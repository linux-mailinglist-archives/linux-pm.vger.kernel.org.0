Return-Path: <linux-pm+bounces-36320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A8DBE6066
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 03:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBEAE3B7567
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 01:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDB71F9EC0;
	Fri, 17 Oct 2025 01:16:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA14D334691;
	Fri, 17 Oct 2025 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760663766; cv=none; b=Fc+z6nZDa8KlEroFrJOKckJt8R+23w+kQD1YSdHQ+cos8j4sF2S3PcC+pbhEWI5yGqDU9r+TedlE88ViByGvxPfbapA/5TbAttgy4i6SoyY8QAcnfzqzdMsJXIuAITFvFQTY+rco9jPS8bqmunMEbu6dREPnUvKnCZ9I8EFUjgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760663766; c=relaxed/simple;
	bh=Bgc9vMU0TT6EFEW0gQwJGrUuki8L4LXvDhpOK9tlHTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7j6odO77KudnlITuZYqx1rTD8b/7SxCS5GePh3Uq9JmDMei3AsCDH7vfYMY0hLO3Vjrt4I3Z9SBnO6C2AXlBbenFcAa2xApWBZbvKKBIed0gc2Gk4YLP+VaMsNzdQVesJHrUufqXSGkjQk4nmZqebUxMyWdKY9IFuSca5xDcQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d6b85104aaf611f0a38c85956e01ac42-20251017
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:553dcdf0-b480-428c-ac79-57f21655012d,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:baaff538ce2cf347ab541d112c01e87b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d6b85104aaf611f0a38c85956e01ac42-20251017
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 2146366030; Fri, 17 Oct 2025 09:15:58 +0800
Message-ID: <17d59056-d613-40a5-a2d1-9a03f8c3ab12@kylinos.cn>
Date: Fri, 17 Oct 2025 09:15:38 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] cpufreq: intel_pstate: hybrid: Adjust energy model
 rules
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Christian Loehle <christian.loehle@arm.com>
References: <2404176.ElGaqSPkdT@rafael.j.wysocki>
 <3394529.aeNJFYEL58@rafael.j.wysocki> <5932894.DvuYhMxLoT@rafael.j.wysocki>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <5932894.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/10/17 00:22, Rafael J. Wysocki 写道:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>
> v2 -> v3:
>     * Reduce cost differences between CPU types by 1 (Tian, Christian)
>     * Add a tag from Dietmar
>
> Note: The other patches in the series have not changed.
>
> v1 -> v2: New patch
>
> ---
>   drivers/cpufreq/intel_pstate.c |   35 ++++++++++++++---------------------
>   1 file changed, 14 insertions(+), 21 deletions(-)
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
> +	if (hybrid_get_cpu_type(dev->id) == INTEL_CPU_TYPE_ATOM) {
> +		if (hybrid_has_l3(dev->id)) /* E-core */
> +			*cost += 1;
> +	} else { /* P-core */
>   		*cost += 2;
> +	}
>   
>   	return 0;
>   }

LGTM
Reviewed-by: Yaxiong Tian <tianyaxiong@kylinos.cn>


