Return-Path: <linux-pm+bounces-25492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2689BA8A6F6
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 20:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B0C1900721
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 18:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BAB21C168;
	Tue, 15 Apr 2025 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g91dMG9Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7335A1F542E
	for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744742468; cv=none; b=luxUzdWqwKkOX7Yg7X0y3g/pWWCsuRd1V8xqkSw7xK5PdLpaaSFWbKVdYY995hCHAouqHzAS3ZRYY4TcrsXFws8t/jtuTBTlWbDzRNHKvqusSklEa46mfdSvk91+24NPND9/DvqX0dVq4H6DPXJ+5LBoI2uVjUVGxbmlMFxjMIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744742468; c=relaxed/simple;
	bh=iPsbGFIQttu3N7n0RcaUzwu0mt3aTqLe6I2/5USe3KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZ/1kK/wXhiXiVrVD1tOZhMm2CWIixD/z1XzrWf3odNdFacVuxklgH4ZCib52XQ8aJJSKbQmCwf+FGUsi5Xor8JhryovOTWMqkruz1Idm7PwAQLweKOfUx0umOCz3iL5JUgh2PqqqBUvYto6q95X532wA954mND7EUOlD4uOyG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g91dMG9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F26C4CEEC
	for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 18:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744742467;
	bh=iPsbGFIQttu3N7n0RcaUzwu0mt3aTqLe6I2/5USe3KI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g91dMG9YnljUHqAmIZl+U8iibck8ALeBfzqXudUWVXiPuvolB0HwDXf63ArnfBdzE
	 lEWDzGyzgKQdmNug3tfxRMOrPnWS8oYYfJVfQQUK9/JzoZf8Z6fQaYxPTe4OmdEGBy
	 cK98EWNAHnIBrSfLAYHJu8mtwt7Tc5xD+w+tS1UPeTb8BsT/asOoTCJs5hn5OpodrY
	 v2C6DHjYm2inslfVWK28rL2qBn7G82Qci3dX5WVCzz9lg5kKTkMxQsbil+7I5Jc5jq
	 Co9CKKw7bQnZPtDxl8eIMVTqJvPN5KX4NcRzdjDOH+KtO9YOl/BOkmWp7GgE8b80du
	 4ny/Zo1/yB3PQ==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2c6ed7efb1dso3792581fac.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 11:41:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzFupgF4eve759jwgLlLbFAzikdvP1llPtplUBmUZupWmeRf5TsLmfxXgD7qJcLK7bDEDljM/kKA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz42BQlIxx7JI+WMLhhT3M2A1ysAwRzcXEdBl95ol5QWqXKXFlm
	jlD0R64TagAOls1xuOvN71mBhRASdGN7Y/5zADoLsnOi4z0C3LiBzkCFbzRtptb2zCR1ORHvT3f
	di+NxASYuIP3UmV2HCAM5xfeCbdA=
X-Google-Smtp-Source: AGHT+IFiW3y+aYA1H8kCKabXdR0SJ0+YgQp13UCGY73dSfhdpECl0nUOMyp1ZORZ5Zwzprs0VM3Tf9/8XOcG5t56xfQ=
X-Received: by 2002:a05:6870:4710:b0:2c1:ac88:4a8d with SMTP id
 586e51a60fabf-2d4c3e9a6d0mr165083fac.30.1744742467172; Tue, 15 Apr 2025
 11:41:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317135541.1471754-1-dedekind1@gmail.com> <20250317135541.1471754-2-dedekind1@gmail.com>
In-Reply-To: <20250317135541.1471754-2-dedekind1@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 Apr 2025 20:40:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j9FCUR4Sj65mmOm7MYx94RO7w59SzRb7un7BR4_sFZvg@mail.gmail.com>
X-Gm-Features: ATxdqUHABDQcrsLoNpadTFK1me0CXhCJ3DZ60_s3YbWlPe7StNHK8ctPRggc3kc
Message-ID: <CAJZ5v0j9FCUR4Sj65mmOm7MYx94RO7w59SzRb7un7BR4_sFZvg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] intel_idle: Add C1 demotion on/off sysfs knob
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 2:55=E2=80=AFPM Artem Bityutskiy <dedekind1@gmail.c=
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
>  drivers/idle/intel_idle.c | 102 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 348c49d50a967..da9da7cb27656 100644
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
>          */
>         unsigned long auto_demotion_disable_flags;
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
> @@ -1539,18 +1547,21 @@ static const struct idle_cpu idle_cpu_gmt __initc=
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
> @@ -1589,12 +1600,14 @@ static const struct idle_cpu idle_cpu_snr __initc=
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
> @@ -2310,6 +2323,88 @@ static void __init intel_idle_cpuidle_devices_unin=
it(void)
>                 cpuidle_unregister_device(per_cpu_ptr(intel_idle_cpuidle_=
devices, i));
>  }
>
> +static void intel_c1_demotion_toggle(void *enable)
> +{
> +       unsigned long long msr_val;
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
> +static ssize_t intel_c1_demotion_store(struct device *dev,
> +                                      struct device_attribute *attr,
> +                                      const char *buf, size_t count)
> +{
> +       bool enable;
> +       int err;
> +
> +       err =3D kstrtobool(buf, &enable);
> +       if (err)
> +               return err;
> +
> +       mutex_lock(&c1_demotion_mutex);
> +       /* Enable/disable C1 demotion on all CPUs */
> +       on_each_cpu(intel_c1_demotion_toggle, (void *)enable, 1);
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
> +        * configuration would be a BIOS bug.
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
> @@ -2360,6 +2455,8 @@ static int __init intel_idle_init(void)
>                 auto_demotion_disable_flags =3D icpu->auto_demotion_disab=
le_flags;
>                 if (icpu->disable_promotion_to_c1e)
>                         c1e_promotion =3D C1E_PROMOTION_DISABLE;
> +               if (icpu->c1_demotion_supported)
> +                       c1_demotion_supported =3D true;
>                 if (icpu->use_acpi || force_use_acpi)
>                         intel_idle_acpi_cst_extract();
>         } else if (!intel_idle_acpi_cst_extract()) {
> @@ -2373,6 +2470,10 @@ static int __init intel_idle_init(void)
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
> @@ -2397,6 +2498,7 @@ static int __init intel_idle_init(void)
>         intel_idle_cpuidle_devices_uninit();
>         cpuidle_unregister_driver(&intel_idle_driver);
>  init_driver_fail:
> +       intel_idle_sysfs_uninit();
>         free_percpu(intel_idle_cpuidle_devices);
>         return retval;
>
> --

Applied as 6.16 material along with the [2-3/3], thanks!

