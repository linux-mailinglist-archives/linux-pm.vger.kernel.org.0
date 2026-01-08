Return-Path: <linux-pm+bounces-40423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D25BD0157D
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 08:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABD45301D61B
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 07:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352CC328628;
	Thu,  8 Jan 2026 07:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BmGgNpOU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hfSQwCYD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84324239E80
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767856066; cv=none; b=dynEyAElZwYtLcT1KeEyE99ptzeFkIg1gCPPoc7E7IY3Bva1L6SYetNEDRYBdYXMzbn6RkZEcgrbfIHEUuN2T7gd0bYjSwJlS/x+VeDaYAmxs+oI2chjcX5CqfBzwcNNI2oBcpVDQGc5kha+DxW6mMbrEwOWzlIKD2Dc8KmcMw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767856066; c=relaxed/simple;
	bh=EW9ZJEx/Y4DrtxgKA1ui14J9T68gvpdN1tRau3pG9UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QbohYcaZmBM1n8BWEsD3NrtIqa6hasJ7NIXQgHiOfukHCFkcik7O0E6F3U549N38cUkbo4vsjeslcoOMBx2BOmvwbZVkkXf2JwDeSaPn12Y+x+OI6NZfbuOcOmzeICdSYAmihD0NFpKMDOUkujl4UheVvf0cp1vD/pPKp4t4Qmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BmGgNpOU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hfSQwCYD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607LrZTA2239468
	for <linux-pm@vger.kernel.org>; Thu, 8 Jan 2026 07:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H291/GDYLdo15JZXgl9p7LmvmkDeNjcIbx8C1kz8ufo=; b=BmGgNpOUAyxTBare
	jOKALGcWGeOGt4H4LTXZgD1dRwnRCRdgko3d119xm0awMVpEbJvUqJ2ArFcVwhdf
	k8Q09bFU+uT4Jb4QHTb+QNQeDYeYLbA7QM56p9C9B26eKNsV9LQDVvMVDwzXtzlp
	6NGUtyDqS64grERh+tuXndzbpJrPiq4in/t0X93bbIb+t16sh4B76XztffFkcK/B
	LBvUlUzehjRJ9Y67RboJ0y6MaXOwBKGghG05TeWvthi8msYT3bgCc1kOsrUVj/rh
	UQj0sYLA0nFK15piu3vOy5M4ObqKH4fhFdYra2u89KaostRbtBd7XqaBNJPwAh43
	YeXfwQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhqwg30eb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 07:07:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f25e494c2so20189535ad.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 23:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767856062; x=1768460862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H291/GDYLdo15JZXgl9p7LmvmkDeNjcIbx8C1kz8ufo=;
        b=hfSQwCYDJMVEu/ohG92ZwZ+tabH11MuLGBv4vx8qASME6LaSaIAhqLa/ESJ2m9Ln0G
         tBAAhgzvkMeFHl9eeM8vkTG2KOqQmno+9JXo0pvtvJNQW6BaX6ooY7xoz0WkixcRssbX
         X3NCUiQouVRFDBOaNt9PBjmF+TAppTwkE2a9hs77x8tHSnQbzaaooDDywGFfgvJy9CL3
         3uKVmZX5n5m7aIoIIXGSmCxQbGLe7vsodmZJHZVDM2PM5eqaGcYSU9ChjcFnGKHHBw5l
         lnfeilUaOXylqMvAEPhJk3Wviiw9BbQ2tfckgiIBlZPHcEglKueTSFh3qQxMPxr+hBGt
         z+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767856062; x=1768460862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H291/GDYLdo15JZXgl9p7LmvmkDeNjcIbx8C1kz8ufo=;
        b=Qc5S40iWCshlpGEdF3oORpnVwRGxGtG1jAVMjCZflqrmqgAnzwQ3EVIFNLIjIV8Pq7
         lKc+ZM8ZBGYSn/kJ3iyeGz9viLA+M76TTEIN1M9M3aqR4xTvcKZARSDLsev6bo65dyho
         SpU6HDMN0dJ/pYoAUkzsowQoP0GiU7cKudvvCgZFno7MHNUCnQ4Oi0wW8xIkUD2ZCZEF
         3XAL+i/9lX70VkB/pwj2El5hB1MJ/Vmz5aubz2WU1v1ihfcIwyqLtRwH4G+oKE+bjrJE
         Uev6xRDBCdGnTtoFDsROBBst3OH8A0eW4xGWCG0Vh97OAL5Ih9OOPJTjUrZRyaJqklQa
         wl5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXP59grT7aDCPF4q0nsdKrr3FIjWzeC+5aHMdsWeFYmQSFZHB05lCTQ/jiLOundgwFVvWETpfIZ5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWASnbPThkcdi2CA9yut5b2A1hIojyctme11X7O9nBNxJ9z58N
	6e5yRET4xo5Jjvb16yhh5y7yul2DOu9My5/KLqRMejvce9f2zFsAfPnK6d692odzdV8joWRmi/0
	E4xr/n/VHamKeXBJ/eNuu02YCZH9pHXjlH0mCDLndLo+qaYQAqbrIentRkvgv7Q==
