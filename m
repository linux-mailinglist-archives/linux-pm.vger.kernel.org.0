Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1C7F2C12
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 11:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfKGKXD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 05:23:03 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40695 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfKGKXD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2019 05:23:03 -0500
Received: by mail-vs1-f66.google.com with SMTP id m9so927558vsq.7
        for <linux-pm@vger.kernel.org>; Thu, 07 Nov 2019 02:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klf1T6RBuB2EMHIc4Rj/8/h5XlKXIauPiGkAA0PQJHA=;
        b=KcZmcBA01wjsArSslzWd0PcZKG5+oUh1YvoGSRLuorbgBtw8eQnaVjTKqr4FIjIgX7
         QWKTyjkc2cyGpL33feXncnUPzVYWwoyn7MIFRS8keHpk2uwuil1HrOs2Hu8QWAvBq3MJ
         FMY7P/utSM92pNef2sXoTwX1bpkEeb2XEK0ruARavfZPC15C/goMAfwjrPkIg4CtvhH3
         agADHSfHT5q7zZCZPWUHJeYeSaa6aOg0A2hfjkGfz52i+vm775zUbSQ7jS1QaP2k3hQr
         dNhlBens4XoPNq0D0yUFYdkpQQfJfbDmEhOYJXh5pmNxl9I2s8afDl0bgQdaqACLcbbb
         ZTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klf1T6RBuB2EMHIc4Rj/8/h5XlKXIauPiGkAA0PQJHA=;
        b=c97RO0LBp7KiSBvEceQaEH0ASgaMIXcU+OVQv9JJraFVSLV5D+DA3/8LJKwBrS7OGj
         QeyClQldSwLqRiOaWD20YGePIugl1t0C44t1psTyf2+sMT7D6k27nNl63VWW0Bq7xJAR
         CHwSBl8evGO7bz9liODUZKB4ebGoV91FlDodRdC9meA4k1nqamRd04rf5CTFXtLX8YyK
         2DzFdzB0QrE5Ejijhy+zIQA2QO1qRnmMT3eYpiOAtFGU3tM6pQXgA1nY/AgtYCcJZLnB
         Y4bUhZrD7PbNJ94HjtrLT5Dh6uquqN9HUDlIDzeHK2qwA02QNMXJ1eafGFleMtWzq11c
         q84g==
X-Gm-Message-State: APjAAAW4WSZoi9OrXKgpPwKCsxN7cMs9W/WDKv4bQY86+eHIqHI59uVw
        sa9YwOxJgIb/YK996RcdbMoFR823zl/z7Y+my0GnxQ==
X-Google-Smtp-Source: APXvYqy0f8eg9ePlHMjSmey5WM9znhvGExZSxWGU0F+oNb8FPRtEBPgEercA1k8qGYybSqNZ7bJQmgTaBUVOK2n9zzE=
X-Received: by 2002:a67:7ac5:: with SMTP id v188mr2229899vsc.191.1573122180217;
 Thu, 07 Nov 2019 02:23:00 -0800 (PST)
MIME-Version: 1.0
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
 <20191029164438.17012-9-ulf.hansson@linaro.org> <20191107091335.GA1914942@centauri.lan>
