Return-Path: <linux-pm+bounces-29429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E9BAE668A
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 15:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02021927743
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 13:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0093A2C3278;
	Tue, 24 Jun 2025 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="StSsBfzn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3146F2C3254
	for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750771716; cv=none; b=axzyv0OLiSI7Y/2ppyssQWhto77+5AufH2v6CjFAz/HLaPpCDSbwScPwXYadOh1y4jkmlQmKfB/hJeWoxmTjykXCqC/2BoZh51n7daEcpsQNu87qyReoYFYGZvyG3Qn4/qP41BcQrj0ocS0Q4eaG9NlicPC9XcU5y34jY3ppyMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750771716; c=relaxed/simple;
	bh=EGi6Js4t1+Z8KlSKkFFm0EkPtH4FtV0CZisHn9B3Rsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yh8wsUPP8nSZGrBGNo6w6B0nm/xPUcgK4hhFt7kZz34El6L8F9UKHtfmgXEMEzSxldkJSNPmf8ktKSbko9ucV5EsOvZKcEC5OtC2IfYKzlKEWMcYur7LicOZVYvNNgimI4kA2YdHG0xDQWIcGE4u391Fl3XjFY0hhpA8mYHfwmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=StSsBfzn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O7mCSS014481
	for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 13:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RvZazCwxIEFv8meBdBiCL7u1qoqBdDyV6DUE2XCe3rg=; b=StSsBfznSX7FPokl
	prC7bOr1dq6rSqbwon7V5OaBroPwPDswksoarR7lQC84ugZt7s2maAvfsEUcswg4
	GZXUJIWXgdlycoR8tty8IFaqn6xQam4uMKc6vPVZ2/B1LAioHGYXEzsnzEc9cwln
	0WGr+O33wxOJADti/jyMr3Pc7hwBd7KegW1yITwItX4CraIqkM22yf3dEvJtRS4K
	U/iOOudFEksMDJlA80ViAKP4zIM4yi3caO9GD818seqMlLfn1ydYGOT1+Gxt10yY
	KyL6E1UN59NoXzYuvPSA2M4XuvhEkg1EL9vPAJSnVO6PE+NTH5G1sCEQiKK/G1L/
	vsYZCQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47evc5ncdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 13:28:34 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b3216490a11so2715410a12.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 06:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750771713; x=1751376513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RvZazCwxIEFv8meBdBiCL7u1qoqBdDyV6DUE2XCe3rg=;
        b=S4JjPpf7ADC9jmat9OletzDKZJ0V0IC9Kkd/UWWrUm9cnQtUpYoMY8tPNpyTVpi9t4
         rOc3i0zIRKvoR9+h591KMU85E5tg4uVI0EaEnwLCUEVc99UupBgVxkwWVRqnVN+UHrDV
         PHnNcsO9LIXSRblhtopinq2kS5Rd0C00YxVYI3+35sI6gEC95/aHaRNgaCUuwEJJWpo5
         PhrhhbnKqp+/EAWUBdaAX8SE3aqZMsw/C/sIDpsT9l51CPSQr7yQhwi2yJ1QriGYH3BK
         l+HZdEa6XC3nSJ96EZ/OzehEElb+q5fwIZW+jepbRLg6l9N3yZKUd06LxDMoE3GCv4tj
         h2hA==
X-Forwarded-Encrypted: i=1; AJvYcCWIdM0gpVfLdNnWOHpwCJ4WoJvBkYfCpgHPPxwV/J7sHmocvAun45d/aCiAYeZQe3rcoHdS8lh+fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKrACyUIuNMYqeukDBrr3OaloWZ+VJZJOs+wAD8LsrO39gEmZU
	zV7TgqvQj0u/+K21NAv68IiW/Zav9/JmhfcxmnjA4vwo5QEJdrbue0AGQeLPirIsDO5gpU2Orfl
	KUZlWlY7NXy4/xJxIp0Ew06eXQs+v32hBhauM/ceIG6BdFR2lcDuzxWbbar+s7Q==
X-Gm-Gg: ASbGncv996J3cPvqWR9Ad3fRoe3UqCDfaqY42iN7lyfL5WISG1+Yfp9qKeO0i7SmnCO
	fdpWeNfucF9Zi7VmjS3YlgefXcKbK1Mk8YbRnpo2TVp8dxgR47mjPWUAfT2et8bVGcZhorMKJZD
	CbLsL5L/n1h4BT98buZhGt6zeTSjafvd6Hk+lqqRWQAYSBmSMmLoSeqZ6hqg+qJfu9QEAS1rJl4
	sQKutd+NxZ0rkc8yMuDk+2noi1W+oPuBMcTDTFwb0YUvVBD/GIvuLVrlvaCN3ok+sWa0gSk+iYN
	t/9XJzJhnV6kAQYcmafYDlVLRBgPkj6H4GpK1CF5SIMKJgGCCG4=
