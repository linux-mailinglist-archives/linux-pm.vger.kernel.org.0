Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AAE3A1140
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 12:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbhFIKi7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 06:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236517AbhFIKi6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 06:38:58 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B741C061760
        for <linux-pm@vger.kernel.org>; Wed,  9 Jun 2021 03:37:04 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso3935015wmi.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Jun 2021 03:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rYodVtyswGkxjPZ1N4VGwVug/p/tXWlRC7vMIsTSrBI=;
        b=bPJatgBr7cf/n/nozcV2QXkJ6KuYcmc76wQhAXvk8Hq+0jiCf6/weX5BvAxYuOgBWL
         tWw35amLPl4/ErMRBcCXdpHGnDsivP8d9+T96WJsPIFQQuvwIwuFoyuH2TlXYHmZ2ekD
         ZHqceoPEjeLEw6zJEJ06j9uYxHOY54DttYbKMAdqmOlbIrAWgymewLD+n551uHTZtvzs
         sOjOc8+zgOxmMeABVYyDzKOSdJcSU9UhkbnQi+/fvmYNGPmcUMs04w8EC+rjHzLRf0ns
         4vQ2+Re0/hFuAliL64jRfAkIloDs4EoP1BMiVF3mO1y7nPY5SiFjRYqqgQMKjLc0z6Y9
         jWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rYodVtyswGkxjPZ1N4VGwVug/p/tXWlRC7vMIsTSrBI=;
        b=dq/t+YS3pkF/QeASu/He8UxxXieSP5Dd/A9tnj6/bxbGRF/BnhF4UsQqYSkFk0esFy
         iGkmfpgMGPfhtbsVCcO/gM/9uqI015bO/StnkfyXOzWjcjNz1opxGuHYqgjW5q+1bGYW
         VXf5rInkKOCBUddPvy85KXBm0m3mnyiscbQqD8WiTbt54e03HkwqOBFicb23v6OnKQbm
         pcxTt/rP83vGbO5FlD0YGUi+VET4l8uOaE5CPa94oqhTKMM9I7hRQPbOIoOK7s+auYfM
         h/znvFr7GlNIu2BJAdW7zy3tZtj8tlGvVN30nNzHSIF1TDGMAGzwbPnyc0lBDQQ5NQa2
         ta+g==
X-Gm-Message-State: AOAM533TBPdnl1YHiHZPQwq5iuGdlGHq0+nKs4b3sDuB9ZE1tGLH7SiE
        r3xUT7HVSa1nKRGj9Z77W3CkqcTAJWR3M/7wl+erkQ==
X-Google-Smtp-Source: ABdhPJwOxSjrqbtXWi10C+dUk2jqM3x4JRkuQ+gY4Ec5hihOhUwkVNAF+kUVfPzxoPSu0goTPjfOIV7UIM3SddRgI/Q=
X-Received: by 2002:a05:600c:4ec7:: with SMTP id g7mr13233266wmq.157.1623235022430;
 Wed, 09 Jun 2021 03:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210602112321.2241566-1-anup.patel@wdc.com> <20210602112321.2241566-7-anup.patel@wdc.com>
 <26cddfa8-75e2-7b5b-1a47-e01cc1c7821e@sholland.org>
In-Reply-To: <26cddfa8-75e2-7b5b-1a47-e01cc1c7821e@sholland.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 9 Jun 2021 16:06:51 +0530
Message-ID: <CAAhSdy3jKY_48bFCSyzCcJ8kW=aERNEjBRz=5GEasefuN3Bydw@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] cpuidle: Add RISC-V SBI CPU idle driver
To:     Samuel Holland <samuel@sholland.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 7, 2021 at 12:09 AM Samuel Holland <samuel@sholland.org> wrote:
>
> On 6/2/21 6:23 AM, Anup Patel wrote:
> > The RISC-V SBI HSM extension provides HSM suspend call which can
> > be used by Linux RISC-V to enter platform specific low-power state.
> >
> > This patch adds a CPU idle driver based on RISC-V SBI calls which
> > will populate idle states from device tree and use SBI calls to
> > entry these idle states.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  MAINTAINERS                   |   7 +
> >  drivers/cpuidle/Kconfig       |   5 +
> >  drivers/cpuidle/Kconfig.riscv |  15 +
> >  drivers/cpuidle/Makefile      |   4 +
> >  drivers/cpuidle/cpuidle-sbi.c | 626 ++++++++++++++++++++++++++++++++++
> >  5 files changed, 657 insertions(+)
> >  create mode 100644 drivers/cpuidle/Kconfig.riscv
> >  create mode 100644 drivers/cpuidle/cpuidle-sbi.c
> >
> > ...
> > diff --git a/drivers/cpuidle/cpuidle-sbi.c b/drivers/cpuidle/cpuidle-sbi.c
> > new file mode 100644
> > index 000000000000..f743684d07de
> > --- /dev/null
> > +++ b/drivers/cpuidle/cpuidle-sbi.c
> > @@ -0,0 +1,626 @@
> > ...
> > +     /* Initialize idle states from DT. */
> > +     ret = sbi_cpuidle_dt_init_states(dev, drv, cpu, state_count);
> > +     if (ret) {
> > +             pr_err("HART%ld: failed to init idle states\n",
> > +                    cpuid_to_hartid_map(cpu));
> > +             return ret;
> > +     }
> > +
> > +     ret = cpuidle_register(drv, NULL);
> > +     if (ret)
> > +             goto deinit;
> > +
> > +     cpuidle_cooling_register(drv);
> > +
> > +     return 0;
> > +deinit:
> > +     sbi_cpuidle_deinit_cpu(cpu);
> > +     return ret;
> > +}
> > +
> > +static int sbi_cpuidle_pd_power_off(struct generic_pm_domain *pd)
>
> This function should be moved inside the CONFIG_DT_IDLE_GENPD block
> below. Otherwise it is defined but unused.

Indeed, sbi_cpuidle_pd_power_off() should be under
"#ifdef CONFIG_DT_IDLE_GENPD". I will update in the
next patch revision.

>
> > +{
> > +     struct genpd_power_state *state = &pd->states[pd->state_idx];
> > +     u32 *pd_state;
> > +
> > +     if (!state->data)
> > +             return 0;
> > +
> > +     if (!sbi_cpuidle_pd_allow_domain_state)
> > +             return -EBUSY;
> > +
> > +     /* OSI mode is enabled, set the corresponding domain state. */
> > +     pd_state = state->data;
> > +     sbi_set_domain_state(*pd_state);
> > +
> > +     return 0;
> > +}
> > +
> > +static void sbi_cpuidle_domain_sync_state(struct device *dev)
> > +{
> > +     /*
> > +      * All devices have now been attached/probed to the PM domain
> > +      * topology, hence it's fine to allow domain states to be picked.
> > +      */
> > +     sbi_cpuidle_pd_allow_domain_state = true;
> > +}
> > +
> > +#ifdef CONFIG_DT_IDLE_GENPD
> > +
> > +struct sbi_pd_provider {
> > +     struct list_head link;
> > +     struct device_node *node;
> > +};
> > +
> > +static LIST_HEAD(sbi_pd_providers);
> > +
> > +static int sbi_pd_init(struct device_node *np)
> > +{
> > +     struct generic_pm_domain *pd;
> > +     struct sbi_pd_provider *pd_provider;
> > +     struct dev_power_governor *pd_gov;
> > +     int ret = -ENOMEM, state_count = 0;
> > +
> > +     pd = dt_idle_pd_alloc(np, sbi_dt_parse_state_node);
> > +     if (!pd)
> > +             goto out;
> > ...

Regards,
Anup
