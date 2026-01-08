Return-Path: <linux-pm+bounces-40447-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69439D02C8F
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 13:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CACF30188CA
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 12:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E3F47C67B;
	Thu,  8 Jan 2026 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JeAww7VO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NeIFMOPE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1492F47C65C
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873582; cv=none; b=RxAC82s9P9zoEgkQV5yd2619Rb4Tjt3vvbrdiPS7B5EEVdhj8aviC1nDPjL3hkTIOArl36jg6tRwYlELFSNYIWvP0BvcoxJdEJ0Dg3QGJWSFacUX91P4jWtpexJOUemocWUNSUpkCIs55B4DM2+mmcdHq5/rqwlp82Aa3TFmVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873582; c=relaxed/simple;
	bh=8kJB94hZyPR8MuRaqMzRm0KGhxZfwYyezB1O9loh66g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gjfuog8oKnZgS1b2uCO8RD5CKMqwfXpFNG/nS1wlLBkilFewofXGCklSC8DPTg6EzUltLcxl+0fF6eAWp8R9HXNwZoEex7Cp062Xkplwzkgjpj12x2RWJuJIQ5q7UGNDd7ewjJCGqKy009lkFefToCFHaqPxA9YTfmsT6horD10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JeAww7VO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NeIFMOPE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6089wsbw125834
	for <linux-pm@vger.kernel.org>; Thu, 8 Jan 2026 11:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aPV5JMJb545VwKcqd+eushmVdNeqBStXtF+OY6h49wg=; b=JeAww7VOpgvxb0Rf
	9ndf5Izl+tzgOYjCm1NLCJs2kUQ3RYAJSMT14HZUY3BMtqzeX/qx9xp9EpeSw9f1
	UOjCdHTH7sdPZ3KjN8tmrJCSQZ/wgdg1PaZrFADd+H42QH1rEMIDp/RucBnUIlUY
	ZfiSImg2hdnpGPpSV/Zdqo7evnwYl8wgf9N+Vx7Y6tPcg3NyfY9Cc56UFFcjMayu
	Yew2+EHGVkoZrTEYTdra32DmTIbY65lRn1rUcuY8gTMtL0S8Hhr3mX5NEgx2NRnb
	AdeCyXdqBCtRWQtFloVdvgIqyU0uBb37Oo5gtk1PkJxtRWhIdrgbl2IsHS8tw1JN
	RhPa1g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj3d69pyy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 11:59:37 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8088be744afso1399297b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 03:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767873576; x=1768478376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aPV5JMJb545VwKcqd+eushmVdNeqBStXtF+OY6h49wg=;
        b=NeIFMOPERPXWi8ZuDPJ3qUmQsP7A0nXT6jVfQcqzNJSS+DM9fxeSS/blOeRndf9Td2
         oux4clN0EgyFoIZ2Rcd/CdjTEitQ/3BZ3kA3umCyMk5JyfY/nISgyCmbsr3jrCqT8PfY
         cAjukosimPvnhA7IOJOWoPc+Y6Fhw0lP6ONYQ6DZOlw1Xl5pB53OgFdWIblGH7aggC4j
         e+kerky+zuR7YvnMbJN2DQopKpyjgRN53wo2MaHQf1ZDmpgSEyXr+nTrsa3l3GTX15yu
         GwUlH7EGSmc9lRGWDPsbpMPC8gDMuDPgdixGQW6siHJsyuBUmpNWHa3eXvVXRSr35TkO
         jvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767873576; x=1768478376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPV5JMJb545VwKcqd+eushmVdNeqBStXtF+OY6h49wg=;
        b=ICPurrdrHlQ3/YfegtZoYdSuJ+xINwEzMTW7AtzDGPVfGsaU0TbvMAXNm+Kpfzbk9E
         s6ggH/WgOPUNwqsK99NBrdeusaELqFLKSmaEV7KVtFAOe5qphNtyyXGsYL2awohN/w2N
         BGI0Ze+Ng1EZuuuHoK27Wly4b5dPhWMCoPuHFJQxJpcNRM28lK3yt1z3GMvJ66is9d6o
         /0Bsitgf75Jf8lbOlJBdzc3cQEycsJQiOP8gEdTl7KpNQC0ZpLmVHx2gmAcKp/EDq7mZ
         gudq0fO/GMdTBhGWuzu7l0NmZbt0p322Ogbq5qF1pzUaZbM8GyubUDvkyjzW75rAwg1F
         wcCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZmkCqRsyjXDaaVdMBsoQdfFlEvRl5cXSqbWfWCUWWffgpqT+6VO3RXoo5/PZH2H7SQwKpwAc7JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5+u95IgoCZYDc2vJifl4FWMlTVAu7erYwvZNPldIYKPZ8WE+D
	UlvnQ32s3R4LQu8azUYCGYx5XdR9A0WYFE2aKSpCnoFZT6MQPcG5VZsFAeVRRZGWLEgDltPG582
	KtOrAHTbfMZlRLy2YTt8XExk9gthdgmVahDlcId730zOIuq1htcmClABaLHhakQ==