X-Gm-Gg: AY/fxX7W92VzKvh0jHkuQalbzQVEisTWZaOkEcGxJOserWxfPYMkYHhicvZQGWL2Db5
	ULNWzrOT/JCpLMPAES8olnnzA5cxM8WMqOgGECK3305wBE9eKFbwEelFHE2WiSkrPFGSUXx7vca
	K2z4wfLxmIjhowLNdhOHBo5gcG9I2e7WKhuSj51EUKtuP1jOTDNUdhtHlQe8avOu+0x/52wuCCU
	rsRYtpVd8j1GWPcRAN8spJpxpbHn0LCZ+fyytt2Rvx4F3WouBYAl3p5g/MyHB6hkn/WwUibCEIO
	slgWFh7DL+dbt/XgF4LI16Im37smLrktKT+SfY++DPLG7pLk6MpHVTcL4ElMKH+LAb8QwZDYWug
	/iCSuVYP0lPcAEvoqvRKjTor/B6Z8ddOK+jb8nUI=
X-Received: by 2002:a17:903:90d:b0:2a0:acdb:ce0c with SMTP id d9443c01a7336-2a3edbaeef5mr57580295ad.29.1767856062233;
        Wed, 07 Jan 2026 23:07:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQGy72i55Bln+OLLaW6HT8jBVTsf/2UpcbyKR6ZxubyT8/7OrZRDENs7bDh4FSn4TvSrc3ZQ==
X-Received: by 2002:a17:903:90d:b0:2a0:acdb:ce0c with SMTP id d9443c01a7336-2a3edbaeef5mr57579775ad.29.1767856061288;
        Wed, 07 Jan 2026 23:07:41 -0800 (PST)
Received: from [10.218.27.120] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a560sm68034105ad.21.2026.01.07.23.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 23:07:40 -0800 (PST)
Message-ID: <cb5430c8-12d6-4439-b1ae-c2f36f29a9f8@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 12:37:35 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/8] remoteproc: qcom: probe all child devices
To: Bjorn Andersson <andersson@kernel.org>
Cc: mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, konradybcio@kernel.org,
        amitk@kernel.org, mani@kernel.org, casey.connolly@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-3-gaurav.kohli@oss.qualcomm.com>
 <evb5tn2cht7wk76fuc2wpsyxepknigfw37633n6ypuapstbceh@tn5glmi65bdv>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <evb5tn2cht7wk76fuc2wpsyxepknigfw37633n6ypuapstbceh@tn5glmi65bdv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HGdxR5G3fCyV9IoNKNZBtj5eYyEhOq9q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA0NiBTYWx0ZWRfX8lpdU9yAMl8O
 pb8djHwcH27cn/7c505GE0pvvHci5adQWqCwXjQdiJY+U8xxRZwi7d/Q5ModDmByLbnpxhTSqgE
 F/3NdMRlvqgCVV8gCggk/yUXIL/1llrIP/Kjb9Zyedo6wzlEj21MjK4iNxSGj/S+szElSZStO5I
 XYd9nSYFAYWepFFJDEnABuzWlsNnv44hkM+KNO2Tai9GGpdztoyFXbyNMtNABhwzLNKvCpCb2NI
 7v9dZnbiTkVYjobvaHnUIrR/9rxnlypC9N+znY05AKU7YSWDxiEJkFXHXmdUT0mYjc8g6+iiLtZ
 wkpmfOdfIHalBmyGVefmAevRqCmM7m5+hnBbO6Z5XR7KqnlijwsQE52ooAbLt3qnPI90Znh+ioj
 rfsctd91uh0d745eSLzqloIA11qqOIBokjl3XS7meBEjSLAYUhJ5Mc8LQPmkXzijTceCY9s/2z7
 PnsxyZke53KkARJALrw==
