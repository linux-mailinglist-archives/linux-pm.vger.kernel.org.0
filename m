Return-Path: <linux-pm+bounces-28985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C07FADF0ED
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 17:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB653A4829
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 15:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18ED2EE5EC;
	Wed, 18 Jun 2025 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ksa/ve93"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA50374D1;
	Wed, 18 Jun 2025 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259766; cv=none; b=W0Sl+xqHAKE45lyr0S+8xkc+FkNDq/ssdHzJBGxs1F3tGIreyyaG49m9b64som5HEnVWVMMZ5QrVEscx4wO/AHELBJAYLSrGokN7pN9/3FpFO+t2+/3TzUMYErOEyJpA5E0JPOe6816qX17+l2qDADrJFXEQirTCMqwTn4Ea3dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259766; c=relaxed/simple;
	bh=A0uba17LICp30pwFRDCstfBdNh6sUK8C6iNknR+2KCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GUARnB4aXDVMbSHPhWACpwUJXRVmdUsAaUeoyJebxEBgS6y/tdRSVuRXCqPUuaPmWk/t6XH0jGE1aUih0z+t77UnN/0MfDJ5MgmItQIV/GIPBQgoMil4oa5LE+pWWhE9KrseWAI1RrQwSw5Uc537yrHr1rNAkET1Mpz1oO+fYEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ksa/ve93; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I9Gb46024672;
	Wed, 18 Jun 2025 15:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IwuISKemoPQD28NpL2ydZJyp4ovY/NMCIQMHrwff4/8=; b=Ksa/ve93ylRvGBBz
	dPxktfTWSpgdjSiG2sdRM+BwGuC0URyFEVjSWLY04RzYTet8Yv8eXUBF9JITYmi6
	XtxuJQA6mkKFrRheba7IRkNENH8TrzybTA/ODII4L7yVyVywk2GKmfg1ujTGczFQ
	OFE1rS3nC1uzhYYdnuFc6/FHolxJcKeF7Jl5AOkVzAWFDDjXbfYhNv8xLbXa5N6h
	ku54fXTXm1wkIyP+34sSGZAWXl3FDTJ+8od9c9oIWghCiZztr1pR4y7BOoEVE0G3
	oIaN85eSfKRdnMSl9aPDEVvUk2v+b222fl4hXtd/dB4KOv9rULAC8or/CZfINynj
	KCqs8A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4792ca4qeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 15:15:48 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55IFFmEY028752
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 15:15:48 GMT
Received: from [10.253.36.28] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 18 Jun
 2025 08:15:42 -0700
Message-ID: <0929a968-cdce-4a95-8d07-644940465e67@quicinc.com>
Date: Wed, 18 Jun 2025 23:15:40 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] clk: qcom: Add NSS clock controller driver for
 IPQ5424
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
 <20250617-qcom_ipq5424_nsscc-v1-6-4dc2d6b3cdfc@quicinc.com>
 <8281dbfc-6294-43de-ac0c-1e97b5cb4871@kernel.org>
Content-Language: en-US
From: Luo Jie <quic_luoj@quicinc.com>
In-Reply-To: <8281dbfc-6294-43de-ac0c-1e97b5cb4871@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M4FwtATtnAtjA2RR-tLowzWKQYDRibat
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDEyOSBTYWx0ZWRfX33F9B3/2Jyy4
 P9Il8b5MpR9XUFSkgIWqsNCY9zN+/nWeILbBQa3mFmVfyEXp9NJyLdK6nmVNsx1KlQEJZgTPdCK
 B/P/IChDRvrmXcmCLgyunHcpK0H2X00xZeikF1ZzwATtC5XDa2oXSg1oqTmyLKFuQ9WaO+/QaNd
 I/8Ya0uD+wSB9Ic/KU8JwseobI1CVmI1UPWXa2wcDa5MoMwPFUIl+gbgmDS6l+U5RQJWMsX/QMQ
 d8cJZBFqJ3pC4SxOaf8PQP3uaqeAF483rZywEzde5Xf96MK16uL/+YoxTAmqXv9EIaLAz0LiK9y
 hfL3MkgbfzBJ8SsHjfrjW12h78Nj8FFUBnbnHhFJ7CN1Xzb6/LwydZhzXW/5zMJWHuhVRkw+2rf
 iR42h8A5WNVTAvBeWSPzCeIEalCZRE4xGkfczee/sLgwU9IwLXJsXVqSYKAtIgea3zf7Sxgt
X-Proofpoint-ORIG-GUID: M4FwtATtnAtjA2RR-tLowzWKQYDRibat
X-Authority-Analysis: v=2.4 cv=etffzppX c=1 sm=1 tr=0 ts=6852d824 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=WS8sAOBzu-YLfLK63bQA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506180129



On 6/17/2025 10:50 PM, Krzysztof Kozlowski wrote:
> On 17/06/2025 14:06, Luo Jie wrote:
>> NSS (Network Subsystem) clock controller provides the clocks and
>> resets to the networking hardware blocks of the IPQ5424 SoC.
>>
>> The icc-clk framework is used to enable NoC related clocks to
>> create paths so that the networking blocks can connect to these
>> NoCs.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   drivers/clk/qcom/Kconfig         |   11 +
>>   drivers/clk/qcom/Makefile        |    1 +
>>   drivers/clk/qcom/nsscc-ipq5424.c | 1340 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 1352 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 7d5dac26b244..fc4755f18b84 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -281,6 +281,17 @@ config IPQ_GCC_9574
>>   	  i2c, USB, SD/eMMC, etc. Select this for the root clock
>>   	  of ipq9574.
>>   
>> +config IPQ_NSSCC_5424
>> +	tristate "IPQ5424 NSS Clock Controller"
>> +        depends on ARM64 || COMPILE_TEST
>> +        depends on IPQ_GCC_5424
> 
> Messed up indentation.

Sorry, thank you for pointing to it. I will fix the indentation.

> 
> Best regards,
> Krzysztof


