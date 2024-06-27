Return-Path: <linux-pm+bounces-10094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC0991A058
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 09:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DBB1F217DB
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 07:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DDB4D8BF;
	Thu, 27 Jun 2024 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OQ4J/YP5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA712482F6;
	Thu, 27 Jun 2024 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719473027; cv=none; b=tVU9ajN7GrtNI/JH8bRMhxqbMSzr+Ni2kv76d37psY8Fozm5cTxnWqIYGpPkVZ6cLIUgsclB/PZvdktgLuiRJiT3KbqK2+QTZx8Hf+rzJmDvTu2OZ291DfACvpGPGM6qS4VmgjPU9t79BeR6XZnsLmkmVsNEbxBNa4pyA7ZH7p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719473027; c=relaxed/simple;
	bh=GOh/cH6/r/eNXGbISTWzC6NNL+2UhJuov5Tbid9lxtA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsanQB5I+EJZ9nTfuvKSnNojGIbXmMxUKaK4V0ZJpNP2Q1u8CreKy/0GNg8sLoIJsLN2SnGtMwZjj6ZocvXMSKuDx0lpQcFI3JrH0Q4Crm0kaqrBAhgzLqhTDhNQzqj+/CdgVqZgwv9wbPgiJeDLPfrQ+i5bIO5/ifspPdkArEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OQ4J/YP5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QLccCg016938;
	Thu, 27 Jun 2024 07:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cXE3pGdxpHYpYuaQiyy6Y5lE
	6iV5vehOUqJ9RtaCnxY=; b=OQ4J/YP5MSYTl6lIrUPbafh7UZ4iEfznTqHUtCJ2
	H55OzGvEgqQjS+Zs+PhwJkpNQAXO9BDaecYZvEVt/NTRZQ88hjFkEaeDFo7uQupl
	KKBGayy73TpQubODmVbJaRGE1c8x8mLpiKc1HlouL6GZ9C2LQ09WOOHwK1cXo8px
	fb2B+b5xCx3OiBN0wRtiP1TQJ0xwcq8C+X/CDJANam5zuovKVrQNoX+F6pHi0oyt
	tRgVbhikYrGQDDRfmrn72+/8r3Fj82PfXRBUD74s5sVwmDT/mNY/OTjY47D2/F9E
	yO/yyhgWaobIBM2d/q/anSFt90KJt1U2CyuXymsj79u2CA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnjs35ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 07:23:30 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45R7NTPI023177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 07:23:29 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 27 Jun 2024 00:23:22 -0700
Date: Thu, 27 Jun 2024 12:53:18 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ilia.lin@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ulf.hansson@linaro.org>,
        <quic_sibis@quicinc.com>, <otto.pflueger@abscue.de>,
        <neil.armstrong@linaro.org>, <luca@z3ntu.xyz>, <abel.vesa@linaro.org>,
        <danila@jiaxyga.com>, <quic_ipkumar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 8/9] soc: qcom: cpr3: Add IPQ9574 definitions
Message-ID: <Zn0TZiIDQ9W/ttox@hu-varada-blr.qualcomm.com>
References: <20240626104002.420535-1-quic_varada@quicinc.com>
 <20240626104002.420535-9-quic_varada@quicinc.com>
 <txid2b47zhnuknz35xaosfctuojrnrskcjehhqmyqubuxdimqj@7q7pzxlavk6k>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <txid2b47zhnuknz35xaosfctuojrnrskcjehhqmyqubuxdimqj@7q7pzxlavk6k>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: um9BVXflAiB9fiHUEXGPDtfhOuhGlzp5
X-Proofpoint-ORIG-GUID: um9BVXflAiB9fiHUEXGPDtfhOuhGlzp5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_03,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270054

On Wed, Jun 26, 2024 at 09:27:53PM +0300, Dmitry Baryshkov wrote:
> On Wed, Jun 26, 2024 at 04:10:01PM GMT, Varadarajan Narayanan wrote:
> > From: Praveenkumar I <quic_ipkumar@quicinc.com>
> >
> > Add thread, scaling factor, CPR descriptor defines to enable CPR
> > on IPQ9574.
> >
> > Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v3: Fix patch author
> >     Included below information in cover letter
> > v2: Fix Signed-off-by order
> > Depends:
> > 	[1] https://lore.kernel.org/lkml/20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org/T/
> > 	[2] https://github.com/quic-varada/cpr/commits/konrad/
> > ---
> >  drivers/pmdomain/qcom/cpr3.c | 137 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 137 insertions(+)
> >
> > diff --git a/drivers/pmdomain/qcom/cpr3.c b/drivers/pmdomain/qcom/cpr3.c
> > index c28028be50d8..66c8a4bd9adc 100644
> > --- a/drivers/pmdomain/qcom/cpr3.c
> > +++ b/drivers/pmdomain/qcom/cpr3.c
>
> > +
> > +static const struct cpr_desc ipq9574_cpr_desc = {
> > +	.cpr_type = CTRL_TYPE_CPR4,
>
> So, is it CPR4 or CPRh?

CPR4.

> > +	.num_threads = 1,
> > +	.apm_threshold = 850000,
> > +	.apm_crossover = 880000,
> > +	.apm_hysteresis = 0,
> > +	.cpr_base_voltage = 700000,
> > +	.cpr_max_voltage = 1100000,
> > +	.timer_delay_us = 5000,
> > +	.timer_cons_up = 0,
> > +	.timer_cons_down = 0,
> > +	.up_threshold = 2,
> > +	.down_threshold = 2,
> > +	.idle_clocks = 15,
> > +	.count_mode = CPR3_CPR_CTL_COUNT_MODE_ALL_AT_ONCE_MIN,
> > +	.count_repeat = 1,
> > +	.gcnt_us = 1,
> > +	.vreg_step_fixed = 12500,
> > +	.vreg_step_up_limit = 1,
> > +	.vreg_step_down_limit = 1,
> > +	.vdd_settle_time_us = 34,
> > +	.corner_settle_time_us = 6,
> > +	.reduce_to_corner_uV = true,
> > +	.hw_closed_loop_en = false,
> > +	.threads = (const struct cpr_thread_desc *[]) {
> > +		&ipq9574_thread_silver,
>
> If it's silver, where is gold or bronze?

Will rename this as "ipq9574_thread"

Thanks
Varada

> > +	},
> > +};
> > +
> > +static const struct cpr_acc_desc ipq9574_cpr_acc_desc = {
> > +	.cpr_desc = &ipq9574_cpr_desc,
> > +};
> > +
> >  static const int sdm630_gold_scaling_factor[][CPR3_RO_COUNT] = {
> >  	/* Same RO factors for all fuse corners */
> >  	{
> > @@ -2828,6 +2964,7 @@ static void cpr_remove(struct platform_device *pdev)
> >  }
> >
> >  static const struct of_device_id cpr3_match_table[] = {
> > +	{ .compatible = "qcom,ipq9574-cprh", .data = &ipq9574_cpr_acc_desc },
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

