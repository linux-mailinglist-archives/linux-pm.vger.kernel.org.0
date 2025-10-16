Return-Path: <linux-pm+bounces-36225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0180DBE2075
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 09:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FAF2421056
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 07:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B872FDC38;
	Thu, 16 Oct 2025 07:49:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80744214812;
	Thu, 16 Oct 2025 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600953; cv=none; b=suTvXe/kb+5R6rTDo+HKbRhv2KTPmm/KupLcbglP537aIe3zMd4wrfSK4DTLENYsj+/uNxDat45SJpYvIe678touxIkLG2s06CA6AjP9kwnonAbxUFO4eEIz2gLFL9OOBqJyd4B5QeRP3JCYwi10amWYcDlTVV+cH5kWHJGWUW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600953; c=relaxed/simple;
	bh=RjbmRx8/GdkOWRF92JnypmFwTgH5nqsGBf6mqWStoeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVTLMueIb6VAjNyF2IaHMB/xO61SXQyumoTVfInmfjX3y1m4Otr6GgBUabLfIkC9esDyqN8kHLo0lv5FTtMnQQsnVUl6CmdeILlqmZaOymMXStHvbGeyWNYVHoWPkmmfKV78Cnj5txMlXMNy4KEZT1FbIGGmtguTDRW4jXMo+ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9296f1b6aa6411f0a38c85956e01ac42-20251016
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF, CIE_UNKNOWN
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:78c828b6-5295-4228-9af5-4c6bdbb63c9a,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:78c828b6-5295-4228-9af5-4c6bdbb63c9a,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:14317c042bd57d89bbe3ebd40eb2eb47,BulkI
	D:251015231359I6R5N7TL,BulkQuantity:2,Recheck:0,SF:17|19|23|43|64|66|74|78
	|80|81|82|83|102|841|850,TC:nil,Content:0|52,EDM:-3,IP:-2,URL:0,File:nil,R
	T:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP
	:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9296f1b6aa6411f0a38c85956e01ac42-20251016
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(223.153.233.62)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1688555980; Thu, 16 Oct 2025 15:48:58 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: rafael@kernel.org
Cc: christian.loehle@arm.com,
	dietmar.eggemann@arm.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	srinivas.pandruvada@linux.intel.com,
	tianyaxiong@kylinos.cn
Subject: Re: [PATCH v2 3/3] cpufreq: intel_pstate: hybrid: Adjust energy model rules
Date: Thu, 16 Oct 2025 15:48:49 +0800
Message-Id: <20251016074849.1046580-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3394529.aeNJFYEL58@rafael.j.wysocki>
References: <3394529.aeNJFYEL58@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

在 2025/10/15 21:48, Rafael J. Wysocki 写道:> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of using HWP-to-frequency scaling factors for computing cost
> coefficients in the energy model used on hybrid systems, which is
> fragile, rely on CPU type information that is easily accessible now and
> the information on whether or not L3 cache is present for this purpose.
> 
> This also allows the cost coefficients for P-cores to be adjusted so
> that they start to be populated somewhat earlier (that is, before
> E-cores are loaded up to their full capacity).
> 
> In addition to the above, replace an inaccurate comment regarding the
> reason why the freq value is added to the cost in hybrid_get_cost().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/cpufreq/intel_pstate.c |   37 +++++++++++++++----------------------
>   1 file changed, 15 insertions(+), 22 deletions(-)
> 
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -933,11 +933,8 @@ static int hybrid_active_power(struct de
>   			       unsigned long *freq)
>   {
>   	/*
> -	 * Create "utilization bins" of 0-40%, 40%-60%, 60%-80%, and 80%-100%
> -	 * of the maximum capacity such that two CPUs of the same type will be
> -	 * regarded as equally attractive if the utilization of each of them
> -	 * falls into the same bin, which should prevent tasks from being
> -	 * migrated between them too often.
> +	 * Create four "states" corresponding to 40%, 60%, 80%, and 100% of the
> +	 * full capacity.
>   	 *
>   	 * For this purpose, return the "frequency" of 2 for the first
>   	 * performance level and otherwise leave the value set by the caller.
> @@ -970,26 +967,22 @@ static bool hybrid_has_l3(unsigned int c
>   static int hybrid_get_cost(struct device *dev, unsigned long freq,
>   			   unsigned long *cost)
>   {
> -	struct pstate_data *pstate = &all_cpu_data[dev->id]->pstate;
> -
> +	/* Facilitate load balancing between CPUs of the same type. */
> +	*cost = freq;
>   	/*
> -	 * The smaller the perf-to-frequency scaling factor, the larger the IPC
> -	 * ratio between the given CPU and the least capable CPU in the system.
> -	 * Regard that IPC ratio as the primary cost component and assume that
> -	 * the scaling factors for different CPU types will differ by at least
> -	 * 5% and they will not be above INTEL_PSTATE_CORE_SCALING.
> +	 * Adjust the cost depending on CPU type.
>   	 *
> -	 * Add the freq value to the cost, so that the cost of running on CPUs
> -	 * of the same type in different "utilization bins" is different.
> -	 */
> -	*cost = div_u64(100ULL * INTEL_PSTATE_CORE_SCALING, pstate->scaling) + freq;
> -	/*
> -	 * Increase the cost slightly for CPUs able to access L3 to avoid
> -	 * touching it in case some other CPUs of the same type can do the work
> -	 * without it.
> +	 * The idea is to start loading up LPE-cores before E-cores and start
> +	 * to populate E-cores when LPE-cores are utilized above 60% of the
> +	 * capacity.  Similarly, P-cores start to be populated when E-cores are
> +	 * utilized above 60% of the capacity.
>   	 */
> -	if (hybrid_has_l3(dev->id))
> -		*cost += 2;
> +	if (hybrid_get_cpu_type(dev->id) == INTEL_CPU_TYPE_ATOM) {
> +		if (hybrid_has_l3(dev->id)) /* E-core */
> +			*cost += 2;
> +	} else { /* P-core */
> +		*cost += 4;
> +	}
>   
>   	return 0;
>   }

Hi Rafael J. Wysocki:

Is the increment of this cost for different types of CPUs by one instead 
of two?

cost by increment of 2:
          0~40%  40%~60%  60%~80% 80%~100
LPE-core    2       3        4      5
E-core      4       5        6      7
P-core      6       7        8      9

So, tasks only start being allocated to more powerful CPUs when 
utilization exceeds 80%, but by that point the system is already in an
 overloaded state.

cost by increment of 1:
          0~40%  40%~60%  60%~80% 80%~100
LPE-core    2       3        4      5
E-core      3       4        5      6
P-core      4       5        6      7

This situation aligns with the description in your patch.

The idea of this patch looks good to me.

