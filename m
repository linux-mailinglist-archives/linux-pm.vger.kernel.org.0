Return-Path: <linux-pm+bounces-35488-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3615BA4B3A
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 18:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3CD2A6752
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 16:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884303054F9;
	Fri, 26 Sep 2025 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdQC/krJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1453043D4;
	Fri, 26 Sep 2025 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905249; cv=none; b=SA1kMLjfRNPRwYPl8hCFUS3oZulzHJ9gnjtIvwvp86fYohpJ4Y4qiXNzGvkjgHok2v3GDE+txWWnHQblmZiVFbsUtbQOrMb4fuG99bBjqnhlsUjw5FC9PHoJ//NBWLnVnb18dppMNhAOpYUdmOIqapnmt1TF7B/TSCq3lxICvy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905249; c=relaxed/simple;
	bh=rrEBx18qzXSvz+cyceSpbHcd1Pd95v0VXH07nAr2mG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clGsEIkRU7jW0ZMT1z6SSNwQKvZkNCF+ILz2ozWpQkAr45CRB6dPoWBdwhRrWJGM5CDqOccsYmJmVP3Z+DEo0UlYd9j4p2kzud8NcwCuJUQfIIoquEQrXNY8gUarUgLWMABoDXPRXDEXad4FKlMsDtNgeUx9/mJTBqVX/sb0OFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdQC/krJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968C3C4CEF4;
	Fri, 26 Sep 2025 16:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758905248;
	bh=rrEBx18qzXSvz+cyceSpbHcd1Pd95v0VXH07nAr2mG0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YdQC/krJzFBoouzCqqmrIKtiUm53faJ6TwL5uucxOvIeHAiGJ2QKkVydXU1KLkKob
	 ejuvmGFGNSoPzFXLcspgIAL2EpOtfzRmYT1JecI8oHaNWhlIWk6F1l1Ll87eMOuEDh
	 IrmMVUbNN6TdWf61AlxIEEUt4lYcM7zt/8JCsOUK40X0s8zBObtXnsXZOFcjOZdNJE
	 bgIUYthyj6ZaRzRa9srXLAqUBijkBl49SAI83yHAUL26uE1eLnSo5q1FeQt2oSPWqX
	 pyunpFS7ORCUaQNdB3E+NCSDNlC7LAQARKrROSppBJTtr1M/za/5Z7TqqtiJE5uqIG
	 iYwduE56x2ywQ==
Message-ID: <880b6e4d-58c3-4fb7-a378-12b842fcc7c9@kernel.org>
Date: Fri, 26 Sep 2025 11:47:26 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] PM: hibernate: Restrict GFP mask in power_down()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <3303305.5fSG56mABF@rafael.j.wysocki>
 <8625379.NyiUUSuA9g@rafael.j.wysocki>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <8625379.NyiUUSuA9g@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/26/25 11:40 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 12ffc3b1513e ("PM: Restrict swap use to later in the
> suspend sequence") caused hibernation_platform_enter() to call
> pm_restore_gfp_mask() via dpm_resume_end(), so when power_down()
> returns after aborting hibernation_platform_enter(), it needs
> to match the pm_restore_gfp_mask() call in hibernate() that will
> occur subsequently.
> 
> Address this by adding a pm_restrict_gfp_mask() call to the relevant
> error path in power_down().
> 
> Fixes: 12ffc3b1513e ("PM: Restrict swap use to later in the suspend sequence")
> Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
>   kernel/power/hibernate.c |    2 ++
>   1 file changed, 2 insertions(+)
> 
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -733,6 +733,8 @@ static void power_down(void)
>   	case HIBERNATION_PLATFORM:
>   		error = hibernation_platform_enter();
>   		if (error == -EAGAIN || error == -EBUSY) {
> +			/* Match pm_restore_gfp_mask() in hibernate(). */
> +			pm_restrict_gfp_mask();
>   			swsusp_unmark();
>   			events_check_enabled = false;
>   			pr_info("Wakeup event detected during hibernation, rolling back.\n");
> 
> 
> 


