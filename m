Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A816A61444B
	for <lists+linux-pm@lfdr.de>; Tue,  1 Nov 2022 06:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiKAFc2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Nov 2022 01:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiKAFc2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Nov 2022 01:32:28 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7115F13CF8
        for <linux-pm@vger.kernel.org>; Mon, 31 Oct 2022 22:32:24 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id j14so19405539ljh.12
        for <linux-pm@vger.kernel.org>; Mon, 31 Oct 2022 22:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdL/ISy5Zbr0SGDfbtmA5pd1u678YR3PFy/v1pVzdjk=;
        b=KL6C4QlL0nWItXpy1+JXGv+UL+ngb1Jve16eJeZYomidHE+TulvJ75ZKDW90MYU3JP
         wQLiIRXxV3m61DW4RXuOMxPQeU2ke09eK6ATVhzOBGEm7oRq1w0kqZeEuGNMwZDbEN11
         AQoPfgv51hgkb9Uuqnr9/sZLpGzh4SD2T5VCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdL/ISy5Zbr0SGDfbtmA5pd1u678YR3PFy/v1pVzdjk=;
        b=trmtBCr/SoSCiipnCI22ObOlwhjzPYxgzv1IXp1W1wKy29E48zhuZx7sb4Sa7q/x4F
         nMie0EvxO/dM3PPyVyiKY4xyVEf5y0xo4fIWZ4Y1wW8iSHT5NEXxHTX3ROeqmkfqZioY
         tWnFmPVnLzEw0SnawDjiVBF6e+B4LfDiOLYuDO1zhPFjWIscsk4aIydBKjuBqfCFNWRY
         NTOl/ZRlApqhjlmTXy1au4ZgURSuOkyprnuqG315EYzZf4svLUrxlEjgHWbgMnoNIglx
         kvjuEHnjodXjAmp/pVX+jhSifwgIXvY3UD/s8M0ENrJqaVmYMHQEHAWr9FGPYMWwlxpp
         Aj3w==
X-Gm-Message-State: ACrzQf3QJjNYhU0INbrS3KJO1f1VhNE8dary/8LBgTRuMtxD0U7TCaJo
        ubUgk1FBdTmKtYwXnxbTS0GMnwRMfnQ1OnJ3pYbM8Q==
X-Google-Smtp-Source: AMsMyM64CqMkXZ2Qn0l8GVDv/0F99c4SYyq6g1f6T+ecC0miETvv3w40/45jz4Mt+SrTVFOsSjWkim6KHSa4Sl3wN3Q=
X-Received: by 2002:a2e:8011:0:b0:277:4031:95b1 with SMTP id
 j17-20020a2e8011000000b00277403195b1mr393968ljg.277.1667280742680; Mon, 31
 Oct 2022 22:32:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Oct 2022 22:32:21 -0700
MIME-Version: 1.0
In-Reply-To: <CAA8EJprYe+wFC6b0ryKRzUF4WE9pz28gT_+60SZ=S-NmRfsbsQ@mail.gmail.com>
References: <CAE-0n52xbZeJ66RaKwggeRB57fUAwjvxGxfFMKOKJMKVyFTe+w@mail.gmail.com>
 <CAPDyKFpay0w6n6rtv+bsdcTvL4ijtEPBODo1=XJpUFNdaooTcg@mail.gmail.com>
 <CAE-0n52Bfe-7Fpawct=_3=miLBygR_-YXm1YPnhCWOwxFnjv7g@mail.gmail.com>
 <9a696c92-eac2-e8fc-5081-8feb9c6150c1@linaro.org> <CAE-0n50b+h_1tojmw-u0uMkmAHP_=-Kxx=oUURfn52gTv99KaA@mail.gmail.com>
 <CAA8EJprYe+wFC6b0ryKRzUF4WE9pz28gT_+60SZ=S-NmRfsbsQ@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 31 Oct 2022 22:32:21 -0700
