Return-Path: <linux-pm+bounces-41668-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M/MENHyemmXAAIAu9opvQ
	(envelope-from <linux-pm+bounces-41668-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 06:40:33 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5507ABF93
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 06:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 597433019B80
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 05:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4432E9ED6;
	Thu, 29 Jan 2026 05:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ed2IbzVp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dQ9PF7Da"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730632DE6FC
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 05:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769665221; cv=none; b=eseXPEKjeL3PTYbGeKq3zcwarDUPtprW5cOIN6ZuWD20MjIhQObpL+PU4zdHBt2ogO0ul7E3YL7w1CXOrxdiKUyPoFksg9tFKElvBNoVMqtIcqXLDhLj02XrUJ+UINM+FCGE5/myAa1uQABTa2HKM7/y7laTJryOUjC/TeFhBvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769665221; c=relaxed/simple;
	bh=zittGDaEvIjaRcE3Cect8ja65nAnr6c5M4dtK4G4lJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myfHDOa55Qv8EualJsr6x/7Ba/oDjWrt5O12AtkA3Wqa2tFBFlJ5Yd6AZkWfha4LIvGVyYpNluJgbldj9bdSqWOZKkDMgC3R7MQBp4BMT8QF93YrSHGgYQAM3aWX+11cJlKsD38ee4T2y7FMvoF45O1wtAC9cKT6Vq4gbf5YnHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ed2IbzVp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dQ9PF7Da; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T2okw33143767
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 05:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+HA2CpCAmJL7x0jYx/L7D8r9FT2aT8ALDvJJGHLIlSk=; b=ed2IbzVp1v7ywrMZ
	RcZTJVJlWvRcxM7d1sb4lb9PLSnWMX+j5tUkBLbOrmyysKfXopnVzh/NPfIl/wKa
	VXblJ9Co6/qb/A1y/BwJ9EPA0i4jqudI0+gO7atJoFYvNPU8i+QC+blfBamQLFAy
	TnvxMQOEvdASx3186utcshWxQvsE2SfOYXcxFY5aVd0EQD4nAQ7PDvO4HU5VJB57
	iDbf/uQa5526DCCigO/1b7TUWKpprbGLEjFQWGpkOhTvqHUmsO5M+teQRFUuKmn9
	n4G3lcLepZVlVjb+TgzTIwG04IT5sYekYcnp/qt5snS7FQfCyee0bNnJCPpq8SVR
	aIrl4g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byqpxhny6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 05:40:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c93f0849dso656213a91.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 21:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769665217; x=1770270017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+HA2CpCAmJL7x0jYx/L7D8r9FT2aT8ALDvJJGHLIlSk=;
        b=dQ9PF7DaF01bg3zkeBXaqVu+LHZQXb9VuXeAtRThbgNirCPcbZqWd7aqF656dlejya
         bErVln/sV2EYz/o3hMWgMBn7c5jdL9WCX0GA+d4pho7eLJ4tijRafaeEbU4JdnTRtTUj
         V1VUnqXuSJiE/X2V921gS8I2X3dB74pPg6ov4yOO7PwuRTrBF9Vq50AVGF8V+oBqaQaW
         f6GPBBlqWiyfWLX+0e7h9rz1cB8kZwjUDIpFUrnDqOYaZ2JULqowMa4itI2qy7Boxck4
         kbna7VpMBg6VfKJCndOPXDacvXR+6emwOHl2tZpz0xDHaJdNMxrem6byI1D3wBIk/CJP
         fMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769665217; x=1770270017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HA2CpCAmJL7x0jYx/L7D8r9FT2aT8ALDvJJGHLIlSk=;
        b=nCmqVTuLsg06hZ8EmUnbHa9mc/QAiREmgth0qGvqX0DK4Dq2Z7QCwaKglzTHaD70KQ
         bp2h4lnQPdvs6FlRRnh0dCWB8QKYG9CJXAOPGzvLgwS8WvKwpfM43wY26fMIAf5+U3v2
         QwAJBxYH5Dx/Wqvi6RaGo6LZ5bCu8R33Nd5vIafoljICdljxzS9DMR/hC9me/oLXWzxe
         cQsxjTGf+ug9XXCo9QJIfekM4AI3xgV1fiP9atM1+Yh1CVmeS4Ha7B8DsJR0Hf7EahSH
         WyCevDYRZ5LMwCDXL9177Doexdig91eQkCkEJX7bvFcmcooXto0yr8TTb9KBUDyKogEB
         KhjA==
X-Forwarded-Encrypted: i=1; AJvYcCXEWWxyP8twCOMoBl3VuVweg1IKi+ndCiOtZU4HP3+tkztoshEsou/iR+JUjuDYYkUzJe+IEIXLwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkosNkVoz6M2U5HWhwywjpGQg1lJALV+TiiuP5zaQFHPF+fGTd
	JfL9ru7aWXN0/yF7effZ042e0nYIOspGDh5r6J75trnsfQty/9z8LcvWeRE3ksnJMKM9EjR7R9P
	224bsJ2YL0agDAEn0w5u4ta+qVJow4HMv88ARRIbpU3qXLHPMeXIQzGop2jcBCw==
X-Gm-Gg: AZuq6aI2VJStumyaf2nifd+2IgAw0otjcDXPXqfOfo7uou13Qa8V3YPhBEEfR7E6J+X
	Grda1d4M6erNoc4hWRt176/eUBSbvy4Mr7vaK5ZEMlP35Vt6amNqW8u5BT1Ov/WF8p0iH8W0iOx
	K7ZPkkVLxpQ/++mYMGfwVEfJlSFGA3Ute/eDddKn8//tNDsFiPXEUWGqL1YmND/JK+oIya1sOka
	zyuWpWPJme8JhSRG8ApluzsNuDFSFcpNvWaSEoTP7Vv+upLtVongb+QDgPDGM8aboqEpTA3FBiO
	NAAA4Npw07vBama4s/V+05me4j8HIs/+aD3kb/H9ePxilnDSkJ/WqOtlnI/HniXlfMK3T51UOsh
	EZmfTU0c+BKBkRpY9SC2tLNAIghTrKiDgomz4iTSK
X-Received: by 2002:a17:90b:4d8c:b0:352:be45:1063 with SMTP id 98e67ed59e1d1-35429ac7eebmr1579436a91.10.1769665217024;
        Wed, 28 Jan 2026 21:40:17 -0800 (PST)
X-Received: by 2002:a17:90b:4d8c:b0:352:be45:1063 with SMTP id 98e67ed59e1d1-35429ac7eebmr1579410a91.10.1769665216453;
        Wed, 28 Jan 2026 21:40:16 -0800 (PST)
Received: from [10.217.199.117] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6427e9ce16sm3738322a12.11.2026.01.28.21.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 21:40:16 -0800 (PST)
Message-ID: <7033ebe1-34d6-4845-9745-db30ceaf3d82@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 11:10:09 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/8] thermal: Add Remote Proc cooling driver
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, konradybcio@kernel.org,
        amitk@kernel.org, mani@kernel.org, casey.connolly@linaro.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-2-gaurav.kohli@oss.qualcomm.com>
 <ca326a27-a6b0-4935-ae3f-417e0d769045@oss.qualcomm.com>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <ca326a27-a6b0-4935-ae3f-417e0d769045@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BE4OXD6rTCEvxmjfytDXTfuLc-mOlzDy