X-Gm-Gg: AY/fxX7pzb49e6qhfCxLATFKGqKEzKrBDK9I9iJD0Lcb2HQZOU/uwl1JAlYERD4Jr47
	g84C5g4YpSG2NyX8CZ3CR0BFaaGCciSQwPNXqRVH+gFCs3SV5xydQstPh23P8PtMoZUuYL9hMH3
	Nc5R0eBwC+fikOdHizcXxm2lFhASyS7FNSDsBW7JsZx95Ydeu2hEzKaeRbQvZUVGzEshQEDGa6E
	+nCm824QX8NkE+3beAjEh9XoijawKeTvNBGEAucXgRVQRnIK5F1j8FwLnfgawe9CMrQ4HkBXLLA
	7t8aDrEhfYM5D7UyoLzF56TTwLSQPAPxoUdWOGUB0gSzZXSUjzxOlVRYiqcVfH6VigagNauPGS3
	IlhAu16SWR2Id5K/wdoEj9Yq1UL73eqNbKGtKG0oCySW78UIQFQMb48QO3ALaB6EUDDhi5PKG64
	+LA98Mjw==
X-Received: by 2002:a05:6a00:1bcc:b0:7f6:f92d:77e7 with SMTP id d2e1a72fcca58-81b76759596mr5630007b3a.9.1767873576186;
        Thu, 08 Jan 2026 03:59:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVzchwh0BPJzi7b7LWftn70OPApLbSa49yem6AlpPbDabi1x3Emw84GP63aynnRl956Z/IAA==
X-Received: by 2002:a05:6a00:1bcc:b0:7f6:f92d:77e7 with SMTP id d2e1a72fcca58-81b76759596mr5629977b3a.9.1767873575664;
        Thu, 08 Jan 2026 03:59:35 -0800 (PST)
