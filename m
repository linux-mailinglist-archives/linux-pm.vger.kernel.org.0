Return-Path: <linux-pm+bounces-40176-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9ECCF1FCA
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 06:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A18FE30049C5
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 05:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DD024677F;
	Mon,  5 Jan 2026 05:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W64Vhf15";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dvhWPhf9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2BE326959
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 05:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767590296; cv=none; b=YVzeLKGczE4RF+9MmWbCfEziveMCWT0zfM6ZZ1TekS5MjXZWxNGJtw+CuIR65R23dqMq3ZXtOz/vLsDA0Y/Tlz00wf+EzTQ5ufcDIg0NV3VfsJOCPHM0FmzroPlkLMVFdWp+aRLk+PxPjLiScy6MqP9PFerz4uT4IW83sE1z8i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767590296; c=relaxed/simple;
	bh=ocaou5uR6eFyLDCEvk/W+9q8FiFR/tuh4+NiSKUdqrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRo+NzsVNeMmTn0lQs8vIdUJoBVzG+W4iZUljlsmLoem7frYXkNup7Qno5IlmSflwCXhdoaVUubYkRZiyAHG4IvYaqO4tEYCqR1dt/FjhSnOFS/hQ9fheTziHjT2aGtTfVnE1P0x5O7gVxHHmxtEN2hahsYSChHbI8u6Yaxhs04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W64Vhf15; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dvhWPhf9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604Ncece1207936
	for <linux-pm@vger.kernel.org>; Mon, 5 Jan 2026 05:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ySWYYDA7v/+DqDVTbnsFBC4H3eWDLGY6h0cEy/G1fDw=; b=W64Vhf15Gvwh6U/R
	Nz4Iu7uxUo1A3rHLvrlP27g1ZF+zaksSFpgpBBBWQFwVAFMKOeeaP7Vxo+jX8U4Q
	jh0fj9KQ8qjq3xgNSJr9ryRRnUARCCctUnfEK9XkHvAPZDeiBtBIWCeOcpjyp4tU
	GIsCesLphflilRp/EJKi3c2TF/74xjrkfT1FGd/Mx4HdiwQ7bmvhcn95n2oAc/t0
	I1mHY8yDqwmBt3NEY7M/CtNrXT129lg3D7Q/aBGE6AShZQg1lBBfVxcZpGgjMLj5
	BpJU+TsHRgmZBd6EcCRcBKEOSX1x+rIzSLMPdtipCvIPstCniiwkxUA2tUmKxdQd
	TVqLeQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bev9hb5w8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 05:18:12 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7ba92341f38so14675413b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 04 Jan 2026 21:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767590292; x=1768195092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ySWYYDA7v/+DqDVTbnsFBC4H3eWDLGY6h0cEy/G1fDw=;
        b=dvhWPhf9nn2YAcHEKzY1BNevAN5JsDYPY27Hr14EPDLuypEigvjydFoI02hWBEhTqC
         wMk58IuhpFhqXgTk9yIAOFaaCt9J9CsSb+738iJp8lzg7phRopG1H34KTacp+TSyLg+s
         2GICdYsoDzes/qw1tmsEHhOTDJ9aUpvYrIFS2xQl1ANGAZ053Re36bTpqZxVUwUSyGOv
         4FMvus3G1hIi40f34dtrKVYqyoWcjSXF3HcbYPDJ9ltoTjt4fE25DnRZUa0cOQHds27c
         wbQAARZxaAyuGS+ozU2Ok/tWVS4yWxwGoQYvZD134VNPcEY8D8Q4FN8GqV8UfKBov/sW
         6R8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767590292; x=1768195092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ySWYYDA7v/+DqDVTbnsFBC4H3eWDLGY6h0cEy/G1fDw=;
        b=e8reKehr3FnBjKDpAd89UoC6wTyN5B38LolAWrZt3ecO7pDkgjQtAszePnYpNfq4dO
         76vR3FyzanGjMqZ3dS9ZHtzNSc1K4MOQG1GDScVLYPc4VJQGHSW7k9i/tipkxeVYrwYq
         xKUjX242hXMqVlTCaQXvEkgAyzRfTiEtrm0mcrFy+aQuOrC6wbVmj5QHviPNZAKaQDDE
         Q5rtKXtQwJRm2JaNLdr6tZWdHaFJQr1/KXok3aNGwZk8nBymKTOtgiA2wRahlTcmLfXy
         zWx9naRO9T3QWpVdXAfGQ4yn8plkAnUHLka4hStbJWJ6YoPpBj0mrDxukfqEpXw0MqJy
         FEnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXIKGdhuvDihSKz/GDHbB1uvJcKjK/5uTYTrckR0PAmExELvEguSKQGV73hu8zYlLZxrKWJUtLMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzH9Qiv8svlzOFnfSN3zgJ/3M278/p4tmfFH8xccdpcTVU8LgDX
	2KDo/lgsrxO+p8zeyO8SqJPrLfj+4cr9G9yqYm8ubBGIMlbQsweQBruGjyz7MNNq5YBhcxZCykk
	HWWEbk8yJ146bUTAP+TA5lamh5vH0En3iG5Pzl0tnpPTgCEXfCqdFDzTUHtTiRg==
