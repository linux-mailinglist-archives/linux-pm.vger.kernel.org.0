Return-Path: <linux-pm+bounces-4308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 654F28604FD
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 22:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204D0284891
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 21:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A54212D1E7;
	Thu, 22 Feb 2024 21:42:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA0B73F2F
	for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708638143; cv=none; b=E6CVKT+7d7Wg+XRU4XSd/BRDdGgRvqUuPGR8Ekuuw6/4d4t88Y/KfZf5roevL0gV98sdxb9pjS2kNSEY25qi8wgGhwbAvw4ERA2yreXlaetwLVyM1e2qUu4CMEf/btGAEU3BIrnrtjDBfsqn5bhxFBZ0bSgBMRXbsbsE5LtTi7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708638143; c=relaxed/simple;
	bh=3qH6a911hvLZnHJF5DoZ8K6rR8//RgNHgPFdiHBY9tk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQMmeRVxdDeCinwCIaMrLVxxs22s//1MCzwGWFWgrsvnygDmvdUQio5akm9Ug2gQp/vDFfoQwB6DupIh+YxuyYhPfp1tt2/si+LihH3XOgv+Q9AwUeqnVsjhYu5DugrDK6xlFA63IXT7EQuxe4/jqxRVfKSOF5k/kESZp/i88R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 3c868ecd-d1cb-11ee-b3cf-005056bd6ce9;
	Thu, 22 Feb 2024 23:42:13 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Thu, 22 Feb 2024 23:42:11 +0200
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Aleksandr Mezin <mezin.alexander@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-gpio@vger.kernel.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	George Stark <gnstark@salutedevices.com>
Subject: Re: [PATCH 1/2] devm-helpers: Add resource managed version of mutex
 init
Message-ID: <Zde_s8iecR2ArKjC@surfacebook.localdomain>
References: <20240222145838.12916-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222145838.12916-1-kabel@kernel.org>

Thu, Feb 22, 2024 at 03:58:37PM +0100, Marek Behún kirjoitti:
> A few drivers are doing resource-managed mutex initialization by
> implementing ad-hoc one-liner mutex dropping functions and using them
> with devm_add_action_or_reset(). Help drivers avoid these repeated
> one-liners by adding managed version of mutex initialization.
> 
> Use the new function devm_mutex_init() in the following drivers:
>   drivers/gpio/gpio-pisosr.c
>   drivers/gpio/gpio-sim.c
>   drivers/gpu/drm/xe/xe_hwmon.c
>   drivers/hwmon/nzxt-smart2.c
>   drivers/leds/leds-is31fl319x.c
>   drivers/power/supply/mt6370-charger.c
>   drivers/power/supply/rt9467-charger.c

Pardon me, but why?

https://lore.kernel.org/linux-leds/20231214173614.2820929-1-gnstark@salutedevices.com/

Can you cooperate, folks, instead of doing something independently?


> --- a/include/linux/devm-helpers.h
> +++ b/include/linux/devm-helpers.h
> @@ -24,6 +24,8 @@
>   */
>  
>  #include <linux/device.h>
> +#include <linux/kconfig.h>
> +#include <linux/mutex.h>
>  #include <linux/workqueue.h>
>  
>  static inline void devm_delayed_work_drop(void *res)
> @@ -76,4 +78,34 @@ static inline int devm_work_autocancel(struct device *dev,
>  	return devm_add_action(dev, devm_work_drop, w);
>  }
>  
> +static inline void devm_mutex_drop(void *res)
> +{
> +	mutex_destroy(res);
> +}
> +
> +/**
> + * devm_mutex_init - Resource managed mutex initialization
> + * @dev:	Device which lifetime mutex is bound to
> + * @lock:	Mutex to be initialized (and automatically destroyed)
> + *
> + * Initialize mutex which is automatically destroyed when driver is detached.
> + * A few drivers initialize mutexes which they want destroyed before driver is
> + * detached, for debugging purposes.
> + * devm_mutex_init() can be used to omit the explicit mutex_destroy() call when
> + * driver is detached.
> + */
> +static inline int devm_mutex_init(struct device *dev, struct mutex *lock)
> +{
> +	mutex_init(lock);
> +
> +	/*
> +	 * mutex_destroy() is an empty function if CONFIG_DEBUG_MUTEXES is
> +	 * disabled. No need to allocate an action in that case.
> +	 */
> +	if (IS_ENABLED(CONFIG_DEBUG_MUTEXES))
> +		return devm_add_action_or_reset(dev, devm_mutex_drop, lock);
> +	else
> +		return 0;
> +}

Cc: George Stark <gnstark@salutedevices.com>

-- 
With Best Regards,
Andy Shevchenko



