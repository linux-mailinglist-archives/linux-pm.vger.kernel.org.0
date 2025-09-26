Return-Path: <linux-pm+bounces-35470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA15BA40F9
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 16:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188931C01A02
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 14:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B902F6574;
	Fri, 26 Sep 2025 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5ZFMrV5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388D3225A35;
	Fri, 26 Sep 2025 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758895959; cv=none; b=ZyOphyBa6K+rxbcoMnV8CafHGcf7Gir+ux8stca4CuYMnq8NWBD+wUPMQMuLnq1fW41rgVi55kH+GLE3udrFCmquOjYsiULMTC63OaZeNgX+4nLmEmrzF/DSuPJIq2kSDacWVXmL+CcipvGjP3oKHz4R2kWCUdx2X1MAXQNuNzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758895959; c=relaxed/simple;
	bh=J3DpS5kZB6XptQTvvt2hoOfcWCkqxGjjmHDYrY3f++8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+EQmKMEh/kFabZSsBT9QuNFNALgQF8UZaD+MYnoj5/CPbqrLxO1oORXDIC7PnVLNUulAuTgS0QJ/Nalahvd2zO/ENaPrT6p5Y/qS541AEtJu9AX8ZMt5mgIAPDLCLnMN1IjsERou7eLxUEhZQ/Sgl/6yvzDq3CpbiP/HBtkWvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5ZFMrV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A58C4CEF4;
	Fri, 26 Sep 2025 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758895958;
	bh=J3DpS5kZB6XptQTvvt2hoOfcWCkqxGjjmHDYrY3f++8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d5ZFMrV5mmjd4kVyQWI9YEeUlgWKYv0i0vEaPUlgjX/pHOLTOeZMrwRJI5QaCan77
	 VDQY9kEW98Nl8yhmQYJHjfbUZSoSS1yNvfU96YPuyMqWDZg7kPnYm67YVFcglyG+jV
	 JbvlQYm53XmbcTOmYTZw68SILW9XH5gMkkhZtXp5/+SvaxYNUJGgSjNT35SFszF74c
	 Ra7j6lVLCPQDG8OiSflW0Vaq8zhPeVjbakhM1qL5kJkGFKaRqFgUzE9Co/eQLiLwiF
	 l0qBDxetCTA3CcaLbkMHerAZD0o06TuH+pk6zmqWAKQbMyc3UNI4jh/9RkgBno3RN8
	 gLttuh7y+ZHLQ==
Message-ID: <a1a6170e-2d91-4678-9147-6cb3fe534c93@kernel.org>
Date: Fri, 26 Sep 2025 09:12:37 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: hibernate: Fix pm_hibernation_mode_is_suspend()
 build breakage
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ionut Nechita
 <ionut_n2001@yahoo.com>, Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Crudup <kenny@panix.com>, amd-gfx@lists.freedesktop.org
References: <12746883.O9o76ZdvQC@rafael.j.wysocki>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <12746883.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/26/25 6:10 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 495c8d35035e ("PM: hibernate: Add pm_hibernation_mode_is_suspend()")
> that introduced pm_hibernation_mode_is_suspend() did not define it in
> the case when CONFIG_HIBERNATION is unset, but CONFIG_SUSPEND is set.
> 
> Subsequent commit 0a6e9e098fcc ("drm/amd: Fix hybrid sleep") made the
> amdgpu driver use that function which led to kernel build breakage in
> the case mentioned above [1].
> 
> Address this by using appropriate #ifdeffery aroung the definition of
> pm_hibernation_mode_is_suspend().
> 
> Fixes: 0a6e9e098fcc ("drm/amd: Fix hybrid sleep")
> Reported-by: KernelCI bot <bot@kernelci.org>
> Closes: https://groups.io/g/kernelci-results/topic/regression_pm_testing/115439919 [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
>   include/linux/suspend.h |    8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -276,7 +276,6 @@ extern void arch_suspend_enable_irqs(voi
>   
>   extern int pm_suspend(suspend_state_t state);
>   extern bool sync_on_suspend_enabled;
> -bool pm_hibernation_mode_is_suspend(void);
>   #else /* !CONFIG_SUSPEND */
>   #define suspend_valid_only_mem	NULL
>   
> @@ -289,7 +288,6 @@ static inline bool pm_suspend_via_firmwa
>   static inline bool pm_resume_via_firmware(void) { return false; }
>   static inline bool pm_suspend_no_platform(void) { return false; }
>   static inline bool pm_suspend_default_s2idle(void) { return false; }
> -static inline bool pm_hibernation_mode_is_suspend(void) { return false; }
>   
>   static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
>   static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
> @@ -420,6 +418,12 @@ static inline int hibernate_quiet_exec(i
>   }
>   #endif /* CONFIG_HIBERNATION */
>   
> +#if defined(CONFIG_HIBERNATION) && defined(CONFIG_SUSPEND)
> +bool pm_hibernation_mode_is_suspend(void);
> +#else
> +static inline bool pm_hibernation_mode_is_suspend(void) { return false; }
> +#endif
> +
>   int arch_resume_nosmt(void);
>   
>   #ifdef CONFIG_HIBERNATION_SNAPSHOT_DEV
> 
> 
> 