X-Gm-Gg: AY/fxX57Pl9GbBa5ORrl2Vv9l+jp7MR1yx0j9FdXfEkNr3nXpR28AkRVTuXFOey+2f4
	4xdJI8X9BkBb6nfRlj9wm34DXwza5C5FtkSMe2em+Iugrtudh0mMqpPP7jPHwb8IIoqJtP/fVPn
	CEKHP4FvS64PR1jYk2QC/UciWo/czbjXcpGPKGMqhqYyhdRFiuD8WHCrg2lgOFjXYD5kV1v8q5b
	X1SpcSwI73iBKRwiHmAoXJdx15MN2mg/gK0fpNg7ZjYCye98b0eHX/xdZexKZdetYkp4cD3Mmxx
	Bzln5t5vsRalRpd4EUAtat+oCcfB4mc8F83E98mWbmbKWVyfTblSzS1OBx0ZtGkU+7MoMg4wj7B
	bYmU9yBX6ylbzx6VtX+8oA+VNRbi0FKRP03320aM=
X-Received: by 2002:a05:6a00:1f14:b0:7b7:90de:e191 with SMTP id d2e1a72fcca58-7ff654b812amr42406340b3a.23.1767590291745;
        Sun, 04 Jan 2026 21:18:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDvDRzL24Mlqqr/cKwCquOpoKNcLxSMnfZt+iAz84l0KGwgDEtrHlB770xXA5wUiUtm3pZyQ==
X-Received: by 2002:a05:6a00:1f14:b0:7b7:90de:e191 with SMTP id d2e1a72fcca58-7ff654b812amr42406323b3a.23.1767590291190;
        Sun, 04 Jan 2026 21:18:11 -0800 (PST)
Received: from [10.218.27.120] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f26asm45872005b3a.52.2026.01.04.21.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 21:18:10 -0800 (PST)
Message-ID: <f034126a-cadb-4c97-9917-5803da7c929f@oss.qualcomm.com>
Date: Mon, 5 Jan 2026 10:48:04 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/8] thermal: Add Remote Proc cooling driver
To: Bjorn Andersson <andersson@kernel.org>
Cc: mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, konradybcio@kernel.org,
        amitk@kernel.org, mani@kernel.org, casey.connolly@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-2-gaurav.kohli@oss.qualcomm.com>
 <a4dpzxt4zkhwfnjijj455nziu2fa26nxzt6a6wgsm4fflcdrcu@rxjw7gcnwnxi>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <a4dpzxt4zkhwfnjijj455nziu2fa26nxzt6a6wgsm4fflcdrcu@rxjw7gcnwnxi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA0NyBTYWx0ZWRfX6hmqZgyO8Bvp
 fzlhz01yUsls/aiuMasCtFbY7+GwO3qd/EUqSwGLRWJq4gXcapH69MYMCsmVETlhmngr8DGxY3v
 dHNxo9a67DkG1hoqf/gS14SvGS9C4zwJDTSVsnaCEeFSKCfYv7/fdhb2O8e0Kos+G/byF4IwT78
 gQh3fVPfBJmyNcdxBS6YCVu5seViZG47HMJ74rn637Wjt26E25cFf4/CC34mjnkD+35hc/fjK8G
 flhu+LwXTkKzY72NZeiq0BDLjVjd/xvuHNJx2GWjEd+CV9J8ioQzlRyJ7uafXN1QybculQIYZsF
 27lqYNnZW3k1Bcr8oBzqM6wrzpQKmPx0CvFyO3JyUDQe7F2EdaW2oDgrkcyb9CiMxqQ29rv289o
 WHeFUPllXkXEjh+9+zTIDLtqDLMcENx/QXKBEhDjD0VK2EfKnLf8HcUIztlH2HwCp1UURnOu2hI
 OxngT4QsemucBf5XBeQ==
