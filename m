Return-Path: <linux-pm+bounces-40080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EF5CEB592
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 07:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72D1C3014AE4
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 06:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789B6310636;
	Wed, 31 Dec 2025 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L6fNTd4t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z7XF/GPK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D933C3A1E82
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767162790; cv=none; b=Bf2v+1Rd2EyDNo/gRMFoY4FZFA+OxoGv8L5XNOb3V1F5wp88MpAua6S7G4ic+f9fUQgI7+P0JZt58OmMq05Viacj3tGPLVuLlsdU9hEHIvcQnVOrazGSMMgaLsEGGvGYlZlJul/tSmRJbxpv0dKWS9ItjmckzaihdmZ/EWVvxSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767162790; c=relaxed/simple;
	bh=ZEWYEWDDeP6gdb3lEeXP/y3oqDzSpocoNta5So617vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8V5UxZuvrsluf314yfPZPXEF29/t2paN8Wc9QpN6SvcAUlQHhygDW/cYeh05OMFwaHwxaDMwNg/M/oJhRyR7GmSZ+PbJoWwbMlsMd9yBpvkci8CMSGMfoCk88UbOMM4ViMK6QytDv9YgtvWFQCNLyxtLsSEjsZ6Yp5fF1odZCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L6fNTd4t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z7XF/GPK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV04CSA2551303
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 06:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YCEYYsq4ZhM7LuwiDr23e+07qSBlBDIgToQnNungY7c=; b=L6fNTd4tGD5pp/UE
	xUto/mn0m8s4mFfKVDvVb4I5rGnQ79nrGgyPhxU3QCBxQqmkcsA+7/tK/15JY0jY
	b47YmsrIj6Gpd0KTdGMkZToQtJ9/mxULrXtItLP8ejeaTn8vucJW65Ld/2nb/AcV
	V+HvtAAO8NxvhooQDXgnMXoW8InEWxDIXfomrBhToJGCynavDlgYpAoSZl4qNl2a
	Y6BfZdSQCDwZe+GOUOZ8ALlH9ilCN4oUjFJtfF4lG/EgZHcZyO/EH+cUamfTOJb1
	kI8uIuYl23oPWzjNSLkuiF+XTIQfg4aErSjLln1uARa4Bkwh6gSa9juOFU3xSk+R
	iMOolg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc0skkq3v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 06:33:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed7591799eso262346111cf.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 22:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767162786; x=1767767586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCEYYsq4ZhM7LuwiDr23e+07qSBlBDIgToQnNungY7c=;
        b=Z7XF/GPKOCu1cEdpTELqbezLIyBLzIoyL/iZN5p8mdJnw5wEcaN6w35Tjr+lK1Ypiv
         Ak2KxvSY3eG/xo5hOMcjNwWcpBRHhd2NwmMuQsE/o+VGMf0qPDCeFAuE4JZVJfFWIvH6
         q05QHNkyyo9we2HIpaBdOKbSV/8/xIpfpTwxCd0iDYzBUI721I7kZCjt6xOcfKuryqBh
         mbYreZcjo3k/IY3++ghdK1b6ZMLsXjjYIKQ6wgYRY6zEMyW1PGgaECqhCP4BM6LrBADl
         OK5Wj4TQr1Qcd6tD4hk5PpsMFW1J+MqIKV5tIjBCrEvm6NrpM3XjBBKn7ypP6idokglC
         xpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767162786; x=1767767586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCEYYsq4ZhM7LuwiDr23e+07qSBlBDIgToQnNungY7c=;
        b=S+LiYFitBusyeuJk8Mz+ayegbVypY0AMpw/CN6J8d0LgNeWKxsft6EI2duH0GNVZDU
         a4q7/HmVgvh9c5gNtVmmzF5KHxBCl122yX7cBI7SssgDsUfNWOVF5Wg16C6+XCMb2nCf
         yYMzSiClBpkgpJuZQLXXJQGdxHop9OC9T8Do0OCLglzeaLwvbIOZGPjHyBfNE0PkEVFl
         OVLa3MWVT6GUMrMOeGBXlxTFQcbxLhCz6T0mK+5bAnUH6QtakVh0OobVmnuQY+u+KJqB
         jsp4O6DKf35JC9XqeTNnH/z4r3/fd81URdsl2LeBHUBKi1mcRdrSLKtww9FsyU41/FKR
         uvvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd+EOxA+x7dbV8WLn8wtK8n8XxRkmKok+AO5XH4FvsExttL7433yA52gaGPUGKX7PkXV8IKtC9Rw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTy38ecgyNIv+uet4gCtv0tSM2qp5saaKqR0MTw81js18QI0TG
	qctjumjJ8/JLmnRG2pbfv9XLSafb1lyfv+U2VrdW7MWtJMIHt1q5uLKyLAdIvBYSvBO0Dxy2Ww+
	Pxju92V/MHjb55XPEHrIbvSYk+3pqln5qJhphaZzQ5TZSf6dJSNkNtAAWWv4gpQ==