X-Received: by 2002:a05:6a20:7284:b0:1f5:72eb:8b62 with SMTP id adf61e73a8af0-22026f162a1mr24223800637.20.1750771712991;
        Tue, 24 Jun 2025 06:28:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD/iFGK3TEg3DGL2eOm7/r1fQKuDSUgr5lVbG0Ag5wbPKzaX5UAN6m14tHIodZOPm9VJGb6w==
X-Received: by 2002:a05:6a20:7284:b0:1f5:72eb:8b62 with SMTP id adf61e73a8af0-22026f162a1mr24223727637.20.1750771712450;
        Tue, 24 Jun 2025 06:28:32 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c882f5b8sm1961515b3a.95.2025.06.24.06.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 06:28:32 -0700 (PDT)
Message-ID: <ff19780e-5bbd-4074-9db3-b4f27922a093@oss.qualcomm.com>
Date: Tue, 24 Jun 2025 18:58:24 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 4/5] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzysztof.kozlowski@linaro.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
        rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        quic_kamalw@quicinc.com, rui.zhang@intel.com, lukasz.luba@arm.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        quic_skakitap@quicinc.com, neil.armstrong@linaro.org,
        stephan.gerhold@linaro.org
References: <20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com>
 <20250509110959.3384306-5-jishnu.prakash@oss.qualcomm.com>
 <20250511140418.33171ca3@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20250511140418.33171ca3@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -j7jHcCmx86bU4GTGwMlGShkTtt2TIzJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDExMyBTYWx0ZWRfXyKE9FWNNA4zs
 1h6V4dQYecvXM1tmMWxlhB7XWrwVGzi5J7Kjvjw7px+lK/pAdNnjmujENrujb+9mxUoBxHzIL1j
 UZiiHLTf9/a4PbTqMIPIFIVLq0jnUVVbwsW/5lkHZprIGkZBwUZe4mzbh1ozjEIGbirGWH1iHsx
 kyxDD0wRHW2CMXXSN8rS5yBnI+ABN0VcNYzaV6zNEurHEUpstN+dXy8DlyrXMqNLk6NX0rHyL0G
 xVGnxZM7tTqM+WP/8UTb2aF50uyR+LMxcVsDVhOZff6aujVlivu6Jq7Z3PdyuG24e+pf0jNvp4q
 S/HhTyzjkFjRHhQqNkLl8Q2dkoYZiE574B0TLHkycmq5zCbB2Ss1gQ+TECbsPUj2VDfVsz4QgfM
 Xnt28PWijAKwBjs15RHfHNmJMx6VxTDHoemT1VrIaN3UlcTksq0hWfScHwRLM2rOpk2L3to3
X-Authority-Analysis: v=2.4 cv=caHSrmDM c=1 sm=1 tr=0 ts=685aa802 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=LEaH-SS2L9D2elKWKUoA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: -j7jHcCmx86bU4GTGwMlGShkTtt2TIzJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240113

Hi Jonathan,

On 5/11/2025 6:34 PM, Jonathan Cameron wrote:
> On Fri,  9 May 2025 16:39:58 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
>> with all SW communication to ADC going through PMK8550 which
>> communicates with other PMICs through PBS.
>>

...

>> +#include <linux/delay.h>
>> +#include <linux/iio/adc/qcom-adc5-gen3-common.h>
>> +
>> +int adc5_gen3_read(struct adc5_device_data *adc, unsigned int sdam_index,
>> +		   u16 offset, u8 *data, int len)
>> +{
>> +	return regmap_bulk_read(adc->regmap,
>> +				adc->base[sdam_index].base_addr + offset,
>> +				data, len);
>> +}
>> +EXPORT_SYMBOL(adc5_gen3_read);
> 
> Consider namespacing these exports.
> 

OK, I'll add them in the existing namespace (QCOM_SPMI_ADC5_GEN3)
if there's no issue.

