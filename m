Return-Path: <linux-pm+bounces-19267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 698319F257F
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 20:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F9F18825D7
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 19:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7291B87C7;
	Sun, 15 Dec 2024 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U9yYFq9u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D403C192D76;
	Sun, 15 Dec 2024 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734289368; cv=none; b=EvILtGn8WW1MX953xGrM/mPJVAbGKKWL328nJ28iWCsfiYdDbYMGs3Jaq4hz+JtyrmZPT9D5pXZ6E1XyEMVG0hh8vp8qzj3fJbapkA5NX2aZWpLQpcs+LYK8c8dkprtH8DE0ML1sZ3QT8lYAfdr207Ria7n1rN2pODP+Wfc+Wmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734289368; c=relaxed/simple;
	bh=5wgYjyIp/JT/tJn/YqdvA5A07C5vcJybT0TuAJFmO2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qEi3MRIUSo+BNJFmi6jNDALxKVY21uwZYMhZLqvtTEbSBDRgI21nG9h78PVqAm8gEoeKBUoS1U2SifCZjB/cXE+PX2am0eatZJsfCya/sCAhtTVIbelGwDqf9YjuDUT2vb919aAh5Xm8Z6tlhrfup3P54Yvuu90Pnd0qZT1Uqr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U9yYFq9u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BFHgsU8010575;
	Sun, 15 Dec 2024 19:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O6Du/W2RTrVQoyBwGNVh+rPSOyikaF9NgKinBBPgp04=; b=U9yYFq9uayB2iVgb
	7mkGt65Ks+m2EGNEhek/FYRKHxt1Qdr5HIk3DgJgJTDmeDlm4IrW06fjk9C3Ie0e
	gmls+W6xgD8EZemVVD1PNdKJfp7r19M42MLi1Z3/d8/N5JI1EcCatF6JJ/eFbfEI
	YS+YmA6q9yHXb4Qciv1M+PGLz9BjGKCCSlw7IfaBwTJHGuZ1b5gbOAUSWXWXQsps
	mcofEve8Tjy6Lbn1isjCEL3TBqktt59V40mhTRGgYzLuA5rf+TH4KPBf+TWCEDd5
	VZC545JNKH7/ThyeGRSBRPRZULJiSCnGd92KsRF2KkQ9FoJrf+NRnThn69X9rgXh
	5x1jeg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43hu3yrqkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 19:02:37 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BFJ2aBL023629
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 19:02:36 GMT
Received: from [10.216.10.72] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 15 Dec
 2024 11:02:34 -0800
Message-ID: <3a8685b4-c18e-e3ca-60f2-893e3a9e0ecd@quicinc.com>
Date: Mon, 16 Dec 2024 00:32:22 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] thermal/thresholds: Fix boundaries and detection routine
To: Daniel Lezcano <daniel.lezcano@linaro.org>, <rafael@kernel.org>
CC: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        "open
 list:THERMAL" <linux-pm@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>
References: <20241212190737.4127274-1-daniel.lezcano@linaro.org>
From: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
In-Reply-To: <20241212190737.4127274-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jDrlc2QBKwLt3_wcLyMn-pJChwgwK9aM
X-Proofpoint-ORIG-GUID: jDrlc2QBKwLt3_wcLyMn-pJChwgwK9aM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 clxscore=1011 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412150165


Hi Daniel,


