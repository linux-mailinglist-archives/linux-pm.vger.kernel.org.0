Return-Path: <linux-pm+bounces-10188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A2691BDE0
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 13:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAEAF1C21EBC
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 11:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA608158207;
	Fri, 28 Jun 2024 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gwv3z3k5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB171865A;
	Fri, 28 Jun 2024 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575646; cv=none; b=LO8Suj/5CdLG3aRcgE/nypKF7gq6YnYq9g+lj10FHmcZ15l7sJ8KcEIV5BBmT5BYHitqNy2vaZqoUNBo6uWxLAe6245mDZYeCSvSexv15BKSwDU6bEuPXLPG1Nc+t2zP3osyQFBbz/TkbJwd73xMG0scqA2+dcWnRRvbsoy8crc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575646; c=relaxed/simple;
	bh=EfZPK4bQlzDxBEzFkfeTiecD2ZjbyZUL5K5NzJWy8bM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gP8SZ4mIyLczJl21V0bqqa02J0DNMull+0ECpNhOo5kFamoo51GguooSFJ9wJjkFHJH51iE35mGDnYLGiUaIS7I1VjSTxrOV2pIuCdVoFoHOmhOMzTS0FCt2sNt8huK/3BeLNed6FEke9HVUb6XjHSpWzE+5LV1SWNCyvQHRE3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Gwv3z3k5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S8EoQN015125;
	Fri, 28 Jun 2024 11:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9At5m60WgpAapqFuAPwU1Hli
	wnsb0FkeiKytGYb9+YA=; b=Gwv3z3k5DjFBLwP9W3KTTI9oJm6iGxryDIbMJw0e
	XzhN7ngX3Ge1+hr3Z2FaFSj/kH+y4UJHbckJ4qLvOxDbzAAywGJlAK/jrrbkK/4o
	L4t1jJTAE9Ejw36cg5OrKeV+I0RWnw/4LS9eEX65pQwmkW48m5e1n0q4Zk6C7/Lv
	dOaxMf8bxiJET7kkVWprAm9EmHk3OkO0LjCxdZ1E0IzzouM/VaC34EOaTQu3HUJW
	2A/q72AGincj8xFb2+7R5tNEufuTLZgCXoELHz/1Ev+gtBV/zCk5sDbTT+ep+ybT
	jfSf+kSO1YPhoFSUsA8RM4RAfnY2QaoHJeWJHMwsgCJ8Mg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqshysxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 11:53:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45SBrnnD027966
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 11:53:49 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 28 Jun 2024 04:53:42 -0700
Date: Fri, 28 Jun 2024 17:23:38 +0530
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
Message-ID: <Zn6kQuw1Fm9ylppX@hu-varada-blr.qualcomm.com>
References: <20240626104002.420535-1-quic_varada@quicinc.com>
 <20240626104002.420535-9-quic_varada@quicinc.com>
 <txid2b47zhnuknz35xaosfctuojrnrskcjehhqmyqubuxdimqj@7q7pzxlavk6k>
 <Zn0TZiIDQ9W/ttox@hu-varada-blr.qualcomm.com>
 <3mzerxpsa2gj227pryu2pg5rgaoqya7y3fplvpdsq5cnffuzj3@puwzk4j2t2t5>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3mzerxpsa2gj227pryu2pg5rgaoqya7y3fplvpdsq5cnffuzj3@puwzk4j2t2t5>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eEv0sBU4hXyiL4tztb316o4l1ifuEe84
X-Proofpoint-GUID: eEv0sBU4hXyiL4tztb316o4l1ifuEe84
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_08,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406280087

