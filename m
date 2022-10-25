Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AD360CB12
	for <lists+linux-pm@lfdr.de>; Tue, 25 Oct 2022 13:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJYLls (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Oct 2022 07:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiJYLlr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2022 07:41:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F37B16E2AB
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 04:41:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E606ED6E;
        Tue, 25 Oct 2022 04:41:51 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F57B3F7B4;
        Tue, 25 Oct 2022 04:41:44 -0700 (PDT)
Date:   Tue, 25 Oct 2022 12:41:41 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RESEND PATCH v2] firmware/psci: Print a warning if PSCI doesn't
 accept PC mode
Message-ID: <20221025114141.2my5drpjhincjons@bogus>
References: <20220926110249.666813-1-dmitry.baryshkov@linaro.org>
 <Y1AGLPXWFOmjfdd0@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1AGLPXWFOmjfdd0@hovoldconsulting.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 19, 2022 at 04:14:04PM +0200, Johan Hovold wrote:
> On Mon, Sep 26, 2022 at 02:02:49PM +0300, Dmitry Baryshkov wrote:
> > The function psci_pd_try_set_osi_mode() will print an error if enabling
> > OSI mode fails. To ease debugging PSCI issues print corresponding
> > message if switching to PC mode fails too.
> >
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> > This is a replacement for [1], now moving the warning from
> > psci_set_osi_mode() callers to the function iself.
> >
> > The patch is resent to include soc@kernel.org
> >
> > [1] https://lore.kernel.org/all/20220727182034.983727-1-dmitry.baryshkov@linaro.org/
> >
> > ---
> >  drivers/cpuidle/cpuidle-psci-domain.c | 4 +---
> >  drivers/firmware/psci/psci.c          | 2 ++
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > index 3db4fca1172b..821984947ed9 100644
> > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > @@ -124,10 +124,8 @@ static bool psci_pd_try_set_osi_mode(void)
> >  		return false;
> >
> >  	ret = psci_set_osi_mode(true);
> > -	if (ret) {
> > -		pr_warn("failed to enable OSI mode: %d\n", ret);
> > +	if (ret)
> >  		return false;
> > -	}
> >
> >  	return true;
> >  }
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index 9fdcb6bff403..42cae0ba10e2 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -164,6 +164,8 @@ int psci_set_osi_mode(bool enable)
> >  			PSCI_1_0_SUSPEND_MODE_PC;
> >
> >  	err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE, suspend_mode, 0, 0);
> > +	if (err < 0)
> > +		pr_warn("failed to set %s mode: %d\n", enable ? "OSI" : "PC", err);
> >  	return psci_to_linux_errno(err);
> >  }
>
> When booting 6.1-rc1 I now see:
>
> 	[    0.000000] psci: OSI mode supported.
> 	[    0.000000] psci: failed to set PC mode: -3
>
> on every boot with sc8280xp, while later enabling OSI mode still works:
>
> 	[    0.227358] CPUidle PSCI: psci_pd_try_set_osi_mode - success
> 	[    0.227599] CPUidle PSCI: Initialized CPU PM domain topology
>
> Judging from Sudeep's comment on v1:
>
> 	The platform must boot in PC mode, so even if it fails we ignore
> 	so not sure if the logging is of much help here IMO.
>
> perhaps logging this as an error is not a good idea?
>

Sorry I have forgotten about the discussion on this already. I may contradict
myself, but it the platform is misbehaving, why is it not a good idea to
log it as error. It can be ignored right if it is not an issue on the
platform ? My main worry is no one will turn on debug unless they are
debugging and new platforms with same issues may go unnoticed while we
want them to be fixed, right ?

--
Regards,
Sudeep
