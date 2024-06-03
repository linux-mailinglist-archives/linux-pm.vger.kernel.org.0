Return-Path: <linux-pm+bounces-8530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 259778D86DD
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 18:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D512228169E
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B82212E1DD;
	Mon,  3 Jun 2024 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYLQOazg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EA227269;
	Mon,  3 Jun 2024 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430615; cv=none; b=M7o4bvwFA1/NiCjQ7C3d64U2bFJ2xzg6o229tUCuUoG3o4FqfiR6ce7vkJ/xOfH/oNofMJIld/rmSMcmgD3EbwPD9ETXFsQeYHnMdNYqnyyPYSc84UebKOX+A1NgNaHfpoh79rLtjwmk1PYP6+CvhhFSOQpBjw7OyXkVfcKlsJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430615; c=relaxed/simple;
	bh=lQyrMYvJvqu0yiAIygYCncuMTdVtDI0csy12c7vRrNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3WuwwV2dDWu887GNCqZ1+YgjtOQgHCXxytV2Q0nfB2eqsDOa4oFtfSvFcUft5s3JsYfeTPDPLsNqHfOogkPYb2uoznWA93jC6p6uoRRFTx20j8wrt8cTJ9pZOFURaF885GwClH/yP8cJAQYcHBrUmxMflsQUlb5SAU1nDmHs2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYLQOazg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C59C2BD10;
	Mon,  3 Jun 2024 16:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717430614;
	bh=lQyrMYvJvqu0yiAIygYCncuMTdVtDI0csy12c7vRrNY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LYLQOazgr83Ax/HeYjYQeHuUmq9TpTFR8kYj1j4SF+nLWxwQei9ozYv/XORqEgDtd
	 mFpHJP4dhslUserCc1H7qfeCHK+rNtxbPOqRHb+DZqIpfDTSpudBIlx9L7k+I54au4
	 5m4S8qxppRkxqV3xmrGYZWuGzousHrPZYC6YwRWmwnYgYFtITta7eeS4+f0Z2Z8egZ
	 XjFdC9vFk+xU+TdKElxEBH06Bs8qBv8uu27YUFUTSTg1cvoC2W3xrgXtuiBwWxHkdY
	 OOeiFD3afhyEdNruWjeET7rq/zc+95nj7nGIVUSpXHOA1P2GxPozSgbqoCZaFUazUw
	 fzRmbouyit32Q==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-250ff991197so607fac.1;
        Mon, 03 Jun 2024 09:03:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4W9xuKSUESG6rnUl0UpW0MOi3fjOHXNF8R5MOpTVHkouu9zdkEDo/DQdjeYMgjR+UylYsb00YKjJ3gl0qzCG0OUyqdOucIDLTASaB9gHMUh08aZKPe2MXQ8QpFXvwsmuYC3+mViM=
X-Gm-Message-State: AOJu0YxPUjB0/FOVqV+IN9PLMBWZJiCOSy2AnWQLp77qB0LYpyeN+XOH
	g0A63wLoqbvNJGM8594KEawE5LOJNWOSCyIS5fOyQIlAl70u3w0TWqAChI4um+Z0EL0mWjxxD4r
	qOfK3gb4N4Zsk22OYrdg/dsR09y8=
X-Google-Smtp-Source: AGHT+IH6xTtiUzAoXuAMcElDEuD0tu2xexyX3hiXD8AuHHpNfgsLDZkFUen78pLg2sKuzFJMNc2DH7vXEXVMAGKygoo=
X-Received: by 2002:a05:6870:d892:b0:24f:ddd5:a21d with SMTP id
 586e51a60fabf-2508be4806dmr9882822fac.5.1717430614083; Mon, 03 Jun 2024
 09:03:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531230004.1334127-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20240531230004.1334127-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Jun 2024 18:03:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j7ERKQr7RSu7q7v_rz9EKjjD+vs26a88jqvWm4tNL=uQ@mail.gmail.com>
Message-ID: <CAJZ5v0j7ERKQr7RSu7q7v_rz9EKjjD+vs26a88jqvWm4tNL=uQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix unchecked HWP MSR access
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 1:00=E2=80=AFAM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Fix unchecked MSR access error for processors with no HWP support. On
> such processors, maximum frequency can be changed by the system firmware
> using ACPI event ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED. This results
> in accessing HWP MSR 0x771.
>
> Call Trace:
>         <TASK>
>         generic_exec_single+0x58/0x120
>         smp_call_function_single+0xbf/0x110
>         rdmsrl_on_cpu+0x46/0x60
>         intel_pstate_get_hwp_cap+0x1b/0x70
>         intel_pstate_update_limits+0x2a/0x60
>         acpi_processor_notify+0xb7/0x140
>         acpi_ev_notify_dispatch+0x3b/0x60
>
> HWP MSR 0x771 can be only read on a CPU which supports HWP and enabled.
> Hence intel_pstate_get_hwp_cap() can only be called when hwp_active is
> true.
>
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Closes: https://lore.kernel.org/linux-pm/20240529155740.Hq2Hw7be@linutron=
ix.de/
> Fixes: e8217b4bece3 ("cpufreq: intel_pstate: Update the maximum CPU frequ=
ency consistently")
> Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 4b986c044741..65d3f79104bd 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1153,7 +1153,8 @@ static void intel_pstate_update_policies(void)
>  static void __intel_pstate_update_max_freq(struct cpudata *cpudata,
>                                            struct cpufreq_policy *policy)
>  {
> -       intel_pstate_get_hwp_cap(cpudata);
> +       if (hwp_active)
> +               intel_pstate_get_hwp_cap(cpudata);
>
>         policy->cpuinfo.max_freq =3D READ_ONCE(global.no_turbo) ?
>                         cpudata->pstate.max_freq : cpudata->pstate.turbo_=
freq;
> --

Applied as 6.10-rc material, thanks!

