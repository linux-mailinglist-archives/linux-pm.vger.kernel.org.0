Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46CD110059B
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 13:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfKRM3H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 07:29:07 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:45309 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfKRM3H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 07:29:07 -0500
Received: by mail-vk1-f193.google.com with SMTP id s4so1883285vkk.12
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2019 04:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U/Dzry7dkP8u9lgjMIg9ewtJsEx1dOyW/4RrZyMxcwg=;
        b=BwopXKkvUAS0EsnuPjioJ+LUEnpqkyiTJbK+tzbwnWZ0QyXSFXcw6+wZo/RWOI15OP
         bLQ5seVn7kEWfk3jqwjl8aznVCVYDr3gZrnAY88ZigjS379xYGIwMwgxZrwi5c7XBnRd
         R1qgFS4vJ/rjrCBcpolaaitww7T6o3FADj118wcn9mwW9O6xYk3th1Dp32SnEa8KRUMI
         gQV/QKhOo9F0FDGv5BY3bMTzrntVQeA/KPqMdNvLRJ5itgB7g9TAdYnz+bLzcdSFHv9o
         jc5C/hywJxJXHL0Qtyv3Jgnzwo4gmR2UBCwhRLfiADd61Fmed1fj/Q2BwX9i8IlcxJw6
         XPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U/Dzry7dkP8u9lgjMIg9ewtJsEx1dOyW/4RrZyMxcwg=;
        b=fYpl/drzHaGTjWhQ1QaRHrO2/DupMAuUa2I2R4jH83dEnISFWbGJaLmRlMX8hZnzZu
         XupiJMclFy6RhzIas4axReMqH9oG2WXMOX6jXvQn6n5g/gkagJj5BSYMmvH/DNjn73Um
         Ms9UeSsJMH8GshNCQQsxOerpD49+uUihDX23lBjJpqFKJCCSROk2ndc5+ipfFLr0q73Y
         ec3bYCtI+YBAELb1zlNbQs/8mOBNpxYbzQ8eTKhNGTiOfEhH4sPaMj/pFOXPvsgjDswE
         6yKqFQH/0k8QOShyx1A8pHYdcGJ03qNDjTTk28+pYvURz5zR0Ybn58KrWCevDvWxpJJK
         8nIw==
X-Gm-Message-State: APjAAAXo50LZTCGCXI4TUISBBw5HrQEvA+NnGz7CWCbPd1Af53PGEtV3
        rhEeBH97QmYSI8g51DmlbCG3CnBQ0pq1AQ1JGvXTHg==
X-Google-Smtp-Source: APXvYqz4jVOHFzimlFTeSKI08BoNNlhIhBV2zNSqr4gbAhvZZ0RFr2YfD9/jeZsJ45egP1Vtmo5ZajRTJswbmlREPO4=
X-Received: by 2002:ac5:cd47:: with SMTP id n7mr8716291vkm.101.1574080146192;
 Mon, 18 Nov 2019 04:29:06 -0800 (PST)
MIME-Version: 1.0
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
 <20191029164438.17012-9-ulf.hansson@linaro.org> <20191115171336.GC27170@bogus>
In-Reply-To: <20191115171336.GC27170@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Nov 2019 13:28:29 +0100
Message-ID: <CAPDyKFoqOPg_kfVTuENSh-m-cW_6M1H4Ma8=8dgPvK8_w4addw@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] cpuidle: psci: Add a helper to attach a CPU to
 its PM domain
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
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

On Fri, 15 Nov 2019 at 18:13, Sudeep Holla <sudeep.holla@arm.com> wrote:
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
>
> This was super confusing for a minute until I noticed the difference
> between _ and - used here. I know such pattern is used in the kernel,
> just that it's difficult to notice on first go :)
>
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
> > +     if (IS_ERR_OR_NULL(dev))
> > +             return dev;
> > +
> > +     pm_runtime_irq_safe(dev);
> > +     if (cpu_online(cpu))
> > +             pm_runtime_get_sync(dev);
>
> I probably have to wait till I see the user of this, but until then I
> assume we have some way to deal with CPU HP machinery for this.

Yes, I discussed this with Lorenzo at LPC as well. I did not include a
patch in the series using a CPU HP, simply because I am targeting to
land the basic support first.

For now, this means that the "cluster" will remain on even if there
are CPUs being put offline.

>
> Other than that, it looks fine. I will get back to this to ack or with
> more questions as I review further.

Great, thanks!

Kind regards
Uffe
