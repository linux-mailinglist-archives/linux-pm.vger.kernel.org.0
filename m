Return-Path: <linux-pm+bounces-11295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F537938BC7
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 11:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA09B1F219B3
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 09:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7571684AC;
	Mon, 22 Jul 2024 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eWNKfFDP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105F31BC40;
	Mon, 22 Jul 2024 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721639496; cv=none; b=GY0HrvB/s3iAQ4ZZ0WELetkRfBkdCxS93Nb/RlPD93xfCdbIOvhnyAE5OwQvCryxfqiKgklwm8gxcuL8i1VCZfMIHnOalv+EtNhYkAgstPi+3PNkCekxOXLN067W7M1MKQoSWHyt9uMxKMj0FxChuUJIO7gPRDa87bXRTdgjc3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721639496; c=relaxed/simple;
	bh=i5LWlF2d5juvYCY2I9dzdDaQkQYfoYUAO6/9J+WlNRk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcYRaHyTu+n7EetYEcGn0lpWSshOkGr7Wo2ZgWjhi2deKZDg5SQBALaRrHTKy6vONb5hmZTmYseA8LyjMKnPPc4nYR1BATdZIw+gjIPWzUcmFQQjetO9I++l3pVHWatOxncrczCplZIue8HZ9y07xFPNh6Bg47/NeBazCiYibQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eWNKfFDP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46LNk0Op002791;
	Mon, 22 Jul 2024 09:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ix7m/Z9JtbmisA8N8doKhQlL
	jP7ZTA97hiC4rkta+IQ=; b=eWNKfFDPnmOn/2XwuCEypFmJI8NutPzlxGOrtVYq
	7ut7QpSD7bNlPnRJYGlhICuTRT97V1xWroOl/OuspIZP8s4y5Z/oqo3Sp1kfgdO8
	n/9n9DJRmtAUm8gDbPRDdwD3EhlrzSJHSYYgWMtrn9YoHxblKeXGoAjWoJMjxAN6
	8relfmIUOsGUp32m9EJJ/1PrHSlLzCgG9+OaOZySWh1+/1nYHZoLCAfnatoDSeJh
	KKB4aYMDIZjMwFuozvLMv5r+o/z4UBHw6e2GfYmWXZzNbSjU/C7ZzoczY87YhUz8
	weYoydbcUJ+016jlF7PSo8UmbtqjTCbfeHCZA4KLVrsfNQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g4jgu7bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 09:11:27 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46M9BQ1j020861
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 09:11:26 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Jul 2024 02:11:21 -0700
Date: Mon, 22 Jul 2024 14:41:17 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] clk: qcom: ipq5332: Register
 gcc_qdss_tsctr_clk_src
Message-ID: <Zp4iNQcBN0eH2QeA@hu-varada-blr.qualcomm.com>
References: <20240722055539.2594434-1-quic_varada@quicinc.com>
 <20240722055539.2594434-4-quic_varada@quicinc.com>
 <bgu4ii2lumk2afgendf2hrcj57gavqd7k3essblcqnhue2auy3@bkmfy4zjv3xs>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bgu4ii2lumk2afgendf2hrcj57gavqd7k3essblcqnhue2auy3@bkmfy4zjv3xs>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cu-lXVVSyNqBl7PPL4Us0ZBY1dbxzsQR
X-Proofpoint-GUID: cu-lXVVSyNqBl7PPL4Us0ZBY1dbxzsQR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_05,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407220071

On Mon, Jul 22, 2024 at 11:24:33AM +0300, Dmitry Baryshkov wrote:
> On Mon, Jul 22, 2024 at 11:25:37AM GMT, Varadarajan Narayanan wrote:
> > gcc_qdss_tsctr_clk_src (enabled in the boot loaders and dependent
> > on gpll4_main) was not registered as one of the ipq5332 clocks.
> > Hence clk_disable_unused() disabled 'gpll4_main' assuming there
> > were no consumers for 'gpll4_main' resulting in system freeze or
> > reboots.
> >
> > After registering gcc_qdss_tsctr_clk_src, CLK_IGNORE_UNUSED can
> > be removed from gpll4_main.
>
> Commented below.
>
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>
> Fixes?

Will add that. Was hesitant to add as it would point to the approx
3800 line commit (3d89d52970fd) that introduced the gcc-ipq5332.c file.

> > ---
> >  drivers/clk/qcom/gcc-ipq5332.c | 12 +-----------
> >  1 file changed, 1 insertion(+), 11 deletions(-)
> >
> > diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
> > index f98591148a97..237b6a766179 100644
> > --- a/drivers/clk/qcom/gcc-ipq5332.c
> > +++ b/drivers/clk/qcom/gcc-ipq5332.c
> > @@ -126,17 +126,6 @@ static struct clk_alpha_pll gpll4_main = {
> >  			.parent_data = &gcc_parent_data_xo,
> >  			.num_parents = 1,
> >  			.ops = &clk_alpha_pll_stromer_ops,
> > -			/*
> > -			 * There are no consumers for this GPLL in kernel yet,
> > -			 * (will be added soon), so the clock framework
> > -			 * disables this source. But some of the clocks
> > -			 * initialized by boot loaders uses this source. So we
> > -			 * need to keep this clock ON. Add the
> > -			 * CLK_IGNORE_UNUSED flag so the clock will not be
> > -			 * disabled. Once the consumer in kernel is added, we
> > -			 * can get rid of this flag.
> > -			 */
> > -			.flags = CLK_IGNORE_UNUSED,
>
> You can't drop it in this patch, since GPLL4 still can get disabled if
> GCC_QDSS_TSCTR_CLK_SRC gets disabled. This chunk should go to the next
> patch (or you should reorder the patches).

Ok, will move the above chunk to next patch.

Thanks
Varada

> >  		},
> >  	},
> >  };
> > @@ -3388,6 +3377,7 @@ static struct clk_regmap *gcc_ipq5332_clocks[] = {
> >  	[GCC_QDSS_DAP_DIV_CLK_SRC] = &gcc_qdss_dap_div_clk_src.clkr,
> >  	[GCC_QDSS_ETR_USB_CLK] = &gcc_qdss_etr_usb_clk.clkr,
> >  	[GCC_QDSS_EUD_AT_CLK] = &gcc_qdss_eud_at_clk.clkr,
> > +	[GCC_QDSS_TSCTR_CLK_SRC] = &gcc_qdss_tsctr_clk_src.clkr,
> >  	[GCC_QPIC_AHB_CLK] = &gcc_qpic_ahb_clk.clkr,
> >  	[GCC_QPIC_CLK] = &gcc_qpic_clk.clkr,
> >  	[GCC_QPIC_IO_MACRO_CLK] = &gcc_qpic_io_macro_clk.clkr,
> > --
> > 2.34.1
> >
>
> --
> With best wishes
> Dmitry

