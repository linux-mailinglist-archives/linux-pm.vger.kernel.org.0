Return-Path: <linux-pm+bounces-10573-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB8D926EA9
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 07:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8711F213B1
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 05:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D188A1A00F3;
	Thu,  4 Jul 2024 05:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UgEQq7l3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC8517C20E;
	Thu,  4 Jul 2024 05:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720069375; cv=none; b=kBB4MhwxsIMssrVO8QRTl833gaJnOFJwv3Wx9v5mk2enaVD4u0U8VEV/WVziwqRiYw9e/lNfds0vYRrVWAiHxaAnkVHrZEJWOBKU4yCYvxGaDCILfsdMVowJZ+UJaymVz52peN2OLSQFINmJ++woHKHYGIG4TskBpr2GUWZYSUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720069375; c=relaxed/simple;
	bh=hQkeseZIi6r8EiJMX+bvi6ZnfT5oMV79Q+YfKJH4aeY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Icz+49PNkNIfoyrkeIGf/HEUC1+NKvog9M7DRVY4Hpz/BH2rqQaHfnuCHDMLZAqAc1oGaS9iTSAzhzNZqXDiZ+mPpwx8NeJ8Wfh9V1FdhsmO1oZd0M8e/s30oZ6m68ofasBiUINbxk/pM0wX4+pOx6dlkmys3RXHILxHw6Xk9LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UgEQq7l3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463KvN5b015251;
	Thu, 4 Jul 2024 05:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WVBHATDwaUUEe/XpZ8zsDl6y
	bp9pnSEz96nBPuTir8I=; b=UgEQq7l3j7tfCl0I3NGFeLLF+06hQGu2Yvw1Xtqk
	WCHDDvz1iKzgkjFfconqwEwFB39S1kAnjc1SZJfuA8tYc5D0hNTQEvoOLLBPFCbj
	hBWjLS4AhW1Q7teSOtqMMt229WUJ4z5osKCnrq0U3uOVsq3fuGV1EbVZUFAZgQTe
	QdfMt3HhJO+P2tD70KtYBCuTtmf13L5W1M+C15mbR7cwt1SeZbBc68QnmI4/OUyF
	JDPcDwma+5krUff2kzTjDKuj0vDjb4zZoy1iGwo09RlPrxzmKxH/ZBXhYvcdiynF
	rWxvW3M3rkxJ15pFUpaKFVRI/CI4fT05J2fLwN0iL6vCAw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4052yhj8bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 05:02:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46452O6g030012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jul 2024 05:02:24 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 3 Jul 2024 22:02:16 -0700
Date: Thu, 4 Jul 2024 10:32:12 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <vireshk@kernel.org>, <nm@ti.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <ilia.lin@kernel.org>, <rafael@kernel.org>, <ulf.hansson@linaro.org>,
        <quic_sibis@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_rohiagar@quicinc.com>, <abel.vesa@linaro.org>,
        <otto.pflueger@abscue.de>, <danila@jiaxyga.com>,
        <quic_ipkumar@quicinc.com>, <luca@z3ntu.xyz>,
        <stephan.gerhold@kernkonzept.com>, <nks@flawful.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v4 08/10] soc: qcom: cpr3: Add IPQ9574 definitions
Message-ID: <ZoYs1ATONyplhWqw@hu-varada-blr.qualcomm.com>
References: <20240703091651.2820236-1-quic_varada@quicinc.com>
 <20240703091651.2820236-9-quic_varada@quicinc.com>
 <sk66oje4p4yzh5hfk7pqihr72rap3vpidgdxzhje57uu47sjpf@z72v46onyiwf>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <sk66oje4p4yzh5hfk7pqihr72rap3vpidgdxzhje57uu47sjpf@z72v46onyiwf>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -uulT2A8xm2ZFiZJP9itlDrfux2Fxujn
X-Proofpoint-GUID: -uulT2A8xm2ZFiZJP9itlDrfux2Fxujn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_18,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 clxscore=1015
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040035

On Wed, Jul 03, 2024 at 01:49:15PM +0300, Dmitry Baryshkov wrote:
> On Wed, Jul 03, 2024 at 02:46:49PM GMT, Varadarajan Narayanan wrote:
> > From: Praveenkumar I <quic_ipkumar@quicinc.com>
> >
> > * Add thread, scaling factor, CPR descriptor defines to enable
> >   CPR on IPQ9574.
> >
> > * Skip 'acc' usage since IPQ9574 does not have acc
> >
> > Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v4: s/silver//, s/cprh/cpr4/
> >     Skip 'acc' related code as IPQ9574 does not have acc
> >
> > v3: Fix patch author
> >     Included below information in cover letter
> > v2: Fix Signed-off-by order
> > Depends:
> > 	[1] https://lore.kernel.org/lkml/20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org/T/
> > 	[2] https://github.com/quic-varada/cpr/commits/konrad/
> > ---
> >  drivers/pmdomain/qcom/cpr3.c | 143 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 141 insertions(+), 2 deletions(-)
> >
>
>
>
> > @@ -2703,7 +2840,8 @@ static int cpr_probe(struct platform_device *pdev)
> >
> >  	mutex_init(&drv->lock);
> >
> > -	if (desc->cpr_type < CTRL_TYPE_CPRH) {
> > +	if (desc->cpr_type < CTRL_TYPE_CPRH &&
> > +	    !of_device_is_compatible(dev->of_node, "qcom,ipq9574-cpr4")) {
>
> No. Check for ->acc_desc instead.

Ok.

Thanks
Varada

> >  		np = of_parse_phandle(dev->of_node, "qcom,acc", 0);
> >  		if (!np)
> >  			return -ENODEV;
> > @@ -2828,6 +2966,7 @@ static void cpr_remove(struct platform_device *pdev)
> >  }
> >
> >  static const struct of_device_id cpr3_match_table[] = {
> > +	{ .compatible = "qcom,ipq9574-cpr4", .data = &ipq9574_cpr_acc_desc },
> >  	{ .compatible = "qcom,msm8998-cprh", .data = &msm8998_cpr_acc_desc },
> >  	{ .compatible = "qcom,sdm630-cprh", .data = &sdm630_cpr_acc_desc },
> >  	{ }
> > --
> > 2.34.1
> >
>
> --
> With best wishes
> Dmitry

