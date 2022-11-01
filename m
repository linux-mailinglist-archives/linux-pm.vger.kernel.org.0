Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7CD614265
	for <lists+linux-pm@lfdr.de>; Tue,  1 Nov 2022 01:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiKAAnT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Oct 2022 20:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKAAnS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Oct 2022 20:43:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A5115FD0
        for <linux-pm@vger.kernel.org>; Mon, 31 Oct 2022 17:43:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o12so21660084lfq.9
        for <linux-pm@vger.kernel.org>; Mon, 31 Oct 2022 17:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0Mn6UUyn2POrZdflNpCqerE8BuvzKjwaM2cng/uy+8=;
        b=amzzn0Xd3AhUBH4uuqjtr75nN6/YOpgMpVtin0zTna3Nb8OU/UgJCWSx6LasscEe1u
         y3jQjvtBmOgSK04dUbImcWhz+KEQ0DSOhVAdc+XJ6tRlOuAxad27dKfrPMqBDEJbjQzz
         mHNtDz2Pvyw5W/C/qbY1oWkSLW23DGI3hw4Ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0Mn6UUyn2POrZdflNpCqerE8BuvzKjwaM2cng/uy+8=;
        b=FYcctjmwlnBXGWh+D3/QictGokZnqWPVkw5JWQyat4S+q09eMgIbYXfXe7ky3toS0X
         h3b/T1cbTEA9/7VvygbuEwjrzg9X0xHpPQy9sOnBSX9INl4med7/waiE2uEdtV3QaJau
         1wHd83YQluOVWB/Kaf0BpHyEtWSy5FihBjD+9Bqx8hLIMbnoCqYbIOEl3gh0cKTrexa6
         9L6/F+FrLhYy2QZe9gsSLMWgSORURg/Sqsm3FfWmUFMyHjCyxvobHGQQpmBJ4xCYEvzm
         +dBy12Wvlf9YPLk2BDcDrZF2F3ixVqrYLnQu9X5Zhe4/tCIDpdQRFrSZ++ShI5vy0Pyj
         iu5Q==
X-Gm-Message-State: ACrzQf3Goq9tCR1XjBTfxQtS5RhUFWOBajL0ACZZxLaGey47zNEgsBaO
        zuVaunEa7VMn7I9iY8t1JKMNYKOcoNyelAwQuMq+Mw==
X-Google-Smtp-Source: AMsMyM6lJhJnj6lqydNYNdWRz2TwLLKidbTAReBf++65kFH+LWYjaeDCIf8wZKfo9j9xkbp3qSWV5M1oGpPWgzbqBdE=
X-Received: by 2002:a05:6512:1592:b0:4a2:b56c:388e with SMTP id
 bp18-20020a056512159200b004a2b56c388emr15801lfb.145.1667263395579; Mon, 31
 Oct 2022 17:43:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Oct 2022 17:43:14 -0700
MIME-Version: 1.0
In-Reply-To: <9a696c92-eac2-e8fc-5081-8feb9c6150c1@linaro.org>
References: <CAE-0n52xbZeJ66RaKwggeRB57fUAwjvxGxfFMKOKJMKVyFTe+w@mail.gmail.com>
 <CAPDyKFpay0w6n6rtv+bsdcTvL4ijtEPBODo1=XJpUFNdaooTcg@mail.gmail.com>
 <CAE-0n52Bfe-7Fpawct=_3=miLBygR_-YXm1YPnhCWOwxFnjv7g@mail.gmail.com> <9a696c92-eac2-e8fc-5081-8feb9c6150c1@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 31 Oct 2022 17:43:14 -0700
