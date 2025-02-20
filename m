Return-Path: <linux-pm+bounces-22574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFB9A3E50E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 20:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35FB919C1946
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 19:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1022641CA;
	Thu, 20 Feb 2025 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0Qmm8Fi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8263721480E;
	Thu, 20 Feb 2025 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079827; cv=none; b=FbNwPF+525/U92H/grmt1cq8d9+tiB4/PKOHAKm/LhNYeXAY7151++DbSsxDFqbqh8dNUILV3NFek/UuzkMzOVU8xTPgf9bEvXHDRG0ImlqCgc2qBx22z4UqCMB1ZhFgbGQsOD0VO7o4wyd/1FQ8Y4jxZFaLLGzIHFAnijLblbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079827; c=relaxed/simple;
	bh=JYsUnxNvX0J/idutygDTGbMdirhnhhDBwHyk/2PV7Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8XNgcQG3eBkvLZ0VowJgYW9svOpbypxhnsC+Zc0nlEDXzUA9m3bwHKeG0LmAFP2+aYLB8Wl8tTZFSFwSLa9biPCFLf8YINNTziqyjX51PfnrF0viDWO5DHjlSAgDPK0Tf3eZ5R843Jr22pNNuUluDr0QhYAPDSD17YxL/vVi74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0Qmm8Fi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFEFC4CED1;
	Thu, 20 Feb 2025 19:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740079827;
	bh=JYsUnxNvX0J/idutygDTGbMdirhnhhDBwHyk/2PV7Tk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d0Qmm8Fi5jiSWBGYwytSxkDVtD917CXxUEojk1uICF+jOroAO+WnzinyU0l68E8qO
	 TB+C2oskVjM5dxkS1C3fnJUETY4Grnm7TEyVF9pZlc94McmawB+QJpIjPmFewwXT1w
	 RMPPurcHvLxxN/hitP9idtzxMtflAKgiPGfCicO5zfDa21T1LL0Kbn5huSnv5fa84p
	 YX0udxMoxLumdi77BUwEoTdpjjsix6OZUNW3L+MUrvan2ersahixol5x0VbwoGJlEA
	 4mvd+zAMyOXzoA3wFdINtjIqHF5VQ0h83rwDhYfOO1i6BhdHEkYN7cDKxPsiaPCDCF
	 dhTT61/kbzP3A==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72720572addso855339a34.3;
        Thu, 20 Feb 2025 11:30:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFN+oO2A7w+eaJM3vMKJd25UC4Az3kkK70RlWUHyF0xxnVImzunJ3+rmIQi1uxANk7X83Jfa06+ghZVXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhhQXcr5GFgVxGtReRjdvauGuP6M3hwWMOQtA6+t7iuws1V1J+
	HDx90ip+EpykbB5UccXwG86twjBD7SSkR5a3h8038RbS6EQVA9jevi6XlanFlLNgHWYkClRCblz
	RLftFZS3xguizjUDJ4dN2NgEOoTk=
X-Google-Smtp-Source: AGHT+IEHPirn8tICjP+bAchnhcqCiKD8mNewopnyyiVdDe4tdAH+w/JiH5sNyROKj33YZXAMT9eIFe86H6kCIvx1cdc=
X-Received: by 2002:a05:6808:200c:b0:3f3:f89d:356d with SMTP id
 5614622812f47-3f4246b93e9mr491536b6e.15.1740079826315; Thu, 20 Feb 2025
 11:30:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2776745.mvXUDI8C0e@rjwysocki.net>
In-Reply-To: <2776745.mvXUDI8C0e@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Feb 2025 20:30:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jF_oLkzqEJuc9NX_j1+javyU8HF0JU8FiFgNaCks+RdA@mail.gmail.com>
X-Gm-Features: AWEUYZl1xrv75cqQu9PrlQBhTHO6VXJAWN08ezgaoviHC_0bWUwhgCWsGVsJmS4
Message-ID: <CAJZ5v0jF_oLkzqEJuc9NX_j1+javyU8HF0JU8FiFgNaCks+RdA@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Relocate platform preference check
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 1:48=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.net=
> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Move the invocation of intel_pstate_platform_pwr_mgmt_exists() before
> checking whether or not HWP is enabled because it does not depend on
> any code running before it except for the vendor check and if CPU
> performance scaling is going to be carried out by the platform, all of
> the code that runs before that function (again, except for the vendor
> check) is redundant.
>
> This is not expected to alter any functionality except for the ordering
> of messages printed by intel_pstate_init() when it is going to return an
> error before attempting to register the driver.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Srinivas, I'm wondering if you have any concerns regarding this one?

> ---
>  drivers/cpufreq/intel_pstate.c |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3688,6 +3688,15 @@
>         if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_INTEL)
>                 return -ENODEV;
>
> +       /*
> +        * The Intel pstate driver will be ignored if the platform
> +        * firmware has its own power management modes.
> +        */
> +       if (intel_pstate_platform_pwr_mgmt_exists()) {
> +               pr_info("P-states controlled by the platform\n");
> +               return -ENODEV;
> +       }
> +
>         id =3D x86_match_cpu(hwp_support_ids);
>         if (id) {
>                 hwp_forced =3D intel_pstate_hwp_is_enabled();
> @@ -3743,15 +3752,6 @@
>                 default_driver =3D &intel_cpufreq;
>
>  hwp_cpu_matched:
> -       /*
> -        * The Intel pstate driver will be ignored if the platform
> -        * firmware has its own power management modes.
> -        */
> -       if (intel_pstate_platform_pwr_mgmt_exists()) {
> -               pr_info("P-states controlled by the platform\n");
> -               return -ENODEV;
> -       }
> -
>         if (!hwp_active && hwp_only)
>                 return -ENOTSUPP;
>
>
>
>
>

