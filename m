Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0F47BFCDB
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 15:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjJJNDC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 09:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjJJNCl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 09:02:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A07A199
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 06:02:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE96D1FB;
        Tue, 10 Oct 2023 06:03:06 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 427D03F762;
        Tue, 10 Oct 2023 06:02:25 -0700 (PDT)
Date:   Tue, 10 Oct 2023 14:02:22 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>
Subject: Re: Question regarding scmi_perf_domain.c
Message-ID: <20231010130222.ftd76mblcaojmcxb@bogus>
References: <DU0PR04MB9417DE145496DC03579F50E488CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010105503.jwrmjahuvcjgwtk5@bogus>
 <CAPDyKFqEpnKeF7Yuvv_a+=Kqs=pNU_kM59EqWdpCniHrY_373A@mail.gmail.com>
 <20231010124840.ztzsu5swqd2ez377@bogus>
 <DU0PR04MB9417BD408A9307A77A10A3F688CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417BD408A9307A77A10A3F688CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 10, 2023 at 12:53:58PM +0000, Peng Fan wrote:
> Hi Sudeep
>
> > Subject: Re: Question regarding scmi_perf_domain.c
> >
> > On Tue, Oct 10, 2023 at 01:02:01PM +0200, Ulf Hansson wrote:
> > > On Tue, 10 Oct 2023 at 12:55, Sudeep Holla <sudeep.holla@arm.com>
> > wrote:
> > > >
> > > > On Tue, Oct 10, 2023 at 10:30:17AM +0000, Peng Fan wrote:
> > > > > Hi Ulf,
> > > > >
> > > > > I just see you wrote scmi_perf_domain.c, just wonder this driver
> > > > > is only for devices, not support arm cores, right?
> > > > >
> > > > > For ARM cores, we still need scmi_cpufreq.c for performance
> > > > > settings, right?
> > > >
> > > > Sorry if I wasn't clear. The reason I mentioned it in private is
> > > > that we now support the power domain bindings in the scmi-cpufreq.c
> > > > as you were little bit nervous to use the clock bindings(though they
> > > > work just fine, I understand the possible confusion with the clock
> > protocol).
> > >
> > > Right, good point!
> > >
> > > I think we discussed earlier whether we should deprecate the use of
> > > the clock bindings. Maybe that's a good idea, to indicate that we
> > > prefer the power-domain bindings when going forward?
> >
> > Yes we could do that. I prefer to have some example in the actual DTS files
> > before we can think of deprecating it. I need to get around, test and push the
> > change to switch from clock to power domain bindings on Juno for example.
>
> Before that, I think we need think about whether it is possible to use
> a property saying perf-domain, using power domains implies a restriction
> that power domain is same as perf domain, but the spec not say that.
>

Just responded on the other thread, lets continue the discussion there to
keep the related discussions together there.

--
Regards,
Sudeep
