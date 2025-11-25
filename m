Return-Path: <linux-pm+bounces-38636-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8EBC86088
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 17:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631663AD1FF
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 16:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805EF325735;
	Tue, 25 Nov 2025 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFwvcuAr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB8878F51
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089456; cv=none; b=OuiCvHKSa9biB+rStTeVoqchMoyyuqR5haiPO4Rua6cT6QijzuP38hCRY36eut9TLIaoqlKJoxYL3UzVpio1KPtP850tEtyl0J9NFUkYhi0+zaMLNp3CUTPbRPmvA9cozgRvmcZoAIeR2gLLWDmK9v/z+TawfvVAaYoJbzdlG9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089456; c=relaxed/simple;
	bh=FBzozBuNcrfNyveqo8J3mC9BcN3oSI7tmZXBREaKJyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+6PCwgx3pVRWYeggd1M8io/WTZdQufd1WGqT/n8ofgiBfhGH1WEWgqbSWY/sXLzspXS5y7IpvHc5Jnnn2soZcgG5s4Vs3Up32kzXTz/vSmoROz8xFsqJX8ovdTqiWIAyJxVMJii506oKBzfyMY3uiPbCMc20iH0wct3tTKATPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFwvcuAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73FEC4CEF1
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 16:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764089455;
	bh=FBzozBuNcrfNyveqo8J3mC9BcN3oSI7tmZXBREaKJyI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nFwvcuArlNMSn7srSPggnubAab2NbFufLiAcqLNQ3c5YnZU1ElBzYa62eL13S5C33
	 RpFn6VmQYGc8AKydy62D4xqIIiNv+FRilZvum5VveMfsvfeUskvWbQtgNwoj/h/I06
	 Q5dHGaP300ySPkQKh7LGxOfVY0XWrO8KmzEzK00LujRlyDn23RLQVJXUClu/J4m8Kk
	 2reeecDbYQYlvuR9DsZ8Z0/AoqnU5dPiStgd1SdXDKegEu2GImWDAh6gHECuOqL+6k
	 aXI2BrL0OZtjYYgqGnSkLrJwjYIBFWS5MlmKGsc0K+xu3+qo9khXZ0BMkB6lxTwBFH
	 zis+j8gFEzjXA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3e37ad3d95aso3623327fac.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 08:50:54 -0800 (PST)
X-Gm-Message-State: AOJu0YxoDltraIkp6S5/4XkqwJP4VwumbE/Z0W3CbPxMpXWhSRhth+Uw
	e5M1ZMmtgN3otYwhv1I06ldwSS2kSoJyK53wHaBonGbGOGqRRWTbpm9GJgV9WnOpYHNoh1f0cJ2
	oCdzx/ihhcWMeu9YQgtYv5lnHnRpsUQ0=
X-Google-Smtp-Source: AGHT+IFQpwUONtnvvEKmOan0g8oWPW3JKFcxoo7Koe4vUWP7YO0WrKWpp1LmKTHpgLNsmOH59XKvBdal8Ga11EMEM7A=
X-Received: by 2002:a05:6808:80c4:b0:450:d6fe:89a5 with SMTP id
 5614622812f47-4514e5f941cmr1582212b6e.10.1764089454193; Tue, 25 Nov 2025
 08:50:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003110319.515085-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20251003110319.515085-1-kaushlendra.kumar@intel.com>
From: Len Brown <lenb@kernel.org>
Date: Tue, 25 Nov 2025 11:50:43 -0500
X-Gmail-Original-Message-ID: <CAJvTdKn04OhNyG_wZU11RNaSi3wHhamwGpxy2Ox86DDkzh7LWQ@mail.gmail.com>
X-Gm-Features: AWmQ_blB3xWE6eFIus1hZYcLe5hKOlxgP1qPLwbEZK3LCYdLvjac-rQCqvKHhEg
Message-ID: <CAJvTdKn04OhNyG_wZU11RNaSi3wHhamwGpxy2Ox86DDkzh7LWQ@mail.gmail.com>
Subject: Re: [PATCH] tools/power x86_energy_perf_policy: Add Android MSR
 device support
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks!

(FYI, I also applied a simple patch on top to simplify this code.)

