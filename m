Return-Path: <linux-pm+bounces-40078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 037C8CEB571
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 07:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64FE3301394C
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 06:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2FA310652;
	Wed, 31 Dec 2025 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W4TiuM9A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kWq+Pruc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE405310636
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 06:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767162505; cv=none; b=fjWNLFhpTpJps5w78EAFTxgt3tp65plqJLLOF/V60uPJT2RPGyPvTDfb53xkonSsziBlY9VqWbocZo3D6YF/4CYuEYcXFrtnckrQ3+Bh5QrM46o68c1fCvoFv1vEKaBKEOmykSdR8QwToQ9LVdbUrLr5NmxuO1Y8/AFmBYqfyRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767162505; c=relaxed/simple;
	bh=RAEJkzafLY8pvzvD4GezBDA0X67JkBoKZpTjmCvXKsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YednETHg0uS9Cffb3hr1H/eTOQOJDz0r7tUeMv3sEfJi13Kt3HbnGFR6hsgmyRcIY6YT4YW8+xB0XAlvSoYyKlrv1X9xpso1bsA7f3SZN/pHqU+x7SuD970VXlcH+dQhWUtmTBer8ibcGFHVVeuyHWkQRrX3juQYPS60ApjKAC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W4TiuM9A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kWq+Pruc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUKsKaP526459
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 06:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Au6pLFrUOMCxWOP+nqQQw4AUz/dv19GOEFWm9aVO0mY=; b=W4TiuM9AUqD0wX86
	E9v0J3kx78Y/UXx3SonvAGm8JDLQzzwptDvDAHellelYbmUD5IsnLihelGVjhwZK
	qUM3rM17QpG9e+WzOAfQ6lOyLq8ahc5Qny1Z70YlL+6ST7+b0qJkk+wgWaoNJUHS
	k7faFOHN/v37S1wKX2CD3kEM6h6cPWyZLRU6xLMnyd+rijexCBJU3xwJs9qGbfIs
	bsu5zv/NFPmesx81zvtbCLJvvFupuIzNoxPrcQ3hds3CtgbdYe8rN3Oil5LaXLGd
	R0SAEA81/xxwZvcbNwsIFDdKtQjL4JPoYXKIRam4yFsJRBK+BqgCGe9XGAsQo64D
	F/liVQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc0sgupvj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 06:28:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f2381ea85so224479095ad.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 22:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767162500; x=1767767300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Au6pLFrUOMCxWOP+nqQQw4AUz/dv19GOEFWm9aVO0mY=;
        b=kWq+Pruc6m6txgp4g0yaEv6mVq6lPU98FEr3RHxRSUNE5E9j72LPow+UhToyCbg222
         3wWPfm/vFzzkh0fJQLJhS5H6V1ITAGYSiQ4LXHVDtlzk2+EgOhy6dsD60Y5MuiDUbKeK
         l4NvWwBN0FjGZ3XFGPEgT7TT+4/fO6RX53HyKdmkN+Ak2DFJgFNrlmCdAoSu/FpC83PW
         hSppv5xMvqR+hM5hxetmGZANsochuuNEC8B7hx/Fu9vgG9/9dtZEgnI0X4axeoNbc5Gz
         UXywBDMoos0EPVBLNyQul5DIwtyVcGPR+0rHpIXfJFbF4LV5NVdtjE18iFo2lAaRSu5e
         vezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767162500; x=1767767300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Au6pLFrUOMCxWOP+nqQQw4AUz/dv19GOEFWm9aVO0mY=;
        b=V+GlKn+1CcTLdYfQcPDQcYDWuOWmUCP4TJvcGwsF3a5HIcmFnRbgRpeWXaNdhbv6l6
         Ki8Ec08RG12ZIXGZfn4onE6AtRIyeIQgBWh8RAVHFYl3VfjMWRrHUBHpurKNuq8plEdn
         tTLTOgVpqWbDor6jumXnffLQt7P9zl5VLkYxejk2GOPLRSYnywH33hkMEWkjbbSC0/6y
         lwT9p44Btv4p6w1wTlwGyVARikvVjdN2COb5yvQCbz6OQnw/0lm/xkSZWsGvLbx9KVus
         2Oe1XSZE6jXrbY2prEhv4aE7w8wLjIJKSb/CzQW3avJO/aTrXvNCOCVVK/jmkYIEbyPx
         LK3g==
