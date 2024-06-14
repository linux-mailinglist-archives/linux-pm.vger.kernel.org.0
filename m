Return-Path: <linux-pm+bounces-9212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCE690934E
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 22:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58AC1F2484A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 20:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA21B146D6D;
	Fri, 14 Jun 2024 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LTJGfLCc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19104393;
	Fri, 14 Jun 2024 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718396389; cv=none; b=W+pHsZEv8xxRwGYbgJamKRI6U1pIfnml4sCX/QFmoe3VceI/Qr9/uRvceDjsze5RM/aivih/igjpfW1p3/hejDE/4P/R8AW5VPAkxrhfIoPeRGDHWI3+d57ESKFzKH1uR8xxnPKVK5rRVp79uV0KKX/TNSp8wWkl4NC+//PNXAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718396389; c=relaxed/simple;
	bh=MO7d+ilL3XZhUZBsmfpYq+oyqYrOIe1GkR5FSI2xQbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ak+c7a1uVxUQhGmBjRNjYMSuNIymlXDgPcpLvbmuUdHFA2GfhSTjuDIxN4XUG5HxI02N+Lj1zU8AgF4vCLxXQpxqIvcu2CKBxVi7NXetfs0oLWH1qTOo3f7L/ZdIgAwxJf2rnh0OC93xY1A5WlIRfmKXaX1Fvo84rDsK3Flzqxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LTJGfLCc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EKChw7030498;
	Fri, 14 Jun 2024 20:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H+fhsOX2oM3LNxV6L2zysDTUgRq1q4HveG16XE7UwTI=; b=LTJGfLCchDbD5kA7
	ivQXJFRY+n7gPsCUw0suYyhCJfNYGDXZBv8JK9+YaEogiix3rTgzjbfegw2zmJmb
	GKveLIfDBB32nPSigJ1lZYjlls2i7CYUoeQwKapOdHqXFg1wKe159/N0i4YYhYUD
	523bjlEmojznB6XRPKgQUBSfU2aVfkaqz4LBC8DWLmOS/JnP2/gJtAec3XOeRVCd
	/GDa4c92+aUEVBitS9hdiCuOiJ/zxYOf8vF4vFuwVMKBtDrBHUo61VQsackNh3aE
	V/r13yZFa5KrAhX31YVZhZfWEcdB6twMzRSHg3vcrZGep1ZqcfcakZeuZIGmt/Q2
	jPXDKg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yr6q42m48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 20:19:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45EKJhw5030496
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 20:19:43 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 14 Jun
 2024 13:19:38 -0700
Message-ID: <122b5418-ca2d-df7d-a1d5-d7682ce0ed5a@quicinc.com>
Date: Sat, 15 Jun 2024 01:49:34 +0530
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
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <conor+dt@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <abel.vesa@linaro.org>
References: <20240604011157.2358019-1-quic_sibis@quicinc.com>
 <20240604011157.2358019-3-quic_sibis@quicinc.com>
 <5e5f052b-df59-47fb-aed0-10b4f980f151@linaro.org>
 <5df5dc6b-872f-34c5-a6d2-a64f9c881193@quicinc.com>
 <672b6156-e425-4f3b-86f4-02a34cab2b67@linaro.org>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <672b6156-e425-4f3b-86f4-02a34cab2b67@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kvdxFHK5rbyFNXzxYVdLiWOjYLBkeImc
X-Proofpoint-ORIG-GUID: kvdxFHK5rbyFNXzxYVdLiWOjYLBkeImc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_17,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=624 suspectscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406140140



On 6/14/24 13:54, Krzysztof Kozlowski wrote:
> On 13/06/2024 19:02, Sibi Sankar wrote:
>>
>>
>> On 6/4/24 12:16, Krzysztof Kozlowski wrote:
>>> On 04/06/2024 03:11, Sibi Sankar wrote:
>>>> The multiple BWMONv4 instances available on the X1E80100 SoC use the
>>>> same interrupt number. Mark them are shared to allow for re-use across
>>>> instances.
>>
>> Hey Krzysztof,
>>
>> Thanks for taking time to review the series :)
>>
>>>
>>> Would be nice if you also mention you checked that it is safe to have
>>> both devm and shared interrupts (so you investigated possibility of race
>>> on exit path).
>>
>> I didn't see any problems with devm being used with SHARED when I posted
>> it out. After your review comments I went back again to vett the exit
>> path for races and ran into an pre-existing splat [1] but the bwmon
>> instances work as expected on module removal/re-insertion.
> 
> Using devm and shared interrupts is in general sign of possible race
> issues and should be avoided. Just "not seeing problems" is not an
> argument for me, to be honest.

Didn't I go further and say I got it tested though? Also can you
elaborate on what race do you think the bwmon will hit rather than
being too generic about it?

-Sibi

> 
> Best regards,
> Krzysztof
> 

