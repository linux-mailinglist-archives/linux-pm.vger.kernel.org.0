Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24B15B5AC8
	for <lists+linux-pm@lfdr.de>; Mon, 12 Sep 2022 15:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiILNBp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Sep 2022 09:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiILNBn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2022 09:01:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96FB420BEA
        for <linux-pm@vger.kernel.org>; Mon, 12 Sep 2022 06:01:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B914C113E;
        Mon, 12 Sep 2022 06:01:48 -0700 (PDT)
Received: from bogus (unknown [10.57.48.242])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A67B3F73B;
        Mon, 12 Sep 2022 06:01:40 -0700 (PDT)
Date:   Mon, 12 Sep 2022 14:01:37 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "npitre@baylibre.com" <npitre@baylibre.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: Question: why call clk_prepare in pm_clk_acquire
Message-ID: <20220912130137.kkmnpfce5cgocmsh@bogus>
References: <DU0PR04MB94173B45A2CFEE3BF1BD313A88409@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFrzJikk6rJr9xwV6W-whvdLe5tTUE+xO_EoRtm+9DAbNA@mail.gmail.com>
 <20220908173840.rqy335cdeg5a2ww5@bogus>
 <DU0PR04MB9417294DCE3DD29CD76F911388459@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417294DCE3DD29CD76F911388459@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Sep 11, 2022 at 01:31:15AM +0000, Peng Fan wrote:
> > Subject: Re: Question: why call clk_prepare in pm_clk_acquire
> > 
> > On Thu, Sep 08, 2022 at 04:37:13PM +0200, Ulf Hansson wrote:
> > > On Thu, 8 Sept 2022 at 09:33, Peng Fan <peng.fan@nxp.com> wrote:
> > > >
> > > > Hi All,
> > > >
> > > > We are facing an issue clk_set_rate fail with commit a3b884cef873
> > ("firmware:
> > > > arm_scmi: Add clock management to the SCMI power domain") ,
> > >
> > > Hmm, I wonder about the main reason behind that commit. Can we revert
> > > it or is there some platform/driver that is really relying on it?
> > >
> > 
> > IIUC, at the time of the commit, it was needed on some Renesas platform.
> > Not sure if it is still used or not.
> > 
> > > >
> > > > we use scmi power domain, but not use scmi clk, but with upper
> > > > commit, the clk is prepared when pm_clk_acquire.
> > > >
> > 
> > Is this based on latest SCMI clocks that support atomic or older one which
> > doesn't. If latter, I see pm_clk_acquire doesn't actually call prepare as if
> > clk_is_enabled_when_prepared(clk) = true. Do you see have issue ?
> 
> We are using 5.15 kernel, and clk_is_enabled_when_prepared(clk) is false.
>

Sorry I was just looking at scmi clk driver.

> > 
> > > > However the clk has flag CLK_SET_RATE_GATE, clk_set_rate will fail
> > > > in driver, because clk is prepared in pm_clk_acquire.
> > > >
> > 
> > Where is CLK_SET_RATE_GATE set exactly ?
> 
> The is flag in clk driver, drivers/clk/imx/clk-imx8ulp.c,
> imx8ulp_clk_hw_composite will use CLK_SET_RATE_GATE.
>

Understood.

> > 
> > > > Looking into drivers/base/power/clock_ops.c, I see
> > > > pm_clk_suspend/pm_clk_resume will handle clk prepare/unprepared,
> > so why pm_clk_acquire will also prepare the clk?
> > >
> > 
> > As asked above do you see the actual clk_prepare getting called as I see it
> > isn't if lk_is_enabled_when_prepared(clk) = true.
> 
> Yes, clk_is_enabled_when_prepared(clk) is not always true in my case,
> This function is just checking ops:
> clk && !(clk->core->ops->enable && clk->core->ops->disable)
> 

Got it, I was assuming you are using scmi clk driver which is not the case.

-- 
Regards,
Sudeep
