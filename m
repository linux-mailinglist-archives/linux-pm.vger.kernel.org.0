Return-Path: <linux-pm+bounces-15976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC999A4314
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 17:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8699B23810
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C185202F7E;
	Fri, 18 Oct 2024 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lgfb0E2C"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23763202F78;
	Fri, 18 Oct 2024 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267133; cv=none; b=SUuagzRHAH4IHUM6QLE/22DsA9vU6ug4cVJsg7vphwBcYxPGhjel8c0+EqVzlJ3u0JEKvWC+CpcoXGDI3aibcWgNTM6hpKdsyI2pagjC0WzhbLSUdpmFv28q1/n2J2pcuayu/hT33TThTXkyyWK+N+3NiNF6qks0gMXWx6W1GlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267133; c=relaxed/simple;
	bh=ihFNrZPihZ26W2rNb7v+8YMJ3Cl4N/7ETfs8GUCuNbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ln8NJChWgOJ1qH8sTEtg0MMAc8azyxCN+C9cvG44rsWxYT5ToZYc46PBKUYL9D1RYRHQHSgg+/fkqRTEVfTNI+cDOSrNU1WmmHAiSnXhgAsQHXsX44EUPjCOlHJrBOZb8+5qwCvU5TWfMEVNDFAEapxS7iM1LfveZ0FfbScS/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lgfb0E2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8523C4CED1;
	Fri, 18 Oct 2024 15:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729267132;
	bh=ihFNrZPihZ26W2rNb7v+8YMJ3Cl4N/7ETfs8GUCuNbE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Lgfb0E2C4SznJHnA/o5Arhwe+QeGFQ4Ps5lYOUOG0zJPylkann42H0DO3UbOjDB2L
	 szhSlNdqoLW2hXa9XypJSabXgCdjQETAcyeV+T1UX48SmmOQeJsPcqpMylcnzKxkqL
	 mAOmU7qDl1JHY9sa8Nj3Y7BEYymuIjS2YNRW7Yrbxxj57uEmC3PhM2b+lZlhoTtyHz
	 f/KGRIC0zj/klGYO9lHbFZQzSQVYFhIDiowjOjuhvq8e4+hHNXqr7QFBM8AGmEN9Ar
	 DevPwpqas6/lvoz8GIxETe/L4muUCeFbbCApt7fYc/nWizGRaoC3DtBT/VDop9HB0v
	 5AvLMfykY43Qw==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5eb60f6b391so1208660eaf.3;
        Fri, 18 Oct 2024 08:58:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQOIecxcnQYj+e8tWLiHISJaTXoc2fzIwkscf6lcmMVNE9b4mt8Jk15Ty5WTYrNcGq2lEptMB9Hfk=@vger.kernel.org, AJvYcCWx5S9bVwGil8YgJ/GFLk6KbsGR7J9acCP4nLYh3UqmKr13LFPU9CIp6vaButsZlEW2YnGYLII9ZT9cPJkb47mgDAwrBw==@vger.kernel.org, AJvYcCXkfSftSJfnG6KpBaj+YZo/7DIiVr8sJyKD9Q7cXAch82Pwm+GOgoiucp++tDCglpqAGrpL7PwrQ+fYW0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxteOLw5DhNhHmsaMN8rCagHTgct4OjL66Ty+HRvgSFmOTAUrrb
	lAGAfjq+rcgoFC5b6i2efRbLXlh+NcW0A4CHO5FoQD1juq9AMtq6xOmVQIf0PxWkgVehjJlYQIT
	fDMNEWaaTTbAtbtbeVIycn+QQm0M=
X-Google-Smtp-Source: AGHT+IGtFgnBQ+8orSi7Xf16ffcXenwWJ0Coi92JyldI/9Vie9DEmddgrQPzPVyEcx5U9O7Y55Td9ccfVLxmTyoi5tA=
X-Received: by 2002:a05:6870:1645:b0:287:34a7:af9a with SMTP id
 586e51a60fabf-2892c2d12ccmr3275118fac.12.1729267131981; Fri, 18 Oct 2024
 08:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017210439.3449324-1-david.e.box@linux.intel.com> <20241017210439.3449324-2-david.e.box@linux.intel.com>
