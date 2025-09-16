Return-Path: <linux-pm+bounces-34752-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C78B5A0C5
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 20:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7301642A2
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 18:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD95242D76;
	Tue, 16 Sep 2025 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Q3fPokB2"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965B413B293;
	Tue, 16 Sep 2025 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758048549; cv=pass; b=RAD2t626Nq3yq3eX13736wpygvPb1fhfI0vY4ORy9SW60MeneIJvzgdoQ8hTH+W6D+dkHB1WTEMl3b2LKjAdRaf5ZCFPJW+ttCO6/QmIMMTDHm6trvxNXy0/tykx71FLaSq7YU9vCbO1YzedOL2XRNU8D38cWDpq2YMls7cteaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758048549; c=relaxed/simple;
	bh=4WLGR2PEUe/xzGimsjJlrC6ZWZOUlx5VsHQcRRX5YLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=px1cvG0wzpdvvMKzzP5qfUJA/KRLEAOYBxcCUIx9xE2xl487SMZQfv5WPsI/ApwpqZFzjNKUdpktLX/6WSF/WJkXwPDelH3E/MuVtnkElhFRNH6apjV2hxDtvWAhnFJhUWmzort8SNxkXPnJ/9ARoYBz+OSojsDdK+ihxlFZj7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Q3fPokB2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758048524; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hOuaNoXZZWfOlDgsV2mcJcyWbXI/sr+t0ff/wa0U7GsR+e0TVEgktNcbPzROFLZ2pAOQ6ZbgwGFPCp/zHVrO+DEMxaT5q9s1QWhHPwQROuBBIFJvIRf7yOEretvcV1X3lqMLj+/vmAQ/SR3M21vfuOyygmCZjxs+qSw9omg7wjs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758048524; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=W1IJjyM9OVaQcEmkWiSOUFeaD6n08j4ucNHzBhm+qQk=; 
	b=kzAxViRb7tuY3qv8/NQnlFlrN3pTBinQXT635SjNgoLkDaxb7hfr8mjrPScuiMioOGNM1vLXvu2QJPuoZN6eEcKPXZTIu9zyx+HFX8jghq+g1p7eubni4Wi7QflOcVwl630AbNVYG3xQq9VdnGk6HlYlG5hLmev5YmLWG/WOSCk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758048524;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=W1IJjyM9OVaQcEmkWiSOUFeaD6n08j4ucNHzBhm+qQk=;
	b=Q3fPokB2GbhR+Ki4vWnQlVuwEGsS8+e7CSRgdDHTTQcMVPQbytMgCS54D0cOWQVa
	mE8Tg7As2IUdbVHd29/Fag4+ZGZkxLRKF2+SK1uowiapF/WArH6my1D5CA4B8aAh1lf
	dbv7WVwbQDPHZZ5gwNQa3Vk96OSU5zEuKR0V3KzM=
Received: by mx.zohomail.com with SMTPS id 1758048522298948.311304452888;
	Tue, 16 Sep 2025 11:48:42 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id BACAC180733; Tue, 16 Sep 2025 20:48:13 +0200 (CEST)
Date: Tue, 16 Sep 2025 20:48:13 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Yan <andy.yan@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Vinod Koul <vkoul@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, 
	Stephen Boyd <swboyd@chromium.org>, Andre Draszik <andre.draszik@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	Elliot Berman <quic_eberman@quicinc.com>, Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v14 02/10] power: reset: reboot-mode: Add device tree
 node-based registration
Message-ID: <in6bqvemnscvuxbumpxogxiiav7odmsc3iazktifninh6iqen7@qwhrhdidcx7y>
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
 <20250815-arm-psci-system_reset2-vendor-reboots-v14-2-37d29f59ac9a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="czj77t3nras3pevm"
Content-Disposition: inline
In-Reply-To: <20250815-arm-psci-system_reset2-vendor-reboots-v14-2-37d29f59ac9a@oss.qualcomm.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/258.4.7
X-ZohoMailClient: External


