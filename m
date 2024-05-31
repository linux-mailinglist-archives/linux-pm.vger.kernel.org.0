Return-Path: <linux-pm+bounces-8453-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0836A8D5F31
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 12:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE02A1F23A31
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 10:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46141422D9;
	Fri, 31 May 2024 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvojpVt5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845FA558A5;
	Fri, 31 May 2024 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717149823; cv=none; b=NX8vnY0dFHCr/Za/EbwQDWsG0b0an0AymuGEzvRGQljH0VJELydHjVQdXSlR0Pf0TxDz9lnU2v6I/0TIqMh8StWXShEzxlfaSYRDKv8xZ/25fHNY+GMwngDjrHtPOi1DJ9iUdklNd52xRArZJ3vin4sjBD5fGB2wLBaOG5Ge+Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717149823; c=relaxed/simple;
	bh=zzwoazfnjgwqW/4OiNo7KvkuF2KIVKIBzXDfwVrAiO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPFOGtK+URgrD8DluYGYVXFiUjnAELMZap2khm54Uj85RWq1AkxwFF34SvdnoOvGPnt7I8dr4hjtsTYpdOt8fHI10M0F6DXLdSuLstIOPVO3lOg9HhXem0rMV62wnjFBd0+oxEYrT55Tcpkg2UWP51Yg9GaPsQ8E2I8oT0z1HKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvojpVt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D82C116B1;
	Fri, 31 May 2024 10:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717149823;
	bh=zzwoazfnjgwqW/4OiNo7KvkuF2KIVKIBzXDfwVrAiO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VvojpVt5qwv811tWdMtR0b+ufRhUuYUrlwckgUu6oFqpq/doi2lSuqmt0FgRsVnqg
	 H2Gy5M8SQVbRS/H61nC1hKuEXqbpokT4ywceLzFqGLsMRonzP7xhRCzjNvu4TiIUbx
	 ej/ZvBi9iB/qY9UWsSqppBSjp/dRnMJPiKiC2sZlHjt6GwekIZTHLdAoxIJRwmSKjP
	 uhAh1/Y6z8UX0vM936yQWYtVmbh/zerR41yJX7fkvVz/YQY6S55cKuJr9XbaisgWBs
	 adhkQbYfyVBo3k2BX7V6vfCJ6lV7raCVBL8qDajz0cBcaNBv3qg90xa9ykwNn8QDJY
	 yebSG1MlZRGrQ==
Date: Fri, 31 May 2024 11:03:37 +0100
From: Lee Jones <lee@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Kate Hsuan <hpa@redhat.com>, Sebastian Reichel <sre@kernel.org>,
	platform-driver-x86@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 0/7] KTD2026 indicator LED for X86 Xiaomi Pad2
Message-ID: <20240531100337.GA1005600@google.com>
References: <20240504164105.114017-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240504164105.114017-1-hdegoede@redhat.com>

On Sat, 04 May 2024, Hans de Goede wrote:

> Hi All,
> 
> Here is v9 of Kate's series to add support for Xiaomi Pad2 indicator LED.
> 
> I believe this is ready for merging now. Patch 6/7 has an Acked-by from
> Sebastien for merging this patch through the leds tree since it depends
> on the earlier patches. LEDs tree maintainers please merge patches 1-6,
> then patch 7 can be merged through the pdx86 tree independently.
> 
> This applies on top of:
> git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git ib-leds-locking-v6.10
> 
> This work includes:
> 1. Added the KTD2026 swnode description to describe the LED controller.
> 2. Migrated the original driver to fwnode to support x86 platform.
> 3. Support for multi-color LED trigger events.
> 4. The LED shows orange when charging and the LED shows green when the
>    battery is full.
> 
> Moreover, the LED trigger is set to the new trigger, called
> "bq27520-0-charging-orange-full-green" for Xiaomi Pad2 so the LED shows
> orange when charging and the LED shows green when the battery is full.
> 
> --
> Changes in v9:
> 1. Switch to devm_mutex_init()
> 2. Add Andy's Reviewed-by to the series
> 
> Changes in v8:
> 1. New bugfix: "leds: rgb: leds-ktd202x: Initialize mutex earlier"
> 2. Make charging_orange_full_green triggers set the colors in RGB order
> 3. Modify the Pad2 ktd202x fwnode to have the colors in RGB order
> 
> Changes in v7:
> 1. Platform: x86-android-tablets: other: Add swnode for Xiaomi pad2
>    indicator LED was included in Hans' branch.
> 2. Included the tags from the previous version in the commit message.
> 3. Fixed the comma issue for the structure initialiser.
> 
> Changes in v6:
> 1. The I2C ID table was moved to a separate patch.
> 2. The LED shows orange when charging.
> 3. The trigger name was renamed to charging-orange-full-green.
> 4. The default trigger of Xiaomi Pad2 is
>    "bq27520-0-charging-orange-full-green".
> 
> Changes in v5:
> 1. Fix swnode LED color settings.
> 2. Improve the driver based on the comments.
> 3. Introduce a LED new API- led_mc_trigger_event() to make the LED
>    color can be changed according to the trigger.
> 4. Introduced a new trigger "charging-red-full-green". The LED will be
>    red when charging and the LED will be green when the battery is full.
> 5. Set the default trigger to "bq27520-0-charging-red-full-green" for
>    Xiaomi Pad2.
> 
> Changes in v4:
> 1. Fix double casting.
> 2. Since force casting a pointer value to int will trigger a compiler
>    warning, the type of num_leds was changed to unsigned long.
> 
> Changes in v3:
> 1. Drop the patch "leds-ktd202x: Skip regulator settings for Xiaomi
>    pad2"
> 
> Changes in v2:
> 1. Typo and style fixes.
> 2. The patch 0003 skips all the regulator setup for Xiaomi pad2 since
>    KTD2026 on Xiaomi pad2 is already powered by BP25890RTWR. So, the
>    sleep can be removed when removing the module.
> 
> Regards,
> 
> Hans
> 
> 
> Hans de Goede (3):
>   leds: rgb: leds-ktd202x: Initialize mutex earlier
>   leds: core: Add led_mc_set_brightness() function
>   leds: trigger: Add led_mc_trigger_event() function
> 
> Kate Hsuan (4):
>   leds: rgb: leds-ktd202x: Get device properties through fwnode to
>     support ACPI
>   leds: rgb: leds-ktd202x: I2C ID tables for KTD2026 and 2027
>   power: supply: power-supply-leds: Add charging_orange_full_green
>     trigger for RGB LED
>   platform: x86-android-tablets: Xiaomi pad2 RGB LED fwnode updates
> 
>  drivers/leds/led-class-multicolor.c           |  1 +
>  drivers/leds/led-core.c                       | 31 +++++++
>  drivers/leds/led-triggers.c                   | 20 +++++
>  drivers/leds/rgb/Kconfig                      |  1 -
>  drivers/leds/rgb/leds-ktd202x.c               | 80 +++++++++++--------
>  .../platform/x86/x86-android-tablets/other.c  |  6 +-
>  drivers/power/supply/power_supply_leds.c      | 23 ++++++
>  include/linux/leds.h                          | 26 ++++++
>  include/linux/power_supply.h                  |  2 +
>  9 files changed, 152 insertions(+), 38 deletions(-)

Set is ready to go, but does not apply.

Please rebase and resubmit, thanks.

-- 
Lee Jones [李琼斯]

