Return-Path: <linux-pm+bounces-22201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E0FA3824B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 12:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F4D16928E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 11:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1A5219A99;
	Mon, 17 Feb 2025 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ga3BjvGm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE558C2EF;
	Mon, 17 Feb 2025 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793179; cv=none; b=qcU8qmf0hsCxs/7t171mATPDjWunUZiCRn2fbErbGeq4bceXPtW8WV00slXLMLyM+SdhC8tkSTxaK1aPpd+ao39D1TwjGFbUv7Yz+YkZns/roWrG5JKiNCjTPs+KXV1iNGJHIo1etqfNwFvffOp5cSd8yr0JueniANUDrq/UxsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793179; c=relaxed/simple;
	bh=fALyPesKDexFLqrL682vo6Gg3diI4uJ8t5o+EuWB7lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKODtkyrd9OLIxsnOjQnyv8xazuNk6lJ0IiGBlBcOVwxglRVC7VOPPTYeNTNuCBWgZFTnjmd+3A1uyElrUJrN6nJFgxVPsD+9VYL3n0tbiOaR9CRz0mnhjaQttJTxDtBHt3kz89JR/rqdqQPilBPFUCVJBLxMPvj80JUAOVTiNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ga3BjvGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390C0C4CEED;
	Mon, 17 Feb 2025 11:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739793179;
	bh=fALyPesKDexFLqrL682vo6Gg3diI4uJ8t5o+EuWB7lg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ga3BjvGmBpNta6i7xzE9CH2etGrzAJ0PbyRInlzWCm+mzOjBoi1eAPelwFhzDdD6v
	 EIRz1Bs+AM6q+ofQubnxQn7CZZaH4Ad1ld8U/zyoG+pZGi1HZqnseKugrDVqTmNh5T
	 DlySaHrNWqvJ1WmgsRFLpU4Qyov4ubv8MtGtvOu4dbp8DuLvHzBnuiAPIU475WW2SS
	 ih06UxrcB9CaCfbyIngebdDu/jcvqVd95ffetDzlewTdK1zilbdISHyDECB7K/8vLo
	 OsGTMs67/QHl5NKF+WR6STOkiwPqkIhyxtsW4zmYvi2hF5qMO5YFAjrleuKXIJg2F9
	 GJSUL5KcogFsQ==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-726fec215d7so2693533a34.2;
        Mon, 17 Feb 2025 03:52:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjIcHI7K/v51E/oC1qto2xdiIn7G0uLTbmM+xsI8aZP+tyQVEZI44sDZufd8V4PLhZBT6SMI5Q19w=@vger.kernel.org, AJvYcCVKx2/ksGrc02bvVzxq9Hx+oiijwI19ID5BwONudJV5IYWqsUUKzxB1GUMbEb/5myg9CJWCAWkRkhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsWNMu9VyrE1jO/Iq97c/oTd/s/B1z3cnMEywHANW6VRm5INnO
	GNYsLr4F1EfkMhbiQJGDnLswWri0DjdaW8dcepYjMN9hEWtQO9abyvufbZCTwJyovH1WdnxvJPv
	7vwMNx4V/2v0g3p2haUATLaglZxQ=
X-Google-Smtp-Source: AGHT+IFVVYYbfWFp50Vgm/8/jOG1dKsdvDum4jRfwfMYeu7eMmrCifCE4J9b/zE1tfHWUNE1oMSm7u8tEJSuPg+CO3k=
X-Received: by 2002:a05:6808:2e99:b0:3f3:c301:c9e3 with SMTP id
 5614622812f47-3f3eb0dfdcfmr5815289b6e.12.1739793178328; Mon, 17 Feb 2025
 03:52:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131162439.3843071-1-beata.michalska@arm.com> <20250131162439.3843071-3-beata.michalska@arm.com>
