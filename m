Return-Path: <linux-pm+bounces-23133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD05CA48962
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 21:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99373B3843
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 20:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABE926FA44;
	Thu, 27 Feb 2025 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drb5bYia"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D809B26F467
	for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 20:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686817; cv=none; b=le5zXbOHtCkxxhLXcm8b3LuQyb2UXMXq8D4qFyIm/XYJkU7g6ff4kvjLAc7F5ev71rNVxsJBeJYnQO6CeosoUhnUJ9l57wLylnI9+t2A6HCxyWbZ09LXFw7o6MIcr9VmiIEzmPt3cFVVl590oRS+bp/wcya2mblHR8xN1MFPWMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686817; c=relaxed/simple;
	bh=jRkw+dhmZlJ2y8Eu1xsnEU43FS1pt3FqykbMruhEswQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IY5pUVyOxeBBjQIfdQh2oNkrYJ6FOtD5DQCQ+rGcIowz0kezNLzty/arn0oRLnFPbAnWZXSu3gUA2YhMRBN+I8AZMff/PVwsBhVoRozMeuIoWM2eyruTU9J80pZvtprRu5diWRTdtqlLiOmSNtL1vxhoZUWSjiVwuSkEneOvEPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drb5bYia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49997C4CEDD
	for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 20:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740686817;
	bh=jRkw+dhmZlJ2y8Eu1xsnEU43FS1pt3FqykbMruhEswQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=drb5bYia4uftB7xb7pGj240ozhIQNAjJ3K54Kfpxrt3c0v4gjNsvV3LxJ4NKlRaUo
	 20IfS7GnIKVyOcFgV3c8IORXcd47fA1FJkLWmF0pnn/ShGNZzrnhdf8C1MooGkmddc
	 8MCx/qzo25RytA5EX+s7K56MjgPdar9CNyXZJGvQo1ikLX1kSUGxwxfLbfTY6ZhhRS
	 SJL3EpmN9Ll2ZZrrIh7GbrsEBYSo9e0hA3GSFadfd2HvltAY8b8h4UTh6TSeO39afF
	 4/tX+gudqa1OcP3rMjVW7ArgHw1czjLHBU9jzOgcytyAzncktowqBOAsX/w+CZOdTW
	 lMILRtkPmI2tQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2bcceee7b40so833386fac.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 12:06:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDfD/AbKDbP3t/DgNpphyPF83skLeNFP6qVSVtDe8GlRlI0/wPXOp3gea5zAvcGTYiKBxxJWc7pA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyV/N5fvz6+OGk8OrC8I9Fn+nmuRS4pOJY3NoZk47T1hhMn60v
	y/zVG8jokSe/2p3dgES5mVEW7V0VizuGrROX/lAa8ZV6KUxX8Rqhc5ixatRvz1qjyjqnJOP6k3y
	DIZt9ap/BMsBPGpzqzxfpM8AGT3U=
X-Google-Smtp-Source: AGHT+IFoGtMi03bR7ZSqIEoUtrzj9YxEDWMpwqj63B+3dSW7sXmmry5QaJyLTRaR1x332HvMxortFuHr5fmigY2DCOM=
X-Received: by 2002:a05:6871:aa02:b0:29e:7a09:d92a with SMTP id
 586e51a60fabf-2c17832b087mr348744fac.5.1740686816605; Thu, 27 Feb 2025
 12:06:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220151702.2153579-1-dedekind1@gmail.com> <20250220151702.2153579-2-dedekind1@gmail.com>