On 12/13/2024 12:37 AM, Daniel Lezcano wrote:
> The current implementation does not work if the thermal zone is
> interrupt driven only.
>
> The boundaries are not correctly checked and computed as it happens
> only when the temperature is increasing or decreasing.
>
> The problem arises because the routine to detect when we cross a
> threshold is correlated with the computation of the boundaries. We
> assume we have to recompute the boundaries when a threshold is crossed
> but actually we should do that even if the it is not the case.
>
> Mixing the boundaries computation and the threshold detection for the
> sake of optimizing the routine is much more complex as it appears
> intuitively and prone to errors.
>
> This fix separates the boundaries computation and the threshold
> crossing detection into different routines. The result is a code much
> more simple to understand, thus easier to maintain.
>
> The drawback is we browse the thresholds list several time but we can
> consider that as neglictible because that happens when the temperature
> is updated. There are certainly some aeras to improve in the
> temperature update routine but it would be not adequate as this change
> aims to fix the thresholds for v6.13.
>
> Fixes: 445936f9e258 ("thermal: core: Add user thresholds support")
> Tested-by: Daniel Lezcano <daniel.lezcano@linaro.org> # rock5b, Lenovo x13s
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/thermal_thresholds.c | 68 +++++++++++++++-------------
>   1 file changed, 36 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/thermal/thermal_thresholds.c b/drivers/thermal/thermal_thresholds.c
> index d9b2a0bb44fc..dc2852721151 100644
> --- a/drivers/thermal/thermal_thresholds.c
> +++ b/drivers/thermal/thermal_thresholds.c
> @@ -69,58 +69,60 @@ static struct user_threshold *__thermal_thresholds_find(const struct list_head *
>   	return NULL;
>   }
>   
> -static bool __thermal_threshold_is_crossed(struct user_threshold *threshold, int temperature,
> -					   int last_temperature, int direction,
> -					   int *low, int *high)
> +static bool thermal_thresholds_handle_raising(struct list_head *thresholds, int temperature,
> +					      int last_temperature)
>   {
> +	struct user_threshold *t;
>   
> -	if (temperature >= threshold->temperature) {
> -		if (threshold->temperature > *low &&
> -		    THERMAL_THRESHOLD_WAY_DOWN & threshold->direction)
> -			*low = threshold->temperature;
> +	list_for_each_entry(t, thresholds, list_node) {
>   
> -		if (last_temperature < threshold->temperature &&
> -		    threshold->direction & direction)
> -			return true;
> -	} else {
> -		if (threshold->temperature < *high && THERMAL_THRESHOLD_WAY_UP
> -		    & threshold->direction)
> -			*high = threshold->temperature;
> +		if (!(t->direction & THERMAL_THRESHOLD_WAY_UP))
> +		    continue;
>   
> -		if (last_temperature >= threshold->temperature &&
> -		    threshold->direction & direction)
> +		if (temperature >= t->temperature &&
> +		    last_temperature < t->temperature)
>   			return true;
>   	}
>   
>   	return false;
>   }
>   
> -static bool thermal_thresholds_handle_raising(struct list_head *thresholds, int temperature,
> -					      int last_temperature, int *low, int *high)
> +static bool thermal_thresholds_handle_dropping(struct list_head *thresholds, int temperature,
> +					       int last_temperature)
>   {
>   	struct user_threshold *t;
>   
> -	list_for_each_entry(t, thresholds, list_node) {
> -		if (__thermal_threshold_is_crossed(t, temperature, last_temperature,
> -						   THERMAL_THRESHOLD_WAY_UP, low, high))
> +	list_for_each_entry_reverse(t, thresholds, list_node) {
> +
> +		if (!(t->direction & THERMAL_THRESHOLD_WAY_DOWN))
> +		    continue;
> +
> +		if (temperature < t->temperature &&
> +		    last_temperature >= t->temperature)
>   			return true;

Currently WAY_UP notification triggers if temperature is greater than or 
equal to t-> temperature, but for WAY_DOWN

it is only checking temperature is less than t->temperature. Why don't 
we include temperature = t->temperature

for WAY_DOWN threshold ? In that case it will be consistent for both 
WAY_UP and WAY_DOWN notification for userspace.

If we are not considering 'equal to' for WAY_DOWN, there is a 
possibility of missing WAY_DOWN notification if a sensor

is violated with same WAY_DOWN threshold temperature and only interrupt 
mode is enabled for that sensor.


Thank you

Manaf

>   	}
>   
>   	return false;
>   }
>   
> -static bool thermal_thresholds_handle_dropping(struct list_head *thresholds, int temperature,
> -					       int last_temperature, int *low, int *high)
> +static void thermal_threshold_find_boundaries(struct list_head *thresholds, int temperature,
> +					      int *low, int *high)
>   {
>   	struct user_threshold *t;
>   
> -	list_for_each_entry_reverse(t, thresholds, list_node) {
> -		if (__thermal_threshold_is_crossed(t, temperature, last_temperature,
> -						   THERMAL_THRESHOLD_WAY_DOWN, low, high))
> -			return true;
> +	list_for_each_entry(t, thresholds, list_node) {
> +		if (temperature < t->temperature &&
> +		    (t->direction & THERMAL_THRESHOLD_WAY_UP) &&
> +		    *high > t->temperature)
> +			*high = t->temperature;
>   	}
>   
> -	return false;
> +	list_for_each_entry_reverse(t, thresholds, list_node) {
> +		if (temperature > t->temperature &&
> +		    (t->direction & THERMAL_THRESHOLD_WAY_DOWN) &&
> +		    *low < t->temperature)
> +			*low = t->temperature;
> +	}
>   }
>   
>   void thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, int *high)
> @@ -132,6 +134,8 @@ void thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, int *hi
>   
>   	lockdep_assert_held(&tz->lock);
>   
> +	thermal_threshold_find_boundaries(thresholds, temperature, low, high);
> +
>   	/*
>   	 * We need a second update in order to detect a threshold being crossed
>   	 */
> @@ -151,12 +155,12 @@ void thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, int *hi
>   	 * - decreased : thresholds are crossed the way down
>   	 */
>   	if (temperature > last_temperature) {
> -		if (thermal_thresholds_handle_raising(thresholds, temperature,
> -						      last_temperature, low, high))
> +		if (thermal_thresholds_handle_raising(thresholds,
> +						      temperature, last_temperature))
>   			thermal_notify_threshold_up(tz);
>   	} else {
> -		if (thermal_thresholds_handle_dropping(thresholds, temperature,
> -						       last_temperature, low, high))
> +		if (thermal_thresholds_handle_dropping(thresholds,
> +						       temperature, last_temperature))
>   			thermal_notify_threshold_down(tz);
>   	}
>   }

