Return-Path: <linux-pm+bounces-19463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DC19F6FF1
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 23:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D1116D631
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 22:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3275D1993A3;
	Wed, 18 Dec 2024 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Rj5rtNKm"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB3318B46A;
	Wed, 18 Dec 2024 22:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734560181; cv=none; b=ava8bimlcUBuJobNTSW2ZYehMegxCUddr4b8UEkPw2/cNN5bo0fwKswDIn8+wvsIDp2DPJFNR7Vf6M/paZFg/157W5UX0pQPNbM/h5sBA9dY5NiVD3r2cjy8A4S0qwe5zYTPuvxSarYYsIncZS4DluLTwmuVuM6lBEv0so73+DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734560181; c=relaxed/simple;
	bh=6oooH/HJsNHp40lyT5a/ZluAUb+i4C0qOAMjqptmdzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twIVDLrGMLLgdqH4LIjBrZ7dZomu6UthNV6bbudZJvjqaz9ncbywtnCs8JYVqoBHo2yfKuUodGfDWuH5yRipV/7Ihh0Oymj+ceRqe/bbDKZh7MtsD8U5X7YUc9uBZiNnrrbbCtlaIw0WyIRSnoF/VVToPesKYCZ9RPYqGUR5T+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Rj5rtNKm; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734560176;
	bh=6oooH/HJsNHp40lyT5a/ZluAUb+i4C0qOAMjqptmdzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rj5rtNKmpps3NSPTuxEIVF/v9DOzq2LJvCtD5qjK7IrB97Ut+PzbHt0/1XAFMxE5X
	 gSSyEIMEsiqPW9ym99jMtWu/rr2ActhiRFpNnJYp1R7yGjXzlPNi2ZclTTnxBkGjCG
	 vA3JakvNzD7wKsHgWNjrzXlkzY/ELhM71DmXSPGo=
Date: Wed, 18 Dec 2024 23:16:16 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
	Hans de Goede <hdegoede@redhat.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 4/4] power: supply: core: add UAPI to discover
 currently used extensions
Message-ID: <26833b6c-834d-433b-8d80-0ad39b1c968e@t-8ch.de>
References: <20241211-power-supply-extensions-v6-0-9d9dc3f3d387@weissschuh.net>
 <20241211-power-supply-extensions-v6-4-9d9dc3f3d387@weissschuh.net>
 <20241218195229.GA2796534@ax162>
 <eb265cb2-b079-4bca-bc35-17a9f4d0ec3e@t-8ch.de>
 <otwk52a7nkle7yx3444swh5xasm3l6lmu2suapmvjuplezihyv@p6vrs6lo454e>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <otwk52a7nkle7yx3444swh5xasm3l6lmu2suapmvjuplezihyv@p6vrs6lo454e>

On 2024-12-18 23:11:35+0100, Sebastian Reichel wrote:
> On Wed, Dec 18, 2024 at 09:29:31PM +0100, Thomas Weißschuh wrote:
> > On 2024-12-18 12:52:29-0700, Nathan Chancellor wrote:
> > > I am seeing a build failure in certain configurations because
> > > power_supply_extension_group is only declared under a CONFIG_SYSFS ifdef
> > > but this code can be built without CONFIG_SYSFS.
> > 
> > Thanks for the report.
> > 
> > >   $ echo 'CONFIG_EXPERT=y
> > >   CONFIG_SYSFS=n' >allno.config
> > > 
> > >   $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- KCONFIG_ALLCONFIG=1 mrproper allnoconfig drivers/power/supply/power_supply_core.o
> > >   drivers/power/supply/power_supply_core.c: In function 'power_supply_register_extension':
> > >   drivers/power/supply/power_supply_core.c:1389:55: error: 'power_supply_extension_group' undeclared (first use in this function); did you mean 'power_supply_attr_groups'?
> > >    1389 |         ret = sysfs_add_link_to_group(&psy->dev.kobj, power_supply_extension_group.name,
> > >         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >         |                                                       power_supply_attr_groups
> > >   drivers/power/supply/power_supply_core.c:1389:55: note: each undeclared identifier is reported only once for each function it appears in
> > >   drivers/power/supply/power_supply_core.c: In function 'power_supply_unregister_extension':
> > >   drivers/power/supply/power_supply_core.c:1419:54: error: 'power_supply_extension_group' undeclared (first use in this function); did you mean 'power_supply_attr_groups'?
> > >    1419 |                                                      power_supply_extension_group.name,
> > >         |                                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >         |                                                      power_supply_attr_groups
> > 
> > The reproducer doesn't actually enable CONFIG_POWER_SUPPLY, when I use it
> > I get a whole array of errors.
> > 
> > > Should the declaration be moved out from the ifdef or is there some
> > > other solution I am not seeing?
> > 
> > This, inline constants or a #define.
> > 
> > Sebastian, do you want me to send a patch?
> 
> Yes, please send a patch. I suppose a define next to the NULL define
> for power_supply_attr_groups should be good enough and consistent
> with existing handling of this problem in the subsystem. 

That doesn't work because of the usage of the member "name" of the
symbol power_supply_extension_group.

