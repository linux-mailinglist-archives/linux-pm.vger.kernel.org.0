Return-Path: <linux-pm+bounces-17328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCA39C401C
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 15:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437701C21A0C
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 14:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A2919CC21;
	Mon, 11 Nov 2024 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AArd3umb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3CB175D2D;
	Mon, 11 Nov 2024 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333633; cv=none; b=R4uYc5Yp4xFk1i1S4mzW5LUBePazWCVO7fzUHwKhiCaJnJfP6pj9DjLeTu2XeLGk1EIJ1QOp2cuELQ/oH4p+wbmxizQUbuAnPc/VpsR9+aq6mKPTlqAOCSACgpUmY8oPaxNYv22U86dGMSC8Ok5tT2pmW/aNfygLYQbNAmDbq4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333633; c=relaxed/simple;
	bh=havDAwwZnsaDJUHiZzpDxi6xtnUHdjDI3CWlxBEw9tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLwmU8Ev4cikfV5ClwlvFB5Q2W9j72CfOBfUm1/5TOz+V3TkTkQUUeUJZ8gmZq/BLEGRt2DqtkYEpdCIkqHn7KJSGvgrnga4vscawdJk4O0QzF4z1UASCJtHf+iG9sRK1jk+rnLawOvs6YsGVXr2ht0rNFQ1Hv8VYRduqv9fmFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AArd3umb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5D1C4CED7;
	Mon, 11 Nov 2024 14:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731333632;
	bh=havDAwwZnsaDJUHiZzpDxi6xtnUHdjDI3CWlxBEw9tc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AArd3umbyEhZ8aiIpMlm5BRsB/sXNSdH0C4PVkhqEJGdnpNghcon2GpNkzvDxkWda
	 MaVAjYW+ABdi49li0vj010hags9QBeYG4NyRDHifw9t8rvsxIF0WonBM4m1e12NXWo
	 t5/FIwA0E133uGK/ld4eMn9qM3RKz0kgaYQkbSvfXzwwrOgr+JwOQXebIdbBHWvR1U
	 TmTp2pP69cucUh8BiTDwhJqtFsN3sI5q8Fi7c0DTo2KxTng8iw2fFhBtBJt+8dnLcF
	 n2hV9IgT0tmqkUF/yejUwYJl8/57chVyBeX0QT0Mmx/SgTv3N0tWv730eafZggAnt9
	 KpFgrr4a2weVQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2951f3af3ceso2285868fac.1;
        Mon, 11 Nov 2024 06:00:32 -0800 (PST)
X-Gm-Message-State: AOJu0Yz274/k579AMZoso4pfa6fKjuWkkH7UJuASUVO1S5vJs1R+hfMM
	O6D1acQf8bSWqQm22c+sQCE4GScFvclm/Xv6f7xEqZYDkCTl/eV4pydMZhVUA1Cb0AM0pFOqYNn
	C/tpb9aPQNGCKxg2gGSYaq/yBX1w=
X-Google-Smtp-Source: AGHT+IFz22lySJ6ocLBAqfwkBTQKXZOe9dmkm0mAC3GP3+bZGBxlJvhcwPvCAYFao8GJNtLy7Pz8XYhrig9WB9tpW5I=
X-Received: by 2002:a05:6870:332a:b0:277:ca2f:905 with SMTP id
 586e51a60fabf-295602a659dmr10696305fac.29.1731333632018; Mon, 11 Nov 2024
 06:00:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12554508.O9o76ZdvQC@rjwysocki.net>
In-Reply-To: <12554508.O9o76ZdvQC@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Nov 2024 15:00:17 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h-6V7PSd4Zv6dhvBXLf97USJj2sO_qwJHwG+sJq3muXg@mail.gmail.com>
Message-ID: <CAJZ5v0h-6V7PSd4Zv6dhvBXLf97USJj2sO_qwJHwG+sJq3muXg@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Rearrange locking in hybrid_init_cpu_capacity_scaling()
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Nikula, Jani" <jani.nikula@intel.com>, 
	"Saarinen, Jani" <jani.saarinen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 1:36=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.net=
> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Notice that hybrid_init_cpu_capacity_scaling() only needs to hold
> hybrid_capacity_lock around __hybrid_init_cpu_capacity_scaling()
> calls, so introduce a "locked" wrapper around the latter and call
> it from the former.  This allows to drop a local variable and a
> label that are not needed any more.
>
> Also, rename __hybrid_init_cpu_capacity_scaling() to
> __hybrid_refresh_cpu_capacity_scaling() for consistency.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This turns out to be fixing a locking issue in commit 929ebc93ccaa
("cpufreq: intel_pstate: Set asymmetric CPU capacity on hybrid
systems") which is related to this report:

https://lore.kernel.org/linux-pm/SJ1PR11MB6129EDBF22F8A90FC3A3EDC8B9582@SJ1=
PR11MB6129.namprd11.prod.outlook.com/

so I'll need to update the changelog, but the patch itself need not be chan=
ged.

> ---
>
> This is on top of
>
> https://lore.kernel.org/linux-pm/12555220.O9o76ZdvQC@rjwysocki.net/
>
> ---
>  drivers/cpufreq/intel_pstate.c |   35 ++++++++++++++++------------------=
-
>  1 file changed, 16 insertions(+), 19 deletions(-)
>
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -1028,26 +1028,29 @@ static void hybrid_update_cpu_capacity_s
>         }
>  }
>
> -static void __hybrid_init_cpu_capacity_scaling(void)
> +static void __hybrid_refresh_cpu_capacity_scaling(void)
>  {
>         hybrid_max_perf_cpu =3D NULL;
>         hybrid_update_cpu_capacity_scaling();
>  }
>
> -static void hybrid_init_cpu_capacity_scaling(bool refresh)
> +static void hybrid_refresh_cpu_capacity_scaling(void)
>  {
> -       bool disable_itmt =3D false;
> +       guard(mutex)(&hybrid_capacity_lock);
>
> -       mutex_lock(&hybrid_capacity_lock);
> +       __hybrid_refresh_cpu_capacity_scaling();
> +}
>
> +static void hybrid_init_cpu_capacity_scaling(bool refresh)
> +{
>         /*
>          * If hybrid_max_perf_cpu is set at this point, the hybrid CPU ca=
pacity
>          * scaling has been enabled already and the driver is just changi=
ng the
>          * operation mode.
>          */
>         if (refresh) {
> -               __hybrid_init_cpu_capacity_scaling();
> -               goto unlock;
> +               hybrid_refresh_cpu_capacity_scaling();
> +               return;
>         }
>
>         /*
> @@ -1056,19 +1059,13 @@ static void hybrid_init_cpu_capacity_sca
>          * do not do that when SMT is in use.
>          */
>         if (hwp_is_hybrid && !sched_smt_active() && arch_enable_hybrid_ca=
pacity_scale()) {
> -               __hybrid_init_cpu_capacity_scaling();
> -               disable_itmt =3D true;
> -       }
> -
> -unlock:
> -       mutex_unlock(&hybrid_capacity_lock);
> -
> -       /*
> -        * Disabling ITMT causes sched domains to be rebuilt to disable a=
sym
> -        * packing and enable asym capacity.
> -        */
> -       if (disable_itmt)
> +               hybrid_refresh_cpu_capacity_scaling();
> +               /*
> +                * Disabling ITMT causes sched domains to be rebuilt to d=
isable asym
> +                * packing and enable asym capacity.
> +                */
>                 sched_clear_itmt_support();
> +       }
>  }
>
>  static bool hybrid_clear_max_perf_cpu(void)
> @@ -1404,7 +1401,7 @@ static void intel_pstate_update_limits_f
>         mutex_lock(&hybrid_capacity_lock);
>
>         if (hybrid_max_perf_cpu)
> -               __hybrid_init_cpu_capacity_scaling();
> +               __hybrid_refresh_cpu_capacity_scaling();
>
>         mutex_unlock(&hybrid_capacity_lock);
>  }
>
>
>
>

