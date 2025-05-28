Return-Path: <linux-pm+bounces-27729-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AABADAC68F6
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 14:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0E31BC6DE2
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 12:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE7428468C;
	Wed, 28 May 2025 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oRMEPjVr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14BC283FC5
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748434506; cv=none; b=XaiD16dpVTLPQ/As0ZCXRCmQ9v+F2aZct+hBvtCM4j0wmAd8JOE+SICOVjfaEg8MKLcODohwxShQ2+KjEfFlF3aoQ8qTWlS08IUFCS9qbF3PM6h1grx5M2ewvFL+Q2p7VwgFkyWkQP56F+HghLlCl3ZKz5EkR3EqXsKazG15dLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748434506; c=relaxed/simple;
	bh=B4Iy4GScb0lOZr3qXJcMXNhDcnRTr1zdGPMFxHZBWQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Upp6NMW5550oK0Tv0HnscZDe6lmzuL2WDJmEpd1ZvtAffCSz4n7LaPyTyvqjhyAs+Y+ZdGw20udY/Ob3THOVCdIpdvbGU9Bb09GhDEMTglJNgjoGcEqcF39/Apnq/g7FZper3TyCa72FTBbdKoUps0zj2L4vIBhe8bzeaWonUcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oRMEPjVr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S9hldt009833
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 12:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3kxSJrMywr9s+d3mPmL3Y3rsQ2dFUTAUlZhEMbytmdA=; b=oRMEPjVrCnOedfZI
	FTk+db0FQ9H+q3FFA1mBrcPBn6D3TZRIfCH1pTDhGc+QbtgRpfmzmXD0gdbuRnTd
	f1552dHaTa2uGvEhaBVbSIzt8vdOUSrE2jP7PTGfKeTvP03JrU/YrIwReS25sJpe
	uH6jGH2oDJf6g9DX7TdRQY/FNnvr/1PZeD2FarsV51SCNJmAHV9yf5cUJohyLvH9
	R/c9ArwXCxfx/dId6ZQQ3qfFtdi7szGGKglAlCcMnFXB2MbrXTap2m+hXpuReYKU
	ZqhfwDXvX+QX0LZkrMYqyvfJy0YOwKg4ATPmzWwA7jYKeyBWV8dOohrlFVg+YT41
	5rF0Hw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46x03mrbhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 12:15:03 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fac4878cfcso338536d6.2
        for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 05:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748434502; x=1749039302;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3kxSJrMywr9s+d3mPmL3Y3rsQ2dFUTAUlZhEMbytmdA=;
        b=WlhF6M2YJ7QXCymc3MkUZ9J/Y10LK9fiTmC3mZYw5JjFEp67VJ/d/mGp6zzFr0XjpD
         eD6Q4JUCXA/WaFn9oamVOtHyZutAsnA/5saU8UuQBcUG3l5JwSPVpWtCOpYMRkAnD4av
         /YqyXb4zrym/6RGE8G1nEiT+kPAlZOHyoW50U8RHvJuuhfCcIHnsXAI00CAhypjs6+cN
         b2c4DPY1PYlUEuR4kEifjEmPWGLmBYXpAqgMUVRTcv3y49sdj+N1icisTUxWqwhOvZET
         rCbP0cUX+1EGbVfOcyQM8i+4hVrMJiR4e8IAbyEN12OkkYbpJsDF9DFuPk8hl38HjzzR
         zczA==
X-Forwarded-Encrypted: i=1; AJvYcCUhnevizvrPwTUg+pqh+PpnbNBOSEWNHPt+exjVRXKjN+fpw9av3VPgC8rhyLgJwCJEaUodXy5YEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCylSBIodhb1OuXNpd3jnGEuhzglJQ+8scCQG35Lz0icqwCHj2
	40s9ShwYRGSGW88WoiO5cuQeo/aYmUqEJAEMj9upxh1sR8NVzg1U7zlHkffu5dqPk3jCuQgzdwI
	DRUd5BpENt6mTJXIgdloIUm2VBAZuqDHcImU5k5CaHo3NaRMOmp9oTQPf3+3Diw==
