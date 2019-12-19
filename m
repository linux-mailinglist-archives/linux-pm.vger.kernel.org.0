Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE300126615
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 16:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfLSPtR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 10:49:17 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42886 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfLSPtQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 10:49:16 -0500
Received: by mail-vs1-f65.google.com with SMTP id b79so4042033vsd.9
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 07:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIlvjsCfvOmlWRqcCAgvunomP0l6HJEE+6R+mmb5zvI=;
        b=qVU+p5owBD89IXyp4SeaCkLgA2uno2/z4M+x+sJ9cez3hAfckODxSZkc8dG/x35LTV
         qeUuRYR9b+sowa7ESvh6IIxVB3TJMlaF6GXo1PISp0Rn2RjP6wQONG6Yrfib/NhUKq6x
         1KFqpgSfYB2fnnSDsRcsOGe8QoisLZVYUYWVXI70tm/bUe2TvXDnetE4yyvT/ryuDT/+
         3v8QoZVRvWlJUoU3yBmJoiBhMoWfLlHwLguo7NM2Egqt8ubNHKHCvQQDS3TKTS1Z1KhK
         1g93Tp71O9xAckz+v3lgzWwrCHAB8LVF5aL4EN3o7RFVkyvWyoK9PtVJrGimWHS5meGd
         2bJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIlvjsCfvOmlWRqcCAgvunomP0l6HJEE+6R+mmb5zvI=;
        b=eENjMBhpTIzXwEnf5loC2ufALUdLvtWQaAVRPdsd73IGJLv0bewSfquecySufsIgZn
         2HLSkQzE35KyUa2YrruYS1/CbVSwzF+9IaUJTJwYZsWIRHGq6qEmITRLFm7XrkYjwNiM
         BwvP7o8ZlgWze90aaqhptZZL43a5WeU3EN5jX5BA07ozzqG7xSKaAgih9JF+zWa5y0Eo
         /UV9DBjs4fxLyUm+8iil2mg+EtQ/hRa1wwvanVQACBpyUC5Aj/cotB+Cxa+J1tjnDt7n
         V2U55e/AGTk07JL0/75eHns+FehQ0jhyFHhRXigJ0v8tdYUrEfR0Txytyb68+oTfoin4
         e9Vw==
X-Gm-Message-State: APjAAAWELaA5oH7zTx1bzdlxul/D7Vp7AAdqMi/wPBpqWCg6lR3mDUNc
        twF5KUH263kSw4lsG8hAtkRISM7KBJTN4Lv1wk/2hg==
X-Google-Smtp-Source: APXvYqzCqEbI+NKtJQ1BzInOGzQQCfldsdLXyDdQEcF1rJlw+/hvaFTgBJHXAJhAg5pCi0ZHks4z70YDpdY0iacWdbo=
X-Received: by 2002:a05:6102:5d1:: with SMTP id v17mr5154086vsf.200.1576770555650;
 Thu, 19 Dec 2019 07:49:15 -0800 (PST)
MIME-Version: 1.0
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
 <20191211154343.29765-14-ulf.hansson@linaro.org> <20191219143427.GF20746@bogus>
In-Reply-To: <20191219143427.GF20746@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Dec 2019 16:48:39 +0100
Message-ID: <CAPDyKFpPmtXkP6LSNWBbfyTJowjQXF39_4LN5YEcDtW1BzVw-g@mail.gmail.com>
Subject: Re: [PATCH v4 13/14] cpuidle: psci: Add support for PM domains by
 using genpd
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
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

