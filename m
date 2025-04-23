Return-Path: <linux-pm+bounces-26030-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C089A989C1
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 14:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC36B178760
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 12:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BA12165E9;
	Wed, 23 Apr 2025 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H9M+wcqI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E67215162
	for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745411146; cv=none; b=SRg4mI+VSF0675rsOuZnU0G2vTD58InI46fNNvwx0g9O9sqm+J+1inrS2MsbW+AFLLyse2vTHmiQA7DXQkV7xWaRUfow9C3uB23hOHVGSumxNruRIElQeBbVrpdsqS+rWlFR43oICWi6RC6GNJoW8oMVuJTK5pyOvR+zdROnp2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745411146; c=relaxed/simple;
	bh=Q2TQQJx49EZoqt+s+UoqOFRUn9Ry2bGHUuUAHKOsrh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbn/+PUHM3DfFuV/txeqE975kxFeNfE8QGGJe2dZhr1chItyIjf6UGPZ+o9iWyGoWcU00m/YQRNblyo/C5hx0n+hJtQlRDF2pUcDW31d7FpYRd3xaXzxabnOw4BjoI8Qb1+YhFWU2hHMzm1zAzfkkRDnocYEVYNsIE4uOba3nVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H9M+wcqI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NApQ6J016264
	for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 12:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t2kUl9QgvO/uB6b51hcAn/oawqIiVbquzPdGvE1gnSU=; b=H9M+wcqITMErLoAk
	nCZGjwKmkqvEHEVExGXss+3rF0Imtxhh59d0youCTSamwjbJnF4KWRQ7zUSdrdE1
	7TFGsNEVGYrvgU7GPSAkBGDhcmdGmW2kf7RFQOwCNIVYuHFB/axONCL/Xpu3mDzY
	x5Sc7cM/yN+ay62Mt11+v8EWNlxGfYR7Iiyl7WR0pbqkoeRaFRop8CyqcQg0fBUO
	5rRqoS83uZvcyLewGFkwOjxhZCC5kowdwcsm+9Y2rdMRdGShrSTIn9AuW3YzTmUA
	SUA75r2+1394TjRCzieHwQ4D8c/GDx0lp7SRa45EexVwMcSepdKPN3d6A+Vaiv/i
	QCr4cg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3j2vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 12:25:43 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8ff8c9dcfso16335986d6.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 05:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745411142; x=1746015942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2kUl9QgvO/uB6b51hcAn/oawqIiVbquzPdGvE1gnSU=;
        b=SZfBBj8aZQH17/fr9bd33gNUm1KhiawKBThmYbPZUZbkDeD/Yi8l/SSiYPjW5Yj7Pk
         ZebtESI9WzdsxaCXNxe2ejer37+vgjbnMT8o2M5X1lu6j3b+awyWUH8OBn0DZW3bGsU1
         uG8A3v5d+vXlWN1X6+umyXrwgz42l/x3B/ZkSO6ZrlnX8WyO7D+2BjvJi4OGEtuCbPn7
         HuQ2jYrX4+a/oypNXPxUlpSaiaZJYyI3GIQhlvL5GoPVefiHFgUeJ/7ncXs7URMU1Opw
         7/hssEC6KUJeFN47lwOJ7ZR74B0oHdpsY0OjoAKY6+GW0M/AKfVqMXTmGe196SW5rez8
         zUDg==
X-Forwarded-Encrypted: i=1; AJvYcCUhjJ/VYdESu0Bee4UPVld+0rIqVynLZpgjTfGLyv4sBb6cldyX0DdhEBQBnoiC71HQXy/1n+5a8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPx8JhSOB/3bEOvFT1LeejuSPQbM0ov3h4ACMhHFrbnovH7+/I
	z2ee6EFIpSD8Hz6SxSRpYhiQCnv+do0J1hk71biV8G4z9NZbkv9dYJVEEUn8g9yT3Ky56JLt6vZ
	GmwfgvZXLOqgKcORCJaD1sxy/aDmTIjxQnSh/f6F/X/k/Uotcb+AQU7X4og==
