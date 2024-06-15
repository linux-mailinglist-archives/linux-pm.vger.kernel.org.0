Return-Path: <linux-pm+bounces-9220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9E69095A4
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 04:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E528E2888DF
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 02:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3366AA7;
	Sat, 15 Jun 2024 02:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CIxa/g/x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF2BEADB;
	Sat, 15 Jun 2024 02:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417755; cv=none; b=J+pT/sNMmkhbnJhyDIryCj2UtRo7bB7YeAACSWJjzG/p4RuwI982IKu32bvAd4/F+fgga8+BtRksTjuxMUh7U52C4lBGR8/lMIlbY3CtLa/uthxdbxzT8B4PcAQuWyZAxstWV5vgKCUUSaLhQyRTg4hZPSr7WrBEt/xJdQj8McE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417755; c=relaxed/simple;
	bh=z9HIddnvgvM3GUTbm86JIM7IUzNU9QDqAL1wIowUq1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E0t53zjGCTpeUaV9iH13JiIPEZe2/DxWf9MLybp+uaUxCZnlwZYULOqgavim3KbJ5/i17/ZPe03eKBa4FUdbZyySyyCfHZc/GI4vRTv16r4hY3TN+vd8oy5/FWwxatYBqX3y5MNdBLrx5W9MIdGMuL65J/cyJ4s0KDAPqeqEpXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CIxa/g/x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45F291A1026963;
	Sat, 15 Jun 2024 02:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XlFtXOpFi8BhNNqPGzzEzhPs+LCSPnDFOKquHAaF4Zw=; b=CIxa/g/xnztrZ6E0
	Ow8bxfh0O9je+sP9xUxeyNZy2PcQClCXSMDVfw0XUVdm8pVm1YRQLyG33U+9uQ8N
	+KjYzYuKt5a2cKtCJLa0C2D4xPYA/i+zlx+BLLOFaWjDL2gg04ozrXJ5rfru4Txy
	Kmp6xx0FHJYEpvgdhHCGPHqTMlTEf14djZOss+uZiTTUIBIXC+aCnX0Ifpn567eP
	9bDhJyiJ+3LdgrvGupB1Hsx0IvCeOl6V54DukNIzBn6GG1yktOWoB+Hkg2sGfiCa
	Fw9OdDjOldmNVnPvZGkMTqeyjsknONkKbKEncK3rdZe/g6mSiw78oAfgpgF2IgOE
	JRVQNw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys1wr007h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 02:15:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45F2Fmq7027631
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 02:15:48 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 14 Jun
 2024 19:15:43 -0700
Message-ID: <13bb3a32-a531-54d0-3dd9-7b6ea595f990@quicinc.com>
Date: Sat, 15 Jun 2024 07:45:40 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] soc: qcom: icc-bwmon: Allow for interrupts to be
 shared across instances
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <conor+dt@kernel.org>, <abel.vesa@linaro.org>
References: <20240604011157.2358019-1-quic_sibis@quicinc.com>
 <20240604011157.2358019-3-quic_sibis@quicinc.com>
 <5e5f052b-df59-47fb-aed0-10b4f980f151@linaro.org>
 <5df5dc6b-872f-34c5-a6d2-a64f9c881193@quicinc.com>
 <672b6156-e425-4f3b-86f4-02a34cab2b67@linaro.org>
 <122b5418-ca2d-df7d-a1d5-d7682ce0ed5a@quicinc.com>
 <r6bwmhfa4csubsvetnjlj6gzgovewupxf6hkuygqdconldpk2v@otrs4lhd3baj>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <r6bwmhfa4csubsvetnjlj6gzgovewupxf6hkuygqdconldpk2v@otrs4lhd3baj>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PcxTvHBfwMgrfHC-DKSBncWbq_dS8xU2
X-Proofpoint-ORIG-GUID: PcxTvHBfwMgrfHC-DKSBncWbq_dS8xU2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_19,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=845 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406150016



On 6/15/24 03:12, Dmitry Baryshkov wrote:
> On Sat, Jun 15, 2024 at 01:49:34AM GMT, Sibi Sankar wrote:
>>
>>
>> On 6/14/24 13:54, Krzysztof Kozlowski wrote:
>>> On 13/06/2024 19:02, Sibi Sankar wrote:
>>>>
>>>>
>>>> On 6/4/24 12:16, Krzysztof Kozlowski wrote:
>>>>> On 04/06/2024 03:11, Sibi Sankar wrote:
>>>>>> The multiple BWMONv4 instances available on the X1E80100 SoC use the
>>>>>> same interrupt number. Mark them are shared to allow for re-use across
>>>>>> instances.
>>>>
>>>> Hey Krzysztof,
>>>>
>>>> Thanks for taking time to review the series :)
>>>>
>>>>>
>>>>> Would be nice if you also mention you checked that it is safe to have
>>>>> both devm and shared interrupts (so you investigated possibility of race
>>>>> on exit path).
>>>>
>>>> I didn't see any problems with devm being used with SHARED when I posted
>>>> it out. After your review comments I went back again to vett the exit
>>>> path for races and ran into an pre-existing splat [1] but the bwmon
>>>> instances work as expected on module removal/re-insertion.
>>>
>>> Using devm and shared interrupts is in general sign of possible race
>>> issues and should be avoided. Just "not seeing problems" is not an
>>> argument for me, to be honest.
>>
>> Didn't I go further and say I got it tested though? Also can you
>> elaborate on what race do you think the bwmon will hit rather than
>> being too generic about it?
> 
> devm_request_threaded_irq means that the IRQ is freed after the
> bwmon_remove() function returns. Having IRQF_SHARED means that the IRQ
> can still be triggered even though IRQ for this device has been disabled
> in bwmon_disable().
> 
> In this particular case such IRQ probably won't cause issues, but at
> least it needs to be validated and probably commented in bwmon_remove().
> Just stating that "you tested and had no problems" usually isn't enough
> for the expected race condition issues.

Cool, thanks for the info. I'll get this fixed in the next re-spin.

-Sibi

> 

