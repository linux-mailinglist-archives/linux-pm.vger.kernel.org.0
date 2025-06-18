Return-Path: <linux-pm+bounces-28984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8B0ADF0DF
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 17:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E9B4A12A7
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 15:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E822EF644;
	Wed, 18 Jun 2025 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TYjo1P9E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEEC2EF288;
	Wed, 18 Jun 2025 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259633; cv=none; b=kTgRE1aKNCXjrs6sbIvGsjVjbWjwoH4q/bmGjyjq51Ak6KTHbsQhbWsNh8llBF83O79TVCvm8hRTE6kasg0M8NBnpGw3B4Bo7uV2M8qBI7w/Fyw1T6XnIJTeMintFECyapvcOAfHvwELiYpXR9w/3tBlDg0tp3IkDtnr4ienPsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259633; c=relaxed/simple;
	bh=Z4WjAjhgs+9cAWXseeZVzK0u2AHpialFbmIzK+axu28=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dj1wVyMklGHjYPPxQtgxgyZr5fqFwUx/F5MLthBL0cwLZmqsOexdDDGP3OFbUa3NGXXV9Z+HM6eELhi8mu9YDofxxt2jb3G4NuRy0DSRzcX2/sdhPxDaEHNe1TypMApXd800F7I4Ofa1rWeIADjQv5eFHDn6TAV+gheE2uuanuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TYjo1P9E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I9231C015638;
	Wed, 18 Jun 2025 15:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BvKiGeQQXdoaNRy8cKQkU1P8BTdh5zPp9R1GKNeEFeA=; b=TYjo1P9E8jrf+vtK
	B4mqkoC4jb/sodFzM6AqHQTtwsNRTuu9renvffElLBm9SfU4atamvmnSw5uByu59
	UC/x0S/ZLi/QUiTrP2veC77Sher2JDnL/q7YCqhS7A5JEplsuUcq0jJGrlubh3LD
	J9ImWWK8Ato2Iydzv6MfOlave32KwxbSIVgUlkvLBrEwn62TvxsBjsi5e5L8+D9x
	AjSqJ0tIdFE4lK1OfM2MA/t4jJvQZiSKuUgq9p1Gv2Pi7eTzWH/OOYSzQCSiyCAu
	D99lXvCCq7RhjWKwmMdpGHcFDZSt7kO5t+SocCmSpyJbzgQpZGwFPy1dpaFwCKI2
	xOchng==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47b9akv2nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 15:13:33 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55IFDWEE028125
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 15:13:32 GMT
Received: from [10.253.36.28] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 18 Jun
 2025 08:13:26 -0700
Message-ID: <c2cefd3f-3579-4c41-ac0d-08869b51eaaa@quicinc.com>
Date: Wed, 18 Jun 2025 23:13:24 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] dt-bindings: interconnect: Add Qualcomm IPQ5424
 NSSNOC IDs
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
 <20250617-qcom_ipq5424_nsscc-v1-1-4dc2d6b3cdfc@quicinc.com>
 <8fc66f04-27f1-416e-b7c5-d3045e94f13a@kernel.org>
Content-Language: en-US
From: Luo Jie <quic_luoj@quicinc.com>
In-Reply-To: <8fc66f04-27f1-416e-b7c5-d3045e94f13a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: erdZe8h3cOfKGCAKK3MbpbXil2YGXIBE
X-Authority-Analysis: v=2.4 cv=UPTdHDfy c=1 sm=1 tr=0 ts=6852d79d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=P-IC7800AAAA:8
 a=wEgfWPuv0KXlM2Taas8A:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDEyOCBTYWx0ZWRfX2T73sEv55TzK
 bd2uZbTfg0L2+P63qECMxQqLAgBX2DldXYERVfx46bZMKKPLfF2m2RhfjgFcVOZEuE4XNfFWlsd
 nJ1lMYGAsx28VCZ4X6AHBVTB3KHgCZhwKX3iync4b5clhbKFfgpGpUW+siJEWZEDUtTTj8Ov3wu
 T8DMEg9q5dqS0AbTDaTfWYtxJsxo6WcbNoGnA6iAPSo7yE+XVn3rrKJ1Qwn3M6+RgHi/cyx1n/s
 W/NEleWEOfIT5bnL8U7JkKn3swRxzRj1griirdwWD6ZtpVLcOuq1KpyQaRePkmfvmcsG737i6Pu
 oSO5jXusIIxamwQteRvkWI1Z7Xc+LQqxZ9KP5RGns6l3pISoYctKUucmLVaH3WTmLTjY0g14juM
 EEkz9RU0o8WdTO1HhTcHbwhcZyeIQtMIEXBENvD8epVD34qMTdBdbGJBhsAV4SkvuE5544jG
X-Proofpoint-GUID: erdZe8h3cOfKGCAKK3MbpbXil2YGXIBE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506180128



On 6/17/2025 10:47 PM, Krzysztof Kozlowski wrote:
> On 17/06/2025 14:06, Luo Jie wrote:
>> Add the NSSNOC master/slave ids for Qualcomm IPQ5424 network
>> subsystem (NSS) hardware blocks. These will be used by the
>> gcc-ipq5424 driver that provides the interconnect services
>> by using the icc-clk framework.
> 
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
> 
> Best regards,
> Krzysztof

Thanks. I will update the commit message to follow the guideline.