In-Reply-To: <20241017210439.3449324-2-david.e.box@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 Oct 2024 17:58:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hJfC+gYbPXiJNHEes4AUq40i3x9iFQLgLpccEqZDvLow@mail.gmail.com>
Message-ID: <CAJZ5v0hJfC+gYbPXiJNHEes4AUq40i3x9iFQLgLpccEqZDvLow@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] platform/x86/intel/pmc: Disable C1 auto-demotion
 during suspend
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: david.e.box@intel.com, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rjw@rjwysocki.net, 
	srinivas.pandruvada@linux.intel.com, ricardo.neri-calderon@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:04=E2=80=AFPM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> On some platforms, aggressive C1 auto-demotion may lead to failure to ent=
er
> the deepest C-state during suspend-to-idle, causing high power consumptio=
n.
> To prevent this, disable C1 auto-demotion during suspend and re-enable on
> resume.
>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V3 - Use s2idle wrapper function suggested by Rafael
>    - Use on_each_cpu() suggested by Ricardo

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> V2 - Remove #define DEBUG
>    - Move refactor of cnl_resume() to separate patch
>    - Use smp_call_function() to disable and restore C1_AUTO_DEMOTE
>    - Add comment that the MSR is per core, not per package.
>    - Add comment that the online cpu mask remains unchanged during
>      suspend due to frozen userspace.
>
>  drivers/platform/x86/intel/pmc/cnp.c | 53 ++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/=
intel/pmc/cnp.c
> index 513c02670c5a..3eaad2a7ebf4 100644
> --- a/drivers/platform/x86/intel/pmc/cnp.c
> +++ b/drivers/platform/x86/intel/pmc/cnp.c
> @@ -8,6 +8,8 @@
>   *
>   */
>
> +#include <linux/smp.h>
> +#include <linux/suspend.h>
>  #include "core.h"
>
>  /* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
> @@ -206,8 +208,57 @@ const struct pmc_reg_map cnp_reg_map =3D {
>         .etr3_offset =3D ETR3_OFFSET,
>  };
>
> +
> +/*
> + * Disable C1 auto-demotion
> + *
> + * Aggressive C1 auto-demotion may lead to failure to enter the deepest =
C-state
> + * during suspend-to-idle, causing high power consumption. To prevent th=
is, we
> + * disable C1 auto-demotion during suspend and re-enable on resume.
> + *
> + * Note that, although MSR_PKG_CST_CONFIG_CONTROL has 'package' in its n=
ame, it
> + * is actually a per-core MSR on client platforms, affecting only a sing=
le CPU.
> + * Therefore, it must be configured on all online CPUs. The online cpu m=
ask is
> + * unchanged during the phase of suspend/resume as user space is frozen.
> + */
> +
> +static DEFINE_PER_CPU(u64, pkg_cst_config);
> +
> +static void disable_c1_auto_demote(void *unused)
> +{
> +       int cpunum =3D smp_processor_id();
> +       u64 val;
> +
> +       rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
> +       per_cpu(pkg_cst_config, cpunum) =3D val;
> +       val &=3D ~NHM_C1_AUTO_DEMOTE;
> +       wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
> +
> +       pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum, val);
> +}
> +
> +static void restore_c1_auto_demote(void *unused)
> +{
> +       int cpunum =3D smp_processor_id();
> +
> +       wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, per_cpu(pkg_cst_config, cpunum=
));
> +
> +       pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum,
> +                per_cpu(pkg_cst_config, cpunum));
> +}
> +
> +static void s2idle_cpu_quirk(smp_call_func_t func)
> +{
> +       if (pm_suspend_via_firmware())
> +               return;
> +
> +       on_each_cpu(func, NULL, true);
> +}
> +
>  void cnl_suspend(struct pmc_dev *pmcdev)
>  {
> +       s2idle_cpu_quirk(disable_c1_auto_demote);
> +
>         /*
>          * Due to a hardware limitation, the GBE LTR blocks PC10
>          * when a cable is attached. To unblock PC10 during suspend,
> @@ -218,6 +269,8 @@ void cnl_suspend(struct pmc_dev *pmcdev)
>
>  int cnl_resume(struct pmc_dev *pmcdev)
>  {
> +       s2idle_cpu_quirk(restore_c1_auto_demote);
> +
>         pmc_core_send_ltr_ignore(pmcdev, 3, 0);
>
>         return pmc_core_resume_common(pmcdev);
> --
> 2.43.0
>
>

