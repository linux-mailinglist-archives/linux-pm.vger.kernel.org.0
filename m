Return-Path: <linux-pm+bounces-40208-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B1ACF462F
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 16:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDBB2303398E
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 15:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931FA261B8C;
	Mon,  5 Jan 2026 15:17:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB2C1F4CB3;
	Mon,  5 Jan 2026 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767626232; cv=none; b=h7eq3WIFRrwfMTzv9qU7JHObUwxZG/kHsgkwcaDZ9FYsF36EFPOHdyl5kH306NCqCjNCcjRVgfIh4ouCmXawP4F11yFjHKVSMN4KCUFVjsTOnfEypBODJecHCru4HPONUk1sk5RoHJkLBtKhu7f0A7qYwY0Iej1txm9EADDipO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767626232; c=relaxed/simple;
	bh=N1EGCKO1uB5XdTNJY02wsXJJ4tZW9+ZDdhRf/DqL3v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tC+RmPT6ohSDJckSt0TyHPGT/QbI9pX+bpgVmolVriSAJeZYo9nkk7UfCtyt6XmVTcf9kzH9iKwhhfbDubnL2oq0BQjpIh/6fzLCINq4/0OxQ0l6VlY5Rl3T/dl8Gad3MHkBwUwFE4yNyFl/Tg9QdAaHi7jku9qJCjRR9Ro++UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B801A339;
	Mon,  5 Jan 2026 07:17:02 -0800 (PST)
Received: from [10.57.11.122] (unknown [10.57.11.122])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF29F3F5A1;
	Mon,  5 Jan 2026 07:17:07 -0800 (PST)
Message-ID: <73439919-e24d-4bd5-a7ed-d7633beb5e4f@arm.com>
Date: Mon, 5 Jan 2026 15:17:05 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: menu: Remove incorrect unlikely() annotation
To: Breno Leitao <leitao@debian.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <20260105-annotated_idle-v1-1-10ddf0771b58@debian.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260105-annotated_idle-v1-1-10ddf0771b58@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/26 14:37, Breno Leitao wrote:
> The unlikely() annotation on the early-return condition in menu_select()
> is incorrect on systems with only one idle state (e.g., ARM64 servers
> with a single ACPI LPI state). Branch profiling shows 100% misprediction
> on such systems since drv->state_count <= 1 is always true.
> 
> On platforms where only state0 is available, this path is the common
> case, not an unlikely edge case. Remove the misleading annotation to
> let the branch predictor learn the actual behavior.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/cpuidle/governors/menu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 64d6f7a1c776..ef9c5a84643e 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -271,7 +271,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  		data->bucket = BUCKETS - 1;
>  	}
>  
> -	if (unlikely(drv->state_count <= 1 || latency_req == 0) ||
> +	if (drv->state_count <= 1 || latency_req == 0 ||
>  	    ((data->next_timer_ns < drv->states[1].target_residency_ns ||
>  	      latency_req < drv->states[1].exit_latency_ns) &&
>  	     !dev->states_usage[0].disable)) {
> 
> ---
> base-commit: 34aa263125b6732375abcb908d73d98169154bb5
> change-id: 20260105-annotated_idle-d6b614ecd207
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 
> 

Fine with me per se, I don't think the unlikely() annotation makes a
difference for the 'good case' either, but if you run into this I'd be curious
if you can see a difference with menu (which should stop the tick on every idle enter
regardless) and teo (which should never stop the tick on state_count == 1).
Alternative you can also just change the menu branch to not stop the tick.
I'd like to know if we need something more sophisticated generally here.