X-Proofpoint-ORIG-GUID: BE4OXD6rTCEvxmjfytDXTfuLc-mOlzDy
X-Authority-Analysis: v=2.4 cv=dfSNHHXe c=1 sm=1 tr=0 ts=697af2c2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=oMbCw5YLhH7N2QicEbMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDAzMyBTYWx0ZWRfX/+8pUHSHQd/J
 RB0LDx4hvSRs1d0uzxbHOEgqLyqfZQ2g5YMa79oHErmhDyAq1YAVAxhmAZu57uVCKB/b/8S1bMX
 zbcOL2iUsm0NDAjTkw1i8l7VHJZ7L4coy4M4wekmekf5Vbipd+0so3OggfC8zKE7LdBpqlwGZ2l
 O099ZdLNCXr2OLR6eLcAkAMVcq8uUT2dRSH7XZr9hN8cW6esbqpfMXB6zylMNmKWrq0131hhaYc
 dik9UtpbZBt0LjHFUk1BGAnxcqzStQxCdlCuDtQ6jVhw8xx6OuBo43QlTh2Tqp/JRh9qb8a75zp
 ShPJl8MiU2vEuF8c+WT0QUkvz5r6Z8XtoU9idEVYR4XK9Gy0pPYDZEiiMvdX3R+qdgysij7rx9u
 LBwJl1BlqtY29002lcVva4/dU5PzCJKvM5Uk4HrX+MsG46XRrGoHh0G++vtm+LT12S2HoKIiXPd
 FBqjf7W+G7QjvKzOrRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290033
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41668-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaurav.kohli@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C5507ABF93
X-Rspamd-Action: no action


