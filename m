Return-Path: <linux-pm+bounces-34577-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E5EB5568D
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 20:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD8E1C25DEF
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 18:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A6B3314AC;
	Fri, 12 Sep 2025 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="UA9KyE9a"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CF33009F0;
	Fri, 12 Sep 2025 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703020; cv=pass; b=GodYoEJ0VUIFq9dMbEku2k3Pse2ohhpm0cH5Jsi1biUeaMQU9YuoNKBMs0PDGn+5f1wTwTvSGuDKNpSSE8GskE4aDpwdYlgmagWy5GyUeY8+aFwo9FFuPqUN9QtjMv8vLpbjAWzRzH1BG0pqLV4W41FyCK5WtoYoRyxKYNxWTqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703020; c=relaxed/simple;
	bh=Mq/MwHte4D8oQ0P2TVknVYp5j+E6PaE5kcQ+dMOwkrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M464eHeaqkWxmlO7Rqs7mHRdYkchp5VLHZzsYExXoqRK1vp10tEVHTvO0rM87og2pYqWxwuK8hkOtXhRDhmYqSyR+BZs3+9XX56ZOlHS/5kX9X1szXClMAaDK86ytVbQz8uSk81c8aWpwApr0iZ8yk3AxWN67cu07fp3lv3+RRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=UA9KyE9a; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757702987; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MMStU+3hRtzkLorSu8cvhj4yj9QKVpW2KU9+rsL9jBT5Moof9YaOUbirSYeUkrghwp/a1hkQLMuTeonRBEN8NBKAGE49gePu8sZCHHfA4XCbnAEryr0NfjpLRoTVekNkGRH1m/LD5p6nnpZ1E8tYDvgSHl4h5FhVoemmVsFA96c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757702987; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Jgluz1VB/1G/DYBTfp7Su1oyZjWlvzq3TKFpkBLruI4=; 
	b=EYCCAVE8Ab3G8NQ426QKbnwxGKRv15FuBpSAWhzZLkuuNqhsiQiKzXitaK57+GL5tWdsIv+AOhloG/OWpyknYxowmsk8duOTrqYSmxX9VoagJ/bnqesTMUA6Y1oWa0s3bGEg4iso4ST76BlrcOvqP8mgCgiXkcdve4NIVBjahr0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757702987;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=Jgluz1VB/1G/DYBTfp7Su1oyZjWlvzq3TKFpkBLruI4=;
	b=UA9KyE9azmnLUmH9Qs86R/QKJcGr7uEhTtfLYk93StOiilKYy63S+sO12DWsWm6P
	Ftc6S5o0hrpM1vB51UgiByP+yAaxIBHbIkTqCjQDgmC8b2U5J/M0ushryPcwzrrB+Vz
	Ks8rmtfLWnMlVtLsw3+M79+fRHMkXDaooFTRhJWg=
Received: by mx.zohomail.com with SMTPS id 1757702984518937.115502131544;
	Fri, 12 Sep 2025 11:49:44 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Saravana Kannan <saravanak@google.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sebin Francis <sebin.francis@ti.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 Peng Fan <peng.fan@oss.nxp.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Johan Hovold <johan@kernel.org>, Maulik Shah <maulik.shah@oss.qualcomm.com>,
 Michal Simek <michal.simek@amd.com>, Konrad Dybcio <konradybcio@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 0/5] pmdomain: Restore behaviour for disabling unused PM domains
Date: Fri, 12 Sep 2025 20:49:37 +0200
Message-ID: <3919643.KlZ2vcFHjT@workhorse>
In-Reply-To:
 <CAGETcx9W5MXyHA2r1kDh9=WJiQWLF1xdPaSCH=jXYeAHqQW60w@mail.gmail.com>
References:
 <20250909111130.132976-1-ulf.hansson@linaro.org>
 <CAGETcx9W5MXyHA2r1kDh9=WJiQWLF1xdPaSCH=jXYeAHqQW60w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, 12 September 2025 20:36:35 Central European Summer Time Saravana=
 Kannan wrote:
> On Tue, Sep 9, 2025 at 4:11=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> >
> > Recent changes to genpd prevents those PM domains being powered-on duri=
ng
> > initialization from being powered-off during the boot sequence. Based u=
pon
> > whether CONFIG_PM_CONFIG_PM_GENERIC_DOMAINS_OF is set of not, genpd rel=
ies
> > on the sync_state mechanism or the genpd_power_off_unused() (which is a
> > late_initcall_sync), to understand when it's okay to allow these PM dom=
ains
> > to be powered-off.
> >
> > This new behaviour in genpd has lead to problems on different platforms=
 [1].
> >
> > In this series, I am therefore suggesting to restore the behavior of
> > genpd_power_off_unused() along with introducing a new genpd config flag,
> > GENPD_FLAG_NO_STAY_ON, to allow genpd OF providers to opt-out from the =
new
> > behaviour.
> >
> > Kind regards
> > Ulf Hansson
> >
> > [1]
> > https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.=
org/
> > https://lore.kernel.org/all/20250902-rk3576-lockup-regression-v1-1-c4a0=
c9daeb00@collabora.com/
>=20
> I'm surprised this is happening. The default behavior of sync_state()
> is to never turn off a power domain until all the consumers have
> probed.
>=20
> Is there a consumer that's not captured correctly? If so, can we add them?

Yes, and unfortunately, not trivially so, no. In Rockchip's case, the
regulators supplying a certain power domain cannot be acquired at
pmdomain probe time, as the regulators themselves are sometimes
SPI or I2C regulators that depend on powerdomains to be up.

So we only acquire them when the power domain is enabled, which does
not happen for unused PDs. Acquiring them during PD disable also
wouldn't work, as the genpd idle check may run after the regulator
idle check.

>=20
> Also, there are already sync_state related kernel configs, command
> line options and sysfs files that should allow people to power off
> devices (at different levels of granularity) even if its consumers
> haven't probed.

This series is a stop-gap solution to get us through v6.17, so that
problematic drivers like Rockchip pmdomains can be rearchitectured
to declare their dependency in some way that is not racey. This
will be somewhat non-trivial, hence the current solution for now.

>=20
> Thanks,
> Saravana
>=20

Kind regards,
Nicolas Frattaroli

> >
> > Ulf Hansson (5):
> >   pmdomain: core: Restore behaviour for disabling unused PM domains
> >   pmdomain: rockchip: Fix regulator dependency with
> >     GENPD_FLAG_NO_STAY_ON
> >   pmdomain: renesas: rcar-sysc: Don't keep unused PM domains powered-on
> >   pmdomain: renesas: rcar-gen4-sysc: Don't keep unused PM domains
> >     powered-on
> >   pmdomain: renesas: rmobile-sysc: Don't keep unused PM domains
> >     powered-on
> >
> >  drivers/pmdomain/core.c                   | 20 ++++++++++++++------
> >  drivers/pmdomain/renesas/rcar-gen4-sysc.c |  1 +
> >  drivers/pmdomain/renesas/rcar-sysc.c      |  1 +
> >  drivers/pmdomain/renesas/rmobile-sysc.c   |  3 ++-
> >  drivers/pmdomain/rockchip/pm-domains.c    |  2 +-
> >  include/linux/pm_domain.h                 |  7 +++++++
> >  6 files changed, 26 insertions(+), 8 deletions(-)
> >
> > --
> > 2.43.0
> >
>=20





