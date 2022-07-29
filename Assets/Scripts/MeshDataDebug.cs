using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class MeshDataDebug : MonoBehaviour
{
    public MeshFilter _meshFiler;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    [ContextMenu("PrintMeshData")]
    void PrintMeshData()
    {
        Vector3[] vertices = _meshFiler.sharedMesh.vertices;
        foreach (var vertex in vertices)
        {
            Debug.Log($"{vertex}");
        }
    }

    private void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.green;
        foreach (var vertex in _meshFiler.sharedMesh.vertices)
        {
            Gizmos.DrawSphere(vertex, 0.05f);
            var offset = vertex;
            offset.y += 0.1f;
            Handles.Label(offset, $"{vertex}");
        }
    }
}
