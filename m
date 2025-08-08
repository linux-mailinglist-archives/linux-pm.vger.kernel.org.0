Return-Path: <linux-pm+bounces-32076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC69AB1EF7B
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 22:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76AE4727BEB
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 20:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AE4232369;
	Fri,  8 Aug 2025 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N61DVLMH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA8A198A2F;
	Fri,  8 Aug 2025 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754684736; cv=none; b=KSbTnksxqzeAfkaU1+vKMhZ3Nui8fa2VCt+pbSdjR0lhWR7yIGf+rm0aRako/gr2hufR6lGumifeSZLLOqgBAWIu4HsGkcTTSnLXxQQ3MIRFOAbd5mALEBxToJLiE8bWt2eebYh39labzrM957s0dWGCCaZPuccrjWQVUkPZPL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754684736; c=relaxed/simple;
	bh=ATffkiA6HMFxBQfIY6pPRbq32ANAdgxQe5KaHy2Mspw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eH/6NSG/LBtuoeRXlaMZEVJ6wvjUZIDM6W2pxknqmU0mV2OUA3e9YPUBnER8rt4qI1Slc9sxaXlJcnfk6JF/xC0NVDUJcPgvx4grhLJ3/p9w3uMEoD3y7/p/7FPZXBlYU9qAjKOA8CymXEmBOoM1Pl56rVt6BF473rxBJfROIEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N61DVLMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21E9C4CEED;
	Fri,  8 Aug 2025 20:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754684735;
	bh=ATffkiA6HMFxBQfIY6pPRbq32ANAdgxQe5KaHy2Mspw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N61DVLMHfWjmakHmc8iRcJndtYBgIN6VDSKppA+pC4zpRMUlBQxCYHOEKduIvomz/
	 3y//Ox8vhUzcNrpp5+Z6I7iN2VvwKqwDqpzBh6vOBgAgvEGdSOTUS/bU/Tysq1OFhT
	 Ye1IwuICwm8wjKVnbehi5ZLLHHVZC4gjTzghf1b4eklCiUuPEyeUfx+GXv6EDSfCCx
	 vDOHHa+AIU2UhZdkVHDucuHwkmSH1h+XXoDQmX0/hHVzDGn0prNAHxj9xLv6Odvr+g
	 /rT5wwSI4CTlmfBnu3apF37jFwWichh/8RXlD5sO08jxrIbIK5XOCiwAFdTB9SakE/
	 nSb1VYsmylEDQ==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-61997c8e2a1so1470700eaf.1;
        Fri, 08 Aug 2025 13:25:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdHygDrz8ESJPX3SG1T2/AOfcUXNhxYqBl8Aw4HnbfMY64FNiIZHY89ju3UHtsA8XKt8g5QVbh9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yym1DEtypVdO1ZmgP1LlvOsTpTnEbC3dACIkjhbAkWQ7zBlEtru
	rZeHJhefK0h59sOV2sRGE43NpWmNn3ffZ7Pae+InICgz1QJUMMBjAkazs3XlqLe9gaaVYA1lxz+
	7mKku+MeO6gEVMJjn5ytSGLajxcwvlTw=
X-Google-Smtp-Source: AGHT+IGiCBiuITWWCgKG0nQb4v5R9B8ccswI5T6gc9ahd0DV++i4ghRZvpLw4GsUGaxx/h0riuPvsmrKqNJvHtCALxY=
X-Received: by 2002:a05:6820:328a:b0:619:9c99:b16a with SMTP id
 006d021491bc7-61b6ed83852mr4965856eaf.3.1754684735106; Fri, 08 Aug 2025
 13:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523052059.3360532-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20250523052059.3360532-1-kaushlendra.kumar@intel.com>
