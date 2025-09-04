Return-Path: <linux-pm+bounces-33874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEC2B4449C
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 19:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 594697B7FF4
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 17:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA4D3148D4;
	Thu,  4 Sep 2025 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Ez7nAOB8"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408653128CC;
	Thu,  4 Sep 2025 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007739; cv=pass; b=C6Y4zLdwcCx8vO5aSXrw/+aFlJ9KiymURNo6k/yix4s84QUL9HoUUsd9PxbXbEoXkIhH8dhy83GDCusSQp5uFADJ9kN9SBxb1dRbyj+zPeAIDU+Aw/5fcE3uQ5pAsB0lnMQ+sOb5vY0FxGNvz6/mngSnOQMfoEC8Gx48DQFHgN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007739; c=relaxed/simple;
	bh=Vd4qQD8+IjTGivAE8rmex+jnFOLnSnLiVaR3vfhhDQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLpqFFfvPPLHyvTlMNdRoQEi0B0pP08eSpsQEU7ISy1RnB7AREZrXT5c0VfECvEiDgDReKlFY2D/oJ82mRZmLHsSX5uHonABQlmC8T7bABadKZ301Gl0b28BIgl/kXaZCKHnrAFAFz1uzD58FlskUy62acbRNLvkKNN9LqZRdAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Ez7nAOB8; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757007718; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Zdo6MRctqTOrOH416fpEhDRw1/VWIcbVhU1RoxWLoNH7orDOWrVEfp2rZNmaW3qTACYQujgy8jkwXbC6+4Aem41rEfG8nH25tUGQyr12F/tPJk0VY1tOHgVa79i1Nl+EHrRP84wFxMVcLDSvmTAlptAMxj930AaUY4j//fT1BW4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757007718; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LVYfyMgtMeKqiCnD9iiYDvuv97L2Kz1xh9U0SIoYoaU=; 
	b=YpjVjXC+IFwmBXZWzwsP1Mk22ugNQR/BhrWyxtVDsuDlXsQ8mchKbBoWkrn/YKpYNhAYR8fii+dum6tKoiJ3avgu3O2YSVHFmdry/9mQdbmlin76MNUGAQOEpiUT5CQB5Cu+qRKdbFx6ciUTWRnL2FqH2jwuFg4AxHrq8qhZgMs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757007718;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=LVYfyMgtMeKqiCnD9iiYDvuv97L2Kz1xh9U0SIoYoaU=;
	b=Ez7nAOB87quV3O0FaR9nWmSQsCTofHg5Lh2HcoN8RBimirM/iIZBciuf7FtvH4In
	Ay2RJockCtLin9AVS9gyCuxb8WBifjI5aSVvIlkpFUuyjvXWVzqi248pD9HsoIXFpzX
	sFQ/PbEjDHr04YbYE4tsq9u3q8ruSEgNJpYeLbV8=
Received: by mx.zohomail.com with SMTPS id 1757007717717119.86464164297934;
	Thu, 4 Sep 2025 10:41:57 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, linux-rockchip@lists.infradead.org,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] pmdomian: core: don't unset stay_on during sync_state
Date: Thu, 04 Sep 2025 19:41:54 +0200
Message-ID: <25561818.ouqheUzb2q@workhorse>
In-Reply-To:
 <CAPDyKFqBgKxhUCaNwUAMHUKorCPH44AfCe1VncO7jU-soy39Dg@mail.gmail.com>
References:
 <20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com>
 <3332408.jE0xQCEvom@workhorse>
 <CAPDyKFqBgKxhUCaNwUAMHUKorCPH44AfCe1VncO7jU-soy39Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 4 September 2025 18:13:22 Central European Summer Time Ulf Hansson wrote:
