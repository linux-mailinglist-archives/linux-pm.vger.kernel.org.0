Return-Path: <linux-pm+bounces-29758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A326EAEC65A
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 11:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C7F16C717
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 09:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FF923C519;
	Sat, 28 Jun 2025 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koMJosSw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C449122D7A3;
	Sat, 28 Jun 2025 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751102718; cv=none; b=LH9LroB2YtpZOb2FoH8UCuFIp/nd1UCZhX+8BexJPrHMA9+2k6b8Lu/Xi8LRfYNOmroVeUKFcena9bkzILkSYZOIAyoP+evkylEikAiiDPGBVa7MicDRP80NDqkJEqQv1fnnDrsiiB5wiwmYognvTke6zR0qz2CV2XxtbnsYTh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751102718; c=relaxed/simple;
	bh=JojSEzA7X+jR/kNu89V44GciVsM5eLhWK20LdmEerYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzkm67DwKIOJR+hcZydIRkXHQRpJtgywErDpIITyInbgT2W1XXDPZ5X3hfk6IHSsGnDQbj37raTI3sgdibsAvBkXFJsvSHykV8hG5/VgsWlTCqq8dhv7Zh13QGRRHOCyiXoPTXJkrc8C43blJRc3QAbdUJ2U+wyRWPHHL43dzFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koMJosSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC08FC4CEEA;
	Sat, 28 Jun 2025 09:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751102715;
	bh=JojSEzA7X+jR/kNu89V44GciVsM5eLhWK20LdmEerYg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=koMJosSwX6VQDUq+sHVJSRy77pEEC9ebRBeCWLTcOu9j1hQ4hyc6kBNCPemVMkIb9
	 aglPZ0E7ilfXJ28eCGOoe0wX/Bbtzx4Bq8Ttyur8syBqFKIezZ4HwK243bqoEZf6sP
	 pN6DZOe49VDndB4fph8xo5ybJfSEj/nJq0GKa1hffUCxCLYOfjz6LLCLAw8fe0TDy8
	 /+TpkbZjvjw3t2VwlAQlIT9CQORYQNIDuEpvvlwDWTHhh9u12cUeSJjgudEx5v7inH
	 6AFAPPppk7Yb3dlcCvk8UY5m2jr0wbBLtaGDi3YfqpmXgpw3Up1mFvztdOoTvxk3qz
	 /ex/hPMaQ1jig==
Message-ID: <b4e077d9-a5f5-47ec-abc7-9e957c32cd5b@kernel.org>
Date: Sat, 28 Jun 2025 11:25:11 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] power: supply: core: Add
 power_supply_get/set_property_direct()
To: Armin Wolf <W_Armin@gmx.de>, sre@kernel.org, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250627205124.250433-1-W_Armin@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250627205124.250433-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Armin,

On 27-Jun-25 10:51 PM, Armin Wolf wrote:
> Power supply extensions might want to interact with the underlying
> power supply to retrieve data like serial numbers, charging status
> and more. However doing so causes psy->extensions_sem to be locked
> twice, possibly causing a deadlock.
> 
> Provide special variants of power_supply_get/set_property() that
> ignore any power supply extensions and thus do not touch the
> associated psy->extensions_sem lock.
> 
> Suggested-by: Hans de Goede <hansg@kernel.org>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your work on this.

The entire series looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

for the series.

There is the question of how to merge this. I think it might
be best for the entire series to go through the power-supply
tree.

Ilpo would that work for you and if yes can we have your ack ?

Sebastian, IMHO this should be merged as fixed not as for-next
material.

Regards,

Hans




