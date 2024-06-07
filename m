Return-Path: <linux-pm+bounces-8768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10629000C6
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 12:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927A1287802
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 10:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025F315CD6E;
	Fri,  7 Jun 2024 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hJFrSZ1+"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D6A1C696;
	Fri,  7 Jun 2024 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756009; cv=none; b=oG0S2MvXQl31WlqKngniJ3tgQTtfn2m9GzCQ71rd9HslDiu1B7KlhlikAUDQaHOtCMrA/yJnFeenT7HZli6oqXDkfwjwKQneLeY4XSY7BpKR8AndczVZilkfiE0bWf30gg2hNmF39OSig0XaLm/27VqvZlc+srap6BQx1LZc7QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756009; c=relaxed/simple;
	bh=L8hh8h9Kw7HDmZBu1X/FxLri/dZ/ljCv84KhbOuROHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTc+WfJmQWW9PTzhLt9nHPDLELhRF6Jw6uTHu6TGGsgdBk6aSei2fBoNgaQ8A+OBMLYSIrlJE1pOBhFYowdYtBCMlbVZBl805r0wkwRrdyzp0GGXughAQ8W2rfR5ZsFnv7pKNJOB6UFZA32+I17wcW7X1lveJ+FX8gSGTAYSLd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hJFrSZ1+; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717755998;
	bh=L8hh8h9Kw7HDmZBu1X/FxLri/dZ/ljCv84KhbOuROHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hJFrSZ1+oeET+Us7k2C0UAlJDvQXXPBjdm/aVQ3fTqWkRsqqcMBY5wK9crYIT9w/T
	 CmxojKtNAOn0qSaRXJA7JX7j5TzDK1dazP8iwtDSubqelRaThycNpzxOYgQKwNoEAL
	 IBDWJq3aVWNxe9EVyRAVhCm8B+jk77NihQJc7K8o=
Date: Fri, 7 Jun 2024 12:26:37 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Jeremy Soller <jeremy@system76.com>, System76 Product Development <productdev@system76.com>, 
	Hans de Goede <hdegoede@redhat.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] power: supply: extension API
Message-ID: <86cafef5-8a41-46c8-8ee6-6b25dd165b58@t-8ch.de>
References: <20240606-power-supply-extensions-v1-0-b45669290bdc@weissschuh.net>
 <41964782-222c-45fa-846e-3656eff5b3a9@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41964782-222c-45fa-846e-3656eff5b3a9@gmx.de>

On 2024-06-07 01:10:02+0000, Armin Wolf wrote:
> Am 06.06.24 um 16:50 schrieb Thomas Weißschuh:
> 
> > Introduce a mechanism for drivers to extend the properties implemented
> > by a power supply.
> > 
> > Motivation
> > ----------
> > 
> > Various drivers, mostly in platform/x86 extend the ACPI battery driver
> > with additional sysfs attributes to implement more UAPIs than are
> > exposed through ACPI by using various side-channels, like WMI,
> > nonstandard ACPI or EC communication.
> > 
> > While the created sysfs attributes look similar to the attributes
> > provided by the powersupply core, there are various deficiencies:
> > 
> > * They don't show up in uevent payload.
> > * They can't be queried with the standard in-kernel APIs.
> > * They don't work with triggers.
> > * The extending driver has to reimplement all of the parsing,
> >    formatting and sysfs display logic.
> > * Writing a extension driver is completely different from writing a
> >    normal power supply driver.
> > * Properties can not be properly overriden.
> > 
> > The proposed extension API avoids all of these issues.
> > An extension is just a "struct power_supply_ext" with the same kind of
> > callbacks as in a normal "struct power_supply_desc".
> > 
> > The API is meant to be used via battery_hook_register(), the same way as
> > the current extensions.
> > 
> > For example my upcoming cros_ec charge control driver[0] saves 80 lines
> > of code with this patchset.
> > 
> > Contents
> > --------
> > 
> > * Patch 1 and 2 are generic preparation patches, that probably make
> >    sense without this series.
> > * Patch 3 implements the extension API itself.
> > * Patch 4 implements a PoC locking scheme for the extension API.
> > * Patch 5 adds extension support to test_power.c
> > * Patch 6 converts the in-tree platform/x86/system76 driver to the
> >    extension API.
> > 
> > Open issues
> > -----------
> > 
> > * Newly registered properties will not show up in hwmon.
> >    To do that properly would require some changes in the hwmon core.
> >    As far as I know, no current driver would extend the hwmon properties anyways.
> > * As this is only useful with the hooks of CONFIG_ACPI_BATTERY, should
> >    it also be gated behind this or another config?
> > * Only one extension can be used at a time.
> >    So far this should be enough, having more would complicate the
> >    implementation.
> > * Is an rw_semaphore acceptable?
> > 
> > [0] https://lore.kernel.org/lkml/20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net/
> 
> Nice, i love this proposal!

Good to hear!

> I agree that the hwmon update functionality will need some changes in the hwmon core to work,
> but there would be at least one driver benefiting from this (dell-wmi-ddv). Maybe we can add
> support for this at a later point in time.

Surely. Alternatively we could re-register the hwmon device after an
extension was added.

> The possibility of registering multiple power supply extensions on a single power supply will
> be necessary to support battery charge control on Dell notebooks in the future. This is because
> there will be two drivers on Dell notebooks which register battery extensions: dell-wmi-ddv and
> dell-laptop (when support for battery charge control is supported someday).
> 
> How difficult would it be to support such scenarios? If its very difficult, then maybe we can implement
> this later when the need arises.

It's not really difficult. The problem is in the callback functions
going from a 'struct power_supply' back to the correct extension struct
for use with container_of() to access the drivers private data.

But we can add a marker member to 'struct power_supply_ext' with which
the callback can figure out which of the registered extensions is its
own. Something like "led_hw_trigger_type" in the LED subsystem.

And some documentation about how conflicts are to be resolved.

Thomas

> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > Thomas Weißschuh (6):
> >        power: supply: sysfs: use power_supply_property_is_writeable()
> >        power: supply: core: avoid iterating properties directly
> >        power: supply: core: implement extension API
> >        power: supply: core: add locking around extension access
> >        power: supply: test-power: implement a power supply extension
> >        platform/x86: system76: Use power_supply extension API
> > 
> >   drivers/platform/x86/system76_acpi.c      |  83 +++++++++---------
> >   drivers/power/supply/power_supply.h       |   9 ++
> >   drivers/power/supply/power_supply_core.c  | 136 ++++++++++++++++++++++++++++--
> >   drivers/power/supply/power_supply_hwmon.c |  48 +++++------
> >   drivers/power/supply/power_supply_sysfs.c |  39 ++++++---
> >   drivers/power/supply/test_power.c         | 102 ++++++++++++++++++++++
> >   include/linux/power_supply.h              |  25 ++++++
> >   7 files changed, 357 insertions(+), 85 deletions(-)
> > ---
> > base-commit: 2df0193e62cf887f373995fb8a91068562784adc
> > change-id: 20240602-power-supply-extensions-07d949f509d9

