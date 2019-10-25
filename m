Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DECEE4EB0
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 16:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfJYONn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Oct 2019 10:13:43 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44321 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390507AbfJYONn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Oct 2019 10:13:43 -0400
Received: by mail-vs1-f66.google.com with SMTP id j85so1520580vsd.11
        for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2019 07:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uN8HSzjVWYgOa/f9HwJLZghBIB5LPa4au9Qp6QOM0oM=;
        b=bYS+y1MXgMPSuAWl/Pw+O36xYjUIvDi9LmeppA4i16Ap9cInMC5v97zMSThnwOwkjG
         G2R98nKwmRhuQLaCxO9vrs2HbOTFJZHZpG7DrkUY3bH1pCHq/QbLn8lTKAwuLAgCKShc
         4ivCigJgcaIc1cTw4U/fd2FuRFK4kkU/nc6vWFttfGBxZtbBCdROsKcqDLrzGKbpvrUs
         77BYTPAlKpSIq/S808KRqib4oAz/cBtdSKIcr7wgp8/wJsiyzd1lZzk80W3RkhDiLuxF
         LFZwMV9dUXwKr9wD+9Im/C7HqsbimiepPkPgw5VR/iu5I87i7i4eo83eDqHqOUSvCQPR
         5bYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uN8HSzjVWYgOa/f9HwJLZghBIB5LPa4au9Qp6QOM0oM=;
        b=CADmu6gsraMP6YITTXpTXvzKPw8pSiSjZ9+b7qvpu9VlWGLPN+nuV3w5WTmpsWLvAl
         2Cxp3ZeQVQu4HfSKwS9r4MU9w8CbgxmVAaBTO+mZRdUdihLoKA7U/+lRyd9CXPLHvJuf
         9KP6gUsW55xGT3Id+AmQw83TSh8TAWGmhGMw2fn7nRWW/KVzx5AxNybC7ZpXRVE3XrGA
         qxUtGFRdCQYLirzNM8w2cHH0Nwd4ml2V30Z/PrxDhjjMXeiuNOqxjReS2wuTGCEE8L04
         wu6tw/+5JE4iQ5sNW6Rqc7fS2O7GhzdSFUCQnMiX7DKu3JAYYC7JlTh3EOLPvEBl6gFF
         dv4w==
X-Gm-Message-State: APjAAAUAYFHVx0/8NpiD3VWlTkroSy9v4taLDFQ13o0q3HiVA6tBqiRL
        8TN4QDtoyhyx/3sh5edy9NBU7GnBeZoWkIzib/qmPQ==
X-Google-Smtp-Source: APXvYqwYv7TgejqODhekRI9dDIIRnGtrb3/+jOe+VBk6FoXTRU0DV374nPjN0wfCLfVDZUOhMqwIhHhSA35PTnmR0zY=
X-Received: by 2002:a67:7ac5:: with SMTP id v188mr2030243vsc.191.1572012821656;
 Fri, 25 Oct 2019 07:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
 <20191010113937.15962-13-ulf.hansson@linaro.org> <20191024163257.GC22036@bogus>
 <CAPDyKFpwrfHj-az5x5dW92VAxi887FgWW6GKhfPv_kuj14TDjQ@mail.gmail.com> <20191025082852.GA4867@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191025082852.GA4867@e121166-lin.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 25 Oct 2019 16:13:05 +0200
Message-ID: <CAPDyKFqpSa6kudba-ezt07fDR=0d216KqYOTcW+5QPVa_DMrKA@mail.gmail.com>
Subject: Re: [PATCH 12/13] cpuidle: psci: Manage runtime PM in the idle path
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
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

On Fri, 25 Oct 2019 at 10:29, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Oct 24, 2019 at 07:00:38PM +0200, Ulf Hansson wrote:
> > On Thu, 24 Oct 2019 at 18:33, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Thu, Oct 10, 2019 at 01:39:36PM +0200, Ulf Hansson wrote:
> > > > In case we have succeeded to attach a CPU to its PM domain, let's deploy
> > > > runtime PM support for the corresponding attached device, to allow the CPU
> > > > to be powered-managed accordingly.
> > > >
> > > > To set the triggering point for when runtime PM reference counting should
> > > > be done, let's store the index of deepest idle state for the CPU in the per
> > > > CPU struct. Then use this index to compare the selected idle state index
> > > > when entering idle, as to understand whether runtime PM reference counting
> > > > is needed or not.
> > > >
> > > > Note that, from the hierarchical point view, there may be good reasons to
> > > > do runtime PM reference counting even on shallower idle states, but at this
> > > > point this isn't supported, mainly due to limitations set by the generic PM
> > > > domain.
> > > >
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >  drivers/cpuidle/cpuidle-psci.c | 21 +++++++++++++++++++--
> > > >  1 file changed, 19 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > > > index 1510422c7a53..0919b40c1a85 100644
> > > > --- a/drivers/cpuidle/cpuidle-psci.c
> > > > +++ b/drivers/cpuidle/cpuidle-psci.c
> > > > @@ -16,6 +16,7 @@
> > > >  #include <linux/of.h>
> > > >  #include <linux/of_device.h>
> > > >  #include <linux/psci.h>
> > > > +#include <linux/pm_runtime.h>
> > > >  #include <linux/slab.h>
> > > >
> > > >  #include <asm/cpuidle.h>
> > > > @@ -25,6 +26,7 @@
> > > >
> > > >  struct psci_cpuidle_data {
> > > >       u32 *psci_states;
> > > > +     u32 rpm_state_id;
> > > >       struct device *dev;
> > > >  };
> > > >
> > > > @@ -50,14 +52,28 @@ static int psci_enter_idle_state(struct cpuidle_device *dev,
> > > >                               struct cpuidle_driver *drv, int idx)
> > > >  {
> > > >       int ret;
> > > > -     u32 *states = __this_cpu_read(psci_cpuidle_data.psci_states);
> > > > -     u32 state = psci_get_domain_state();
> > > > +     struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
> > > > +     u32 *states = data->psci_states;
> > > > +     struct device *pd_dev = data->dev;
> > > > +     bool runtime_pm = (pd_dev && data->rpm_state_id == idx);
> > > > +     u32 state;
> > >
> > > Wonder if we can have separate psci_enter_idle_state for OSI mode so
> > > that all these runtime extra check can be reduced ? It will also make
> > > sure there's no additional latency for PC mode because of OSI.
> >
> > Good idea, that's the plan. See previous answer.
> >
> > Perhaps if I add a patch on top, implementing your suggestion, would
> > you be happy with that?
>
> Separating idle entry functions was the main idea behind moving PSCI
> CPUidle into drivers/cpuidle, I don't think that's complicated to
> change and given that the series is not queued yet we can make these
> changes in the series itself rather than on top.

Okay, no problem. I fold in a patch (or amend existing ones, if that
is better) into the series that addresses this.

Thanks for reviewing and enjoy your weekend!

Kind regards
Uffe