On 1/8/2026 5:29 PM, Zhongqiu Han wrote:
> On 12/23/2025 8:32 PM, Gaurav Kohli wrote:
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
>>   MAINTAINERS                          |   8 ++
>>   drivers/thermal/Kconfig              |  11 ++
>>   drivers/thermal/Makefile             |   2 +
>>   drivers/thermal/remoteproc_cooling.c | 154 +++++++++++++++++++++++++++
>>   include/linux/remoteproc_cooling.h   |  52 +++++++++
>>   5 files changed, 227 insertions(+)
>>   create mode 100644 drivers/thermal/remoteproc_cooling.c
>>   create mode 100644 include/linux/remoteproc_cooling.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 679e5f11e672..c1ba87315cdf 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -25935,6 +25935,14 @@ F:    drivers/thermal/cpufreq_cooling.c
>>   F:    drivers/thermal/cpuidle_cooling.c
>>   F:    include/linux/cpu_cooling.h
>>   +THERMAL/REMOTEPROC_COOLING
>> +M:    Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> +L:    linux-pm@vger.kernel.org
>> +S:    Supported
>> +F:    drivers/thermal/remoteproc_cooling.c
>> +F:    include/linux/remoteproc_cooling.h
>> +
>> +
>>   THERMAL/POWER_ALLOCATOR
>>   M:    Lukasz Luba <lukasz.luba@arm.com>
>>   L:    linux-pm@vger.kernel.org
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index b10080d61860..31e92be34387 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -229,6 +229,17 @@ config PCIE_THERMAL
>>           If you want this support, you should say Y here.
>>   +
>> +config REMOTEPROC_THERMAL
>> +    bool "Remote processor cooling support"
>
> Hi Gaurav,
>
> May I know any depends here?


Thanks for review.

Apologies for the late reply,  this was missed on my end.

This does not require a dependency, as error check is there for cooling 
registration api.


>
>> +    help
>> +      This implements a generic cooling mechanism for remote processors
>> +      (modem, DSP, etc.) that allows vendor-specific implementations to
>> +      register thermal cooling devices and provide callbacks for 
>> thermal
>> +      mitigation.
>> +
>> +      If you want this support, you should say Y here.
>> +
>>   config THERMAL_EMULATION
>>       bool "Thermal emulation mode support"
>>       help
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index bb21e7ea7fc6..ae747dde54fe 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -34,6 +34,8 @@ thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += 
>> devfreq_cooling.o
>>     thermal_sys-$(CONFIG_PCIE_THERMAL) += pcie_cooling.o
>>   +thermal_sys-$(CONFIG_REMOTEPROC_THERMAL) += remoteproc_cooling.o
>> +
>>   obj-$(CONFIG_K3_THERMAL)    += k3_bandgap.o k3_j72xx_bandgap.o
>>   # platform thermal drivers
>>   obj-y                += broadcom/
>> diff --git a/drivers/thermal/remoteproc_cooling.c 
>> b/drivers/thermal/remoteproc_cooling.c
>> new file mode 100644
>> index 000000000000..a1f948cbde0f
>> --- /dev/null
>> +++ b/drivers/thermal/remoteproc_cooling.c
>> @@ -0,0 +1,154 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Remote Processor Cooling Device
>> + *
>> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights 
>> reserved.
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
>> +#define REMOTEPROC_PREFIX        "rproc_"
>> +
>> +struct remoteproc_cooling_ops {
>> +    int (*get_max_level)(void *devdata, unsigned long *level);
>> +    int (*get_cur_level)(void *devdata, unsigned long *level);
>> +    int (*set_cur_level)(void *devdata, unsigned long level);
>> +};
> It's better to have a document to explain member?
>
> And may I know why double define here(another is in .h file)? should it
> include .h file remoteproc_cooling.h ?
>

Sure, i will add comment for each callback and will fix this double 
definition.


