Return-Path: <linux-pm+bounces-35493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4531BA4E52
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 20:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FBBA1C059E7
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 18:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF8030C630;
	Fri, 26 Sep 2025 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciFsacAK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D853090EC;
	Fri, 26 Sep 2025 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758911370; cv=none; b=Hf+3P+EpHoDBJc6/lRPwEaoU4FmZ5iY2kmmSMA4r+dvOtsKLIVeMIW3YjdooNz1HO1BfZl9T4TufGL4T1ddrv0rtvdpmLwsjLWGnJr9VdCTsV2VI/rLKce6mrqjfKH3f3SRhslcoQFp06TVuESFnDvfNXkK2uS99LzHvUTdsJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758911370; c=relaxed/simple;
	bh=IixPxHHIoOB91FusLLycCABHM1SBl3OhA4P69+FGoaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GqkpfS/tJZaTIiUTvAjlYJwu2lM9STi31+BmDxlAfE0L74/Lde2QF4UXFserLGCXt9t2+L/fk7qAS/8EVkCyR+/gjICOLFAfUFDF9+M5hZd8tn6pbvHyqFtwTMGQA+NQLbt9oLXVzco1f6GZa3MDDp0k7KG0wcrCj5BIhSf4zdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciFsacAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577A3C4CEF4;
	Fri, 26 Sep 2025 18:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758911369;
	bh=IixPxHHIoOB91FusLLycCABHM1SBl3OhA4P69+FGoaI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ciFsacAKEbi+bBHDjMcma3/n3Nf2PLQEagqLs5ESCqK/z9arDXoif85Tw85rUu7jI
	 wYGbbn1B9JRYcdcCOMgeNbONVekvfSbg+cPHnO9sF2v8Y4OnN6TctCeRtUyyu+H/V1
	 GWPbVqD8vwSLeSQvzgghxeTCLiEfO4/Q0YupJzIsPJAEmYhR4CCOeTjzyKJwMkr61P
	 VEOdVNttZ+XY9mog7gEWFwHItwDE2MVXOR3OOMHv5wKdKibiayu8076cMALMY+sLx1
	 ga1qpFp0cK7rVKE0OxXg22hWrijgwQYr3apPQKkT3WBRC0YFYY8M2iahRmtduZ4MJ0
	 bfqEYhEYelVCA==
Message-ID: <e47c4c32-faea-4b24-a77e-9a3ec0e2b757@kernel.org>
Date: Fri, 26 Sep 2025 13:29:28 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] PM: hibernate: Combine return paths in
 power_down()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <3303305.5fSG56mABF@rafael.j.wysocki>
 <3571055.QJadu78ljV@rafael.j.wysocki>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <3571055.QJadu78ljV@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/26/25 11:41 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> To avoid code duplication and improve clarity, combine the code
> paths in power_down() leading to a return from that function.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The actual change looks fine to me.

Since it's used in "both" a success and failure path would you consider 
using "wakeup" for the label instead of "rollback"?  Or anything else 
you can think of that doesn't have a connotation of failure.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   kernel/power/hibernate.c |   32 ++++++++++++++------------------
>   1 file changed, 14 insertions(+), 18 deletions(-)
> 
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -708,21 +708,11 @@ static void power_down(void)
>   	if (hibernation_mode == HIBERNATION_SUSPEND) {
>   		pm_restore_gfp_mask();
>   		error = suspend_devices_and_enter(mem_sleep_current);
> -		if (error) {
> -			hibernation_mode = hibernation_ops ?
> -						HIBERNATION_PLATFORM :
> -						HIBERNATION_SHUTDOWN;
> -		} else {
> -			/* Match pm_restore_gfp_mask() call in hibernate() */
> -			pm_restrict_gfp_mask();
> +		if (!error)
> +			goto rollback;
>   
> -			/* Restore swap signature. */
> -			error = swsusp_unmark();
> -			if (error)
> -				pr_err("Swap will be unusable! Try swapon -a.\n");
> -
> -			return;
> -		}
> +		hibernation_mode = hibernation_ops ? HIBERNATION_PLATFORM :
> +						     HIBERNATION_SHUTDOWN;
>   	}
>   #endif
>   
> @@ -733,12 +723,9 @@ static void power_down(void)
>   	case HIBERNATION_PLATFORM:
>   		error = hibernation_platform_enter();
>   		if (error == -EAGAIN || error == -EBUSY) {
> -			/* Match pm_restore_gfp_mask() in hibernate(). */
> -			pm_restrict_gfp_mask();
> -			swsusp_unmark();
>   			events_check_enabled = false;
>   			pr_info("Wakeup event detected during hibernation, rolling back.\n");
> -			return;
> +			goto rollback;
>   		}
>   		fallthrough;
>   	case HIBERNATION_SHUTDOWN:
> @@ -757,6 +744,15 @@ static void power_down(void)
>   	pr_crit("Power down manually\n");
>   	while (1)
>   		cpu_relax();
> +
> +rollback:
> +	/* Match the pm_restore_gfp_mask() call in hibernate(). */
> +	pm_restrict_gfp_mask();
> +
> +	/* Restore swap signature. */
> +	error = swsusp_unmark();
> +	if (error)
> +		pr_err("Swap will be unusable! Try swapon -a.\n");
>   }
>   
>   static int load_image_and_restore(void)
> 
> 
> 


