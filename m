Return-Path: <linux-pm+bounces-8301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 387498D2548
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 21:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF632902A4
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 19:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D41917837A;
	Tue, 28 May 2024 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bde+UQcB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C35431A60;
	Tue, 28 May 2024 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716926186; cv=none; b=VdnHZmCeluCKdgQ/l2DcLE1kVMW4sOLQPouK+wv1808HDoqPHSZ6maVmZb5E2Y7UfNhjXpj0FOHQDqwlXtswe/Fv1ZmkAhf3D130evyUs4DgzF6N6PxYGPVNOx2PpD4l0SM3tONqS3uTkQTX3q9zW4TyTgiO/qlTJTVER+lA8NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716926186; c=relaxed/simple;
	bh=8epW/QFJvHhVzhIz2U+4mF0PmxPK/CRJXwLf/jmU9L4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UNjQwsL3XdCG9XNUSLzmCdI9RfcXA/fXZUEm+eqrXpqXAg9eYqTYmfzFWIjO446FVjAZx8WKXrqhNCiQNpV25HlvadZncpZAByW0i1X6c7MQQLiPKDMML+j1nzJ+u5SFhqHPzugBZJwv3yMK2lm+XM8asXoTFBUnq/iU++f6Pqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bde+UQcB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SBgJO4024256;
	Tue, 28 May 2024 19:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ss6qpj70lx4SSpC0e8leTpGEkEBXzU/46li19BBg28g=; b=bde+UQcBuGKkl4fn
	HpFDu6uOJIohYY/zhogjojymsxVzn7wWvkqH7FHrUYEPj+Fon1luIEOVbo4C24BO
	0QN11Zs+fzskjb+5k3d6xAWtjVD99N+wHXRHqvWxTgKY1kLke/Pyz0vOaLrL+ygk
	yxu9imsr7yi7PFObTBf/S/k/uG04pPuzbgJiBaM3F+oXib+AKrA/IqyNdn2jqHdC
	rXvQZWlTTTD1C71KfaL9OCWv1oyUkcP3C9PYMPGQzFZmaE/ERGJSB9tjDzJD2JRb
	jVYxCCWg/50zeg3mNM453Ze0x8T0FxeUpK8TY38H48K6sYOpL6+WRhlEOKrn+oBf
	joaPtw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ybadx75qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 19:56:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44SJtxFG021884
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 19:55:59 GMT
Received: from [10.110.83.142] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 May
 2024 12:55:59 -0700
Message-ID: <52dce8d3-acfa-4f2c-92d0-c25aa59d6526@quicinc.com>
Date: Tue, 28 May 2024 12:55:58 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] pmdomain: core: Enable s2idle for CPU PM domains
 on PREEMPT_RT
To: Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki"
	<rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, <linux-pm@vger.kernel.org>
CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Nikunj Kela
	<nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Maulik Shah
	<quic_mkshah@quicinc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-rt-users@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240527142557.321610-1-ulf.hansson@linaro.org>
 <20240527142557.321610-2-ulf.hansson@linaro.org>
Content-Language: en-US
From: Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20240527142557.321610-2-ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cyEDIH1xDygla6iRX7ooHFmnl_q1DzTC
X-Proofpoint-GUID: cyEDIH1xDygla6iRX7ooHFmnl_q1DzTC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2405280149


On 5/27/2024 7:25 AM, Ulf Hansson wrote:
> To allow a genpd provider for a CPU PM domain to enter a domain-idle-state
> during s2idle on a PREEMPT_RT based configuration, we can't use the regular
> spinlock, as they are turned into sleepable locks on PREEMPT_RT.
>
> To address this problem, let's convert into using the raw spinlock, but
> only for genpd providers that have the GENPD_FLAG_CPU_DOMAIN bit set. In
> this way, the lock can still be acquired/released in atomic context, which
> is needed in the idle-path for PREEMPT_RT.
>
> Do note that the genpd power-on/off notifiers may also be fired during
> s2idle, but these are already prepared for PREEMPT_RT as they are based on
> the raw notifiers. However, consumers of them may need to adopt accordingly
> to work properly on PREEMPT_RT.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
> 	- None.
>
> ---
>  drivers/pmdomain/core.c   | 47 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/pm_domain.h |  5 ++++-
>  2 files changed, 50 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 623d15b68707..072e6bdb6ee6 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -117,6 +117,48 @@ static const struct genpd_lock_ops genpd_spin_ops = {
>  	.unlock = genpd_unlock_spin,
>  };
>  
> +static void genpd_lock_raw_spin(struct generic_pm_domain *genpd)
> +	__acquires(&genpd->raw_slock)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&genpd->raw_slock, flags);
> +	genpd->raw_lock_flags = flags;
> +}
> +
> +static void genpd_lock_nested_raw_spin(struct generic_pm_domain *genpd,
> +					int depth)
> +	__acquires(&genpd->raw_slock)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave_nested(&genpd->raw_slock, flags, depth);
> +	genpd->raw_lock_flags = flags;
> +}
> +
> +static int genpd_lock_interruptible_raw_spin(struct generic_pm_domain *genpd)
> +	__acquires(&genpd->raw_slock)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&genpd->raw_slock, flags);
> +	genpd->raw_lock_flags = flags;
> +	return 0;
> +}
> +
> +static void genpd_unlock_raw_spin(struct generic_pm_domain *genpd)
> +	__releases(&genpd->raw_slock)
> +{
> +	raw_spin_unlock_irqrestore(&genpd->raw_slock, genpd->raw_lock_flags);
> +}
> +
> +static const struct genpd_lock_ops genpd_raw_spin_ops = {
> +	.lock = genpd_lock_raw_spin,
> +	.lock_nested = genpd_lock_nested_raw_spin,
> +	.lock_interruptible = genpd_lock_interruptible_raw_spin,
> +	.unlock = genpd_unlock_raw_spin,
> +};
> +
>  #define genpd_lock(p)			p->lock_ops->lock(p)
>  #define genpd_lock_nested(p, d)		p->lock_ops->lock_nested(p, d)
>  #define genpd_lock_interruptible(p)	p->lock_ops->lock_interruptible(p)
> @@ -2079,7 +2121,10 @@ static void genpd_free_data(struct generic_pm_domain *genpd)
>  
>  static void genpd_lock_init(struct generic_pm_domain *genpd)
>  {
> -	if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
> +	if (genpd->flags & GENPD_FLAG_CPU_DOMAIN) {
> +		raw_spin_lock_init(&genpd->raw_slock);
> +		genpd->lock_ops = &genpd_raw_spin_ops;
> +	} else if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {

Hi Ulf, though you are targeting only CPU domains for now, I wonder if
FLAG_IRQ_SAFE will be a better choice?  The description of the flag says
it is safe for atomic context which won't be the case for PREEMPT_RT? 


>  		spin_lock_init(&genpd->slock);
>  		genpd->lock_ops = &genpd_spin_ops;
>  	} else {
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index f24546a3d3db..0d7fc47de3bc 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -194,8 +194,11 @@ struct generic_pm_domain {
>  			spinlock_t slock;
>  			unsigned long lock_flags;
>  		};
> +		struct {
> +			raw_spinlock_t raw_slock;
> +			unsigned long raw_lock_flags;
> +		};
>  	};
> -
>  };
>  
>  static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)

