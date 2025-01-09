Return-Path: <linux-pm+bounces-20150-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35141A07713
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 14:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99651168D61
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 13:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28867216619;
	Thu,  9 Jan 2025 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BcWLRure"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2FC1853
	for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2025 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736428720; cv=none; b=UHEjTvqjFqCyKSCe7l1uuA7TrYd3LGZmpOZHF05WXpYP+VziCDzPS6w8Mo8E+DHWQoO7apmIZDo0BmqHLyr3HrnJVQvgdGp9o27GYNIKoiRopEuzCS3VKygXTDhVIqEUyXTOozwuKZB7X87lTqBGJvR7z2Q8ARkKjFO7j+4UnTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736428720; c=relaxed/simple;
	bh=TaIOHD5qOC9eQbkC2KwUCC+oNlvRDSN8i27bzPIAphg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PhznXc4UBl6/by/WMhwYeHmce74CBNtQJjUbXfKDM9xfe3aXygJYX8J0RpIEVzpY7zKyXws2YfRdN2zX4S3YvRxRFVWSzhNBRO9mJfrAxVgNvmhykslWphc5DPJm1p3TJeLZ5EQZnefZofAN/7ZdlCa9ghjZmz3nX1lAIOxVnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BcWLRure; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5096hkxg022415
	for <linux-pm@vger.kernel.org>; Thu, 9 Jan 2025 13:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pAinXbrU54YDWSX+TXddpuW5K6ve1Twi3iiA/2chiCM=; b=BcWLRurexoqUrzil
	CGrFm5ROVN8ieMEH5KtvzD14VWbPC9F/MFgpZA3SFpXoyEQjsa5DOK8dLHFXfZFH
	ESpck5PSTXWnCKGtcgbNRfmqYsYugqscLL9ZH58LZPJMMPU88MQsIMWjNmSTyQdA
	9+xAbz1fASA71qbd46FSVUQYPFgcYO0yztOUj/8O8aUVFL1rJYuc4uqgIcLRF1a4
	BDXTQbcDOi347zK6J5gVivAjkHRfQe2Dd6MUZgesPBFgTh9avZtmCdH/HC+RfuH7
	xzkJBOFWRVLyZDBMzji5CqyQx9PcfgN32LFVhxn09r3MaIVU1IzgqHMDVRCJjECx
	mXGClg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4429epgx52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2025 13:18:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-469059f07e2so585861cf.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2025 05:18:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736428716; x=1737033516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAinXbrU54YDWSX+TXddpuW5K6ve1Twi3iiA/2chiCM=;
        b=g8KDVSeLDd6JIOLS78obJAtGlhNtqit0CLdV+k4F9rRHrFYea15n8nOo0gQhp1QqrN
         6RUlz4y5/Phd02GaUNgvnGxr4UsquXrURqlLwhXc4d+gN1SUxnzgCY6Nd5VYeKVbeL61
         pOQvVHNh70LxA9Bc6WMaR9yBquw33qHXzLEiyALDf7fPWOTBREUAHJz4ctQvuJeV32m8
         pWqNP587WnDWw/ue58cWGFb+6j+0kHcHqviQJRSOvOSZC/KffNLKhRhCw5cnsqtwSGls
         M2q72YBNSJRfik3PGvi4jhTV1t1F103cj7GwWbvGf2SRmouVHSFH4HqUg8jPGE4Vbt8S
         F3GA==
X-Forwarded-Encrypted: i=1; AJvYcCVMSU5fnLi4g6MvB9lY0NUfsImeYwjUAR6+gQp7yXKqPCu4Ec7w1yfCYwtdQ4UQlevtVXyrWhdQiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGr4kSz8rddojPvmpG+rQ0rSNks6epu/aaczF0B5OaBpiNDC4A
	tUMnDrPhsoFH4WvJnNUdsIEY6w3pCujv39k45/J2k/GMLVdF+HxhEbszu1WSZsyuMVaITdVebud
	hEL6s2MeX0T6MN1NGp+2PrHIisGb45IOmCICZpY24JCR7TYyCzgLYj8c76Q==
