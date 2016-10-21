using UnityEngine;
using System.Collections;

public class CubeMapRender : MonoBehaviour {
	public GameObject renderPosition; 
	public Cubemap DesCubMap;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnGUI()
	{
		bool isClick = GUI.Button (new Rect(0,0, 100, 50), "渲染");
		if (isClick) 
		{
			//render
			RenderCubeMap();
		}
	}

	void RenderCubeMap()
	{
		if (renderPosition == null || DesCubMap == null)
			return;
		GameObject go = new GameObject ("CameraGameObject");
		go.AddComponent<Camera> ();
		go.transform.position = renderPosition.transform.position;
		go.GetComponent<Camera> ().RenderToCubemap (DesCubMap);
		DestroyImmediate (go);
	}
}
