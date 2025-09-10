Return-Path: <linux-pm+bounces-34408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B71B5203B
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 20:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A635638D5
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 18:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9E1273D84;
	Wed, 10 Sep 2025 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jpj7MTdv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5690D329F38;
	Wed, 10 Sep 2025 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757528790; cv=none; b=n6x4ZvyW0ahC9HRgKPFHPmDhE+he5vTdavOzI/M60D0+y5h8O7WL9iLRXBbaUD8lH2LvBEddwwLgi/Qqqg6yuAFrig0pUwBI9u88FMiFwYCL0tAQOw7Hovmo2z72H2OSip3LQ/0nmI9tKpiW4my7H0Tpt7fciVX9gr9i3GyCpic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757528790; c=relaxed/simple;
	bh=8zSU8u1AH6DF6zdffsNtTjsbQliu7LsDi1PKEDclH5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaPlQm4rAAq1WlS85GDYiLjBnSP0udcSWQ72sI53inxOXMtqAhgyWYuD4ld9KNK31Sk+vc85Q6Dk1pS48KJSBS9CF9PR3h0UyktMCI4mM/bUiEPTT1ThoWZuYqvf/Cfh/1SHrWbNjxJqPkAF0/jf5WOATCf+ju0jdiFoGGmEdbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jpj7MTdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57980C4CEEB;
	Wed, 10 Sep 2025 18:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757528789;
	bh=8zSU8u1AH6DF6zdffsNtTjsbQliu7LsDi1PKEDclH5Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jpj7MTdv5Oqaqig2NCNo6RAZMwqMtLhmQ+QuMjuqF7xqsBOgETgqt26lx/tyuek4M
	 ILPvuZ3MWkEPlWzh9za/Y5cYoXd4IOEcyzrwh/+4vm2rYEER+V1+2MgAfDTjY/MYN3
	 6c1guk/Y9s9a+Rn8LVBFfuIKCox22YpJDmVwHmn314y7V6OBADRXaV3SXSgfeZbMVM
	 a1SJ7DPYOm/K1wWodHIsjsUCjrLK3monpII7Hf3umITvfJeAsZi+P8dgYLW6n+nJ+4
	 SyzZRUteNz4V5Ggao0RokAtKdbEozIdAnInE72bUyUjFE8lV1/K2FM99td/F/ap1yv
	 TXJfcpa8Bf0Og==
Message-ID: <24abb0c2-553c-49a5-8daf-60d3726557df@kernel.org>
Date: Wed, 10 Sep 2025 13:26:28 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: hibernate: Restrict GFP mask in
 hibernation_snapshot()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Todd Brandt <todd.e.brandt@linux.intel.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Samuel Zhang <guoqing.zhang@amd.com>
References: <5924662.DvuYhMxLoT@rafael.j.wysocki>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <5924662.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/25 4:41 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 12ffc3b1513e ("PM: Restrict swap use to later in the suspend
> sequence") incorrectly removed a pm_restrict_gfp_mask() call from
> hibernation_snapshot(), so memory allocations involving swap are not
> prevented from being carried out in this code path any more which may
> lead to serious breakage.
> 
> The symptoms of such breakage have become visible after adding a
> shrink_shmem_memory() call to hibernation_snapshot() in commit
> 2640e819474f ("PM: hibernate: shrink shmem pages after dev_pm_ops.prepare()")
> which caused this problem to be much more likely to manifest itself.
> 
> However, since commit 2640e819474f was initially present in the DRM
> tree that did not include commit 12ffc3b1513e, the symptoms of this
> issue were not visible until merge commit 260f6f4fda93 ("Merge tag
> 'drm-next-2025-07-30' of https://gitlab.freedesktop.org/drm/kernel")
> that exposed it through an entirely reasonable merge conflict
> resolution.
> 
> Fixes: 12ffc3b1513e ("PM: Restrict swap use to later in the suspend sequence")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220555
> Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> Tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is super-urgent, so I'm going to fast-track it.

Thanks.  Looking at the codepaths again it makes sense.
It's a bit surprising to me this showed up, we had done stress testing 
before submitting.  Nonetheless, thank you for the fix.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> 
> ---
>   kernel/power/hibernate.c |    1 +
>   1 file changed, 1 insertion(+)
> 
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -449,6 +449,7 @@ int hibernation_snapshot(int platform_mo
>   	shrink_shmem_memory();
>   
>   	console_suspend_all();
> +	pm_restrict_gfp_mask();
>   
>   	error = dpm_suspend(PMSG_FREEZE);
>   
> 
> 
> 