X-Gm-Gg: ASbGncu7cUgJTzv14PMMvE1WzwCag4L/K+jrxCvgTevxtzqx8BDv385puEUx7Hs4au2
	+awmgqCvCFNZnfJPA+ewPK1/TufzksyjPZjZ3DvvKe2frIRoHP4Hf33Q4j1Lzb2T36dWfdrgv1p
	J62ON3jSnaz6fxfx2SLVPiJxjJ7wQztgor6FqQDVFDB5wporGz6Q2ajE6OD9+Lk7WhuEsBB7a1C
	Z6xn1UZEUGPzeA5P3NVNK1DpEWm439MU16rzRhUQsYDCKPNS5F7p8HqiRXJClQMR00O6+VxduFe
	NrPwCVcK4M73HvwO90nPGex25J9CyjNJLW0=
X-Received: by 2002:a05:622a:1210:b0:467:5eaf:7d22 with SMTP id d75a77b69052e-46c7107d773mr39277891cf.10.1736428716436;
        Thu, 09 Jan 2025 05:18:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6kvir4x6bXBZGJQpNMnh+xnivzaxOEAhM6X+eUDPYvw1UTSVFnpcbtAmlt9R06v1GvxWRsQ==
X-Received: by 2002:a05:622a:1210:b0:467:5eaf:7d22 with SMTP id d75a77b69052e-46c7107d773mr39277661cf.10.1736428716024;
        Thu, 09 Jan 2025 05:18:36 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99046ddabsm573823a12.68.2025.01.09.05.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 05:18:35 -0800 (PST)
Message-ID: <e934d116-f8ab-4efd-947c-e5c34b102409@oss.qualcomm.com>
Date: Thu, 9 Jan 2025 14:18:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] drm/msm/adreno: Add module param to disable ACD
To: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark
 <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250109-gpu-acd-v4-0-08a5efaf4a23@quicinc.com>
 <20250109-gpu-acd-v4-4-08a5efaf4a23@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250109-gpu-acd-v4-4-08a5efaf4a23@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZW5IWNsr8TbUsOX3EEZlrZvuZM7ujCFh
X-Proofpoint-ORIG-GUID: ZW5IWNsr8TbUsOX3EEZlrZvuZM7ujCFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090106

On 8.01.2025 9:40 PM, Akhil P Oommen wrote:
> Add a module param to disable ACD which will help to quickly rule it
> out for any GPU issues.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 7 +++++++
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 4 ++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 1f213a0fc61b..ce08eed572c8 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -1475,6 +1475,13 @@ static int a6xx_gmu_acd_probe(struct a6xx_gmu *gmu)
>  	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
>  	struct msm_gpu *gpu = &adreno_gpu->base;
>  	int ret, i, cmd_idx = 0;
> +	extern bool disable_acd;
> +
> +	/* Skip ACD probe if requested via module param */
> +	if (disable_acd) {
> +		DRM_DEV_ERROR(gmu->dev, "Skipping GPU ACD probe\n");
> +		return 0;
> +	}
>  
>  	cmd->version = 1;
>  	cmd->stride = 1;
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 236b25c094cd..f4552b8c6767 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -24,6 +24,10 @@ int enable_preemption = -1;
>  MODULE_PARM_DESC(enable_preemption, "Enable preemption (A7xx only) (1=on , 0=disable, -1=auto (default))");
>  module_param(enable_preemption, int, 0600);
>  
> +bool disable_acd;
> +MODULE_PARM_DESC(disable_acd, "Forcefully disable GPU ACD");
> +module_param_unsafe(disable_acd, bool, 0600);

IIUC 0600 makes it sysfs-writeable, which we don't want, as it takes
effect during probe (meaning booting with =0 and writing 1 later on
has no effect)

Konrad

