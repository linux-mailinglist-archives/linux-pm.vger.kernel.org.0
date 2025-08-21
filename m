Return-Path: <linux-pm+bounces-32838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E20F3B30356
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 22:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E95FA210CF
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 20:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9C32E8DF2;
	Thu, 21 Aug 2025 20:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="zRD33+oE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9655680;
	Thu, 21 Aug 2025 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806761; cv=none; b=YCRIpNwKuSN48ongpKr76fuGUfs6puVadY2/esxGKO2LH9WkRpEkUqKkz4Ti6sLgNnFdUUejwEPm9lRIPbjFKy7/7TJGH5/i1vq2wJt9Lv+9Dsr7+Wj4agWkeOaNcNLmLMhYQqs9uFya44C8JJ5K0BaG0HHchSGUXeAscUYp3KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806761; c=relaxed/simple;
	bh=ZazKTqMRGBn45Y9+XmJwECB392SsnW2r2+CmYWQSR18=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOFmfzWmJXtNBgQt5K3GQTmSKaTgNhO72cjJOtxoWPB3s/eLb6+q+lFMbgMOWDlyBXNtqXJOg/SdKK43t2cZorGRhpzJCwSNpZKKjvAy6vwzf6Z7CVcS5ubj54KapU8Bd+MVvXqsvStNKXSxkPpkaRG+hr5eBXt7YdH9J3sEMdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=zRD33+oE; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=duGs71ZGM+AcdNUeemZTcE9RR+6ixlAEFwFO71+Ipa4=; b=zRD33+oEgXk+3fHZjYp1QQBYIP
	sqaZ1xV1+hwJBD86fs63mA74M3j2xuG9lDDP3m2HieVaTloVh2DRygH+xPkDrGOrtn3KIHC9K4IDp
	KI5etPzkATaUNycUwgJRsZtEb5rcm/vsANBT9Y2ax9SAgXJyxQ6D+Gs20cdKgutb+rR7SuwdzJIqr
	G0t72znvb4zNFyShXIF19FihkOT06cJE6wWDkyimPTxLLyZtEoAHmvyZo+2Iju4shjkTBZYrwotcy
	LSCLZaOAseCG5F+wIGEAAPS4GB8QWJ+ZqkFqQc5U+5KzGJVphUGO8r9xrSvymdrkgHoTX09K8IarD
	tmmI7O9Q==;
Date: Thu, 21 Aug 2025 22:05:52 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, Jerry Lv <Jerry.Lv@axis.com>, Pali
 =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
 stable@vger.kernel.org, kernel@pyra-handheld.com
Subject: Re: [PATCH] power: supply: bq27xxx: fix error return in case of no
 bq27000 hdq battery
Message-ID: <20250821220552.2cb701f9@akair>
In-Reply-To: <10174C85-591A-4DCB-A44E-95F2ACE75E99@goldelico.com>
References: <bc405a6f782792dc41e01f9ddf9eadca3589fcdc.1753101969.git.hns@goldelico.com>
	<20250821201544.047e54e9@akair>
	<10174C85-591A-4DCB-A44E-95F2ACE75E99@goldelico.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Thu, 21 Aug 2025 20:54:41 +0200
schrieb "H. Nikolaus Schaller" <hns@goldelico.com>:

> > Am 21.08.2025 um 20:15 schrieb Andreas Kemnade <andreas@kemnade.info>:
> > 
> > Hi,
> > 
> > Am Mon, 21 Jul 2025 14:46:09 +0200
> > schrieb "H. Nikolaus Schaller" <hns@goldelico.com>:
> >   
> >> Since commit
> >> 
> >> commit f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when busy")
> >> 
> >> the console log of some devices with hdq but no bq27000 battery
> >> (like the Pandaboard) is flooded with messages like:
> >> 
> >> [   34.247833] power_supply bq27000-battery: driver failed to report 'status' property: -1
> >> 
> >> as soon as user-space is finding a /sys entry and trying to read the
> >> "status" property.
> >> 
> >> It turns out that the offending commit changes the logic to now return the
> >> value of cache.flags if it is <0. This is likely under the assumption that
> >> it is an error number. In normal errors from bq27xxx_read() this is indeed
> >> the case.
> >> 
> >> But there is special code to detect if no bq27000 is installed or accessible
> >> through hdq/1wire and wants to report this. In that case, the cache.flags
> >> are set (historically) to constant -1 which did make reading properties
> >> return -ENODEV. So everything appeared to be fine before the return value was
> >> fixed. Now the -1 is returned as -ENOPERM instead of -ENODEV, triggering the
> >> error condition in power_supply_format_property() which then floods the
> >> console log.
> >> 
> >> So we change the detection of missing bq27000 battery to simply set
> >> 
> >> cache.flags = -ENODEV
> >> 
> >> instead of -1.
> >>   
> > This all is a bit inconsistent, the offending commit makes it worse. 
> > Normally devices appear only in /sys if they exist. Regarding stuff in
> > /sys/class/power_supply, input power supplies might be there or not,
> > but there you can argument that the entry in /sys/class/power_supply
> > only means that there is a connector for connecting a supply.  
> 
> Indeed. If there is an optional bq27000 hdq battery the entry exists.
> 
Which is the condition that there is an optional bq27000 battery?
w1 might be enabled for other reasons. The bq27000 is not the only w1
chip in the world. BTW: I have removed the battery from my macbook and
there is no battery entry in /sys/class/power_supply. Same with another
laptop.

> > But having the battery entry everywhere looks like waste. If would
> > expect the existence of a battery bay in the device where the common
> > battery is one with a bq27xxx.  
> 
> I think the flaw you are mentioning is a completely diffent one. It comes from that
> the 1-wire or hdq interface of some omap processors is enabled in the .dtsi by default
> instead of disabling it like other interfaces (e.g. mcbsp1). E.g. for omap3 hdqw1w:
> 
> https://elixir.bootlin.com/linux/v6.16.1/source/arch/arm/boot/dts/ti/omap/omap3.dtsi#L502
> 
> And we should have the dts for the boards enable it only if the hdq interface is really
> in use and there is a chance that a bq27000 can be connected. In that case the full
> /sys entry is prepared but returns -ENODEV if the battery is missing, which is then
> exactly the right error return (instead of -EPERM triggering the console message).
>

And why do you think bq27000 should behave different than
max1721x_battery or ds2780_battery or ds2781_battery? If I enable the
drivers there is no additional battery in /sys/class/power_supply! Why
should everyone have a bq27000 in /sys/class/power_supply if the driver
is enabled and w1 is used for something? I wonder if the -ENODEV should
be catched earlier.

Regards,
Andreas

