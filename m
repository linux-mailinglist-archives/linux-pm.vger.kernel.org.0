Return-Path: <linux-pm+bounces-9400-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F1090C035
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 02:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38AEC1C21A04
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 00:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD26A4C7C;
	Tue, 18 Jun 2024 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MRyY4Yn9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7D14A32;
	Tue, 18 Jun 2024 00:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718669572; cv=none; b=cIsngI/L8lj9Pk9+UX39L5VCXtBhXeiQZLNEWI+Y0JEQZ4x68eyC+/ZK00A7sdeeysOXhHJkRhUpUBifRF0cnDmLsnq77US018Sgp7Uf+qkJgPa1rJczbav5PF7nQX306zAbmB1XL5OhG7rbsjm/bTBW9xQWouV1adt4dwLC+Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718669572; c=relaxed/simple;
	bh=ZssrfLhGo7qeCAZkP0oTbUOoz0gnwOHAEKILuErktGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tw5Ru6v4ka6nGjjq3FGACeJYVI868uI0RUozQn5428ByY+mBZAmYRhHYv35eWhMSxK2N8h+wePE/MFvkm0+/CFqczUxA8mHGwLeJTgpvhkrfoKabQUBHhMYYoUXfHde2pNw9b6dPJWGEC0XKDAG9EIl+VU2bbTz572JEO5p+T8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MRyY4Yn9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HHwNA3014973;
	Tue, 18 Jun 2024 00:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D/eU246qe6pmI10E2leuVzYg6Wzmy58R9WJLAW2mwJc=; b=MRyY4Yn9mruKyAIg
	FV/sJKk3SeQTrOEjtC45UXFrwFX4sj9e5xXim3VqiDL+HXcVlssXMmK0jn3AL3V6
	5eFZHILFc2KplLewAUs9lHSmHF6N0ixcQi+0ilNfaM8YPas+N6alMdH7iLMUf+v5
	Tkeq/SqwpNxTX1fZ3I+73MqfPVNB4Dsmmkocoy0u1aeZhCszWCe9lQZaTEPEvNTx
	NZp8gIu6OY2LS8PMYzcYc3QAwiCcHILsPTaMSJBS0vAl+RcZMPDoDkNhwRymd9Ji
	A/9YM7XxZ5cn246mpYPNtylQkTFuU2+A3lwUFZj8w1nXbic2RxisXwA0gZrIVFVV
	vOMrdQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ytt0trq0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 00:12:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45I0Cbtg001808
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 00:12:37 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 17:12:31 -0700
Message-ID: <6f0d6ef8-fc15-43f5-8106-8b96d5045243@quicinc.com>
Date: Tue, 18 Jun 2024 08:12:29 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] arm64: qcom: Add BWMON support for SA8775p
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <krzysztof.kozlowski@linaro.org>, <djakov@kernel.org>, <robh@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20240617092940.1724962-1-quic_tengfan@quicinc.com>
 <yb3ni6o22zdm2lqodj7utdb2dlg3jkbwzutxhmljxle3syoe5y@op2prslmri4y>
 <d997f42d-0616-4180-ae36-9d2ebd60d15f@quicinc.com>
 <3yrji5rrzrfj3j4bekvhos36mgafbdcufsslk5daqfn7y5k2qz@k3nrrlbnlsmb>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <3yrji5rrzrfj3j4bekvhos36mgafbdcufsslk5daqfn7y5k2qz@k3nrrlbnlsmb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EFXOKuuUp6XqD6QDz4FmZd3LcKPXj2Ch
X-Proofpoint-GUID: EFXOKuuUp6XqD6QDz4FmZd3LcKPXj2Ch
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180000



On 6/17/2024 7:00 PM, Dmitry Baryshkov wrote:
> On Mon, Jun 17, 2024 at 06:42:42PM GMT, Tengfei Fan wrote:
>>
>>
>> On 6/17/2024 5:43 PM, Dmitry Baryshkov wrote:
>>> On Mon, Jun 17, 2024 at 05:29:38PM GMT, Tengfei Fan wrote:
>>>> Add CPU and LLCC BWMON nodes and their corresponding OPP tables for
>>>> SA8775p SoC.
>>>
>>> This series is marked as RFC, Request For Comments. What kind of
>>> comments are expected for the series?
>>>
>>
>> I found that the BWMON patch for x1e80100[1] is currently under review.
>> There are upstream comments suggesting that we reference the same shared OPP
>> table from all the BWMONs that share the same OPP table. However, there will
>> be some DTBS CHECK warnings[2] if we do reference the same shared OPP table.
>>
>> Therefore, I pushed this patch series to collect some comments on whether we
>> can have separate OPP tables for each BWMON, as the OPP table of
>> "pmu@90b5400" and "pmu@90b6400" in this patch series.
> 
> Thank you for the explanation. Now why wasn't this a part of the cover
> letter?

I think I previously had some misunderstandings about the cover letter. 
I mistakenly thought that certain information should not be included in 
the cover letter. In the future, I will make an effort to include 
complete information in cover letter.

> 
>>
>> [1]
>> https://lore.kernel.org/lkml/4ef1d9a9-6a0e-4324-b6d5-2ae225855b03@linaro.org/
>>
>> [2]
>> arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: pmu@90b5400: 'opp-table' is a
>> required property from schema $id:
>> http://devicetree.org/schemas/interconnect/qcom,msm8998-bwmon.yaml#
>>
>>>>
>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>> ---
>>>>
>>>> This patch series depends on patch series:
>>>> "[PATCH 2/4] soc: qcom: icc-bwmon: Allow for interrupts to be shared across instances"
>>>> https://lore.kernel.org/lkml/20240604011157.2358019-3-quic_sibis@quicinc.com/
>>>>
>>>> Tengfei Fan (2):
>>>>     dt-bindings: interconnect: qcom-bwmon: Document SA8775p bwmon
>>>>       compatibles
>>>>     arm64: dts: qcom: sa8775p: Add CPU and LLCC BWMON
>>>>
>>>>    .../interconnect/qcom,msm8998-bwmon.yaml      |   2 +
>>>>    arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 115 ++++++++++++++++++
>>>>    2 files changed, 117 insertions(+)
>>>>
>>>>
>>>> base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
>>>> -- 
>>>> 2.25.1
>>>>
>>>
>>
>> -- 
>> Thx and BRs,
>> Tengfei Fan
> 

-- 
Thx and BRs,
Tengfei Fan

