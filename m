Return-Path: <linux-pm+bounces-8673-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A528FDAFE
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 01:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58BFA1C2310E
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 23:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04D617E8E0;
	Wed,  5 Jun 2024 23:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KNBfEpor"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497DB1AAA5;
	Wed,  5 Jun 2024 23:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631555; cv=none; b=o1W1JZxblfH0QcQVuq5bs8r7L32FbWjFADJgNiH1/OLQEpe7rVIK1VsUmLwENv+6ZsLzsHbIq7r1gRxyxAtO+NSa+PF4IKHnG/uxtDa09f0tanTF1klONeHiJEK/erWLHU6t5i88iSYOLJQ7ogMurv22J+WbtP/NfY2CdDhOIfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631555; c=relaxed/simple;
	bh=S5f1uzmtb8uc01jTh5ar2w9G5sPTtr6TfMY0Y57y51I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exwogDsvrL/SjVBeonkMvJOIAhXt+5/ce3ZCODcd42EmUAkFYXmQu7/MNW6GqVij8qS/KMM9ZB2uSP5mF42RSxQLVrRg7Zd3lED+IBn279rTvu5ygGatzeMbfuHAXJBOqgeB+EJQil8i2r1uHdGwf2/Lx1CIzt2dPsZ2fSyXPUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KNBfEpor; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717631552;
	bh=S5f1uzmtb8uc01jTh5ar2w9G5sPTtr6TfMY0Y57y51I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KNBfEporJmpNknMJZiS7jXmOSq3w0jhWnijSn4zrZwzqTv3/Kj5GVr6rc6RPSfiiT
	 xT9DFOCYJQsU6Tr/r+mnHtF2sGq9z3d46OV6sWbul/Nk450x6Nk91ddyF1hbDkLe5c
	 h8ukxce5hZ0e1geY0NehPHakiJdHx9l8TbIuO3FZGdq/57JX8HhLSmx4Ms8dodvsL7
	 dvDMEhasmnTC+AwDr0wdJaRTpaSJrmOl2InBZelFa2Ofy7K5QOUwrHYHtRkyU0gTkP
	 3eC9k0VkNpiAUIOQm9hnA3MWtJu3DaWtXfGajefxKRz3zfwHhjWXnzCBzOp7xh1MMx
	 AC523n1BdeTlA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3346937820CD;
	Wed,  5 Jun 2024 23:52:32 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id ACD2B1060501; Thu, 06 Jun 2024 01:52:31 +0200 (CEST)
Date: Thu, 6 Jun 2024 01:52:31 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v4 4/6] power: supply: lenovo_yoga_c630_battery: add
 Lenovo C630 driver
Message-ID: <iefpe3vjf6u43yph2jqhd2pp6dhzk5kzseo2cffv5ksoyqk22c@2plv7xxped67>
References: <20240528-yoga-ec-driver-v4-0-4fa8dfaae7b6@linaro.org>
 <20240528-yoga-ec-driver-v4-4-4fa8dfaae7b6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ebyt27yflv6nt4ze"
Content-Disposition: inline
In-Reply-To: <20240528-yoga-ec-driver-v4-4-4fa8dfaae7b6@linaro.org>


--ebyt27yflv6nt4ze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Thanks for your patch. I have a few more comments.

On Tue, May 28, 2024 at 11:44:49PM +0300, Dmitry Baryshkov wrote:
...
> +struct yoga_c630_psy {
> +       struct yoga_c630_ec *ec;
> +       struct device *dev;
> +       struct device_node *of_node;

Please use fwnode

> +static enum power_supply_property yoga_c630_psy_bat_mA_properties[] = {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_POWER_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
> +static enum power_supply_property yoga_c630_psy_bat_mWh_properties[] = {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> +	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_ENERGY_FULL,
> +	POWER_SUPPLY_PROP_ENERGY_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_POWER_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};

Please also add

POWER_SUPPLY_PROP_SCOPE = POWER_SUPPLY_SCOPE_SYSTEM

> +static enum power_supply_property yoga_c630_psy_adpt_properties[] = {
> +       POWER_SUPPLY_PROP_ONLINE,
> +};

Please also add

POWER_SUPPLY_PROP_USB_TYPE = POWER_SUPPLY_USB_TYPE_C

> +static const struct power_supply_desc yoga_c630_psy_adpt_psy_desc = {
> +	.name = "yoga-c630-adapter",
> +	.type = POWER_SUPPLY_TYPE_USB_TYPE_C,

static const enum power_supply_usb_type yoga_c630_psy_adpt_usb_type[] = {
	POWER_SUPPLY_USB_TYPE_C,
};

.type = POWER_SUPPLY_TYPE_USB
.usb_types = yoga_c630_psy_adpt_usb_type
.num_usb_types = ARRAY_SIZE(yoga_c630_psy_adpt_usb_type),

> +	.properties = yoga_c630_psy_adpt_properties,
> +	.num_properties = ARRAY_SIZE(yoga_c630_psy_adpt_properties),
> +	.get_property = yoga_c630_psy_adpt_get_property,
> +};
> +

Greetings,

-- Sebastian

--ebyt27yflv6nt4ze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZg+jwACgkQ2O7X88g7
+prgcg/+Oj9Lis1zOv00R9LtK2n3mOqqE4WLDAnm9j8cxMhyQyNlAOY/71t6VkCU
bXeDpkoBVYVLRTHu++yw7yuBXckKJ8ZGxfzGtuHPiUzl2FjXBOjZEHCc7RlAfiHy
wLpqos2ZHrDu/IkSr1wgLmPe1nqOGbuBWJLcUgmi0pk9iKt5+tB1w2UqP7CsqDRH
ncOE7YydWI71ueD4DmBceAa4p11mUnX+dBrx2vuTWUPaAJecpP6vcIkqWiKdf5LF
USw8GvSMfEgBus/KMgohMI9YJvNeNM/iC8wjxjOFHN6Csvt5VmRE7L7rk/EsG1QX
g+zXiHh8FxasapjsiM5ZHwYbT5zZBLSl6DLS16gcouZu7a8spmPXDi4PafaHi46A
YGNjb1It/aUdJdA2GLjiHXZKCtmTNKTngm40UbP0BsfSJgG7tGTfQb7HNCShBOlL
V1KmhEeIuFgs0PbkAH5bu993Vu2qn19ohYwd64KWTJqXtsMlfDWxcOPw8aNBxDc1
i8kv1Tytya3a0XK3oCHUZ4AUVO2BfwbA0uLc2JVZ0LV2nJiCeFVzyW76YA4FhAPl
PeIvwvoOYAD4GtX6Ovf4npq5QMhMjG1f5QBVW1CkjXPtYeZNqAIft8AlnL0MzazY
4rKlgjL6XywuGsqmhSEO43GoBleMTQNDwi3J+LOM/u4Fmi3f1zE=
=PNUy
-----END PGP SIGNATURE-----

--ebyt27yflv6nt4ze--