>
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
>> +    struct thermal_cooling_device *cdev;
>> +    const struct remoteproc_cooling_ops *ops;
>> +    void *devdata;
>> +    struct device_node *np;
>> +    struct mutex lock;
>> +};
>> +
>> +
>> +/* Thermal cooling device callbacks */
>> +
>> +static int remoteproc_get_max_state(struct thermal_cooling_device 
>> *cdev,
>> +                    unsigned long *state)
>> +{
>> +    struct remoteproc_cdev *rproc_cdev = cdev->devdata;
>> +    int ret;
>> +
>> +    if (!rproc_cdev || !rproc_cdev->ops)
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&rproc_cdev->lock);
>> +    ret = rproc_cdev->ops->get_max_level(rproc_cdev->devdata, state);
>> +    mutex_unlock(&rproc_cdev->lock);
>> +
>> +    return ret;
>> +}
>> +
>> +static int remoteproc_get_cur_state(struct thermal_cooling_device 
>> *cdev,
>> +                    unsigned long *state)
>> +{
>> +    struct remoteproc_cdev *rproc_cdev = cdev->devdata;
>> +    int ret;
>> +
>> +    if (!rproc_cdev || !rproc_cdev->ops)
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&rproc_cdev->lock);
>> +    ret = rproc_cdev->ops->get_cur_level(rproc_cdev->devdata, state);
>> +    mutex_unlock(&rproc_cdev->lock);
>> +
>> +    return ret;
>> +}
>> +
>> +static int remoteproc_set_cur_state(struct thermal_cooling_device 
>> *cdev,
>> +                    unsigned long state)
>> +{
>> +    struct remoteproc_cdev *rproc_cdev = cdev->devdata;
>> +    int ret;
>> +
>> +    if (!rproc_cdev || !rproc_cdev->ops)
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&rproc_cdev->lock);
>> +    ret = rproc_cdev->ops->set_cur_level(rproc_cdev->devdata, state);
>> +    mutex_unlock(&rproc_cdev->lock);
>> +
>> +    return ret;
>> +}
>> +
>> +static const struct thermal_cooling_device_ops 
>> remoteproc_cooling_ops = {
>> +    .get_max_state = remoteproc_get_max_state,
>> +    .get_cur_state = remoteproc_get_cur_state,
>> +    .set_cur_state = remoteproc_set_cur_state,
>> +};
>> +
>> +struct remoteproc_cdev *
>> +remoteproc_cooling_register(struct device_node *np,
>> +                 const char *name, const struct 
>> remoteproc_cooling_ops *ops,
>> +                 void *devdata)
>> +{
>> +    struct remoteproc_cdev *rproc_cdev;
>> +    struct thermal_cooling_device *cdev;
>> +    int ret;
>> +
>> +    if (!name || !ops) {
>> +        return ERR_PTR(-EINVAL);
>> +    }
>> +
>
> May I know which ops callbacks are required and which are optional?
> If the callback is optional, should we check for null before calling it?
>

Actually all are mandatory for cooling api, will put null check for all 
to be on safer side.


>
>> +    rproc_cdev = kzalloc(sizeof(*rproc_cdev), GFP_KERNEL);
>> +    if (!rproc_cdev)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    rproc_cdev->ops = ops;
>> +    rproc_cdev->devdata = devdata;
>> +    rproc_cdev->np = np;
>> +    mutex_init(&rproc_cdev->lock);
>> +
>> +    char *rproc_name __free(kfree) =
>> +        kasprintf(GFP_KERNEL, REMOTEPROC_PREFIX "%s", name);
>
> It should have a NULL check when alloc memory.
>
>

Thanks for pointing this, will update this.


>> +    /* Register with thermal framework */
>> +    if (np) {
>> +        cdev = thermal_of_cooling_device_register(np, rproc_name, 
>> rproc_cdev,
>> +                              &remoteproc_cooling_ops);
>> +    }
>> +
>> +    if (IS_ERR(cdev)) {
>> +        ret = PTR_ERR(cdev);
>> +        goto free_rproc_cdev;
>> +    }
>> +
>> +    rproc_cdev->cdev = cdev;
>> +
>> +    return rproc_cdev;
>> +
>> +free_rproc_cdev:
>> +    kfree(rproc_cdev);
>> +    return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_GPL(remoteproc_cooling_register);
>> +
>> +void remoteproc_cooling_unregister(struct remoteproc_cdev *rproc_cdev)
>> +{
>> +    if (!rproc_cdev)
>> +        return;
>> +
>> +    thermal_cooling_device_unregister(rproc_cdev->cdev);
>> +    mutex_destroy(&rproc_cdev->lock);
>> +    kfree(rproc_cdev);
>> +}
>> +EXPORT_SYMBOL_GPL(remoteproc_cooling_unregister);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Remote Processor Cooling Device");
>> diff --git a/include/linux/remoteproc_cooling.h 
>> b/include/linux/remoteproc_cooling.h
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
>> +    int (*get_max_level)(void *devdata, unsigned long *level);
>> +    int (*get_cur_level)(void *devdata, unsigned long *level);
>> +    int (*set_cur_level)(void *devdata, unsigned long level);
>> +};
>> +
>> +struct remoteproc_cdev;
>> +
>> +#ifdef CONFIG_REMOTEPROC_THERMAL
>> +
>> +struct remoteproc_cdev *
>> +remoteproc_cooling_register(struct device_node *np,
>> +                 const char *name,
>> +                 const struct remoteproc_cooling_ops *ops,
>> +                 void *devdata);
>> +
>> +void remoteproc_cooling_unregister(struct remoteproc_cdev *rproc_cdev);
>> +
>> +#else /* !CONFIG_REMOTEPROC_THERMAL */
>> +
>> +static inline struct remoteproc_cdev *
>> +remoteproc_cooling_register(struct device_node *np,
>> +                 const char *name,
>> +                 const struct remoteproc_cooling_ops *ops,
>> +                 void *devdata)
>> +{
>> +    return ERR_PTR(-EINVAL);
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
>
>