X-Proofpoint-GUID: XHOx6DhUnyq1kUKrhtIUDWOpp58PaI4J
X-Authority-Analysis: v=2.4 cv=RrbI7SmK c=1 sm=1 tr=0 ts=695b4994 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=evdxb9anZX7H7y_a-x0A:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: XHOx6DhUnyq1kUKrhtIUDWOpp58PaI4J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_07,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050047


On 1/3/2026 8:35 PM, Bjorn Andersson wrote:
> On Tue, Dec 23, 2025 at 06:02:20PM +0530, Gaurav Kohli wrote:
>> Add a new generic driver for thermal cooling devices that control
>> remote processors (modem, DSP, etc.) through various communication
>> channels.
>>
>> This driver provides an abstraction layer between the thermal
>> subsystem and vendor-specific remote processor communication
>> mechanisms.
>>
>> Suggested-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   MAINTAINERS                          |   8 ++
>>   drivers/thermal/Kconfig              |  11 ++
>>   drivers/thermal/Makefile             |   2 +
>>   drivers/thermal/remoteproc_cooling.c | 154 +++++++++++++++++++++++++++
>>   include/linux/remoteproc_cooling.h   |  52 +++++++++
>>   5 files changed, 227 insertions(+)
>>   create mode 100644 drivers/thermal/remoteproc_cooling.c
>>   create mode 100644 include/linux/remoteproc_cooling.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 679e5f11e672..c1ba87315cdf 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -25935,6 +25935,14 @@ F:	drivers/thermal/cpufreq_cooling.c
>>   F:	drivers/thermal/cpuidle_cooling.c
>>   F:	include/linux/cpu_cooling.h
>>   
>> +THERMAL/REMOTEPROC_COOLING
>> +M:	Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> +L:	linux-pm@vger.kernel.org
>> +S:	Supported
>> +F:	drivers/thermal/remoteproc_cooling.c
>> +F:	include/linux/remoteproc_cooling.h
>> +
>> +
> Two empty lines here...


thanks, will fix.


>
>>   THERMAL/POWER_ALLOCATOR
>>   M:	Lukasz Luba <lukasz.luba@arm.com>
>>   L:	linux-pm@vger.kernel.org
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index b10080d61860..31e92be34387 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -229,6 +229,17 @@ config PCIE_THERMAL
>>   
>>   	  If you want this support, you should say Y here.
>>   
>> +
> And two here...
>
>> +config REMOTEPROC_THERMAL
>> +	bool "Remote processor cooling support"
>> +	help
>> +	  This implements a generic cooling mechanism for remote processors
>> +	  (modem, DSP, etc.) that allows vendor-specific implementations to
>> +	  register thermal cooling devices and provide callbacks for thermal
>> +	  mitigation.
>> +
>> +	  If you want this support, you should say Y here.
>> +
>>   config THERMAL_EMULATION
>>   	bool "Thermal emulation mode support"
>>   	help
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index bb21e7ea7fc6..ae747dde54fe 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -34,6 +34,8 @@ thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
>>   
>>   thermal_sys-$(CONFIG_PCIE_THERMAL) += pcie_cooling.o
>>   
>> +thermal_sys-$(CONFIG_REMOTEPROC_THERMAL) += remoteproc_cooling.o
>> +
>>   obj-$(CONFIG_K3_THERMAL)	+= k3_bandgap.o k3_j72xx_bandgap.o
>>   # platform thermal drivers
>>   obj-y				+= broadcom/
>> diff --git a/drivers/thermal/remoteproc_cooling.c b/drivers/thermal/remoteproc_cooling.c
>> new file mode 100644
>> index 000000000000..a1f948cbde0f
>> --- /dev/null
>> +++ b/drivers/thermal/remoteproc_cooling.c
>> @@ -0,0 +1,154 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Remote Processor Cooling Device
>> + *
>> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> No, that's not the right one.


