Return-Path: <linux-pm+bounces-15030-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E50E98C57A
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 20:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1F4284DC1
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 18:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051BD1CC8A4;
	Tue,  1 Oct 2024 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDbF/q2U"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1651CB321;
	Tue,  1 Oct 2024 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807954; cv=none; b=FvgPilcF/NZ+YZl2fkSfuR9TStgmo0yUmLap8zKkN3wqReFm9WTciHyIvjG5SJBTgc9r+h36KCGSNxIBchVGjuA5IyHLeYs2VpnLV51PAxMclZoWwZQkolHLaFsD3od9RFNmiw80MeDIWQd+ALCnzX2CG9U2Rgn0LTs/ONcBcb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807954; c=relaxed/simple;
	bh=cu9/9B6GCuPwcG+elLW15FjmIJfNPLynLghRti9l2l4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLfsU65TYupWscto+oJYgQ2v67K2khoPSZozZCMb6PaUqXqlH2ZXPpuw+i74GqG4QAatKkQP/NNFDN9yoOpjjQ3CfQ564PRmf00a252YJwavJrMp7Hfz+J1xeS/owMAbLoxoRGFms/5ld1ulmwr7XnKFERFEr9pPQPdcMK041gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDbF/q2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9BDC4CED3;
	Tue,  1 Oct 2024 18:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727807954;
	bh=cu9/9B6GCuPwcG+elLW15FjmIJfNPLynLghRti9l2l4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KDbF/q2UVm4zk9Sq7OzCU+r1ZUrReH2/h5zKuK/yIiapgPWie5BQOevoj9YZzBZ7H
	 yMQhkdof7SFwiHQXOYdKOqRGZmfzyKaPy2hnGKfALyXoDljI/VIcBslxua4lqIYCk3
	 1aM2/sTX9Cqb4otSSRXFp+/ayOMgbkXO9OeKNdkKOimBv2ZQjehGQLWB4GLQjPERNs
	 /yLnJn+kv8Toy+cocGi48Nc9o69AhWfse2C0rTusTTXuxLiaTZRbBInsePfBMoS7To
	 jQjH0iQhIs3Pj6ttLVQRThQZlcV6gDFsTFNxXHli8gRRkdSKBboqsl8ddVW8ebiNZ/
	 7bJg6eSsB48DQ==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-710da8668b3so2042226a34.1;
        Tue, 01 Oct 2024 11:39:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxOjza1aZZ+N7HLROL7C4MO+GRFytkSH0RBTCYC613+XYDiYxK5OGDwjSsOxj+05VgimSo3NaxVQ==@vger.kernel.org, AJvYcCV2c91agJkwMYl717TKMgynslaj/cfpC7JK2ZmaYgHBdJzNA8cF3bIBVlW8P8G/RPONuEJHVeb2QMzIeNmQ25I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+qIpQLvc8VXXnxETRvNnMOwkNpbG5o31Dm8na/2xUMDNHm0ME
	c5fqjXUzj+Ml+98fNxBfZbwLba1yyxnMw0KtE4upfCqTtJiQdFNWeef/5/+7+7gyeF4oG6OaFec
	18mOIcVVohLUY7ASMq3ULsTu4Yb8=
X-Google-Smtp-Source: AGHT+IEfxPOIwVN64AKilWJEdP3JLxAHmaxhc1ZcWL7Mn+3DpOY2m/c7p31vIZbKHV15cugMVeMk+TsRmEhuQzV30WU=
X-Received: by 2002:a05:6830:65c4:b0:710:bd1f:6cbe with SMTP id
 46e09a7af769-7153cd4d01cmr758777a34.1.1727807953637; Tue, 01 Oct 2024
 11:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919081121.10784-2-ukleinek@debian.org>
In-Reply-To: <20240919081121.10784-2-ukleinek@debian.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 1 Oct 2024 20:39:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hz+w3eFYQpHqwe0Fv3axe8LBDEf+oMd01dEQMuN=Dy5g@mail.gmail.com>
Message-ID: <CAJZ5v0hz+w3eFYQpHqwe0Fv3axe8LBDEf+oMd01dEQMuN=Dy5g@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Make hwp_notify_lock a raw spinlock
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@debian.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-pm@vger.kernel.org, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-rt-users@vger.kernel.org, 
	xiao sheng wen <atzlinux@sina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 10:12=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@de=
