Return-Path: <linux-pm+bounces-21982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0906A33089
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 21:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA23165427
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 20:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8AB20102E;
	Wed, 12 Feb 2025 20:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzZRdlr2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DCD201259
	for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 20:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391131; cv=none; b=EIK9Mt54LJZid7OfOqVt0bONZIif2QOJfarLHjc5+HU8Lj2IBo/rRmIGdHj/xTqPLu1psB/EY4UMbdolSVklWA1mnijggRcXhcLZD+0p/ZFXX9aO0FiMfPQHVUwqqvLKiDsQRwSzoPBJycpy26TlPODtDXU0+9nyPoO0yEEdZ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391131; c=relaxed/simple;
	bh=ARYD94gCf6MIQGpoqHN8PzRzfKm4cClh+tg+izZP6yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljrg7cbhH5ErLQ5QJEwrPVr/odJwj9IoGptgVR2o//erU2P5iUwwD+kubjD5bl1u96EG/HNuIMCdQ3knTw2sF4FFQbTbvbuMiTgEw71Sg6IOFV4hFjFT+NFzVnsDpz5tD2l8abLyyxIZVwC4G9LYAWHwuhAgkZSuNhtdobS8kUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzZRdlr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D9BC4CEE7
	for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 20:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739391130;
	bh=ARYD94gCf6MIQGpoqHN8PzRzfKm4cClh+tg+izZP6yk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kzZRdlr2U8uM3QkrNgPK55Ujipp7vEu6GX7omHBNSNY3f8xXIQOv0TEMnmJWlAOAi
	 PrvkvFUt2Bo8+1tbGc/whK4hmlL0wLyngqYJYVxUPwKCmonzEm6Pq4NCtMtdh+5m2K
	 Pdm/G9ZJMVExIGZYsXOA/Uw85Hdi2/yjw1RisUz4uCJnI9QqCMwJf8ELYyiEufBRyd
	 t1glRPRbeEr1qna77nOkSePPUIyp3sfk2EO3iWuU0MTVPDUF/YJK9MJ00NPIj7CFar
	 P4Gd9IJZ5XvErJRV2vynBtbNyhdLiUjGVpc5SYypOFD7HGGAg+HyADiUsKV5SV94f3
	 Em0ox8aSOEPBw==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5fcad6dbce0so95555eaf.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 12:12:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJPAWxBdLSjBdVYXOkx7HMpnUV23AXmjKBBJaX2As74nc7Cg1io0oyUPHzMTP0vDgzYqe8pRvc5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/l/SWoWgCroolhsgIpGbEegyWT4ebaMmEnR8scVJs0iqmpNYY
	gGTE64oTnJWaQuGVP8rqykbXkQ1XrOgiHAqojRNwmyeMUfoL3LxS/c2K3PxvQeEuooem5Peq2ci
	kvGBoJkfHcmalVn0Ji1mg6u2srJ0=
X-Google-Smtp-Source: AGHT+IF9Pde4CLEnCIVv9IzsLhEMe8iZAgWqf9306heQY4ljcxWBgPiAqubnf3rI7HM08jScHs94jV4K1k5RrpwhD1o=
X-Received: by 2002:a05:6871:374c:b0:24e:8987:6f34 with SMTP id
 586e51a60fabf-2b8f8c0d2d8mr349136fac.3.1739391129834; Wed, 12 Feb 2025
 12:12:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212084232.2349984-1-dedekind1@gmail.com>
