Return-Path: <linux-pm+bounces-9860-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F309141C5
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 07:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B896280FEF
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 05:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94A017996;
	Mon, 24 Jun 2024 05:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LH2Ra4VX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B3618039;
	Mon, 24 Jun 2024 05:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719205518; cv=none; b=bsVdQu1MFqCPM03YqOVTyrtbB+L40hMFcaoCm3GamFa4dVgXe4+jIuoaiRDzmv2G76TP9MYyN1Cgh1kD7Eh2TEkU13ZDe4NJioSVK3cSw1mQ1OTzPCJKSrvIMDebIH1A/uDsMZDrz8Ll1UdlophI1NbyL5ynbfD/xcGvlYgqLA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719205518; c=relaxed/simple;
	bh=VDea9JZ/VnAkeiodG4ZUOo+AIKC6dTvRIqSwpoH2Yf0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXdwNjBGczg2/jHtQ3I15Wya/J63A7v4puTDZbLBOhEPCszfIS78dMRwkBU9BH0wyX2uoySERWTYFeoI8bRA40ugBvfuNG0dzttaOKtjvFLWM14IhIE8XUADVXsdH4lOjlwSislx7G1P1PEqAXvaNIVye2JcSDO6ApYJ3sayXOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LH2Ra4VX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NMvdjR002875;
	Mon, 24 Jun 2024 05:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VDea9JZ/VnAkeiodG4ZUOo+A
	IKC6dTvRIqSwpoH2Yf0=; b=LH2Ra4VXAU89VyZUh/qxDxt9MK/mOOI1SX1OSn3/
	3YeRFxj7FdJttGI4EeS76ITi/vj3Gn6v3Dc4dXFL3ewsb1HOmo2nHhRWHYbRHmFm
	vqmziq8eGnyOtyGt8exyK/cG7DD7HknwnZH+chhaGtNn/Q8dl+tu/L1DCMW4Jp5L
	kDpAvMX6tpLbixEYGh7w/uWBRmpxSwO97JpwcWUpPt+CeBnkOrsDXaP9cdepWp+y
	I5mimvi8RNTMZo8wL1pbBQ+arsTnlvF8HmBlg45Hit9vmKpFnxSdH/TKEVPHQsuO
	3Jfx6kE7TRoL+Ufddq6u8wbwijH0daXmnj6N3LR+lQgxYg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqshjp57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 05:05:06 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O552vr021314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 05:05:03 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 23 Jun 2024 22:04:56 -0700
Date: Mon, 24 Jun 2024 10:34:52 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <quic_rjendra@quicinc.com>, <luca@z3ntu.xyz>, <abel.vesa@linaro.org>,
        <quic_rohiagar@quicinc.com>, <danila@jiaxyga.com>,
        <otto.pflueger@abscue.de>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: Re: [PATCH v1 3/7] pmdomain: qcom: rpmpd: Add IPQ9574 power domains
Message-ID: <Znj+dLEefZWOWqx+@hu-varada-blr.qualcomm.com>
References: <20240620081427.2860066-1-quic_varada@quicinc.com>
 <20240620081427.2860066-4-quic_varada@quicinc.com>
 <jfh2xygjdoapkno2jrt6w7thlylgyp2tk7oaczundhxvi26qel@ahtskgn4v6sp>
 <ZnUsFwQyc7JRTXl/@hu-varada-blr.qualcomm.com>
 <jqptvxu4ovvau3aqunfegtr34w5ynk3jjjza2iebhhkzyeuuib@bzvwscd57hoz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <jqptvxu4ovvau3aqunfegtr34w5ynk3jjjza2iebhhkzyeuuib@bzvwscd57hoz>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MapNJ4gECFMKMJlsmZz6iLeE-UwjeooU
X-Proofpoint-GUID: MapNJ4gECFMKMJlsmZz6iLeE-UwjeooU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 mlxlogscore=571 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406240038

On Fri, Jun 21, 2024 at 11:55:10PM +0300, Dmitry Baryshkov wrote:
> On Fri, Jun 21, 2024 at 01:00:31PM GMT, Varadarajan Narayanan wrote:
> > On Thu, Jun 20, 2024 at 06:09:51PM +0300, Dmitry Baryshkov wrote:
> > > On Thu, Jun 20, 2024 at 01:44:23PM GMT, Varadarajan Narayanan wrote:
> > > > Add the APC power domain definitions used in IPQ9574.
> > > >
> > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> > >
> > > The order of the S-o-B's is wrong. Who is the actual author of the
> > > patch?
> >
> > Praveenkumar I <quic_ipkumar@quicinc.com> is the actual author.
>
> So the order of the tags in your patch is wrong.

Have fixed this and other comments and posted v2.
Please review.

Thanks
Varada

