Return-Path: <linux-pm+bounces-34158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F94B48F24
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 15:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB09162024
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 13:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC44630AAC8;
	Mon,  8 Sep 2025 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="FQHB5ZAO"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4E309F1E;
	Mon,  8 Sep 2025 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337295; cv=pass; b=HHpC8M4blXEKaqzSks1rFXQbaRWYDx8zFW1lpv2Ze3agmV9suwW32O03MrTHtojKzqek1IvZQTdYr0qh/VvS6i+o3rt6PosIQW4J3sABaay+Gg88UtiakLQ43xnPoGvzzCNopVOJbI1ZfeI5sSWGzWcyIgdl0En+876MSVi5Ncw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337295; c=relaxed/simple;
	bh=+6pyxVAkDoyE8Cyu0p5N+L0faFzxQ9qlRST8FYxtxoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCv+jR+sgPl9YN5hGvC726e8P7pLM7kn45SfBfEJosHkvgO4Tf4ceLcUSXAGJxwYid6fKK/D1UcZHbykcXh85tApYD24jr0jTfgkjfm3ibiktVLIifif3Xux3BuAyWDL2K2pFRDzHSrXe+GhtTMmlsxcuiMORhPeVHDU6fvrtbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=FQHB5ZAO; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757337274; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DNh13hbFAmkcsVoMBOYEI2azWoZts5Tloe+7VNBo6Kal0Rt8Ft0HNkSbk+CD6RugngB3pmFnR/A3s5jP8Ff/8QZS9GBzd/PSIb41LOFGp0AKolLTuT825FL9ELSftJivQtC+sNxkCGij9Vc2GaoiuteOJxyiwS2w2EP3S+adB7Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757337274; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pk0pPbbGzqsDwAb5KOUGSpgEXegsNBH0oucyp1ouJvs=; 
	b=bnADyuBiUpkfLxyDVSannBNIBHWRhcNPBgAaPrZgquGkCJfXdgJijdGOrVsQ8UamL8oWb1SKPa8HuQ5qmC5EzvIft/w6aMgLWZs2nfHJId3DH7lLZKFoRuPlhuCpnwt0sModYCw7v8aa9ymnkHSzUrU78+lhUiEMExIhwf7aIcU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757337274;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=pk0pPbbGzqsDwAb5KOUGSpgEXegsNBH0oucyp1ouJvs=;
	b=FQHB5ZAO3t8mFRAWbT4PhhvTQL8TZAZVnBRS5+l6VHAcG2epE5UTsZTH6Q0rHEE+
	7DXx+udKmcgHmrx1ExjnEJB4aVF4pFktKBdYHTgw87gYZzXJMMfIi2bZs2QQZ6YGXhZ
	gVgyeJR2nMC4d8y6mDUlaYCauRsNl39VXnVbqEi8=
Received: by mx.zohomail.com with SMTPS id 1757337272979795.5615319676068;
	Mon, 8 Sep 2025 06:14:32 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, linux-rockchip@lists.infradead.org,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] pmdomian: core: don't unset stay_on during sync_state
Date: Mon, 08 Sep 2025 15:14:28 +0200
Message-ID: <1953725.CQOukoFCf9@workhorse>
In-Reply-To:
 <CAPDyKFpSY+FeKh7ocjQ_nGNZA5+3tWAL8e7ZNKXKNFP-yoiu_g@mail.gmail.com>
References:
 <20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com>
 <3556261.BddDVKsqQX@workhorse>
 <CAPDyKFpSY+FeKh7ocjQ_nGNZA5+3tWAL8e7ZNKXKNFP-yoiu_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 5 September 2025 16:27:27 Central European Summer Time Ulf Hansson wrote:
