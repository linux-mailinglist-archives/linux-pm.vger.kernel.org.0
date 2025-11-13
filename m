Return-Path: <linux-pm+bounces-37952-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B9AC5742C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 12:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5423A16B0
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 11:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3C8320A0E;
	Thu, 13 Nov 2025 11:48:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFD227B34E;
	Thu, 13 Nov 2025 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034494; cv=none; b=gzMegZ57rapJZ/cVzFYCsDu+5cYXsREHzQA74Y+hk15iQWJ772Huu49m0qEZFtU9fjHz7G5UkkJudBchwwKv6ur00UxCpQxXCizmrk2aPDvBLLp72gXZO+zYjzhIcOVbv3h1vBTxzBstCeMXbjqli2aWxBKTX8sKlQUIBzjXc6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034494; c=relaxed/simple;
	bh=qhOfdGgBrrf6k/HsNHpiwuqkWULXk59D0/gyGV7+9Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I84NJXmRYZ13Lkb3CbtJqcwMWNUtTsTOBsy2Ed0UBrGnaGLaEzvC0fZph8yLiEroGgC+EQwk0kwqBfHp6BVuaqbb7ukUpybntKaUF0fkN+d7w6oTtTUeqekKQk7ne461+rSbgHFgW/eC/5FFOLJ7PSIaqevHQjdr1c5oZNP58mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B56D612FC;
	Thu, 13 Nov 2025 03:48:03 -0800 (PST)
Received: from [10.1.28.59] (e127648.arm.com [10.1.28.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C37513F66E;
	Thu, 13 Nov 2025 03:48:09 -0800 (PST)
Message-ID: <ec6af97c-5d9d-4485-a343-7e4683a51ab8@arm.com>
Date: Thu, 13 Nov 2025 11:48:06 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] cpuidle: governors: teo: Use s64 consistently in
 teo_update()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Reka Norman <rekanorman@chromium.org>
References: <4701737.LvFx2qVVIh@rafael.j.wysocki>
 <3026616.e9J7NaK4W3@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <3026616.e9J7NaK4W3@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/25 16:24, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Two local variables in teo_update() are defined as u64, but their
> values are then compared with s64 values, so it is more consistent
> to use s64 as their data type.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
>  drivers/cpuidle/governors/teo.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -157,8 +157,7 @@ static void teo_update(struct cpuidle_dr
>  {
>  	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
>  	int i, idx_timer = 0, idx_duration = 0;
> -	s64 target_residency_ns;
> -	u64 measured_ns;
> +	s64 target_residency_ns, measured_ns;
>  
>  	cpu_data->short_idles -= cpu_data->short_idles >> DECAY_SHIFT;
>  
> @@ -167,9 +166,9 @@ static void teo_update(struct cpuidle_dr
>  		 * If one of the safety nets has triggered, assume that this
>  		 * might have been a long sleep.
>  		 */
> -		measured_ns = U64_MAX;
> +		measured_ns = S64_MAX;
>  	} else {
> -		u64 lat_ns = drv->states[dev->last_state_idx].exit_latency_ns;
> +		s64 lat_ns = drv->states[dev->last_state_idx].exit_latency_ns;
>  
>  		measured_ns = dev->last_residency_ns;
>  		/*
> 
> 
> 