On Thu, 19 Dec 2019 at 15:34, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Dec 11, 2019 at 04:43:42PM +0100, Ulf Hansson wrote:
> > When the hierarchical CPU topology layout is used in DT and the PSCI OSI
> > mode is supported by the PSCI FW, let's initialize a corresponding PM
> > domain topology by using genpd. This enables a CPU and a group of CPUs,
> > when attached to the topology, to be power-managed accordingly.
> >
> > To trigger the attempt to initialize the genpd data structures let's use a
> > subsys_initcall, which should be early enough to allow CPUs, but also other
> > devices to be attached.
> >
> > The initialization consists of parsing the PSCI OF node for the topology
> > and the "domain idle states" DT bindings. In case the idle states are
> > compatible with "domain-idle-state", the initialized genpd becomes
> > responsible of selecting an idle state for the PM domain, via assigning it
> > a genpd governor.
> >
> > Note that, a successful initialization of the genpd data structures, is
> > followed by a call to psci_set_osi_mode(), as to try to enable the OSI mode
> > in the PSCI FW. In case this fails, we fall back into a degraded mode
> > rather than bailing out and returning an error code.
> >
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v4:
> >       - None.
> >
> > ---
> >  drivers/cpuidle/cpuidle-psci-domain.c | 267 ++++++++++++++++++++++++++
> >  drivers/cpuidle/cpuidle-psci.c        |   4 +-
> >  drivers/cpuidle/cpuidle-psci.h        |   5 +
> >  3 files changed, 274 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > index 656ef3d59149..c2f94ba42222 100644
> > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > @@ -7,14 +7,281 @@
> >   *
> >   */
> >
> > +#define pr_fmt(fmt) "CPUidle PSCI: " fmt
> > +
> >  #include <linux/cpu.h>
> >  #include <linux/device.h>
> >  #include <linux/kernel.h>
> >  #include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/psci.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> >
> >  #include "cpuidle-psci.h"
> >
> > +struct psci_pd_provider {
> > +     struct list_head link;
> > +     struct device_node *node;
> > +};
> > +
> > +static LIST_HEAD(psci_pd_providers);
> > +static bool osi_mode_enabled;
> > +
> > +static int psci_pd_power_off(struct generic_pm_domain *pd)
> > +{
> > +     struct genpd_power_state *state = &pd->states[pd->state_idx];
> > +     u32 *pd_state;
> > +
> > +     /* If we have failed to enable OSI mode, then abort power off. */
> > +     if (!osi_mode_enabled)
> > +             return -EBUSY;
> > +
>
> Why is above check needed ? Shouldn't we have disable/remove pd of
> OSI is not enabled ?

Well, failing to enable OSI should in practice not happen, while it
theoretically it could.

My approach to this has been to fall back to use a "degraded mode",
which seems quite common for these kind of situations. The degraded
mode means, we are preventing domain states from being used.

More importantly, it also keeps the code registering the PM domains, a
bit simpler.

>
> > +     if (!state->data)
> > +             return 0;
> > +
> > +     /* OSI mode is enabled, set the corresponding domain state. */
> > +     pd_state = state->data;
> > +     psci_set_domain_state(*pd_state);
> > +
> > +     return 0;
> > +}
> > +
>
> [...]
>
> > +static const struct of_device_id psci_of_match[] __initconst = {
> > +     { .compatible = "arm,psci" },
>
> I think we can drop the above one as it's for v0.1 which didn't support
> OSI.

Yeah, I do that.

>
> > +     { .compatible = "arm,psci-0.2" },
> > +     { .compatible = "arm,psci-1.0" },
> > +     {}
> > +};
> > +
> > +static int __init psci_idle_init_domains(void)
> > +{
> > +     struct device_node *np = of_find_matching_node(NULL, psci_of_match);
> > +     struct device_node *node;
> > +     int ret = 0, pd_count = 0;
> > +
> > +     if (!np)
> > +             return -ENODEV;
> > +
> > +     /* Currently limit the hierarchical topology to be used in OSI mode. */
> > +     if (!psci_has_osi_support())
> > +             goto out;
> > +
> > +     /*
> > +      * Parse child nodes for the "#power-domain-cells" property and
> > +      * initialize a genpd/genpd-of-provider pair when it's found.
> > +      */
> > +     for_each_child_of_node(np, node) {
> > +             if (!of_find_property(node, "#power-domain-cells", NULL))
> > +                     continue;
> > +
> > +             ret = psci_pd_init(node);
> > +             if (ret)
> > +                     goto put_node;
> > +
> > +             pd_count++;
> > +     }
> > +
> > +     /* Bail out if not using the hierarchical CPU topology. */
> > +     if (!pd_count)
> > +             goto out;
> > +
> > +     /* Link genpd masters/subdomains to model the CPU topology. */
> > +     ret = psci_pd_init_topology(np);
> > +     if (ret)
> > +             goto remove_pd;
> > +
> > +     /* Try to enable OSI mode. */
> > +     ret = psci_set_osi_mode();
> > +     if (ret)
> > +             pr_warn("failed to enable OSI mode: %d\n", ret);
>
> Same question as above: shouldn't we disable and goto remove_pd ?

See my answer above. Does it satisfy your concern?

If so, may I add your reviewed-by tag, for the next re-spin when I
have removed one of the compatible strings?

Kind regards
Uffe