> [...]
> 
> >
> > Okay so I believe I have found the root cause of the regression. UFS is
> > innocent, disabling UFS just happens to avoid it due to how the timing of
> > things works out.
> >
> > The real issue is that the NPU power domains on the RK3576, which are
> > currently unused, have an undeclared dependency on vdd_npu_s0.
> >
> > Declaring this dependency with a `domain-supply` and adding the
> > necessary flag in the rockchip PD controller to use it does not solve
> > he problem. This is because the rockchip PD controller cannot acquire
> > those supplies during probe, as they're not available yet and their
> > availability depends on the PD controller finishing probe.
> >
> > That's why it acquires them in the PD enable callback, but the NPU
> > PDs are never enabled because they're unused.
> >
> > This worked fine when unused PDs were still turned off quite early, as
> > this meant they were turned off before regulators. Now the unused
> > regulators are turned off before turning off the unused PDs happens.
> 
> I see, thanks for sharing these details. What a mess.
> 

Agreed :(

> >
> > I don't really see an easy way to fix this with a patch that's fit for
> > an rc cycle. We can't request the regulator early or even just add a
> > device link, as the regulator is not around yet.
> 
> Right, I will work on a patch or two that allows rockchip
> power-domains to opt-out from genpds new behavior and to keep using
> the old one.
> 
> I think we prefer to do it like this (should be quite a limited amount
> of code and okay for an rc), rather than reverting for everyone.

That sounds good to me.

> 
> >
> > Marking vdd_npu_s0 as always-on would be abusing DT to work around a
> > Linux kernel shortcoming, which is a no-no.
> >
> > What we need is either a way to register with pmdomain core that
> > certain PDs need a late init for additional supplies, which is then
> > called before any of the unused regulator power off functionality is
> > invoked by the regulator core.
> >
> > Any ideas?
> 
> Yes :-)
> 
> I would suggest implementing an auxiliary driver, along with the
> rockchip_pm_domain_driver. The main job for the auxiliary driver would
> be to get the regulator in its ->probe() - and if it fails because the
> regulator isn't available yet, it should keep trying by returning
> -EPROBE_DEFER. See more about the auxiliary bus/device/driver in
> include/linux/auxiliary_bus.h and module_auxiliary_driver().
> 
> Moreover, when the rockchip_pm_domain_driver probes, it becomes
> responsible for pre-parsing the OF nodes for the domain-supply DT
> property, for each of the specified power-domains. If it finds a
> domain-supply, it should register an auxiliary device that corresponds
> to that particular power-domain. This can be done by using
> platform-data that is shared with the auxiliary device/driver. See
> devm_auxiliary_device_create().
> 
> Furthermore we would need some kind of synchronization mechanism
> between the rockchip_pm_domain_driver and the auxiliary driver, to
> manage the regulator get/enable/disable. I think that should be rather
> easy to work out.
> 
> Do you think this can work?

This sounds similar to something Heiko suggested to me, and I agree
it could work. It does seem like a pretty painful solution though,
in terms of needed additional code and complexity to basically just
tell Linux "hey you can't get this regulator yet but please try
again later without our involvement".

To that end, I've tried working out a regulator-based solution to
it, where the rockchip_pm_domain driver registers a "proxy"
regulator for each power domain that wants a regulator, with its
supply set to the name of the real `domain-supply` regulator.

The logic behind this was that the regulator core runs a check
for whether every supply is resolved before it turns off unused
regulators. The hope was that if we register a proxy regulator
and enable it immediately in the pm_domain probe, then regulator
core will handle the actual dependency at precisely the right
time, namely before it checks to see whether any are unused and
can be turned off.

As I discovered though, this can't really work. The regulator
core will in this case just set the supply regulator to a dummy
regulator when it's enabled in our probe function, and later
supply resolving passes are then content that this supply is
resolved even though it is a dummy supply. There does not appear
to be any way to opt out of getting this dummy supply.

So knowing that this doesn't work, I have another idea, but I
feel like both the regulator subsystem and the pm-domains
subsystem will hate this: explicitly create an order between
the pmdomain idle check and the regulator idle check to make
sure that the pmdomains idle check runs first.

This would set in stone how the kernel worked previously for
kernel users that relied on this, but is a conceptually
unpleasant cross-subsystem dependency.

> 
> Kind regards
> Uffe
> 

Kind regards,
Nicolas Frattaroli