Message-ID: <CAE-0n50b+h_1tojmw-u0uMkmAHP_=-Kxx=oUURfn52gTv99KaA@mail.gmail.com>
Subject: Re: clk: qcom: genpd lockdep warning in gdsc
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Yu Zhao <yuzhao@google.com>, linux-arm-msm@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Dmitry Baryshkov (2022-10-27 11:13:44)
> On 27/10/2022 01:18, Stephen Boyd wrote:
> > Reviving this old thread because this commit has lead to a couple bugs
> > now.
> >
> > Quoting Ulf Hansson (2022-06-22 03:26:52)
> >> On Fri, 17 Jun 2022 at 21:58, Stephen Boyd <swboyd@chromium.org> wrote:
> >>>
> >>> Hi Bjorn and Dmitry,
> >>>
> >>> Yu reported a lockdep warning coming from the gdsc driver. It looks like
> >>> the runtime PM usage in gdsc.c is causing lockdep to see an AA deadlock
> >>> possibility with 'genpd->mlock'. I suspect this is because we have
> >>> commit 1b771839de05 ("clk: qcom: gdsc: enable optional power domain
> >>> support"), and that is now calling runtime PM code from within the genpd
> >>> code.
> >
> > This commit has caused a deadlock at boot for Doug[1] and I see that the
> > camera driver on Google CoachZ and Wormdingler devices doesn't work
> > after resuming from suspend once this commit is applied. I'm leaning
> > towards sending a revert, because it seems to cause 3 issues while
> > removing the regulator hack that was in place to enable MMCX. This patch
> > is cleaning up the hack, but trading the hack for three more problems.
> >
> >> I think genpd already has nested lock support, so the only
> >>> solution is to not use runtime PM from within genpd code and start
> >>> expressing genpd parent relationships in genpd itself?
> >>
> >> Not sure exactly what you mean here, but yes, expressing the
> >> parent/child domain relationship is always needed.
> >>
> >> Having gdsc_disable() to do runtime PM calls (gdsc_pm_runtime_put())
> >> seems awkward to me. Why is that needed, more exactly?
> >
> > It seems like this is needed so that the gdsc_enable() and
> > gdsc_disable() calls can read/write the registers for the genpd, while
> > those registers live in some clk controller that needs either a
> > different clk (probably some AHB clk) or another genpd to be enabled. It
> > looks like for qcom,sm8250-dispcc it relies on MMCX gdsc (which is a
> > genpd). From a hardware view, the MDSS_GDSC provided by the display clk
> > controller is probably not a sub-domain of MMCX. Instead, we need to
> > have MMCX enabled so that we can access the registers for the MDSS GDSC.
>
> Yes, exactly.

Thanks for confirming. I've debugged further and found that we can't use
runtime PM calls here in the gdsc enable/disable functions at all. What
happens is runtime PM is disabled during device late suspend (see
__device_suspend_late() and how it calls __pm_runtime_disable() early
on). All genpds are assigned noirq phase suspend/resume operations that
will power on and off the genpd during system wide suspend/resume (see
the genpd->domain.ops assignments in pm_genpd_init() and how noirq PM
ops are used).

When it comes time to resume the system, we'll try to enable the gdsc,
and call into gdsc_enable() which will try to call pm_runtime APIs on
the parent clk controller during the noirq phase of resume and that is
doomed to fail.

>
> >
> > My question is if it makes sense to simply describe that the GDSCs
> > provided by a device are sub-domains of whatever power domains are
> > listed in DT for that device? I think if we did that here for sm8250
> > dispcc, we wouldn't need to use runtime PM within the genpd code
> > assuming that the MMCX parent genpd is enabled before we attempt to
> > read/write the dispcc gdsc registers. Hopefully that is also done, i.e.
> > enabling parent domains before enabling child domains if the parent is
> > disabled.
>
> I will check this tomorrow. It should be possible to handle the
> MMCX/MDSS_GDSC relationship in this way.
>
> > Is this already being done with pm_genpd_add_subdomain() in
> > gdsc_register()? I see that we're attaching that to dispcc's struct
> > device::pm_domain, but I assume that is different from the MMCX genpd.
>
> No, I think the only domain there is the MMCX domain, so this call s
>

Did this get deleted?

> > Maybe that is the problem here. Dmitry can you further describe the
> > problem being solved?
>
> I must admit, I don't remember what caused me to add this call. May be
> it was added before me getting the pm_genpd_add_subdomain() call in place.
>

I see that the 'dev->pm_domain' pointer isn't assigned unless I have a
'power-domains = <&some_pd>' property in DT for the clock controller
registering GDSCs. This means that a driver using the pm clock APIs
isn't populating 'dev->pm_domain' and thus the clks for the device
aren't enabled when this gdsc is enabled.

There is a GENPD_FLAG_PM_CLK flag that we could try, but
genpd_resume_noirq() calls genpd_sync_power_on() before calling
genpd_start_dev(), and the device it is trying to start there is the
wrong device, it is the consumer of the gdsc. That looks like a
dead-end.

We really need some sort of way to mix pm clks with DT power-domains and
tie that all up into some struct generic_pm_domain that turns on the DT
power-domain along with the clks needed for the device to be accessible.
If we had that domain we could then attach the GDSCs registered here as
subdomains of that domain so that we didn't use runtime PM APIs.
Possibly we can make a struct generic_pm_domain in the drivers that need
this and have it call pm_clk_resume() directly and set the domain with
dev_pm_domain_set()? I believe that runs into a problem though if we
have a power-domain in DT and want to use pm_clks as well. The
power-domain from DT will be auto-attached during probe and we don't
want to do that.

This problem exposes that the power-domains that we implement for GDSCs
are not "complete". If we listed the clocks required for the domain to
operate properly, then we would be able to attach those to the gdsc's
genpd and have one power domain that represents everything for the
device in DT. Of course, if the device itself had some sort of "freeze"
or "lock" register that caused the device to not work unless you
unlocked it by writing a special value then we would need to also start
the device in the PM domain. I don't see any sort of call to start
parent devices in genpd_resume_noirq(), so I don't know how this would
work. Luckily I don't have this problem today, but I'm just thinking of
how we slice up the genpd code and the device specific code and hook
that all into genpd.

In a sense, we want to resume the device that is providing the genpd,
but that isn't happening here. Instead, we're noirq resuming a genpd
while the provider of that genpd is still suspended. I think typically
genpds are registered by a bus entity that is "always on" and doesn't
need to power manage itself. That disconnect is where we're getting into
trouble.

TL;DR: This patch seems fairly broken. It works only for boot time probe
and then breaks suspend/resume. I think we should revert it and work on
a proper solution. Can we do that? Or are there DT dependencies stacked
on top to move away from the regulator design?
