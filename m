Return-Path: <linux-pm+bounces-24137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3ABA645B5
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 09:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB211680D7
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 08:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFA321CC64;
	Mon, 17 Mar 2025 08:35:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC8B191499;
	Mon, 17 Mar 2025 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742200546; cv=none; b=Mu3GZSODxN/teM/PHudq0oaNDqP6bbJPuDxaTcd/mxNG0Z82OlkZTwpT76DJ+r1E9Dah4WRCG2kbsUKlfIn7U2zFqlmteWr+tKTuMiu2FtQ6eaCTgevMA+n0aPz/vGN032Tlg6wMWLDVpetcg6qR7xFFiqoISKXrudb8in+fa3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742200546; c=relaxed/simple;
	bh=PNCX0IbECCUET8eDzILsETuGYO44sI8lDbE99Xe/R34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXo9UM8ooywL+wkUPY6nRbUMQdKcfqXQoo5H+MdGIF+snmgyn1DSSQaqL/18fsu1EFU5Zw8mnGfpTzfmLuWPZ9a6XrDbYKwpzZWrT6CQSxuapyTg1dGi6tTuTiRJ9t5RAug8UU+CNnNMCaQY8nluaBSVQLthQL4LW3762MzG7o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EA1C13D5;
	Mon, 17 Mar 2025 01:35:49 -0700 (PDT)
Received: from [192.168.188.123] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC26A3F673;
	Mon, 17 Mar 2025 01:35:38 -0700 (PDT)
Message-ID: <525a2352-dc57-45ca-adb2-f7039c37145e@arm.com>
Date: Mon, 17 Mar 2025 08:35:34 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cpuidle: menu: Prefer polling state for short idle
 durations
To: Aboorva Devarajan <aboorvad@linux.ibm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Gautam Menghani <gautam@linux.ibm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250317060357.29451-1-aboorvad@linux.ibm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250317060357.29451-1-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/25 06:03, Aboorva Devarajan wrote:
> Avoid selecting deep idle state when the predicted idle duration is
> shorter than its target residency, as this leads to unnecessary state
> transitions without energy savings.
> 
> On virtualized PowerPC (pseries) systems, where only one polling state
> (Snooze) and one deep state (CEDE) are available, selecting CEDE when
> its target residency exceeds the predicted idle duration hurts
> performance.
> 
> For example, if the predicted idle duration is 15 us and the first
> non-polling state has a target residency of 120 us, selecting it
> would be suboptimal.
> 
> Remove the condition introduced in commit 69d25870f20c
> ("cpuidle: fix the menu governor to boost IO performance") that
> prioritized non-polling states even when their target residency
> exceeded the predicted idle duration and allow polling states to
> be selected when appropriate.
> 
> Performance improvement observed with pgbench on PowerPC (pseries)
> system:
> +---------------------------+------------+------------+------------+
> | Metric                    | Baseline   | Patched    | Change (%) |
> +---------------------------+------------+------------+------------+
> | Transactions/sec (TPS)    | 494,834    | 538,707    | +8.85%     |
> | Avg latency (ms)          | 0.162      | 0.149      | -8.02%     |
> +---------------------------+------------+------------+------------+
> 
> CPUIdle state usage:
> +--------------+--------------+-------------+
> | Metric       | Baseline     | Patched     |
> +--------------+--------------+-------------+
> | Total usage  | 12,703,630   | 13,941,966  |
> | Above usage  | 11,388,990   | 1,620,474   |
> | Below usage  | 19,973       | 684,708     |
> +--------------+--------------+-------------+
> 
> Above/Total and Below/Total usage percentages:
> +------------------------+-----------+---------+
> | Metric                 | Baseline  | Patched |
> +------------------------+-----------+---------+
> | Above % (Above/Total)  | 89.67%    | 11.63%  |
> | Below % (Below/Total)  | 0.16%     | 4.91%   |
> | Total cpuidle miss (%) | 89.83%    | 16.54%  |
> +------------------------+-----------+---------+
> 
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> 
> ---
> 
> v1: https://lore.kernel.org/all/20240809073120.250974-1-aboorvad@linux.ibm.com/
> 
> v1 -> v2:
> 
> - Drop cover letter and improve commit message.
> ---
>  drivers/cpuidle/governors/menu.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 28363bfa3e4c..4b199377e4be 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -296,17 +296,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  			idx = i; /* first enabled state */
>  
>  		if (s->target_residency_ns > predicted_ns) {
> -			/*
> -			 * Use a physical idle state, not busy polling, unless
> -			 * a timer is going to trigger soon enough.
> -			 */
> -			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> -			    s->exit_latency_ns <= latency_req &&
> -			    s->target_residency_ns <= data->next_timer_ns) {
> -				predicted_ns = s->target_residency_ns;
> -				idx = i;
> -				break;
> -			}
>  			if (predicted_ns < TICK_NSEC)
>  				break;
>  

I'm still fine with this and don't see a better way to solve the reported
issue generally, see the discussion on v1.
Rafael, do you have any objections?
We could make this conditional on there being a high latency difference between
polling and non-polling to keep x86 behavior.

