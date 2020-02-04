Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEBA4151D1A
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2020 16:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgBDPVo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Feb 2020 10:21:44 -0500
Received: from foss.arm.com ([217.140.110.172]:38078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbgBDPVn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Feb 2020 10:21:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDA41101E;
        Tue,  4 Feb 2020 07:21:42 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC71A3F52E;
        Tue,  4 Feb 2020 07:21:40 -0800 (PST)
Date:   Tue, 4 Feb 2020 15:21:32 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, agross@kernel.org, david.brown@linaro.org,
        Lorenzo.Pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org, ulf.hansson@linaro.org,
        rjw@rjwysocki.net, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 5/7] drivers: firmware: psci: Add hierarchical domain
 idle states converter
Message-ID: <20200204152132.GA44858@bogus>
References: <1580736940-6985-1-git-send-email-mkshah@codeaurora.org>
 <1580736940-6985-6-git-send-email-mkshah@codeaurora.org>
 <20200203170832.GA38466@bogus>
 <0d7f7ade-3a1e-5428-d851-f1a886f58712@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d7f7ade-3a1e-5428-d851-f1a886f58712@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 04, 2020 at 10:22:42AM +0530, Maulik Shah wrote:
>
> On 2/3/2020 10:38 PM, Sudeep Holla wrote:
> > On Mon, Feb 03, 2020 at 07:05:38PM +0530, Maulik Shah wrote:
> > > From: Ulf Hansson <ulf.hansson@linaro.org>
> > >
> > > If the hierarchical CPU topology is used, but the OS initiated mode isn't
> > > supported, we need to rely solely on the regular cpuidle framework to
> > > manage the idle state selection, rather than using genpd and its
> > > governor.
> > >
> > > For this reason, introduce a new PSCI DT helper function,
> > > psci_dt_pm_domains_parse_states(), which parses and converts the
> > > hierarchically described domain idle states from DT, into regular flattened
> > > cpuidle states. The converted states are added to the existing cpuidle
> > > driver's array of idle states, which make them available for cpuidle.
> > >
> > And what's the main motivation for this if OSI is not supported in the
> > firmware ?
>
> Hi Sudeep,
>
> Main motivation is to do last-man activities before the CPU cluster can
> enter a deep idle state.
>

Details on those last-man activities will help the discussion. Basically
I am wondering what they are and why they need to done in OSPM ?

> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > [applied to new path, resolved conflicts]
> > > Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> > > ---
> > >   drivers/cpuidle/cpuidle-psci-domain.c | 137 +++++++++++++++++++++++++++++-----
> > >   drivers/cpuidle/cpuidle-psci.c        |  41 +++++-----
> > >   drivers/cpuidle/cpuidle-psci.h        |  11 +++
> > >   3 files changed, 153 insertions(+), 36 deletions(-)
> > >
> > > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > > index 423f03b..3c417f7 100644
> > > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > > @@ -26,13 +26,17 @@ struct psci_pd_provider {
> > >   };
> > >
> > >   static LIST_HEAD(psci_pd_providers);
> > > -static bool osi_mode_enabled __initdata;
> > > +static bool osi_mode_enabled;
> > >
> > >   static int psci_pd_power_off(struct generic_pm_domain *pd)
> > >   {
> > >   	struct genpd_power_state *state = &pd->states[pd->state_idx];
> > >   	u32 *pd_state;
> > >
> > > +	/* If we have failed to enable OSI mode, then abort power off. */
> > > +	if ((psci_has_osi_support()) && !osi_mode_enabled)
> > > +		return -EBUSY;
> > > +
> > Why is this needed ? IIUC we don't create genpd domains if OSI is not
> > enabled.
>
> we do create genpd domains, for cpu domains, we just abort power off here
> since idle states are converted into regular flattened mode.
>

OK, IIRC the OSI patches from Ulf didn't add the genpd or rather removed
them in case of any failure to enable OSI. Has that been changed ? If so,
why ?

> however genpd poweroff will be used by parent domain (rsc in this case)
> which is kept in hireachy in DTSI with cluster domain to do last man
> activities.
>

I am bit confused here. Either we do OSI or PC and what you are describing
sounds like a mix-n-match to me and I am totally against it.

--
Regards,
Sudeep
