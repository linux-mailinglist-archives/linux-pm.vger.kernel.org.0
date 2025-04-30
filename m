Return-Path: <linux-pm+bounces-26464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F74AA4E90
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 16:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4083B6803
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 14:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC53625D900;
	Wed, 30 Apr 2025 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFbCy0Ah"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA961EB5B;
	Wed, 30 Apr 2025 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746023362; cv=none; b=feCOMQHLuVisv099bJIaIDyPoksfqTomHrcauy0alwdAnKB+aCyv9MpX7la55Nrj6a12dQj0mSzLHXEmc7r/Wuv2FET9KLyOC6bCXIrcImOaCreVdPlwpsLGXYxC/wxhLpLtDyNFILvS6bP7m5YKfzMCVdtt4rzHUg20F6uNpSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746023362; c=relaxed/simple;
	bh=9rrCfGTMptRk9siYkQ49YPhvfisXdGfLi815HqSA/RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1abOn7GuqEdwNHPhK319+ERNb/tVmacFaCt8OV/mNJl8YAo/vcJ5WOzw8iPaEERMo/lAg3CyPzZ3aDYRknRFmPUWj/hQ4pcHae5GSqFibfVs7MRc/DFZMP13FuR5r2jkQGrwcJAvWaq+qKR4WKPBGMHo0bvyvAWOUg1kX2yDc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFbCy0Ah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AB4C4CEEB;
	Wed, 30 Apr 2025 14:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746023362;
	bh=9rrCfGTMptRk9siYkQ49YPhvfisXdGfLi815HqSA/RQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gFbCy0AhX8eMpmq3FUVriVHhmbs9EhTyKq6i12kx/22Jmr2FIkROzz0MSy0WjEbK4
	 bU7St/1k4Rmjkv63qpP1+cNEgU61uDw/qVglUY6XUQqXwcD6HKVB7yq41hKJ8XX1uI
	 rMZj+pMnAJmaLhy+cI6acC8mGvZLF2wufqRakU/JWmuVvJJtUGG1JL5839yTlupQyG
	 APmQi+lVO0RjDQvFJxCIifbf3f6ayWUWDhr9Ivq84MT/spRhFOdWVJFsUMvEAP6Ido
	 bQM/dF7YUFk4i8PYZwSHbFsvN3Hm5GLHDwcI6zagcdqSIEtJ/QLBl7BNRXrXxxJAmN
	 GTq2ZoVCP3tqw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-601b6146b9cso3753047eaf.0;
        Wed, 30 Apr 2025 07:29:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQIgSmW1EaPkkc1E4lSCn1nJjvhpRCXbJ9wMLzNxm3xRw/lsbYyqMKG73zGTmyliiqtaRfYN13UM0=@vger.kernel.org, AJvYcCW3JSIPwynmQNUdfvSF9mj4U42NywoI73TMlqFY2w/LD7IWeqMxVFeeuQhGJf36WtCf4FJ8LLFj@vger.kernel.org, AJvYcCXO075KfW2Z7AdG1V9gjHKIER/sAs/6UOtQvUQei6s2IoP9dZTM3UpbXV4l4PcIy4Yi7AwVjchrrT0vr28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzszT7nZQKyxYBunMo54Ky/3/1K66rCFveSt4qDxYjk2R8WSrgE
	rgTREit5KJkUHXmbCll5QgChAgBmaWg+Gs/Iv9D+U/F+CGd8qZBUASAaHm6mW0PsD1VE804chu3
	QKEQIdEWfhoW6xrWaI+CS6uqUGYg=
X-Google-Smtp-Source: AGHT+IFcK34daQQEIl15Gs+jdXSIyzj30C1WfRyydPj9+NAUHh863VhppsqwGdR8X2E8N2tW4xZc38fecZy3txcqwyI=
X-Received: by 2002:a05:6870:331f:b0:2c2:5ac3:4344 with SMTP id
 586e51a60fabf-2da6cd48526mr1489206fac.15.1746023360851; Wed, 30 Apr 2025
 07:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429210711.255185-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250429210711.255185-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 Apr 2025 16:29:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h99RFF26qAnJf07LS0t-6ATm9c2zrQVzdi96x3FAPXQg@mail.gmail.com>
X-Gm-Features: ATxdqUF2YVbfjJN7SOr83t0V7L7vVsb1iRwnZLblfVRA5_mIXmRLp29LfMewLaE
Message-ID: <CAJZ5v0h99RFF26qAnJf07LS0t-6ATm9c2zrQVzdi96x3FAPXQg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Unchecked MSR aceess in legacy mode
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 11:07=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> When turbo mode is unavailable on a Skylake-X system, executing the
> command:
> "echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo"
> results in an unchecked MSR access error: WRMSR to 0x199
> (attempted to write 0x0000000100001300).
>
> This issue was reproduced on an OEM (Original Equipment Manufacturer)
> system and is not a common problem across all Skylake-X systems.
>
> This error occurs because the MSR 0x199 Turbo Engage Bit (bit 32) is set
> when turbo mode is disabled. The issue arises when intel_pstate fails to
> detect that turbo mode is disabled. Here intel_pstate relies on
> MSR_IA32_MISC_ENABLE bit 38 to determine the status of turbo mode.
> However, on this system, bit 38 is not set even when turbo mode is
> disabled.
>
> According to the Intel Software Developer's Manual (SDM), the BIOS sets
> this bit during platform initialization to enable or disable
> opportunistic processor performance operations. Logically, this bit
> should be set in such cases. However, the SDM also specifies that "OS and
> applications must use CPUID leaf 06H to detect processors with
> opportunistic processor performance operations enabled."
>
> Therefore, in addition to checking MSR_IA32_MISC_ENABLE bit 38, verify
> that CPUID.06H:EAX[1] is 0 to accurately determine if turbo mode is
> disabled.
>
> Fixes: 4521e1a0ce17 ("cpufreq: intel_pstate: Reflect current no_turbo sta=
te correctly")
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/cpufreq/intel_pstate.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index f41ed0b9e610..ba9bf06f1c77 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -598,6 +598,9 @@ static bool turbo_is_disabled(void)
>  {
>         u64 misc_en;
>
> +       if (!cpu_feature_enabled(X86_FEATURE_IDA))
> +               return true;
> +
>         rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
>
>         return !!(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
> --

Applied as a fix for 6.15-rc, thanks!

