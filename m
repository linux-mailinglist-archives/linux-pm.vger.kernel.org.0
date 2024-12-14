Return-Path: <linux-pm+bounces-19235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EC99F1D2C
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 08:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55B218838ED
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 07:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3319713A26F;
	Sat, 14 Dec 2024 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="JfMtAxSB"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ABE1CD2C;
	Sat, 14 Dec 2024 07:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734162804; cv=none; b=ENyyXst81cMbyeFDOiH9ryiqQ3CIZCeC50HQahL6g0aQAYK8UPCT/2YVvk3VP76qUSmk2Dw5BEtByMCmlsveOpP6XdB/lyelIU28/yr1nL2WB+j4npLmntfVCSO4xTyvdQMa85v1MPFd2JmiX+1zA6C2TTKfn5mXiFlfjIZWwsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734162804; c=relaxed/simple;
	bh=fxw6X+UXrcG3EGEQM/Ie6kxNM6DUBbOk+RNZ1QExddQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V75G0w/3N+VQmF5rtf6SX834gMs3X9buMu/AdwMfLgZOEQ583vL2jNnaBP7sXaXf+//VaPtk5NG7Q+iUYP+vzpU52IZXo+cWps/805Xs9Z2aPFFJ7bbmL9LvehZO5HHQWx5i5gjp/EN8CBGvFNf+5HDLS/ODE6hoNDBxElu/n3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=JfMtAxSB; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734162791;
	bh=fxw6X+UXrcG3EGEQM/Ie6kxNM6DUBbOk+RNZ1QExddQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JfMtAxSB7IcVJUONVbaIURRMZ4LacN4mOFZq92a/bS9FA6CiZJ/IVNstLX105pIaK
	 Aazk8XuxQaBxT/8JyC13YoAnpVmIdbxCYHqXQUP0TUJSyKe04k4hQuTesIkyMcp5RX
	 YlQL0TtuvR2K+48ktOy4X6666FF+4AOoLbFw9WZI=
Date: Sat, 14 Dec 2024 08:53:10 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
	Hans de Goede <hdegoede@redhat.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>
Cc: linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 4/4] power: supply: core: add UAPI to discover
 currently used extensions
Message-ID: <12c775fd-0adc-4dca-aac8-91b353e4f01f@t-8ch.de>
References: <20241211-power-supply-extensions-v6-0-9d9dc3f3d387@weissschuh.net>
 <20241211-power-supply-extensions-v6-4-9d9dc3f3d387@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211-power-supply-extensions-v6-4-9d9dc3f3d387@weissschuh.net>

On 2024-12-11 20:57:58+0100, Thomas Weißschuh wrote:
> Userspace wants to now about the used power supply extensions,
> for example to handle a device extended by a certain extension
> differently or to discover information about the extending device.
> 
> Add a sysfs directory to the power supply device.
> This directory contains links which are named after the used extension
> and point to the device implementing that extension.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  Documentation/ABI/testing/sysfs-class-power |  9 +++++++++
>  drivers/power/supply/cros_charge-control.c  |  5 ++++-
>  drivers/power/supply/power_supply.h         |  2 ++
>  drivers/power/supply/power_supply_core.c    | 19 +++++++++++++++++--
>  drivers/power/supply/power_supply_sysfs.c   | 10 ++++++++++
>  drivers/power/supply/test_power.c           |  4 +++-
>  include/linux/power_supply.h                |  2 ++
>  7 files changed, 47 insertions(+), 4 deletions(-)

[..]

> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1346,17 +1346,21 @@ static int power_supply_update_sysfs_and_hwmon(struct power_supply *psy)
>  }
>  
>  int power_supply_register_extension(struct power_supply *psy, const struct power_supply_ext *ext,
> -				    void *data)
> +				    struct device *dev, void *data)
>  {
>  	struct power_supply_ext_registration *reg;
>  	size_t i;
>  	int ret;
>  
> -	if (!psy || !ext || !ext->properties || !ext->num_properties)
> +	if (!psy || !dev || !ext || !ext->name || !ext->properties || !ext->num_properties)
>  		return -EINVAL;
>  
>  	guard(rwsem_write)(&psy->extensions_sem);
>  
> +	power_supply_for_each_extension(reg, psy)
> +		if (strcmp(ext->name, reg->ext->name) == 0)
> +			return -EEXIST;
> +
>  	for (i = 0; i < ext->num_properties; i++)
>  		if (power_supply_has_property(psy, ext->properties[i]))
>  			return -EEXIST;
> @@ -1366,9 +1370,15 @@ int power_supply_register_extension(struct power_supply *psy, const struct power
>  		return -ENOMEM;
>  
>  	reg->ext = ext;
> +	reg->dev = dev;
>  	reg->data = data;
>  	list_add(&reg->list_head, &psy->extensions);
>  
> +	ret = sysfs_add_link_to_group(&psy->dev.kobj, power_supply_extension_group.name,
> +				      &dev->kobj, ext->name);
> +	if (ret)
> +		goto sysfs_link_failed;
> +
>  	ret = power_supply_update_sysfs_and_hwmon(psy);
>  	if (ret)
>  		goto sysfs_hwmon_failed;
> @@ -1376,6 +1386,8 @@ int power_supply_register_extension(struct power_supply *psy, const struct power
>  	return 0;
>  
>  sysfs_hwmon_failed:
> +	sysfs_remove_link_from_group(&psy->dev.kobj, power_supply_extension_group.name, ext->name);
> +sysfs_link_failed:
>  	list_del(&reg->list_head);
>  	kfree(reg);
>  	return ret;
> @@ -1392,6 +1404,9 @@ void power_supply_unregister_extension(struct power_supply *psy, const struct po
>  		if (reg->ext == ext) {
>  			list_del(&reg->list_head);
>  			kfree(reg);
> +			sysfs_remove_link_from_group(&psy->dev.kobj,
> +						     power_supply_extension_group.name,
> +						     reg->ext->name);

Dan Carpenter's sparse bot detected a use after free here.
Could you move the call to sysfs_remove_link_from_group() before the
kfree() when applying?

(Or switch reg->ext->name to ext->name)

>  			power_supply_update_sysfs_and_hwmon(psy);
>  			return;
>  		}

[..]


Thanks,
Thomas