> ---
>  drivers/power/supply/power_supply_core.c | 82 ++++++++++++++++++++----
>  include/linux/power_supply.h             |  8 +++
>  2 files changed, 78 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index aedb20c1d276..e70ffedf1a80 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1241,9 +1241,8 @@ bool power_supply_has_property(struct power_supply *psy,
>  	return false;
>  }
>  
> -int power_supply_get_property(struct power_supply *psy,
> -			    enum power_supply_property psp,
> -			    union power_supply_propval *val)
> +static int __power_supply_get_property(struct power_supply *psy, enum power_supply_property psp,
> +				       union power_supply_propval *val, bool use_extensions)
>  {
>  	struct power_supply_ext_registration *reg;
>  
> @@ -1253,10 +1252,14 @@ int power_supply_get_property(struct power_supply *psy,
>  		return -ENODEV;
>  	}
>  
> -	scoped_guard(rwsem_read, &psy->extensions_sem) {
> -		power_supply_for_each_extension(reg, psy) {
> -			if (power_supply_ext_has_property(reg->ext, psp))
> +	if (use_extensions) {
> +		scoped_guard(rwsem_read, &psy->extensions_sem) {
> +			power_supply_for_each_extension(reg, psy) {
> +				if (!power_supply_ext_has_property(reg->ext, psp))
> +					continue;
> +
>  				return reg->ext->get_property(psy, reg->ext, reg->data, psp, val);
> +			}
>  		}
>  	}
>  
> @@ -1267,20 +1270,49 @@ int power_supply_get_property(struct power_supply *psy,
>  	else
>  		return -EINVAL;
>  }
> +
> +int power_supply_get_property(struct power_supply *psy, enum power_supply_property psp,
> +			      union power_supply_propval *val)
> +{
> +	return __power_supply_get_property(psy, psp, val, true);
> +}
>  EXPORT_SYMBOL_GPL(power_supply_get_property);
>  
> -int power_supply_set_property(struct power_supply *psy,
> -			    enum power_supply_property psp,
> -			    const union power_supply_propval *val)
> +/**
> + * power_supply_get_property_direct - Read a power supply property without checking for extensions
> + * @psy: The power supply
> + * @psp: The power supply property to read
> + * @val: The resulting value of the power supply property
> + *
> + * Read a power supply property without taking into account any power supply extensions registered
> + * on the given power supply. This is mostly useful for power supply extensions that want to access
> + * their own power supply as using power_supply_get_property() directly will result in a potential
> + * deadlock.
> + *
> + * Return: 0 on success or negative error code on failure.
> + */
> +int power_supply_get_property_direct(struct power_supply *psy, enum power_supply_property psp,
> +				     union power_supply_propval *val)
> +{
> +        return __power_supply_get_property(psy, psp, val, false);
> +}
> +EXPORT_SYMBOL_GPL(power_supply_get_property_direct);
> +
> +
> +static int __power_supply_set_property(struct power_supply *psy, enum power_supply_property psp,
> +				       const union power_supply_propval *val, bool use_extensions)
>  {
>  	struct power_supply_ext_registration *reg;
>  
>  	if (atomic_read(&psy->use_cnt) <= 0)
>  		return -ENODEV;
>  
> -	scoped_guard(rwsem_read, &psy->extensions_sem) {
> -		power_supply_for_each_extension(reg, psy) {
> -			if (power_supply_ext_has_property(reg->ext, psp)) {
> +	if (use_extensions) {
> +		scoped_guard(rwsem_read, &psy->extensions_sem) {
> +			power_supply_for_each_extension(reg, psy) {
> +				if (!power_supply_ext_has_property(reg->ext, psp))
> +					continue;
> +
>  				if (reg->ext->set_property)
>  					return reg->ext->set_property(psy, reg->ext, reg->data,
>  								      psp, val);
> @@ -1295,8 +1327,34 @@ int power_supply_set_property(struct power_supply *psy,
>  
>  	return psy->desc->set_property(psy, psp, val);
>  }
> +
> +int power_supply_set_property(struct power_supply *psy, enum power_supply_property psp,
> +			      const union power_supply_propval *val)
> +{
> +	return __power_supply_set_property(psy, psp, val, true);
> +}
>  EXPORT_SYMBOL_GPL(power_supply_set_property);
>  
> +/**
> + * power_supply_set_property_direct - Write a power supply property without checking for extensions
> + * @psy: The power supply
> + * @psp: The power supply property to write
> + * @val: The value to write to the power supply property
> + *
> + * Write a power supply property without taking into account any power supply extensions registered
> + * on the given power supply. This is mostly useful for power supply extensions that want to access
> + * their own power supply as using power_supply_set_property() directly will result in a potential
> + * deadlock.
> + *
> + * Return: 0 on success or negative error code on failure.
> + */
> +int power_supply_set_property_direct(struct power_supply *psy, enum power_supply_property psp,
> +				     const union power_supply_propval *val)
> +{
> +	return __power_supply_set_property(psy, psp, val, false);
> +}
> +EXPORT_SYMBOL_GPL(power_supply_set_property_direct);
> +
>  int power_supply_property_is_writeable(struct power_supply *psy,
>  					enum power_supply_property psp)
>  {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 45468959dd98..f21f806bfb38 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -878,15 +878,23 @@ static inline int power_supply_is_system_supplied(void) { return -ENOSYS; }
>  extern int power_supply_get_property(struct power_supply *psy,
>  			    enum power_supply_property psp,
>  			    union power_supply_propval *val);
> +int power_supply_get_property_direct(struct power_supply *psy, enum power_supply_property psp,
> +				     union power_supply_propval *val);
>  #if IS_ENABLED(CONFIG_POWER_SUPPLY)
>  extern int power_supply_set_property(struct power_supply *psy,
>  			    enum power_supply_property psp,
>  			    const union power_supply_propval *val);
> +int power_supply_set_property_direct(struct power_supply *psy, enum power_supply_property psp,
> +				     const union power_supply_propval *val);
>  #else
>  static inline int power_supply_set_property(struct power_supply *psy,
>  			    enum power_supply_property psp,
>  			    const union power_supply_propval *val)
>  { return 0; }
> +static inline int power_supply_set_property_direct(struct power_supply *psy,
> +						   enum power_supply_property psp,
> +						   const union power_supply_propval *val)
> +{ return 0; }
>  #endif
>  extern void power_supply_external_power_changed(struct power_supply *psy);
>  


