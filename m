Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A3D7CBE5E
	for <lists+linux-pm@lfdr.de>; Tue, 17 Oct 2023 11:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbjJQJEa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Oct 2023 05:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbjJQJE3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2023 05:04:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F308DF7
        for <linux-pm@vger.kernel.org>; Tue, 17 Oct 2023 02:04:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3217A2F4;
        Tue, 17 Oct 2023 02:05:07 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2DF73F762;
        Tue, 17 Oct 2023 02:04:25 -0700 (PDT)
Date:   Tue, 17 Oct 2023 10:04:23 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Peng Fan <peng.fan@nxp.com>, Sudeep Holla <sudeep.holla@arm.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>
Subject: Re: Question regarding scmi_perf_domain.c
Message-ID: <ZS5OFzLjEEZi0Q8s@bogus>
References: <20231010130054.ieylxocuapugajif@bogus>
 <DU0PR04MB94177FFEAA62AC27839D826F88CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010133059.57rs52qedrc5mxfr@bogus>
 <DU0PR04MB9417D01218CA4803D00545A788CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010145137.fyxjlsj5qq3elq7l@bogus>
 <DU0PR04MB9417233F914A061FB0A23B3088CCA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFo32GQdgMWJ_rkb88mcdc+0jYubWiCapf99Zg9JTnNnPw@mail.gmail.com>
 <20231011141551.exqxkmt3xsl5fyjh@bogus>
 <CAPDyKFrWjAdujOr8JX5_JawaKqs0_MYUrsUN57XaB9q=darJ0w@mail.gmail.com>
 <CAPDyKFoJpnF_CezT6RySPpAwJY0+LO+RiSqqM=byTaRibKQPyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoJpnF_CezT6RySPpAwJY0+LO+RiSqqM=byTaRibKQPyg@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 16, 2023 at 05:08:18PM +0200, Ulf Hansson wrote:
> On Thu, 12 Oct 2023 at 13:53, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 11 Oct 2023 at 16:17, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Wed, Oct 11, 2023 at 11:26:54AM +0200, Ulf Hansson wrote:
> > >
> > > [..]
> > >
> > > > Not sure exactly what you are referring to when saying that "automatic
> > > > power domain on is broken". Genpd power-on the PM domain for a device
> > > > that gets attached to it, if the device has only a single PM domain.
> > > > This is the legacy behaviour.
> > > >
> > > > When we added support for multiple PM domains per device, we decided
> > > > to *not* power-on the PM domain, if the device that gets attached has
> > > > multiple PM domains. This behaviour was chosen deliberately, to allow
> > > > consumer drivers to decide themselves instead. Is there a problem with
> > > > this you think?
> > > >
> > >
> > > Just my understanding. Since the second PM domain added now is for perf
> > > and is not strictly power domain, Peng's concern is switching to this
> > > binding will make the platform loose this automatic genpd power-on
> > > feature.
> >
> > Yes, correct, as they way things are today.
> >
> > It all boils down to that attaching a device to multiple PM domains
> > can't really be done in a generic way, as it becomes device/platform
> > specific. Since this needs to be managed by the drivers/buses anyway,
> > they might as well get control of what PM domain they need to power-on
> > to probe their devices.
>
> Due to the above, it might be a good idea to power-on the SCMI
> *power-domains* during boot and leave them on to allow drivers to
> continue to probe their devices?
>

Such workarounds in my opinion are always inviting troubles as few platforms
make not like it that way.

> Maybe a module parameter or Kconfig debug option could be used to control this?
>

May be that works, but again I see this as working around. If the expectation
is the driver must manage the PM domain eventually, does it make sense to
start doing that now. You termed the single domain power on automatically
in the genpd as the "legacy support". Do you mean there is a plan to remove
it or make drivers not rely on it ?

My main worry is now we are spreading this work around every where. It was
in genpd but now you want in SCMI power domain driver. It just makes things
harder to remove if the eventual plan is to make drivers take care of the
power domains themselves.

> In this way an updated DTS with that adds a performance domain to a
> consumer device node (which already has a power-domain), should allow
> the consumer driver to continue to probe successfully.
>

This will work, but I find it hard as addition of some extra information
in the DTS is ending up losing some feature which was otherwise available.
If platforms relied on it, they may just stick with clock bindings silently
as it is easier that way. Even expecting a module param might be a big ask
if someone working on the platform isn't aware of all the details.
That is my main concern.


--
Regards,
Sudeep
