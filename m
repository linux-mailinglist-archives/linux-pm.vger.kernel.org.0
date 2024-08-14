Return-Path: <linux-pm+bounces-12188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA8D9511C2
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 03:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11961C2229F
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 01:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9035179AD;
	Wed, 14 Aug 2024 01:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="djtvAlh9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E3011717
	for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 01:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723600595; cv=none; b=hQIv/kEXNROlcsloc/bKdVQPVng6H9xFdqMmP3OWzXqGQXHoy1KcXa4Wi8sjcuq5k1ReBph/1exEJRCZdBaPLeYhuAFRDVjhL3QL9va5r8jblvrR5ukraHM5zgfQuS3wqBhzOngoLtVVFqhGJEw/f3TnmfIjUz08oCgIqaFUf4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723600595; c=relaxed/simple;
	bh=8XCNxWaa/779JhO6sTtax06Mooe+kbq8KtC+N1sHAd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rigE5lxLGjQMouZ50hNVRz0zO5azyJTq7ql86iUe0SWT0yDAL+Z3OHeHEiET0ToBTaRn7zTV+03L4Basm2Dt5AP+ZmCutQOj72KKAabbXfWzP4Ev6gjyDxS9PiH2Dk6YeHdTSOucn1l5JAUafJBzgNy7Bc1pjQO5FZpeEIoJHE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=djtvAlh9; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-26b5173e861so3740586fac.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 18:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723600593; x=1724205393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8G2fruqv1n9Ss0goXxvFPeqf2LkkBVMKwQASCzStoE8=;
        b=djtvAlh98C+4u8JmujT9pwUvJk2E2XFcCbK5Q4FyQ+HpEGyfuafyr4e4qkmImOeYgy
         H4fGQa4fvB/LQeYDRnW2JXOTL3nSEu2dKl3LMhLU6rUlYOkySGFmBnhMvhpE03cBg9IC
         B7Ojj2GAd7RtJTS+pTUNEq/AmbwgXFSsiDrfef3dN8cAJvt5nCY3EP4pyE4IXWZzsbFA
         CO/ze1cpxr1GhNKZ0B8tLCNSAQyz/ucx/t/vhLMNK1YEoWWbx0eIuWE7Dit9mxXElj3b
         W0bHC8TIYvF/ifMsms7IVKStbo69Al8Q3mk89CuxxOajN1QbO8rQvCsamIhAlUmApM7R
         oY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723600593; x=1724205393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8G2fruqv1n9Ss0goXxvFPeqf2LkkBVMKwQASCzStoE8=;
        b=ZJ2Ozi1YI644ffIzPseSE1kXbcnGv9OiEtLwBd338gP5s27tmN5L31OQBvOI4pBalj
         fZycVak2biadx3hJOaDEXnbF1mo8lWhTSOQ4fy6PrDa8HLsKoXbNbPZqDvaejYn0JLiC
         WRWGFh7oI3WtgemDF0JUecZKk/wTKNKLsHGGQEetqwaz82qZmaaWcRRMlOf9jSbNQaAQ
         sWS4o5OI/jwXFl08255DsVm/2CwzunQ0WnHmnxTUMvkgRkFizQOF/wW+foWtPsm9zBXF
         M3FLzuey+NY+aAA6YS2jzocK+94svAYoH+UuYo86vR/hoUUwaZ3jZ1hxDEmf4/k8mF1v
         favQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0Xq8itb8bg7fRYHQeJj7xix/enlsokA+WNRNOHx99JvoAriXX1IPrLLeQvSV86Du2+ME2aJM3aO2mfDfhr0f8yBO7KMMhg4c=
X-Gm-Message-State: AOJu0Yzd3Fq7lU6vU1pUeQN0e7PWD/WdJz4zMRdzLfbnHn7IC2M9paDj
	/7VBm1F+JY5RAktFZkvf2xnT8lsEt9XwBa0PFXeU8XAvRDxtUsA+6m5WYkDM+YXQBajPOFy1fh/
	qByj+9r3nIOYEMWEdXBKgd+iZ5EHR/Oexi+SyZw==
X-Google-Smtp-Source: AGHT+IHWd0hlYEzs1C0Rh4miYN64b3wfj+uxdiVNOaHT0Q4lb9gQ1EiBX8uTVfyO3Lpanaly7QaJ+Ovil84n/B1I3x4=
X-Received: by 2002:a05:6871:e014:b0:268:79bd:9edb with SMTP id
 586e51a60fabf-26fe5c707b0mr1653171fac.47.1723600592963; Tue, 13 Aug 2024
 18:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813081324.3205944-1-nick.hu@sifive.com> <CAAhSdy0W5mSVp79dF63BJkDCE_tMxrxWOxqwaTHghztX6dEm2w@mail.gmail.com>
In-Reply-To: <CAAhSdy0W5mSVp79dF63BJkDCE_tMxrxWOxqwaTHghztX6dEm2w@mail.gmail.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Wed, 14 Aug 2024 09:56:22 +0800
Message-ID: <CAKddAkAOUJSnM=Px-YO=U6pis_7mODHZbmYqcgEzXikriqYvXQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Allow cpuidle pd used by other devices
To: Anup Patel <anup@brainfault.org>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	greentime.hu@sifive.com, zong.li@sifive.com, 
	Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anup

Thanks for your feedback!

