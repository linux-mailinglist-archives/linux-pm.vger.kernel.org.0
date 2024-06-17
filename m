Return-Path: <linux-pm+bounces-9321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6100690ABCF
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 12:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108861C21A29
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 10:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12E7194A7F;
	Mon, 17 Jun 2024 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GU+DrT2E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8F91940B3;
	Mon, 17 Jun 2024 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718620998; cv=none; b=kyoVgUuV9ppf/nDC3t+CIaHr8b6S7xGJRpVODfXoeg13RSaA7ZWPg5PrHW9nPXiIGHMSSKSvcBPqzckNLXCEB6ZAcQ67Ug7WUhLyWMlXYggne6QLcu6xkGyNPMXOEKY+51b+2vv1wxADLkBVXorCdDnbRMGm6HZUGz5CCjOiLQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718620998; c=relaxed/simple;
	bh=i3uW3NOlbKjP4qf5Axhnm99g5Mt2/WaSNm74QRBZhrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DYIB36JFbcfDYSzO4pC8Tjs7HszQLb7KezKbatwZ66WefUv6/dgSIt7FcKOc1HctK1QCB/defWSk23gOhKYVgvaU5cPd/ZgSexj/C1H7PuXScWXPbR5jN2J1kXx5/VPp1HH5olXWVCLEfBs7XyaM01C339KBuyQAWoQl0/3ILbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GU+DrT2E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HAV4AN022722;
	Mon, 17 Jun 2024 10:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bdp0i5ngaQ4+E3qeMMivqEtEmbMZP+Ab6cxXPFCoqi4=; b=GU+DrT2EFZYzEdN9
	PfiCUEpuzSe7po74u5oQyoo/MFz91HLLm2XDVZkg4+uNi/nhgjfFtCW7/W040n0e
	BV1vwfwE0sXoXRVQ+elan9KRofQmQcBlxhbPUc2XdHoqqBedIgeBtmul1i2F5xjP
	eM3V4LJxtCNk/Uy1eUZglE936MHUbxujFE7IIDkczqLCuh25uxjBipWH6CZ3yCnT
	fhQSh9+W2LRgzsoZVKcW1cN2Drt6A0puwAR68wOcktuQsmfoVZtMPJApkiGJZcBO
	1asxBWDvl/V2MAx89YJiu+fuqH7gbMYapuQEQuUMfkN4lDWTD0XMaQ+3QlftVRMV
	KgzLKw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys44ju8e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 10:43:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45HAgpTl004802
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 10:42:51 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 03:42:44 -0700
Message-ID: <d997f42d-0616-4180-ae36-9d2ebd60d15f@quicinc.com>
Date: Mon, 17 Jun 2024 18:42:42 +0800
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
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <yb3ni6o22zdm2lqodj7utdb2dlg3jkbwzutxhmljxle3syoe5y@op2prslmri4y>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mEQjeyQ3u3zLNnSMTaiIYoE__gGc83dK
X-Proofpoint-ORIG-GUID: mEQjeyQ3u3zLNnSMTaiIYoE__gGc83dK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_09,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=976 spamscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406170082



On 6/17/2024 5:43 PM, Dmitry Baryshkov wrote:
> On Mon, Jun 17, 2024 at 05:29:38PM GMT, Tengfei Fan wrote:
>> Add CPU and LLCC BWMON nodes and their corresponding OPP tables for
>> SA8775p SoC.
> 
> This series is marked as RFC, Request For Comments. What kind of
> comments are expected for the series?
> 

I found that the BWMON patch for x1e80100[1] is currently under review. 
There are upstream comments suggesting that we reference the same shared 
OPP table from all the BWMONs that share the same OPP table. However, 
there will be some DTBS CHECK warnings[2] if we do reference the same 
shared OPP table.

Therefore, I pushed this patch series to collect some comments on 
whether we can have separate OPP tables for each BWMON, as the OPP table 
of "pmu@90b5400" and "pmu@90b6400" in this patch series.

[1] 
https://lore.kernel.org/lkml/4ef1d9a9-6a0e-4324-b6d5-2ae225855b03@linaro.org/

[2]
arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: pmu@90b5400: 'opp-table' is a 
required property from schema $id:
http://devicetree.org/schemas/interconnect/qcom,msm8998-bwmon.yaml#

>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>
>> This patch series depends on patch series:
>> "[PATCH 2/4] soc: qcom: icc-bwmon: Allow for interrupts to be shared across instances"
>> https://lore.kernel.org/lkml/20240604011157.2358019-3-quic_sibis@quicinc.com/
>>
>> Tengfei Fan (2):
>>    dt-bindings: interconnect: qcom-bwmon: Document SA8775p bwmon
>>      compatibles
>>    arm64: dts: qcom: sa8775p: Add CPU and LLCC BWMON
>>
>>   .../interconnect/qcom,msm8998-bwmon.yaml      |   2 +
>>   arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 115 ++++++++++++++++++
>>   2 files changed, 117 insertions(+)
>>
>>
>> base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
>> -- 
>> 2.25.1
>>
> 

-- 
Thx and BRs,
Tengfei Fan

