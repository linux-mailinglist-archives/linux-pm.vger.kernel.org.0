Return-Path: <linux-pm+bounces-19994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC336A03122
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 21:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4557A3A214D
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 20:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFA31DF260;
	Mon,  6 Jan 2025 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NwZnOmFA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2471D5CF4;
	Mon,  6 Jan 2025 20:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736194001; cv=none; b=uvwTKeiiwhan6qnD/GgtfkvZX10KLPrFN23eBjGrmp153qTUozdOCwxuQpse5RXO5FGN+V/2BBsVv6vQSeoTcrADqEuxHEMJiWr0ktHgbyLoZpvx9qa0vmds6V8i9uOWN0zXTOfPuBYg/C7a71uSZwqWEK6k5dg2Ad+6ZvEMJoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736194001; c=relaxed/simple;
	bh=ZskdcjSZHDk+YnBFKSSXMOTUIwwh1x/l4PXqRhHaIpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=US1D4ktqT1gDsqRgT9Ys3zWO/S/a77qB8+c74uGCLMAaQwaCGWPoLJW3kQswxw2Z51PwYrlvcGtw/bPTpHXmEbuIU9CnYeGUZK0QRkfEqJSW2MT7ZqEKN27DReneUChiZlq182GdokSBiLLuyvmkCreeYuVFfpDHzWIyJK1TzuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NwZnOmFA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506HwUdG005564;
	Mon, 6 Jan 2025 20:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q7fqXg026ZAnMZXN1MXFj57rk/uuZQXlz7QDDo9fMcI=; b=NwZnOmFAOz6Cputz
	4hbte5VN4Uie2H/E5ZpDAZmW8BymOO5tsE2odCfRoy/nC6GRcFNWhyQucKakihE6
	G31uPNjRQ7oUrR/L4Z+i0F+zK44RuCanmV3GmsmwYuRVXLhhYxbRpSRkRzSVr3QP
	M1QwhK5crGmrctRPeUkjVIf5eutVu2NkLeM+S+be1jZ0e/42X143ifw3YPigX/Qb
	3ZKlMIpp9I8yLNrMR6IqNcs6AV59MRpKxuvXJGgdVHB7aDlEBvSD0p/Wb/O0MJjs
	fzWWp2JMRC1yAWLWft8Rtipi1Noc1/nf5df0wXN9n05iRXLfqywqjfr8HJYmMuNc
	Sw4y4g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 440m20r87h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 20:06:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 506K6TaK016447
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 Jan 2025 20:06:29 GMT
Received: from [10.216.24.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 6 Jan 2025
 12:06:22 -0800
Message-ID: <7380a14d-4d96-42b7-97e0-9916717d62a0@quicinc.com>
Date: Tue, 7 Jan 2025 01:36:19 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] drm/msm/adreno: Add module param to disable ACD
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark
	<robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon
	<nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20241231-gpu-acd-v3-0-3ba73660e9ca@quicinc.com>
 <20241231-gpu-acd-v3-3-3ba73660e9ca@quicinc.com>
 <3f33a94e-3fb2-4df2-91f5-59a92f5094f0@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <3f33a94e-3fb2-4df2-91f5-59a92f5094f0@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -Q0R83qpC8B5CHgb51nLn0-BYHpE2k4J
X-Proofpoint-GUID: -Q0R83qpC8B5CHgb51nLn0-BYHpE2k4J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501060175

On 12/31/2024 4:02 PM, Konrad Dybcio wrote:
> On 30.12.2024 10:11 PM, Akhil P Oommen wrote:
>> Add a module param to disable ACD which will help to quickly rule it
>> out for any GPU issues.
>>
>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>> ---
> 
> Is that something useful during internal development, or do we
> see ACD causing issues in the wild?
> 
> If the latter, would that be caused by e.g. outdated firmware?

It is rare to see ACD issues in production because there is pretty
stringent testing done during development. Still, disabling ACD is one
of the first thing we try because debugging HW spec violation is a
nightmare.

Regarding firmware, yeah, it is possible but rare in production.

-Akhil.

> 
> Konrad


