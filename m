Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E785F6142A9
	for <lists+linux-pm@lfdr.de>; Tue,  1 Nov 2022 02:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiKABJD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Oct 2022 21:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiKABJC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Oct 2022 21:09:02 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDC2264D
        for <linux-pm@vger.kernel.org>; Mon, 31 Oct 2022 18:09:01 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id f205so15725020yba.2
        for <linux-pm@vger.kernel.org>; Mon, 31 Oct 2022 18:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4jYhgCXnVodbNWDB2rRTz9iSRZip5q9Zs/8Yq6qfrHM=;
        b=x6PkcIYxeIZhkNJNh5PTLKkgMpXohVquQ49iwWeF2wxBSryknEyu5TWkM//H1HiUgQ
         ieY1wVwZYrmOMOsomSu0Fu75n5ys7qGEtABaz3/LKgQVCJf9SWcyi8GVM1HwbKfWuQAv
         QdnJ2viFa4VL1DuWUbHwkUZHv54rFGY+6eMrS1u9eM3WjsniErAPXueZB6jdStD2XWL5
         aWHcoKQeXoY4ovvyLveMemrPn6mLRS5HIMeugtaDX43XpgjBs0Mq/reY8mSBePuIueiz
         F0yCA2DyGTz53cBXLpbr/FxDKIgkSv698eJf5+S5KvEtjJc8Msh6YofWMEdsEm11+DFT
         P2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4jYhgCXnVodbNWDB2rRTz9iSRZip5q9Zs/8Yq6qfrHM=;
        b=InAUIG6J0kOboXunNUh1+x4F/gYDcHx/bfKOgoXyGBD6U69rVjssen5D5WwuwJ6Y11
         y9ID00fmFtSSbvbwM747e5q087bF6wv6VFtjF8oTmXprPy+x+W7nIJ19lQuNz6G9Dg+A
         VhxDjIgqnsso3gEqkObEFxwh50dNO0i9FiTFZR4kvDZtdvWofFUCqGRyf+SQYbbjvxhx
         amxPsdoLRK/lAtAVWWwVXDjl7Ej1L8BrR3mk0r9KQ7xiEVj4iqJtmziIhT9LSSdyws1O
         oJBc2uTjEJFU/MRyyXVygiliku/x1uf8Cg3brpKtrJXUEKOnikFGUyXS7mnQ/hwgaLKG
         meIQ==
X-Gm-Message-State: ACrzQf2oT/HlLF/Iq/x6meiKIiw9dQKszHdfFHFC0+kP5MmW4eT9XCvd
        BUI+39MQJrR/iHVUZLHrV2o581D6QzVmZYOLZENEYw==
X-Google-Smtp-Source: AMsMyM6WVPAsBcmF9m+QrqRbQ3a5gBKgI80Q1OWpN7PGMglpP4zNDlPpv8DvBx8a5TAQc25GaT97kwMaOmuXaDeLmvE=
X-Received: by 2002:a25:ba45:0:b0:67a:6298:7bac with SMTP id
 z5-20020a25ba45000000b0067a62987bacmr16839119ybj.194.1667264940414; Mon, 31
 Oct 2022 18:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAE-0n52xbZeJ66RaKwggeRB57fUAwjvxGxfFMKOKJMKVyFTe+w@mail.gmail.com>
 <CAPDyKFpay0w6n6rtv+bsdcTvL4ijtEPBODo1=XJpUFNdaooTcg@mail.gmail.com>
 <CAE-0n52Bfe-7Fpawct=_3=miLBygR_-YXm1YPnhCWOwxFnjv7g@mail.gmail.com>
 <9a696c92-eac2-e8fc-5081-8feb9c6150c1@linaro.org> <CAE-0n50b+h_1tojmw-u0uMkmAHP_=-Kxx=oUURfn52gTv99KaA@mail.gmail.com>