--czj77t3nras3pevm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v14 02/10] power: reset: reboot-mode: Add device tree
 node-based registration
MIME-Version: 1.0

Hi,

On Fri, Aug 15, 2025 at 08:05:07PM +0530, Shivendra Pratap wrote:
> The reboot-mode driver does not have a strict requirement for
> device-based registration. It primarily uses the device's of_node
> to read mode-<cmd> properties and the device pointer for logging.
>=20
> Remove the dependency on struct device and introduce support for
> Device Tree (DT) node-based registration. This enables drivers
> that are not associated with a struct device to leverage the
> reboot-mode framework.
>=20
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---

Please use fwnode instead of device_node, so that the same thing
can be used with non DT setups, if that becomes necessary. Otherwise
LGTM.

Greetings,

-- Sebastian

>  drivers/power/reset/reboot-mode.c | 37 ++++++++++++++++++++++++++-------=
----
>  include/linux/reboot-mode.h       |  2 +-
>  2 files changed, 27 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/rebo=
ot-mode.c
> index 42bb99128ed3846d4bff62416dc31135ddeaeb90..9bb97bcd33cd3d58c75c791e9=
b568024e810e5b0 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -3,13 +3,17 @@
>   * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>   */
> =20
> +#define pr_fmt(fmt)	"reboot-mode: " fmt
> +
>  #include <linux/device.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/reboot.h>
>  #include <linux/reboot-mode.h>
> +#include <linux/slab.h>
> =20
>  #define PREFIX "mode-"
> =20
> @@ -75,17 +79,21 @@ static int reboot_mode_notify(struct notifier_block *=
this,
>  /**
>   * reboot_mode_register - register a reboot mode driver
>   * @reboot: reboot mode driver
> + * @np: Pointer to device tree node
>   *
>   * Returns: 0 on success or a negative error code on failure.
>   */
> -int reboot_mode_register(struct reboot_mode_driver *reboot)
> +int reboot_mode_register(struct reboot_mode_driver *reboot, struct devic=
e_node *np)
>  {
>  	struct mode_info *info;
> +	struct mode_info *next;
>  	struct property *prop;
> -	struct device_node *np =3D reboot->dev->of_node;
>  	size_t len =3D strlen(PREFIX);
>  	int ret;
> =20
> +	if (!np)
> +		return -EINVAL;
> +
>  	INIT_LIST_HEAD(&reboot->head);
>  	mutex_init(&reboot->rb_lock);
> =20
> @@ -94,28 +102,28 @@ int reboot_mode_register(struct reboot_mode_driver *=
reboot)
>  		if (strncmp(prop->name, PREFIX, len))
>  			continue;
> =20
> -		info =3D devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
> +		info =3D kzalloc(sizeof(*info), GFP_KERNEL);
>  		if (!info) {
>  			ret =3D -ENOMEM;
>  			goto error;
>  		}
> =20
>  		if (of_property_read_u32(np, prop->name, &info->magic)) {
> -			dev_err(reboot->dev, "reboot mode %s without magic number\n",
> -				info->mode);
> -			devm_kfree(reboot->dev, info);
> +			pr_err("reboot mode %s without magic number\n", info->mode);
> +			kfree(info);
>  			continue;
>  		}
> =20
>  		info->mode =3D kstrdup_const(prop->name + len, GFP_KERNEL);
>  		if (!info->mode) {
>  			ret =3D  -ENOMEM;
> +			kfree(info);
>  			goto error;
>  		} else if (info->mode[0] =3D=3D '\0') {
>  			kfree_const(info->mode);
> +			kfree(info);
>  			ret =3D -EINVAL;
> -			dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
> -				prop->name);
> +			pr_err("invalid mode name(%s): too short!\n", prop->name);
>  			goto error;
>  		}
> =20
> @@ -129,8 +137,11 @@ int reboot_mode_register(struct reboot_mode_driver *=
reboot)
>  	return 0;
> =20
>  error:
> -	list_for_each_entry(info, &reboot->head, list)
> +	list_for_each_entry_safe(info, next, &reboot->head, list) {
> +		list_del(&info->list);
>  		kfree_const(info->mode);
> +		kfree(info);
> +	}
> =20
>  	mutex_unlock(&reboot->rb_lock);
>  	return ret;
> @@ -144,12 +155,16 @@ EXPORT_SYMBOL_GPL(reboot_mode_register);
>  int reboot_mode_unregister(struct reboot_mode_driver *reboot)
>  {
>  	struct mode_info *info;
> +	struct mode_info *next;
> =20
>  	unregister_reboot_notifier(&reboot->reboot_notifier);
> =20
>  	mutex_lock(&reboot->rb_lock);
> -	list_for_each_entry(info, &reboot->head, list)
> +	list_for_each_entry_safe(info, next, &reboot->head, list) {
> +		list_del(&info->list);
>  		kfree_const(info->mode);
> +		kfree(info);
> +	}
>  	mutex_unlock(&reboot->rb_lock);
> =20
>  	return 0;
> @@ -178,7 +193,7 @@ int devm_reboot_mode_register(struct device *dev,
>  	if (!dr)
>  		return -ENOMEM;
> =20
> -	rc =3D reboot_mode_register(reboot);
> +	rc =3D reboot_mode_register(reboot, reboot->dev->of_node);
>  	if (rc) {
>  		devres_free(dr);
>  		return rc;
> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
> index b73f80708197677db8dc2e43affc519782b7146e..98f68f95c9e8460be23282c51=
ef7fcbed73887bd 100644
> --- a/include/linux/reboot-mode.h
> +++ b/include/linux/reboot-mode.h
> @@ -13,7 +13,7 @@ struct reboot_mode_driver {
>  	struct mutex rb_lock;
>  };
> =20
> -int reboot_mode_register(struct reboot_mode_driver *reboot);
> +int reboot_mode_register(struct reboot_mode_driver *reboot, struct devic=
e_node *np);
>  int reboot_mode_unregister(struct reboot_mode_driver *reboot);
>  int devm_reboot_mode_register(struct device *dev,
>  			      struct reboot_mode_driver *reboot);
>=20
> --=20
> 2.34.1
>=20

--czj77t3nras3pevm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjJsO0ACgkQ2O7X88g7
+ppfBQ/9HMIqbVJuvwZzQo3EipYpGXXdP/CdOeC6oZnYrfQm8LfZS8TcF83agJhf
CNUrAY2d3YH5Do+/xl+2KA2kgYHMgoDDX3f2/DWjpTadO5P7zW6vYcDNP0w0wR4S
IdHfOPa5Ov0ybtsepYCFX5QlMzevP1Izppg76+ERDoWPSUCT9IT449rM8J7aRScT
48JePKqtUCacNqV4zwEGcG7M2q8FVsv2xkpulVuF9XXicdSoQxvxeAMX+/E5HsWl
+2DAfSHs+gdGWrWacr9IYceQvCQUzb6nX69ax1Jqo0tGxY8CbO6dhQjw5OFpxnXt
RqB7W0yenJ9fNtDSWd7UEv1OtWUtN9MLb5ZDvMcjpCWWHIP8oqL7IIUaXVESEDxg
EhJ3/ekmVpdW2oIvOyDAsT294qBpiPsZngU2SweijEZrcYTpIrjqTM7eTzB6hQbL
K2A+VAq8+4T6UBM6Dq9DJddGtKWyG86e6aUPnnwB2pzqRH0D9kYMpv72AF+7Kcx1
HLmvKxQrF2wKvXINw8uSN1GokRWVZOeUt00dhiWjpXcXBd+xxf4vU5ZGeVZaLuBS
gvMF93kzoC9QTcpjw/Qa/12NY2xTD4U0oqWOklNhVjWB5vgAeEV+EylpTsb9tFXq
gD/QuzyhxxxjrG6t0jCLYsII8Jz+aibFgJK0RGzLK3ey9QzQ9Mc=
=5SRf
-----END PGP SIGNATURE-----

--czj77t3nras3pevm--