Received: from [10.133.33.147] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819baa1894csm7620651b3a.10.2026.01.08.03.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 03:59:35 -0800 (PST)
Message-ID: <ca326a27-a6b0-4935-ae3f-417e0d769045@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 19:59:28 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/8] thermal: Add Remote Proc cooling driver
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, konradybcio@kernel.org,
        amitk@kernel.org, mani@kernel.org, casey.connolly@linaro.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        zhongqiu.han@oss.qualcomm.com
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-2-gaurav.kohli@oss.qualcomm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20251223123227.1317244-2-gaurav.kohli@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DVu2-f16hpbfUoUJqt_Uc8N14kGmD3K_
X-Authority-Analysis: v=2.4 cv=APfYzRIR c=1 sm=1 tr=0 ts=695f9c29 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=D6nbwq-aYW_yfCsrQPgA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA4MyBTYWx0ZWRfX+m8vgriKTNzD
 2Oy3wduQaA0X4nu+UI72RtRFojObf/nbb8uDVvWPZFfKsAQG+wP+JBfSmPSxYCJTaKnk0a51ow4
 OeH6+Xl8yt6GGJNnoCdEG4OOd4162CCBuhrgJQg50HX1sSOckUQJIavWOePW/5SZ5T3izEnTvv2
 jXEcAAWVhPcL3jptG9vfjhcC1BWb67ja95Ujd9mDMGA9cxDxHKdcT3ZceN9XG3qJKhGuEZYpO5t
 7By8wgENQCSCs47LfFCeQ8rDqFNGq5/586/zV6woac0Hg2DMJ/qMzLAtU8ayLrvip74Ncp1I1Dy
 Hmb/tn9Mc3AMvEXQEqpkCHsENzLeKQWap9kYlTsotCZDS2u4dngxbZ1a23LRRl6pDx/k8/A9qUH
 /mrIPB05OqOp3emRT3hXx8m4m/rgNLu0BzS8L6OA4hGH8/T8E4qhvKsnmrVxKtfS4ZIr/8yjix3
 NtIG2sXwET1KxxJ7ThQ==
X-Proofpoint-ORIG-GUID: DVu2-f16hpbfUoUJqt_Uc8N14kGmD3K_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 clxscore=1011 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601080083

On 12/23/2025 8:32 PM, Gaurav Kohli wrote:
> Add a new generic driver for thermal cooling devices that control
> remote processors (modem, DSP, etc.) through various communication
> channels.
> 
> This driver provides an abstraction layer between the thermal
> subsystem and vendor-specific remote processor communication
> mechanisms.
> 
> Suggested-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>   MAINTAINERS                          |   8 ++
>   drivers/thermal/Kconfig              |  11 ++
>   drivers/thermal/Makefile             |   2 +
>   drivers/thermal/remoteproc_cooling.c | 154 +++++++++++++++++++++++++++
>   include/linux/remoteproc_cooling.h   |  52 +++++++++
>   5 files changed, 227 insertions(+)
>   create mode 100644 drivers/thermal/remoteproc_cooling.c
>   create mode 100644 include/linux/remoteproc_cooling.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 679e5f11e672..c1ba87315cdf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25935,6 +25935,14 @@ F:	drivers/thermal/cpufreq_cooling.c
>   F:	drivers/thermal/cpuidle_cooling.c
>   F:	include/linux/cpu_cooling.h
>   
> +THERMAL/REMOTEPROC_COOLING
> +M:	Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> +L:	linux-pm@vger.kernel.org
> +S:	Supported
> +F:	drivers/thermal/remoteproc_cooling.c
> +F:	include/linux/remoteproc_cooling.h
> +
> +
>   THERMAL/POWER_ALLOCATOR
>   M:	Lukasz Luba <lukasz.luba@arm.com>
>   L:	linux-pm@vger.kernel.org
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index b10080d61860..31e92be34387 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -229,6 +229,17 @@ config PCIE_THERMAL
>   
>   	  If you want this support, you should say Y here.
>   
> +
> +config REMOTEPROC_THERMAL
> +	bool "Remote processor cooling support"

Hi Gaurav,

May I know any depends here?

