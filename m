Return-Path: <linux-pm+bounces-13865-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 912AD9708F0
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 19:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F53B1C20C4B
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 17:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F97176226;
	Sun,  8 Sep 2024 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="YG/8eb4i"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC9A26281
	for <linux-pm@vger.kernel.org>; Sun,  8 Sep 2024 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725816536; cv=none; b=oIF511sUP/G//WaqcSt8CzFLwij4sIBbd+snDUPqR5aToYA0g4QMGQznUZ8kGSqYfmecaYguHWGRraIouRaQzAjaXlh3cngyNlEpE/a/RsGapl+a0ZAFVAr8jZvFLergI2FRfkEbcF+BbBuTtnTxuynS+1mOV57CTUXzH5eOgKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725816536; c=relaxed/simple;
	bh=sQC2A6xH8zT5+W5UEIe582nSTkqHdMHza/Q+XevcK6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rvv2wUfz5/6hV2sQc32mdCbMGEp/mUkz7gQHZkZ92K9zZ8Frvh8XAdKbfF7wSWh/OnJe841QFaLlX8a9o5oY/JdkG68vHA41QU2iRTsGjemqFhh89469cKWeUgPlJGj70BC2iJ51Fc5G36cidvZAIH7v3MXbhIBQNn4gg0192cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=YG/8eb4i; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725816530;
	bh=sQC2A6xH8zT5+W5UEIe582nSTkqHdMHza/Q+XevcK6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YG/8eb4ievD3UuEMfv/MtSKOzHxYv4WdOa+9nQKTnNXOaTTvgDswbKKl/CIr+XK9K
	 2piYVTH4l+GxUvsBlcibOSmv4w+zA7QNX0+JNf154RbRQR/86tDzYuNxlv/VcyuKZX
	 eaIeu+cOLoDyPfXR+oT0/n84WyYkv8RiWSK/G1HU=
Date: Sun, 8 Sep 2024 19:28:50 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 6.11 regression fix] power: supply: sysfs: Revert use
 power_supply_property_is_writeable()
Message-ID: <b54d7389-1a7e-4102-9f21-48ca83f5b7d2@t-8ch.de>
References: <20240908144414.82887-1-hdegoede@redhat.com>
 <de97c24e-85b2-4196-80da-5718075c900b@t-8ch.de>
 <44c3d02a-cab2-4d51-86cf-600fdf19f1a4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44c3d02a-cab2-4d51-86cf-600fdf19f1a4@redhat.com>

On 2024-09-08 18:38:21+0000, Hans de Goede wrote:
> Hi,
> 
> On 9/8/24 4:52 PM, Thomas Weißschuh wrote:
> > Hi Hans,
> > 
> > On 2024-09-08 16:44:14+0000, Hans de Goede wrote:
> >> power_supply_property_is_writeable() contains the following check:
> >>
> >>         if (atomic_read(&psy->use_cnt) <= 0 ||
> >>                         !psy->desc->property_is_writeable)
> >>                 return -ENODEV;
> >>
> >> psy->use_cnt gets initialized to 0 and is incremented by
> >> __power_supply_register() after it calls device_add(); and thus after
> >> the driver core calls power_supply_attr_is_visible() to get the attr's
> >> permissions.
> >>
> >> So when power_supply_attr_is_visible() runs psy->use_cnt is 0 failing
> >> the above check. This is causing all the attributes to have permissions
> >> of 444 even those which should be writable.
> >>
> >> Move back to manually calling psy->desc->property_is_writeable() without
> >> the psy->use_cnt check to fix this.
> > 
> > Thanks for the fix!
> > 
> > OTOH the whole power_supply_attr_is_visible() is completely unused
> > outisde of the psy core. So instead we could unexport it, drop the use_cnt
> > check and use it again.
> > (All of this as part of the psy extension series, for now your revert
> > should be used)
> > 
> > What do you think?
> 
> So I took a look at other users of power_supply_attr_is_visible() and
> the only other user is power_supply_hwmon_is_visible() which suffers
> from the exact same problem.
> 
> NACK.
> 
> So self-nack for this fix. It is better to drop the use_cnt check
> from power_supply_property_is_writeable() altogether since currently
> all hwmon attributes are always 0444 too. I checked with a max170xx_battery
> where /sys/class/hwmon/hwmon5/temp1_min_alarm should be 0644, but
> until I fix power_supply_property_is_writeable() it is 0444.

IMO it should also be unexported and renamed to
psy_property_is_writeable() to signify that it's internal to the psy
core.

> Also temp1_max_alarm is missing from the hwmon, I also have a fix
> for that one ...