In-Reply-To: <20250220151702.2153579-2-dedekind1@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Feb 2025 21:06:45 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gY6=B=YQLw3Q57r1xxWV1eO-7AuH0+m96yFQ6T-4t8jw@mail.gmail.com>
X-Gm-Features: AQ5f1JqQKhumGpueYouxqJ4DpVyv9iZNp0BnZ7NHltuu1FyF4aDjp1_roOcUFDU
Message-ID: <CAJZ5v0gY6=B=YQLw3Q57r1xxWV1eO-7AuH0+m96yFQ6T-4t8jw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] intel_idle: Add C1 demotion on/off sysfs knob
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 4:17=E2=80=AFPM Artem Bityutskiy <dedekind1@gmail.c=
om> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> Add a sysfs knob to enable/disable C1 demotion for the following Intel
> platforms: Sapphire Rapids Xeon, Emerald Rapids Xeon, Granite Rapids Xeon=
,
> Sierra Forest Xeon, and Grand Ridge SoC.
>
> This sysfs file shows up as
> "/sys/devices/system/cpu/cpuidle/intel_c1_demotion".
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
>  drivers/idle/intel_idle.c | 103 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 118fe1d37c22..8d2095078469 100644
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
> @@ -2291,6 +2304,89 @@ static void __init intel_idle_cpuidle_devices_unin=
it(void)
>                 cpuidle_unregister_device(per_cpu_ptr(intel_idle_cpuidle_=
devices, i));
>  }
>
> +static void intel_c1_demotion_toggle(void *info)
> +{
> +       unsigned long long msr_val;
> +       bool enable =3D *(bool *)info;

Instead of doing this here, you can cast the enable value to (void *)
in the caller, so you can do

> +
> +       rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
> +       /*
> +        * Enable/disable C1 undemotion along with C1 demotion, as this i=
s the
> +        * most sensible configuration in general.
> +        */
> +       if (enable)

if (info)  // and maybe rename info to enable?

> +               msr_val |=3D NHM_C1_AUTO_DEMOTE | SNB_C1_AUTO_UNDEMOTE;
> +       else
> +               msr_val &=3D ~(NHM_C1_AUTO_DEMOTE | SNB_C1_AUTO_UNDEMOTE)=
;
> +       wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
> +}
> +
> +static ssize_t intel_c1_demotion_store(struct device *dev,
> +                                      struct device_attribute *attr,
> +                                      const char *buf, size_t count)
> +{
> +       int err;
> +       bool enable;

Reverse X-mas tree ordering, please.

> +
> +       err =3D kstrtobool(buf, &enable);
> +       if (err)
> +               return err;
> +
> +       mutex_lock(&c1_demotion_mutex);
> +       /* Enable/disable C1 demotion on all CPUs */
> +       on_each_cpu(intel_c1_demotion_toggle, &enable, 1);

I mean

      on_each_cpu(intel_c1_demotion_toggle, (void *)enable, 1);

> +       mutex_unlock(&c1_demotion_mutex);
> +
> +       return count;
> +}
> +
> +static ssize_t intel_c1_demotion_show(struct device *dev,
> +                                     struct device_attribute *attr, char=
 *buf)
> +{
> +       unsigned long long msr_val;
> +
> +       /*
> +        * Read the MSR value for a CPU and assume it is the same for all=
 CPUs. Any other
> +        * configureation would be a BIOS bug.

configuration

> +        */
> +       rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
> +       return sysfs_emit(buf, "%d\n", !!(msr_val & NHM_C1_AUTO_DEMOTE));
> +}
> +static DEVICE_ATTR_RW(intel_c1_demotion);
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
> +                                     &dev_attr_intel_c1_demotion.attr,
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
> +                                    &dev_attr_intel_c1_demotion.attr,
> +                                    "cpuidle");
> +       put_device(sysfs_root);
> +}
> +
>  static int __init intel_idle_init(void)
>  {
>         const struct x86_cpu_id *id;
> @@ -2337,6 +2433,8 @@ static int __init intel_idle_init(void)
>                 auto_demotion_disable_flags =3D icpu->auto_demotion_disab=
le_flags;
>                 if (icpu->disable_promotion_to_c1e)
>                         c1e_promotion =3D C1E_PROMOTION_DISABLE;
> +               if (icpu->c1_demotion_supported)
> +                       c1_demotion_supported =3D true;
>                 if (icpu->use_acpi || force_use_acpi)
>                         intel_idle_acpi_cst_extract();
>         } else if (!intel_idle_acpi_cst_extract()) {
> @@ -2350,6 +2448,10 @@ static int __init intel_idle_init(void)
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
> @@ -2374,6 +2476,7 @@ static int __init intel_idle_init(void)
>         intel_idle_cpuidle_devices_uninit();
>         cpuidle_unregister_driver(&intel_idle_driver);
>  init_driver_fail:
> +       intel_idle_sysfs_uninit();
>         free_percpu(intel_idle_cpuidle_devices);
>         return retval;
>
> --