> +	help
> +	  This implements a generic cooling mechanism for remote processors
> +	  (modem, DSP, etc.) that allows vendor-specific implementations to
> +	  register thermal cooling devices and provide callbacks for thermal
> +	  mitigation.
> +
> +	  If you want this support, you should say Y here.
> +
>   config THERMAL_EMULATION
>   	bool "Thermal emulation mode support"
>   	help
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index bb21e7ea7fc6..ae747dde54fe 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -34,6 +34,8 @@ thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
>   
>   thermal_sys-$(CONFIG_PCIE_THERMAL) += pcie_cooling.o
>   
> +thermal_sys-$(CONFIG_REMOTEPROC_THERMAL) += remoteproc_cooling.o
> +
>   obj-$(CONFIG_K3_THERMAL)	+= k3_bandgap.o k3_j72xx_bandgap.o
>   # platform thermal drivers
>   obj-y				+= broadcom/
> diff --git a/drivers/thermal/remoteproc_cooling.c b/drivers/thermal/remoteproc_cooling.c
> new file mode 100644
> index 000000000000..a1f948cbde0f
> --- /dev/null
> +++ b/drivers/thermal/remoteproc_cooling.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Remote Processor Cooling Device
> + *
> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +
> +#define REMOTEPROC_PREFIX		"rproc_"
> +
> +struct remoteproc_cooling_ops {
> +	int (*get_max_level)(void *devdata, unsigned long *level);
> +	int (*get_cur_level)(void *devdata, unsigned long *level);
> +	int (*set_cur_level)(void *devdata, unsigned long level);
> +};
It's better to have a document to explain member?

And may I know why double define here(another is in .h file)? should it
include .h file remoteproc_cooling.h ?


