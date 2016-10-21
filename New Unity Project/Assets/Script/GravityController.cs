using UnityEngine;
using System.Collections;

public class GravityController : MonoBehaviour {
	GameObject Ball;
	Camera camera;
	public int speedGravity = 10;
	Vector3 PositionAdd = Vector3.zero;
	Vector3 Speed;
	// Use this for initialization
	void Start () 
	{
		Ball = GameObject.Find ("Sphere");
		camera = GameObject.Find ("Camera").GetComponent<Camera>();
		if (Ball == null || camera == null)
		{
			Debug.Log ("Init fault");
		}
		PositionAdd = camera.transform.position - Ball.transform.position;
		Speed = Vector3.zero;
	}
	
	// Update is called once per frame
	void Update () 
	{
		Vector3 accelate = Vector3.zero;
		accelate.x = Input.acceleration.x;
		accelate.z = Input.acceleration.y;
		//if (accelate.sqrMagnitude > 1)
		//	accelate.Normalize ();

		//根据每帧加速度计算速度
		Speed += (accelate * speedGravity * Time.deltaTime);

		//移动物体
		Ball.transform.Translate (Speed * 0.016f,Space.World);

		if (Time.frameCount % 60 == 0) {
			Debug.Log (Speed);
		}
		//相机跟随
		camera.gameObject.transform.position = Ball.transform.position + PositionAdd;
		Input.gyro.enabled = true;
	}

	void OnGUI()
	{
		GUIStyle style = new GUIStyle ();
	    style.normal.textColor = Color.red;
		style.fontSize = 25;
		GUI.Label (new Rect(0,0,480,30),"position is " + Input.acceleration + "Speed : " + Speed ,style);
		GUI.Label (new Rect(0,35,480,30),"重力：" + Input.gyro.gravity + " attitude: " + Input.gyro.attitude,style);
		GUI.Label (new Rect(0,70,480,30),"旋转速率：" + Input.gyro.rotationRate + " 精确值: " + Input.gyro.rotationRateUnbiased,style);
	}
}
