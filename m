Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3488F10CE94
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 19:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfK1Sbw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 13:31:52 -0500
Received: from foss.arm.com ([217.140.110.172]:39690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfK1Sbv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 Nov 2019 13:31:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23E8F1FB;
        Thu, 28 Nov 2019 10:31:51 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 435DE3F6C4;
        Thu, 28 Nov 2019 10:31:49 -0800 (PST)
Date:   Thu, 28 Nov 2019 18:31:43 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
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
Subject: Re: [PATCH v3 08/13] cpuidle: psci: Add a helper to attach a CPU to
 its PM domain
Message-ID: <20191128183143.GA15793@e121166-lin.cambridge.arm.com>
References: <20191127102914.18729-1-ulf.hansson@linaro.org>
 <20191127102914.18729-9-ulf.hansson@linaro.org>
 <20191128141443.GA31123@e121166-lin.cambridge.arm.com>
 <CAPDyKFr1GTAkNyTmLvvC1ovm4yOtMGLOVWA-e-wjGJz2ENdN1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr1GTAkNyTmLvvC1ovm4yOtMGLOVWA-e-wjGJz2ENdN1g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 28, 2019 at 06:21:03PM +0100, Ulf Hansson wrote:
> On Thu, 28 Nov 2019 at 15:15, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Wed, Nov 27, 2019 at 11:29:09AM +0100, Ulf Hansson wrote:
> >
> > [...]
> >
> > > +struct device *psci_dt_attach_cpu(int cpu)
> > > +{
> > > +     struct device *dev;
> > > +
> > > +     /* Currently limit the hierarchical topology to be used in OSI mode. */
> > > +     if (!psci_has_osi_support())
> > > +             return NULL;
> > > +
> > > +     dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), "psci");
> > > +     if (IS_ERR_OR_NULL(dev))
> > > +             return dev;
> > > +
> > > +     pm_runtime_irq_safe(dev);
> > > +     if (cpu_online(cpu))
> >
> > It is unclear to me how we handle (or rather we don't) CPU hotplug
> > with this series - it does not look OK unless genpd code manages
> > that automatically.
> 
> The series doesn't handle CPU hotplug at the moment, simply because I
> am targeting to get the basic support, upstream first.

Basic support must work and that includes CPU hotplug - I don't want
to merge code that work with assumptions that aren't valid.

> For a functionality point of view, this isn't a problem in my opinion.
> Simply because the consequence is only that the idle states for the
> "cluster" will not be reached if there is a CPU brought offline.
> 
> As we talked about at LPC and as also told Sudeep for the v2 series,
> CPU hotplug is going to be implemented by using a CPU HP notifier.

Yes, it should be part of the series.

> That should be fine, right?

Yes, hopefully but it has to be part of the series.

Thanks,
Lorenzo