In-Reply-To: <20250131162439.3843071-3-beata.michalska@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 17 Feb 2025 12:52:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g+yax=pT4m_2MTd9kUwbk5VBp2wkctTYJpFRU3myEjPQ@mail.gmail.com>
X-Gm-Features: AWEUYZnn9bgmOxkTXEcn87pSetveYQRe_SyW5ltWCODIphxbCVMgI8FLshf-Yx0
Message-ID: <CAJZ5v0g+yax=pT4m_2MTd9kUwbk5VBp2wkctTYJpFRU3myEjPQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com, sudeep.holla@arm.com, 
	will@kernel.org, catalin.marinas@arm.com, rafael@kernel.org, 
	viresh.kumar@linaro.org, sumitg@nvidia.com, yang@os.amperecomputing.com, 
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com, 
	zhanjie9@hisilicon.com, ptsm@linux.microsoft.com, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Phil Auld <pauld@redhat.com>, x86@kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 5:25=E2=80=AFPM Beata Michalska <beata.michalska@ar=
m.com> wrote:
>
> Currently the CPUFreq core exposes two sysfs attributes that can be used
> to query current frequency of a given CPU(s): namely cpuinfo_cur_freq
> and scaling_cur_freq. Both provide slightly different view on the
> subject and they do come with their own drawbacks.
>
> cpuinfo_cur_freq provides higher precision though at a cost of being
> rather expensive. Moreover, the information retrieved via this attribute
> is somewhat short lived as frequency can change at any point of time
> making it difficult to reason from.
>
> scaling_cur_freq, on the other hand, tends to be less accurate but then
> the actual level of precision (and source of information) varies between
> architectures making it a bit ambiguous.
>
> The new attribute, cpuinfo_avg_freq, is intended to provide more stable,
> distinct interface, exposing an average frequency of a given CPU(s), as
> reported by the hardware, over a time frame spanning no more than a few
> milliseconds. As it requires appropriate hardware support, this
> interface is optional.
>
> Note that under the hood, the new attribute relies on the information
> provided by arch_freq_get_on_cpu, which, up to this point, has been
> feeding data for scaling_cur_freq attribute, being the source of
> ambiguity when it comes to interpretation. This has been amended by
> restoring the intended behavior for scaling_cur_freq, with a new
> dedicated config option to maintain status quo for those, who may need
> it.

In case anyone is waiting for my input here

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

for this and the previous patch and please feel free to route them
both through ARM64.

Thanks!

> CC: Jonathan Corbet <corbet@lwn.net>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Borislav Petkov <bp@alien8.de>
> CC: Dave Hansen <dave.hansen@linux.intel.com>
> CC: H. Peter Anvin <hpa@zytor.com>
> CC: Phil Auld <pauld@redhat.com>
> CC: x86@kernel.org
> CC: linux-doc@vger.kernel.org
>
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> Reviewed-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
> Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  Documentation/admin-guide/pm/cpufreq.rst | 17 +++++++++++++-
>  drivers/cpufreq/Kconfig.x86              | 12 ++++++++++
>  drivers/cpufreq/cpufreq.c                | 30 +++++++++++++++++++++++-
>  3 files changed, 57 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/adm=
in-guide/pm/cpufreq.rst
> index a21369eba034..3950583f2b15 100644
> --- a/Documentation/admin-guide/pm/cpufreq.rst
> +++ b/Documentation/admin-guide/pm/cpufreq.rst
> @@ -248,6 +248,20 @@ are the following:
>         If that frequency cannot be determined, this attribute should not
>         be present.
>
> +``cpuinfo_avg_freq``
> +        An average frequency (in KHz) of all CPUs belonging to a given p=
olicy,
> +        derived from a hardware provided feedback and reported on a time=
 frame
