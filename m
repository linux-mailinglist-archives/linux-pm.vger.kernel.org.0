Return-Path: <linux-pm+bounces-10820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B2192B22A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 10:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94ED91F222C2
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 08:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3851C152796;
	Tue,  9 Jul 2024 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a5dC9Xk1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7114A12D75A;
	Tue,  9 Jul 2024 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513830; cv=none; b=n4znXIH3uclPgyQob0VY5fghN5L0vWe58gpyF658a7W2inCVNCrH/3PeO/6i9/TeZGLIjr82xfC+eL0sq477i6CrPnv3AMyA6q8W07mikk0hEfKdEVeZg0kQjBKuPVRRjqStzbq2EQxMl8TneFn2A4N1N7pMmcWM9TBfP1rIp7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513830; c=relaxed/simple;
	bh=vZko0zXObbnUfm5fUonCC4PkDMvlJpOGq/V0uKONUq8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/WfmYBxcjnK2fGLJrWzXMzk0UEmIhQ1r7rOSFvOtkVXE9k14QmcNneomnwZcl50V73842my8B50prLk8uOeC/r4wxU4FQra/PBeXsyZnHlpRWh0WnpiUJ7ynAZg+i+6Sk5mgZ0PoQEjRQndfhMrogyY+m8xtbkR2y6sxJXMBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a5dC9Xk1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468NitN4003666;
	Tue, 9 Jul 2024 08:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/Zy5mILeNBOv9xCjrLcyUBqI
	7DnDFNjrOAIfm3ywjqk=; b=a5dC9Xk1Vw//BsDrD6ZCTikMyylswjGhCur0AQG/
	A/AH6UZ9FrHt1+SIGjmvC4QVsXUPsg1M6oNCZOL93iN0M4sio8Ap7XTlo8gHMyoZ
	PiAHk/ku36SWYl1Bwhhy64e2AgvmMfQGYoSyMwLjcedcWuD/Rxlyaw5P0FiegcXb
	V2+WHmqp+zNTGecxqKbiDQ8idf7ZatNhKomgeLIojul1NkrscyH7fEOTZ6b+YDGx
	LfOtox/M7ZQN+PCQlCWwpwcf95bG/SVkxhNwTh0dhfylmvsy8blUjDQbIhLOBz6q
	IimA9fP5qrnNVERwPgRSCRmJpmcL84WhSjJGUzyNhm5lHg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wgwns97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 08:30:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4698U5AS021028
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 08:30:05 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 9 Jul 2024 01:29:57 -0700
Date: Tue, 9 Jul 2024 13:59:53 +0530
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
Subject: Re: [PATCH v4 01/10] soc: qcom: cpr3: Fix 'acc_desc' usage
Message-ID: <Zoz1AQh+6jfbgJSy@hu-varada-blr.qualcomm.com>
References: <20240703091651.2820236-1-quic_varada@quicinc.com>
 <20240703091651.2820236-2-quic_varada@quicinc.com>
 <u4hzxnecdyow6h4vhddcp53tuxrqhbqu6cv4cznytihsyshzy4@lqxhsn3qvjbz>
 <ZoYsguLOCnZjxOku@hu-varada-blr.qualcomm.com>
 <bsr6l33xllblwwoa3ftbldxvqwe6tcljt3ek2petoc4hc5xgsg@b36fw3wetj5f>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bsr6l33xllblwwoa3ftbldxvqwe6tcljt3ek2petoc4hc5xgsg@b36fw3wetj5f>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IYsyehHIqrfsAk7y8KFh5IFdaJTTBdNT
X-Proofpoint-ORIG-GUID: IYsyehHIqrfsAk7y8KFh5IFdaJTTBdNT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=651 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090055

On Fri, Jul 05, 2024 at 06:16:51PM +0300, Dmitry Baryshkov wrote:
> On Thu, Jul 04, 2024 at 10:30:50AM GMT, Varadarajan Narayanan wrote:
> > On Wed, Jul 03, 2024 at 01:46:54PM +0300, Dmitry Baryshkov wrote:
> > > On Wed, Jul 03, 2024 at 02:46:42PM GMT, Varadarajan Narayanan wrote:
> > > > cpr3 code assumes that 'acc_desc' is available for SoCs
> > > > implementing CPR version 4 or less. However, IPQ9574 SoC
> > > > implements CPRv4 without ACC. This causes NULL pointer accesses
> > > > resulting in crashes. Hence, check if 'acc_desc' is populated
> > > > before using it.
> > > >
> > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > ---
> > > > v4: Undo the acc_desc validation in probe function as that could
> > > >     affect other SoC.
> > > > ---
> > > >  drivers/pmdomain/qcom/cpr3.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/pmdomain/qcom/cpr3.c b/drivers/pmdomain/qcom/cpr3.c
> > > > index c7790a71e74f..6ceb7605f84d 100644
> > > > --- a/drivers/pmdomain/qcom/cpr3.c
> > > > +++ b/drivers/pmdomain/qcom/cpr3.c
> > > > @@ -2399,12 +2399,12 @@ static int cpr_pd_attach_dev(struct generic_pm_domain *domain,
> > > >  		if (ret)
> > > >  			goto exit;
> > > >
> > > > -		if (acc_desc->config)
> > > > +		if (acc_desc && acc_desc->config)
> > > >  			regmap_multi_reg_write(drv->tcsr, acc_desc->config,
> > > >  					       acc_desc->num_regs_per_fuse);
> > > >
> > > >  		/* Enable ACC if required */
> > > > -		if (acc_desc->enable_mask)
> > > > +		if (acc_desc && acc_desc->enable_mask)
> > > >  			regmap_update_bits(drv->tcsr, acc_desc->enable_reg,
> > > >  					   acc_desc->enable_mask,
> > > >  					   acc_desc->enable_mask);
> > >
> > > Should the same fix be applied to other places which access acc_desc?
> > > For example cpr_pre_voltage() and cpr_post_voltage() which call
> > > cpr_set_acc()?
> >
> > With this patch alone, if acc_desc is NULL, cpr_probe() will fail
> > at the start itself because of this check
> >
> > 	if (!data->acc_desc && desc->cpr_type < CTRL_TYPE_CPRH)
> > 		return -EINVAL;
> >
> > After applying this patch series, cpr_probe will cross the above
> > check to accomodate IPQ9574. However, the check below will ensure
> > drv->tcsr is not initialized.
> >
> > 	if (desc->cpr_type < CTRL_TYPE_CPRH &&
> > 	    !of_device_is_compatible(dev->of_node, "qcom,ipq9574-cpr4"))
> >
> > cpr_pre_voltage() and cpr_post_voltage() call cpr_set_acc() only
> > if drv->tcsr is not NULL. Hence acc_desc need not be checked.
> >
> > Will add the check to cpr_pre_voltage() and cpr_post_voltage() if
> > you feel it will make it more robust regardless of the changes to
> > cpr_probe in future. Please let me know.
>
> Having !acc_desc check instead of the of_device_is_compatible would
> solve the issue.

Ok. Will post next version with that.

Thanks
Varada

