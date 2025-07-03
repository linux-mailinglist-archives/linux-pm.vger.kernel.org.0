Return-Path: <linux-pm+bounces-30013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3606BAF6DC0
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 10:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8BFF5207DA
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 08:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056B92D3740;
	Thu,  3 Jul 2025 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X/p6n1PL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5676E299ABF;
	Thu,  3 Jul 2025 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751532901; cv=none; b=rRQg4s2y6tFNp3K7TFlNXEhh/G25vejZWHZ1O5sgBxzSPFfyBjzXCNgeNOD0PI2iCHS6FRLsnzON2s4tbuXx9DjO45ZFPgd+56JTez5tCh6g2hJ7iRYvPCVp+rJZTKKrG2yZh+wyEB3U9YMF8aU//MSlIjSLmTPFYHEeQ7lJbig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751532901; c=relaxed/simple;
	bh=bkxsZXQXk1taRkpxPK1WqrlT/Fj2yKejwmtoFGbPKrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AfQM0RPTYTePhgYVNk1gleWsd1Vv4DXgaIHO1OGf3aCHiwmoKvoQrpJ6nR0vTuOY0y2fjO2uPJ7Z9CAgFqfulY65CLcD5O6rjCCmYO21yIkKfhfdPcQQSW9wHGhZkSFXpQcflTqsrXSyJ6+C+/mY4y8MTh6/qnSkJLLj9VHClR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X/p6n1PL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5631018o026279;
	Thu, 3 Jul 2025 08:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hc2H3+qssMR9WWuhbSr9WpF7LcGGN6jvOIx1REmjJ1s=; b=X/p6n1PLf2eKQTs6
	US+qn7rPFmtVbrGeym0+/lnbg/pz1/9/MKouFEZjhOthjqV8lcxtIk4C7dBceyDU
	5oMsaFnW75rlETOvra5AAw996Gt2wIf1/W5zfU5LuL0OflbautZbXfGDouWXV1xq
	QKzA342M3x4rliNbfvmWo4dFwXzT6Mook67quTalmyrCc7rR0jY0PNomlNJ1T+Du
	VxHXLMThvew8r73NJn7ahBTgURPpSW7t85WBmD7SmmZBin5AZ69OVZf+PyiAtHia
	ExVV4+5szuC2bJkpqEuX7yj3d93VQqRg7S6GDwfvBmpNsN30u1h17BcsWPUTzgsu
	iAacZg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kd64vv56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 08:54:56 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5638st0d021889
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 3 Jul 2025 08:54:55 GMT
Received: from [10.217.217.109] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 3 Jul
 2025 01:54:50 -0700
Message-ID: <8351e7ad-6f28-4500-a0e8-8b1c3f66672d@quicinc.com>
Date: Thu, 3 Jul 2025 14:24:44 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Add support for clock controllers and CPU scaling
 for QCS615
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Manivannan
 Sadhasivam" <mani@kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        "Imran
 Shaik" <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
 <20250703-daft-asparagus-gaur-e77861@krzk-bin>
 <b6cabc11-a4f0-4d8a-97b1-140be394feca@quicinc.com>
 <6df04862-2254-4181-8db7-c58023f9716c@kernel.org>
Content-Language: en-US
From: Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <6df04862-2254-4181-8db7-c58023f9716c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Z+PsHGRA c=1 sm=1 tr=0 ts=68664560 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=PA7-FZJZPMTzKNGQEtQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDA3MSBTYWx0ZWRfX7aqtEuf7wDVi
 fm+QUcDUfXBapxceB3SyX65FgIKIv84mRn007Sa5ehPavdMCFUpWypgpdHFdXVvq2A8crCMg1uY
 iSGP0wA1WOONEbHnHO8YBy+XuV8zeTBGfP1UvC0j/lrS/N3UKQ7HpF2AYfGZl5eHKsJ0UeIpJrD
 aNpds5RvxGdZfNQ/dfCn9NTMk8+gKwlHbKBuJ/EX9V7CuU6mndmXpIg9bQkN6kaL9FuhQwVet5h
 KKDLcmckK/ame83n6tg5IJp1GdFpcHPzHNCnS8egPkZRLRSZSb8WqkXBB1C06E9uZGf4R1OZLU5
 TXPTlrSK8fB+xDBASDSfICBUvhB966zFtVg9aSu4CjmHFW7fEqIRiQvzHYSIP9rJvLVLOGUJyTX
 vPPnzlt4DYFftGFTVU6ziKyCJzwzG67LEDPfqBwqBKb22jCrF5uRpR2P/9dF+KMbpiv6/hhQ
X-Proofpoint-GUID: WolCNvLlDVPXjmxWy6Mi53AZ8pullkBi
X-Proofpoint-ORIG-GUID: WolCNvLlDVPXjmxWy6Mi53AZ8pullkBi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_02,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=619
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030071



On 7/3/2025 2:06 PM, Krzysztof Kozlowski wrote:
> On 03/07/2025 10:28, Taniya Das wrote:
>>
>>
>> On 7/3/2025 12:51 PM, Krzysztof Kozlowski wrote:
>>> On Wed, Jul 02, 2025 at 02:43:08PM +0530, Taniya Das wrote:
>>>> Add the video, camera, display and gpu clock controller nodes and the
>>>> cpufreq-hw node to support cpu scaling.
>>>>
>>>> Clock Dependency:
>>>> https://lore.kernel.org/all/20250702-qcs615-mm-v10-clock-controllers-v11-0-9c216e1615ab@quicinc.com
>>>>
>>>> Changes in v5:
>>>> - Update the documentation for CPUFREQ-HW for QCS615.
>>>
>>> What did you update? This has to be specific, not vague.
>>
>> Sorry, this is the update: "compatible for cpufreq hardware on Qualcomm
>> QCS615 platform."
>>
> Do you mean you added a new patch?
> 

Yes, Krzysztof, I’ve added a new patch. Initially, I was reusing the
compatible string of the SC7180 SoC for QCS615, since both SoCs share
the same hardware design. However, Dmitry and Konrad raised a valid
point — if we ever need to handle quirks specific to a particular SoC,
using distinct compatible entries would make that easier. Based on that,
I’ve updated the patch accordingly.

-- Taniya.

