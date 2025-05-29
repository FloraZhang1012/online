import { ElMessage } from 'element-plus'
import request from './request' // Ensure request is correctly imported

// Upload function
export async function uploadFile(option, onUploadProgress) {
  const type = option.file.type // File type
  let formData = new FormData()
  formData.append("file", option.file)
  let url

  console.log(type)

  if (type === 'image/png' || type === 'image/jpeg') {
    url = "/api-mall/admin/api/v1/products/uploadfile"
  } else {
    ElMessage.warning("Unsupported file format")
    option.onError()
    return
  }

  try {
    const res = await request.post(url, formData, {
      headers: { "Content-Type": "multipart/form-data" },
      onUploadProgress
    })

    if (res.data.code === 200) {
      option.onSuccess(res.data.data)
      return res.data.data
    } else {
      ElMessage.error(res.data.message || "Upload failed")
      option.onError()
      return
    }
  } catch (error) {
    ElMessage.error(error.response?.data?.message || "Upload error")
    option.onError()
  }
}
