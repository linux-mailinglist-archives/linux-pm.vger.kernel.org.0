Return-Path: <linux-pm+bounces-15538-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C155F99A24C
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 13:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C119286F70
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 11:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C2E2141B9;
	Fri, 11 Oct 2024 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq/gXs7m"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096A914293;
	Fri, 11 Oct 2024 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644731; cv=none; b=hN7Cllly3FVhZjVeZkAeyXjwN7GCjViGBxR+U6klxfcEkWMOenh6PqPDfiwmMFRLoBXFIc+R8eNPcyKPau0wI4p6tR52liWatscgija0+nvQpuJ3MUzuGSNfyKjzov7Z9zxr5KMCv3BfoUL1LT5wj5JiHmaEEkudc7evY+tJYgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644731; c=relaxed/simple;
	bh=pWaUK6oZz9+kh/mcn2cVY2AIOr66cZMGpSFQuPnLBBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pX0RYHpEtp3oNiVE510U8zJU3AE4HmTiRm37UvlX9x7Eou/Gby0OnpHu143uKmwRv6OSkq5UMWKhZo/LIx7It/qVgXS/KubYGt/UO6RJ0aTKyrM1XzVkHB9tJeYsSSvLu+J8LRzUlq2U06K9y2wNVaVyCJYagTCLSm0gx+kDNOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oq/gXs7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF49C4AF09;
	Fri, 11 Oct 2024 11:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728644730;
	bh=pWaUK6oZz9+kh/mcn2cVY2AIOr66cZMGpSFQuPnLBBU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Oq/gXs7mU4RKNiYT78CK9ANwbyf/NY5ld2EnY1toMMqv5L76B2usOJ99vsj1AD/89
	 XL/Hg4F5QDGXNukUtX5lHRia8/NoHz9ti8EmMrooX9vSfzGjxUsvTse6b3jhiAqZPR
	 Cc0Y51FbNBTy7NmPpE+MFW8gevqfFBv0hAOG3tG7VMbWtsS2jotLCl5MtgO7yAjli1
	 U+xZ3YHVaMLAeEk0Hf9CLBMyAUusGkADGCOtvys+3V3OmYW31PBH70qZO64yT8NjKU
	 192zv/M9Bj+lKJuLbpyspN85dGZJGn6QE0P6ZEVi0rJc3tbZHB16TouqrUWrjRMl24
	 zEclR2YvVV9Vg==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5e803a607f3so735517eaf.2;
        Fri, 11 Oct 2024 04:05:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPSUkXNOgCyzqt8PthcuHDWh83CI6RKn+/KsfGgtsuK9V8oWjaSiMF7S2ayT6bRgpXbeLWXSnjYDvXi/M=@vger.kernel.org, AJvYcCXEphSmL2I3vVahIXTtas2FcRoZQS/N8CXxWMmiHUHiRoi/1yuLEmaLu+egWvBLp+4vmZJh1xi6p1nSHIc+Ew2K71dXuw==@vger.kernel.org, AJvYcCXOGE7d9w28mNkrqfQQIBS9pYO91a/cHwfAPcPM3I7tjTTsNAh9sAGprlXWJqvdpskZN59Adn2WnhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0HNXcY1/5Jen6zPPj5PSt5hm12LFhu7ghBmKpRS0wg0FLpym8
	RsRIXqt/1BD9qe84TOu2EmXJFLKYzH5YozJR05uWR0hJ7jW0nHl1Nq+SQGMsLvtGsVNWBGR1jti
	BIVVAuPBXKNZeBUzUAKUSeSkJkAs=
X-Google-Smtp-Source: AGHT+IHIXek8kNzmz8ZDbXKuZUg4I3LS7/jhn6vFJ/fxIC+tkCPgzzIGfol6kVCxgvSLASuLxB7nC2KExxoE+D8evqs=
X-Received: by 2002:a05:6870:2c93:b0:277:f14c:9c0f with SMTP id
 586e51a60fabf-2886df763e7mr1168852fac.32.1728644729753; Fri, 11 Oct 2024
 04:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011003640.1613812-1-david.e.box@linux.intel.com> <20241011003640.1613812-2-david.e.box@linux.intel.com>
In-Reply-To: <20241011003640.1613812-2-david.e.box@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 Oct 2024 13:05:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0haLjsM67QCVg-6i6i7GmBZjhZzFTmm3=r+8gmAfP4qxQ@mail.gmail.com>
Message-ID: <CAJZ5v0haLjsM67QCVg-6i6i7GmBZjhZzFTmm3=r+8gmAfP4qxQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] platform/x86/intel/pmc: Disable C1 auto-demotion
 during suspend
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, rjw@rjwysocki.net, 
	srinivas.pandruvada@linux.intel.com, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 2:36=E2=80=AFAM David E. Box
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
>
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
> index 513c02670c5a..f12d4f0f9e93 100644
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
> @@ -206,8 +208,52 @@ const struct pmc_reg_map cnp_reg_map =3D {
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
> +       pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum, val);
> +}

If you decide to retain the debug statements, I generally prefer to
separate them from the rest of the code with empty lines, for clarity.

> +
> +static void restore_c1_auto_demote(void *unused)
> +{
> +       int cpunum =3D smp_processor_id();
> +
> +       pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum,
> +                per_cpu(pkg_cst_config, cpunum));
> +       wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, per_cpu(pkg_cst_config, cpunum=
));
> +}
> +

I would add something like

static void s2idle_cpu_quirk(smp_call_func_t func)
{
       if (pm_suspend_via_firmware())
              return;

       preempt_disable();
       func();
       smp_call_function(func, NULL, 0);
       preempt_enable();
}

>  void cnl_suspend(struct pmc_dev *pmcdev)
>  {
> +       if (!pm_suspend_via_firmware()) {
> +               preempt_disable();
> +               disable_c1_auto_demote(NULL);
> +               smp_call_function(disable_c1_auto_demote, NULL, 0);
> +               preempt_enable();
> +       }
> +

And here I'd just do

      s2idle_cpu_quirk(disable_c1_auto_demote);

and analogously below.

>         /*
>          * Due to a hardware limitation, the GBE LTR blocks PC10
>          * when a cable is attached. To unblock PC10 during suspend,
> @@ -218,6 +264,13 @@ void cnl_suspend(struct pmc_dev *pmcdev)
>
>  int cnl_resume(struct pmc_dev *pmcdev)
>  {
> +       if (!pm_suspend_via_firmware()) {
> +               preempt_disable();
> +               restore_c1_auto_demote(NULL);
> +               smp_call_function(restore_c1_auto_demote, NULL, 0);
> +               preempt_enable();
> +       }
> +
>         pmc_core_send_ltr_ignore(pmcdev, 3, 0);
>
>         return pmc_core_resume_common(pmcdev);
> --

