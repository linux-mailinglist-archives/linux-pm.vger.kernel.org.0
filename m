Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F057A583A77
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 10:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbiG1IkS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 04:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbiG1IkS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 04:40:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 555AC240B3;
        Thu, 28 Jul 2022 01:40:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF20F106F;
        Thu, 28 Jul 2022 01:40:16 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D4863F73B;
        Thu, 28 Jul 2022 01:40:15 -0700 (PDT)
Date:   Thu, 28 Jul 2022 09:40:12 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vinod Koul <vinod.koul@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: PSCI domains without OSI support
Message-ID: <20220728084012.jjbmycplye3zuaok@bogus>
References: <CAA8EJpr2S-81+q-vjmk5i+T-JwaadkRpjCr_oGi7fMf7o3iH3A@mail.gmail.com>
 <20220727111410.bglx2u26456ray2u@bogus>
 <CAA8EJprNPJfGjkq2=hexbZn-=t2wKG6ZjSm5Mcbo4JuPQ-sc-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJprNPJfGjkq2=hexbZn-=t2wKG6ZjSm5Mcbo4JuPQ-sc-A@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 27, 2022 at 04:24:22PM +0300, Dmitry Baryshkov wrote:
> On Wed, 27 Jul 2022 at 14:14, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, Jul 27, 2022 at 12:09:27PM +0300, Dmitry Baryshkov wrote:
> > > Hi,
> > >
> > > Lately I have been working on improving the msm8996 platform support.
> > > Vendor kernel seems to support domain-like idle (see [1], [2]).
> > > However when I tried changing upstream msm8996.dtsi to use PSCI
> > > domains, I faced the firmware reporting NOT_SUPPORTED to an attempt to
> > > enable OSI (thus rendering PSCI domains useless, as they are now
> > > marked with ALWAYS_ON).
> > >
> >
> > That's not good to hear 🙁.
> >
> > > I noticed that vendor kernel makes a call to cpu_suspend() with
> > > power_state following the original format (described in PSCI spec
> > > 5.4.2.1). What would be the best way to support this?
> >
> > And why is this not possible with the existing code ? Not sure if I
> > understood it right, I am assuming you are mentioning that it is not
> > possible.
>
> It's not possible with the cpuidle-psci-domains.c. The driver marks
> all genpds as ALWAYS_ON, thus making sure that they are never
> suspended.
>

That doesn't sound correct. I am sure Ulf has tried this on one of SDM
platform for sure when it was merged.

> > > - Allow DTS forcing the PSCI power domains even if OSI enablement fails?
> >
> > Meaning DTS flag for this ? If OSI enable fails, why would you want to
> > still proceed. It is non-compliant and must be fixed if the firmware
> > supports OSI and expects OSPM to use the same.
>
> I'm not sure at this moment. PSCI firmware reports that OSI mode is
> supported, but then when psci_pd_try_set_osi_mode() tries to switch
> into OSI mode, it gets NOT_SUPPORTED.

Yikes, fix the damn broken firmware. That is utter non-sense. I don't
understand why would the firmware authors enable some feature before it
is ready.

> Just for the sake of completeness, I added a print to the psci.c to
> dump the result of the psci_set_osi_mode(false). It also returns
> NOT_SUPPORTED!
>

Well it is simply broken then. Not tested firmware, so please don't
attempt to use OSI if it is so fundamentally broken. I find it hard to
accept the argument that well it works just that the query API is failing.
But what is the guarantee that it is tested well enough. We will end up
adding more quirks after adding one to enable it.

> My logical assumption would be that the firmware reports support for
> OS_INITIATED, but then just fails to properly support
> SET_SUSPEND_MODE.

I knew this argument was coming as I wrote above, sorry I don't buy that.
It is probably one of the early platforms supporting PSCI and not well tested
for conformance. So I am inclined to just say we can't support it.

> I should probably try ignoring the error psci-domain.c and continue
> with binding power domains. What would be the best way to check that
> the domains setup works as expected?
>
> >
> > > - Add a separate cpuidle driver?
> >
> > I would avoid that.
> >
> > > - Just forget about it and use plain PSCI as we currently do?
> > >
> >
> > Worst case yes. My main worry is how many of the old SDM SoC has such a
> > behaviour and how much they wary from each other. The OSI mode was pushed
> > after lengthy discussions to support all these platforms and now we have
> > platforms needing separate idle driver ?
>
> I'm not sure. 32-bit SoCs use non-PSCI idle driver. MSM8916, sdm845
> and later SoCs are using proper domains support.

Yes that is 32-bit, we just support PSCI on 64-bit. No more arguments
there, we had enough in the early days for almost more than a year. We
are not going back to that again.

--
Regards,
Sudeep
