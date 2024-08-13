Return-Path: <linux-pm+bounces-12148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DBE9504DE
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 14:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469891F21B36
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 12:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09857199392;
	Tue, 13 Aug 2024 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="V+uzBlTq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6BF19925A
	for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551957; cv=none; b=HTP76nmzD2u9xq7Agka+uP2TlpSpR8UNAYEK6VmK2HfHSuyqgF9qSktSVcclTOArsAeYkQu6V42MRPRKQRwUbOcDlEWrkhXy4okCG1In+kMjivimNqlLOqu2nw3dKIrKN7CrtuZoV0rp0+OhT96mFazIU8RkRtxqDu/BfBljsjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551957; c=relaxed/simple;
	bh=GuqX40LREmVg4Nqh1G6UJFWuG2NzNdEBbMzn5xStQCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fd+tfmHi2ac3rraXkk3tZCgnZGTcJolOFB/zuNhTJYXWJbR/N06kXg5yg9B4SzofgywpMaHqi7Pr7y90St3OyvgSONzlqh04jTnqHjCASJyrG6jPyhmNWzAGjmmbGsyPNOVlDeEPvslkVM8co+4oCayUYL8iB1Oh5DkiHhoRw7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=V+uzBlTq; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39b4f847a5eso18222515ab.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 05:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1723551955; x=1724156755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlpsPbvSqY1Guepb/+C8Hj4r/YthyFNML6v64qjLHgQ=;
        b=V+uzBlTqZdSnZ8s7/W1XBqCU3742paqPvYP232W9vaJGK01UwZY29sFYEunnOJQgn3
         a+8Ph1+Jkygq4y5ngWPVuhE9L2d18PoDm9AgeDPZU2De47utUArxynJWh3KIW8B2V5Cq
         YxdqNr7edpCmCDaZqAd/jiRHqn3r4xjzZkEypJlq3PSXKwwFd2b8uyfJvFAjidYGSBh4
         K5PvkVlOznGIV1AjoLp6Jv1FFFUR880+R6ePzI0UCzVNo/rsJYA0pb2Cw5XgBQXm0Pm7
         Bk2K+YXFPPrliBLn7j9yCF/3H2Ii2FaJsXagok9/q9KE0INZ9VasuX78JVOORsNrdyRf
         yD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723551955; x=1724156755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlpsPbvSqY1Guepb/+C8Hj4r/YthyFNML6v64qjLHgQ=;
        b=gfPWlUHE7YBjnx+CGxX0UTnSMgdQzepn6eAKVwvKod/bOj0Sj06gAqJecTnOd4zdNk
         Q0yAF6KeMYuhUbsL4WVRoAOgtxzzknTHuW83GtrLRka3bgBxRQnDaJj5Zm+u0//P3Ufl
         h3lxBVRnsuqNvLBIQAvlh9aOzOvOpXJLAc+vCjbd3wsYMrd8DmXqoRjlZ1Sg3Jon7N9x
         cihP5iCbrwBUVhSVspIDKECWLbJB46iP0xMSHd8IrUVlsP/RaMKXu/fMQ2hMM0os7UYK
         EjxIm/OpwzvKQHYcQDnqNY5TaylUGlMUr/ebV1A2Ulgwx2Nh6SGdmgDhWMHFtRjX/DSg
         kgsw==
X-Forwarded-Encrypted: i=1; AJvYcCWAUb7BM+eidZfXmL7ko+yg7+NE5BtoYnMiTcBy9iMHpSaw4mueI7LPpUXEfu1u2Td5gRB02V7ITqPr9chzr0H+Vg+o898SHSc=
X-Gm-Message-State: AOJu0YxGnwtLoSuJx+vrQV1jJirs0RiKHps+AM/r+XyXuGdzlNfgWTJP
	NDLvVqgFNxVQZnkvZUtvL0OxpvhQ9ftvHoSlVHXDauft58zDSQHPZkRsvypbRFkFSDssl90dMhF
	+04AAYtBwSZGNl8pYaj2I6GYPmd3WRZRY1xMpDA==
X-Google-Smtp-Source: AGHT+IGfc1hlnSw9m1j0prPgIWYWO3SpEZp9zrnyAvAWqBu+fTcn7+WZsmM/0bL31M4eersVd96dOZoC9Kz1EGd0ycA=
X-Received: by 2002:a05:6e02:1fce:b0:375:c473:4a78 with SMTP id
 e9e14a558f8ab-39c478f783emr40305315ab.23.1723551955377; Tue, 13 Aug 2024
 05:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813081324.3205944-1-nick.hu@sifive.com>
In-Reply-To: <20240813081324.3205944-1-nick.hu@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 13 Aug 2024 17:55:44 +0530
Message-ID: <CAAhSdy0W5mSVp79dF63BJkDCE_tMxrxWOxqwaTHghztX6dEm2w@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Allow cpuidle pd used by other devices
To: Nick Hu <nick.hu@sifive.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	greentime.hu@sifive.com, zong.li@sifive.com, 
	Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 1:43=E2=80=AFPM Nick Hu <nick.hu@sifive.com> wrote:
