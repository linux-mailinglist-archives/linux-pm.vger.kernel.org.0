Return-Path: <linux-pm+bounces-21535-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CAEA2C31B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 13:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1369716AA7F
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 12:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191D61E0DE5;
	Fri,  7 Feb 2025 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZR/rV+0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E86944E;
	Fri,  7 Feb 2025 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738932961; cv=none; b=SwJ9e1ph2Jy8dwsFGaEs67tZoSTfiGUnrNCo8O4TNp5SZPB0ZrIvyvy3vF6IM/Z9d3/W+Rz8pMwsHIB6JRZmHNLrWCDi2VdrZF5duHj4PjMvhEhjLpUG7JmrSagl7ydFSDv+rCFqZo1Etd//wFIBP4Ug3IJog2JoTz8y9qMR51o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738932961; c=relaxed/simple;
	bh=2ZSzyPSgW8Nc958RFBf7+Jl5gwzWQyIwJddG+ZITof0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bopoOyGT/UjYYabxrBqg1BJuW6dkguUwu0RPpZ18cEtK7KBMdW7PcC27OtHOhpOdmLcRFMPl7SdGtfZRj22wRRXNoxJfWueXHCnSRqzs8vJcuKGJvREP2zl1PZbrMN/6aMKu03f32x6PKUFNXIJYkSZpCVzzyuKF/5JZ2+FiBvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZR/rV+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76B7C4CEE4;
	Fri,  7 Feb 2025 12:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738932960;
	bh=2ZSzyPSgW8Nc958RFBf7+Jl5gwzWQyIwJddG+ZITof0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lZR/rV+0VhtumFB64rWvIRmSkJYNvI75YnLrs5wh1Am4DhV70rkAtGM0b3kneW76V
	 87H7eVVRtUl1zSL8sqRuuglz32fuwLYqyzHw129htIo3oeevS1zJcsSnCskcKIyitV
	 LlIAqIpcqd8dOp0P1v6NSbOa+3g6e30v3ZwYFpEWVscv4Na0b0vuymusyJa4/p5QkR
	 ZU3IkMoWjXg0HDKMPLbKcLjUQpo9AqDM8XvuksRglQ9msaaeAIUEQd/Ezojj6+iP7F
	 Hnf0bBgNvW/y2V98h5Juc822q6dcI6jhVxZ/ljtIAvBYoOECpzSsHGRE/DYO9+yeJ6
	 mpaz/+V9ehXKQ==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f2e13cb359so610443eaf.3;
        Fri, 07 Feb 2025 04:56:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1IChN8XS+BDmAcuEpuSUY9tB1JTjS84ougcTXyHqk2JVsK1a4XoCZ0eRw++/DHtsubuF1xyng7biDxbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDLFQQ2/5/k17nVLzfqihcq6hozc2tjRzFiptrESkRZDxjuaDn
	dUipcDpIf4C/3NkBJYaiC55RW0pA0Uyt2EWyBP75JpZGRxbLQQKxKtfp97SxXjyEJZdhbb45zm4
	IlNeXhI3Ut26oqhicZaz/T2PgiVc=
X-Google-Smtp-Source: AGHT+IEyfVjxr2CaZz42veOqMmMnwZ7LuGcTfrWXmqUvCORGtrVP5OmTvh5k4R3LvXW9FE+RLZ1rwgna9R6NGUll6rc=
X-Received: by 2002:a05:6820:80c:b0:5f3:4175:1d7f with SMTP id
 006d021491bc7-5fc5e75e777mr1648130eaf.8.1738932959992; Fri, 07 Feb 2025
 04:55:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2781262.mvXUDI8C0e@rjwysocki.net>
In-Reply-To: <2781262.mvXUDI8C0e@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Feb 2025 13:55:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jytAtj_rDSz52OznCNV5Wo3hb0bjXCUR+ox99YdSxJ_Q@mail.gmail.com>
X-Gm-Features: AWEUYZmjaDNtsCO8S0PoOQU0JXAH_FPdWde4Xo4SlHl4_NqLpMRiOTA1XUUpKfo
Message-ID: <CAJZ5v0jytAtj_rDSz52OznCNV5Wo3hb0bjXCUR+ox99YdSxJ_Q@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Make it possible to avoid
 enabling CAS
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 3:07=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Capacity-aware scheduling (CAS) is enabled by default by intel_pstate on
> hybrid systems without SMT, but in some usage scenarios it may be more
> attractive to place tasks for maximum CPU performance regardless of the
> extra cost in terms of energy, which is the case on such systems when
> CAS is not enabled, so introduce a command line option to forbid
> intel_pstate to enable CAS.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Srinivas,

Any concerns or comments?

> ---
>  Documentation/admin-guide/kernel-parameters.txt |    3 +++
>  Documentation/admin-guide/pm/intel_pstate.rst   |    3 +++
>  drivers/cpufreq/intel_pstate.c                  |    9 +++++++++
>  3 files changed, 15 insertions(+)
>
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2295,6 +2295,9 @@
>                         per_cpu_perf_limits
>                           Allow per-logical-CPU P-State performance contr=
ol limits using
>                           cpufreq sysfs interface
> +                       no_cas
> +                         Do not enable capacity-aware scheduling (CAS) o=
n
> +                         hybrid systems
>
>         intremap=3D       [X86-64,Intel-IOMMU,EARLY]
>                         on      enable Interrupt Remapping (default)
> --- a/Documentation/admin-guide/pm/intel_pstate.rst
> +++ b/Documentation/admin-guide/pm/intel_pstate.rst
> @@ -696,6 +696,9 @@
>         Use per-logical-CPU P-State limits (see `Coordination of P-state
>         Limits`_ for details).
>
> +``no_cas``
> +       Do not enable capacity-aware scheduling (CAS) which is enabled by
> +       default on hybrid systems.
>
>  Diagnostics and Tuning
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -936,6 +936,8 @@
>         NULL,
>  };
>
> +static bool no_cas __ro_after_init;
> +
>  static struct cpudata *hybrid_max_perf_cpu __read_mostly;
>  /*
>   * Protects hybrid_max_perf_cpu, the capacity_perf fields in struct cpud=
ata,
> @@ -1041,6 +1043,10 @@
>
>  static void hybrid_init_cpu_capacity_scaling(bool refresh)
>  {
> +       /* Bail out if enabling capacity-aware scheduling is prohibited. =
*/
> +       if (no_cas)
> +               return;
> +
>         /*
>          * If hybrid_max_perf_cpu is set at this point, the hybrid CPU ca=
pacity
>          * scaling has been enabled already and the driver is just changi=
ng the
> @@ -3835,6 +3841,9 @@
>         if (!strcmp(str, "no_hwp"))
>                 no_hwp =3D 1;
>
> +       if (!strcmp(str, "no_cas"))
> +               no_cas =3D true;
> +
>         if (!strcmp(str, "force"))
>                 force_load =3D 1;
>         if (!strcmp(str, "hwp_only"))
>
>
>
>