> +
> +/**
> + * struct remoteproc_cdev - Remote processor cooling device
> + * @cdev: Thermal cooling device handle
> + * @ops: Vendor-specific operation callbacks
> + * @devdata: Private data for vendor implementation
> + * @np: Device tree node associated with this cooling device
> + * @lock: Mutex to protect cooling device operations
> + */
> +struct remoteproc_cdev {
> +	struct thermal_cooling_device *cdev;
> +	const struct remoteproc_cooling_ops *ops;
> +	void *devdata;
> +	struct device_node *np;
> +	struct mutex lock;
> +};
> +
> +
> +/* Thermal cooling device callbacks */
> +
> +static int remoteproc_get_max_state(struct thermal_cooling_device *cdev,
> +				    unsigned long *state)
> +{
> +	struct remoteproc_cdev *rproc_cdev = cdev->devdata;
> +	int ret;
> +
> +	if (!rproc_cdev || !rproc_cdev->ops)
> +		return -EINVAL;
> +
> +	mutex_lock(&rproc_cdev->lock);
> +	ret = rproc_cdev->ops->get_max_level(rproc_cdev->devdata, state);
> +	mutex_unlock(&rproc_cdev->lock);
> +
> +	return ret;
> +}
> +
> +static int remoteproc_get_cur_state(struct thermal_cooling_device *cdev,
> +				    unsigned long *state)
> +{
> +	struct remoteproc_cdev *rproc_cdev = cdev->devdata;
> +	int ret;
> +
> +	if (!rproc_cdev || !rproc_cdev->ops)
> +		return -EINVAL;
> +
> +	mutex_lock(&rproc_cdev->lock);
> +	ret = rproc_cdev->ops->get_cur_level(rproc_cdev->devdata, state);
> +	mutex_unlock(&rproc_cdev->lock);
> +
> +	return ret;
> +}
> +
> +static int remoteproc_set_cur_state(struct thermal_cooling_device *cdev,
> +				    unsigned long state)
> +{
> +	struct remoteproc_cdev *rproc_cdev = cdev->devdata;
> +	int ret;
> +
> +	if (!rproc_cdev || !rproc_cdev->ops)
> +		return -EINVAL;
> +
> +	mutex_lock(&rproc_cdev->lock);
> +	ret = rproc_cdev->ops->set_cur_level(rproc_cdev->devdata, state);
> +	mutex_unlock(&rproc_cdev->lock);
> +
> +	return ret;
> +}
> +
> +static const struct thermal_cooling_device_ops remoteproc_cooling_ops = {
> +	.get_max_state = remoteproc_get_max_state,
> +	.get_cur_state = remoteproc_get_cur_state,
> +	.set_cur_state = remoteproc_set_cur_state,
> +};
> +
> +struct remoteproc_cdev *
> +remoteproc_cooling_register(struct device_node *np,
> +			     const char *name, const struct remoteproc_cooling_ops *ops,
> +			     void *devdata)
> +{
> +	struct remoteproc_cdev *rproc_cdev;
> +	struct thermal_cooling_device *cdev;
> +	int ret;
> +
> +	if (!name || !ops) {
> +		return ERR_PTR(-EINVAL);
> +	}
> +

May I know which ops callbacks are required and which are optional?
If the callback is optional, should we check for null before calling it?


> +	rproc_cdev = kzalloc(sizeof(*rproc_cdev), GFP_KERNEL);
> +	if (!rproc_cdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rproc_cdev->ops = ops;
> +	rproc_cdev->devdata = devdata;
> +	rproc_cdev->np = np;
> +	mutex_init(&rproc_cdev->lock);
> +
> +	char *rproc_name __free(kfree) =
> +		kasprintf(GFP_KERNEL, REMOTEPROC_PREFIX "%s", name);

It should have a NULL check when alloc memory.


> +	/* Register with thermal framework */
> +	if (np) {
> +		cdev = thermal_of_cooling_device_register(np, rproc_name, rproc_cdev,
> +							  &remoteproc_cooling_ops);
> +	}
> +
> +	if (IS_ERR(cdev)) {
> +		ret = PTR_ERR(cdev);
> +		goto free_rproc_cdev;
> +	}
> +
> +	rproc_cdev->cdev = cdev;
> +
> +	return rproc_cdev;
> +
> +free_rproc_cdev:
> +	kfree(rproc_cdev);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(remoteproc_cooling_register);
> +
> +void remoteproc_cooling_unregister(struct remoteproc_cdev *rproc_cdev)
> +{
> +	if (!rproc_cdev)
> +		return;
> +
> +	thermal_cooling_device_unregister(rproc_cdev->cdev);
> +	mutex_destroy(&rproc_cdev->lock);
> +	kfree(rproc_cdev);
> +}
> +EXPORT_SYMBOL_GPL(remoteproc_cooling_unregister);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Remote Processor Cooling Device");
> diff --git a/include/linux/remoteproc_cooling.h b/include/linux/remoteproc_cooling.h
> new file mode 100644
> index 000000000000..ef94019d220d
> --- /dev/null
> +++ b/include/linux/remoteproc_cooling.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Remote Processor Cooling Device
> + *
> + * Copyright (c) 2025, Qualcomm Innovation Center
> + */
> +
> +#ifndef __REMOTEPROC_COOLING_H__
> +#define __REMOTEPROC_COOLING_H__
> +
> +#include <linux/thermal.h>
> +
> +struct device;
> +struct device_node;
> +
> +struct remoteproc_cooling_ops {
> +	int (*get_max_level)(void *devdata, unsigned long *level);
> +	int (*get_cur_level)(void *devdata, unsigned long *level);
> +	int (*set_cur_level)(void *devdata, unsigned long level);
> +};
> +
> +struct remoteproc_cdev;
> +
> +#ifdef CONFIG_REMOTEPROC_THERMAL
> +
> +struct remoteproc_cdev *
> +remoteproc_cooling_register(struct device_node *np,
> +			     const char *name,
> +			     const struct remoteproc_cooling_ops *ops,
> +			     void *devdata);
> +
> +void remoteproc_cooling_unregister(struct remoteproc_cdev *rproc_cdev);
> +
> +#else /* !CONFIG_REMOTEPROC_THERMAL */
> +
> +static inline struct remoteproc_cdev *
> +remoteproc_cooling_register(struct device_node *np,
> +			     const char *name,
> +			     const struct remoteproc_cooling_ops *ops,
> +			     void *devdata)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static inline void
> +remoteproc_cooling_unregister(struct remoteproc_cdev *rproc_cdev)
> +{
> +}
> +
> +#endif /* CONFIG_REMOTEPROC_THERMAL */
> +
> +#endif /* __REMOTEPROC_COOLING_H__ */


-- 
Thx and BRs,
Zhongqiu Han