> On Thu, 4 Sept 2025 at 14:50, Nicolas Frattaroli
> <nicolas.frattaroli@collabora.com> wrote:
> >
> > On Thursday, 4 September 2025 11:17:01 Central European Summer Time Ulf Hansson wrote:
> > > On Tue, 2 Sept 2025 at 20:23, Nicolas Frattaroli
> > > <nicolas.frattaroli@collabora.com> wrote:
> > > >
> > > > This reverts commit de141a9aa52d6b2fbeb63f98975c2c72276f0878.
> > >
> > > I can't find this commit hash. What tree are you using when testing this?
> > >
> > > Are you trying to revert 0e789b491ba04c31de5c71249487593e386baa67 ?
> >
> > Probably, I did the revert on a rebased branch and then rebased the revert
> > onto v6.17-rc4 so it likely is the wrong hash here. I'll fix this in v2 if
> > there is a v2 (it might actually become a different patch, see huge text
> > below, sorry!)
> >
> > >
> > > >
> > > > On RK3576, the UFS controller's power domain has a quirk that requires
> > > > it to stay enabled, infrastricture for which was added in Commit
> > > > cd3fa304ba5c ("pmdomain: core: Introduce dev_pm_genpd_rpm_always_on()").
> > > >
> > > > Unfortunately, Commit de141a9aa52d ("pmdomain: core: Leave powered-on
> > > > genpds on until sync_state") appears to break this quirk wholesale. The
> > > > result is that RK3576 devices with the UFS controller enabled but unused
> > > > will freeze once pmdomain shuts off unused domains.
> > > >
> > > > Revert it until a better fix can be found.
> > >
> > > This sounds a bit vague to me, can you please clarify and elaborate a
> > > bit more so I can try to help.
> > >
> > > What does "UFS controller enabled but unused" actually mean? Has the
> > > UFS controller driver been probed successfully and thus its
> > > corresponding device been attached to its PM domain?
> >
> > It means the UFS controller driver has probed, but does not find a
> > UFS storage chip connected to it, and therefore reports a probe
> > failure. This is a possibility on single-board computers like the
> > Radxa ROCK 4D, where the UFS storage is a separate module that plugs
> > into some headers.
> >
> > > Moreover, the behaviour of dev_pm_genpd_rpm_always_on() is orthogonal
> > > to what 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on
> > > until sync_state") brings along with its corresponding sync_state
> > > series for genpd [1]. Again, more information is needed to understand
> > > what goes wrong.
> >
> > The reason why Rockchip's UFS driver needs this function is that once
> > the RK3576_PD_USB power domain is turned on on the RK3576 SoC, it should
> > not be toggled off again until a whole SoC suspend/resume cycle because
> > the off/on operation is seemingly not idempotent.
> 
> So how about adding some prints in the genpd->power_on|off() callbacks
> to see what goes on during boot. Along with some prints in the UFS
> driver's ->probe().
> 
> In particular, what is the difference before and after the revert.

See my reply to myself, the problem is that power_off() is never called
before the revert. UFS was a red herring, it just changes the timings,
the real culprit is the NPU PD.

After the revert, the NPU domains do get powered off way before the regulator
ever gets touched. I've narrowed it down to just the npu PDs by doing an strstr
in the unused power domains function on the PD name for "npu".

> 
> > This does not preclude
> > turning off the power domain if the device isn't used at all, e.g. the DT
> > node is absent. This is why the affected PDs are not marked as always-on
> > in the PD init data for the SoC, as the device driver is the best place to
> > set this during runtime.
> >
> > The way I got to this commit is through a bisect between the UFS node
> > being enabled on the ROCK 4D (commit 00abee2b18342d6c2f6f37225682fa7ca0d33142)
> > and v6.17-rc4. The bisect landed on the pmdomain merge commit
> > (commit fc8f5028eb0cc5aee0501a99f59a04f748fbff1c) as the first bad commit,
> > so I checked out v6.16, cherry-picked the UFS node enablement, made sure it
> > works fine with that, and then rebased the 44 pmdomain commits that this
> > merge commit merged onto this base. I verified that the tip of that then
> > exhibited the faulty behaviour, namely that my ROCK 4D was locking up
> > some time after boot, right after the kernel log message
> >
> >     [   33.756516] vdd_npu_s0: disabling
> >
> > so presumably when unused regulators and domains were being disabled.
> > Aside note: setting vdd_npu_s0 to always-on also works to work around
> > the issue, and I'm not quite sure why, because this regulator is not
> > used for anything right now so this may be some peculiar SoC silicon
> > design where VDD_NPU is leaking into the part that the UFS PD actually
> > should be gating, preventing the lockup on accident.
> >
> > Anyway, so I did a bisect between the UFS introduction and the rebased
> > tip of the pmdomain branch, and landed on the commit I'm reverting.
> >
> > The problem exhibits itself not when the affect PD is first turned off,
> > but when the NPU regulator is turned off. How could this be relevant to
> > power domains at all? I have no idea.
> >
> > I admit that I don't understand the commit I'm reverting, as it talks of
> > keeping powered-on genpds on, but the code sets a member called "stay_on"
> > to false.
> >
> > However, reverting it 100% reproducibly fixes the observed lockup. The
> > lockup does not occur if an UFS module is connected to the SBC.
> >
> > It seems `dev_pm_genpd_rpm_always_on` is never run if UFS experiences
> > a probe failure, so I'm not entirely sure how this specific commit
> > changes the behaviour in a way that makes it unhappy. I agree the
> > solution is probably not a revert here. Also, adding an unconditional
> > `dev_pm_genpd_rpm_always_on` in the failing UFS probe path doesn't
> > work, likely because the driver is unbound. Maybe this is a complete
> > red herring and `dev_pm_genpd_rpm_always_on` is unrelated.
> >
> > The only other device that uses RK3576_PD_USB is the usb_drd0_dwc3
> > usb controller. This node is not enabled in my rebase-pd-onto-ufs-enable
> > branch, so even assuming the problem is that the usb driver is missing
> > the same `dev_pm_genpd_rpm_always_on` call, that shouldn't matter
> > becuase nothing else is using that power domain. Unless, of course, our
> > description of that power domain is incomplete, which is possible.
> >
> > The problem may be that this was always racey and the genpd changes
> > just made the race go wrong more often.
> >
> > Another observation: my kernel log during afflicted bootups contains
> >
> >     rockchip-pm-domain 27380000.power-management:power-controller: sync_state() pending due to 2a2d0000.ufshc
> >
> > A further observation: pd_ignore_unused does not fix it. Looking at
> > the revert and experimenting, removing the `stay_on = false` is not
> > what actually fixes my problem, but removing the
> > `#ifndef CONFIG_PM_GENERIC_DOMAINS_OF`, even without setting
> > pd_ignore_unused, fixes my issue.
> >
> > This is probably a big enough clue to suss out what's going on; that
> > I *need* "[    2.868987] PM: genpd: Disabling unused power domains"
> > to run quite early before the regulator that feeds VDD_NPU is disabled
> > after the bootup completes unless an UFS module is present or the UFS
> > controller is disabled makes me think this is another peculiarity of
> > the RK3576 power domains hardware, because none of this I just wrote
> > sounds like the words of a sane human.
> 
> Thanks a lot for sharing more information!
> 
> As I just responded to Heiko's email, my guess is that PM domain needs
> the genpd->power_off() callback to be invoked first, before it can be
> properly powered-on via genpd->power_on().

It's never powered off or powered on. In my case, the SoC dies before
the affected NPU domains are ever touched apart from the probe function.

> In some way we need to make sure the PM domain (genpd) is in a correct
> state before we call pm_genpd_init(). Exactly how, I think you can
> explore with different approaches.

I'm not sure we're able to really do this, as we don't know before drivers
have probed whether a PD shouldn't be turned off, due to the
aforementioned rpm_always_on thing.

What we really need is a way to add regulators as suppliers to PDs after
the initial power controller probe function, but before the the regulator
unused suspension is run, regardless of whether a PD is used by any device
that's got a driver bound.

Alternatively, the regulator core needs to somehow synchronise with the
genpd core to have it turn off its unused domains first.

Both of these don't seem like solutions that can be snuck in during an
rc, but there really isn't any way right now to fix this from within
Rockchip's power domain controller unless we just hardcode another flag
that says a certain PD should be turned off during probe, which is a
really dirty hack.

Kind regards,
Nicolas Frattaroli

> 
> [...]
> 
> Kind regards
> Uffe
> 