Message-ID: <CAE-0n50MB+r8DBZGSM3VyWnVBAPbD=-pqY7quNwtgRLrCoAMqA@mail.gmail.com>
Subject: Re: clk: qcom: genpd lockdep warning in gdsc
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Yu Zhao <yuzhao@google.com>, linux-arm-msm@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Dmitry Baryshkov (2022-10-31 18:08:49)
> On Tue, 1 Nov 2022 at 03:43, Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Dmitry Baryshkov (2022-10-27 11:13:44)
> > > On 27/10/2022 01:18, Stephen Boyd wrote:
> > > > Reviving this old thread because this commit has lead to a couple bugs
> > > > now.
> > > >
> > > > Quoting Ulf Hansson (2022-06-22 03:26:52)
> > > >> On Fri, 17 Jun 2022 at 21:58, Stephen Boyd <swboyd@chromium.org> wrote:
> > > >>>
> > > >>> Hi Bjorn and Dmitry,
> > > >>>
> > > >>> Yu reported a lockdep warning coming from the gdsc driver. It looks like
> > > >>> the runtime PM usage in gdsc.c is causing lockdep to see an AA deadlock
> > > >>> possibility with 'genpd->mlock'. I suspect this is because we have
> > > >>> commit 1b771839de05 ("clk: qcom: gdsc: enable optional power domain
> > > >>> support"), and that is now calling runtime PM code from within the genpd
> > > >>> code.
> > > >
> > > > This commit has caused a deadlock at boot for Doug[1] and I see that the
> > > > camera driver on Google CoachZ and Wormdingler devices doesn't work
> > > > after resuming from suspend once this commit is applied. I'm leaning
> > > > towards sending a revert, because it seems to cause 3 issues while
> > > > removing the regulator hack that was in place to enable MMCX. This patch
> > > > is cleaning up the hack, but trading the hack for three more problems.
> > > >
> > > >> I think genpd already has nested lock support, so the only
> > > >>> solution is to not use runtime PM from within genpd code and start
> > > >>> expressing genpd parent relationships in genpd itself?
> > > >>
> > > >> Not sure exactly what you mean here, but yes, expressing the
> > > >> parent/child domain relationship is always needed.
> > > >>
> > > >> Having gdsc_disable() to do runtime PM calls (gdsc_pm_runtime_put())
> > > >> seems awkward to me. Why is that needed, more exactly?
> > > >
> > > > It seems like this is needed so that the gdsc_enable() and
> > > > gdsc_disable() calls can read/write the registers for the genpd, while
> > > > those registers live in some clk controller that needs either a
> > > > different clk (probably some AHB clk) or another genpd to be enabled. It
> > > > looks like for qcom,sm8250-dispcc it relies on MMCX gdsc (which is a
> > > > genpd). From a hardware view, the MDSS_GDSC provided by the display clk
> > > > controller is probably not a sub-domain of MMCX. Instead, we need to
> > > > have MMCX enabled so that we can access the registers for the MDSS GDSC.
> > >
> > > Yes, exactly.
> >
> > Thanks for confirming. I've debugged further and found that we can't use
> > runtime PM calls here in the gdsc enable/disable functions at all. What
> > happens is runtime PM is disabled during device late suspend (see
> > __device_suspend_late() and how it calls __pm_runtime_disable() early
> > on). All genpds are assigned noirq phase suspend/resume operations that
> > will power on and off the genpd during system wide suspend/resume (see
> > the genpd->domain.ops assignments in pm_genpd_init() and how noirq PM
> > ops are used).
> >
> > When it comes time to resume the system, we'll try to enable the gdsc,
> > and call into gdsc_enable() which will try to call pm_runtime APIs on
> > the parent clk controller during the noirq phase of resume and that is
> > doomed to fail.
> >
> > >
> > > >
> > > > My question is if it makes sense to simply describe that the GDSCs
> > > > provided by a device are sub-domains of whatever power domains are
> > > > listed in DT for that device? I think if we did that here for sm8250
> > > > dispcc, we wouldn't need to use runtime PM within the genpd code
> > > > assuming that the MMCX parent genpd is enabled before we attempt to
> > > > read/write the dispcc gdsc registers. Hopefully that is also done, i.e.
> > > > enabling parent domains before enabling child domains if the parent is
> > > > disabled.
> > >
> > > I will check this tomorrow. It should be possible to handle the
> > > MMCX/MDSS_GDSC relationship in this way.
> > >
> > > > Is this already being done with pm_genpd_add_subdomain() in
> > > > gdsc_register()? I see that we're attaching that to dispcc's struct
> > > > device::pm_domain, but I assume that is different from the MMCX genpd.
> > >
> > > No, I think the only domain there is the MMCX domain, so this call s
> > >
> >
> > Did this get deleted?
>
> No, the regulator was deleted. But for some time we had the following
> in display and video clock controller nodes:
>
> power-domains = <&rpmhpd SM8250_MMCX>;
> required-opps = <&rpmhpd_opp_low_svs>;

The sentence got cut off for me so I was looking for the rest of it.

>
> >
> > > > Maybe that is the problem here. Dmitry can you further describe the
> > > > problem being solved?
> > >
> > > I must admit, I don't remember what caused me to add this call. May be
> > > it was added before me getting the pm_genpd_add_subdomain() call in place.
> > >
> >
> > I see that the 'dev->pm_domain' pointer isn't assigned unless I have a
> > 'power-domains = <&some_pd>' property in DT for the clock controller
> > registering GDSCs. This means that a driver using the pm clock APIs
> > isn't populating 'dev->pm_domain' and thus the clks for the device
> > aren't enabled when this gdsc is enabled.
>
> We were looking for the opposite way: to enable the power domain, when
> the GDSC (and clocks) are accessed.
> The bus clocks (DISP_CC_XO_CLK, GCC_DISP_AHB_CLK, etc.) are hardwired
> into the on state forever.

Alright cool. If that's true then you don't care about the combined
power-domain in DT and pm clk domain problem?

>
> > There is a GENPD_FLAG_PM_CLK flag that we could try, but
> > genpd_resume_noirq() calls genpd_sync_power_on() before calling
> > genpd_start_dev(), and the device it is trying to start there is the
> > wrong device, it is the consumer of the gdsc. That looks like a
> > dead-end.
>
> I see.
>
> [skipped the pm_clk part. I might be wrong, but I don't think it's
> relevant. We have to enable the GDSC, but not the clocks to enable the
> access.]
>
> > This problem exposes that the power-domains that we implement for GDSCs
> > are not "complete". If we listed the clocks required for the domain to
> > operate properly, then we would be able to attach those to the gdsc's
> > genpd and have one power domain that represents everything for the
> > device in DT. Of course, if the device itself had some sort of "freeze"
> > or "lock" register that caused the device to not work unless you
> > unlocked it by writing a special value then we would need to also start
> > the device in the PM domain. I don't see any sort of call to start
> > parent devices in genpd_resume_noirq(), so I don't know how this would
> > work. Luckily I don't have this problem today, but I'm just thinking of
> > how we slice up the genpd code and the device specific code and hook
> > that all into genpd.
> >
> > In a sense, we want to resume the device that is providing the genpd,
> > but that isn't happening here. Instead, we're noirq resuming a genpd
> > while the provider of that genpd is still suspended. I think typically
> > genpds are registered by a bus entity that is "always on" and doesn't
> > need to power manage itself. That disconnect is where we're getting into
> > trouble.
>
> I think that genpd's are registered in the logical order. So the
> parents are resumed before the child because they come earlier in the
> device list. Is my assumption correct?

Any parent links are resumed before the child genpd is resumed. It's not
based on registration order of the genpds. It's based on the device PM
list order of the devices that use the genpds. Only the genpds that are
attached to a device will be resumed, and those will resume their parent
(and grandparent) genpds.

>
> > TL;DR: This patch seems fairly broken. It works only for boot time probe
> > and then breaks suspend/resume. I think we should revert it and work on
> > a proper solution. Can we do that? Or are there DT dependencies stacked
> > on top to move away from the regulator design?
>
> No, the regulators are completely removed. I think I still need to
> send the revert for the fixed-regulator driver, but the code is not
> used anyway.

Alright :/

>
> Just reverting the commit would kill the display & video on all recent
> platforms. We can mark MMCX as ALWAYS_ON for some time.
> However I'd like to try if anything is necessary at all to fix this
> issue. I suppose that setting up the subdomain should be enough, but
> I'd like to run some thorough tests before declaring the result.
>

Can you try this patch? If you only need to make sure the GDSC is
enabled for MMCX (and the other clks are always on) and 'power-domains =
<&mmcc MMCX>' is in DT then I think the code that sets up the gdscs as
subdomains of the device should already be sufficient. Maybe you need to
also set the runtime PM state as active in the clk driver probe when a
GDSC is found to be enabled at driver probe time. Hopefully that isn't
necessary though and the subdomain can sync enable state to the parent
domain when registered.

---8<---
diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 7cf5e130e92f..ee2aa6cbf7fd 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -56,22 +56,6 @@ enum gdsc_status {
 	GDSC_ON
 };

-static int gdsc_pm_runtime_get(struct gdsc *sc)
-{
-	if (!sc->dev)
-		return 0;
-
-	return pm_runtime_resume_and_get(sc->dev);
-}
-
-static int gdsc_pm_runtime_put(struct gdsc *sc)
-{
-	if (!sc->dev)
-		return 0;
-
-	return pm_runtime_put_sync(sc->dev);
-}
-
 /* Returns 1 if GDSC status is status, 0 if not, and < 0 on error */
 static int gdsc_check_status(struct gdsc *sc, enum gdsc_status status)
 {
@@ -271,8 +255,9 @@ static void gdsc_retain_ff_on(struct gdsc *sc)
 	regmap_update_bits(sc->regmap, sc->gdscr, mask, mask);
 }

-static int _gdsc_enable(struct gdsc *sc)
+static int gdsc_enable(struct generic_pm_domain *domain)
 {
+	struct gdsc *sc = domain_to_gdsc(domain);
 	int ret;

 	if (sc->pwrsts == PWRSTS_ON)
@@ -328,22 +313,11 @@ static int _gdsc_enable(struct gdsc *sc)
 	return 0;
 }

-static int gdsc_enable(struct generic_pm_domain *domain)
+static int gdsc_disable(struct generic_pm_domain *domain)
 {
 	struct gdsc *sc = domain_to_gdsc(domain);
 	int ret;

-	ret = gdsc_pm_runtime_get(sc);
-	if (ret)
-		return ret;
-
-	return _gdsc_enable(sc);
-}
-
-static int _gdsc_disable(struct gdsc *sc)
-{
-	int ret;
-
 	if (sc->pwrsts == PWRSTS_ON)
 		return gdsc_assert_reset(sc);

@@ -388,18 +362,6 @@ static int _gdsc_disable(struct gdsc *sc)
 	return 0;
 }

-static int gdsc_disable(struct generic_pm_domain *domain)
-{
-	struct gdsc *sc = domain_to_gdsc(domain);
-	int ret;
-
-	ret = _gdsc_disable(sc);
-
-	gdsc_pm_runtime_put(sc);
-
-	return ret;
-}
-
 static int gdsc_init(struct gdsc *sc)
 {
 	u32 mask, val;
@@ -447,11 +409,6 @@ static int gdsc_init(struct gdsc *sc)
 				return ret;
 		}

-		/* ...and the power-domain */
-		ret = gdsc_pm_runtime_get(sc);
-		if (ret)
-			goto err_disable_supply;
-
 		/*
 		 * Votable GDSCs can be ON due to Vote from other masters.
 		 * If a Votable GDSC is ON, make sure we have a Vote.
@@ -459,14 +416,14 @@ static int gdsc_init(struct gdsc *sc)
 		if (sc->flags & VOTABLE) {
 			ret = gdsc_update_collapse_bit(sc, false);
 			if (ret)
-				goto err_put_rpm;
+				goto err_disable_supply;
 		}

 		/* Turn on HW trigger mode if supported */
 		if (sc->flags & HW_CTRL) {
 			ret = gdsc_hwctrl(sc, true);
 			if (ret < 0)
-				goto err_put_rpm;
+				goto err_disable_supply;
 		}

 		/*
@@ -495,14 +452,11 @@ static int gdsc_init(struct gdsc *sc)
 		sc->pd.power_on = gdsc_enable;

 	ret = pm_genpd_init(&sc->pd, NULL, !on);
-	if (ret)
-		goto err_put_rpm;
+	if (!ret)
+		goto err_disable_supply;

 	return 0;

-err_put_rpm:
-	if (on)
-		gdsc_pm_runtime_put(sc);
 err_disable_supply:
 	if (on && sc->rsupply)
 		regulator_disable(sc->rsupply);
@@ -541,8 +495,7 @@ int gdsc_register(struct gdsc_desc *desc,
 	for (i = 0; i < num; i++) {
 		if (!scs[i])
 			continue;
-		if (pm_runtime_enabled(dev))
-			scs[i]->dev = dev;
+		scs[i]->dev = dev;
 		scs[i]->regmap = regmap;
 		scs[i]->rcdev = rcdev;
 		ret = gdsc_init(scs[i]);