On Tue, Aug 13, 2024 at 8:25=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> On Tue, Aug 13, 2024 at 1:43=E2=80=AFPM Nick Hu <nick.hu@sifive.com> wrot=
e:
> >
> > To prevent the probe of consumer devices being deferred, create the
> > platform devices for each pd node under '/cpus/power-domains' and move =
the
> > driver initailization to the arch_initcall.
>
> To prevent the probe deferral of consumer devices, you can simply use
> fwnode_dev_initialized() instead of creating a dummy platform device.
>
You are right. I'll remove the dummy platform device.
If the fwnode_dev_initialized() was done before
fw_devlink_create_devlink(), the link will be dropped.
The fwnode_dev_initialized() is already included in the
of_genpd_add_provider_simple() and If the fwnode_dev_initialized()
was done before fw_devlink_create_devlink(), the link will be dropped.
so I think we only need to move the driver initialization
to the arch_initcall.
Thanks!

> > The consumer devices that inside the cpu/cluster power domain may regis=
ter
> > the genpd notifier where their power domains are point to the pd nodes
> > under '/cpus/power-domains'. If the cpuidle.off=3D=3D1, the genpd notif=
ier
> > will fail due to sbi_cpuidle_pd_allow_domain_state is not set. We also
> > need the sbi_cpuidle_cpuhp_up/down to invoke the callbacks. Therefore,
> > add a cpuidle_disabled() check before registering the cpuidle driver to
> > address the issue.
>
> I think dealing with cpuidle.off=3D=3D1 case should be a separate patch.
>
Sure, I'll update it in the next patch

> >
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > Link: https://lore.kernel.org/lkml/20240226065113.1690534-1-nick.hu@sif=
ive.com/
> > Suggested-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/cpuidle/cpuidle-riscv-sbi.c | 24 +++++++++++++++++++++---
> >  1 file changed, 21 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpui=
dle-riscv-sbi.c
> > index a6e123dfe394..d6b01fc64f94 100644
> > --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> > +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/of_platform.h>
> >  #include <linux/slab.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_domain.h>
> > @@ -25,6 +26,7 @@
> >  #include <asm/smp.h>
> >  #include <asm/suspend.h>
> >
> > +#include "cpuidle.h"
> >  #include "dt_idle_states.h"
> >  #include "dt_idle_genpd.h"
> >
> > @@ -336,6 +338,9 @@ static int sbi_cpuidle_init_cpu(struct device *dev,=
 int cpu)
> >                 return ret;
> >         }
> >
> > +       if (cpuidle_disabled())
> > +               return 0;
> > +
> >         ret =3D cpuidle_register(drv, NULL);
> >         if (ret)
> >                 goto deinit;
> > @@ -380,20 +385,26 @@ static int sbi_cpuidle_pd_power_off(struct generi=
c_pm_domain *pd)
> >  struct sbi_pd_provider {
> >         struct list_head link;
> >         struct device_node *node;
> > +       struct platform_device *pdev;
> >  };
> >
> >  static LIST_HEAD(sbi_pd_providers);
> >
> >  static int sbi_pd_init(struct device_node *np)
> >  {
> > +       struct platform_device *pdev;
> >         struct generic_pm_domain *pd;
> >         struct sbi_pd_provider *pd_provider;
> >         struct dev_power_governor *pd_gov;
> >         int ret =3D -ENOMEM;
> >
> > +       pdev =3D of_platform_device_create(np, np->name, NULL);
> > +       if (!pdev)
> > +               goto out;
> > +
> >         pd =3D dt_idle_pd_alloc(np, sbi_dt_parse_state_node);
> >         if (!pd)
> > -               goto out;
> > +               goto free_pdev;
> >
> >         pd_provider =3D kzalloc(sizeof(*pd_provider), GFP_KERNEL);
> >         if (!pd_provider)
> > @@ -419,6 +430,7 @@ static int sbi_pd_init(struct device_node *np)
> >                 goto remove_pd;
> >
> >         pd_provider->node =3D of_node_get(np);
> > +       pd_provider->pdev =3D pdev;
> >         list_add(&pd_provider->link, &sbi_pd_providers);
> >
> >         pr_debug("init PM domain %s\n", pd->name);
> > @@ -430,6 +442,8 @@ static int sbi_pd_init(struct device_node *np)
> >         kfree(pd_provider);
> >  free_pd:
> >         dt_idle_pd_free(pd);
> > +free_pdev:
> > +       of_platform_device_destroy(&pdev->dev, NULL);
> >  out:
> >         pr_err("failed to init PM domain ret=3D%d %pOF\n", ret, np);
> >         return ret;
> > @@ -447,6 +461,7 @@ static void sbi_pd_remove(void)
> >                 if (!IS_ERR(genpd))
> >                         kfree(genpd);
> >
> > +               of_platform_device_destroy(&pd_provider->pdev->dev, NUL=
L);
> >                 of_node_put(pd_provider->node);
> >                 list_del(&pd_provider->link);
> >                 kfree(pd_provider);
> > @@ -548,7 +563,10 @@ static int sbi_cpuidle_probe(struct platform_devic=
e *pdev)
> >         /* Setup CPU hotplut notifiers */
> >         sbi_idle_init_cpuhp();
> >
> > -       pr_info("idle driver registered for all CPUs\n");
> > +       if (cpuidle_disabled())
> > +               pr_info("cpuidle is disabled\n");
> > +       else
> > +               pr_info("idle driver registered for all CPUs\n");
> >
> >         return 0;
> >
> > @@ -592,4 +610,4 @@ static int __init sbi_cpuidle_init(void)
> >
> >         return 0;
> >  }
> > -device_initcall(sbi_cpuidle_init);
> > +arch_initcall(sbi_cpuidle_init);
> > --
> > 2.34.1
> >
>
> Regards,
> Anup

Regards,
Nick

