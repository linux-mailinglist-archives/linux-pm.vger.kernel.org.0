Return-Path: <linux-pm+bounces-18925-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 374709EB71F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 17:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D275165BD2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 16:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F963231C8C;
	Tue, 10 Dec 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="EeTvAvgX"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754A5230D2C;
	Tue, 10 Dec 2024 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849517; cv=none; b=LBbX5OYXCbvCOzmgw/XTLvZiaf5c//uYteBieKlkJZ5+yV4FUDHpiSOdLsI/kgcrhYUzmpgRcYXU785nnS7O5zm5Qq5I1IC4WN5esLzjndnXLS4a1XzN1jkiC+U0BxZRtefrKUU0konkYq5BtbJ/f2Dv7vrqLE6BDn9728XsEso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849517; c=relaxed/simple;
	bh=gaQySQkwwY6ayjIjivNHXPWGhrJ5ONC+ndSahpeBSoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYGhjhEgK6uyAFPsHhrp3BU8CLXUPQ8wMiaw4dJKLFRYL42nJ6/VRmV7t/1kgWQuSlpSy4FZCV5MWOMUMLBCDJe3XdrCjoZooeCLWGejOkHj3IkY48k40g95hTWuIgFrgdlot8Br//uwWHyf5RIscHyGyFgr7zRprPByQcfkIzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=EeTvAvgX; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733849512;
	bh=gaQySQkwwY6ayjIjivNHXPWGhrJ5ONC+ndSahpeBSoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EeTvAvgX1qb/7GmvdO0QmEFIBHqL+vxwdfZwwbB+R1TyvJAlbc2toHg6+SgmcNL6q
	 nTpg4HgEb4a3xe3uKhVN12W343dqZcRCP7JZtHH/5l6svufNaBBGOBOKjoCBXAqMUB
	 vHL4KOAMb3kvdXmUheLDvPAXmH4gbVIBMzZkdHWY=
Date: Tue, 10 Dec 2024 17:51:51 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	platform-driver-x86@vger.kernel.org, Jelle van der Waa <jelle@vdwaa.nl>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/4] power: supply: bq24190_charger: Add support for
 "charge_types" property
Message-ID: <1ea66f67-d9d1-4dad-b911-a5e32d3a68d2@t-8ch.de>
References: <20241209204051.8786-1-hdegoede@redhat.com>
 <20241209204051.8786-4-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241209204051.8786-4-hdegoede@redhat.com>

On 2024-12-09 21:40:50+0100, Hans de Goede wrote:
> The bq24190 power_supply class device has a writeable "charge_type"
> property, add support for the new "charge_types" property. Reading this
> returns a list of supported charge-types with the currently active type
> surrounded by square brackets, allowing userspace to find out which
> enum power_supply_charge_type values are supported.
> 
> This has been tested on a GPD win gaming-handheld.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  drivers/power/supply/bq24190_charger.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index 2b393eb5c282..0101aaca1a97 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1313,6 +1313,7 @@ static int bq24190_charger_get_property(struct power_supply *psy,
>  
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +	case POWER_SUPPLY_PROP_CHARGE_TYPES:
>  		ret = bq24190_charger_get_charge_type(bdi, val);
>  		break;
>  	case POWER_SUPPLY_PROP_HEALTH:
> @@ -1393,6 +1394,7 @@ static int bq24190_charger_set_property(struct power_supply *psy,
>  		ret = bq24190_charger_set_temp_alert_max(bdi, val);
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +	case POWER_SUPPLY_PROP_CHARGE_TYPES:
>  		ret = bq24190_charger_set_charge_type(bdi, val);
>  		break;
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> @@ -1421,6 +1423,7 @@ static int bq24190_charger_property_is_writeable(struct power_supply *psy,
>  	case POWER_SUPPLY_PROP_ONLINE:
>  	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
>  	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +	case POWER_SUPPLY_PROP_CHARGE_TYPES:
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> @@ -1469,6 +1472,7 @@ static void bq24190_charger_external_power_changed(struct power_supply *psy)
>  
>  static enum power_supply_property bq24190_charger_properties[] = {
>  	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_CHARGE_TYPES,
>  	POWER_SUPPLY_PROP_HEALTH,
>  	POWER_SUPPLY_PROP_ONLINE,
>  	POWER_SUPPLY_PROP_STATUS,
> @@ -1498,6 +1502,9 @@ static const struct power_supply_desc bq24190_charger_desc = {
>  	.set_property		= bq24190_charger_set_property,
>  	.property_is_writeable	= bq24190_charger_property_is_writeable,
>  	.external_power_changed	= bq24190_charger_external_power_changed,
> +	.charge_types		= BIT(POWER_SUPPLY_CHARGE_TYPE_NONE)    |
> +				  BIT(POWER_SUPPLY_CHARGE_TYPE_TRICKLE) |
> +				  BIT(POWER_SUPPLY_CHARGE_TYPE_FAST),
>  };
>  
>  /* Battery power supply property routines */
> -- 
> 2.47.1
> 

