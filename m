Return-Path: <linux-pm+bounces-9752-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EEC912337
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 13:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1AD1C23044
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 11:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8250C172BC7;
	Fri, 21 Jun 2024 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HknzW6uQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA6312D771;
	Fri, 21 Jun 2024 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718968838; cv=none; b=JvSz3nNx8xDcON1kkmme98pPgFK2D2pchJevKs7erk4IPJ3iuMBpEGMcdeS797RW1pZ7bQNJlufmrlxxaJMQA9q0D3SHBYANGALmysasJzaFvcE09AJ5+nZh4Rq2kbzgyZQL46BYkAgzLVAIyu/BTms4A/bj3Me41TDoKZ8/7vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718968838; c=relaxed/simple;
	bh=v2fSHKFeFk8kKjPt2+kyNGoSc76Neq1kp/GJIS7UsW8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UY/6IYjKiXxD+98CQplsZlz0mN9iIUvi3j7Vp0yHTJ9N5TQc4tbtRrH+GclTNFBdZ6VpdMccVt8oVdiBKTbwkubRPd1r4X/mRvJwKdsz0eWgaPvXuAMh7+ynXJSp0VLC6da2aeiMg7ByNPhb6aiEdJqq4dVb+dQ0yugCZVeqtrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HknzW6uQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L6Jkcp018169;
	Fri, 21 Jun 2024 11:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GvBt5EFx3bJUMUtNY16lmRX7
	FxXV93kKPh2W99Or8Ao=; b=HknzW6uQ4ssxUXCNPkdclrrM5TAFo6euMpEM26BQ
	MjaZEZFBZAGvhcsunJqxX6l80UNr3I87ipTyLD4NBrcZBI01Y3kl8KvsqNBkOTOy
	K/jSc+1araKJ1UUiWp0OfY90ehXevcWQGoZr1Bpz/GRUNpJCnWoHBbmrEaIRYxDj
	v83oGDwcIPfwyjnYkelBTviDk2zOOzLqhRV4+TjqZvevpZatW8vBH4s8lqb13z4H
	ArM9oD44BpKKu8U0CXvqgLwzSA1Ul1LlXS5NYYQO1/zoMtufdoLx6WeUziRjA4/x
	KM+Rp8nGU4RDUd0FJ0niNRjYK4SGG8UmvVQ/Aw+RZ++7tA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvrm0ad5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 11:20:16 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45LBKFpL027039
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 11:20:15 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 21 Jun 2024 04:20:09 -0700
Date: Fri, 21 Jun 2024 16:50:05 +0530
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
        <linux-clk@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1 5/7] clk: qcom: gcc-ipq9574: Add CPR clock definition
Message-ID: <ZnVh5d8RfPnMBvN8@hu-varada-blr.qualcomm.com>
References: <20240620081427.2860066-1-quic_varada@quicinc.com>
 <20240620081427.2860066-6-quic_varada@quicinc.com>
 <wadru6axfhvws74vcd6umdhnm6gl5poegoljvb7fgbtuz2mccp@hrclt6qesp6e>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <wadru6axfhvws74vcd6umdhnm6gl5poegoljvb7fgbtuz2mccp@hrclt6qesp6e>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PtMB4z0B8foTTy1Ntbh4XdDN-9b72SOY
X-Proofpoint-GUID: PtMB4z0B8foTTy1Ntbh4XdDN-9b72SOY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210083

On Thu, Jun 20, 2024 at 06:11:32PM +0300, Dmitry Baryshkov wrote:
> On Thu, Jun 20, 2024 at 01:44:25PM GMT, Varadarajan Narayanan wrote:
> > Add the CPR clock definition needed for enabling access to
> > CPR register space.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  drivers/clk/qcom/gcc-ipq9574.c | 38 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
> > index e1dc74d04ed1..7c8eb94f654b 100644
> > --- a/drivers/clk/qcom/gcc-ipq9574.c
> > +++ b/drivers/clk/qcom/gcc-ipq9574.c
> > @@ -3994,6 +3994,43 @@ static struct clk_branch gcc_xo_div4_clk = {
> >  	},
> >  };
> >
> > +static const struct freq_tbl ftbl_hmss_rbcpr_clk_src[] = {
> > +	F(24000000, P_XO, 1, 0, 0),
> > +	{ }
> > +};
> > +
> > +static struct clk_rcg2 rbcpr_clk_src = {
> > +	.cmd_rcgr = 0x48044,
> > +	.mnd_width = 0,
> > +	.hid_width = 5,
> > +	.parent_map = gcc_xo_map,
> > +	.freq_tbl = ftbl_gp1_clk_src,
> > +	.clkr.hw.init = &(struct clk_init_data){
> > +		.name = "rbcpr_clk_src",
> > +		.parent_data = gcc_xo_gpll0_gpll4,
> > +		.num_parents = ARRAY_SIZE(gcc_xo_map),
> > +		.ops = &clk_rcg2_ops,
> > +	},
> > +};
> > +
> > +static struct clk_branch gcc_rbcpr_clk = {
> > +	.halt_reg = 0x48008,
> > +	.halt_check = BRANCH_HALT,
> > +	.clkr = {
> > +		.enable_reg = 0x48008,
> > +		.enable_mask = BIT(0),
> > +		.hw.init = &(struct clk_init_data){
> > +			.name = "gcc_rbcpr_clk",
> > +			.parent_hws = (const struct clk_hw *[]) {
> > +				&rbcpr_clk_src.clkr.hw,
>
> Where is the &rbcpr_clk_src registered?

Oops. Missed it. Will post a corrected patch.

Thanks
Varada

> > +			},
> > +			.num_parents = 1,
> > +			.flags = CLK_SET_RATE_PARENT,
> > +			.ops = &clk_branch2_ops,
> > +		},
> > +	},
> > +};
> > +
> >  static struct clk_hw *gcc_ipq9574_hws[] = {
> >  	&gpll0_out_main_div2.hw,
> >  	&gcc_xo_div4_clk_src.hw,
> > @@ -4219,6 +4256,7 @@ static struct clk_regmap *gcc_ipq9574_clks[] = {
> >  	[GCC_PCIE1_PIPE_CLK] = &gcc_pcie1_pipe_clk.clkr,
> >  	[GCC_PCIE2_PIPE_CLK] = &gcc_pcie2_pipe_clk.clkr,
> >  	[GCC_PCIE3_PIPE_CLK] = &gcc_pcie3_pipe_clk.clkr,
> > +	[GCC_RBCPR_CLK] = &gcc_rbcpr_clk.clkr,
> >  };
> >
> >  static const struct qcom_reset_map gcc_ipq9574_resets[] = {
> > --
> > 2.34.1