bian.org> wrote:
>
> notify_hwp_interrupt() is called via sysvec_thermal() ->
> smp_thermal_vector() -> intel_thermal_interrupt() in hard irq context.
> For this reason it must not use a simple spin_lock that sleeps with
> PREEMPT_RT enabled. So convert it to a raw spinlock.
>
> Reported-by: xiao sheng wen <atzlinux@sina.com>
> Link: https://bugs.debian.org/1076483
> Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@debian.org>
> ---
> Hello,
>
> this is deep in x86 land where I have *very* little experience and
> knowledge. Is sysvec_thermal() (defined in arch/x86/kernel/irq.c) really
> running in hard irq context? The stacktrace in the Debian bug report
> suggests that.
>
> So please double check my reasoning before applying this patch.
>
> Thanks
> Uwe
>
>  drivers/cpufreq/intel_pstate.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index aaea9a39eced..b0018f371ea3 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1845,7 +1845,7 @@ static void intel_pstate_notify_work(struct work_st=
ruct *work)
>         wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
>  }
>
> -static DEFINE_SPINLOCK(hwp_notify_lock);
> +static DEFINE_RAW_SPINLOCK(hwp_notify_lock);
>  static cpumask_t hwp_intr_enable_mask;
>
>  #define HWP_GUARANTEED_PERF_CHANGE_STATUS      BIT(0)
> @@ -1868,7 +1868,7 @@ void notify_hwp_interrupt(void)
>         if (!(value & status_mask))
>                 return;
>
> -       spin_lock_irqsave(&hwp_notify_lock, flags);
> +       raw_spin_lock_irqsave(&hwp_notify_lock, flags);
>
>         if (!cpumask_test_cpu(this_cpu, &hwp_intr_enable_mask))
>                 goto ack_intr;
> @@ -1876,13 +1876,13 @@ void notify_hwp_interrupt(void)
>         schedule_delayed_work(&all_cpu_data[this_cpu]->hwp_notify_work,
>                               msecs_to_jiffies(10));
>
> -       spin_unlock_irqrestore(&hwp_notify_lock, flags);
> +       raw_spin_unlock_irqrestore(&hwp_notify_lock, flags);
>
>         return;
>
>  ack_intr:
>         wrmsrl_safe(MSR_HWP_STATUS, 0);
> -       spin_unlock_irqrestore(&hwp_notify_lock, flags);
> +       raw_spin_unlock_irqrestore(&hwp_notify_lock, flags);
>  }
>
>  static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
> @@ -1895,9 +1895,9 @@ static void intel_pstate_disable_hwp_interrupt(stru=
ct cpudata *cpudata)
>         /* wrmsrl_on_cpu has to be outside spinlock as this can result in=
 IPC */
>         wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
>
> -       spin_lock_irq(&hwp_notify_lock);
> +       raw_spin_lock_irq(&hwp_notify_lock);
>         cancel_work =3D cpumask_test_and_clear_cpu(cpudata->cpu, &hwp_int=
r_enable_mask);
> -       spin_unlock_irq(&hwp_notify_lock);
> +       raw_spin_unlock_irq(&hwp_notify_lock);
>
>         if (cancel_work)
>                 cancel_delayed_work_sync(&cpudata->hwp_notify_work);
> @@ -1912,10 +1912,10 @@ static void intel_pstate_enable_hwp_interrupt(str=
uct cpudata *cpudata)
>         if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY)) {
>                 u64 interrupt_mask =3D HWP_GUARANTEED_PERF_CHANGE_REQ;
>
> -               spin_lock_irq(&hwp_notify_lock);
> +               raw_spin_lock_irq(&hwp_notify_lock);
>                 INIT_DELAYED_WORK(&cpudata->hwp_notify_work, intel_pstate=
_notify_work);
>                 cpumask_set_cpu(cpudata->cpu, &hwp_intr_enable_mask);
> -               spin_unlock_irq(&hwp_notify_lock);
> +               raw_spin_unlock_irq(&hwp_notify_lock);
>
>                 if (cpu_feature_enabled(X86_FEATURE_HWP_HIGHEST_PERF_CHAN=
GE))
>                         interrupt_mask |=3D HWP_HIGHEST_PERF_CHANGE_REQ;
>
> base-commit: 3621a2c9142bd490af0666c0c02d52d60ce0d2a5
> --

Applied as 6.12-rc material, thanks!

