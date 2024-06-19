Return-Path: <linux-pm+bounces-9545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0155A90E4A5
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 09:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06ED91C21F22
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 07:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2A0770E8;
	Wed, 19 Jun 2024 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hH0J0IcK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4AD208B0;
	Wed, 19 Jun 2024 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782623; cv=none; b=UQV1tptvxI/hxQwzZ2YI2QMYn1nx5IVXYcM5foqdk+lnVlcUCkt27+MmJihwH9Kws9MA50y5f/dXapwfdrGvOOdUfGcnL6Q3K4vp+g8fvpZsbh3GEJorOBmAMfxUVkx9wg4cSXMtAUgyCzIdW1WwwvFEVV3BLcy+wdkGMivIdjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782623; c=relaxed/simple;
	bh=f7oSllmrd35P9uGR4eisbtJTPzm/dPPuS0q8bcjDQv8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhPll4HPpusZ4DL38SHjesR4B/y7JHskUNRjVmuTLGbcs0+0XeHCAl16JnZj06Js1chPdtpRF98BvJ1XdL2WolOVOKDClwfzfFSRT5mRcBG+zPF7vqEvFezy6nouQ6mT2rn6PLJTW/4kGdKZeFmV4E3UkCprnvt6/LE7dXO1c2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hH0J0IcK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILbEpH007379;
	Wed, 19 Jun 2024 07:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tedI/wDgAe2P2gAwrsKDr6tK
	yUDAAtGPLir7ppJx4as=; b=hH0J0IcKos3rnNxyMLyPbiT1gWcaGvAnOEL/aWsx
	FqceVDJrxBXW4nuGNJswI9ADyEfBgtFZwQPvg6gRk0ESLQWCPNXXutS5TxM1osqT
	fWxYEf72QmvA5+/rs1L4UNSJy55RCOjbBM5ELXxxoyt90IR5mb8nD4DmvoZ8Knej
	GwaYyzowvG00oC9Q2pEgWwOslSxM7uOn79Huc83nlWfJW8lv+jx6zASy0/ncTDKV
	2LQF6/dTb2zvv4Fxelyg7iAEEuUEI3HAPbg6Wy03ePKm+3d+wJWvRuoZjIS4+nC6
	pcvXKNpGRSO+uCbnM6MwzARdEatEpQR/6uFpzg9szQ8P2g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yujag0yh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 07:36:56 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45J7asqg007860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 07:36:54 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Jun 2024 00:36:50 -0700
Date: Wed, 19 Jun 2024 13:06:46 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>
CC: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v9 6/6] arm64: dts: qcom: ipq9574: Add icc provider
 ability to gcc
Message-ID: <ZnKKjomRQtJS2ZgL@hu-varada-blr.qualcomm.com>
References: <ZjshR0ekcn0gxwOa@hu-varada-blr.qualcomm.com>
 <CAA8EJpqENsojPQmCbma_nQLEZq8nK1fz1K0JdtvLd=kPrH_DBw@mail.gmail.com>
 <1a08ef42-b52f-4c97-90d7-e7fdee7725b4@linaro.org>
 <Zmgb+OjdBNw71sC1@hu-varada-blr.qualcomm.com>
 <176137e5-6312-4d46-97b6-c4494bc1c61b@kernel.org>
 <ZmlAdETV0+6Md8HC@hu-varada-blr.qualcomm.com>
 <e24cfd23-6f77-46a0-b020-9cb3daef6930@kernel.org>
 <Zml4RQ5R5s3mVMnI@hu-varada-blr.qualcomm.com>
 <8e32a8be-dbbf-49ca-92a1-2fe3c8bfb571@kernel.org>
 <ZmpsOdsl9AMTSH88@hu-varada-blr.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZmpsOdsl9AMTSH88@hu-varada-blr.qualcomm.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q23CxMHp9g3T2Lbye7KLJTHea_kt33mb
X-Proofpoint-ORIG-GUID: q23CxMHp9g3T2Lbye7KLJTHea_kt33mb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190055

