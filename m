Return-Path: <linux-pm+bounces-33833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E850B43C0C
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 14:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDB75A416E
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 12:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A886E2FD7D0;
	Thu,  4 Sep 2025 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="k0cugo+e"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9998F2E8E1D;
	Thu,  4 Sep 2025 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990240; cv=pass; b=iGr6qPDmmTLqBvens3IfTKxS/pCF6a+KoOBNvwrntOGdYipu/DJLFXCUyjc4+Wqk66Dfzrdw+jke5lKefhBCicvanf6+AiijTcAQAUKplh3iVOdE1V7KPjaCU6YEFHVWHiu/273rOsDSpQpRwUCHyyzjybhaIEQjetM3/ZjmFjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990240; c=relaxed/simple;
	bh=qfd+5L+Pd9KeKUdYgSQpIggTDKEsEuNs9VP4GlgnOzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHvtN82ErTyDnJY5vHiqXRUwQbCu83WA2x70uElePpQWpRBXihHhBg070vwfiz7o2hF/iJ5QK6oMnNdpG+neFau+z/Y2cLTGmu1hkRHQa1+ENdmd/SudU6X/NnEQU1lGvuSdvUHDbEvu2hKt2a2EGgiLMutI+//liJ7qkiR0uoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=k0cugo+e; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756990220; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ApDpon0xLNyaqlM3Cvsyqdq4pi6LgWmMeh2zuPJ7//+dYjb51jPdCVxhTPTNpGuxHjkvtgPtrMxyG08KE3wrvPkNp68AzY2GUQAjvqZ6/X71tOabXKR6IbWjSHg4Zeq7Aq0clLCfCh3tT0FcdJs0UB6u9jlSAEC9neJ5bjpk9I8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756990220; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=L8qpeRieIsLLxpttaICO063jG7df++yVwdZkcuPBW+8=; 
	b=dX7J9l9S7Li4rwNvzDM4F6OGWA5vTnVfyOcq6q+CWeD1RkZpXzjJTlJpr2XNMCDW3oXx/0ZdTU5W2Fr6QSnq64mILpUNrkDpwm7+kcbhCImA26XWgpNSpeYcLjyY/j0WfdhREpXezYPeUN69d/qDhIy8Q8oRVsb8PkuJbgUN+5w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756990219;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=L8qpeRieIsLLxpttaICO063jG7df++yVwdZkcuPBW+8=;
	b=k0cugo+ePjqwt9Sc3dwl2rBacAwVd580UQCkechLz/Lx6FKfqpxRSbsOZJryGWWP
	OF9+LhP+tJ+/l5P903tGx9mtTz45xYYloMacQL7UQ7LqC3Gsbc99fQT8AXlWMp8BRJo
	INSIwkmInINVjOtI/hl0KqbgVp9OBT++7JzTPIcs=
Received: by mx.zohomail.com with SMTPS id 1756990217294112.06172142778973;
	Thu, 4 Sep 2025 05:50:17 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, linux-rockchip@lists.infradead.org,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] pmdomian: core: don't unset stay_on during sync_state
Date: Thu, 04 Sep 2025 14:50:13 +0200
Message-ID: <3332408.jE0xQCEvom@workhorse>
In-Reply-To:
 <CAPDyKFpAOLiBOoAhv+GQcobU_g_AWrB9iyOGmodROLtRmR30JA@mail.gmail.com>
References:
 <20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com>
 <CAPDyKFpAOLiBOoAhv+GQcobU_g_AWrB9iyOGmodROLtRmR30JA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 4 September 2025 11:17:01 Central European Summer Time Ulf Hansson wrote:
> On Tue, 2 Sept 2025 at 20:23, Nicolas Frattaroli
> <nicolas.frattaroli@collabora.com> wrote:
> >
> > This reverts commit de141a9aa52d6b2fbeb63f98975c2c72276f0878.
> 
> I can't find this commit hash. What tree are you using when testing this?
> 
> Are you trying to revert 0e789b491ba04c31de5c71249487593e386baa67 ?

Probably, I did the revert on a rebased branch and then rebased the revert
onto v6.17-rc4 so it likely is the wrong hash here. I'll fix this in v2 if
there is a v2 (it might actually become a different patch, see huge text
below, sorry!)