On Thu, Jun 27, 2024 at 04:46:05PM +0300, Dmitry Baryshkov wrote:
> On Thu, Jun 27, 2024 at 12:53:18PM GMT, Varadarajan Narayanan wrote:
> > On Wed, Jun 26, 2024 at 09:27:53PM +0300, Dmitry Baryshkov wrote:
> > > On Wed, Jun 26, 2024 at 04:10:01PM GMT, Varadarajan Narayanan wrote:
> > > > From: Praveenkumar I <quic_ipkumar@quicinc.com>
> > > >
> > > > Add thread, scaling factor, CPR descriptor defines to enable CPR
> > > > on IPQ9574.
> > > >
> > > > Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > ---
> > > > v3: Fix patch author
> > > >     Included below information in cover letter
> > > > v2: Fix Signed-off-by order
> > > > Depends:
> > > > 	[1] https://lore.kernel.org/lkml/20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org/T/
> > > > 	[2] https://github.com/quic-varada/cpr/commits/konrad/
> > > > ---
> > > >  drivers/pmdomain/qcom/cpr3.c | 137 +++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 137 insertions(+)
> > > >
> > > > diff --git a/drivers/pmdomain/qcom/cpr3.c b/drivers/pmdomain/qcom/cpr3.c
> > > > index c28028be50d8..66c8a4bd9adc 100644
> > > > --- a/drivers/pmdomain/qcom/cpr3.c
> > > > +++ b/drivers/pmdomain/qcom/cpr3.c
> > >
> > > > +
> > > > +static const struct cpr_desc ipq9574_cpr_desc = {
> > > > +	.cpr_type = CTRL_TYPE_CPR4,
> > >
> > > So, is it CPR4 or CPRh?
> >
> > CPR4.
>
> Then why do you have cprh in the compatible?

Sorry, copy-paste from msm8998. Will fix that in the next version.

Thanks
Varada

> > > > +	.num_threads = 1,
> > > > +	.apm_threshold = 850000,
> > > > +	.apm_crossover = 880000,
> > > > +	.apm_hysteresis = 0,
> > > > +	.cpr_base_voltage = 700000,
> > > > +	.cpr_max_voltage = 1100000,
> > > > +	.timer_delay_us = 5000,
> > > > +	.timer_cons_up = 0,
> > > > +	.timer_cons_down = 0,
> > > > +	.up_threshold = 2,
> > > > +	.down_threshold = 2,
> > > > +	.idle_clocks = 15,
> > > > +	.count_mode = CPR3_CPR_CTL_COUNT_MODE_ALL_AT_ONCE_MIN,
> > > > +	.count_repeat = 1,
> > > > +	.gcnt_us = 1,
> > > > +	.vreg_step_fixed = 12500,
> > > > +	.vreg_step_up_limit = 1,
> > > > +	.vreg_step_down_limit = 1,
> > > > +	.vdd_settle_time_us = 34,
> > > > +	.corner_settle_time_us = 6,
> > > > +	.reduce_to_corner_uV = true,
> > > > +	.hw_closed_loop_en = false,
> > > > +	.threads = (const struct cpr_thread_desc *[]) {
> > > > +		&ipq9574_thread_silver,
> > >
> > > If it's silver, where is gold or bronze?
> >
> > Will rename this as "ipq9574_thread"
> >
> > Thanks
> > Varada
> >
> > > > +	},
> > > > +};
> > > > +
> > > > +static const struct cpr_acc_desc ipq9574_cpr_acc_desc = {
> > > > +	.cpr_desc = &ipq9574_cpr_desc,
> > > > +};
> > > > +
> > > >  static const int sdm630_gold_scaling_factor[][CPR3_RO_COUNT] = {
> > > >  	/* Same RO factors for all fuse corners */
> > > >  	{
> > > > @@ -2828,6 +2964,7 @@ static void cpr_remove(struct platform_device *pdev)
> > > >  }
> > > >
> > > >  static const struct of_device_id cpr3_match_table[] = {
> > > > +	{ .compatible = "qcom,ipq9574-cprh", .data = &ipq9574_cpr_acc_desc },
> > > >  	{ .compatible = "qcom,msm8998-cprh", .data = &msm8998_cpr_acc_desc },
> > > >  	{ .compatible = "qcom,sdm630-cprh", .data = &sdm630_cpr_acc_desc },
> > > >  	{ }
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > --
> > > With best wishes
> > > Dmitry
>
> --
> With best wishes
> Dmitry

