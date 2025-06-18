Return-Path: <linux-pm+bounces-28986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 452AAADF10C
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 17:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711051891188
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 15:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE082EF2A8;
	Wed, 18 Jun 2025 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jvfsGTs3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE11A2EF28A;
	Wed, 18 Jun 2025 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260050; cv=none; b=uHc4VvWcMgFjA7zy0YNgDjKA9kWa94wrZ374tswetyFW5wkvkA1w6MqLdR9ijFjiacO2OoNdibuy5KptK47UgOUPXr3R/Tp0sxkC+K6wSJTXhYoNBruAGwMug+0HIF0E1caZpOrpkAHPKJplcQBlMCNWYbSyfO5qmBdlOhmfKLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260050; c=relaxed/simple;
	bh=qPwi2JfQCu4n2PS79SmzYcP++oGPtpOHOINnWSZXAuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k0UHxzZ9Uvy0tnmOhEbrfIulhJ1q3xLU7hTLdSzwvGhPq5XxXnmoE1uwami4iH+MviYdjrJxXaKyS8CWAbHwdg83ptM/IhZmF1ovBDdoBJ9LBemOhk7U8thOR6KfzSS+dsu88/6X5K0Cv2sRMwDQxDmJKaUpJkL3JgSo0JUQiAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jvfsGTs3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I9JLJ5031604;
	Wed, 18 Jun 2025 15:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4JxJhlTKaWLHxrr2sQ6HBb0cbTYMQOvF9DeXN1OYDf4=; b=jvfsGTs3Pe+noeRu
	CNcRfaYnT0EIyyjDpznzPO6MZB4P2ow3qOhR8sP96QIyVsY12zwBS8mCsrbW/qqF
	p8v/Ljq+pUIfI2u7pKJuWxQ18gIFDzTcM+woEltfhlU59xsMRXz1T+ijjJYtVX9d
	CH3m4YExE7+qtSPafp8uYWU9GKzRDV0nV9wVncJbNaHI1aqwL6fAULx1/arSues8
	IQ8gDT0owQQ21HBIZy4PnkiSD2xL2Jvm5XtAkuB2AujOoOcSxzhLOKNYIKwHx6KG
	dXSs9b2XZp60Wb7fRZTifKCBDZ+r+ZmPV9kWZuOgDfxAwU456/4xWldmiRatwTkK
	nuc/OA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791h9cjgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 15:20:34 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55IFKXq3032498
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 15:20:33 GMT
Received: from [10.253.36.28] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 18 Jun
 2025 08:20:28 -0700
Message-ID: <817d069a-5e0e-41a7-95bb-e3c3ac964346@quicinc.com>
Date: Wed, 18 Jun 2025 23:20:25 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: defconfig: Build NSS clock controller driver
 for IPQ5424
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will
 Deacon" <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_pavir@quicinc.com>
References: <20250617-qcom_ipq5424_nsscc-v1-0-4dc2d6b3cdfc@quicinc.com>
 <20250617-qcom_ipq5424_nsscc-v1-8-4dc2d6b3cdfc@quicinc.com>
 <cf07ac73-9908-4d96-bf44-1f40186df189@kernel.org>
Content-Language: en-US
From: Luo Jie <quic_luoj@quicinc.com>
In-Reply-To: <cf07ac73-9908-4d96-bf44-1f40186df189@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Omg8Eqdm4Mb3wLpwZXdkBmZmrsUHJ3YG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDEyOSBTYWx0ZWRfX+/IZ9J8TT/Td
 G8mYy/+/6x+v7Ha825s4bs5VEljbG3WJNFdYKLMUTFymiBpGY+o4aF9BS5EzMWJADvf4FqPb22O
 wRGHvrFzhJWd2z8zDES+qaoYrWNMrdvDolh0N7VU2CJyimEzb+ZXXXb1ASEF4YMzdrKeUTkJMbk
 PuiUQWOlTRGd9ZMJWUbqp+W4K6hGvDolyJpLkh96d3YVT4fveab8KjM4KHhvyTdt+bWqBINnsZY
 KiSssFXGyLExhX2E8H72re4CyR1IAdQBPgCJ/H63s7fTd2HUzEcy7OpSNRVxdmGGPa50znNaerX
 e580Emrf85HFxRnHxG+0o5wPfL8Zmqzvl2RAt+nuVC7EwkI1ZQq6Pmey64zEjsGqla6iIjaS6Jt
 LFNOmm7/Xzm+8WZkAwNHU7WK61RwiXZUk4BbqE//hdFBWded90wkh8L98yW5Yf6H4m+w+EYa
X-Authority-Analysis: v=2.4 cv=UL/dHDfy c=1 sm=1 tr=0 ts=6852d942 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=U-iYb9-RqBH3_7pkrJoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Omg8Eqdm4Mb3wLpwZXdkBmZmrsUHJ3YG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=857
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180129



On 6/17/2025 10:49 PM, Krzysztof Kozlowski wrote:
> On 17/06/2025 14:06, Luo Jie wrote:
>> NSS clock controller is needed for supplying clocks and resets
>> to the networking blocks for the Ethernet functions on the
>> IPQ5424 platforms.
> 
> Which boards need it?

All boards based on the IPQ5424 SoC require this driver to be
included in the build. I will update the commit message to
clarify this requirement.

> 
> Also here not really proper wrapping.

I will correct the line wrapping in the next revision.

> 
> Best regards,
> Krzysztof


