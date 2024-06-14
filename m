Return-Path: <linux-pm+bounces-9143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5A4908427
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 09:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9152828E0
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 07:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD52F14882D;
	Fri, 14 Jun 2024 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="kSnb4UqH"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED8E148849;
	Fri, 14 Jun 2024 07:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718348563; cv=none; b=KjtTL7k5yxTzqam1lOTss5kqKhbFllh8BogRDpwNJTmG1tS936Ike1N7Xqk+N5Wr4VjqHqnHC0kEv54sNUdone5ARAXH9obJbSu8sDkc1BSARLJ7NZcvp0ao2F0zvpIZVG0nXNRBHLGMvLYx7Tq1+9cBOroh5CWw1QjYC99lDm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718348563; c=relaxed/simple;
	bh=8p2Al/9e1siGHXoHFWJ+KpCoiuz9+nAteekXoz94MzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9KR6j5EvZJFE2IEIvVdGUM5+fM4IDZWy9DTj2pMfZPt4EbOvzH/UMJd+Yh6fWtTQNw2dRbOT1n23p8jFFPHQvRpfy/MPmqbXMv3HLFxLnDNBgO6Kh15KjvEsUYEwi+SEOVU6FLv2Y4RAUA1Ax0pZrE0Ef3lsGD3uygnFy3IMUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=kSnb4UqH; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718348551;
	bh=8p2Al/9e1siGHXoHFWJ+KpCoiuz9+nAteekXoz94MzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kSnb4UqHpVouIJdpPGuVIdKOTMgrjcS5soC2D6Sa3E3rIKyIQ6Hcp3MA7Q1vsJp+V
	 3IJ3HIc9Weu9hvk2vIqwKnElogg9g8HbafPMUgUugPM8UAcCIaSQ3OzklM4jmSBFct
	 5AiF3jG+7e7o54seLecdWVVOgs+JlQMbVsjnCJOE=
Date: Fri, 14 Jun 2024 09:02:29 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 3/5] power: supply: core: implement extension API
Message-ID: <3491c641-bee2-4100-8eb6-8e90d63330b0@t-8ch.de>
References: <20240608-power-supply-extensions-v2-0-2dcd35b012ad@weissschuh.net>
 <20240608-power-supply-extensions-v2-3-2dcd35b012ad@weissschuh.net>
 <76dff03c-08f6-4edc-af57-c0b8dbf55293@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76dff03c-08f6-4edc-af57-c0b8dbf55293@gmx.de>

Hi!

On 2024-06-14 01:11:29+0000, Armin Wolf wrote:
> Am 08.06.24 um 21:19 schrieb Thomas Weißschuh:
> 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >   drivers/power/supply/power_supply.h       |  13 ++-
> >   drivers/power/supply/power_supply_core.c  | 128 ++++++++++++++++++++++++++++--
> >   drivers/power/supply/power_supply_hwmon.c |   2 +-
> >   drivers/power/supply/power_supply_sysfs.c |  37 ++++++++-
> >   include/linux/power_supply.h              |  26 ++++++
> >   5 files changed, 192 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
> > index 622be1f0a180..686b66161900 100644
> > --- a/drivers/power/supply/power_supply.h
> > +++ b/drivers/power/supply/power_supply.h
> > @@ -13,8 +13,17 @@ struct device;
> >   struct device_type;
> >   struct power_supply;
> > 
> > -extern bool power_supply_has_property(const struct power_supply_desc *psy_desc,
> > -				      enum power_supply_property psp);
> > +struct psy_ext_registration {
> > +	struct list_head list_head;
> > +	const struct power_supply_ext *ext;
> > +};
> > +
> > +#define psy_for_each_extension(psy, pos) list_for_each_entry(pos, &(psy)->extensions, list_head)
> 
> sorry for taking so long to respond, the patch looks good to me except one single thing:
> 
> when removing a power supply extension, the driver has to be sure that no one is still using
> the removed extension. So you might want to add some sort of locking when using a power supply
> extension.

That was part of the v1 of the series [0].
I dropped it in v2 to focus on the external API and semantics first.
IMO now that we have the loop macro anyways that can also take care of
the locking: psy_for_each_extension_locked()

[0] https://lore.kernel.org/all/20240606-power-supply-extensions-v1-4-b45669290bdc@weissschuh.net/

Thomas

<snip>