On Fri, Oct 3, 2025 at 7:05=E2=80=AFAM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Add support for Android MSR device paths which use /dev/msrN format
> instead of the standard Linux /dev/cpu/N/msr format. The tool now
> probes both path formats at startup and uses the appropriate one.
>
> This enables x86_energy_perf_policy to work on Android systems where
> MSR devices follow a different naming convention while maintaining
> full compatibility with standard Linux systems.
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  .../x86_energy_perf_policy.c                  | 54 ++++++++++++++++---
>  1 file changed, 46 insertions(+), 8 deletions(-)
>
> diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_polic=
y.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> index 884a4c746f32..5301efc741ce 100644
> --- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> +++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> @@ -95,6 +95,9 @@ unsigned int bdx_highest_ratio;
>  #define PATH_TO_CPU "/sys/devices/system/cpu/"
>  #define SYSFS_PATH_MAX 255
>
> +/* keep Default as a linux path */
> +static int use_android_msr_path;
> +
>  /*
>   * maintain compatibility with original implementation, but don't docume=
nt it:
>   */
> @@ -678,16 +681,41 @@ void err_on_hypervisor(void)
>                     "not supported on this virtual machine");
>  }
>
> +static void probe_msr_path_format(void)
> +{
> +       struct stat sb;
> +       char test_path[32];
> +
> +       /* Test standard Linux path */
> +       sprintf(test_path, "/dev/cpu/%d/msr", base_cpu);
> +       if (stat(test_path, &sb) =3D=3D 0) {
> +               use_android_msr_path =3D 0;
> +               return;
> +       }
> +
> +       /* Test Android-style path */
> +       sprintf(test_path, "/dev/msr%d", base_cpu);
> +       if (stat(test_path, &sb) =3D=3D 0) {
> +               use_android_msr_path =3D 1;
> +               return;
> +       }
> +
> +       /* If neither exists, keep the default Linux format */
> +       use_android_msr_path =3D 0;
> +}
> +
>  int get_msr(int cpu, int offset, unsigned long long *msr)
>  {
>         int retval;
>         char pathname[32];
>         int fd;
>
> -       sprintf(pathname, "/dev/cpu/%d/msr", cpu);
> +       sprintf(pathname, use_android_msr_path ? "/dev/msr%d" : "/dev/cpu=
/%d/msr", cpu);
>         fd =3D open(pathname, O_RDONLY);
>         if (fd < 0)
> -               err(-1, "%s open failed, try chown or chmod +r /dev/cpu/*=
/msr, or run as root", pathname);
> +               err(-1, "%s open failed, try chown or chmod +r %s, or run=
 as root",
> +                  pathname, use_android_msr_path ? "/dev/msr*" : "/dev/c=
pu/*/msr");
> +
>
>         retval =3D pread(fd, msr, sizeof(*msr), offset);
>         if (retval !=3D sizeof(*msr)) {
> @@ -708,10 +736,11 @@ int put_msr(int cpu, int offset, unsigned long long=
 new_msr)
>         int retval;
>         int fd;
>
> -       sprintf(pathname, "/dev/cpu/%d/msr", cpu);
> +       sprintf(pathname, use_android_msr_path ? "/dev/msr%d" : "/dev/cpu=
/%d/msr", cpu);
>         fd =3D open(pathname, O_RDWR);
>         if (fd < 0)
> -               err(-1, "%s open failed, try chown or chmod +r /dev/cpu/*=
/msr, or run as root", pathname);
> +               err(-1, "%s open failed, try chown or chmod +r %s, or run=
 as root",
> +                  pathname, use_android_msr_path ? "/dev/msr*" : "/dev/c=
pu/*/msr");
>
>         retval =3D pwrite(fd, &new_msr, sizeof(new_msr), offset);
>         if (retval !=3D sizeof(new_msr))
> @@ -1427,10 +1456,15 @@ void probe_dev_msr(void)
>         struct stat sb;
>         char pathname[32];
>
> -       sprintf(pathname, "/dev/cpu/%d/msr", base_cpu);
> -       if (stat(pathname, &sb))
> -               if (system("/sbin/modprobe msr > /dev/null 2>&1"))
> -                       err(-5, "no /dev/cpu/0/msr, Try \"# modprobe msr\=
" ");
> +       sprintf(pathname, use_android_msr_path ? "/dev/msr%d" : "/dev/cpu=
/%d/msr", base_cpu);
> +       if (stat(pathname, &sb)) {
> +               if (system("/sbin/modprobe msr > /dev/null 2>&1")) {
> +                       if (use_android_msr_path)
> +                               err(-5, "no /dev/msr0, Try \"# modprobe m=
sr\" ");
> +                       else
> +                               err(-5, "no /dev/cpu/0/msr, Try \"# modpr=
obe msr\" ");
> +               }
> +       }
>  }
>
>  static void get_cpuid_or_exit(unsigned int leaf,
> @@ -1547,6 +1581,10 @@ void parse_cpuid(void)
>  int main(int argc, char **argv)
>  {
>         set_base_cpu();
> +
> +       /* probe MSR path */
> +       probe_msr_path_format();
> +
>         probe_dev_msr();
>         init_data_structures();
>
> --
> 2.34.1
>


--=20
Len Brown, Intel Open Source Technology Center