X-Forwarded-Encrypted: i=1; AJvYcCX0MDCQPp2lYJoapnXsIxUibSLbWzXN8qdwsrRg5toDKMyqQG5uU4F/VEcKMRPcTeSQQcrFwP4LmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJwHtG8cUwVi7I34lnw0k12kQlyNXOJ6XQWX1UdI/12/DegVZh
	YncZUH7V4BcH8pxdzxQT+HJjmfCMoNHx3WwhvG/YCg+sN4+YJYdIm/BZ/Jby6cJWqbKZMgYJlsn
	QSB/YEp7c3DtCi2oPnF+XXmJl7V0RC5dQ3Io7lEHRYJGZMBaOmIib4U05OgJEBA==
X-Gm-Gg: AY/fxX5xWRRJDVJ4dZn5iAWWWg+Aww7AST1t53O/kGcm9pID/ene1lqi7mn41XOBFMJ
	nRz9o/DnN7BGGaigQ76hFF+ldbMVJMbmrZh/T3jhAnNfTzhsCVErLUzJa7rKNOi0Cbuo4167iG1
	NHFfMF7w8d66wFg6hODRdumyDVpw1yY9B4YDopJguxSSKi9FpWBej8JaImhvLFJLr2bHaAzHVvv
	EXE291aDAYy52UfS5ZHDy3NTMokNP/zVTS8fnluLfDLY1piXCvDrJ71qobjJ/s32H2593NtELPv
	f/pGMypnkvzSW7JqmTTZnYX9eGOILi4eOPeoWeEsUOOGqUphffD230Z/mzam9gVvC6/cSEi6syg
	2+WSInp1ZG0MtVNInWtHdn5p+I1JJR0kewxRXOpfXIw==
X-Received: by 2002:a17:903:1b65:b0:297:e69d:86ac with SMTP id d9443c01a7336-2a2f2836516mr359415475ad.39.1767162500312;
        Tue, 30 Dec 2025 22:28:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3KmFoS0r0s4yYqATzSmXuX88ltxwdl5N4efYLdRLdcFQmAX7jw9qzlYovClDLTBx7qyQk4A==
X-Received: by 2002:a17:903:1b65:b0:297:e69d:86ac with SMTP id d9443c01a7336-2a2f2836516mr359415265ad.39.1767162499717;
        Tue, 30 Dec 2025 22:28:19 -0800 (PST)