On Thu, Jun 13, 2024 at 09:19:13AM +0530, Varadarajan Narayanan wrote:
> On Wed, Jun 12, 2024 at 03:52:51PM +0300, Georgi Djakov wrote:
> > On 12.06.24 13:28, Varadarajan Narayanan wrote:
> > > On Wed, Jun 12, 2024 at 11:48:17AM +0300, Georgi Djakov wrote:
> > > > On 12.06.24 9:30, Varadarajan Narayanan wrote:
> > > > > On Tue, Jun 11, 2024 at 02:29:48PM +0300, Georgi Djakov wrote:
> > > > > > On 11.06.24 12:42, Varadarajan Narayanan wrote:
> > > > > > > On Thu, Jun 06, 2024 at 04:06:01PM +0200, Konrad Dybcio wrote:
> > > > > > > > On 8.05.2024 10:10 AM, Dmitry Baryshkov wrote:
> > > > > > > > > On Wed, 8 May 2024 at 09:53, Varadarajan Narayanan
> > > > > > > > > <quic_varada@quicinc.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, May 03, 2024 at 04:51:04PM +0300, Georgi Djakov wrote:
> > > > > > > > > > > Hi Varada,
> > > > > > > > > > >
> > > > > > > > > > > Thank you for your work on this!
> > > > > > > > > > >
> > > > > > > > > > > On 2.05.24 12:30, Varadarajan Narayanan wrote:
> > > > > > > > > > > > On Tue, Apr 30, 2024 at 12:05:29PM +0200, Konrad Dybcio wrote:
> > > > > > > > > > > > > On 25.04.2024 12:26 PM, Varadarajan Narayanan wrote:
> > > > > > > > > > > > > > On Tue, Apr 23, 2024 at 02:58:41PM +0200, Konrad Dybcio wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On 4/18/24 11:23, Varadarajan Narayanan wrote:
> > > > > > > > > > > > > > > > IPQ SoCs dont involve RPM in managing NoC related clocks and
> > > > > > > > > > > > > > > > there is no NoC scaling. Linux itself handles these clocks.
> > > > > > > > > > > > > > > > However, these should not be exposed as just clocks and align
> > > > > > > > > > > > > > > > with other Qualcomm SoCs that handle these clocks from a
> > > > > > > > > > > > > > > > interconnect provider.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Hence include icc provider capability to the gcc node so that
> > > > > > > > > > > > > > > > peripherals can use the interconnect facility to enable these
> > > > > > > > > > > > > > > > clocks.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > > > > > > > > > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > If this is all you do to enable interconnect (which is not the case,
> > > > > > > > > > > > > > > as this patch only satisfies the bindings checker, the meaningful
> > > > > > > > > > > > > > > change happens in the previous patch) and nothing explodes, this is
> > > > > > > > > > > > > > > an apparent sign of your driver doing nothing.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > It appears to do nothing because, we are just enabling the clock
> > > > > > > > > > > > > > provider to also act as interconnect provider. Only when the
> > > > > > > > > > > > > > consumers are enabled with interconnect usage, this will create
> > > > > > > > > > > > > > paths and turn on the relevant NOC clocks.
> > > > > > > > > > > > >
> > > > > > > > > > > > > No, with sync_state it actually does "something" (sets the interconnect
> > > > > > > > > > > > > path bandwidths to zero). And *this* patch does nothing functionally,
> > > > > > > > > > > > > it only makes the dt checker happy.
> > > > > > > > > > > >
> >
> > [..]
> >
> > >
> > > nsscc_ipq9574 was not using icc_sync_state. After adding that, I
> > > can see the following messages printed from icc_sync_state. I
> > > also added a print to confirm if 'p->set(n, n);' is called.
> >
> > Ok, that's good! So now when all providers are using sync_state, we
> > can go back to the initial comment from Konrad. I think you should
> > re-check the tests that you did, as the current results just lead to
> > more questions than answers. Maybe it was just the sync-state that
> > was missing, or there is some other issue.
>
> Georgi,
>
> Thanks very much for the clarifications. Will re-test the patches
> and update the thread.
>
> -Varada

Georgi,

Tested the patches with both gcc and nsscc providers having
'sync_state' set to icc_sync_state.

	# dmesg | grep synced
	[    3.029820] qcom,gcc-ipq9574 1800000.clock-controller: interconnect provider is in synced state
	[    3.470106] qcom,nsscc-ipq9574 39b00000.clock-controller: interconnect provider is in synced state

I can see that icc_sync_state is getting called and clocks
related to paths with zero bandwidth are getting disabled.

Will post the NSSCC patches to get the full picture.

-Varada

>
> > > nodes. Please refer to this patch
> > >
> > > 	[PATCH V5 4/6] arm64: dts: qcom: ipq9574: Add PCIe PHYs and controller nodes
> > > 	https://lore.kernel.org/linux-arm-msm/20240512082858.1806694-5-quic_devipriy@quicinc.com/
> > >
> > > Sorry, did not post the nsscc related patches since this base ICC
> > > patch hasn't reached closure. The nsscc patches are very similar
> > > to this gcc based series. Wanted to gather the issues raised in
> > > this and address them in nsscc so that it is in a more acceptable
> > > shape.
> > >
> > > Thanks
> > > Varada
> >
>

