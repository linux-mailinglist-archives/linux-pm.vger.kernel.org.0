Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC08E38CF
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2019 18:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407988AbfJXQsU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 12:48:20 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41077 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405516AbfJXQsU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 12:48:20 -0400
Received: by mail-ua1-f66.google.com with SMTP id l13so7363996uap.8
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2019 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z4Vvz4A4TSFl81zQLuVmP6KhRZpu2qJ/W4bi+0a71ME=;
        b=zppJNNtN+F05YFlhGDSJfbwNtesfGhVK0aYpmAwDE6hLl9xdOGlhX7f6PQCpqlvrnz
         8LwdcrJKfHHYhlEtiiUaleP6i94XwuI4bXkTxWVeReqfiFqMOvJl08O/5DZbF+cg7YLA
         Lud75vYhsbBZJtMAnpwqdp0QhcS1gCZTJd68whc+qJ06CuevlbGYCxnW0Z0SspM5aGNV
         IQD6GMYalS1U+imo+FSHi47837uauQkqMr3FM9fbTsZSlDCm6LcZ3vU7l4arKzK4hbwf
         4o3qAYpKuEhg4Jj/hGwGg6mj/30eZzPZe5fn8KnHwbx4w6Q3gwUa2orzq3v2IbtKDDHj
         5LBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4Vvz4A4TSFl81zQLuVmP6KhRZpu2qJ/W4bi+0a71ME=;
        b=M/UATgwazL54KbZb39JI5ous08wiJKdRHGStzS5sLylFwp1NzTKGm5Hyt3k5DLFB9y
         8As+sJsE/hix5vh0xwgD7AW1Dsm7FQ/wyZ/tjRe4mJIrdg5qcjp9wp/XinYAA5ZBOA5w
         VYT9lQ4MIQU1rBIOHVfJ1kmJa4tjtQKoMOI9+wl9aQ+FxAaQhx6l6VR3RljHNXpLyXpP
         JbXGJS3nVtO3QV2NuiRzOrP8WGv1eyTxuFVDiauxZGoQAHGvKPYYdWGZacVzpODHMc4R
         h6N3TR8FhVHVHQ7XO6QuI8aFyBZrSYcimtWpFYr6D46nKE0ZB4MHVG0IZaoWiW5nJROT
         2QVQ==
X-Gm-Message-State: APjAAAWoIXlc4lzR7qyyAgV0vjPaUTNC+iV5TgZtlfVGm+BOQ4IiQIE/
        g1wHmAXdG9vPl1fkllbi6cXHlBTQcsvZ6EgGMKP0oQ==
X-Google-Smtp-Source: APXvYqwd0vnOqB8MMiy1SJz3YktZErKuqpHA+NezQYiNfpLZoIsrkA7Os4037evpJM9MYpBSH0VE7UApzHWsQObxyNU=
X-Received: by 2002:ab0:331a:: with SMTP id r26mr9644172uao.104.1571935699420;
 Thu, 24 Oct 2019 09:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
 <20191010113937.15962-11-ulf.hansson@linaro.org> <20191024163117.GB22036@bogus>
In-Reply-To: <20191024163117.GB22036@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Oct 2019 18:47:43 +0200
Message-ID: <CAPDyKFo2Fma1_JMSd39bmQ3X1PV4SmQ0AfEuKyX5KLLe83ycmA@mail.gmail.com>
Subject: Re: [PATCH 10/13] cpuidle: psci: Add a helper to attach a CPU to its
 PM domain
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
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 24 Oct 2019 at 18:31, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Oct 10, 2019 at 01:39:34PM +0200, Ulf Hansson wrote:
> > Introduce a PSCI DT helper function, psci_dt_attach_cpu(), which takes a
> > CPU number as an in-parameter and tries to attach the CPU's struct device
> > to its corresponding PM domain.
> >
> > Let's makes use of dev_pm_domain_attach_by_name(), as it allows us to
> > specify "psci" as the "name" of the PM domain to attach to. Additionally,
> > let's also prepare the attached device to be power managed via runtime PM.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/cpuidle/cpuidle-psci-domain.c | 21 +++++++++++++++++++++
> >  drivers/cpuidle/cpuidle-psci.h        |  6 ++++++
> >  2 files changed, 27 insertions(+)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > index 3f5143ccc3e0..7429fd7626a1 100644
> > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > @@ -9,9 +9,11 @@
> >
> >  #define pr_fmt(fmt) "CPUidle PSCI: " fmt
> >
> > +#include <linux/cpu.h>
> >  #include <linux/device.h>
> >  #include <linux/kernel.h>
> >  #include <linux/pm_domain.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/psci.h>
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> > @@ -279,3 +281,22 @@ static int __init psci_idle_init_domains(void)
> >       return ret;
> >  }
> >  subsys_initcall(psci_idle_init_domains);
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
> This clarifies the need for the fixed name. But why not just go by index 0
> as the consumer of these psci power-domains will have only one power domain
> entry. Why do we need this name compulsory ?

The idea is to be future proof. If I recall correctly, the CPU node on
some QCOM SoCs may also have "CPR" PM domain specified, thus
"multiple" power-domains could be specified.

In any case, using "psci" doesn't really hurt, right?

> Further, it's specified as
> optional in the generic binding, do we make it "required" for this psci
> idle states binding anywhere that I missed ?

Good point! Unless you tell me differently, I will update the DT doc
to clarify this is "required".

Kind regards
Uffe
