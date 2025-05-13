Return-Path: <linux-pm+bounces-27080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A69AAB5719
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 16:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96C21892CCE
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 14:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036AE2BDC18;
	Tue, 13 May 2025 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="TL9bA5j1"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C7E269D1B;
	Tue, 13 May 2025 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747146464; cv=pass; b=RnDFoEvPgP1Pw9CubvlWQ/xf89uNUude9NfFjnzuY3rlE8bzVFidpNhvKibNqJdh5JYZuyw4nYlgVo4TGQ5aIHanVTjCB8i4lquvoGXNn5akiKoEDuEOLYw42EA4ngTs7LRd0+Yn/GCz1AtKGk360rvseDs+mEbgOBxvOhXEO5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747146464; c=relaxed/simple;
	bh=qrm7iQ0BdPOTxoVtofacn+8/rrDJ538eLVyyVWrv16g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sh+SfAv1XG0ILVEmQw/V+E8/U4e/DNOeRF9S/uEt6/eAMieCVepQaUaxo7frGqXPC2uO/U9egUk4RgzZ4agZy30WNQoPGcn6E6y4eVg8xzZ/ki81P6aKcFn6G1078h/o9jppaaxRt7Yzgg4GizIhBqKXYfOOBu9GHcJXOyQrfMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=TL9bA5j1; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1747146434; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ANqNFwZEb+ZFYow3aFAQoyO/1Ud2AXpFUIBSle0bCo8FVYBcNiP+i1HJVeS9GxYppl7HJpmC+qZl37HtRPkZXcPEOXkDBCQ/zrr8dgKo5uei6H47cW+QVV7ZXJHw8+jUnBeKS3gYXF9OXPTulAsAQCmtDNFdp0Tbw/DhN5W4wsg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747146434; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=S8HvFU+C7sIo5Yzd4dl6ojrhAT/ghV8MpikwHZzYzPM=; 
	b=juo7qhHanaIrojtSIzpy4DRVsL0LxCZof/Ml9fpsJ0EWTj5tH9ljTvKL658u060IhnGxO0kOeBj1jr4KDs4a0RM2Ff4rELQ6Xo0dB7Amhs30S12gFTnGp+viG8MZG4T5h0EJuFWABukZ5OjIvp4EG54KMCC1prBrdmXWOVtR1t0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747146434;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=S8HvFU+C7sIo5Yzd4dl6ojrhAT/ghV8MpikwHZzYzPM=;
	b=TL9bA5j1wnQEzElGt0exkEIhE0Vo7i6xr6vp0qX6xbOLsv8oU234w/eH/ZX6PJJ4
	goH3Vq90j1+kAQio1s0ScSTAfdctQvB99CVnqDrQkokNPU2LuRPEm7T3kvOY7xyhf0T
	oVg9Lwl4xwFaLP7+KQ2QJZqRJPmFWFuGHhXf4uT8=
Received: by mx.zohomail.com with SMTPS id 1747146427338952.0201359300785;
	Tue, 13 May 2025 07:27:07 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Finley Xiao <finley.xiao@rock-chips.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Detlev Casanova <detlev.casanova@collabora.com>, kernel@collabora.com,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
Subject: Re: [PATCH v3] mmc: sdhci-of-dwcmshc: add PD workaround on RK3576
Date: Tue, 13 May 2025 16:27:02 +0200
Message-ID: <6154950.lOV4Wx5bFT@workhorse>
In-Reply-To:
 <CAPDyKFp5N23KCZwOTba6vGyk9eaS1-SjSqY52FfPDng-bahn6g@mail.gmail.com>
References:
 <20250423-rk3576-emmc-fix-v3-1-0bf80e29967f@collabora.com>
 <CAPDyKFp5N23KCZwOTba6vGyk9eaS1-SjSqY52FfPDng-bahn6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, 29 April 2025 12:06:16 Central European Summer Time Ulf Hansson wrote:
> On Wed, 23 Apr 2025 at 09:54, Nicolas Frattaroli
> <nicolas.frattaroli@collabora.com> wrote:
> >
> > RK3576's power domains have a peculiar design where the PD_NVM power
> > domain, of which the sdhci controller is a part, seemingly does not have
> > idempotent runtime disable/enable. The end effect is that if PD_NVM gets
> > turned off by the generic power domain logic because all the devices
> > depending on it are suspended, then the next time the sdhci device is
> > unsuspended, it'll hang the SoC as soon as it tries accessing the CQHCI
> > registers.
> >
> > RK3576's UFS support needed a new dev_pm_genpd_rpm_always_on function
> > added to the generic power domains API to handle what appears to be a
> > similar hardware design.
> >
> > Use this new function to ask for the same treatment in the sdhci
> > controller by giving rk3576 its own platform data with its own postinit
> > function. The benefit of doing this instead of marking the power domains
> > always on in the power domain core is that we only do this if we know
> > the platform we're running on actually uses the sdhci controller. For
> > others, keeping PD_NVM always on would be a waste, as they won't run
> > into this specific issue. The only other IP in PD_NVM that could be
> > affected is FSPI0. If it gets a mainline driver, it will probably want
> > to do the same thing.
> >
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> Applied for next, thanks!
> 
> Kind regards
> Uffe
> 

Hi Uffe,

I was wondering whether we can get this into 6.15 as a fix as well, as 6.15
should already have the genpd API additions this requires AFAIU.

Fixes tag could be something like:

  Fixes: cfee1b507758 ("pmdomain: rockchip: Add support for RK3576 SoC")

but may need some more flavorings to keep the stable robot overlords from
trying to apply it to 6.14 and earlier and then starting the robot uprising
in your inbox when they notice the API is missing.

I originally left out the Fixes tag on the rewrite of this using the new
API because I wanted to avoid those awkward backport scenarios for a fairly
freshly supported SoC, but it'd be great to have this in 6.15 because that
will be with us for a full release cycle to come.

Kind regards,
Nicolas Frattaroli