will update this.


>
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/export.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of.h>
>> +#include <linux/slab.h>
>> +#include <linux/thermal.h>
>> +
>> +#define REMOTEPROC_PREFIX		"rproc_"
>> +
>> +struct remoteproc_cooling_ops {
>> +	int (*get_max_level)(void *devdata, unsigned long *level);
>> +	int (*get_cur_level)(void *devdata, unsigned long *level);
>> +	int (*set_cur_level)(void *devdata, unsigned long level);
>> +};
>> +
>> +/**
>> + * struct remoteproc_cdev - Remote processor cooling device
>> + * @cdev: Thermal cooling device handle
>> + * @ops: Vendor-specific operation callbacks
>> + * @devdata: Private data for vendor implementation
>> + * @np: Device tree node associated with this cooling device
>> + * @lock: Mutex to protect cooling device operations
>> + */
>> +struct remoteproc_cdev {
>> +	struct thermal_cooling_device *cdev;
>> +	const struct remoteproc_cooling_ops *ops;
>> +	void *devdata;
>> +	struct device_node *np;
> This is a local variable in remoteproc_cooling_register().
>
>> +	struct mutex lock;
>> +};
>> +
>> +
>> +/* Thermal cooling device callbacks */
>> +
>> +static int remoteproc_get_max_state(struct thermal_cooling_device *cdev,
>> +				    unsigned long *state)
>> +{
>> +	struct remoteproc_cdev *rproc_cdev = cdev->devdata;
>> +	int ret;
>> +
>> +	if (!rproc_cdev || !rproc_cdev->ops)
> How is this possible? Is there some race condition or something that you
> need to guard against?


Ideally this can be controlled from the calling driver only, so i can 
remove this.


>
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&rproc_cdev->lock);
>> +	ret = rproc_cdev->ops->get_max_level(rproc_cdev->devdata, state);
>> +	mutex_unlock(&rproc_cdev->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int remoteproc_get_cur_state(struct thermal_cooling_device *cdev,
>> +				    unsigned long *state)
>> +{
>> +	struct remoteproc_cdev *rproc_cdev = cdev->devdata;
>> +	int ret;
>> +
>> +	if (!rproc_cdev || !rproc_cdev->ops)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&rproc_cdev->lock);
>> +	ret = rproc_cdev->ops->get_cur_level(rproc_cdev->devdata, state);
>> +	mutex_unlock(&rproc_cdev->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int remoteproc_set_cur_state(struct thermal_cooling_device *cdev,
>> +				    unsigned long state)
>> +{
>> +	struct remoteproc_cdev *rproc_cdev = cdev->devdata;
>> +	int ret;
>> +
>> +	if (!rproc_cdev || !rproc_cdev->ops)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&rproc_cdev->lock);
>> +	ret = rproc_cdev->ops->set_cur_level(rproc_cdev->devdata, state);
>> +	mutex_unlock(&rproc_cdev->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct thermal_cooling_device_ops remoteproc_cooling_ops = {
>> +	.get_max_state = remoteproc_get_max_state,
>> +	.get_cur_state = remoteproc_get_cur_state,
>> +	.set_cur_state = remoteproc_set_cur_state,
>> +};
>> +
>> +struct remoteproc_cdev *
>> +remoteproc_cooling_register(struct device_node *np,
>> +			     const char *name, const struct remoteproc_cooling_ops *ops,
>> +			     void *devdata)
>> +{
>> +	struct remoteproc_cdev *rproc_cdev;
>> +	struct thermal_cooling_device *cdev;
>> +	int ret;
>> +
>> +	if (!name || !ops) {
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	rproc_cdev = kzalloc(sizeof(*rproc_cdev), GFP_KERNEL);
>> +	if (!rproc_cdev)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	rproc_cdev->ops = ops;
>> +	rproc_cdev->devdata = devdata;
>> +	rproc_cdev->np = np;
>> +	mutex_init(&rproc_cdev->lock);
>> +
>> +	char *rproc_name __free(kfree) =
>> +		kasprintf(GFP_KERNEL, REMOTEPROC_PREFIX "%s", name);
>> +	/* Register with thermal framework */
> Technically it's "Optionally register with thermal framework" but that's
> immediately understood by the name of the function you're calling. What
> isn't clear, and where a comment would be beneficial would be to
> document why it's optional (or rather conditional on np).


Sure will add comment.


>
>> +	if (np) {
>> +		cdev = thermal_of_cooling_device_register(np, rproc_name, rproc_cdev,
>> +							  &remoteproc_cooling_ops);
>> +	}
>> +
>> +	if (IS_ERR(cdev)) {
>> +		ret = PTR_ERR(cdev);
>> +		goto free_rproc_cdev;
>> +	}
>> +
>> +	rproc_cdev->cdev = cdev;
>> +
>> +	return rproc_cdev;
>> +
>> +free_rproc_cdev:
>> +	kfree(rproc_cdev);
>> +	return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_GPL(remoteproc_cooling_register);
>> +
>> +void remoteproc_cooling_unregister(struct remoteproc_cdev *rproc_cdev)
>> +{
>> +	if (!rproc_cdev)
>> +		return;
>> +
>> +	thermal_cooling_device_unregister(rproc_cdev->cdev);
>> +	mutex_destroy(&rproc_cdev->lock);
>> +	kfree(rproc_cdev);
>> +}
>> +EXPORT_SYMBOL_GPL(remoteproc_cooling_unregister);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Remote Processor Cooling Device");
>> diff --git a/include/linux/remoteproc_cooling.h b/include/linux/remoteproc_cooling.h
>> new file mode 100644
>> index 000000000000..ef94019d220d
>> --- /dev/null
>> +++ b/include/linux/remoteproc_cooling.h
>> @@ -0,0 +1,52 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Remote Processor Cooling Device
>> + *
>> + * Copyright (c) 2025, Qualcomm Innovation Center
> That was never the right one.
>
>> + */
>> +
>> +#ifndef __REMOTEPROC_COOLING_H__
>> +#define __REMOTEPROC_COOLING_H__
>> +
>> +#include <linux/thermal.h>
>> +
>> +struct device;
>> +struct device_node;
>> +
>> +struct remoteproc_cooling_ops {
>> +	int (*get_max_level)(void *devdata, unsigned long *level);
>> +	int (*get_cur_level)(void *devdata, unsigned long *level);
>> +	int (*set_cur_level)(void *devdata, unsigned long level);
>> +};
>> +
>> +struct remoteproc_cdev;
>> +
>> +#ifdef CONFIG_REMOTEPROC_THERMAL
>> +
>> +struct remoteproc_cdev *
>> +remoteproc_cooling_register(struct device_node *np,
>> +			     const char *name,
>> +			     const struct remoteproc_cooling_ops *ops,
>> +			     void *devdata);
>> +
>> +void remoteproc_cooling_unregister(struct remoteproc_cdev *rproc_cdev);
>> +
>> +#else /* !CONFIG_REMOTEPROC_THERMAL */
>> +
>> +static inline struct remoteproc_cdev *
>> +remoteproc_cooling_register(struct device_node *np,
>> +			     const char *name,
>> +			     const struct remoteproc_cooling_ops *ops,
>> +			     void *devdata)
>> +{
>> +	return ERR_PTR(-EINVAL);
> This means that if I build my kernel with CONFIG_REMOTEPROC_THERMAL=n it
> will not just disable remoteproc thermal management, but my remoteproc
> driver will stop probing.
>
> The remoteproc thermal feature isn't critical to the remtoeproc, so
> wouldn't it make more sense to return 0 here and let the remoteproc
> continue to operate in such configuration?


Yes it will work, as probe of this child node won't impact the remote 
proc probe, as we are not returning error condition there during 
of_platform_populate.

But yes, this should not block remote proc probe in any condition, so 
return 0 is more better option. will update this.


>
> Regards,
> Bjorn
>
>> +}
>> +
>> +static inline void
>> +remoteproc_cooling_unregister(struct remoteproc_cdev *rproc_cdev)
>> +{
>> +}
>> +
>> +#endif /* CONFIG_REMOTEPROC_THERMAL */
>> +
>> +#endif /* __REMOTEPROC_COOLING_H__ */
>> -- 
>> 2.34.1
>>