Received: from [192.168.1.11] ([106.222.232.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dcc7c8sm34643568a91.15.2025.12.30.22.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 22:28:19 -0800 (PST)
Message-ID: <f3013c96-673f-4a7c-8296-d4d7d0ec2a44@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 11:58:13 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/8] thermal: qcom: add qmi-cooling driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        konradybcio@kernel.org, amitk@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-5-gaurav.kohli@oss.qualcomm.com>
 <gp5alhoqcty3nqj5jgm33nzytjtqp35pq6ycefxyvubqoggjqk@ndip4esdd6oi>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <gp5alhoqcty3nqj5jgm33nzytjtqp35pq6ycefxyvubqoggjqk@ndip4esdd6oi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDA1MyBTYWx0ZWRfX1Fd9/JdoP7dV
 18Ylb8/rbC/IrbgGF5p0RMs95rvgP6HFsw9Dh1f1jBIVmu0HTfjScr6z7hYAPAi6Bia6VXr4pQB
 0uZAuWnKCAhBerKaSzf+kumYyKJl/hHZ9nIUm2S5l3X4CXYWiGnPgQ/qQbYeOlEUDzMUGInm4ed
 1BzH/7ddu1f3CfEIX+41SsPPjUG/dRGWnb77eXuwiachjL+p82wlUwaOS+LOfnq3FZLQ+7Qeiyj
 /dByqDJPvYZQEvfMHORLJz6/d7XHcQIbH+wzr4zbktZO2kETSRJ45VQRenDBN0dOLkdJ0n0ooOl
 nOfrQjSv5z34U0aMVzZD5YF3M5I8bE83xzLVvOHTs84GFkAV0Meeh/OGTh/k2WIhmFzxiudtpP4
 PvHutxJOZv6S1yI3J2sqNnZmaEkUza5ZDmgXM15w9eftz9nF2yGRTBGEn5VsWWFYvl6DKm55GNR
 zkKPw5tAlr63iVB2r8Q==
X-Proofpoint-GUID: ZemG1cp-at7LP335hNcC8i9KK7X96cG7
X-Proofpoint-ORIG-GUID: ZemG1cp-at7LP335hNcC8i9KK7X96cG7
X-Authority-Analysis: v=2.4 cv=foHRpV4f c=1 sm=1 tr=0 ts=6954c285 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=pk+8NuH2X28N4C0eta/h1Q==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=IiptomdJC7LAVO-t1HUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310053


On 12/24/2025 1:19 AM, Dmitry Baryshkov wrote:
> On Tue, Dec 23, 2025 at 06:02:23PM +0530, Gaurav Kohli wrote:
>> From: Casey Connolly <casey.connolly@linaro.org>
>>
>> The Thermal Mitigation Device (TMD) service exposes various platform
>> specific thermal mitigations available on remote subsystems (ie the
>> modem and cdsp). The service is exposed via the QMI messaging
>> interface, usually over the QRTR transport.
>>
>> Qualcomm QMI-based TMD cooling devices are used to mitigate thermal
>> conditions across multiple remote subsystems. These devices operate
>> based on junction temperature sensors (TSENS) associated with thermal
>> zones for each subsystem.
>>
>> Co-developed-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   drivers/soc/qcom/Kconfig           |  13 +
>>   drivers/soc/qcom/Makefile          |   1 +
>>   drivers/soc/qcom/qmi-cooling.c     | 498 +++++++++++++++++++++++++++++
>>   drivers/soc/qcom/qmi-cooling.h     | 428 +++++++++++++++++++++++++
>>   drivers/thermal/qcom/qmi-cooling.h | 428 +++++++++++++++++++++++++
>>   5 files changed, 1368 insertions(+)
>>   create mode 100644 drivers/soc/qcom/qmi-cooling.c
>>   create mode 100644 drivers/soc/qcom/qmi-cooling.h
>>   create mode 100644 drivers/thermal/qcom/qmi-cooling.h
>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 2caadbbcf830..905a24b42fe6 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -124,6 +124,19 @@ config QCOM_PMIC_GLINK
>>   	  Say yes here to support USB-C and battery status on modern Qualcomm
>>   	  platforms.
>>   
>> +config QCOM_QMI_COOLING
>> +	tristate "Qualcomm QMI cooling drivers"
>> +	depends on QCOM_RPROC_COMMON
>> +	depends on ARCH_QCOM || COMPILE_TEST
>> +	select QCOM_QMI_HELPERS
>> +	help
>> +	   This enables the remote subsystem cooling devices. These cooling
>> +	   devices will be used by Qualcomm chipset to place various remote
>> +	   subsystem mitigations like remote processor passive mitigation,
>> +	   remote subsystem voltage restriction at low temperatures etc.
>> +	   The QMI cooling device will interface with remote subsystem
>> +	   using Qualcomm remoteproc interface.
>> +
>>   config QCOM_QMI_HELPERS
>>   	tristate
>>   	depends on NET
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index b7f1d2a57367..b6728f54944b 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -14,6 +14,7 @@ obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink.o
>>   obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink_altmode.o
>>   obj-$(CONFIG_QCOM_PMIC_PDCHARGER_ULOG)	+= pmic_pdcharger_ulog.o
>>   CFLAGS_pmic_pdcharger_ulog.o	:=  -I$(src)
>> +obj-$(CONFIG_QCOM_QMI_COOLING) += qmi-cooling.o
>>   obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
>>   qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
>>   obj-$(CONFIG_QCOM_RAMP_CTRL)	+= ramp_controller.o
>> diff --git a/drivers/soc/qcom/qmi-cooling.c b/drivers/soc/qcom/qmi-cooling.c
>> new file mode 100644
>> index 000000000000..1a6afcb96bf6
>> --- /dev/null
>> +++ b/drivers/soc/qcom/qmi-cooling.c
>> @@ -0,0 +1,498 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2017, The Linux Foundation
>> + * Copyright (c) 2025, Linaro Limited
>> + *
>> + * QMI Thermal Mitigation Device (TMD) client driver.
>> + * This driver provides an in-kernel client to handle hot and cold thermal
>> + * mitigations for remote subsystems (modem and DSPs) running the TMD service.
>> + * It doesn't implement any handling of reports from remote subsystems.
>> + */
>> +
>> +#include <linux/cleanup.h>
>> +#include <linux/err.h>
>> +#include <linux/module.h>
>> +#include <linux/net.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/remoteproc/qcom_rproc.h>
>> +#include <linux/remoteproc_cooling.h>
>> +#include <linux/slab.h>
>> +#include <linux/soc/qcom/qmi.h>
>> +#include <linux/thermal.h>
>> +
>> +#include "qmi-cooling.h"
>> +
>> +#define MODEM0_INSTANCE_ID	0x0
>> +#define ADSP_INSTANCE_ID	0x1
>> +#define CDSP_INSTANCE_ID	0x43
> Will CDSP1 also use instance ID? What are instance IDs for GPDSP?


In Leman's there are two different cdsp subsytem, i will add new 
instance id for that also.

What is GPdsp, you mean gpu ?


>> +#define SLPI_INSTANCE_ID	0x53
>> +
>> +#define QMI_TMD_RESP_TIMEOUT msecs_to_jiffies(100)
>> +
>> +/**
>> + * struct qmi_tmd_client - TMD client state
>> + * @dev:	Device associated with this client
>> + * @name:	Friendly name for the remote TMD service
>> + * @handle:	QMI connection handle
>> + * @mutex:	Lock to synchronise QMI communication
>> + * @id:		The QMI TMD service instance ID
>> + * @cdev_list:	The list of cooling devices (controls) enabled for this instance
>> + * @svc_arrive_work: Work item for initialising the client when the TMD service
>> + *		     starts.
>> + * @connection_active: Whether or not we're connected to the QMI TMD service
>> + */
>> +struct qmi_tmd_client {
>> +	struct device *dev;
>> +	const char *name;
>> +	struct qmi_handle handle;
>> +	struct mutex mutex;
>> +	u32 id;
>> +	struct list_head cdev_list;
>> +	struct work_struct svc_arrive_work;
>> +	bool connection_active;
>> +};
>> +
>> +/**
>> + * struct qmi_tmd - A TMD cooling device
>> + * @np:		OF node associated with this control
>> + * @type:	The control type (exposed via sysfs)
>> + * @qmi_name:	The common name of this control shared by the remote subsystem
>> + * @rproc_cdev:	Remote processor cooling device handle
>> + * @cur_state:	The current cooling/warming/mitigation state
>> + * @max_state:	The maximum state
>> + * @client:	The TMD client instance this control is associated with
>> + */
>> +struct qmi_tmd {
>> +	struct device_node *np;
>> +	const char *type;
>> +	char qmi_name[QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1];
>> +	struct list_head node;
>> +	struct remoteproc_cdev *rproc_cdev;
>> +	unsigned int cur_state;
>> +	unsigned int max_state;
>> +	struct qmi_tmd_client *client;
>> +};
>> +
>> +/**
>> + * struct qmi_instance_id - QMI instance match data
>> + * @id:		The QMI instance ID
>> + * @name:	Friendly name for this instance
>> + */
>> +struct qmi_instance_data {
>> +	u32 id;
>> +	const char *name;
>> +};
>> +
>> +/* Notify the remote subsystem of the requested cooling state */
>> +static int qmi_tmd_send_state_request(struct qmi_tmd *tmd)
>> +{
>> +	struct tmd_set_mitigation_level_resp_msg_v01 tmd_resp = { 0 };
>> +	struct tmd_set_mitigation_level_req_msg_v01 req = { 0 };
>> +	struct qmi_tmd_client *client;
>> +	struct qmi_txn txn;
>> +	int ret = 0;
>> +
>> +	client = tmd->client;
>> +
>> +	guard(mutex)(&client->mutex);
>> +
>> +	/*
>> +	 * This function is called by qmi_set_cur_state() which does not know if
>> +	 * the QMI service is actually online. If it isn't then we noop here.
>> +	 * The state is cached in tmd->cur_state and will be broadcast via
>> +	 * qmi_tmd_init_control() when the service comes up.
>> +	 */
>> +	if (!client->connection_active)
>> +		return 0;
>> +
>> +	strscpy(req.mitigation_dev_id.mitigation_dev_id, tmd->qmi_name,
>> +		QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1);
>> +	req.mitigation_level = tmd->cur_state;
>> +
>> +	ret = qmi_txn_init(&client->handle, &txn,
>> +			   tmd_set_mitigation_level_resp_msg_v01_ei, &tmd_resp);
>> +	if (ret < 0) {
>> +		dev_err(client->dev, "qmi set state %d txn init failed for %s ret %d\n",
>> +			tmd->cur_state, tmd->type, ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = qmi_send_request(&client->handle, NULL, &txn,
>> +			       QMI_TMD_SET_MITIGATION_LEVEL_REQ_V01,
>> +			       TMD_SET_MITIGATION_LEVEL_REQ_MSG_V01_MAX_MSG_LEN,
>> +			       tmd_set_mitigation_level_req_msg_v01_ei, &req);
>> +	if (ret < 0) {
>> +		dev_err(client->dev, "qmi set state %d txn send failed for %s ret %d\n",
>> +			tmd->cur_state, tmd->type, ret);
>> +		qmi_txn_cancel(&txn);
>> +		return ret;
>> +	}
>> +
>> +	ret = qmi_txn_wait(&txn, QMI_TMD_RESP_TIMEOUT);
>> +	if (ret < 0) {
>> +		dev_err(client->dev, "qmi set state %d txn wait failed for %s ret %d\n",
>> +			tmd->cur_state, tmd->type, ret);
>> +		return ret;
>> +	}
>> +
>> +	if (tmd_resp.resp.result != QMI_RESULT_SUCCESS_V01) {
>> +		ret = -tmd_resp.resp.result;
>> +		dev_err(client->dev, "qmi set state %d NOT success for %s ret %d\n",
>> +			tmd->cur_state, tmd->type, ret);
>> +		return ret;
>> +	}
>> +
>> +	dev_dbg(client->dev, "Requested state %d/%d for %s\n", tmd->cur_state,
>> +		tmd->max_state, tmd->type);
>> +
>> +	return 0;
>> +}
>> +
>> +static int qmi_get_max_level(void *devdata, unsigned long *level)
>> +{
>> +	struct qmi_tmd *tmd = devdata;
>> +
>> +	if (!tmd)
>> +		return -EINVAL;
>> +
>> +	*level = tmd->max_state;
>> +
>> +	return 0;
>> +}
>> +
>> +static int qmi_get_cur_level(void *devdata, unsigned long *level)
>> +{
>> +	struct qmi_tmd *tmd = devdata;
>> +
>> +	if (!tmd)
>> +		return -EINVAL;
>> +
>> +	*level = tmd->cur_state;
>> +
>> +	return 0;
>> +}
>> +
>> +static int qmi_set_cur_level(void *devdata, unsigned long level)
>> +{
>> +	struct qmi_tmd *tmd = devdata;
>> +
>> +	if (!tmd)
>> +		return -EINVAL;
>> +
>> +	if (level > tmd->max_state)
>> +		return -EINVAL;
>> +
>> +	if (tmd->cur_state == level)
>> +		return 0;
>> +
>> +	tmd->cur_state = level;
>> +
>> +	return qmi_tmd_send_state_request(tmd);
>> +}
>> +
>> +static const struct remoteproc_cooling_ops qmi_rproc_ops = {
>> +	.get_max_level = qmi_get_max_level,
>> +	.get_cur_level = qmi_get_cur_level,
>> +	.set_cur_level = qmi_set_cur_level,
>> +};
>> +
>> +static int qmi_register_cooling_device(struct qmi_tmd *tmd)
>> +{
>> +	struct remoteproc_cdev *rproc_cdev;
>> +
>> +	rproc_cdev = remoteproc_cooling_register(tmd->np,
>> +						 tmd->type,
>> +						 &qmi_rproc_ops,
>> +						 tmd);
>> +
>> +	if (IS_ERR(rproc_cdev))
>> +		return dev_err_probe(tmd->client->dev, PTR_ERR(rproc_cdev),
>> +				     "Failed to register cooling device %s\n",
>> +				     tmd->qmi_name);
> This is being executed outside of the probe() path. What is the point of
> calling dev_err_probe() here?
>
>> +
>> +	tmd->rproc_cdev = rproc_cdev;
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Init a single TMD control by registering a cooling device for it, or
>> + * synchronising state with the remote subsystem if recovering from a service
>> + * restart. This is called when the TMD service starts up.
>> + */
>> +static int qmi_tmd_init_control(struct qmi_tmd_client *client, const char *label,
>> +				u8 max_state)
>> +{
>> +	struct qmi_tmd *tmd = NULL;
>> +
>> +	list_for_each_entry(tmd, &client->cdev_list, node)
>> +		if (!strncasecmp(tmd->qmi_name, label,
>> +				 QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1))
>> +			goto found;
>> +
>> +	dev_dbg(client->dev,
>> +		"TMD '%s' available in firmware but not specified in DT\n",
>> +		label);
>> +	return 0;
>> +
>> +found:
>> +	tmd->max_state = max_state;
>> +	/*
>> +	 * If the cooling device already exists then the QMI service went away and
>> +	 * came back. So just make sure the current cooling device state is
>> +	 * reflected on the remote side and then return.
>> +	 */
>> +	if (tmd->rproc_cdev)
>> +		return qmi_tmd_send_state_request(tmd);
>> +
>> +	return qmi_register_cooling_device(tmd);
>> +}
>> +
>> +/*
>> + * When the QMI service starts up on a remote subsystem this function will fetch
>> + * the list of TMDs on the subsystem, match it to the TMDs specified in devicetree
>> + * and call qmi_tmd_init_control() for each
>> + */
>> +static void qmi_tmd_svc_arrive(struct work_struct *work)
>> +{
>> +	struct qmi_tmd_client *client =
>> +		container_of(work, struct qmi_tmd_client, svc_arrive_work);
>> +
>> +	struct tmd_get_mitigation_device_list_req_msg_v01 req = { 0 };
>> +	struct tmd_get_mitigation_device_list_resp_msg_v01 *resp __free(kfree);
>> +	int ret = 0, i;
>> +	struct qmi_txn txn;
>> +
>> +	/* resp struct is 1.1kB, allocate it on the heap. */
>> +	resp = kzalloc(sizeof(*resp), GFP_KERNEL);
>> +	if (!resp)
>> +		return;
>> +
>> +	/* Get a list of TMDs supported by the remoteproc */
>> +	scoped_guard(mutex, &client->mutex) {
>> +		ret = qmi_txn_init(&client->handle, &txn,
>> +				tmd_get_mitigation_device_list_resp_msg_v01_ei, resp);
>> +		if (ret < 0) {
>> +			dev_err(client->dev,
>> +				"Transaction init error for instance_id: %#x ret %d\n",
>> +				client->id, ret);
>> +			return;
>> +		}
>> +
>> +		ret = qmi_send_request(&client->handle, NULL, &txn,
>> +				QMI_TMD_GET_MITIGATION_DEVICE_LIST_REQ_V01,
>> +				TMD_GET_MITIGATION_DEVICE_LIST_REQ_MSG_V01_MAX_MSG_LEN,
>> +				tmd_get_mitigation_device_list_req_msg_v01_ei, &req);
>> +		if (ret < 0) {
>> +			qmi_txn_cancel(&txn);
>> +			return;
>> +		}
>> +
>> +		ret = qmi_txn_wait(&txn, QMI_TMD_RESP_TIMEOUT);
> So, we are waiting with the mutex held. What if the remote proc crashes
> and restarts _while_ we are waiting here?
>
>> +		if (ret < 0) {
>> +			dev_err(client->dev, "Transaction wait error for client %#x ret:%d\n",
>> +				client->id, ret);
>> +			return;
>> +		}
>> +		if (resp->resp.result != QMI_RESULT_SUCCESS_V01) {
>> +			ret = resp->resp.result;
>> +			dev_err(client->dev, "Failed to get device list for client %#x ret:%d\n",
>> +				client->id, ret);
>> +			return;
>> +		}
>> +
>> +		client->connection_active = true;
>> +	}
>> +
>> +	for (i = 0; i < resp->mitigation_device_list_len; i++) {
>> +		struct tmd_mitigation_dev_list_type_v01 *device =
>> +			&resp->mitigation_device_list[i];
>> +
>> +		ret = qmi_tmd_init_control(client,
>> +					   device->mitigation_dev_id.mitigation_dev_id,
>> +					   device->max_mitigation_level);
>> +		if (ret)
>> +			break;
>> +	}
>> +}
>> +
>> +static void thermal_qmi_net_reset(struct qmi_handle *qmi)
>> +{
>> +	struct qmi_tmd_client *client = container_of(qmi, struct qmi_tmd_client, handle);
>> +	struct qmi_tmd *tmd = NULL;
>> +
>> +	list_for_each_entry(tmd, &client->cdev_list, node) {
>> +		qmi_tmd_send_state_request(tmd);
>> +	}
> Useless braces, please drop.


sure, will fix this.


>
>> +}
>> +
>> +static void thermal_qmi_del_server(struct qmi_handle *qmi, struct qmi_service *service)
>> +{
>> +	struct qmi_tmd_client *client = container_of(qmi, struct qmi_tmd_client, handle);
>> +
>> +	scoped_guard(mutex, &client->mutex)
>> +		client->connection_active = false;
>> +}
>> +
>> +static int thermal_qmi_new_server(struct qmi_handle *qmi, struct qmi_service *service)
>> +{
>> +	struct qmi_tmd_client *client = container_of(qmi, struct qmi_tmd_client, handle);
>> +	struct sockaddr_qrtr sq = { AF_QIPCRTR, service->node, service->port };
> C99, please.
>
>> +
>> +	scoped_guard(mutex, &client->mutex)
>> +		kernel_connect(qmi->sock, (struct sockaddr_unsized *)&sq, sizeof(sq), 0);
>> +
>> +	queue_work(system_highpri_wq, &client->svc_arrive_work);
> Why?


this function indicates that qmi service is up, but post that there is 
lot of work like query available tmd devices in remote subsystem and 
then registration

  with cooling framework.


>
>> +
>> +	return 0;
>> +}
>> +
>> +static struct qmi_ops thermal_qmi_event_ops = {
>> +	.new_server = thermal_qmi_new_server,
>> +	.del_server = thermal_qmi_del_server,
>> +	.net_reset = thermal_qmi_net_reset,
>> +};
>> +
>> +static void qmi_tmd_cleanup(struct qmi_tmd_client *client)
>> +{
>> +	struct qmi_tmd *tmd, *c_next;
>> +
>> +	guard(mutex)(&client->mutex);
>> +
>> +	client->connection_active = false;
>> +
>> +	qmi_handle_release(&client->handle);
>> +	cancel_work(&client->svc_arrive_work);
>> +	list_for_each_entry_safe(tmd, c_next, &client->cdev_list, node) {
>> +		if (tmd->rproc_cdev)
>> +			remoteproc_cooling_unregister(tmd->rproc_cdev);
>> +
>> +		list_del(&tmd->node);
>> +	}
>> +}
>> +
>> +/* Parse the controls and allocate a qmi_tmd for each of them */
>> +static int qmi_tmd_alloc_cdevs(struct qmi_tmd_client *client)
>> +{
>> +	struct device *dev = client->dev;
>> +	struct qmi_tmd *tmd;
>> +	struct device_node *subnode, *node = dev->of_node;
>> +	int ret;
>> +
>> +	for_each_available_child_of_node(node, subnode) {
> Hmm...
>
>> +		const char *name;
>> +
>> +		tmd = devm_kzalloc(dev, sizeof(*tmd), GFP_KERNEL);
>> +		if (!tmd)
>> +			return dev_err_probe(client->dev, -ENOMEM,
>> +					     "Couldn't allocate tmd\n");
>> +
>> +		tmd->type = devm_kasprintf(client->dev, GFP_KERNEL, "%s:%s",
>> +						client->name, subnode->name);
>> +		if (!tmd->type)
>> +			return dev_err_probe(dev, -ENOMEM,
>> +					     "Couldn't allocate cooling device name\n");
>> +
>> +		if (of_property_read_string(subnode, "label", &name)) {
>> +			return dev_err_probe(client->dev, -EINVAL,
>> +					     "Failed to parse dev name for %s\n",
>> +					     subnode->name);
>> +		}
>> +
>> +		ret = strscpy(tmd->qmi_name, name,
>> +			      QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1);
>> +		if (ret == -E2BIG) {
>> +			return dev_err_probe(dev, -EINVAL, "TMD label %s is too long\n",
>> +					     name);
>> +		}
>> +
>> +		tmd->client = client;
>> +		tmd->np = subnode;
>> +		tmd->cur_state = 0;
>> +		list_add(&tmd->node, &client->cdev_list);
>> +	}
>> +
>> +	if (list_empty(&client->cdev_list))
>> +		return dev_err_probe(client->dev, -EINVAL,
>> +				     "No cooling devices specified for client %s (%#x)\n",
>> +				     client->name, client->id);
>> +
>> +	return 0;
>> +}
>> +
>> +static int qmi_tmd_client_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct qmi_tmd_client *client;
>> +	const struct qmi_instance_data *match;
>> +	int ret;
>> +	client = devm_kzalloc(dev, sizeof(*client), GFP_KERNEL);
>> +	if (!client)
>> +		return -ENOMEM;
>> +
>> +	client->dev = dev;
>> +
>> +	match = of_device_get_match_data(dev);
>> +	if (!match)
>> +		return dev_err_probe(dev, -EINVAL, "No match data\n");
>> +
>> +	client->id = match->id;
>> +	client->name = match->name;
>> +
>> +	mutex_init(&client->mutex);
>> +	INIT_LIST_HEAD(&client->cdev_list);
>> +	INIT_WORK(&client->svc_arrive_work, qmi_tmd_svc_arrive);
>> +
>> +	ret = qmi_tmd_alloc_cdevs(client);
>> +	if (ret)
>> +		return ret;
>> +
>> +	platform_set_drvdata(pdev, client);
>> +
>> +	ret = qmi_handle_init(&client->handle,
>> +			      TMD_GET_MITIGATION_DEVICE_LIST_RESP_MSG_V01_MAX_MSG_LEN,
>> +			      &thermal_qmi_event_ops, NULL);
>> +	if (ret < 0)
>> +		return dev_err_probe(client->dev, ret, "QMI handle init failed for client %#x\n",
>> +			      client->id);
>> +
>> +	ret = qmi_add_lookup(&client->handle, TMD_SERVICE_ID_V01, TMD_SERVICE_VERS_V01,
>> +			     client->id);
>> +	if (ret < 0) {
>> +		qmi_handle_release(&client->handle);
>> +		return dev_err_probe(client->dev, ret, "QMI register failed for client 0x%x\n",
>> +			      client->id);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void qmi_tmd_client_remove(struct platform_device *pdev)
>> +{
>> +	struct qmi_tmd_client *client = platform_get_drvdata(pdev);
>> +
>> +	qmi_tmd_cleanup(client);
>> +}
>> +
>> +static const struct of_device_id qmi_tmd_device_table[] = {
>> +	{
>> +		.compatible = "qcom,qmi-cooling-cdsp",
> Where is support for modem cooling? ADSP? SLPI?
>
>> +		.data = &((struct qmi_instance_data) { CDSP_INSTANCE_ID, "cdsp" }),
> Define it outside and reference here. Use C99 initializers.
>
>> +	},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, qmi_tmd_device_table);
>> +
>> +static struct platform_driver qmi_tmd_device_driver = {
>> +	.probe = qmi_tmd_client_probe,
>> +	.remove = qmi_tmd_client_remove,
>> +	.driver = {
>> +		.name = "qcom-qmi-cooling",
>> +		.of_match_table = qmi_tmd_device_table,
>> +	},
>> +};
>> +
>> +module_platform_driver(qmi_tmd_device_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Qualcomm QMI Thermal Mitigation Device driver");
>
>
>> diff --git a/drivers/thermal/qcom/qmi-cooling.h b/drivers/thermal/qcom/qmi-cooling.h
>> new file mode 100644
>> index 000000000000..f46b827b4ce6
>> --- /dev/null
>> +++ b/drivers/thermal/qcom/qmi-cooling.h
>> @@ -0,0 +1,428 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2017, The Linux Foundation
>> + * Copyright (c) 2023, Linaro Limited
>> + */
>> +
>> +#ifndef __QCOM_COOLING_H__
>> +#define __QCOM_COOLING_H__
>> +
>> +#include <linux/soc/qcom/qmi.h>
>> +
>> +#define TMD_SERVICE_ID_V01 0x18
>> +#define TMD_SERVICE_VERS_V01 0x01
>> +
>> +#define QMI_TMD_GET_MITIGATION_DEVICE_LIST_RESP_V01 0x0020
>> +#define QMI_TMD_GET_MITIGATION_LEVEL_REQ_V01 0x0022
>> +#define QMI_TMD_GET_SUPPORTED_MSGS_REQ_V01 0x001E
>> +#define QMI_TMD_SET_MITIGATION_LEVEL_REQ_V01 0x0021
>> +#define QMI_TMD_REGISTER_NOTIFICATION_MITIGATION_LEVEL_RESP_V01 0x0023
>> +#define QMI_TMD_GET_SUPPORTED_MSGS_RESP_V01 0x001E
>> +#define QMI_TMD_SET_MITIGATION_LEVEL_RESP_V01 0x0021
>> +#define QMI_TMD_DEREGISTER_NOTIFICATION_MITIGATION_LEVEL_RESP_V01 0x0024
>> +#define QMI_TMD_MITIGATION_LEVEL_REPORT_IND_V01 0x0025
>> +#define QMI_TMD_GET_MITIGATION_LEVEL_RESP_V01 0x0022
>> +#define QMI_TMD_GET_SUPPORTED_FIELDS_REQ_V01 0x001F
>> +#define QMI_TMD_GET_MITIGATION_DEVICE_LIST_REQ_V01 0x0020
>> +#define QMI_TMD_REGISTER_NOTIFICATION_MITIGATION_LEVEL_REQ_V01 0x0023
>> +#define QMI_TMD_DEREGISTER_NOTIFICATION_MITIGATION_LEVEL_REQ_V01 0x0024
>> +#define QMI_TMD_GET_SUPPORTED_FIELDS_RESP_V01 0x001F
>> +
>> +#define QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 32
>> +#define QMI_TMD_MITIGATION_DEV_LIST_MAX_V01 32
>> +
>> +struct tmd_mitigation_dev_id_type_v01 {
>> +	char mitigation_dev_id[QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1];
>> +};
>> +
>> +static const struct qmi_elem_info tmd_mitigation_dev_id_type_v01_ei[] = {
> No data objects in the _header_ file.
>
>> +	{
>> +		.data_type = QMI_STRING,
>> +		.elem_len = QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1,
>> +		.elem_size = sizeof(char),
>> +		.array_type = NO_ARRAY,
>> +		.tlv_type = 0,
>> +		.offset = offsetof(struct tmd_mitigation_dev_id_type_v01,
>> +				   mitigation_dev_id),
>> +	},
>> +	{
>> +		.data_type = QMI_EOTI,
>> +		.array_type = NO_ARRAY,
>> +		.tlv_type = QMI_COMMON_TLV_TYPE,
>> +	},
>> +};
>> +

