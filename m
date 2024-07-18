Return-Path: <linux-pm+bounces-11226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00CE934BD3
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 12:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C3F1C21A4B
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 10:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EB312E1ED;
	Thu, 18 Jul 2024 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Al1adQQy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9CE12D745;
	Thu, 18 Jul 2024 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721299378; cv=none; b=hQAxOB9aDdv/feL8ez6wFb+x0T0Jy9QKumYBmByySd4x1H1KkS9SzSnbS7Pg0Djn3oyRdWYG5/WvO6mWQxGm0bHNEOkSTGMS6mYcPl9v00Eryo82bpRF2/KBqF5ttygtokbDCodUJQIsC2gWjgZkOO1QO3455XNrB6Q7zMpvH80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721299378; c=relaxed/simple;
	bh=0y5fvGYpLHku1Mt2k8bzRdKl/4g+OtS7CLaodaIPD9Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hA7dllMbryaALJe6xPtidC9iRKk10ifK7Ci9VBaFQbO9S6Mzfp62Y+JOnOV8CiIbYnlJ1cVSIpHkZESfg2tGcJu58PWQEi3RPB/bSYV5v485qqn1xbwGYaARGQHKoOgysHob/9yiKYKrNClZtY7n46Et/fqiit29aGyIPFJPaYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Al1adQQy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I9sBUN023118;
	Thu, 18 Jul 2024 10:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=r+TwacGcp1O7u4JtjIZTd905
	NcHS2JPI86tAeWbU1Mo=; b=Al1adQQy3KSYn/+SZTwZmstSjx5eLR+PCh0vENyJ
	3k2iioq+JxbR427LlQE5dBVf7Hy9vEk1yViS9J2DERG3n+gvrXT+OewRutc7uaco
	PJa67+TTanLf9eCH206MBRsWmqqdFoli8O0DxGcH/sCQAmJP3vmjSBLnvCDztW/6
	JlE0ev+DksSmRpLTrFa4+fFoVPnAi/FWOuLu25qzvKoRKDjvv7+Pxjdxx/Br8n0P
	5csuKNtYUEIeTGOEDWk33Oouv1eTyLvfSf2g6t+vezydQtpBz4o73Tbe8dagHuvT
	ojxAhNZq/EOqyd/1+O1w4qkCYdb3it7qfU2sXZfKX1xdiA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfnn7n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 10:42:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46IAgoR1011131
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 10:42:50 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 18 Jul 2024 03:42:45 -0700
Date: Thu, 18 Jul 2024 16:12:41 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] clk: qcom: ipq5332: Use icc-clk for enabling NoC
 related clocks
Message-ID: <ZpjxobF6LZMMN8A9@hu-varada-blr.qualcomm.com>
References: <20240711113239.3063546-1-quic_varada@quicinc.com>
 <20240711113239.3063546-4-quic_varada@quicinc.com>
 <iwdennlw4njxefulw5e2wofu4pylep65el4hiiso6xqmoaq5fb@i4hrltrn2o6z>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <iwdennlw4njxefulw5e2wofu4pylep65el4hiiso6xqmoaq5fb@i4hrltrn2o6z>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5Twh_FuLj610zBt_uq0I4R1gwppJLeRN
X-Proofpoint-ORIG-GUID: 5Twh_FuLj610zBt_uq0I4R1gwppJLeRN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_07,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=963 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407180070

On Sat, Jul 13, 2024 at 07:21:29PM +0300, Dmitry Baryshkov wrote:
> On Thu, Jul 11, 2024 at 05:02:38PM GMT, Varadarajan Narayanan wrote:
> > Use the icc-clk framework to enable few clocks to be able to
> > create paths and use the peripherals connected on those NoCs.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  drivers/clk/qcom/gcc-ipq5332.c | 36 +++++++++++++++++++++++++++++-----
> >  1 file changed, 31 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
> > index f98591148a97..6d7672cae0f7 100644
> > --- a/drivers/clk/qcom/gcc-ipq5332.c
> > +++ b/drivers/clk/qcom/gcc-ipq5332.c
> > @@ -4,12 +4,14 @@
> >   */
> >
> >  #include <linux/clk-provider.h>
> > +#include <linux/interconnect-provider.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> >
> >  #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
> > +#include <dt-bindings/interconnect/qcom,ipq5332.h>
> >
> >  #include "clk-alpha-pll.h"
> >  #include "clk-branch.h"
> > @@ -131,12 +133,14 @@ static struct clk_alpha_pll gpll4_main = {
> >  			 * (will be added soon), so the clock framework
> >  			 * disables this source. But some of the clocks
> >  			 * initialized by boot loaders uses this source. So we
> > -			 * need to keep this clock ON. Add the
> > -			 * CLK_IGNORE_UNUSED flag so the clock will not be
> > -			 * disabled. Once the consumer in kernel is added, we
> > -			 * can get rid of this flag.
> > +			 * need to keep this clock ON.
> > +			 *
> > +			 * After initial bootup, when the ICC framework turns
> > +			 * off unused paths, as part of the icc-clk dependencies
> > +			 * this clock gets disabled resulting in a hang. Marking
> > +			 * it as critical to ensure it is not turned off.
>
> Previous comment was pretty clear: there are missing consumers, the flag
> will be removed once they are added. Current comment doesn't make sense.
> What is the reason for the device hang if we have all the consumers in
> place?

Earlier, since there were no consumers for this clock, it got
disabled via clk_disable_unused() and CLK_IGNORE_UNUSED helped
prevent that.

Now, since this clk is getting used indirectly via icc-clk
framework, it doesn't qualify for being disabled by
clk_disable_unused(). However, when icc_sync_state is called, if
it sees there are no consumers for a path and that path gets
disabled, the relevant clocks get disabled and eventually this
clock also gets disabled. To avoid this have changed 'flags' from
CLK_IGNORE_UNUSED -> CLK_IS_CRITICAL.

Thanks
Varada

> >  			 */
> > -			.flags = CLK_IGNORE_UNUSED,
> > +			.flags = CLK_IS_CRITICAL,
> >  		},
> >  	},
> >  };
>
>
> --
> With best wishes
> Dmitry