>
> To prevent the probe of consumer devices being deferred, create the
> platform devices for each pd node under '/cpus/power-domains' and move th=
e
> driver initailization to the arch_initcall.

To prevent the probe deferral of consumer devices, you can simply use
fwnode_dev_initialized() instead of creating a dummy platform device.

> The consumer devices that inside the cpu/cluster power domain may registe=
r
> the genpd notifier where their power domains are point to the pd nodes
> under '/cpus/power-domains'. If the cpuidle.off=3D=3D1, the genpd notifie=
r
> will fail due to sbi_cpuidle_pd_allow_domain_state is not set. We also
> need the sbi_cpuidle_cpuhp_up/down to invoke the callbacks. Therefore,
> add a cpuidle_disabled() check before registering the cpuidle driver to
> address the issue.

I think dealing with cpuidle.off=3D=3D1 case should be a separate patch.

>
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> Link: https://lore.kernel.org/lkml/20240226065113.1690534-1-nick.hu@sifiv=
e.com/
> Suggested-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidl=
e-riscv-sbi.c
> index a6e123dfe394..d6b01fc64f94 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -16,6 +16,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_platform.h>
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> @@ -25,6 +26,7 @@
>  #include <asm/smp.h>
>  #include <asm/suspend.h>
>
> +#include "cpuidle.h"
>  #include "dt_idle_states.h"
>  #include "dt_idle_genpd.h"
>
> @@ -336,6 +338,9 @@ static int sbi_cpuidle_init_cpu(struct device *dev, i=
nt cpu)
>                 return ret;
>         }
>
> +       if (cpuidle_disabled())
> +               return 0;
> +
>         ret =3D cpuidle_register(drv, NULL);
>         if (ret)
>                 goto deinit;
> @@ -380,20 +385,26 @@ static int sbi_cpuidle_pd_power_off(struct generic_=
pm_domain *pd)
>  struct sbi_pd_provider {
>         struct list_head link;
>         struct device_node *node;
> +       struct platform_device *pdev;
>  };
>
>  static LIST_HEAD(sbi_pd_providers);
>
>  static int sbi_pd_init(struct device_node *np)
>  {
> +       struct platform_device *pdev;
>         struct generic_pm_domain *pd;
>         struct sbi_pd_provider *pd_provider;
>         struct dev_power_governor *pd_gov;
>         int ret =3D -ENOMEM;
>
> +       pdev =3D of_platform_device_create(np, np->name, NULL);
> +       if (!pdev)
> +               goto out;
> +
>         pd =3D dt_idle_pd_alloc(np, sbi_dt_parse_state_node);
>         if (!pd)
> -               goto out;
> +               goto free_pdev;
>
>         pd_provider =3D kzalloc(sizeof(*pd_provider), GFP_KERNEL);
>         if (!pd_provider)
> @@ -419,6 +430,7 @@ static int sbi_pd_init(struct device_node *np)
>                 goto remove_pd;
>
>         pd_provider->node =3D of_node_get(np);
> +       pd_provider->pdev =3D pdev;
>         list_add(&pd_provider->link, &sbi_pd_providers);
>
>         pr_debug("init PM domain %s\n", pd->name);
> @@ -430,6 +442,8 @@ static int sbi_pd_init(struct device_node *np)
>         kfree(pd_provider);
>  free_pd:
>         dt_idle_pd_free(pd);
> +free_pdev:
> +       of_platform_device_destroy(&pdev->dev, NULL);
>  out:
>         pr_err("failed to init PM domain ret=3D%d %pOF\n", ret, np);
>         return ret;
> @@ -447,6 +461,7 @@ static void sbi_pd_remove(void)
>                 if (!IS_ERR(genpd))
>                         kfree(genpd);
>
> +               of_platform_device_destroy(&pd_provider->pdev->dev, NULL)=
;
>                 of_node_put(pd_provider->node);
>                 list_del(&pd_provider->link);
>                 kfree(pd_provider);
> @@ -548,7 +563,10 @@ static int sbi_cpuidle_probe(struct platform_device =
*pdev)
>         /* Setup CPU hotplut notifiers */
>         sbi_idle_init_cpuhp();
>
> -       pr_info("idle driver registered for all CPUs\n");
> +       if (cpuidle_disabled())
> +               pr_info("cpuidle is disabled\n");
> +       else
> +               pr_info("idle driver registered for all CPUs\n");
>
>         return 0;
>
> @@ -592,4 +610,4 @@ static int __init sbi_cpuidle_init(void)
>
>         return 0;
>  }
> -device_initcall(sbi_cpuidle_init);
> +arch_initcall(sbi_cpuidle_init);
> --
> 2.34.1
>

Regards,
Anup

