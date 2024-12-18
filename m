Return-Path: <linux-pm+bounces-19459-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAB29F6E91
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 20:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F21188BF9D
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1821AA1DC;
	Wed, 18 Dec 2024 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+z6/K84"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3291155C87;
	Wed, 18 Dec 2024 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734551554; cv=none; b=oG8VSRpkMeapefKcVjztzsApuN+ccZrjYqvO/JxAfoIR4ngCsjp0fLoOoFyyv79/DBXnbbWBOT2MJ9u5t+LL08+E7+38QiPDssRsL7SnbW8k/y2oyRFNOal8IzKiF0rOCLy3j0vJbkqccqRiTbaDLTny/be2L8fYywOVw7flWQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734551554; c=relaxed/simple;
	bh=MTDqj2C6p8mu61jp/vPRGFl8kUJBhrxZD/OzxDofY4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAchDrWnWEOvhvBeV5rSSYFF6g5RL8QLfFyxtJPDY0J3Fq6NUjcfG1gT8DfgtbV68DRaxJoWsDnU0AdVLpBFvC5e9Y4221HlyvmrZgC2H4BMJO++4qJYNT5UWvR1+F0N/+Kg0r2s3iHdKsMDD/M9bGNEvskzrYEHYk6K/JQgOxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+z6/K84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D155C4CECD;
	Wed, 18 Dec 2024 19:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734551553;
	bh=MTDqj2C6p8mu61jp/vPRGFl8kUJBhrxZD/OzxDofY4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o+z6/K84LHeO1ksCvn7ADx7+GlQoQ9Fw7QQZBzWTyhhN6yDSMVSKe0OXE9kZO9hkV
	 v4VG5xFOE85o/D+LYpBISQ54H18DsqxkDbq5r1Lmv9UivDObbodIg3JaMlqW42WGz4
	 JyME7yIeDy8zOhdLBPvEZ5yMccFcB3P4n6nGsxcluYO6HA2sHAKT6nL65pejwOWSyt
	 o4uaFIQOjnVPhRBd+DXDCUDbxy/L4pHqx7PlpuuAlragAzoUgZP8AMwp8OGU+q09LT
	 2K0ko+QllqJFTPZyuu0z9b65W02UgkJVFLssx6WEGtZWIneYOtrrxt9zbMVuAR2w6Z
	 2yyBAMxR6lOWA==
Date: Wed, 18 Dec 2024 12:52:29 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 4/4] power: supply: core: add UAPI to discover
 currently used extensions
Message-ID: <20241218195229.GA2796534@ax162>
References: <20241211-power-supply-extensions-v6-0-9d9dc3f3d387@weissschuh.net>
 <20241211-power-supply-extensions-v6-4-9d9dc3f3d387@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211-power-supply-extensions-v6-4-9d9dc3f3d387@weissschuh.net>

Hi Thomas,

On Wed, Dec 11, 2024 at 08:57:58PM +0100, Thomas Weiﬂschuh wrote:
> Userspace wants to now about the used power supply extensions,
> for example to handle a device extended by a certain extension
> differently or to discover information about the extending device.
> 
> Add a sysfs directory to the power supply device.
> This directory contains links which are named after the used extension
> and point to the device implementing that extension.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  Documentation/ABI/testing/sysfs-class-power |  9 +++++++++
>  drivers/power/supply/cros_charge-control.c  |  5 ++++-
>  drivers/power/supply/power_supply.h         |  2 ++
>  drivers/power/supply/power_supply_core.c    | 19 +++++++++++++++++--
>  drivers/power/supply/power_supply_sysfs.c   | 10 ++++++++++
>  drivers/power/supply/test_power.c           |  4 +++-
>  include/linux/power_supply.h                |  2 ++
>  7 files changed, 47 insertions(+), 4 deletions(-)
...
> diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
> index 531785516d2ac31f9a7f73a58e15e64cb81820ed..9ed749cd09369f0f13017847687509736b30aae8 100644
> --- a/drivers/power/supply/power_supply.h
> +++ b/drivers/power/supply/power_supply.h
> @@ -39,6 +40,7 @@ struct power_supply_ext_registration {
>  
>  extern void __init power_supply_init_attrs(void);
>  extern int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env);
> +extern const struct attribute_group power_supply_extension_group;
>  extern const struct attribute_group *power_supply_attr_groups[];
>  
>  #else
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index bc22edbd0e6a02c27500132075f5c98d814a7330..5142fbd580ee3d629a2aae7d0b9bcd5709162129 100644
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
>  			power_supply_update_sysfs_and_hwmon(psy);
>  			return;
>  		}

I am seeing a build failure in certain configurations because
power_supply_extension_group is only declared under a CONFIG_SYSFS ifdef
but this code can be built without CONFIG_SYSFS.

  $ echo 'CONFIG_EXPERT=y
  CONFIG_SYSFS=n' >allno.config

  $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- KCONFIG_ALLCONFIG=1 mrproper allnoconfig drivers/power/supply/power_supply_core.o
  drivers/power/supply/power_supply_core.c: In function 'power_supply_register_extension':
  drivers/power/supply/power_supply_core.c:1389:55: error: 'power_supply_extension_group' undeclared (first use in this function); did you mean 'power_supply_attr_groups'?
   1389 |         ret = sysfs_add_link_to_group(&psy->dev.kobj, power_supply_extension_group.name,
        |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
        |                                                       power_supply_attr_groups
  drivers/power/supply/power_supply_core.c:1389:55: note: each undeclared identifier is reported only once for each function it appears in
  drivers/power/supply/power_supply_core.c: In function 'power_supply_unregister_extension':
  drivers/power/supply/power_supply_core.c:1419:54: error: 'power_supply_extension_group' undeclared (first use in this function); did you mean 'power_supply_attr_groups'?
   1419 |                                                      power_supply_extension_group.name,
        |                                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
        |                                                      power_supply_attr_groups

Should the declaration be moved out from the ifdef or is there some
other solution I am not seeing?

Cheers,
Nathan

diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
index 9ed749cd0936..6fc9939145fc 100644
--- a/drivers/power/supply/power_supply.h
+++ b/drivers/power/supply/power_supply.h
@@ -40,7 +40,6 @@ struct power_supply_ext_registration {
 
 extern void __init power_supply_init_attrs(void);
 extern int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env);
-extern const struct attribute_group power_supply_extension_group;
 extern const struct attribute_group *power_supply_attr_groups[];
 
 #else
@@ -51,6 +50,8 @@ static inline void power_supply_init_attrs(void) {}
 
 #endif /* CONFIG_SYSFS */
 
+extern const struct attribute_group power_supply_extension_group;
+
 #ifdef CONFIG_LEDS_TRIGGERS
 
 extern void power_supply_update_leds(struct power_supply *psy);

