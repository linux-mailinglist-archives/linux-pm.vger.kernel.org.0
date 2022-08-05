Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EC258ADCB
	for <lists+linux-pm@lfdr.de>; Fri,  5 Aug 2022 18:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238497AbiHEQAa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Aug 2022 12:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241072AbiHEQA3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Aug 2022 12:00:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BBD82ADC;
        Fri,  5 Aug 2022 09:00:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAE46106F;
        Fri,  5 Aug 2022 09:00:24 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41B383F73B;
        Fri,  5 Aug 2022 09:00:23 -0700 (PDT)
Date:   Fri, 5 Aug 2022 17:00:20 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vinod Koul <vinod.koul@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: PSCI domains without OSI support
Message-ID: <20220805160020.fc5s3hv3u5h4gcmv@bogus>
References: <CAA8EJpr2S-81+q-vjmk5i+T-JwaadkRpjCr_oGi7fMf7o3iH3A@mail.gmail.com>
 <20220727111410.bglx2u26456ray2u@bogus>
 <CAA8EJprNPJfGjkq2=hexbZn-=t2wKG6ZjSm5Mcbo4JuPQ-sc-A@mail.gmail.com>
 <20220728084012.jjbmycplye3zuaok@bogus>
 <CAPDyKFqT23A_4EdBe=2-+6821BzjPvGzsMositM2=Of692iv3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFqT23A_4EdBe=2-+6821BzjPvGzsMositM2=Of692iv3A@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 05, 2022 at 04:12:42PM +0200, Ulf Hansson wrote:
> On Thu, 28 Jul 2022 at 10:40, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, Jul 27, 2022 at 04:24:22PM +0300, Dmitry Baryshkov wrote:
> > > On Wed, 27 Jul 2022 at 14:14, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > On Wed, Jul 27, 2022 at 12:09:27PM +0300, Dmitry Baryshkov wrote:
> > > > > Hi,
> > > > >
> > > > > Lately I have been working on improving the msm8996 platform support.
> > > > > Vendor kernel seems to support domain-like idle (see [1], [2]).
> > > > > However when I tried changing upstream msm8996.dtsi to use PSCI
> > > > > domains, I faced the firmware reporting NOT_SUPPORTED to an attempt to
> > > > > enable OSI (thus rendering PSCI domains useless, as they are now
> > > > > marked with ALWAYS_ON).
> > > > >
> > > >
> > > > That's not good to hear 🙁.
> > > >
> > > > > I noticed that vendor kernel makes a call to cpu_suspend() with
> > > > > power_state following the original format (described in PSCI spec
> > > > > 5.4.2.1). What would be the best way to support this?
> > > >
> > > > And why is this not possible with the existing code ? Not sure if I
> > > > understood it right, I am assuming you are mentioning that it is not
> > > > possible.
> > >
> > > It's not possible with the cpuidle-psci-domains.c. The driver marks
> > > all genpds as ALWAYS_ON, thus making sure that they are never
> > > suspended.
> > >
> >
> > That doesn't sound correct. I am sure Ulf has tried this on one of SDM
> > platform for sure when it was merged.
>
> It looks like there may be some misunderstanding here.
>
> I think the point Dmitry is trying to make, is that the we set the
> GENPD_FLAG_ALWAYS_ON for the created genpds, when the OSI mode could
> not be turned on, when probing the cpuidle-psci-domain driver. In this
> way, all of cluster idle-states become disabled.
>
> More details about why we have this behaviour can be found from the
> commit below.
>
> 70c179b49870 ("cpuidle: psci: Allow PM domain to be initialized even
> if no OSI mode")
>

Ah OK, understood now.

> >
> > > > > - Allow DTS forcing the PSCI power domains even if OSI enablement fails?
> > > >
> > > > Meaning DTS flag for this ? If OSI enable fails, why would you want to
> > > > still proceed. It is non-compliant and must be fixed if the firmware
> > > > supports OSI and expects OSPM to use the same.
> > >
> > > I'm not sure at this moment. PSCI firmware reports that OSI mode is
> > > supported, but then when psci_pd_try_set_osi_mode() tries to switch
> > > into OSI mode, it gets NOT_SUPPORTED.
> >
> > Yikes, fix the damn broken firmware. That is utter non-sense. I don't
> > understand why would the firmware authors enable some feature before it
> > is ready.
>
> I certainly agree that the FW is broken and should really have been
> fixed, but that seems unlikely to happen when moving forward.
>
> On the other hand, it's quite common that we try to add workarounds at
> the Linux side to fix FW issues. Of course, it depends on what kind of
> hacks it means for us to carry.
>
> In this particular case, I am of the opinion that it looks like the
> "hack" may be worth it. Unless I have underestimated the problem, it
> seems like a new DT property/flag and a simple if-clause in
> psci_pd_try_set_osi_mode() should do the trick for us.
>

I don't like the idea of new property/flag for this for simple reason.
Once you have that it is impossible to control if downstream new platforms
are using it and they will expect it to be maintained once they ship the
product.

> I wouldn't mind maintaining such small parts, when going forward - and
> of course I think we should also reject any newer platforms from using
> it.
>

The only way that we can achieve this IMO is to have quirks based on
platform compatible which needs to be updated and can be rejected for
newer platforms. New flags means new feature which is expected to be
supported for long and hard to control newer platforms not using them.

> >
> > > Just for the sake of completeness, I added a print to the psci.c to
> > > dump the result of the psci_set_osi_mode(false). It also returns
> > > NOT_SUPPORTED!
> > >
> >
> > Well it is simply broken then. Not tested firmware, so please don't
> > attempt to use OSI if it is so fundamentally broken. I find it hard to
> > accept the argument that well it works just that the query API is failing.
> > But what is the guarantee that it is tested well enough. We will end up
> > adding more quirks after adding one to enable it.
> >
> > > My logical assumption would be that the firmware reports support for
> > > OS_INITIATED, but then just fails to properly support
> > > SET_SUSPEND_MODE.
> >
> > I knew this argument was coming as I wrote above, sorry I don't buy that.
> > It is probably one of the early platforms supporting PSCI and not well tested
> > for conformance. So I am inclined to just say we can't support it.
> >
>
> As Dmitry also wrote in his other reply, the FW has certainly been
> well tested with the cluster idle states (acting like OSI mode has
> been enabled).
>

OK, fair enough if you are aware that is the case here.

> To me, it seems like a pity, if we just decided to leave all those
> devices out there in the field, lacking support for deeper idle
> states. Don't you think?
>

Sure, but I don't like new flags for handling this for reasons stated
above. Unless DT maintainers expect to take "new flag/property" for
some reasons that I am not aware of, I prefer the check on existing
platform compatible to deal with this problem so that this problem
doesn't trickle down to newer platforms as well. Thoughts ?

And please add that we can't add any compatibles that are added later
than certain date to that list when we are adding this support.

--
Regards,
Sudeep