X-Gm-Gg: AY/fxX44DdjoAYv6+j9lz9H2bPiBChPg4E8xudXppmY+34uHt7tDqgw1Emlk13WmBQi
	YNbtG4I9S2HaszjcicPCns8Vbrw5JyiNAIHVZ0Ns/G5t4SoTXvAOnK3O4BswWn4y/iwf7JuKxgj
	Kyte11cKfIXN/xP19lYwOxSlEnDnCge+y8ZopRbOJwos1/oti5BQUOBUXbhq9b/m67MpNnUEH3w
	UxRu8od1Ow9r27FPIk78RZTgsER9Z7L3tj4c9EZtdWWELVkKGVDQp8p62b9mKA6xNVK+1GzQY+h
	RHM94syDhMLlJ4JUvj1dulO15jk22L+A1hnHYSFzhEwKnIMeCkO4KAKKK8kM503A5M4Xxgr2jqU
	U72CpLUWYD7uAoYuEVR6VtR7ilaPoqWb2rVmbnyamLpM9DNl7358LbMrfvRiu6uzLea+KGeOy01
	r811Vafatft5cF
X-Received: by 2002:a05:622a:344:b0:4f3:4ec0:9032 with SMTP id d75a77b69052e-4f4abdd5bb4mr517512581cf.72.1767162786074;
        Tue, 30 Dec 2025 22:33:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbVVPiUu9/9xOzV2d3JboY1CL5Me1rW7KZn5Lm58vJXyZqGKFcOFoYJsTxMJLmrEadLtIiZQ==
X-Received: by 2002:a05:622a:344:b0:4f3:4ec0:9032 with SMTP id d75a77b69052e-4f4abdd5bb4mr517512361cf.72.1767162785537;
        Tue, 30 Dec 2025 22:33:05 -0800 (PST)
Received: from ?IPV6:2001:14ba:a073:af00::4c9? (2001-14ba-a073-af00--4c9.rev.dnainternet.fi. [2001:14ba:a073:af00::4c9])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d5eccsm10862767e87.14.2025.12.30.22.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 22:33:04 -0800 (PST)
Message-ID: <68d70a3d-4443-4596-842a-e8a700b276eb@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 08:33:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/8] thermal: qcom: add qmi-cooling driver
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
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
 <f3013c96-673f-4a7c-8296-d4d7d0ec2a44@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <f3013c96-673f-4a7c-8296-d4d7d0ec2a44@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDA1NSBTYWx0ZWRfX+lCmNtqnKVFc
 rP8s+k6l2sIXICbWtQPkoFjEV+1N90UmjtNKMJwfJcBjk2ECH1cI8TQQUuuiWd6ipmkMMHkraWZ
 ABCNYhw6o9TPbZ2tbDPJx7ABqgqE4w2RVtKw00GD61sFvnVAvToVNZ+NL6NuThLwBUaeaMGwXK8
 4DCKRIvuLolgwWcyu/AM2beQLnj4dXCqH9LhTl31fIAH/ASoKHCsWFntJPiaFaJVtNij6NrqWad
 i4XxysdSL07whsxCLAAEDfdONzyl5I0vcPBdoLkxK/V+uUCmISBdQUSKdJXhl96nHoLRsDl7jK0
 CASWZz9Ky9Ih0jQtHIDQPO/0rn1bXDPFYxtnhbhS+nFcv4wGNvGuIymmsH5esqQyf/p3fRQvQ0L
 6Yz/0sLFcI/PnG6vsbM/eRirUSXsGFTY5tRpE5sYLA8+AFx6vKkIcvcxgd5rgMisfOZyGAnxWSO
 5TJXSydw28aYaKrMF1w==
X-Proofpoint-ORIG-GUID: QOAmaKpDDcFa5uDVRvDtywDPxX4cbwmh
X-Proofpoint-GUID: QOAmaKpDDcFa5uDVRvDtywDPxX4cbwmh
X-Authority-Analysis: v=2.4 cv=FJ0WBuos c=1 sm=1 tr=0 ts=6954c3a2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=LQj-z2CNEsGdv2HSHM8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310055

