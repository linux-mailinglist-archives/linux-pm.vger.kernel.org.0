Return-Path: <linux-pm+bounces-17733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA499D1786
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 19:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C221F22719
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 18:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D7A1DD866;
	Mon, 18 Nov 2024 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IDBK+xLv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFBB1DC054;
	Mon, 18 Nov 2024 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731952942; cv=none; b=VxyKDzAuKDAgLAZ4quh4/3phR6nTCeuS6GkN3ffO5Kv6CBUosgt9UmkTKF8Dj/xXzNgN/esYSUpUkgtI30TEORFREvj1xYwOhLkS/5eFpuaZV5qicMytFUs/hBaOQcxuGqIvskj3gNZ2gnMLpRtWacpq55m7bBpXuUpBb/0U2Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731952942; c=relaxed/simple;
	bh=IaeKpdec/3PSsBxKIbML0Pa+p5E4+JiLIUphOSQ2TiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VT8MXPuek3BV3r7wN/RDjclUYTo2XGTMZBq3f7/IVSMa6fXZNPI4r030Mz2Pue1/erdFcS9AezHNL6IIe36AIdOcC0gtM2h5CqJvNHwfPXCpcJhI9cAwKZdndo+OK3Pw8sbFhMROrnMFNSC8RNaxV/SJ9vr+R38sh6t1FvCXEBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IDBK+xLv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGGeCG022370;
	Mon, 18 Nov 2024 18:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G+5aI+CNTCLzdOV3Q6IscoEfQzbT9AxQXMivnhOM6ZE=; b=IDBK+xLvU+ewI1Z8
	Nu4MDQ1YseLudMbYbVywbrD6ZOfdgy8H7gkB9cOXfodmFDzCTnAI6ZfJ0M9IgeHx
	XxZopQT1rilm0rmLzEn+LFsRPXnrrtNYo0F0+kNPa58ncabfwWccUQFsf6lNI69d
	NRl0h/tjjWGhMPMfc1F1eBYASayFkQghcUJIM4BdZ+hw2ar4vDPp2M4tzjpF6X8u
	AkGvyLuvr+4Ze4DNwpgv8cK476sCLKwZnZgaW2So4YeNd9HUnoGJZ/dBSjGj0OA/
	JR4tCVBEGm7a+fPcLyh7LTDsQrGKVqTCPsCe+70Kundg8993chR1L12NmEFbyAcz
	gCZ/GQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y607yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 18:02:09 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AII28UY012604
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 18:02:08 GMT
Received: from [10.71.108.63] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 18 Nov
 2024 10:01:05 -0800
Message-ID: <0ca812e7-bf5b-463a-83dc-9195aee14589@quicinc.com>
Date: Mon, 18 Nov 2024 10:01:05 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add interconnect provider
 driver for SM8750
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Adam Skladowski <a39.skl@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Raviteja Laggyshetty
	<quic_rlaggysh@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Mike Tipton
	<quic_mdtipton@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241112003017.2805670-1-quic_molvera@quicinc.com>
 <20241112003017.2805670-3-quic_molvera@quicinc.com>
 <em4vkg4totsg435s4usu7kqn45vfqfot2j7sikzmnof2kkyidi@26b6kkpz7z4c>
Content-Language: en-US
From: Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <em4vkg4totsg435s4usu7kqn45vfqfot2j7sikzmnof2kkyidi@26b6kkpz7z4c>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6o3wh5KPYkW3hpmr5NLmsZVm6OVLYW1c
X-Proofpoint-ORIG-GUID: 6o3wh5KPYkW3hpmr5NLmsZVm6OVLYW1c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411180149



On 11/15/2024 7:27 AM, Dmitry Baryshkov wrote:
> On Mon, Nov 11, 2024 at 04:30:17PM -0800, Melody Olvera wrote:
>> From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>>
>> Introduce SM8750 interconnect provider driver using the interconnect
>> framework.
>>
>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>   drivers/interconnect/qcom/Kconfig  |    9 +
>>   drivers/interconnect/qcom/Makefile |    2 +
>>   drivers/interconnect/qcom/sm8750.c | 1585 ++++++++++++++++++++++++++++
>>   drivers/interconnect/qcom/sm8750.h |  132 +++
>>   4 files changed, 1728 insertions(+)
>>   create mode 100644 drivers/interconnect/qcom/sm8750.c
>>   create mode 100644 drivers/interconnect/qcom/sm8750.h
>>
>> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
>> index 362fb9b0a198..1219f4f23d40 100644
>> --- a/drivers/interconnect/qcom/Kconfig
>> +++ b/drivers/interconnect/qcom/Kconfig
>> @@ -337,6 +337,15 @@ config INTERCONNECT_QCOM_SM8650
>>   	  This is a driver for the Qualcomm Network-on-Chip on SM8650-based
>>   	  platforms.
>>   
>> +config INTERCONNECT_QCOM_SM8750
>> +	tristate "Qualcomm SM8750 interconnect driver"
>> +	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
>> +	select INTERCONNECT_QCOM_RPMH
>> +	select INTERCONNECT_QCOM_BCM_VOTER
>> +	help
>> +	  This is a driver for the Qualcomm Network-on-Chip on SM8750-based
>> +	  platforms.
>> +
>>   config INTERCONNECT_QCOM_X1E80100
>>   	tristate "Qualcomm X1E80100 interconnect driver"
>>   	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
>> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
>> index 9997728c02bf..7887b1e8d69b 100644
>> --- a/drivers/interconnect/qcom/Makefile
>> +++ b/drivers/interconnect/qcom/Makefile
>> @@ -40,6 +40,7 @@ qnoc-sm8350-objs			:= sm8350.o
>>   qnoc-sm8450-objs			:= sm8450.o
>>   qnoc-sm8550-objs			:= sm8550.o
>>   qnoc-sm8650-objs			:= sm8650.o
>> +qnoc-sm8750-objs			:= sm8750.o
>>   qnoc-x1e80100-objs			:= x1e80100.o
>>   icc-smd-rpm-objs			:= smd-rpm.o icc-rpm.o icc-rpm-clocks.o
>>   
>> @@ -80,5 +81,6 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SM8350) += qnoc-sm8350.o
>>   obj-$(CONFIG_INTERCONNECT_QCOM_SM8450) += qnoc-sm8450.o
>>   obj-$(CONFIG_INTERCONNECT_QCOM_SM8550) += qnoc-sm8550.o
>>   obj-$(CONFIG_INTERCONNECT_QCOM_SM8650) += qnoc-sm8650.o
>> +obj-$(CONFIG_INTERCONNECT_QCOM_SM8750) += qnoc-sm8750.o
>>   obj-$(CONFIG_INTERCONNECT_QCOM_X1E80100) += qnoc-x1e80100.o
>>   obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
>> diff --git a/drivers/interconnect/qcom/sm8750.c b/drivers/interconnect/qcom/sm8750.c
>> new file mode 100644
>> index 000000000000..bc72954d54ff
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/sm8750.c
>> @@ -0,0 +1,1585 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
>> + *
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/interconnect.h>
>> +#include <linux/interconnect-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/of_platform.h>
>> +#include <dt-bindings/interconnect/qcom,sm8750-rpmh.h>
>> +
>> +#include "bcm-voter.h"
>> +#include "icc-rpmh.h"
>> +#include "sm8750.h"
> Nit: please merge sm8750.h here, there is no need to have a separate
> header, there are no other users.

Ack.

>
> Also, is there QoS support? I see no qcom_icc_qosbox entries.

Unsure; will let Raviteja comment.

Thanks,
Melody
>
> Other than that:
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
>