In-Reply-To: <20191107091335.GA1914942@centauri.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 Nov 2019 11:22:24 +0100
Message-ID: <CAPDyKFpaONqMa1OmULjo=XuyKg4gwd2yT3-b5i2oFLg306xasQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] cpuidle: psci: Add a helper to attach a CPU to
 its PM domain
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 7 Nov 2019 at 10:13, Niklas Cassel <niklas.cassel@linaro.org> wrote:
>
> On Tue, Oct 29, 2019 at 05:44:33PM +0100, Ulf Hansson wrote:
> > Introduce a PSCI DT helper function, psci_dt_attach_cpu(), which takes a
> > CPU number as an in-parameter and tries to attach the CPU's struct device
> > to its corresponding PM domain.
> >
> > Let's makes use of dev_pm_domain_attach_by_name(), as it allows us to
> > specify "psci" as the "name" of the PM domain to attach to. Additionally,
> > let's also prepare the attached device to be power managed via runtime PM.
> >
> > Note that, the implementation of the new helper function is in a new
> > separate c-file, which may seems a bit too much at this point. However,
> > subsequent changes that implements the remaining part of the PM domain
> > support for cpuidle-psci, helps to justify this split.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v2:
> >       - Reorder patch to be the first one that starts adding the PM domain
> >         support.
> >       - Rebased.
> >
> > ---
> >  drivers/cpuidle/Makefile              |  4 ++-
> >  drivers/cpuidle/cpuidle-psci-domain.c | 36 +++++++++++++++++++++++++++
> >  drivers/cpuidle/cpuidle-psci.h        | 12 +++++++++
> >  3 files changed, 51 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/cpuidle/cpuidle-psci-domain.c
> >  create mode 100644 drivers/cpuidle/cpuidle-psci.h
> >
> > diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> > index ee70d5cc5b99..cc8c769d7fa9 100644
> > --- a/drivers/cpuidle/Makefile
> > +++ b/drivers/cpuidle/Makefile
> > @@ -21,7 +21,9 @@ obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
> >  obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
> >  obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
> >  obj-$(CONFIG_ARM_CPUIDLE)            += cpuidle-arm.o
> > -obj-$(CONFIG_ARM_PSCI_CPUIDLE)               += cpuidle-psci.o
> > +obj-$(CONFIG_ARM_PSCI_CPUIDLE)               += cpuidle_psci.o
> > +cpuidle_psci-y                               := cpuidle-psci.o
> > +cpuidle_psci-$(CONFIG_PM_GENERIC_DOMAINS_OF) += cpuidle-psci-domain.o
> >
> >  ###############################################################################
> >  # MIPS drivers
> > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > new file mode 100644
> > index 000000000000..bc7df4dc0686
> > --- /dev/null
> > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > @@ -0,0 +1,36 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PM domains for CPUs via genpd - managed by cpuidle-psci.
> > + *
> > + * Copyright (C) 2019 Linaro Ltd.
> > + * Author: Ulf Hansson <ulf.hansson@linaro.org>
> > + *
> > + */
> > +
> > +#include <linux/cpu.h>
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/pm_domain.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/psci.h>
> > +
> > +#include "cpuidle-psci.h"
> > +
> > +struct device *psci_dt_attach_cpu(int cpu)
> > +{
> > +     struct device *dev;
> > +
> > +     /* Currently limit the hierarchical topology to be used in OSI mode. */
> > +     if (!psci_has_osi_support())
> > +             return NULL;
> > +
> > +     dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), "psci");
>
> Hello Ulf,
>
> here you use dev_pm_domain_attach_by_name(), which will call
> genpd_dev_pm_attach_by_name(), which will call genpd_dev_pm_attach_by_id(),
> which will call __genpd_dev_pm_attach(virt_dev, dev, index, false);
> the last argument is power_on, which here is always set to false.
>
> In older versions of your patch series, psci_dt_attach_cpu() called
> dev_pm_domain_attach(dev, true), where the last argument is power_on.
> Interestingly enough (for the non-ACPI case), dev_pm_domain_attach()
> ignores the power_on parameter, and simply calls genpd_dev_pm_attach(dev);
> which will call __genpd_dev_pm_attach(dev, dev, 0, true);
> the last argument is power_on, which here is always set to true.
>
> In other words, your previous patch series always powered on the power
> domain, while the newer versions do not. Is this change intentional?

Wow, thanks for an in-depth review!

Yes, the change is intentional.

If the device is attached via dev_pm_domain_attach(), genpd needs to
power on the PM domain, due to legacy reasons (from behaviours by
drivers/subsystem).

This isn't the case when the device is attached through
dev_pm_domain_attach_by_*(), as there is no legacy to care about.

> Perhaps psci_dt_attach_cpu() should call dev_to_genpd(dev)->power_on()
> after attaching the power domain? (In order to be consistent with the
> previous behavior of this patch series.)

After calling dev_pm_domain_attach_by_name, I am calling
pm_runtime_get_sync() if the cpu is online, which means the
corresponding genpd will be powered on - but then, only when actually
needed.

The old behaviour actually relied on the late_initcall
genpd_power_off_unused(), to power off the genpd, in case the CPU
device was offline.

In other words, the new behaviour is even slightly better. Does it make sense?

Kind regards
Uffe

>
>
> Kind regards,
> Niklas
>
> > +     if (IS_ERR_OR_NULL(dev))
> > +             return dev;
> > +
> > +     pm_runtime_irq_safe(dev);
> > +     if (cpu_online(cpu))
> > +             pm_runtime_get_sync(dev);
> > +
> > +     return dev;
> > +}
> > diff --git a/drivers/cpuidle/cpuidle-psci.h b/drivers/cpuidle/cpuidle-psci.h
> > new file mode 100644
> > index 000000000000..0cadbb71dc55
> > --- /dev/null
> > +++ b/drivers/cpuidle/cpuidle-psci.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __CPUIDLE_PSCI_H
> > +#define __CPUIDLE_PSCI_H
> > +
> > +#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
> > +struct device *psci_dt_attach_cpu(int cpu);
> > +#else
> > +static inline struct device *psci_dt_attach_cpu(int cpu) { return NULL; }
> > +#endif
> > +
> > +#endif /* __CPUIDLE_PSCI_H */
> > --
> > 2.17.1
> >
