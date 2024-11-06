Return-Path: <linux-pm+bounces-17056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3939D9BE149
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 09:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58951F24271
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FFA1D5151;
	Wed,  6 Nov 2024 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jqYoCV4H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232141922EF;
	Wed,  6 Nov 2024 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882860; cv=none; b=TrQolV5KNcp1FmsGSlFZHSIX4HPb10OvUb8Xgcic/6rBHAlIaI06fmUq7iLywwMNJSedo+sh62ZXTousDKLgqCuERIMTF+tqzhrKyQdypv0tgFuTiTgmqlfZvExan7lc6xoZ6lRiwr1l6pOHibBu8OCpJpfIcRK3qDUJIiggzhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882860; c=relaxed/simple;
	bh=si7vGcVBaSlXRYG1n0v/ZEP3Y38EpJ7U0VNz8c7EAUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G8L05uVlql1t4fCnYBamF2TA2+r5/e2gCQRN8fV6BjP/udgmY1L1dKxKmvBUYERl678ERzQ4Z21deFw8MpstRdC7XZe4GDksHYYMrzWZ2vgmpcQdD3SSDkxG+0AlZQcEDLFeG+8JExsQ8GgDaBFrNvoEfFpOXVimejrllvb0m/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jqYoCV4H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A632e3W001983;
	Wed, 6 Nov 2024 08:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/UJAN+H99QW21UZAbynexOkZQpDqUFyAoB5dSaqnB+A=; b=jqYoCV4HgVT1pOpL
	iZcgNWu5m1heuBJ1Hq5FIqLy4ELirNrNg/WumA2oZuB5MYLTDDqSXkzCQ/8JjH/o
	25Fi6lT0AATue7ojTfkLm2r/SbwDjTIXFw6D2cJj/yIom+bNdAXPFmUGFLG4FtX1
	mpYAgM88Yg6D21AH/xVP6nQ9unr1ZbKhM21k1CW6pdwHnNPgw/SrEPdQMrahaDru
	bANqBdiZJXSWcQGrHxAwkKV27Cs4CkgoQrCz2HIU2sZRIYH1UYAprWagSZPXPNyn
	iJy3ypjslqTAvGDUx3Q7iS8EdoCyqV3dcx5F7Gtp2MsFq0JetjO2AwBUIKe97vIL
	SFnhew==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42r072grrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 08:47:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A68lRci000942
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 08:47:27 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 00:47:21 -0800
Message-ID: <8cb665f5-4885-4853-804a-7313decc719c@quicinc.com>
Date: Wed, 6 Nov 2024 14:17:18 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] arm64: dts: qcom: ipq5424: Add thermal zone nodes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        <srinivas.kandagatla@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20241104124413.2012794-1-quic_mmanikan@quicinc.com>
 <20241104124413.2012794-8-quic_mmanikan@quicinc.com>
 <91ea0f03-9bbe-491d-9056-ebd9fdc73bfa@oss.qualcomm.com>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <91ea0f03-9bbe-491d-9056-ebd9fdc73bfa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: J3vNvvZ2O1ycsqR0KMq8FWZSJU2SoSjE
X-Proofpoint-GUID: J3vNvvZ2O1ycsqR0KMq8FWZSJU2SoSjE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=744 spamscore=0
 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060071



On 11/4/2024 7:21 PM, Konrad Dybcio wrote:
> On 4.11.2024 1:44 PM, Manikanta Mylavarapu wrote:
>> Add thermal zone nodes for sensors present in IPQ5424.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
> [...]
> 
>> +
>> +		cpu3-thermal {
>> +			polling-delay-passive = <0>;
>> +			polling-delay = <0>;
>> +			thermal-sensors = <&tsens 13>;
>> +
>> +			trips {
>> +				cpu-critical {
>> +					temperature = <120000>;
>> +					hysteresis = <9000>;
>> +					type = "critical";
>> +				};
>> +
>> +				cpu-passive {
>> +					temperature = <110000>;
>> +					hysteresis = <9000>;
>> +					type = "passive";
> 
> You have a passive trip point without passive polling
> 

Okay, will remove this.

>> +				};
>> +			};
>> +		};
>> +
>> +		wcss-tile2-thermal {
>> +			polling-delay-passive = <0>;
>> +			polling-delay = <0>;
> 
> These are the defaults
> 

Okay, sure. I will remove.

>> +			thermal-sensors = <&tsens 9>;
>> +
>> +			trips {
>> +				wcss_tile2-critical {
> 
> Node names must not contain underscores
> 

Okay, sure. I will remove.

Thanks & Regards,
Manikanta.