X-Authority-Analysis: v=2.4 cv=Pa7yRyhd c=1 sm=1 tr=0 ts=695f57bf cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=87LZ4QhyrNmesvD_9F8A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: HGdxR5G3fCyV9IoNKNZBtj5eYyEhOq9q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080046


On 1/3/2026 8:26 PM, Bjorn Andersson wrote:
> On Tue, Dec 23, 2025 at 06:02:21PM +0530, Gaurav Kohli wrote:
>> From: Casey Connolly <casey.connolly@linaro.org>
>>
>> Generalise the qcom,bam-dmux child node support by probing all
>> remoteproc children with of_platform_populate(). This will be used to
>> enable support for devices which are best represented as subnodes of the
>> remoteproc, such as those representing QMI clients.
> Please flip this around, start with the description of the problem
> you're trying to solve.
>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> This must have your signed-off-by, where you certifies the origin of
> this patch.
>
>> ---
>>   drivers/remoteproc/qcom_q6v5.c     | 4 ++++
>>   drivers/remoteproc/qcom_q6v5_mss.c | 8 --------
>>   2 files changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
>> index 58d5b85e58cd..a02839c7ed8c 100644
>> --- a/drivers/remoteproc/qcom_q6v5.c
>> +++ b/drivers/remoteproc/qcom_q6v5.c
>> @@ -6,6 +6,7 @@
>>    * Copyright (C) 2014 Sony Mobile Communications AB
>>    * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
>>    */
>> +#include <linux/of_platform.h>
>>   #include <linux/kernel.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/interconnect.h>
>> @@ -351,6 +352,8 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
>>   		return dev_err_probe(&pdev->dev, PTR_ERR(q6v5->path),
>>   				     "failed to acquire interconnect path\n");
>>   
>> +	of_platform_populate(q6v5->dev->of_node, NULL, NULL, q6v5->dev);
> There are other child nodes here, in particular the GLINK and SMD edges.
> Do we really want platform_devices registered for them?
>
> Regards,
> Bjorn


thanks for pointing this, can you please suggest the right approach.

This should not impact glink, as that is registering as rproc sub node, 
And we need rproc cooling as child node

of remote proc subsytem to create probe dependency only.


Can we do platform populate for specific child, would that be right 
approach. or we should create rproc cooling as independent of parent ?


>> +
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_q6v5_init);
>> @@ -361,6 +364,7 @@ EXPORT_SYMBOL_GPL(qcom_q6v5_init);
>>    */
>>   void qcom_q6v5_deinit(struct qcom_q6v5 *q6v5)
>>   {
>> +	of_platform_depopulate(q6v5->dev);
>>   	qmp_put(q6v5->qmp);
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_q6v5_deinit);
>> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
>> index 91940977ca89..d40565c1cc62 100644
>> --- a/drivers/remoteproc/qcom_q6v5_mss.c
>> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
>> @@ -238,7 +238,6 @@ struct q6v5 {
>>   	struct qcom_rproc_pdm pdm_subdev;
>>   	struct qcom_rproc_ssr ssr_subdev;
>>   	struct qcom_sysmon *sysmon;
>> -	struct platform_device *bam_dmux;
>>   	bool need_mem_protection;
>>   	bool has_alt_reset;
>>   	bool has_mba_logs;
>> @@ -2029,7 +2028,6 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
>>   static int q6v5_probe(struct platform_device *pdev)
>>   {
>>   	const struct rproc_hexagon_res *desc;
>> -	struct device_node *node;
>>   	struct q6v5 *qproc;
>>   	struct rproc *rproc;
>>   	const char *mba_image;
>> @@ -2163,10 +2161,6 @@ static int q6v5_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		goto remove_sysmon_subdev;
>>   
>> -	node = of_get_compatible_child(pdev->dev.of_node, "qcom,bam-dmux");
>> -	qproc->bam_dmux = of_platform_device_create(node, NULL, &pdev->dev);
>> -	of_node_put(node);
>> -
>>   	return 0;
>>   
>>   remove_sysmon_subdev:
>> @@ -2186,8 +2180,6 @@ static void q6v5_remove(struct platform_device *pdev)
>>   	struct q6v5 *qproc = platform_get_drvdata(pdev);
>>   	struct rproc *rproc = qproc->rproc;
>>   
>> -	if (qproc->bam_dmux)
>> -		of_platform_device_destroy(&qproc->bam_dmux->dev, NULL);
>>   	rproc_del(rproc);
>>   
>>   	qcom_q6v5_deinit(&qproc->q6v5);
>> -- 
>> 2.34.1
>>

