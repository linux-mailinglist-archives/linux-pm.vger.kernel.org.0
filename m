Return-Path: <linux-pm+bounces-9096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9926E9079D3
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 19:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9933DB24BEB
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 17:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6118914A098;
	Thu, 13 Jun 2024 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IW7+bqMx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD26149E06;
	Thu, 13 Jun 2024 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299694; cv=none; b=k6tuOgpc0EpM8NUMuxnf/fqTRER3dE/QPzMDgh2nfgBcgnUKUcxJA76KzIuIDKGceurU2BgXm7SqXveCDtLSHQ9ZlQEdb7bycdPlL8F9rnoVosV/cuYSYN5Xz+Bt9nG/57DL4vjx6s6rweDhbrin0l/GikHqRSL2UgYG8dp04Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299694; c=relaxed/simple;
	bh=CNrPcqc8022Bt4QwcjS0SE8OmQ9gGgaggZXF2mwS7Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aQ1yv/IzvVTTCNHlWFiCTrkkylP0dI/Qg/JXyzCRi7J5SE0s1CIMp5QQqOgyc9lB/zGbEz3mflK1zhcPAIXdvabGK19Da7v8SGzYIe3McnZdD0xKp31Ut18qgvnzslPJZuTVc4z9/MxM0P9fUYyp9/xvx6ztdXwiP+uwLQSXNV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IW7+bqMx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DDhZB5018436;
	Thu, 13 Jun 2024 17:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aA7Z5zxsmTlozGn3Npa3uDeUxg+iQykh1R92quahMZ4=; b=IW7+bqMxXd9aIbTL
	YszADtwGo7MbJN/pvNr+9ATdgZDipa6o+10/aKhV2y1/U6pFFuFVwWiaSrj+cmCH
	d2Qx9mAiXj0nbXxvNy0w2jBbot99WWaJ4EAb3Xubk8DrRevyd5COVrG6AypYrhnq
	zKz5oZfQCSgw4QV8earayidPNPyQMFHMe6xI9llsyuoxKl1mFgyZ9R4WWAufuzFB
	qivFodtPq//GhBfGoq6wcxX3Nha2r2ZRpomxhMPf4RrkTGVCf5LNDEyvKX/xiKh8
	EzyuvOPS/xLpMjf4aoHQ4u2s3EG7f3vxERLzkIEwUdA0fe1IBadJXeheTa4xPnbt
	a49wvQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yr1wfgp7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 17:28:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45DHS7vb017418
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 17:28:07 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 10:28:02 -0700
Message-ID: <24d2d3b3-d676-8e86-bae4-c3538b7b9981@quicinc.com>
Date: Thu, 13 Jun 2024 22:57:59 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/4] arm64: dts: qcom: x1e80100: Enable bwmon and fastrpc
 support
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <djakov@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <conor+dt@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <abel.vesa@linaro.org>
References: <20240604011157.2358019-1-quic_sibis@quicinc.com>
 <be2dc908-c8d3-4739-9f46-8f8daf0f328e@linaro.org>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <be2dc908-c8d3-4739-9f46-8f8daf0f328e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NyH2GTLbNEYNrJDtmz0cvT1ZdMXWEzf_
X-Proofpoint-GUID: NyH2GTLbNEYNrJDtmz0cvT1ZdMXWEzf_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_11,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=797 spamscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406130125



On 6/6/24 16:00, Konrad Dybcio wrote:
> On 4.06.2024 3:11 AM, Sibi Sankar wrote:
>> This patch series enables bwmon and fastrpc support on X1E80100 SoCs.
>>
>> This series applies on:
>> next-20240603 + https://lore.kernel.org/lkml/20240603205859.2212225-1-quic_sibis@quicinc.com/
>>
> 
> Going back to [1], is memlat-over-scmi not enough to give us good numbers
> without OS intervention? Does probing bwmon and making some decisions in
> Linux actually help here?

Memlat and bwmon are meant to cover to different use cases. Though
they have a big overlap on when they get triggered bwmon is specifically
meant to address cases where band-width aggregation is required (meaning
if other peripherals already have a avg bw vote on active LLCC/DDR, the
vote from bwmon would be an additional request on top of that). However
to make use of this we should vote for avg-kbps in addition to peak from
icc-bwmon driver which we don't currently do (Shiv was planning on
sending a fix for it).

-Sibi

> 
> Konrad
> 
> [1] https://lore.kernel.org/all/20240117173458.2312669-1-quic_sibis@quicinc.com/