From: Len Brown <lenb@kernel.org>
Date: Fri, 8 Aug 2025 16:25:24 -0400
X-Gmail-Original-Message-ID: <CAJvTdKkVHsR6NcvAx+ZpF8C_euPpx2OnYtUHfmm_xbZU0YYXfQ@mail.gmail.com>
X-Gm-Features: Ac12FXxf1jIXfg4Vg_2XZgTeC1uzGL2d90gO4I0WgRNSLT7nDBK3GMqvYr1YmCQ
Message-ID: <CAJvTdKkVHsR6NcvAx+ZpF8C_euPpx2OnYtUHfmm_xbZU0YYXfQ@mail.gmail.com>
Subject: Re: [PATCH] tools/power x86_energy_perf_policy: Add Android support
 for MSR device path
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I regret applying the analogous turbostat patch, and I don't want to
apply this patch.

So Android moved /dev/cpu/0/msr to /dev/msr0 ...
Assuming that they had a really really good reason to break
compatibility (perhaps for the rest of us, you could share that
reason?)...

I would rather the tools probed the compatible/incompatible paths at
initialization time than littering the code with #ifdef ANDROID.

thanks,
-Len

On Fri, May 23, 2025 at 1:21=E2=80=AFAM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> This patch adds support for Android by updating the MSR device path
> handling in x86_energy_perf_policy. The code now uses /dev/msrN on
> Android systems instead of the default /dev/cpu/N/msr path. Error
> messages and modprobe instructions are also updated accordingly to
> improve clarity for Android users.
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  .../x86_energy_perf_policy.c                  | 28 +++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_polic=
y.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> index ebda9c366b2b..0c42cecca6a3 100644
> --- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> +++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> @@ -682,11 +682,19 @@ int get_msr(int cpu, int offset, unsigned long long=
 *msr)
>         int retval;
>         char pathname[32];
>         int fd;
> -
> +#if defined(ANDROID)
> +       sprintf(pathname, "/dev/msr%d", cpu);
> +#else
>         sprintf(pathname, "/dev/cpu/%d/msr", cpu);
> +#endif
>         fd =3D open(pathname, O_RDONLY);
>         if (fd < 0)
> +#if defined(ANDROID)
> +               err(-1, "%s open failed, try chown or chmod +r /dev/msr*,=
 or run as root",
> +                   pathname);
> +#else
>                 err(-1, "%s open failed, try chown or chmod +r /dev/cpu/*=
/msr, or run as root", pathname);
> +#endif
>
>         retval =3D pread(fd, msr, sizeof(*msr), offset);
>         if (retval !=3D sizeof(*msr)) {
> @@ -706,11 +714,19 @@ int put_msr(int cpu, int offset, unsigned long long=
 new_msr)
>         char pathname[32];
>         int retval;
>         int fd;
> -
> +#if defined(ANDROID)
> +       sprintf(pathname, "/dev/msr%d", cpu);
> +#else
>         sprintf(pathname, "/dev/cpu/%d/msr", cpu);
> +#endif
>         fd =3D open(pathname, O_RDWR);
>         if (fd < 0)
> +#if defined(ANDROID)
> +               err(-1, "%s open failed, try chown or chmod +r /dev//msr*=
, or run as root",
> +                   pathname);
> +#else
>                 err(-1, "%s open failed, try chown or chmod +r /dev/cpu/*=
/msr, or run as root", pathname);
> +#endif
>
>         retval =3D pwrite(fd, &new_msr, sizeof(new_msr), offset);
>         if (retval !=3D sizeof(new_msr))
> @@ -1385,10 +1401,18 @@ void probe_dev_msr(void)
>         struct stat sb;
>         char pathname[32];
>
> +#if defined(ANDROID)
> +       sprintf(pathname, "/dev/msr%d", base_cpu);
> +#else
>         sprintf(pathname, "/dev/cpu/%d/msr", base_cpu);
> +#endif
>         if (stat(pathname, &sb))
>                 if (system("/sbin/modprobe msr > /dev/null 2>&1"))
> +#if defined(ANDROID)
> +                       err(-5, "no /dev/msr0, Try \"# modprobe msr\" ");
> +#else
>                         err(-5, "no /dev/cpu/0/msr, Try \"# modprobe msr\=
" ");
> +#endif
>  }
>
>  static void get_cpuid_or_exit(unsigned int leaf,
> --
> 2.34.1
>


--=20
Len Brown, Intel Open Source Technology Center