>> +
>> +int adc5_gen3_write(struct adc5_device_data *adc, unsigned int sdam_index,
>> +		    u16 offset, u8 *data, int len)
>> +{
>> +	return regmap_bulk_write(adc->regmap,
>> +				 adc->base[sdam_index].base_addr + offset,
>> +				 data, len);
>> +}
>> +EXPORT_SYMBOL(adc5_gen3_write);
>> +
>> +/*

...

>> +	if (status & ADC5_GEN3_STATUS1_CONV_FAULT) {
>> +		dev_err_ratelimited(adc->dev,
>> +				    "Unexpected conversion fault, status:%#x, eoc_status:%#x\n",
>> +				    status, eoc_status);
>> +		val = ADC5_GEN3_CONV_ERR_CLR_REQ;
>> +		adc5_gen3_status_clear(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
>> +				       ADC5_GEN3_CONV_ERR_CLR, &val, 1);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	/* CHAN0 is the preconfigured channel for immediate conversion */
>> +	if (eoc_status & ADC5_GEN3_EOC_CHAN_0)
>> +		complete(&adc->complete);
>> +
>> +	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
>> +			     ADC5_GEN3_TM_HIGH_STS, tm_status, sizeof(tm_status));
>> +	if (ret) {
>> +		dev_err(adc->dev, "adc read TM status failed with %d\n", ret);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	if (tm_status[0] || tm_status[1]) {
>> +		adev = adc->tm_aux;
>> +		if (!adev || !adev->dev.driver) {
>> +			dev_err(adc->dev,
>> +				"adc_tm auxiliary device not initialized\n");
>> +			return IRQ_HANDLED;
>> +		}
>> +
>> +		adrv_tm = container_of(adev->dev.driver,
>> +				       struct adc_tm5_auxiliary_drv,
>> +				       adrv.driver);
>> +
>> +		if (adrv_tm && adrv_tm->tm_event_notify)
>> +			adrv_tm->tm_event_notify(adev);
>> +		else
>> +			dev_err(adc->dev,
>> +				"adc_tm auxiliary driver not initialized\n");
> 
> Not return?  Seems odd to print the dbg print only in this error path path.

In that case, I'll move the print upwards, so that it appears just before
the if() check checking tm_status[]. I think it might be useful to have this
print appear in the error paths.

> 
>> +	}
>> +
>> +	dev_dbg(adc->dev,
>> +		"Interrupt status:%#x, EOC status:%#x, high:%#x, low:%#x\n",
>> +		status, eoc_status, tm_status[0], tm_status[1]);
>> +
>> +	return IRQ_HANDLED;
>> +}
> 
>> +static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
>> +					 struct adc5_channel_prop *prop,
>> +					 struct fwnode_handle *fwnode)
>> +{
>> +	const char *name = fwnode_get_name(fwnode);
>> +	const struct adc5_data *data = adc->data;

...

>> +static const struct adc5_data adc5_gen3_data_pmic = {
>> +	.full_scale_code_volt = 0x70e4,
>> +	.adc_chans = adc5_gen3_chans_pmic,
>> +	.info = &adc5_gen3_info,
>> +	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
>> +				{85, 340, 1360},
> 
> Inconsistent spacing. Should be { 85 etc
> 
>> +	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
>> +				{ 15, 100, 200, 300, 400, 500, 600, 700,
>> +				  1000, 2000, 4000, 8000, 16000, 32000,
>> +				  64000, 128000 },
> Andy often points this out, but I'll do it this time. Fixed numbers (typically power of 2)
> elements per line make it much easier to see which element is which in these arrays.
> Reduce the indent a little to allow that here.

Does this look fine?

	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
			  { 15, 100, 200, 300, 
			    400, 500, 600, 700,
			    1000, 2000, 4000, 8000,
			    16000, 32000, 64000, 128000 },


> 
>> +};
>> +
>> +static const struct of_device_id adc5_match_table[] = {
>> +	{
>> +		.compatible = "qcom,spmi-adc5-gen3",
>> +		.data = &adc5_gen3_data_pmic,
>> +	},
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, adc5_match_table);
>> +
>> +static int adc5_get_fw_data(struct adc5_chip *adc)

...


>> +
>> +static void adc5_gen3_uninit_aux(void *data)
>> +{
>> +	auxiliary_device_uninit(data);
>> +}
>> +
>> +static void adc5_gen3_delete_aux(void *data)
>> +{
>> +	auxiliary_device_delete(data);
>> +}
>> +
>> +static void adc5_gen3_aux_device_release(struct device *dev)
>> +{
>> +	struct auxiliary_device *aux = container_of(dev, struct auxiliary_device,
>> +						    dev);
>> +
>> +	kfree(aux);
> 
> It wasn't allocated at that granularity.
> 
>> +}
>> +
>> +static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
>> +{
>> +	struct tm5_aux_dev_wrapper *aux_device;
>> +	int i, ret, i_tm = 0;
>> +
>> +	aux_device = devm_kzalloc(adc->dev, sizeof(*aux_device), GFP_KERNEL);
> 
> There is some lifetime management stuff that is going wrong here.
> Here you allocate a structure that directly contains the
> struct auxiliary_device and use devm managed allocation.
> 
> But you free the contained struct auxiliary_device via the release
> above. Firstly that's freeing at a different granularity which is going to
> go wrong.  Also, that pointer is the same as aux_device here (as first element)
> and so you free this via devm_ cleanup and on the reference count of the
> auxiliary device dropping to zero.
> 
> 
> Take a look at some other drivers that make use of auxdevs for
> how to handle this.
> 
> Key is that the devm handler should be reducing the refcount, not freeing
> the memory as the release will deal with that later.
> 

Thanks for catching it, I'll fix this in the next patch series. I think
keeping adc5_gen3_aux_device_release() empty should be the right thing
to do in this case.

I had tried removing and reloading the main and auxiliary ADC drivers
using modprobe, but somehow I did not see any issue immediately, when
I tried this only once or twice. When I repeated removal and reinsertion
several times, I eventually ran into a segmentation fault. I verified
that when I tried the same steps keeping adc5_gen3_aux_device_release()
empty, this did not happen.

>> +	if (!aux_device)
>> +		return -ENOMEM;
>> +
>> +	aux_device->aux_dev.name = "adc5_tm_gen3";
>> +	aux_device->aux_dev.dev.parent = adc->dev;
>> +	aux_device->aux_dev.dev.release = adc5_gen3_aux_device_release;
>> +
>> +	aux_device->tm_props = devm_kcalloc(adc->dev, adc->n_tm_channels,
>> +					    sizeof(*aux_device->tm_props),
>> +					    GFP_KERNEL);
>> +	if (!aux_device->tm_props)
>> +		return -ENOMEM;
>> +
>> +	aux_device->dev_data = &adc->dev_data;
>> +
>> +	for (i = 0; i < adc->nchannels; i++) {
>> +		if (!adc->chan_props[i].adc_tm)
>> +			continue;
>> +		aux_device->tm_props[i_tm] = adc->chan_props[i].common_props;
>> +		i_tm++;
>> +	}
>> +
>> +	device_set_of_node_from_dev(&aux_device->aux_dev.dev, adc->dev);
>> +
>> +	aux_device->n_tm_channels = adc->n_tm_channels;
>> +
>> +	ret = auxiliary_device_init(&aux_device->aux_dev);
>> +	if (ret) {
>> +		kfree(&aux_device->aux_dev);
> 
> What is this freeing? 

This is also wrong as it frees the auxiliary device struct under the wrapper
instance aux_device, which has its memory allocated with devm_kzalloc.
I'll correct this too in the next patch series.

> 
>> +		return ret;
>> +	}
>> +	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_uninit_aux,
>> +				       &aux_device->aux_dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = auxiliary_device_add(&aux_device->aux_dev);
>> +	if (ret)
>> +		return ret;
>> +	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_delete_aux,
>> +				       &aux_device->aux_dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	adc->tm_aux = &aux_device->aux_dev;
>> +
>> +	return 0;
>> +}
> 
>> +static int adc5_gen3_probe(struct platform_device *pdev)
>> +{
> 
>> +
>> +	platform_set_drvdata(pdev, indio_dev);
>> +	init_completion(&adc->complete);
>> +	mutex_init(&adc->lock);
> If spinning again for other reasons, in new code I have slight preference for
> 	ret = devm_mutex_init(&adc->lock);
> 	if (ret)
> 		return ret;
> 
> It was never worth bothering with release until we had devm managed form but
> now we do the code complexity cost is low enough to make it reasonable.
> 
>> +	indio_dev->name = pdev->name;
> 
> Just to check.  Does that end up as a part number or similar?

I printed this name and it appeared like this:

indio_dev->name: c426000.spmi:pmic@0:adc@9000

It only gets the DT node names, which are generic, there are 
no part numbers in this name.

I'll address all your other comments in the next patch series.

Thanks,
Jishnu

> 
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->info = &adc5_gen3_info;
>> +	indio_dev->channels = adc->iio_chans;
>> +	indio_dev->num_channels = adc->nchannels;
>> +
>> +	return devm_iio_device_register(dev, indio_dev);
>> +}
> 
>> diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
>> new file mode 100644
>> index 000000000000..4f476cd77b37
>> --- /dev/null
>> +++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
>> @@ -0,0 +1,193 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
> 
> 
>> +#define V_CHAN(x)		\
> 
> Might be a good idea to prefix this.  Seems likely we might end up with
> a V_CHAN macro in some generic header in future.
> 
>> +	(FIELD_PREP(ADC5_GEN3_VIRTUAL_SID_MASK, (x).sid) | (x).channel)


