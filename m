Return-Path: <linux-pm+bounces-11131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38340931F97
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 06:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97D64B21383
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 04:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A7915491;
	Tue, 16 Jul 2024 04:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R2B5jSg3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A453A33C5;
	Tue, 16 Jul 2024 04:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721103105; cv=none; b=XvDUEXcsfGxBAdb3IyxKUjRHXOfkV4I9hskwxpUDiMXGmked+pvpfixfmiFq2LCJG0NEWovZPkG1jHXPFvuUjNDQNMMpAx+KIRFFyOHIF/uZ9VeoJgfN1gL3jmz75B5ZuleZ8V6Bcz9wyy4vY2eH1pKVdcPamlH00tpFKD3jFew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721103105; c=relaxed/simple;
	bh=4bxyhAomRgLZ+AqOtDvq/JoWZxwzTUzq9W+EI9hIdPo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uegr8VU0G5rSl9iqKoZYcMUv+tnR8F3t7iBNrtaSU2sGhjqQlk548tGT+sYaNgwxqZI5rJtIbBeXrFDC9SXCLxsSREhHoN3apWbVpgOunk3GkzBWlHJfcMpgIWnJVXZwXatyEk+oJEGNhkJ2i5MTAY0DtUuSgVaOGD6/F+1HM4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R2B5jSg3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FH8kRB027507;
	Tue, 16 Jul 2024 04:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fo+iZasWI99bWRd1BQ3kIWHY
	EIZNFSckZCiR09n2asQ=; b=R2B5jSg3pSeE4W3GaD5pV2DgOyjq0AhI/s2bOYZI
	G40CfrIbwfaS/fegWJmVqmmm+cA6o9CC1a1HwchQmjyn3/ZB/MntKII9QJTG98yl
	Yl5exPNLe+xgRK/H0vPNtbzAkr4fUQJ/aqG5NAjIPk6c0oAN0X6D4ROA3cL5pMqh
	iSwPqsPIe+1/kycwytRnIx67uiaMjiGmCcRdimIFGCbutmhkF2r1I+n9nqxu5GfK
	6O0rPUr1lpBAHoOp4KlKJvFGEsulpPmOBp8MI/VwYcExIV33akLtMgMsrbZGUcAz
	jiDDJdSZPkvb0b2ha0KZcu/Ricd1iZvhbfFLPi+6SuS4EQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bgk6p0x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 04:11:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46G4BOS0006467
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 04:11:24 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Jul 2024 21:11:19 -0700
Date: Tue, 16 Jul 2024 09:41:16 +0530
From: Pavan Kondeti <quic_pkondeti@quicinc.com>
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        "Len
 Brown" <len.brown@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio"
	<konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf
 Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stanimir Varbanov
	<stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 1/2] PM: domains: add device managed version of
 dev_pm_domain_attach|detach_list()
Message-ID: <08860213-8933-4092-9345-9bd780019a2d@quicinc.com>
References: <1720763312-13018-1-git-send-email-quic_dikshita@quicinc.com>
 <1720763312-13018-2-git-send-email-quic_dikshita@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1720763312-13018-2-git-send-email-quic_dikshita@quicinc.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rFWv7F1rSOIHlwsK-qPTHeLvT_1AuqLG
X-Proofpoint-ORIG-GUID: rFWv7F1rSOIHlwsK-qPTHeLvT_1AuqLG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 suspectscore=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407160030

On Fri, Jul 12, 2024 at 11:18:30AM +0530, Dikshita Agarwal wrote:
> This patch adds the devres-enabled version of dev_pm_domain_attach|detach_list.
> If client drivers use devm_pm_domain_attach_list() to attach the PM domains,
> devm_pm_domain_detach_list() will be invoked implicitly during remove phase.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>  drivers/base/power/common.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  4 ++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index 327d168..082691e 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -277,6 +277,47 @@ int dev_pm_domain_attach_list(struct device *dev,
>  EXPORT_SYMBOL_GPL(dev_pm_domain_attach_list);
>  
>  /**
> + * dev_pm_domain_detach_list - devres-enabled version of dev_pm_domain_detach_list.
> + * @list: The list of PM domains to detach.
> + *
> + * This function reverse the actions from devm_pm_domain_attach_list().
> + * it will be invoked during the remove phase from drivers implicitly if driver
> + * uses devm_pm_domain_attach_list() to attach the PM domains.
> + */
> +void devm_pm_domain_detach_list(void *_list)
> +{
> +	struct dev_pm_domain_list *list = _list;
> +
> +	dev_pm_domain_detach_list(list);
> +}
> +EXPORT_SYMBOL_GPL(devm_pm_domain_detach_list);
> +
> +/**
> + * devm_pm_domain_attach_list - devres-enabled version of dev_pm_domain_attach_list
> + *
> + * NOTE: this will also handle calling devm_pm_domain_detach_list() for
> + * you during remove phase.
> + *
> + * Returns the number of attached PM domains or a negative error code in case of
> + * a failure.
> + */
> +int devm_pm_domain_attach_list(struct device *dev,
> +			       const struct dev_pm_domain_attach_data *data,
> +			       struct dev_pm_domain_list **list)
> +{
> +	int ret, num_pds = 0;
> +
> +	num_pds = dev_pm_domain_attach_list(dev, data, list);
> +
> +	ret = devm_add_action_or_reset(dev, devm_pm_domain_detach_list, (void *)list);
> +	if (ret)
> +		return ret;
> +
> +	return num_pds;
> +}
> +EXPORT_SYMBOL_GPL(devm_pm_domain_attach_list);
> +
> +/**
>   * dev_pm_domain_detach - Detach a device from its PM domain.
>   * @dev: Device to detach.
>   * @power_off: Used to indicate whether we should power off the device.
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 772d328..2f00150 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -450,8 +450,12 @@ struct device *dev_pm_domain_attach_by_name(struct device *dev,
>  int dev_pm_domain_attach_list(struct device *dev,
>  			      const struct dev_pm_domain_attach_data *data,
>  			      struct dev_pm_domain_list **list);
> +int devm_pm_domain_attach_list(struct device *dev,
> +			       const struct dev_pm_domain_attach_data *data,
> +			       struct dev_pm_domain_list **list);
>  void dev_pm_domain_detach(struct device *dev, bool power_off);
>  void dev_pm_domain_detach_list(struct dev_pm_domain_list *list);
> +void devm_pm_domain_detach_list(void *list);
>  int dev_pm_domain_start(struct device *dev);
>  void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
>  int dev_pm_domain_set_performance_state(struct device *dev, unsigned int state);

The stub functions for the newly added functions are missing in this
patch. They would be needed for !CONFIG_PM case.

Thanks,
Pavan

