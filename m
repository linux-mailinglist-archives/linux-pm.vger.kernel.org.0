Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B99C7BFC9E
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 15:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjJJNCC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 09:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjJJNBJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 09:01:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CEC611C
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 06:00:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 809111FB;
        Tue, 10 Oct 2023 06:01:38 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA2803F762;
        Tue, 10 Oct 2023 06:00:56 -0700 (PDT)
Date:   Tue, 10 Oct 2023 14:00:54 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>
Subject: Re: Question regarding scmi_perf_domain.c
Message-ID: <20231010130054.ieylxocuapugajif@bogus>
References: <DU0PR04MB9417DE145496DC03579F50E488CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010105503.jwrmjahuvcjgwtk5@bogus>
 <CAPDyKFqEpnKeF7Yuvv_a+=Kqs=pNU_kM59EqWdpCniHrY_373A@mail.gmail.com>
 <DU0PR04MB941755466872E84217378F6388CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB941755466872E84217378F6388CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 10, 2023 at 12:01:57PM +0000, Peng Fan wrote:
> Hi Sudeep, Ulf
> > Subject: Re: Question regarding scmi_perf_domain.c
> >
> > On Tue, 10 Oct 2023 at 12:55, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Tue, Oct 10, 2023 at 10:30:17AM +0000, Peng Fan wrote:
> > > > Hi Ulf,
> > > >
> > > > I just see you wrote scmi_perf_domain.c, just wonder this driver is
> > > > only for devices, not support arm cores, right?
> > > >
> > > > For ARM cores, we still need scmi_cpufreq.c for performance
> > > > settings, right?
> > >
> > > Sorry if I wasn't clear. The reason I mentioned it in private is that
> > > we now support the power domain bindings in the scmi-cpufreq.c as you
> > > were little bit nervous to use the clock bindings(though they work
> > > just fine, I understand the possible confusion with the clock protocol).
> >
> > Right, good point!
> >
> > I think we discussed earlier whether we should deprecate the use of the clock
> > bindings. Maybe that's a good idea, to indicate that we prefer the power-
> > domain bindings when going forward?
>
> But why use power-domains? Power domains may not same as perf domains
> per my understanding and SCMI spec not has such restriction.
>

Good question as it can be as confusing as using clocks bindings. I
understand, but Linux genpd domains were extended to support performance
domains and Ulf has worked on to support the same for SCMI.

One key point you have to note and understand is that on SCMI based
platforms, you will end up with one set of SCMI genpd domains that provide
only power domain capability using the SCMI power protocol and another
set of genpd domains providing just the performance capability using the
SCMI perf protocol.

The set of power and perf domains may not overlap at all based on how it
is presented by the firmware. To be clear(to answer to your main confusion
and avoid any further), each will have the set of its own domain IDs
(0 - (N - 1)) and (0 - (M - 1)) where M and N represents the number of
perf and power domains supported by the firmware.

> Currently our SCMI server power domain ids and perf domain ids are
> different.  If linux has the restriction that perf domain id should be same
> as power domain id, we need redesign our scmi firmware on this part.
>

No, there is no such restriction. It is just the exact/similar confusion
you had with clock IDs being used with performance protocol. It is just
your misunderstanding, not the reality.

--
Regards,
Sudeep
