Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6515A126610
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 16:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfLSPs6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 10:48:58 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35362 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfLSPs6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 10:48:58 -0500
Received: by mail-vs1-f68.google.com with SMTP id x123so4057040vsc.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 07:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1kaCXRwivzzZ0gDYQMxNb5fZvTKN4Drl/BBA8SeSbvk=;
        b=eJqmNR4yFeu1cbLSw2uG6FfugRqV5dKrxt2YHM9/D9gMpcABkEbswYB8eSaWcXntOS
         mbzjrlF4O2WmbzpBXute4ocZBEnBpbzA6iYMkzyKvI+SbBvchcUgGJBf7naGlw0opObr
         Y46WQiGzBy9SAfjvmPCjmgu7s1paeIAIkRgQj28RQUdH1fEnycR6Ld5+bUHwcj/+yRBT
         exdptdE4Lz73b68vBf2XsQ6q5pulrH8ik5cIQ78uzWYC7MxBF+XFn7DZND19tlp2/pXx
         S14ROpwyoKDClO+2CXDOhgR267n7rlVXK8wIkviSg/eYL8mbvcAGMc1ZHbyKQ/FNcKLC
         XbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1kaCXRwivzzZ0gDYQMxNb5fZvTKN4Drl/BBA8SeSbvk=;
        b=asNwbv4cv8RrD7LBH2KV2D5HfbKOilg8V3OaNamsHDxAKeKIjDw0YVgHtqukjSbYqa
         L3LZTxn9o4adGxZHh9l01CifUy2ZQX+n7cBX3Ciw9OEx6cGi3pI/1S3NOCUduoU0yq5U
         dIUfYaruRzaULA4R9009sW6COfeu+D7W3TdVtWZRNbe4oRPiktnmqLalqzN1rx7xrM5R
         EQ5MLQy1Fdk1thAmR5MeLCS6XmEEY/c9vaCm6uq4rHqNfsJ6mlc8rCpahsklLRqKUnCc
         IypuLBM7tD/rlkI//hp2fuYL3f4su4iwfDa5TaU4DuJSc92E7KolZhQ4ZN+LU6hLSO04
         SF5g==
X-Gm-Message-State: APjAAAXAkYTdIVlurTzOhKgCNC1X3CfHRR7bc4jUT/WNZ9PnsZQGKnDd
        08UwirZLPyp+xQ5k6w0h538xTPSDkQuhQLEuy62VkQ==
X-Google-Smtp-Source: APXvYqyEHXTOiaWT64UHyDsh1e5xkHNXkp6qXSMXSPXq6knbbWfOcCv0hWw8oxuY1uMAA0t2E6RRJdBwf/IgoNOzarc=
X-Received: by 2002:a67:f499:: with SMTP id o25mr5245791vsn.165.1576770537822;
 Thu, 19 Dec 2019 07:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
 <20191211154343.29765-13-ulf.hansson@linaro.org> <20191219143340.GE20746@bogus>
In-Reply-To: <20191219143340.GE20746@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Dec 2019 16:48:21 +0100
Message-ID: <CAPDyKFoayFW_gj5d=7q_YBVSRDEWRiqsKQj85D02EV7B7CWczg@mail.gmail.com>
Subject: Re: [PATCH v4 12/14] cpuidle: psci: Support CPU hotplug for the
 hierarchical model
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

On Thu, 19 Dec 2019 at 15:33, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Dec 11, 2019 at 04:43:41PM +0100, Ulf Hansson wrote:
> > When the hierarchical CPU topology is used and when a CPU is put offline,
> > that CPU prevents its PM domain from being powered off, which is because
> > genpd observes the corresponding attached device as being active from a
> > runtime PM point of view. Furthermore, any potential master PM domains are
> > also prevented from being powered off.
> >
> > To address this limitation, let's add add a new CPU hotplug state
> > (CPUHP_AP_CPU_PM_STARTING) and register up/down callbacks for it, which
> > allows us to deal with runtime PM accordingly.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v4:
> >       - Folded in the patch to be part of the series.
> >       - Rebased on top of earlier changes.
> >
> > ---
> >  drivers/cpuidle/cpuidle-psci.c | 45 +++++++++++++++++++++++++++++++++-
> >  include/linux/cpuhotplug.h     |  1 +
> >  2 files changed, 45 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > index 6e7804e697ed..34a89d99bb0f 100644
> > --- a/drivers/cpuidle/cpuidle-psci.c
> > +++ b/drivers/cpuidle/cpuidle-psci.c
> > @@ -8,6 +8,7 @@
> >
> >  #define pr_fmt(fmt) "CPUidle PSCI: " fmt
> >
> > +#include <linux/cpuhotplug.h>
> >  #include <linux/cpuidle.h>
> >  #include <linux/cpumask.h>
> >  #include <linux/cpu_pm.h>
> > @@ -31,6 +32,7 @@ struct psci_cpuidle_data {
> >
> >  static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
> >  static DEFINE_PER_CPU(u32, domain_state);
> > +static bool psci_cpuidle_use_cpuhp;
> >
>
> [...]
>
> > +
> > +static void psci_idle_init_cpuhp(void)
> > +{
>
> Can this be made __init along with the boolean psci_cpuidle_use_cpuhp ?

Yeah, make sense!

>
> With that,
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks!

Kind regards
Uffe
