Return-Path: <linux-pm+bounces-10913-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A761792CAA8
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 08:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 371D6B22651
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 06:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9564E7174F;
	Wed, 10 Jul 2024 06:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ua5hpEGa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC414174C;
	Wed, 10 Jul 2024 06:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720592150; cv=none; b=WU8BmBZ9ttc7fjqqRi5plQ8bPdLIXN71mpPdkk964P1kVs378zEmB1uab6TDEyjYZpGuAXlHgJo0xgCnnYyHqxxu3BuFlTYutOz6vaSCARKtKvKkgDn4Ee+W725M1j2SNFzMCLyjxrKToZlOPcJCrrb/Mt7UK4x6mn/lrSR7n/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720592150; c=relaxed/simple;
	bh=y0Ae7eA352rTkkXZKhSY1RsSKoR9JQgMBiR1kM95uRU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnUCP/kVs+lGSTr2cDyQX7ROuP8Q0atyYMA22jhtO2pJWffbNFpF0qoSZGX3CKNP0on8RlhZxtI9/YINz6DDCK5Y7yN7O0jERGxBA+KsP1YmVwNz+ptkgKWQ2bbxqnIddix2rpZD2bxo+9jABU6ncik594wBM14+aeawxmWTsOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ua5hpEGa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469KpLt7016975;
	Wed, 10 Jul 2024 06:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Xm/hz+/GEvN/jtsQGBaziK4j
	+UZetj/kf80vnczSJW8=; b=Ua5hpEGaUV6XFrEeyrXHVBziUKBB+hcTG3XGVlOf
	7FjwCu8xAnYuHm2m0IZLknvwt3aoot663M6ZAHYDJn/gwJqjg+snun3rZYZsshcj
	v6xPf6l9D2t38CV0bw2VZSSXOC6MvUOkUF3fqqLXmtnRYj3dHaxlX0bC0aUdd2xS
	aJ+I1mfOd6yExyZSSTKjR6jT3DN4ER/+e6G4m1LHjiXmVqrrhWSlj5rvRyGuSRwP
	0+EFNiSLJT6FibDr+Lj826Gg707IBPLl5WiaEpKYQhPIGcnd6Ew5kvxHo77oq1t6
	06ifM/+Uq/y/8pg722pNiAgtBmk9PpJ+KKfooI6ElQupxg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406x0t8kx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 06:15:27 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46A6FL2h004000
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 06:15:21 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 9 Jul 2024 23:15:14 -0700
Date: Wed, 10 Jul 2024 11:45:10 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ilia.lin@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ulf.hansson@linaro.org>,
        <quic_sibis@quicinc.com>, <quic_rjendra@quicinc.com>,
        <otto.pflueger@abscue.de>, <luca@z3ntu.xyz>, <danila@jiaxyga.com>,
        <quic_ipkumar@quicinc.com>, <stephan.gerhold@kernkonzept.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 9/9] dts: arm64: qcom: ipq9574: Enable CPR
Message-ID: <Zo4m7pBhXbzNLZh4@hu-varada-blr.qualcomm.com>
References: <20240709090132.117077-1-quic_varada@quicinc.com>
 <20240709090132.117077-10-quic_varada@quicinc.com>
 <94e9aea3-6231-4dbe-9a7d-07f79216e78b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <94e9aea3-6231-4dbe-9a7d-07f79216e78b@kernel.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ilmjQJAGn6569mie9UNxTYJjYMuM1Z_i
X-Proofpoint-ORIG-GUID: ilmjQJAGn6569mie9UNxTYJjYMuM1Z_i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=407 priorityscore=1501 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100047

On Tue, Jul 09, 2024 at 11:04:52AM +0200, Krzysztof Kozlowski wrote:
> On 09/07/2024 11:01, Varadarajan Narayanan wrote:
> > * Add CPR, RPMPD, OPP table nodes as applicable to IPQ9574 to
> >   enable CPR functionality on IPQ9574.
> >
> > * Bootloader set frequency 792MHz is added to the OPP table to
> >   the avoid 'need at least 2 OPPs to use CPR' error
> >
> > * Remove 1.2GHz as it is not supported in any of the IPQ9574 SKUs.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

Sorry. Have posted V6 rebased on top of Konrad's latest version
and rectifying the subject prefix. Please take a look.

Thanks
Varada

