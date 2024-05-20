Return-Path: <linux-pm+bounces-7992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CDA8C9ADA
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 11:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5871F21478
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 09:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A1D481CD;
	Mon, 20 May 2024 09:59:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A586A2D;
	Mon, 20 May 2024 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716199192; cv=none; b=udLvWVoreNTiDeRN76oIjf4IQTlM+jSYbhpPAOoizWUtzc6BRWXLC83Aj4Aetvnug4AKyMwJBWCccECjsTD+655uugFmkWpdki5tQBPVfUTOSFL6AiGGw0kgvc317b5h2iegLyp8h1BQSxBqWD+JWPi2AeMQzOp0cvqtA+27vds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716199192; c=relaxed/simple;
	bh=+1q/i+n4GCztk8YDv+eCsSlhH6pi0pOxH3nqm9nZp04=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ud4qpoOxLgKiyx6ohlQChu99xCuilKWI/t8JnyDtBUq5Ep6m4f5pjcelJl3oVs0t7ujf1hYfGQU9FDhaOpYRE8BcCoTYsECA6HFRjnHP87smRhn7VMZmFN6ag7QssBkQXNHMm3CMf4On4eZ5LAmQHPXg84AWtK1ZMCWbXVdVEgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 920481063;
	Mon, 20 May 2024 03:00:13 -0700 (PDT)
Received: from [10.57.81.9] (unknown [10.57.81.9])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA7363F766;
	Mon, 20 May 2024 02:59:47 -0700 (PDT)
Message-ID: <05820baa-b0a2-49e0-8b47-360774969e69@arm.com>
Date: Mon, 20 May 2024 10:59:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: teo: fix underflow of recent intercepts
From: Christian Loehle <christian.loehle@arm.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Qais Yousef <qyousef@layalina.io>, kajetan.puchalski@arm.com,
 Anna-Maria Behnsen <anna-maria@linutronix.de>
References: <0ce2d536-1125-4df8-9a5b-0d5e389cd8af@arm.com>
Content-Language: en-US
In-Reply-To: <0ce2d536-1125-4df8-9a5b-0d5e389cd8af@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/19/24 22:03, Christian Loehle wrote:
> The recent counter of each cpuidle state bin reflects the number of
> recent intercepts. It's decremented and incremented accordingly.
> The decrement was never checked for 0, therefore underflowing into a
> value teo cannot easily recover from.
> 
> The underflow lead to deeper idle states being skipped because teo
> assumed interception was likely and it preferring shallower states.
> 
> Fixes: 77577558f25d ("cpuidle: teo: Rework most recent idle duration values treatment")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/cpuidle/governors/teo.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> index 7244f71c59c5..42fb2771e35d 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -290,7 +290,8 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  	if (cpu_data->next_recent_idx >= NR_RECENT)
>  		cpu_data->next_recent_idx = 0;
>  
> -	if (cpu_data->recent_idx[i] >= 0)
> +	if (cpu_data->recent_idx[i] >= 0 &&
> +			cpu_data->state_bins[cpu_data->recent_idx[i]].recent)
>  		cpu_data->state_bins[cpu_data->recent_idx[i]].recent--;
>  
>  	/*

You should be able to observe the problematic underflow on any system.
Essentially these lines:
	alt_intercepts = 2 * idx_intercept_sum > cpu_data->total - idx_hit_sum;
	alt_recent = idx_recent_sum > NR_RECENT / 2; // CL: idx_recent_sum being the sum of a bunch of underflowed recent values, so expected to be big, too.
	if (alt_recent || alt_intercepts) {
become
	if (true) {

but the if block actually overriding the state should only be possible
for systems with >2 cpuidle states.
I'll follow up with a more detailed report though.

