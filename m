Return-Path: <linux-pm+bounces-37862-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40244C53B6B
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 18:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB7A4A4237
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 17:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACA53469E3;
	Wed, 12 Nov 2025 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObtBZcaQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D036734677B
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968290; cv=none; b=GbkmiFUeoBGHAlIVyAlTs//FFYAVouvLlbJmDynOw2okuv6zUQ2Zk2AlVYqvEbTPnTnp4FgEpzNAW3J1jrhD44OdeGO9qguLMNRR4Gm7VQxxrHKzMXzsWwLNsdRz3PKu2279qop7lMJpqL+lDn4CS1iNVV1aGzp+vOYjtK/SCD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968290; c=relaxed/simple;
	bh=+ZWZxR7pSJKFOK/mgFwXb/5E+Q693R5Pm6iIBYg809g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uN6BbrIpBlbjng7E9I6h5brmQmzNGJZ4MJO9licdzaQMeKGTwQ/1Si3sLWqFFAC3tkuTrYxKCL5RFwfzrdc4a6jIO0479cZK7bnktyaSBKvtTRcGg4YYaZbCayxpuv3QHg4vcScvsau9TUym1/1OmuMiFJYmPkzKxpO4tdmKJcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObtBZcaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9DEC4CEF1
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 17:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762968290;
	bh=+ZWZxR7pSJKFOK/mgFwXb/5E+Q693R5Pm6iIBYg809g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ObtBZcaQI+tOy3KxsiVC45n3SBnrBdSpPrkbQRmGJWVkzsr2qMyRteKmNgsJQxgBM
	 ycKXjw9qys6aGBm2jz7b8G4tVJ+3LRbR2AOIKkKPQfsipZ57wuIYZN3weLgkpinayw
	 G2WbX815TAHmxOreQ1SxV+YrHQyzESI/tIqSupl3XMX3Vml4Z6k5b3XQ4QNsQFescu
	 iYCFf1C+rczu2Y7UPPGAoIfCx1Mi20E4RypoaDmlEIbe5D99k4FdEyzr4siyKlUDNh
	 EMO5ay5+a7BwS8qG4D03Vp6awt3tvnXzq2IM0zGj1F6T5A7srIZXICNwAH86vkiRsS
	 LNsPqnkWnv0nw==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-45045024527so309542b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 09:24:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX9GvR4cfv/UgDk/2/NSk7ZYKBBaqZdNQPZbA2r+XusLlxhyqPj6OBV1b6k7nDnlCj66V6vUGUapw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxunfMDAlSmmC2Ji6OQ+oMq2slzh+r3xlnvi0ZmaCnuD38gwj9u
	3myG5n0/PkQUVmtbB0H9IyThKWqY3/AfjK0faD43P2og+Fs5AFoU+QsGFFIh9nF5jRZF5LRMhaY
	JruBeqJtuuQzEp8S2d1A1pmmBFnRPZEw=
X-Google-Smtp-Source: AGHT+IHQN/cNRXxiYI84ASfst1WTHuD16wrvpTvnZlzd80o34bvnw/iSEdavityt+MzhevgnvSQplGiSWq5XAXyySQQ=
X-Received: by 2002:a05:6808:318f:b0:450:7378:60ee with SMTP id
 5614622812f47-450866f98e9mr87648b6e.23.1762968289746; Wed, 12 Nov 2025
 09:24:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111010840.141490-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20251111010840.141490-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Nov 2025 18:24:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g4FWk3w3Kby5p0ZgMfoTjt0XA=6g=x1UKQhaAUGashMg@mail.gmail.com>
X-Gm-Features: AWmQ_bmIzl5sBAZ12EKfROrLITBm3cKId7qL8xt6qx8B5JOgXx-oy5dPR6y-7qg
Message-ID: <CAJZ5v0g4FWk3w3Kby5p0ZgMfoTjt0XA=6g=x1UKQhaAUGashMg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Check IDA feature only during MSR
 0x199 write
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	trenn@suse.de, Aaron Rainbolt <arainbolt@kfocus.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 2:09=E2=80=AFAM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Commit ac4e04d9e378 ("cpufreq: intel_pstate: Unchecked MSR aceess in
> legacy mode") introduced a check for feature X86_FEATURE_IDA to verify
> turbo mode support. Although this is the correct way to check for turbo
> mode, it causes issues on some platforms that disable turbo during OS
> boot but enable it later. Without this feature check, users were able to
> write 0 to /sys/devices/system/cpu/intel_pstate/no_turbo post-boot to
> get turbo mode frequencies.
>
> To restore the old behavior while still addressing the unchecked MSR
> issue on some Skylake-X systems, limit the X86_FEATURE_IDA check to only
> when setting MSR 0x199 Turbo Engage Bit (bit 32).
>
> Fixes: ac4e04d9e378 ("cpufreq: intel_pstate: Unchecked MSR aceess in lega=
cy mode")
> Reported-by: Aaron Rainbolt <arainbolt@kfocus.org>
> Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2122531
> Tested-by: Aaron Rainbolt <arainbolt@kfocus.org>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 38897bb14a2c..492a10f1bdbf 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -603,9 +603,6 @@ static bool turbo_is_disabled(void)
>  {
>         u64 misc_en;
>
> -       if (!cpu_feature_enabled(X86_FEATURE_IDA))
> -               return true;
> -
>         rdmsrq(MSR_IA32_MISC_ENABLE, misc_en);
>
>         return !!(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
> @@ -2106,7 +2103,8 @@ static u64 atom_get_val(struct cpudata *cpudata, in=
t pstate)
>         u32 vid;
>
>         val =3D (u64)pstate << 8;
> -       if (READ_ONCE(global.no_turbo) && !READ_ONCE(global.turbo_disable=
d))
> +       if (READ_ONCE(global.no_turbo) && !READ_ONCE(global.turbo_disable=
d) &&
> +           cpu_feature_enabled(X86_FEATURE_IDA))
>                 val |=3D (u64)1 << 32;
>
>         vid_fp =3D cpudata->vid.min + mul_fp(
> @@ -2271,7 +2269,8 @@ static u64 core_get_val(struct cpudata *cpudata, in=
t pstate)
>         u64 val;
>
>         val =3D (u64)pstate << 8;
> -       if (READ_ONCE(global.no_turbo) && !READ_ONCE(global.turbo_disable=
d))
> +       if (READ_ONCE(global.no_turbo) && !READ_ONCE(global.turbo_disable=
d) &&
> +           cpu_feature_enabled(X86_FEATURE_IDA))
>                 val |=3D (u64)1 << 32;
>
>         return val;
> --

Applied as 6.18-rc material, with some adjustments in the subject and chang=
elog.

Thanks!

