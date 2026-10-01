# Adaptive Pure Pursuit Curve Tracking Robot using MATLAB

## Overview

This project implements a simulated mobile robot that follows a predefined reference path using the **Pure Pursuit path-tracking algorithm**.

The basic Pure Pursuit approach was extended with:

- Multiple reference path options
- Adaptive robot speed based on path curvature
- MATLAB App Designer GUI
- Real-time robot and target-point visualization
- Robot trajectory visualization
- Speed versus time analysis

The project is developed as a MATLAB-based simulation and does not require a physical robot.

---

## Objectives

The main objectives of this project are:

1. To implement the Pure Pursuit algorithm for curve tracking.
2. To allow the robot to follow different types of reference paths.
3. To adjust the robot's speed according to the curvature of the path.
4. To develop a simple GUI for selecting paths and observing the simulation.
5. To visualize the robot trajectory and its selected target point.
6. To analyse the variation of robot speed with simulation time.

---

## Features

### 1. Multiple Reference Paths

The simulation supports four different reference paths:

- Straight path
- Circular path
- Sinusoidal path
- S-shaped path

The user can select the required path from the GUI.

---

### 2. Pure Pursuit Controller

The Pure Pursuit controller determines a target point ahead of the robot on the reference path.

The controller:

1. Finds the nearest point on the reference path.
2. Selects a look-ahead point from that location.
3. Calculates the desired heading toward the target point.
4. Calculates the heading error.
5. Updates the robot's heading using a proportional control gain.

For a circular path, the reference path is treated as a closed path so that the robot can continue following the circle.

---

### 3. Adaptive Speed Control

Instead of keeping the robot speed constant, the project adjusts the speed according to the local curvature of the reference path.

The curvature is estimated using three nearby points on the path.

The general relationship used is:

```text
Higher curvature  →  Lower speed
Lower curvature   →  Higher speed

```

--- 

Thank you for reading!
