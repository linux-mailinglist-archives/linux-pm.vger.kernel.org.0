Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D20B4F06
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 15:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfIQNUl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 09:20:41 -0400
Received: from foss.arm.com ([217.140.110.172]:55808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfIQNUl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Sep 2019 09:20:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2BD828;
        Tue, 17 Sep 2019 06:20:39 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 078F33F575;
        Tue, 17 Sep 2019 06:20:37 -0700 (PDT)
Date:   Tue, 17 Sep 2019 14:20:35 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        tdas@codeaurora.org, swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/5] cpufreq: qcom-hw: Move driver initialisation earlier
Message-ID: <20190917132035.GB30016@bogus>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
 <b731b713d8738239c26361ece7f5cadea035b353.1568240476.git.amit.kucheria@linaro.org>
 <20190917093412.GA24757@bogus>
 <58e60ca4-9615-bbdf-5fe7-2a0e1d7f48d8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58e60ca4-9615-bbdf-5fe7-2a0e1d7f48d8@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 17, 2019 at 02:47:22PM +0200, Daniel Lezcano wrote:
>
> Hi Sudeep,
>
> On 17/09/2019 11:34, Sudeep Holla wrote:
> > On Thu, Sep 12, 2019 at 04:02:34AM +0530, Amit Kucheria wrote:
> >> Allow qcom-hw driver to initialise right after the cpufreq and thermal
> >> subsystems are initialised in core_initcall so we get earlier access to
> >> thermal mitigation.
> >>
> >> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> >> ---
> >>  drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> >> index 4b0b50403901..04676cc82ba6 100644
> >> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> >> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> >> @@ -327,7 +327,7 @@ static int __init qcom_cpufreq_hw_init(void)
> >>  {
> >>  	return platform_driver_register(&qcom_cpufreq_hw_driver);
> >>  }
> >> -device_initcall(qcom_cpufreq_hw_init);
> >> +postcore_initcall(qcom_cpufreq_hw_init);
> >
> > I am fine with core framework initcall pushed to earlier initcall levels
> > if required, but for individual/platform specific drivers I am not so
> > happy to see that.
> >
> > This goes against the grand plan of single common kernel strategy by
> > Android moving all drivers as modules. We might decide to make this
> > a module.
>
> module = mounted file system = very late initialization
>
> Is that the plan? Force every driver to load too late?
>

Yes. Something similar to what we have on desktops/servers.

> There are core drivers which must be loaded as soon as possible. If the
> qcom driver is one of them, then what is the problem?
>

I am fine with that if it's really issue but it shouldn't become the
defacto trend.

> "The grand plan" will have to solve this first before doing the module
> move.
>

Sure, I just expressed my view as it looks to be going in different
direction for me.

> > Also there are few cpufreq drivers that are modules. Will
> > they have issues ? If not, why do we need this change at all.
>
> Because some boards don't have thermal issues with the cpufreq drivers
> as module, other boards have.
>

OK, so this platform boots with default high OPP and needs thermal
mitigation that early ? If so, that's fine.

> > Needing
> > thermal mitigation during boot this earlier is still too much of
> > expectation, I would rather boot slowly than relying on this feature.
>
> And what if we want to boot faster? The boot time is one of a key point
> of benchmark.
>

I understand the requirement, though for me it's really sounds stupid.

As Quentin pointed out, it would be good to get all those benchmark
details, and preferably in the commit log so that we can look back
whenever someone else take the same approach later.

--
Regards,
Sudeep