X-Gm-Gg: ASbGncsLbbpDzB6/CDVt4i0ulNPr2iYADvqW9VYAQwzjLy7lXOeYB1BdqZRpbQNY/p9
	obqPHPZFtDMNyN3GiIzVYJxGrMTdCPrU2IRfLgCkdZzeBRfRHEBAs8s14K3YTC3Fohl2Oe0LB8V
	n/BBqVO7NFomc6a5Q5SDjyj+XvjpajzaKR+NS+YsuNi7sBjAdcvElPk+Gg9ASCv1yit6oZrseWS
	cINERHE+XIsdDwd3V9Ky+NsdQu+s7Z9A2vKKsruJP70T5flj9/oewd7MRHleyBu0cUrqRamALCM
	FMZphA27W2tZ7E59gmBZyQgYSlDGyOZRmVp4PTRuRj+JFyaj6vfpRHlRmCWJ/AWf5G8=
X-Received: by 2002:ad4:5d68:0:b0:6ed:122c:7daa with SMTP id 6a1803df08f44-6f4b4715783mr16544026d6.4.1745411142444;
        Wed, 23 Apr 2025 05:25:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8oXZ9JnKtVNQzSjdw+36R1Viqv7RB6F1PrfW3UoImxkzoWPf3HA1/z5215kcW7wchhdalKQ==
X-Received: by 2002:ad4:5d68:0:b0:6ed:122c:7daa with SMTP id 6a1803df08f44-6f4b4715783mr16543846d6.4.1745411142040;
        Wed, 23 Apr 2025 05:25:42 -0700 (PDT)
Received: from [192.168.65.183] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f6255778b3sm7388108a12.19.2025.04.23.05.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 05:25:41 -0700 (PDT)
Message-ID: <8671d7f8-0d41-4574-a0de-aa40c1ed3c0b@oss.qualcomm.com>
Date: Wed, 23 Apr 2025 14:25:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] drm/msm/adreno: Add module param to disable ACD
To: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark
 <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Anthony Ruhier <aruhier@mailbox.org>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250419-gpu-acd-v5-0-8dbab23569e0@quicinc.com>
 <20250419-gpu-acd-v5-4-8dbab23569e0@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250419-gpu-acd-v5-4-8dbab23569e0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gN4OhlKmBKlZLOmK8vPfMtBWhHWxTCze
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA4NiBTYWx0ZWRfX4Y0+cqnodRkP hMakPBSJksNJJV7Is989jF8NX6fXrnusROuaSmuLRvTFFtUpHJ/ho0I5z3aQCZlwtJINmdJqJZR srbL8tacZK4oODB1QDH1haPtTi7MsbKwcBferV51/OdSf8f5OwZTBgjTCzRU9pMdbgI/KL0Hj9S
 QnBYrKEM1amhOlCXN3EYsXTBgJYMJRF6STG/5AOI9/tjTO9yJklschJhYsqqm5/Qu3eEfvyndPU 81dbNI8UhkVp6jQ1BiqjwyvcdGEBJks0qEqZ8qh1Qfvby1E7yC7G7r9c27dEOXKtTfU44vwk3hi r+wjxZCObY5HCXF9Gd3dSSK+XrcAMarp28yrvmYBT2KTWhnFmIVFlQy2UBKm9+qYbT/gPyUHcvr
 ky+Xr6KSyjTb2TynMBs3Pxl2e7DR6qga/wiWTMVJpRJ5NYDOp0OyCDRpWCe7PjcG8xe/pDNN
X-Authority-Analysis: v=2.4 cv=ELgG00ZC c=1 sm=1 tr=0 ts=6808dc47 cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=b3CbU_ItAAAA:8 a=EUspDBNiAAAA:8
 a=T2YAUAM4dRpUgQIxx5oA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-GUID: gN4OhlKmBKlZLOmK8vPfMtBWhHWxTCze
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_07,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230086

On 4/19/25 4:51 PM, Akhil P Oommen wrote:
> Add a module param to disable ACD which will help to quickly rule it
> out for any GPU issues.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> Tested-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> Tested-by: Anthony Ruhier <aruhier@mailbox.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 7 +++++++
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 4 ++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 48b4ca8894ba38176481b62b7fd1406472369df1..38c0f8ef85c3d260864541d83abe43e49c772c52 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -1670,6 +1670,13 @@ static int a6xx_gmu_acd_probe(struct a6xx_gmu *gmu)
>  	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
>  	struct msm_gpu *gpu = &adreno_gpu->base;
>  	int ret, i, cmd_idx = 0;
> +	extern bool disable_acd;

'extern' in local scope is.. rare but sure, why not

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

