Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FD85BFFFF
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 16:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiIUOgd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Sep 2022 10:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiIUOga (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2022 10:36:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD0F28B2F7;
        Wed, 21 Sep 2022 07:36:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7AA113D5;
        Wed, 21 Sep 2022 07:36:34 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 118D33F73B;
        Wed, 21 Sep 2022 07:36:26 -0700 (PDT)
Date:   Wed, 21 Sep 2022 15:36:24 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] firmware/psci: Print a warning if PSCI doesn't accept
 PC mode
Message-ID: <20220921143624.eulpt56r4cn4vcrx@bogus>
References: <20220804130750.3706897-1-dmitry.baryshkov@linaro.org>
 <Yu0m6yzLr5fhEMtu@FVFF77S0Q05N>
 <eea4d8ec-d6de-5262-b73f-609b2f1bea86@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eea4d8ec-d6de-5262-b73f-609b2f1bea86@linaro.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 19, 2022 at 02:58:57PM +0300, Dmitry Baryshkov wrote:
> On 05/08/2022 17:19, Mark Rutland wrote:
> > On Thu, Aug 04, 2022 at 04:07:50PM +0300, Dmitry Baryshkov wrote:
> > > The function psci_pd_try_set_osi_mode() will print an error if enabling
> > > OSI mode fails. To ease debugging PSCI issues print corresponding
> > > message if switching to PC mode fails too.
> > > 
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > Mark.
> 
> Granted that this patch has been acked by the maintainers of PSCI interface,
> how do I proceed? Should I submit it to Russel's patch tracker? Or do PSCI
> patches land via some other tree?
>

Not sure if I mentioned it elsewhere or in v1, we generally ask Arm SoC
team to pick up patches directly as they are always 1-2 and rarely large
set. You need to cc soc@kernel.org for the same.

> > 
> > > ---
> > > This is a replacement for [1], now moving the warning from
> > > psci_set_osi_mode() callers to the function iself.
> > > 
> > > https://lore.kernel.org/all/20220727182034.983727-1-dmitry.baryshkov@linaro.org/
> > > 
> > > ---
> > >   drivers/cpuidle/cpuidle-psci-domain.c | 4 +---
> > >   drivers/firmware/psci/psci.c          | 2 ++
> > >   2 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > > index 3db4fca1172b..821984947ed9 100644
> > > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > > @@ -124,10 +124,8 @@ static bool psci_pd_try_set_osi_mode(void)
> > >   		return false;
> > >   	ret = psci_set_osi_mode(true);
> > > -	if (ret) {
> > > -		pr_warn("failed to enable OSI mode: %d\n", ret);
> > > +	if (ret)
> > >   		return false;
> > > -	}
> > >   	return true;
> > >   }
> > > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > > index cfb448eabdaa..1628f1edef4a 100644
> > > --- a/drivers/firmware/psci/psci.c
> > > +++ b/drivers/firmware/psci/psci.c
> > > @@ -163,6 +163,8 @@ int psci_set_osi_mode(bool enable)
> > >   			PSCI_1_0_SUSPEND_MODE_PC;
> > >   	err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE, suspend_mode, 0, 0);
> > > +	if (err < 0)
> > > +		pr_warn("failed to set %s mode: %d\n", enable ? "OSI" : "PC", err);
> > >   	return psci_to_linux_errno(err);
> > >   }
> > > -- 
> > > 2.35.1
> > > 
> 
> -- 
> With best wishes
> Dmitry
> 

-- 
Regards,
Sudeep
