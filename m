Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB925B3C40
	for <lists+linux-pm@lfdr.de>; Fri,  9 Sep 2022 17:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiIIPnC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Sep 2022 11:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiIIPnA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2022 11:43:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2B11D0765
        for <linux-pm@vger.kernel.org>; Fri,  9 Sep 2022 08:42:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B22B165C;
        Fri,  9 Sep 2022 08:43:04 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 630833F73D;
        Fri,  9 Sep 2022 08:42:56 -0700 (PDT)
Date:   Fri, 9 Sep 2022 16:42:54 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Peng Fan <peng.fan@nxp.com>, Sudeep Holla <sudeep.holla@arm.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "npitre@baylibre.com" <npitre@baylibre.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: Question: why call clk_prepare in pm_clk_acquire
Message-ID: <20220909154254.xy4jvj6ybpuynghc@bogus>
References: <DU0PR04MB94173B45A2CFEE3BF1BD313A88409@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFrzJikk6rJr9xwV6W-whvdLe5tTUE+xO_EoRtm+9DAbNA@mail.gmail.com>
 <20220908173840.rqy335cdeg5a2ww5@bogus>
 <CAPDyKFqYDNXxfKHd8PYy8T3di2s206nCiHY7cEf+_EHVrY1YbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqYDNXxfKHd8PYy8T3di2s206nCiHY7cEf+_EHVrY1YbQ@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 09, 2022 at 01:12:03PM +0200, Ulf Hansson wrote:
> On Thu, 8 Sept 2022 at 19:38, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Thu, Sep 08, 2022 at 04:37:13PM +0200, Ulf Hansson wrote:
> > > On Thu, 8 Sept 2022 at 09:33, Peng Fan <peng.fan@nxp.com> wrote:
> > > >
> > > > Hi All,
> > > >
> > > > We are facing an issue clk_set_rate fail with commit a3b884cef873 ("firmware:
> > > > arm_scmi: Add clock management to the SCMI power domain") ,
> > >
> > > Hmm, I wonder about the main reason behind that commit. Can we revert
> > > it or is there some platform/driver that is really relying on it?
> > >
> >
> > IIUC, at the time of the commit, it was needed on some Renesas platform.
> > Not sure if it is still used or not.
> 
> Okay! Maybe Nico remembers more, as he authored the patch...
>

May be, or even check with Renesas team who tested his patch.

> Normally it's best decided on a platform basis, whether it really
> makes sense to use the GENPD_FLAG_PM_CLK. As the scmi power domain is
> a cross platform power domain, it worries me that we lose some needed
> flexibility, which is likely to make it more difficult to use it for
> some platforms. Also note, the main point behind GENPD_FLAG_PM_CLK,
> was just to consolidate code.
>

I agree and share similar concern.

> That said, I decided to do some research, by looking at the DTS files
> in the kernel. So far, there is only Juno and the imx8 based
> platform(s) that are using the scmi power domain.
>

Yes but there are few without any DTS upstream that I know.

> >
> > > >
> > > > we use scmi power domain, but not use scmi clk, but with upper commit, the clk is prepared
> > > > when pm_clk_acquire.
> > > >
> >
> > Is this based on latest SCMI clocks that support atomic or older one
> > which doesn't. If latter, I see pm_clk_acquire doesn't actually call
> > prepare as if clk_is_enabled_when_prepared(clk) = true. Do you see have
> > issue ?
>
> It doesn't really matter if we would be using an atomic clock or not.
>

No what I meant is pm_clk_acquire doesn't call prepare as clk_is_enabled_when_prepared
is true for scmi clocks(non atomic).

> The problem is that when using GENPD_FLAG_PM_CLK, during runtime
> resume (genpd_runtime_resume) we end up calling pm_clk_resume(), but
> prior invoking the consumer driver's ->runtime_resume() callback. In
> other words, the clock(s) will already be prepared and enabled when
> the driver's ->runtime_resume() callback gets invoked. That certainly
> isn't going to work for all cases.
>

Any specific reasons ? Sorry I am missing to understand why that would
be an issue ?


[...]

> In my opinion we should really try to move away from using
> GENPD_FLAG_PM_CLK for the scmi power domain. I can prepare a patch, if
> you think it makes sense?
> 

As along as Renesas is fine with that, it should be OK, but doesn't removing
that flag means we can drop {attach,detach}_dev callbacks too as they are just
adding clocks and without the flag it is useless. Sounds like we must revert
the patch completely IIUC.

-- 
Regards,
Sudeep
