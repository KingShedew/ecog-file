i got scammed by stupid dumb plants vs zombies

import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
            position={[0, 0.5, 0]}
            color="#ff6600"
            intensity={2}
            distance={8}
            castShadow
          />
          <mesh position={[0, 0.4, 0]}>
            <sphereGeometry args={[0.15, 8, 8]} />
            <meshBasicMaterial color="#ff4400" />
          </mesh>
        </group>
      ))}

      <ambientLight intensity={0.1} color="#4455aa" />
      <directionalLight
        position={[5, 10, 5]}
        intensity={0.3}
        color="#6688cc"
        castShadow
        shadow-mapSize={[1024, 1024]}
      />
    </group>
  );
}import { useMemo } from "react";
import * as THREE from "three";
import { useDungeon } from "@/lib/stores/useDungeon";

export function DungeonEnvironment() {
  const { levels, currentLevel } = useDungeon();
  const level = levels[currentLevel];

  const wallPositions = useMemo(() => [
    { position: [0, 3, -10] as [number, number, number], rotation: [0, 0, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [-10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
    { position: [10, 3, 0] as [number, number, number], rotation: [0, Math.PI / 2, 0] as [number, number, number], size: [20, 6, 0.5] as [number, number, number] },
  ], []);

  const torchPositions = useMemo(() => [
    [-8, 3, -9.5] as [number, number, number],
    [8, 3, -9.5] as [number, number, number],
    [-9.5, 3, -5] as [number, number, number],
    [9.5, 3, -5] as [number, number, number],
    [-9.5, 3, 5] as [number, number, number],
    [9.5, 3, 5] as [number, number, number],
  ], []);

  const pillarPositions = useMemo(() => [
    [-6, 2, -6] as [number, number, number],
    [6, 2, -6] as [number, number, number],
    [-6, 2, 2] as [number, number, number],
    [6, 2, 2] as [number, number, number],
  ], []);

  return (
    <group>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, 0, 0]} receiveShadow>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color={level.floorColor} roughness={0.8} />
      </mesh>

      <mesh rotation={[Math.PI / 2, 0, 0]} position={[0, 6, 0]}>
        <planeGeometry args={[20, 20]} />
        <meshStandardMaterial color="#0a0a0a" roughness={1} />
      </mesh>

      {wallPositions.map((wall, index) => (
        <mesh
          key={index}
          position={wall.position}
          rotation={wall.rotation}
          receiveShadow
          castShadow
        >
          <boxGeometry args={wall.size} />
          <meshStandardMaterial color="#2a2a3a" roughness={0.9} />
        </mesh>
      ))}

      {pillarPositions.map((pos, index) => (
        <mesh key={`pillar-${index}`} position={pos} castShadow receiveShadow>
          <cylinderGeometry args={[0.5, 0.6, 4, 8]} />
          <meshStandardMaterial color="#3a3a4a" roughness={0.7} />
        </mesh>
      ))}

      {torchPositions.map((pos, index) => (
        <group key={`torch-${index}`} position={pos}>
          <mesh>
            <cylinderGeometry args={[0.1, 0.15, 0.5, 8]} />
            <meshStandardMaterial color="#4a3520" />
          </mesh>
          <pointLight