> +        spanning at most few milliseconds.
> +
> +        This is expected to be based on the frequency the hardware actua=
lly runs
> +        at and, as such, might require specialised hardware support (suc=
h as AMU
> +        extension on ARM). If one cannot be determined, this attribute s=
hould
> +        not be present.
> +
> +        Note, that failed attempt to retrieve current frequency for a gi=
ven
> +        CPU(s) will result in an appropriate error, i.e: EAGAIN for CPU =
that
> +        remains idle (raised on ARM).
> +
>  ``cpuinfo_max_freq``
>         Maximum possible operating frequency the CPUs belonging to this p=
olicy
>         can run at (in kHz).
> @@ -293,7 +307,8 @@ are the following:
>         Some architectures (e.g. ``x86``) may attempt to provide informat=
ion
>         more precisely reflecting the current CPU frequency through this
>         attribute, but that still may not be the exact current CPU freque=
ncy as
> -       seen by the hardware at the moment.
> +       seen by the hardware at the moment. This behavior though, is only
> +       available via c:macro:``CPUFREQ_ARCH_CUR_FREQ`` option.
>
>  ``scaling_driver``
>         The scaling driver currently in use.
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 97c2d4f15d76..2c5c228408bf 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -340,3 +340,15 @@ config X86_SPEEDSTEP_RELAXED_CAP_CHECK
>           option lets the probing code bypass some of those checks if the
>           parameter "relaxed_check=3D1" is passed to the module.
>
> +config CPUFREQ_ARCH_CUR_FREQ
> +       default y
> +       bool "Current frequency derived from HW provided feedback"
> +       help
> +         This determines whether the scaling_cur_freq sysfs attribute re=
turns
> +         the last requested frequency or a more precise value based on h=
ardware
> +         provided feedback (as architected counters).
> +         Given that a more precise frequency can now be provided via the
> +         cpuinfo_avg_freq attribute, by enabling this option,
> +         scaling_cur_freq maintains the provision of a counter based fre=
quency,
> +         for compatibility reasons.
> +
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 96b013ea177c..a2f31fbb1774 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -734,12 +734,20 @@ __weak int arch_freq_get_on_cpu(int cpu)
>         return -EOPNOTSUPP;
>  }
>
> +static inline bool cpufreq_avg_freq_supported(struct cpufreq_policy *pol=
icy)
> +{
> +       return arch_freq_get_on_cpu(policy->cpu) !=3D -EOPNOTSUPP;
> +}
> +
>  static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char=
 *buf)
>  {
>         ssize_t ret;
>         int freq;
>
> -       freq =3D arch_freq_get_on_cpu(policy->cpu);
> +       freq =3D IS_ENABLED(CONFIG_CPUFREQ_ARCH_CUR_FREQ)
> +               ? arch_freq_get_on_cpu(policy->cpu)
> +               : 0;
> +
>         if (freq > 0)
>                 ret =3D sysfs_emit(buf, "%u\n", freq);
>         else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
> @@ -784,6 +792,19 @@ static ssize_t show_cpuinfo_cur_freq(struct cpufreq_=
policy *policy,
>         return sysfs_emit(buf, "<unknown>\n");
>  }
>
> +/*
> + * show_cpuinfo_avg_freq - average CPU frequency as detected by hardware
> + */
> +static ssize_t show_cpuinfo_avg_freq(struct cpufreq_policy *policy,
> +                                    char *buf)
> +{
> +       int avg_freq =3D arch_freq_get_on_cpu(policy->cpu);
> +
> +       if (avg_freq > 0)
> +               return sysfs_emit(buf, "%u\n", avg_freq);
> +       return avg_freq !=3D 0 ? avg_freq : -EINVAL;
> +}
> +
>  /*
>   * show_scaling_governor - show the current policy for the specified CPU
>   */
> @@ -946,6 +967,7 @@ static ssize_t show_bios_limit(struct cpufreq_policy =
*policy, char *buf)
>  }
>
>  cpufreq_freq_attr_ro_perm(cpuinfo_cur_freq, 0400);
> +cpufreq_freq_attr_ro(cpuinfo_avg_freq);
>  cpufreq_freq_attr_ro(cpuinfo_min_freq);
>  cpufreq_freq_attr_ro(cpuinfo_max_freq);
>  cpufreq_freq_attr_ro(cpuinfo_transition_latency);
> @@ -1073,6 +1095,12 @@ static int cpufreq_add_dev_interface(struct cpufre=
q_policy *policy)
>                         return ret;
>         }
>
> +       if (cpufreq_avg_freq_supported(policy)) {
> +               ret =3D sysfs_create_file(&policy->kobj, &cpuinfo_avg_fre=
q.attr);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         ret =3D sysfs_create_file(&policy->kobj, &scaling_cur_freq.attr);
>         if (ret)
>                 return ret;
> --
> 2.25.1
>
>

