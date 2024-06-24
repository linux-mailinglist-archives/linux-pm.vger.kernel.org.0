Return-Path: <linux-pm+bounces-9878-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233599142FE
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 08:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1235284A89
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 06:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1282F870;
	Mon, 24 Jun 2024 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZVeAko3o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F0F3A8C0;
	Mon, 24 Jun 2024 06:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719211844; cv=none; b=T9amP9FEhSS9MFX2rvTrE9ITd/OKJeAQy6H3BrUoRrv2ri2S2cDXZ1FJZB35vOVOY+3QU1oSsMzZSc9LQZWh/9u/bRFkBCj2sq6QWsoRxhkn6g9/i9X7p4ZODKyQlM4mxrWZhaK7QXkO6oMoXZXLKZukhfpbIV+eL53KCkwtBWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719211844; c=relaxed/simple;
	bh=g5iWYDyt2ZDeg7La5X0LZ/mlaI2yr9c1wbeisWn+Suw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IulVlm+iABDtADvbEB2zPKZ9iiCRKJvnB8jb9zi7FWWyHcDTrWrGpYeKJSs7zTb/u8qGnsX8uZb/lkRAmwxozfX+SFLjIlWhD1W1nhBfZ16HCO9j+RkAcvilIMkSPx+Qon5fQH3SYyAxyLcprREMjBZWKLF0+MYy1uo+W66AmU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZVeAko3o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NNg425005923;
	Mon, 24 Jun 2024 06:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SGEFJta5dbZ7t5J3TYz5Grkh
	njAOdAZafLPY0ATa1YM=; b=ZVeAko3oSiEa6MMu4vvisbc3KN0ncBP37TrB21Pn
	UjaBtIwo2nEQs3f2/Fq2HhDhEWMyN9KxUyC5SdTU8atKUDKKVPuHhQbC4+IDLCsj
	BQyeLYEy72AtikgDIvFdCH5J4BZQ49F7aXTiZ6FYW/5B85R8i3dwaaRfKuA94QD1
	UBIK0tG78Ixi7n/XuRK6WWcLZbryKhfe7PoBGXfLjd08r8gmcmf5gVbEk9NvbkPU
	GWVngEKxIpQ5jUA0g8Qzl3QR9OxPTsbynvF8qQ+ZUpDygH6eNlA6NmFAUdtvh8FL
	HDk0eafPl5CNNHsU1fmwe2JVj/ggQlH0DY7GeX4BnFHsFg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnxgtty8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 06:50:34 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O6oOU6008543
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 06:50:24 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 23 Jun 2024 23:50:17 -0700
Date: Mon, 24 Jun 2024 12:20:13 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <abel.vesa@linaro.org>, <otto.pflueger@abscue.de>,
        <quic_rohiagar@quicinc.com>, <luca@z3ntu.xyz>,
        <quic_ipkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] Enable CPR for IPQ9574
Message-ID: <ZnkXJWXI/mfP/vG+@hu-varada-blr.qualcomm.com>
References: <20240624050254.2942959-1-quic_varada@quicinc.com>
 <5xgjszacvtnjftygwvtonb4npspaceutnvnnniebxntii4tmud@xag2c6j2svqa>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5xgjszacvtnjftygwvtonb4npspaceutnvnnniebxntii4tmud@xag2c6j2svqa>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x1_WOr5dCkzGTj0Apzc_k9hYrVjG9NHb
X-Proofpoint-ORIG-GUID: x1_WOr5dCkzGTj0Apzc_k9hYrVjG9NHb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_06,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=929 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240054

On Mon, Jun 24, 2024 at 08:39:55AM +0300, Dmitry Baryshkov wrote:
> On Mon, Jun 24, 2024 at 10:32:47AM GMT, Varadarajan Narayanan wrote:
> > This series tries to enable CPR on IPQ9574, that implements
> > CPRv4. Since [1] is older, faced few minor issues. Those are
> > addressed in [2].
> >
> > dt_binding_check and dtbs_check passed.
> >
> > Depends:
> > 	[1] https://lore.kernel.org/lkml/20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org/T/
> > 	[2] https://github.com/quic-varada/cpr/commits/konrad/
>
> Please include [2] into your patchset.

Did not include them because Konrad has agreed to post them this week.
And, I don't have an MSM8998 target to test those changes.

Thanks
Varada

> >
> > v2: Fix Signed-off-by order in 2 patches
> >     Update constraints in qcom,cpr3.yaml
> >     Add rbcpr_clk_src registration
> >     Add Reviewed-by to one of the patches
> >     Not adding Acked-by as the file has changed
> >
> > Varadarajan Narayanan (7):
> >   dt-bindings: power: rpmpd: Add IPQ9574 power domains
> >   dt-bindings: soc: qcom: cpr3: Add bindings for IPQ9574
> >   pmdomain: qcom: rpmpd: Add IPQ9574 power domains
> >   dt-bindings: clock: Add CPR clock defines for IPQ9574
> >   clk: qcom: gcc-ipq9574: Add CPR clock definition
> >   soc: qcom: cpr3: Add IPQ9574 definitions
> >   dts: arm64: qcom: ipq9574: Enable CPR
> >
> >  .../devicetree/bindings/power/qcom,rpmpd.yaml |   1 +
> >  .../bindings/soc/qcom/qcom,cpr3.yaml          |  35 +++
> >  arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 269 ++++++++++++++++--
> >  drivers/clk/qcom/gcc-ipq9574.c                |  39 +++
> >  drivers/pmdomain/qcom/cpr3.c                  | 137 +++++++++
> >  drivers/pmdomain/qcom/rpmpd.c                 |  19 ++
> >  include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   2 +
> >  include/dt-bindings/power/qcom-rpmpd.h        |   3 +
> >  8 files changed, 488 insertions(+), 17 deletions(-)
> >
> > --
> > 2.34.1
> >
>
> --
> With best wishes
> Dmitry

