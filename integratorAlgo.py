import numpy as np


def thermo_data(x, v, k=1.0, mass=1.0, step=0, dt=0.05):
    Ep = 0.5 * k * x**2
    Ek = 0.5 * mass * v**2
    Et = Ep + Ek

    return [step, step * dt, x, v, Ep, Ek, Et]


class HarmonicOscillator:
    def __init__(self, k, m):
        self.k = k
        self.m = m

    def period(self):
        return 2.0 * np.pi * np.sqrt(self.m / self.k)

    def acceleration(self, x):
        return -self.k * x / self.m

    def analytical_solution(self, x0, v0, t):
        """
        Calculate the analytical solution for the 1D harmonic oscillator.

        Parameters:
        x0 : float
            Initial position.
        v0 : float
            Initial velocity.
        t : float
            Time at which to calculate the position and velocity.

        Returns:
        x : float
            Position at time t.
        v : float
            Velocity at time t.
        """
        w = np.sqrt(self.k / self.m)  # angular frequency
        x = x0 * np.cos(w * t) + v0 / w * np.sin(w * t)
        v = -x0 * w * np.sin(w * t) + v0 * np.cos(w * t)
        return x, v


class VerletIntegrator:
    def __init__(self, dt):
        self.dt = dt
        self.previous_x = None
        self.next_x = None

    def step(self, system, x, v0=None):
        """
        Perform verlet integration on a system, stores x as previous_x and returns the new_x

        Args:
          system (class): simulation system class, should provide acceleration() method
          x (float): current position
          v0 (float): initial velocity

        Returns:
          float: the position at the next time step

        """
        if self.previous_x is None:
            # On the first step, we can't do a full Verlet update because we
            # don't have a previous_x. Instead, we estimate previous_x using a
            # first-order Taylor expansion, taking into account initial velocity
            self.previous_x = (
                x - v0 * self.dt + 0.5 * system.acceleration(x) * self.dt**2
            )

        # Calculate new position using Verlet algorithm
        a = system.acceleration(x)
        new_x = 2 * x - self.previous_x + a * self.dt**2

        # Calculate the velocity for the current position
        if self.previous_x is not None:
            current_v = (new_x - self.previous_x) / (2 * self.dt)
        else:
            current_v = v0

        # Update previous_x for the next step
        self.previous_x = x

        return new_x, current_v


class VelocityVerletIntegrator:
    """
    A numerical integrator using the Velocity Verlet method.
    """

    def __init__(self, dt):
        """
        Initialize the integrator.

        Parameters:
        dt : float
            Time step for the numerical integration.
        """
        self.dt = dt

    def step(self, system, x, v):
        """
        Perform one integration step.

        Parameters:
        system : object
            The physical system to be integrated. It should have a method `acceleration(x)` that computes the acceleration.
        x : float
            Current position.
        v : float
            Current velocity.

        Returns:
        float, float
            Updated position and velocity.
        """
        a = system.acceleration(x)
        x_new = x + self.dt * v + 0.5 * self.dt**2 * a
        a_new = system.acceleration(x_new)
        v_new = v + 0.5 * self.dt * (a + a_new)

        return x_new, v_new


class LeapfrogIntegrator:
    """
    LeapfrogIntegrator is a class for the Leapfrog integration method.

    Attributes:
        dt: The timestep for integration.

    Methods:
        step(system, x, v): Perform one step of Leapfrog integration.
    """

    def __init__(self, dt):
        self.dt = dt

    def step(self, system, x, v):
        """
        Parameters:
        x : float
            current position
        v : float
            velocity at current minus half timestep

        Returns:
        x_next : float
            position at next time step
        v_next : float
            velocity at next half timestep
        """
        a = system.acceleration(x)
        v_next = v + self.dt * a
        # 修改
        # v_next = v + 0.5 * self.dt * a
        x_next = x + self.dt * v_next
        return x_next, v_next
