Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888743A0E61
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 10:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhFIIEy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 04:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbhFIIEH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 04:04:07 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056B9C06178B
        for <linux-pm@vger.kernel.org>; Wed,  9 Jun 2021 01:01:57 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v206-20020a1cded70000b02901a586d3fa23so3537250wmg.4
        for <linux-pm@vger.kernel.org>; Wed, 09 Jun 2021 01:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ju48vJplC/eqeHsAD3uNcfdCHg6qYZAOA8GhsxxsbGo=;
        b=RoJROVGx6pF3QoOuy/LW0b+B8pW4z/Gu8UsSrljkaodrIneT6aJ5VDM0xOo4QyIIzv
         Gj2yhqG8i/swO3l9mOI7UPStpX1mkoZb+9ZtFCrLBtHfdInHXO9DQzrqz6EnoBSCsDbJ
         CQyY7YdW8oig7+dPjOpzWmgH7zhMtk+yZskpmYk3+dOlc4KOXd1RxbP+Umt+54CUVZRm
         azXxGHY98MXetAA5dphBGr6CRGTv5bFOtfhkbMHOjIHtgKGknZuZd1qGV9narPBcUBvS
         wo8IGBL6tczovK1vv5CFCBG+VcQXdNaQ1n3muF+jV116E+phUJQoQ0NfkYF+TlXToFlL
         njGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ju48vJplC/eqeHsAD3uNcfdCHg6qYZAOA8GhsxxsbGo=;
        b=NLqJUQrPMtdpocF/Eu21sYwOUuNpGHV/Fl9quVqwTTPrXYl3qqLvBl1w0yBexnJh/4
         ru/DwGI+9YyLAAaQDLhnCaF0zLJQUweMpM9y+taQ+LeRyRu9LWR4CYlfZH1rDraixAKy
         BmHpHhVxcZv13Di+/WPV5GxrGIcf6IAL/ioaeIr7HvGWl0k9e7wmiZecvE02e+W7mNU+
         xrqyTH535TqFqWhED1rzexn45Pm9KWMFiwYyG19CXEoC1sveyjsWIFfuHLUQngXd/IH7
         Ua11IGaPzALbajNKYjzMaolzqE+2b/0ntSjreKmWFWS3QOk68Z41fYy4ucNeAl4oc3Wi
         igyA==
X-Gm-Message-State: AOAM531c9BVMYhygo8tRyVyqAOL+L5Vm2LAEgAAnP1Y3NnwB4NbqAAE9
        Bgq4WhIGtYihyIguepr+4c0T38gubZOA61k0kXdEkw==
X-Google-Smtp-Source: ABdhPJwCl3qJZm5Z606JSaosHKIbg85Mj+Z7FrvUrA4ecB82gMzqX8XkomV2Nv0hp9Jl1/jpfn0HzS95ejA1SCogr7s=
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr26760837wmj.134.1623225715467;
 Wed, 09 Jun 2021 01:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210602112321.2241566-1-anup.patel@wdc.com> <20210602112321.2241566-6-anup.patel@wdc.com>
 <82217630-5f89-50dc-bbca-e591bee90950@sholland.org>
In-Reply-To: <82217630-5f89-50dc-bbca-e591bee90950@sholland.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 9 Jun 2021 13:31:44 +0530
Message-ID: <CAAhSdy1D4HnHuuC0Da-rvia5-o3TaCUapTHb-HsBCQ9X6y-AiQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] cpuidle: Factor-out power domain related code from
 PSCI domain driver
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
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 7, 2021 at 12:04 AM Samuel Holland <samuel@sholland.org> wrote:
>
> On 6/2/21 6:23 AM, Anup Patel wrote:
> > The generic power domain related code in PSCI domain driver is largely
> > independent of PSCI and can be shared with RISC-V SBI domain driver
> > hence we factor-out this code into dt_idle_genpd.c and dt_idle_genpd.h.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  MAINTAINERS                           |   7 +
> >  drivers/cpuidle/Kconfig               |   4 +
> >  drivers/cpuidle/Kconfig.arm           |   1 +
> >  drivers/cpuidle/Makefile              |   1 +
> >  drivers/cpuidle/cpuidle-psci-domain.c | 138 +------------------
> >  drivers/cpuidle/cpuidle-psci.h        |  15 ++-
> >  drivers/cpuidle/dt_idle_genpd.c       | 182 ++++++++++++++++++++++++++
> >  drivers/cpuidle/dt_idle_genpd.h       |  50 +++++++
> >  8 files changed, 263 insertions(+), 135 deletions(-)
> >  create mode 100644 drivers/cpuidle/dt_idle_genpd.c
> >  create mode 100644 drivers/cpuidle/dt_idle_genpd.h
> >
> ...
> > diff --git a/drivers/cpuidle/dt_idle_genpd.h b/drivers/cpuidle/dt_idle_genpd.h
> > new file mode 100644
> > index 000000000000..a8a3bad3cb7f
> > --- /dev/null
> > +++ b/drivers/cpuidle/dt_idle_genpd.h
> > @@ -0,0 +1,50 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __DT_IDLE_GENPD
> > +#define __DT_IDLE_GENPD
> > +
> > +struct device_node;
> > +struct generic_pm_domain;
> > +
> > +#ifdef CONFIG_DT_IDLE_GENPD
> > +
> > +void dt_idle_pd_free(struct generic_pm_domain *pd);
> > +
> > +struct generic_pm_domain *dt_idle_pd_alloc(struct device_node *np,
> > +                     int (*parse_state)(struct device_node *, u32 *));
> > +
> > +int dt_idle_pd_init_topology(struct device_node *np);
> > +
> > +struct device *dt_idle_attach_cpu(int cpu, const char *name);
> > +
> > +void dt_idle_detach_cpu(struct device *dev);
> > +
> > +#else
> > +
> > +static inline void dt_idle_pd_free(struct generic_pm_domain *pd)
> > +{
> > +}
> > +
> > +static inline struct generic_pm_domain *dt_idle_pd_alloc(
> > +                     struct device_node *np,
> > +                     int (*parse_state)(struct device_node *, u32 *));
>
> In file included from drivers/cpuidle/cpuidle-sbi.c:27:
> drivers/cpuidle/dt_idle_genpd.h:29:1: error: expected identifier or '('
> before '{' token
>    29 | {
>       | ^
>
> Looks like you have a stray semicolon here.

Okay, I will fix this in the next revision.

Regards,
Anup

>
> > +{
> > +     return NULL;
> > +}
> > +
> > +static inline int dt_idle_pd_init_topology(struct device_node *np)
> > +{
> > +     return 0;
> > +}
> > +
> > +static inline struct device *dt_idle_attach_cpu(int cpu, const char *name)
> > +{
> > +     return NULL;
> > +}
> > +
> > +static inline void dt_idle_detach_cpu(struct device *dev)
> > +{
> > +}
> > +
> > +#endif
> > +
> > +#endif
> >
>