> 
> >
> > On RK3576, the UFS controller's power domain has a quirk that requires
> > it to stay enabled, infrastricture for which was added in Commit
> > cd3fa304ba5c ("pmdomain: core: Introduce dev_pm_genpd_rpm_always_on()").
> >
> > Unfortunately, Commit de141a9aa52d ("pmdomain: core: Leave powered-on
> > genpds on until sync_state") appears to break this quirk wholesale. The
> > result is that RK3576 devices with the UFS controller enabled but unused
> > will freeze once pmdomain shuts off unused domains.
> >
> > Revert it until a better fix can be found.
> 
> This sounds a bit vague to me, can you please clarify and elaborate a
> bit more so I can try to help.
> 
> What does "UFS controller enabled but unused" actually mean? Has the
> UFS controller driver been probed successfully and thus its
> corresponding device been attached to its PM domain?

It means the UFS controller driver has probed, but does not find a
UFS storage chip connected to it, and therefore reports a probe
failure. This is a possibility on single-board computers like the
Radxa ROCK 4D, where the UFS storage is a separate module that plugs
into some headers.

> Moreover, the behaviour of dev_pm_genpd_rpm_always_on() is orthogonal
> to what 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on
> until sync_state") brings along with its corresponding sync_state
> series for genpd [1]. Again, more information is needed to understand
> what goes wrong.

The reason why Rockchip's UFS driver needs this function is that once
the RK3576_PD_USB power domain is turned on on the RK3576 SoC, it should
not be toggled off again until a whole SoC suspend/resume cycle because
the off/on operation is seemingly not idempotent. This does not preclude
turning off the power domain if the device isn't used at all, e.g. the DT
node is absent. This is why the affected PDs are not marked as always-on
in the PD init data for the SoC, as the device driver is the best place to
set this during runtime.

The way I got to this commit is through a bisect between the UFS node
being enabled on the ROCK 4D (commit 00abee2b18342d6c2f6f37225682fa7ca0d33142)
and v6.17-rc4. The bisect landed on the pmdomain merge commit
(commit fc8f5028eb0cc5aee0501a99f59a04f748fbff1c) as the first bad commit,
so I checked out v6.16, cherry-picked the UFS node enablement, made sure it
works fine with that, and then rebased the 44 pmdomain commits that this
merge commit merged onto this base. I verified that the tip of that then
exhibited the faulty behaviour, namely that my ROCK 4D was locking up
some time after boot, right after the kernel log message

    [   33.756516] vdd_npu_s0: disabling

so presumably when unused regulators and domains were being disabled.
Aside note: setting vdd_npu_s0 to always-on also works to work around
the issue, and I'm not quite sure why, because this regulator is not
used for anything right now so this may be some peculiar SoC silicon
design where VDD_NPU is leaking into the part that the UFS PD actually
should be gating, preventing the lockup on accident.

Anyway, so I did a bisect between the UFS introduction and the rebased
tip of the pmdomain branch, and landed on the commit I'm reverting.

The problem exhibits itself not when the affect PD is first turned off,
but when the NPU regulator is turned off. How could this be relevant to
power domains at all? I have no idea.

I admit that I don't understand the commit I'm reverting, as it talks of
keeping powered-on genpds on, but the code sets a member called "stay_on"
to false.

However, reverting it 100% reproducibly fixes the observed lockup. The
lockup does not occur if an UFS module is connected to the SBC.

It seems `dev_pm_genpd_rpm_always_on` is never run if UFS experiences
a probe failure, so I'm not entirely sure how this specific commit
changes the behaviour in a way that makes it unhappy. I agree the
solution is probably not a revert here. Also, adding an unconditional
`dev_pm_genpd_rpm_always_on` in the failing UFS probe path doesn't
work, likely because the driver is unbound. Maybe this is a complete
red herring and `dev_pm_genpd_rpm_always_on` is unrelated.

The only other device that uses RK3576_PD_USB is the usb_drd0_dwc3
usb controller. This node is not enabled in my rebase-pd-onto-ufs-enable
branch, so even assuming the problem is that the usb driver is missing
the same `dev_pm_genpd_rpm_always_on` call, that shouldn't matter
becuase nothing else is using that power domain. Unless, of course, our
description of that power domain is incomplete, which is possible.

The problem may be that this was always racey and the genpd changes
just made the race go wrong more often.

Another observation: my kernel log during afflicted bootups contains

    rockchip-pm-domain 27380000.power-management:power-controller: sync_state() pending due to 2a2d0000.ufshc

A further observation: pd_ignore_unused does not fix it. Looking at
the revert and experimenting, removing the `stay_on = false` is not
what actually fixes my problem, but removing the
`#ifndef CONFIG_PM_GENERIC_DOMAINS_OF`, even without setting
pd_ignore_unused, fixes my issue.

This is probably a big enough clue to suss out what's going on; that
I *need* "[    2.868987] PM: genpd: Disabling unused power domains"
to run quite early before the regulator that feeds VDD_NPU is disabled
after the bootup completes unless an UFS module is present or the UFS
controller is disabled makes me think this is another peculiarity of
the RK3576 power domains hardware, because none of this I just wrote
sounds like the words of a sane human.

Kind regards,
Nicolas Frattaroli

> 
> Kind regards
> Uffe
> 
> [1]
> https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/
> 
> >
> > Fixes: de141a9aa52d ("pmdomain: core: Leave powered-on genpds on until sync_state")
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  drivers/pmdomain/core.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index 0006ab3d078972cc72a6dd22a2144fb31443e3da..4eba30c7c2fabcb250444fee27d7554473a4d0c2 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -1357,7 +1357,6 @@ static int genpd_runtime_resume(struct device *dev)
> >         return ret;
> >  }
> >
> > -#ifndef CONFIG_PM_GENERIC_DOMAINS_OF
> >  static bool pd_ignore_unused;
> >  static int __init pd_ignore_unused_setup(char *__unused)
> >  {
> > @@ -1393,7 +1392,6 @@ static int __init genpd_power_off_unused(void)
> >         return 0;
> >  }
> >  late_initcall_sync(genpd_power_off_unused);
> > -#endif
> >
> >  #ifdef CONFIG_PM_SLEEP
> >
> > @@ -3494,7 +3492,6 @@ void of_genpd_sync_state(struct device_node *np)
> >         list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
> >                 if (genpd->provider == of_fwnode_handle(np)) {
> >                         genpd_lock(genpd);
> > -                       genpd->stay_on = false;
> >                         genpd_power_off(genpd, false, 0);
> >                         genpd_unlock(genpd);
> >                 }
> > @@ -3522,7 +3519,6 @@ static void genpd_provider_sync_state(struct device *dev)
> >
> >         case GENPD_SYNC_STATE_SIMPLE:
> >                 genpd_lock(genpd);
> > -               genpd->stay_on = false;
> >                 genpd_power_off(genpd, false, 0);
> >                 genpd_unlock(genpd);
> >                 break;
> >
> > ---
> > base-commit: 5cc61f86dff464a63b6a6e4758f26557fda4d494
> > change-id: 20250902-rk3576-lockup-regression-5b1f1fb7ff21
> >
> > Best regards,
> > --
> > Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> >
> 





