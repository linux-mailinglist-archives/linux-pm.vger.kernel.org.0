Return-Path: <linux-pm+bounces-21123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7851A22BDA
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 11:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFAB91883092
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 10:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A56B1BD9CE;
	Thu, 30 Jan 2025 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TjrboCpi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890CC286A9;
	Thu, 30 Jan 2025 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738233597; cv=none; b=EYJeS24HD7sRCvl5BxwCNWj2AUo9GeulnhKpuVUKN1n243Dw2Ok/VqVVvw10nA0msJsOsfW4h5EBzUASaQXSFRYSymScoCy5LbnSrxk0tbS++JatWsShvs8NzRbzWFzhifibMyiTD+1hCEWwlbLp3vzduFvnG0AJfJyDVzb/1kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738233597; c=relaxed/simple;
	bh=Bwe1zSzA94tr7JN1tOQGaCAyWDd1qOeWJ+jDd/YFqvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Scgf9lEZdjrIDEuEbbDhN8uK4VssY80WdkvoWBC/+/sVoY72oDPdbO+dJe9gVeMzye4O9zL8OMrHZrbV2qKQcMfPh3cr4Wgszz/iqt+k9uG07YV7EY37a+pRspn4h9OwAW4DHyPds5Yt5yhxJj8sjQY7azQHH6ibKZXoq8Lsa8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TjrboCpi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U9Hcua011694;
	Thu, 30 Jan 2025 10:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9v5kVzMEZCO5IQ1FxICjBWo/iJbjrcZVbQPVd8cZQhc=; b=TjrboCpiVx49+KOS
	K35Mz5F1I8RoElMCy9u7kiqg/nA8ASRnOBMvNLNrd57/f0HUGH40lF0fw7A4FHJD
	T2yY1vaGTtJrqAQnmpntpgPR72YJJMjOeWlNq++0atVmVyDFlNp0x8mZN74n/FoQ
	b5Y404Ti7NWVfDJYeWCujizN+/XepuOcR50AbXah6k8PYgiz5ccXptMsrDLco1qZ
	5uXU57h+Zd2+ILNcwj7Q6v7FNO4z21M1lD6n+wBUnSAU7RuUukYnqY5e78yH0MbD
	4Aj1DSa5OG5EAI64YPE7bBHfLEekcGwpvUsLHkEGfiJdDUMeWMfR/hu77ipUeK5P
	E8jZCQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44g6ntg5ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 10:39:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50UAdnKq013770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 10:39:49 GMT
Received: from [10.216.8.207] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 Jan
 2025 02:39:34 -0800
Message-ID: <39d2ed05-2068-4d41-9af8-da3dcd4e12f0@quicinc.com>
Date: Thu, 30 Jan 2025 16:09:27 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: clock: ipq5424-apss-clk: Add ipq5424
 apss clock controller
To: Krzysztof Kozlowski <krzk@kernel.org>, <andersson@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <konradybcio@kernel.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
References: <20250127093128.2611247-1-quic_srichara@quicinc.com>
 <20250127093128.2611247-2-quic_srichara@quicinc.com>
 <0c26af56-ed7a-4de8-ac47-7447298b87f0@kernel.org>
 <92836021-ee0e-4fb4-bf01-49b46a5af3a4@quicinc.com>
 <c3b6c20f-6e35-446d-a61d-f24611dd815d@kernel.org>
Content-Language: en-US
From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <c3b6c20f-6e35-446d-a61d-f24611dd815d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eUz22xZ4LVTZl3I0QC9PQqMbdqe7d6v9
X-Proofpoint-GUID: eUz22xZ4LVTZl3I0QC9PQqMbdqe7d6v9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300082



On 1/28/2025 6:00 PM, Krzysztof Kozlowski wrote:
> On 28/01/2025 12:15, Sricharan Ramabadhran wrote:
>>
>>
>> On 1/28/2025 1:04 PM, Krzysztof Kozlowski wrote:
>>> On 27/01/2025 10:31, Sricharan R wrote:
>>>> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>>
>>>> The CPU core in ipq5424 is clocked by a huayra PLL with RCG support.
>>>> The RCG and PLL have a separate register space from the GCC.
>>>> Also the L3 cache has a separate pll and needs to be scaled along
>>>> with the CPU.
>>>>
>>>> Co-developed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>>>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>>>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>
>>> Considering that there were multiple conflicting patches coming from
>>> Qualcomm around IPQ SoCs and that we are in the merge window, I will
>>> skip this patch.
>>>
>>> I suspect this duplicates the other chip as well, but that's your task
>>> to sync up internally.
>>>
>> ok, but this .yaml is specific to IPQ5424 and would not conflict with
>> IPQ5332. That said, will post it after merge window as a part of
>> V3 (for other patch changes) to avoid any confusion.
> 
> 
> But maybe it is the same on ipq5332? or similar? Other works were
> totally de-synced and you ask community to sync them. That's not how it
> works.

This is different from ipq5332, hence we cannot re-use and would have
no conflicts as well.

Regards,
  Sricharan

