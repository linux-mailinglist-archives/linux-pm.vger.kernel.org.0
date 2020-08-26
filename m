Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479EA25293D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 10:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgHZIcF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 04:32:05 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:24972 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgHZIcE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 04:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598430717;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=5qbPZwOrGjfVjPer5Q3VTjDIEHM+8e+46OrFUHxkQFA=;
        b=th8H/aEs0w3hgC1F/cXwliYNoI4Yp5N+h4FASob8o2FwyT1nXSTBgBkJa2ASEqhhql
        4BtOAbGbQFC3qqLr5Lh+lwrrp5brDfNcgTFTTFIh9pLSXf99rT48YKzMeZEQ82Qmn4U5
        xuuck+/4YfeX4lx1qNGaOr95qc5NGWxy6I8QQO4Mm9NugRz+l98UFE+c6/+AKM3zruuE
        9Arw4ENLCSqxJYUmFoD0oNXQrCacito7VW2Zr7BMeGA3BM9yaGVivUg/Y5RsLaWfjFrj
        fu7BYXZFsNsYsKMI6GWw89O4Ffp8Xrt6h5ZlwzFEnW6C0lgfURPzTwOAeK3Fw7IKh5Qq
        gr7w==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7Ic/Fboo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id g0b6c1w7Q8VskYv
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 26 Aug 2020 10:31:54 +0200 (CEST)
Date:   Wed, 26 Aug 2020 10:31:48 +0200
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
Message-ID: <20200826083148.GA869@gerhold.net>
References: <20200730080146.25185-1-stephan@gerhold.net>
 <20200730080146.25185-4-stephan@gerhold.net>
 <20200824112744.jsyaxrfbybyjpwex@vireshk-i7>
 <20200824115549.GB208090@gerhold.net>
 <CAPDyKFojtArMRfO+Z8YaWCWw2fFYcO62x3eL1paNi5pKRg3Jww@mail.gmail.com>
 <20200824150831.GA842@gerhold.net>
 <20200825044308.4y3w2urcikban7if@vireshk-i7>
 <CAPDyKFp+71_WGwvdZ6DYamsDjgoRk57H5MjDAdQUtCtJpEHp2Q@mail.gmail.com>
 <20200825073348.GA1048@gerhold.net>
 <CAPDyKFr-gfpVypFs_13hb9Pi5FfQoB32fg=C_gtdSKVDN1U=gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr-gfpVypFs_13hb9Pi5FfQoB32fg=C_gtdSKVDN1U=gQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 25, 2020 at 02:42:54PM +0200, Ulf Hansson wrote:
> On Tue, 25 Aug 2020 at 09:34, Stephan Gerhold <stephan@gerhold.net> wrote:
> >
> > On Tue, Aug 25, 2020 at 08:43:42AM +0200, Ulf Hansson wrote:
> > > On Tue, 25 Aug 2020 at 06:43, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > On 24-08-20, 17:08, Stephan Gerhold wrote:
> > > > > On Mon, Aug 24, 2020 at 04:36:57PM +0200, Ulf Hansson wrote:
> > > > > > That said, perhaps should rely on the consumer to deploy runtime PM
> > > > > > support, but let the OPP core to set up the device links for the genpd
> > > > > > virtual devices!?
> > > > > >
> > > > >
> > > > > Yes, that would be the alternative option.
> > > >
> > > > That is the right option IMO.
> > > >
> > > > > I would be fine with it as long as it also works for the CPUfreq case.
> > > > >
> > > > > I don't think anything manages runtime PM for the CPU device, just
> > > > > like no-one calls dev_pm_opp_set_rate(cpu_dev, 0). So with my patch the
> > > > > power domain is essentially kept always-on (except for system suspend).
> > > > > At least in my case this is intended.
> > > > >
> > > > > If device links also keep the power domains on if the consumer device
> > > > > does not make use of runtime PM it should work fine for my case.
> > > >
> > > > With device link, you only need to do rpm enable/disable on the consumer device
> > > > and it will get propagated by itself.
> > >
> > > Note that the default state for the genpd virtual device(s) is that
> > > runtime PM has been enabled for them. This means it's left in runtime
> > > suspended state, which allows its PM domain to be powered off (if all
> > > other devices and child domains for it allow that too, of course).
> > >
> > > >
> > > > > Personally, I think my original patch (without device links) fits better
> > > > > into the OPP API, for the following two reasons.
> > > > >
> > > > > With device links:
> > > > >
> > > > >   1. Unlike regulators/interconnects, attached power domains would be
> > > > >      controlled by runtime PM instead of dev_pm_opp_set_rate(opp_dev, 0).
> > > > >
> > > > >   2. ... some driver using OPP tables might not make use of runtime PM.
> > > > >      In that case, the power domains would stay on the whole time,
> > > > >      even if dev_pm_opp_set_rate(opp_dev, 0) was called.
> > > > >
> > > > > With my patch, the power domain state is directly related to the
> > > > > dev_pm_opp_set_rate(opp_dev, 0) call, which is more intuitive than
> > > > > relying on the runtime PM state in my opinion.
> > > >
> > > > So opp-set-rate isn't in the best of shape TBH, some things are left for the
> > > > drivers while other are done by it. Regulator-enable/disable was moved to it
> > > > some time back as people needed something like that. While on the other hand,
> > > > clk_enable/disable doesn't happen there, nor does rpm enable/disable.
> > > >
> > > > Maybe one day we may want to do that, but lets make sure someone wants to do
> > > > that first.
> > > >
> > > > Anyway, even in that case both of the changes would be required. We must make
> > > > device links nevertheless first. And later on if required, we may want to do rpm
> > > > enable/disable on the consumer device itself.
> > >
> > > This sounds like a reasonable step-by-step approach.
> > >
> > > Then, to create the device links, we should use DL_FLAG_PM_RUNTIME,
> > > DL_FLAG_STATELESS.
> > >
> >
> > OK, I will give this a try later this week.
> >
> > > But whether we should use DL_FLAG_RPM_ACTIVE as well, to initially
> > > runtime resume the supplier (the genpd virtual device), is harder to
> > > know - as that kind of depends on expectations by the consumer device
> > > driver.
> > >
> >
> > I'm not sure I understand the purpose of that flag. I thought we want to
> > link the PM state of the virtual genpd device (supplier) to the PM state
> > of the device of the OPP table (consumer).
> 
> Correct, but this is about synchronizing the initial runtime PM state
> of the consumer and supplier.
> 
> >
> > Shouldn't it just determine the initial state based on the state of the
> > consumer device?
> 
> We could do that. Then something along the lines of the below, should work:
> 
> pm_runtime_get_noresume(consumer) - to prevent runtime suspend, temporarily.
> 
> if(pm_runtime_active(consumer))
>     create links with DL_FLAG_RPM_ACTIVE
> else
>     create links without DL_FLAG_RPM_ACTIVE
> 
> pm_runtime_put(consumer)
> 

This seems to work as expected, thanks for the suggestion!
I will submit a v2 with that shortly.

Thanks!
Stephan