In-Reply-To: <20250212084232.2349984-1-dedekind1@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Feb 2025 21:11:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hnm_Xx-NQfOiOFWNYJoeOr-LbgTcd1u0SxNM=EbyQQTA@mail.gmail.com>
X-Gm-Features: AWEUYZnZa3CfVRn2zRO-hk70FJXi9zWicrt0y1qSF7nNvPVgJ0MubCkO0Umf-Ns
Message-ID: <CAJZ5v0hnm_Xx-NQfOiOFWNYJoeOr-LbgTcd1u0SxNM=EbyQQTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] intel_idle: Add C1 demotion on/off sysfs knob
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 9:42=E2=80=AFAM Artem Bityutskiy <dedekind1@gmail.c=
om> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> Add a sysfs knob to enable/disable C1 demotion for the following Intel
> platforms: Sapphire Rapids Xeon, Emerald Rapids Xeon, Granite Rapids Xeon=
,
> Sierra Forest Xeon, and Grand Ridge SoC.
>
> This sysfs file shows up as "/sys/devices/system/cpu/cpuidle/c1_demotion"=
.
>
> The C1 demotion feature involves the platform firmware demoting deep
> C-state requests from the OS (e.g., C6 requests) to C1. The idea is
> that firmware monitors CPU wake-up rate, and if it is higher than a
> platform-specific threshold, the firmware demotes deep C-state
> requests to C1. For example, Linux requests C6, but firmware noticed
> too many wake-ups per second, and it keeps the CPU in C1. When the
> CPU stays in C1 long enough, the platform promotes it back to C6.
>
> The default value for C1 demotion is whatever is configured by BIOS.
>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 99 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 118fe1d37c22..f950e8e793fe 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -48,9 +48,11 @@
>  #include <trace/events/power.h>
>  #include <linux/sched.h>
>  #include <linux/sched/smt.h>
> +#include <linux/mutex.h>
>  #include <linux/notifier.h>
>  #include <linux/cpu.h>
>  #include <linux/moduleparam.h>
> +#include <linux/sysfs.h>
>  #include <asm/cpuid.h>
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
> @@ -91,9 +93,15 @@ struct idle_cpu {
>         unsigned long auto_demotion_disable_flags;
>         bool byt_auto_demotion_disable_flag;
>         bool disable_promotion_to_c1e;
> +       bool c1_demotion_supported;
>         bool use_acpi;
>  };
>
> +static bool c1_demotion_supported;
> +static DEFINE_MUTEX(c1_demotion_mutex);
> +
> +static struct device *sysfs_root __initdata;
> +
>  static const struct idle_cpu *icpu __initdata;
>  static struct cpuidle_state *cpuidle_state_table __initdata;
>
> @@ -1541,18 +1549,21 @@ static const struct idle_cpu idle_cpu_gmt __initc=
onst =3D {
>  static const struct idle_cpu idle_cpu_spr __initconst =3D {
>         .state_table =3D spr_cstates,
>         .disable_promotion_to_c1e =3D true,
> +       .c1_demotion_supported =3D true,
>         .use_acpi =3D true,
>  };
>
>  static const struct idle_cpu idle_cpu_gnr __initconst =3D {
>         .state_table =3D gnr_cstates,
>         .disable_promotion_to_c1e =3D true,
> +       .c1_demotion_supported =3D true,
>         .use_acpi =3D true,
>  };
>
>  static const struct idle_cpu idle_cpu_gnrd __initconst =3D {
>         .state_table =3D gnrd_cstates,
>         .disable_promotion_to_c1e =3D true,
> +       .c1_demotion_supported =3D true,
>         .use_acpi =3D true,
>  };
>
> @@ -1591,12 +1602,14 @@ static const struct idle_cpu idle_cpu_snr __initc=
onst =3D {
>  static const struct idle_cpu idle_cpu_grr __initconst =3D {
>         .state_table =3D grr_cstates,
>         .disable_promotion_to_c1e =3D true,
> +       .c1_demotion_supported =3D true,
>         .use_acpi =3D true,
>  };
>
>  static const struct idle_cpu idle_cpu_srf __initconst =3D {
>         .state_table =3D srf_cstates,
>         .disable_promotion_to_c1e =3D true,
> +       .c1_demotion_supported =3D true,
>         .use_acpi =3D true,
>  };
>
> @@ -2291,6 +2304,85 @@ static void __init intel_idle_cpuidle_devices_unin=
it(void)
>                 cpuidle_unregister_device(per_cpu_ptr(intel_idle_cpuidle_=
devices, i));
>  }
>
> +static void c1_demotion_toggle(void *info)
> +{
> +       unsigned long long msr_val;
> +       bool enable =3D *(bool *)info;
> +
> +       rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
> +       /*
> +        * Enable/disable C1 undemotion along with C1 demotion, as this i=
s the
> +        * most sensible configuration in general.
> +        */
> +       if (enable)
> +               msr_val |=3D NHM_C1_AUTO_DEMOTE | SNB_C1_AUTO_UNDEMOTE;
> +       else
> +               msr_val &=3D ~(NHM_C1_AUTO_DEMOTE | SNB_C1_AUTO_UNDEMOTE)=
;
> +       wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
> +}
> +
> +static ssize_t c1_demotion_store(struct device *dev,
> +                                struct device_attribute *attr,
> +                                const char *buf, size_t count)
> +{
> +       int err;
> +       bool enable;
> +
> +       err =3D kstrtobool(buf, &enable);
> +       if (err)
> +               return err;
> +
> +       mutex_lock(&c1_demotion_mutex);
> +       /* Enable/disable C1 demotion on all CPUs */
> +       on_each_cpu(c1_demotion_toggle, &enable, 1);
> +       mutex_unlock(&c1_demotion_mutex);

This is not the only place where MSR_PKG_CST_CONFIG_CONTROL gets
updated.  The other one is drivers/platform/x86/intel/pmc/cnp.c

There is no real conflict because the PMC core thing happens during
system suspend/resume on client platforms, but this is kind of
duplicated code.  Any chance to consolidate this?

> +
> +       return count;
> +}
> +
> +static ssize_t c1_demotion_show(struct device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       unsigned long long msr_val;
> +
> +       rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
> +       return sysfs_emit(buf, "%d\n", !!(msr_val & NHM_C1_AUTO_DEMOTE));

This reads the register on the current CPU with the assumption that
the specific bit value will be the same for all CPUs.  Is this always
true?  What about systems with more than one package?  Do they always
initialize this bit to the same value in all packages?  I guess so,
but then I would add a comment documenting this assumption and the
reasons for it.

> +}
> +static DEVICE_ATTR_RW(c1_demotion);

I'm not sure if the attr name is clear enough.  I guess reading the
doc is really necessary to get an idea of what this is about, but it
might indicate that the demotion is done in hardware, like
"hw_c1_demotion".

> +
> +static int __init intel_idle_sysfs_init(void)
> +{
> +       int err;
> +
> +       if (!c1_demotion_supported)
> +               return 0;
> +
> +       sysfs_root =3D bus_get_dev_root(&cpu_subsys);
> +       if (!sysfs_root)
> +               return 0;
> +
> +       err =3D sysfs_add_file_to_group(&sysfs_root->kobj,
> +                                     &dev_attr_c1_demotion.attr,
> +                                     "cpuidle");
> +       if (err) {
> +               put_device(sysfs_root);
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static void __init intel_idle_sysfs_uninit(void)
> +{
> +       if (!sysfs_root)
> +               return;
> +
> +       sysfs_remove_file_from_group(&sysfs_root->kobj,
> +                                    &dev_attr_c1_demotion.attr,
> +                                    "cpuidle");
> +       put_device(sysfs_root);
> +}
> +
>  static int __init intel_idle_init(void)
>  {
>         const struct x86_cpu_id *id;
> @@ -2337,6 +2429,8 @@ static int __init intel_idle_init(void)
>                 auto_demotion_disable_flags =3D icpu->auto_demotion_disab=
le_flags;
>                 if (icpu->disable_promotion_to_c1e)
>                         c1e_promotion =3D C1E_PROMOTION_DISABLE;
> +               if (icpu->c1_demotion_supported)
> +                       c1_demotion_supported =3D true;
>                 if (icpu->use_acpi || force_use_acpi)
>                         intel_idle_acpi_cst_extract();
>         } else if (!intel_idle_acpi_cst_extract()) {
> @@ -2350,6 +2444,10 @@ static int __init intel_idle_init(void)
>         if (!intel_idle_cpuidle_devices)
>                 return -ENOMEM;
>
> +       retval =3D intel_idle_sysfs_init();
> +       if (retval)
> +               pr_warn("failed to initialized sysfs");
> +
>         intel_idle_cpuidle_driver_init(&intel_idle_driver);
>
>         retval =3D cpuidle_register_driver(&intel_idle_driver);
> @@ -2374,6 +2472,7 @@ static int __init intel_idle_init(void)
>         intel_idle_cpuidle_devices_uninit();
>         cpuidle_unregister_driver(&intel_idle_driver);
>  init_driver_fail:
> +       intel_idle_sysfs_uninit();
>         free_percpu(intel_idle_cpuidle_devices);
>         return retval;
>
> --