On 31/12/2025 08:28, Gaurav Kohli wrote:
> 
> On 12/24/2025 1:19 AM, Dmitry Baryshkov wrote:
>> On Tue, Dec 23, 2025 at 06:02:23PM +0530, Gaurav Kohli wrote:
>>> From: Casey Connolly <casey.connolly@linaro.org>
>>>
>>> The Thermal Mitigation Device (TMD) service exposes various platform
>>> specific thermal mitigations available on remote subsystems (ie the
>>> modem and cdsp). The service is exposed via the QMI messaging
>>> interface, usually over the QRTR transport.
>>>
>>> Qualcomm QMI-based TMD cooling devices are used to mitigate thermal
>>> conditions across multiple remote subsystems. These devices operate
>>> based on junction temperature sensors (TSENS) associated with thermal
>>> zones for each subsystem.
>>>
>>> Co-developed-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>> ---
>>>   drivers/soc/qcom/Kconfig           |  13 +
>>>   drivers/soc/qcom/Makefile          |   1 +
>>>   drivers/soc/qcom/qmi-cooling.c     | 498 +++++++++++++++++++++++++++++
>>>   drivers/soc/qcom/qmi-cooling.h     | 428 +++++++++++++++++++++++++
>>>   drivers/thermal/qcom/qmi-cooling.h | 428 +++++++++++++++++++++++++
>>>   5 files changed, 1368 insertions(+)
>>>   create mode 100644 drivers/soc/qcom/qmi-cooling.c
>>>   create mode 100644 drivers/soc/qcom/qmi-cooling.h
>>>   create mode 100644 drivers/thermal/qcom/qmi-cooling.h
>>>
>>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>> index 2caadbbcf830..905a24b42fe6 100644
>>> --- a/drivers/soc/qcom/Kconfig
>>> +++ b/drivers/soc/qcom/Kconfig
>>> @@ -124,6 +124,19 @@ config QCOM_PMIC_GLINK
>>>         Say yes here to support USB-C and battery status on modern 
>>> Qualcomm
>>>         platforms.
>>> +config QCOM_QMI_COOLING
>>> +    tristate "Qualcomm QMI cooling drivers"
>>> +    depends on QCOM_RPROC_COMMON
>>> +    depends on ARCH_QCOM || COMPILE_TEST
>>> +    select QCOM_QMI_HELPERS
>>> +    help
>>> +       This enables the remote subsystem cooling devices. These cooling
>>> +       devices will be used by Qualcomm chipset to place various remote
>>> +       subsystem mitigations like remote processor passive mitigation,
>>> +       remote subsystem voltage restriction at low temperatures etc.
>>> +       The QMI cooling device will interface with remote subsystem
>>> +       using Qualcomm remoteproc interface.
>>> +
>>>   config QCOM_QMI_HELPERS
>>>       tristate
>>>       depends on NET
>>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>>> index b7f1d2a57367..b6728f54944b 100644
>>> --- a/drivers/soc/qcom/Makefile
>>> +++ b/drivers/soc/qcom/Makefile
>>> @@ -14,6 +14,7 @@ obj-$(CONFIG_QCOM_PMIC_GLINK)    += pmic_glink.o
>>>   obj-$(CONFIG_QCOM_PMIC_GLINK)    += pmic_glink_altmode.o
>>>   obj-$(CONFIG_QCOM_PMIC_PDCHARGER_ULOG)    += pmic_pdcharger_ulog.o
>>>   CFLAGS_pmic_pdcharger_ulog.o    :=  -I$(src)
>>> +obj-$(CONFIG_QCOM_QMI_COOLING) += qmi-cooling.o
>>>   obj-$(CONFIG_QCOM_QMI_HELPERS)    += qmi_helpers.o
>>>   qmi_helpers-y    += qmi_encdec.o qmi_interface.o
>>>   obj-$(CONFIG_QCOM_RAMP_CTRL)    += ramp_controller.o
>>> diff --git a/drivers/soc/qcom/qmi-cooling.c b/drivers/soc/qcom/qmi- 
>>> cooling.c
>>> new file mode 100644
>>> index 000000000000..1a6afcb96bf6
>>> --- /dev/null
>>> +++ b/drivers/soc/qcom/qmi-cooling.c
>>> @@ -0,0 +1,498 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2017, The Linux Foundation
>>> + * Copyright (c) 2025, Linaro Limited
>>> + *
>>> + * QMI Thermal Mitigation Device (TMD) client driver.
>>> + * This driver provides an in-kernel client to handle hot and cold 
>>> thermal
>>> + * mitigations for remote subsystems (modem and DSPs) running the 
>>> TMD service.
>>> + * It doesn't implement any handling of reports from remote subsystems.
>>> + */
>>> +
>>> +#include <linux/cleanup.h>
>>> +#include <linux/err.h>
>>> +#include <linux/module.h>
>>> +#include <linux/net.h>
>>> +#include <linux/of.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/remoteproc/qcom_rproc.h>
>>> +#include <linux/remoteproc_cooling.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/soc/qcom/qmi.h>
>>> +#include <linux/thermal.h>
>>> +
>>> +#include "qmi-cooling.h"
>>> +
>>> +#define MODEM0_INSTANCE_ID    0x0
>>> +#define ADSP_INSTANCE_ID    0x1
>>> +#define CDSP_INSTANCE_ID    0x43
>> Will CDSP1 also use instance ID? What are instance IDs for GPDSP?
> 
> 
> In Leman's there are two different cdsp subsytem, i will add new 
> instance id for that also.
> 
> What is GPdsp, you mean gpu ?
> 

No, I mean general purpose DSP aka GPDSP aka GDSP.

-- 
With best wishes
Dmitry

