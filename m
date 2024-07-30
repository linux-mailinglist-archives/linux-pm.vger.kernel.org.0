Return-Path: <linux-pm+bounces-11627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6343F9407E9
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 07:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B871C209D5
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 05:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89BE16B398;
	Tue, 30 Jul 2024 05:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nDihZmxY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14402433B0;
	Tue, 30 Jul 2024 05:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722318748; cv=none; b=soB5Z+BBuiWG04mqy18R1R1M1eSWR9WcS0mj02RGiguALNMUMaIAsQGAkv6P7ylaFu6eNvUlOrnThyjHQjrZIe/9Z/ymQZAh0su1TFTY0oFZtO7fm/Uh6iPFBAw46YiA1pKd013HKQlco2uxlB4SQkZI94ssR3gOmateuLCKWnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722318748; c=relaxed/simple;
	bh=nE7jjEKTwckzzETESkPd4crYWSCC/Jr3+g+SALsvf0E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXO+tYniQBHO17pX/RtkFy+Gu9SnlIH3FLoXGitDia+yKMveXxiDOCue2Wx0l2ERJPczEyUDsKMgHQ/1UteL4+Rgcm539GptRHd+zzNWltMal2QkrrRoMtDmCtFErb0gJsQZsngT3fc/LJdjGGe8+xbqTnJXBEzBvaBWDt6XWy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nDihZmxY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U29NoF029983;
	Tue, 30 Jul 2024 05:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nE7jjEKTwckzzETESkPd4crY
	WSCC/Jr3+g+SALsvf0E=; b=nDihZmxYfX6HUMk5RZNYwDfnNpp1bkca5LXWMpXC
	s92Je4AyRZxdNRIaxkOEsTetVpkJRXo4ZTq9boAeoPpiEcnHeM3ydOePnKLBvabC
	9rvulAK1D0v+6AVsESPmKcDsZONuUacTL2iqmzzzoSZ1rjmvFS8bng5iRneqjUUJ
	kPM9EGiqL1P/AdJPpdj+NN5qrLeNcBta68ujf9H1ieCVGTqBiajcT8ZmOm+3RXaK
	6HWDzDBvbWYr4/EwmnSfW2/VCgp/zca7xUCBcpdry6umlw332dL88CAnNxlmL2i7
	R1MtQWZaY8f097Jv6ExwFYcI9IQVcXNZRHBUmnucloHEbw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40pq520dd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 05:52:22 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46U5qL6Q013456
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 05:52:21 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Jul 2024 22:52:15 -0700
Date: Tue, 30 Jul 2024 11:22:11 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <quic_wcheng@quicinc.com>,
        <quic_kathirav@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 2/5] dt-bindings: usb: qcom,dwc3: Update ipq5332 clock
 details
Message-ID: <Zqh/i0uGmTYHM1g8@hu-varada-blr.qualcomm.com>
References: <20240725104528.3504967-1-quic_varada@quicinc.com>
 <20240725104528.3504967-3-quic_varada@quicinc.com>
 <3ae2671d-d8ff-426d-8cc8-c1603e616f8c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3ae2671d-d8ff-426d-8cc8-c1603e616f8c@kernel.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qa2LLskEPLVTNPVcM4C3u54VV0XsPi-E
X-Proofpoint-ORIG-GUID: Qa2LLskEPLVTNPVcM4C3u54VV0XsPi-E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_06,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=520
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300042

On Mon, Jul 29, 2024 at 05:13:04PM +0200, Krzysztof Kozlowski wrote:
> On 25/07/2024 12:45, Varadarajan Narayanan wrote:
> > USB uses icc-clk framework to enable the NoC interface clock.
> > Hence the 'iface' clock is removed from the list of clocks.
> > Update the clock-names list accordingly.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
>
> Explanation you gave in v4 should be in the commit msg.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Have posted V6 with the updated commit msg.

Thanka
Varada