X-Gm-Gg: ASbGnctEicazQvPG2nP8VNhulxatgt4Xoo0ghgWO0sJObGfPv6Tq3iYLiAdLKnPmSlS
	oR6u22qnV156EIMpDzlV07+Q6GSADAQAcxE177W4c1DogJ/UaZ+wytEq9C46U5rWNEKNFUJrkpf
	LUXrFukbf4Cy8J9hpBCakyKl73gCblUCYgylA1RKrqmpqm/11monH92ofzLa43kYEIER4yKBYIy
	Pxd0CdXyzSIUfporGTQF7CTWKbuE6maxa/8fungfsDP50Nr5JVf9Q7f9q8DOJElxqJclk/RpEBm
	Fa39URXVNfh1pV1zsrPa6gDR+mUSxqTlDRfx8qOaAAZt01XXyeGB0a65q1kA6h34b07MP07Gp3E
	=
X-Received: by 2002:a05:6214:1805:b0:6fa:c0f8:4dff with SMTP id 6a1803df08f44-6fac0f84fb3mr19984706d6.37.1748434502625;
        Wed, 28 May 2025 05:15:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6Xjdm32wkahk/ntIryyXQ0dV0UAu8jmCUZQcY0SDaEWnx0pvAxtAjn4+fgoBP7skc2unmMQ==
X-Received: by 2002:a05:6214:1805:b0:6fa:c0f8:4dff with SMTP id 6a1803df08f44-6fac0f84fb3mr19984406d6.37.1748434502242;
        Wed, 28 May 2025 05:15:02 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5532f6b3f02sm258525e87.236.2025.05.28.05.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 05:15:01 -0700 (PDT)
Date: Wed, 28 May 2025 15:14:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kornel =?utf-8?Q?Dul=C4=99ba?= <korneld@google.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: qcom_battmgr: Report battery capacity
Message-ID: <q6zxkzuvczjuewapb5jrk6bnp3t6lsvu5mgqb7gpq7bbdsgprd@ozgvgbtapdjw>
References: <20250528112328.1640743-2-korneld@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250528112328.1640743-2-korneld@google.com>
X-Proofpoint-GUID: k-n5n__9LmJR2u8dhXgiY4Ug-1C2pfPi
X-Authority-Analysis: v=2.4 cv=FuAF/3rq c=1 sm=1 tr=0 ts=6836fe47 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=zIzJRpkdUK6dvKgA1CAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: k-n5n__9LmJR2u8dhXgiY4Ug-1C2pfPi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEwNiBTYWx0ZWRfX+q/Pn3Hle0qn
 /dwR+AjUudSkldvGwcU/4HMR0lM4iTBL5DnErVS/cMH48Wrxml/LQd+PcJgwPg6y5wjcXLDooXi
 1jXAovXnUrS8uvDNlOzlPxwE365WEfGxvSYJz8ugWt81AOx0FZ1iEk55tEZWdNZtd882wPN8elN
 QTtEPnAmLzfATPJX4PLCWsaAQL0omxvbg4sPppjXjz2JDgYsCuDQ3wjmU09sy/x6KJLsIb4k3uV
 1fBCJQuU695jLA7u08fycVINT31kRyF6fqt8fl88f+hMQ6WTLiUBVYUw0AIxOVMj1bmyglakSnL
 I7l6CnOc2lJEFiXjZfnRT1Yf8W9NZMVSLzRAd/RoMN5oPc66qQZmZHZki1Z/vbGpuqhy2RodBg2
 HpebBfjf2yMoGAdrZdTIxRBpLsJUI1VHvjAar7T4U9imqBIYDq4xDW86eFn6MUBiomioILuT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280106

On Wed, May 28, 2025 at 11:23:29AM +0000, Kornel Dulęba wrote:
> Battery charge can be reported in several different ways. One of them is
> is charge percentage referred to as POWER_SUPPLY_PROP_CAPACITY in the
> power supply API. Currently the driver reports the capacity in this way
> on SM8350, but not on the newer variants referred to as SC8280XP in the
> driver. Although this is not a bug in itself, not reporting the
> percentage can confuse some userspace consumers.
> Mimic what is done in the ACPI driver (drivers/acpi/battery.c) and
> calculate the percentage capacity by dividing the current charge value
> by the full charge.
> 
> Signed-off-by: Kornel Dulęba <korneld@google.com>
> ---
> v2: Change the logic to avoid u64 division, which is problematic on
>     32bit platforms.
> 
>  drivers/power/supply/qcom_battmgr.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