In-Reply-To: <CAE-0n50b+h_1tojmw-u0uMkmAHP_=-Kxx=oUURfn52gTv99KaA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 1 Nov 2022 04:08:49 +0300
Message-ID: <CAA8EJprYe+wFC6b0ryKRzUF4WE9pz28gT_+60SZ=S-NmRfsbsQ@mail.gmail.com>
Subject: Re: clk: qcom: genpd lockdep warning in gdsc
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Yu Zhao <yuzhao@google.com>, linux-arm-msm@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 1 Nov 2022 at 03:43, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Dmitry Baryshkov (2022-10-27 11:13:44)
> > On 27/10/2022 01:18, Stephen Boyd wrote:
> > > Reviving this old thread because this commit has lead to a couple bugs
> > > now.
> > >
> > > Quoting Ulf Hansson (2022-06-22 03:26:52)
> > >> On Fri, 17 Jun 2022 at 21:58, Stephen Boyd <swboyd@chromium.org> wrote:
> > >>>
> > >>> Hi Bjorn and Dmitry,
> > >>>
> > >>> Yu reported a lockdep warning coming from the gdsc driver. It looks like
> > >>> the runtime PM usage in gdsc.c is causing lockdep to see an AA deadlock
> > >>> possibility with 'genpd->mlock'. I suspect this is because we have
> > >>> commit 1b771839de05 ("clk: qcom: gdsc: enable optional power domain
> > >>> support"), and that is now calling runtime PM code from within the genpd
> > >>> code.
> > >
> > > This commit has caused a deadlock at boot for Doug[1] and I see that the
> > > camera driver on Google CoachZ and Wormdingler devices doesn't work
> > > after resuming from suspend once this commit is applied. I'm leaning
> > > towards sending a revert, because it seems to cause 3 issues while
> > > removing the regulator hack that was in place to enable MMCX. This patch
> > > is cleaning up the hack, but trading the hack for three more problems.
> > >
> > >> I think genpd already has nested lock support, so the only
> > >>> solution is to not use runtime PM from within genpd code and start
> > >>> expressing genpd parent relationships in genpd itself?
> > >>
> > >> Not sure exactly what you mean here, but yes, expressing the
> > >> parent/child domain relationship is always needed.
> > >>
> > >> Having gdsc_disable() to do runtime PM calls (gdsc_pm_runtime_put())
> > >> seems awkward to me. Why is that needed, more exactly?
> > >
> > > It seems like this is needed so that the gdsc_enable() and
> > > gdsc_disable() calls can read/write the registers for the genpd, while
> > > those registers live in some clk controller that needs either a
> > > different clk (probably some AHB clk) or another genpd to be enabled. It
> > > looks like for qcom,sm8250-dispcc it relies on MMCX gdsc (which is a
> > > genpd). From a hardware view, the MDSS_GDSC provided by the display clk
> > > controller is probably not a sub-domain of MMCX. Instead, we need to
> > > have MMCX enabled so that we can access the registers for the MDSS GDSC.
> >
> > Yes, exactly.
>
> Thanks for confirming. I've debugged further and found that we can't use
> runtime PM calls here in the gdsc enable/disable functions at all. What
> happens is runtime PM is disabled during device late suspend (see
> __device_suspend_late() and how it calls __pm_runtime_disable() early
> on). All genpds are assigned noirq phase suspend/resume operations that
> will power on and off the genpd during system wide suspend/resume (see
> the genpd->domain.ops assignments in pm_genpd_init() and how noirq PM
> ops are used).
>
> When it comes time to resume the system, we'll try to enable the gdsc,
> and call into gdsc_enable() which will try to call pm_runtime APIs on
> the parent clk controller during the noirq phase of resume and that is
> doomed to fail.
>
> >
> > >
> > > My question is if it makes sense to simply describe that the GDSCs
> > > provided by a device are sub-domains of whatever power domains are
> > > listed in DT for that device? I think if we did that here for sm8250
> > > dispcc, we wouldn't need to use runtime PM within the genpd code
> > > assuming that the MMCX parent genpd is enabled before we attempt to
> > > read/write the dispcc gdsc registers. Hopefully that is also done, i.e.
> > > enabling parent domains before enabling child domains if the parent is
> > > disabled.
> >
> > I will check this tomorrow. It should be possible to handle the
> > MMCX/MDSS_GDSC relationship in this way.
> >
> > > Is this already being done with pm_genpd_add_subdomain() in
> > > gdsc_register()? I see that we're attaching that to dispcc's struct
> > > device::pm_domain, but I assume that is different from the MMCX genpd.
> >
> > No, I think the only domain there is the MMCX domain, so this call s
> >
>
> Did this get deleted?

No, the regulator was deleted. But for some time we had the following
in display and video clock controller nodes:

power-domains = <&rpmhpd SM8250_MMCX>;
required-opps = <&rpmhpd_opp_low_svs>;

>
> > > Maybe that is the problem here. Dmitry can you further describe the
> > > problem being solved?
> >
> > I must admit, I don't remember what caused me to add this call. May be
> > it was added before me getting the pm_genpd_add_subdomain() call in place.
> >
>
> I see that the 'dev->pm_domain' pointer isn't assigned unless I have a
> 'power-domains = <&some_pd>' property in DT for the clock controller
> registering GDSCs. This means that a driver using the pm clock APIs
> isn't populating 'dev->pm_domain' and thus the clks for the device
> aren't enabled when this gdsc is enabled.

We were looking for the opposite way: to enable the power domain, when
the GDSC (and clocks) are accessed.
The bus clocks (DISP_CC_XO_CLK, GCC_DISP_AHB_CLK, etc.) are hardwired
into the on state forever.

> There is a GENPD_FLAG_PM_CLK flag that we could try, but
> genpd_resume_noirq() calls genpd_sync_power_on() before calling
> genpd_start_dev(), and the device it is trying to start there is the
> wrong device, it is the consumer of the gdsc. That looks like a
> dead-end.

I see.

[skipped the pm_clk part. I might be wrong, but I don't think it's
relevant. We have to enable the GDSC, but not the clocks to enable the
access.]

> This problem exposes that the power-domains that we implement for GDSCs
> are not "complete". If we listed the clocks required for the domain to
> operate properly, then we would be able to attach those to the gdsc's
> genpd and have one power domain that represents everything for the
> device in DT. Of course, if the device itself had some sort of "freeze"
> or "lock" register that caused the device to not work unless you
> unlocked it by writing a special value then we would need to also start
> the device in the PM domain. I don't see any sort of call to start
> parent devices in genpd_resume_noirq(), so I don't know how this would
> work. Luckily I don't have this problem today, but I'm just thinking of
> how we slice up the genpd code and the device specific code and hook
> that all into genpd.
>
> In a sense, we want to resume the device that is providing the genpd,
> but that isn't happening here. Instead, we're noirq resuming a genpd
> while the provider of that genpd is still suspended. I think typically
> genpds are registered by a bus entity that is "always on" and doesn't
> need to power manage itself. That disconnect is where we're getting into
> trouble.

I think that genpd's are registered in the logical order. So the
parents are resumed before the child because they come earlier in the
device list. Is my assumption correct?

> TL;DR: This patch seems fairly broken. It works only for boot time probe
> and then breaks suspend/resume. I think we should revert it and work on
> a proper solution. Can we do that? Or are there DT dependencies stacked
> on top to move away from the regulator design?

No, the regulators are completely removed. I think I still need to
send the revert for the fixed-regulator driver, but the code is not
used anyway.

Just reverting the commit would kill the display & video on all recent
platforms. We can mark MMCX as ALWAYS_ON for some time.
However I'd like to try if anything is necessary at all to fix this
issue. I suppose that setting up the subdomain should be enough, but
I'd like to run some thorough tests before declaring the result.

-- 
With best wishes
Dmitry
