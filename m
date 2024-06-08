Return-Path: <linux-pm+bounces-8813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C469F9012E4
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2024 19:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ACB91F22017
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2024 17:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A34B17839B;
	Sat,  8 Jun 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ABe7Kc3s"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0C21E4A6;
	Sat,  8 Jun 2024 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717866189; cv=none; b=Po/mlruE7ljLrvFgZiOse0I+LtKwNbUhwk+pTSrfIAGpmAQQp8dXOO+ttItv/gfsbEC04rpuFAnvBOCzwp1VzPLzuK7a9MEBeZfWPAb3cenDpiDbLDhDNgjqhcsWS85waMA7YPS3yFlRV/TF7rU/O6VDZPmL3774ayR7rO2Fak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717866189; c=relaxed/simple;
	bh=aueIvf1hpPSoXzp5MDugHfujuyMFd0wpUQBGOz+woqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SS8awZXQxEQf50Q5w8oXVPiKOE5z/C++1Q2tNpuClLC17bP9RRzUout92gxSxnpvuX5uBe2pLaFSSjZrUKxxfizNbYSsqvXKmpDVVpv/FYBLCOVMWWn5KcInQh56lohqsbyLm8+v+melOfXX9YvaulUVcoCXtkkxdb849ffoIJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ABe7Kc3s; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717866175;
	bh=aueIvf1hpPSoXzp5MDugHfujuyMFd0wpUQBGOz+woqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABe7Kc3swRWGza89hhw/QA4ntSQ27MCPhSzAk/lmH7UDsh3k8O4lpkioyPTBXKL2r
	 iiYcEWm0MHoLKRns/qfLWT/6+g4riVrK+XWi5lQvK4u7AI07E847dyKWaJ8JN8vr85
	 5lh8qB4MqsZlMGGyx83QkFFBUV+5FB0Zr633l704=
Date: Sat, 8 Jun 2024 19:02:53 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Jeremy Soller <jeremy@system76.com>, System76 Product Development <productdev@system76.com>, 
	Hans de Goede <hdegoede@redhat.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] power: supply: extension API
Message-ID: <b3d265a3-5bf0-4ed7-b959-9c92aac8fa43@t-8ch.de>
References: <20240606-power-supply-extensions-v1-0-b45669290bdc@weissschuh.net>
 <41964782-222c-45fa-846e-3656eff5b3a9@gmx.de>
 <86cafef5-8a41-46c8-8ee6-6b25dd165b58@t-8ch.de>
 <992978fb-d74c-4da7-a103-9b623b78d889@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <992978fb-d74c-4da7-a103-9b623b78d889@gmx.de>

On 2024-06-08 18:27:07+0000, Armin Wolf wrote:
> Am 07.06.24 um 12:26 schrieb Thomas Weißschuh:
> 
> > On 2024-06-07 01:10:02+0000, Armin Wolf wrote:
> > > Am 06.06.24 um 16:50 schrieb Thomas Weißschuh:
> > > 
> > > > Introduce a mechanism for drivers to extend the properties implemented
> > > > by a power supply.

<snip>

> > > > 
> > > > [0] https://lore.kernel.org/lkml/20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net/
> > > Nice, i love this proposal!
> > Good to hear!
> > 
> > > I agree that the hwmon update functionality will need some changes in the hwmon core to work,
> > > but there would be at least one driver benefiting from this (dell-wmi-ddv). Maybe we can add
> > > support for this at a later point in time.
> > Surely. Alternatively we could re-register the hwmon device after an
> > extension was added.
> > 
> > > The possibility of registering multiple power supply extensions on a single power supply will
> > > be necessary to support battery charge control on Dell notebooks in the future. This is because
> > > there will be two drivers on Dell notebooks which register battery extensions: dell-wmi-ddv and
> > > dell-laptop (when support for battery charge control is supported someday).
> > > 
> > > How difficult would it be to support such scenarios? If its very difficult, then maybe we can implement
> > > this later when the need arises.
> > It's not really difficult. The problem is in the callback functions
> > going from a 'struct power_supply' back to the correct extension struct
> > for use with container_of() to access the drivers private data.
> > 
> > But we can add a marker member to 'struct power_supply_ext' with which
> > the callback can figure out which of the registered extensions is its
> > own. Something like "led_hw_trigger_type" in the LED subsystem.
> 
> Maybe we can do the same thing as the battery hook API and just pass a pointer to
> the power_supply_ext instance to the callbacks. They then can use container_of()
> to access the drivers private data if the struct power_supply_ext is embedded
> inside the private data struct.

That indeed sounds like the obvious thing to do.
I tried very hard to keep the callback signatures exactly the same as in
power_supply_desc and didn't even see this possibility.

> 
> > 
> > And some documentation about how conflicts are to be resolved.
> > 
> > Thomas
> 
> Sound like a plan, i suggest that extensions be prevented from registering with
> a power supply containing conflicting properties or containing extensions with
> conflicting properties.

Ack.

> As a side note, maybe there is a way to make power_supply_update_groups() available
> for other power supply drivers? Afaik the ACPI battery driver would benefit from this too.

I'll take a look and spin that into its own series.
Or as you seem to know that driver better, I'd be happy if you did.

> Thanks,
> Armin Wolf
> 
> > > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > > ---
> > > > Thomas Weißschuh (6):
> > > >         power: supply: sysfs: use power_supply_property_is_writeable()
> > > >         power: supply: core: avoid iterating properties directly
> > > >         power: supply: core: implement extension API
> > > >         power: supply: core: add locking around extension access
> > > >         power: supply: test-power: implement a power supply extension
> > > >         platform/x86: system76: Use power_supply extension API
> > > > 
> > > >    drivers/platform/x86/system76_acpi.c      |  83 +++++++++---------
> > > >    drivers/power/supply/power_supply.h       |   9 ++
> > > >    drivers/power/supply/power_supply_core.c  | 136 ++++++++++++++++++++++++++++--
> > > >    drivers/power/supply/power_supply_hwmon.c |  48 +++++------
> > > >    drivers/power/supply/power_supply_sysfs.c |  39 ++++++---
> > > >    drivers/power/supply/test_power.c         | 102 ++++++++++++++++++++++
> > > >    include/linux/power_supply.h              |  25 ++++++
> > > >    7 files changed, 357 insertions(+), 85 deletions(-)
> > > > ---
> > > > base-commit: 2df0193e62cf887f373995fb8a91068562784adc
> > > > change-id: 20240602-power-supply-extensions-07d949f509d9

