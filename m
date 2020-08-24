Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F09250070
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 17:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgHXPJX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 11:09:23 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:29887 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgHXPJK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 11:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598281728;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=oJ25+Eo0INS90wWLPFZq+am/532LdNYJA8DfYTYvpuA=;
        b=bdOvDvfQfXFlZbBAn3yOiAd4ZYcyNwRMG9y9fyhu5CGRrQH3g51diYDZSt6STlwCVP
        VzpK006H921OKzFbICH/1cVnBcsFchO1A7M9rQyU7/T09f2t9b6WjANsXxRL6TheUPye
        tVYugudvyE1++scngTmrWH0eP/VfQKYzD6jgQdnXEbbzdpByxNtFCHZPAevUnpufuzyk
        DQ2FBDArUtIzaRg/xJjE+hh42BERV4MG7KSz6IJKACP7lDH7RGAEMF8DMLC2ri4X5Env
        s0YRhPlDF9rT2isoAyhb3Y8b9Xs2doM7nXN6JQvi1ul22SztvsJ+APvRQEFDh45z0AUO
        apLQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7Ic/MbIo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id g0b6c1w7OF8lZF6
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 24 Aug 2020 17:08:47 +0200 (CEST)
Date:   Mon, 24 Aug 2020 17:08:42 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [RFC PATCH 3/3] opp: Power on (virtual) power domains managed by
 the OPP core
Message-ID: <20200824150831.GA842@gerhold.net>
References: <20200730080146.25185-1-stephan@gerhold.net>
 <20200730080146.25185-4-stephan@gerhold.net>
 <20200824112744.jsyaxrfbybyjpwex@vireshk-i7>
 <20200824115549.GB208090@gerhold.net>
 <CAPDyKFojtArMRfO+Z8YaWCWw2fFYcO62x3eL1paNi5pKRg3Jww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFojtArMRfO+Z8YaWCWw2fFYcO62x3eL1paNi5pKRg3Jww@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 24, 2020 at 04:36:57PM +0200, Ulf Hansson wrote:
> On Mon, 24 Aug 2020 at 13:56, Stephan Gerhold <stephan@gerhold.net> wrote:
> >
> > On Mon, Aug 24, 2020 at 04:57:44PM +0530, Viresh Kumar wrote:
> > > On 30-07-20, 10:01, Stephan Gerhold wrote:
> > > > dev_pm_opp_attach_genpd() allows attaching an arbitrary number of
> > > > power domains to an OPP table. In that case, the genpd core will
> > > > create a virtual device for each of the power domains.
> > > >
> > > > At the moment, the OPP core only calls
> > > > dev_pm_genpd_set_performance_state() on these virtual devices.
> > > > It does not attempt to power on the power domains. Therefore
> > > > the required power domain might never get turned on.
> > > >
> > > > So far, dev_pm_opp_attach_genpd() is only used in qcom-cpufreq-nvmem.c
> > > > to attach the CPR power domain to the CPU OPP table. The CPR driver
> > > > does not check if it was actually powered on so this did not cause
> > > > any problems. However, other drivers (e.g. rpmpd) might ignore the
> > > > performance state until the power domain is actually powered on.
> > > >
> > > > Since these virtual devices are managed exclusively by the OPP core,
> > > > I would say that it should also be responsible to ensure they are
> > > > enabled. A similar approach is already used for regulators, see
> > > > commit 8d45719caaf5 ("opp: core: add regulators enable and disable").
> > > >
> > > > This commit implements similar functionality for the virtual genpd
> > > > devices managed by the OPP core. The power domains are turned on
> > > > the first time dev_pm_opp_set_rate() is called. They are turned off
> > > > again when dev_pm_opp_set_rate(dev, 0) is called.
> > > >
> > > > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > > > ---
> > > > Related discussion: https://lore.kernel.org/linux-arm-msm/20200426123140.GA190483@gerhold.net/
> > > >
> > > > There would be also other ways to implement this, e.g. device links,
> > > > assuming that the device using the OPP table also makes use of runtime PM.
> > > > My first thought was that it would be most consistent to handle this like
> > > > regulators, bandwidth votes etc. RFC :)
> > >
> > > This stuff was done ages back and I am starting to forget almost
> > > everything now :)
> > >
> > > Ulf, why doesn't pm_runtime_get(dev) take care of enabling multiple
> > > power domain case ? RFP (request for patience) :)
> > >
> >
> > So I'm really not an expert for power domains, but here is my
> > understanding:
> >
> > We attach the power domains in dev_pm_opp_attach_genpd(opp_dev, names),
> > where opp_dev is the device the OPP table belongs to.
> >
> > To do that, the genpd core creates a set of virtual devices. These
> > virtual devices are not related to opp_dev in any way. Therefore, the
> > power domains stay off until we run pm_runtime_get(virt_dev) for each of
> > the virtual devices. (Which is what is implemented in this patch...)
> 
> Just to clarify. The reason why genpd creates virtual devices isn't
> because of the opp table itself.
> 
> Instead this is because we can only attach one PM domain per device.
> And since a device may have multiple PM domains, we need to create a
> virtual device and per PM domain and attach that instead. Then it's up
> to the caller to manage the virtual devices.
> 
> In some cases where the PM domains can be managed together, a device
> link makes sense - while in others it doesn't.
> 
> >
> > If I understand correctly, what you would like to do is to have a single
> > pm_runtime_get(opp_dev) call also enable all the virtual devices?
> >
> > As far as I understand, this can be done by adding "device links"
> > between opp_dev and the virtual devices, e.g.
> >
> >         device_link_add(opp_dev, virt_dev, DL_FLAG_PM_RUNTIME);
> >
> > for each of the virtual devices.
> 
> Yep.
> 
> >
> > But the problem with that approach is that it assumes that someone
> > actually calls pm_runtime_get(opp_dev), i.e. we assume that opp_dev is
> > managed by runtime PM. As far as I know, this isn't the case for the CPU
> > OPP table for example.
> >
> > Maybe Ulf can correct me if I'm wrong :)
> 
> If I understand correctly, the opp_dev is the actual consumer device.
> It could represent an I/O controller for example, or a CPU in the CPU
> freq case.
> 

Exactly.

> That said, perhaps should rely on the consumer to deploy runtime PM
> support, but let the OPP core to set up the device links for the genpd
> virtual devices!?
> 

Yes, that would be the alternative option.
I would be fine with it as long as it also works for the CPUfreq case.

I don't think anything manages runtime PM for the CPU device, just
like no-one calls dev_pm_opp_set_rate(cpu_dev, 0). So with my patch the
power domain is essentially kept always-on (except for system suspend).
At least in my case this is intended.

If device links also keep the power domains on if the consumer device
does not make use of runtime PM it should work fine for my case.

Personally, I think my original patch (without device links) fits better
into the OPP API, for the following two reasons.

With device links:

  1. Unlike regulators/interconnects, attached power domains would be
     controlled by runtime PM instead of dev_pm_opp_set_rate(opp_dev, 0).

  2. ... some driver using OPP tables might not make use of runtime PM.
     In that case, the power domains would stay on the whole time,
     even if dev_pm_opp_set_rate(opp_dev, 0) was called.

With my patch, the power domain state is directly related to the
dev_pm_opp_set_rate(opp_dev, 0) call, which is more intuitive than
relying on the runtime PM state in my opinion.

Stephan
