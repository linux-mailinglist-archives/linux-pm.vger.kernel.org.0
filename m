Return-Path: <linux-pm+bounces-18005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0479D7703
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 18:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C36163657
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 17:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F0912B17C;
	Sun, 24 Nov 2024 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="mlAz0F1v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38117DA9E;
	Sun, 24 Nov 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732471064; cv=none; b=nInOQ9A4MAtNLqcemAc3mGwq0bjJTW0XdI3w0TzrFhOHhAe8RRrF3khzecGQ/07FJrrfv1apwuxguxwnI5sxl4DLQ9PJUlKhcTWI/UhU4b7fyuOuT9TEzNdQSJOmMU5Dv2yLsM9rCuPkwJWxC5DaDf57vsMRryGBFDhz7swRlpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732471064; c=relaxed/simple;
	bh=ZpISjjgwExIV5cqhn+eem0OOga4dcYmaliq+sNjEw0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqm6F0BxR1OjcKI4KxbHtJgoi5Ffz3A4RZHLCX2xA+lmHpqedvOnd5IpfudUpREdVwUrwC1oxb5VbDmyaE6d1fvRBv/FC8RBEj06zpzOux/HWnMumL9e5CrU8qa7zj8SoN4zpWer31BN/b6rOZ1L+fH9c4xtcR/03//xUgDyH5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=mlAz0F1v; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732471050; x=1733075850; i=w_armin@gmx.de;
	bh=K3LLtP1fdMqIitncjLdJbRNDlNwTXuUkd+Pjki0vJhc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mlAz0F1vGdDLLW5pxCpmEe6POqlSAAlaODyODm9stVbDH9ywmEmtA7YE0QhQBvP8
	 q+Cz5Qjts04jB5dWylSAYPM+rmJ56+6TWVi7BZq+UAKL+oNYgT0du1fsXb5/oCbon
	 w0RPPapidY4Cz6Hi7wvQ07/JCe0pBzC+H3nyoXpSuII/pwvU2F3NRDptzZ33GD60d
	 d8+ScBAVFoH8rbXiuO9CRn63fdisce34zBuDWulLXDcaQ0j+cEUSubeFg2jyaE9Zv
	 b1sP8GZnsTFjDeqq4hMx5qeX1HVb359oJvwY0FfuCQi+u2fkgozIvFsvQ7o4xu74G
	 p7SLMYXSghA0fQa20Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wGi-1tIZBF2sDU-009s6W; Sun, 24
 Nov 2024 18:57:29 +0100
Message-ID: <84a5b7f9-9d09-4672-9447-02de05e68f88@gmx.de>
Date: Sun, 24 Nov 2024 18:57:23 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] power: supply: sysfs: prepare for power supply
 extensions
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net>
 <20241111-power-supply-extensions-v4-5-7240144daa8e@weissschuh.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241111-power-supply-extensions-v4-5-7240144daa8e@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1baVtag+WVlTsbmdzX19eeP+QO9RFPn6Hu/5T+2G8wKoiISbv1U
 tiNFMdaU7Y9kNLGpmECg8TndqanLzmdSJsbGpnwHsyiVhSyvbA3f0dv6MZ00HHu1yPVS5By
 BNNYheLrgOJYJsKAmFjKpyEyaFmk3hdwOSb3JngHhuJk3++tSq0sK/TxjX4ZzENQXGvq7sg
 so9FavI5vxcTMNa5kce8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PFQH2kycRVw=;11KY+OPskdC379FCx0T+pVtd4KW
 b06yNL7+/oFQONIQKs3Lgh0+2DuXzZN9pvvxpoSVpWsj4WfVP7b7a7pEqGwjb47TLG5+62K4X
 BklvGqv7cs2PuqKjib7qyjJe/CHhVBnDTLNzjXgKn6l+fjaUJyKKMoGyNhCtCpPWWD7NhyJdg
 yCGHkcsFsexV5qe8oSsbsxEUqFLI4F7gZSWm762HXjTY+gC4IAfJqZgu8JaBEbrI/SFNsku3z
 bpfj73QDXfmLXwluy3V3+360xUhtysB3J/a0bl2C40j4ruaudAo3qp0UkMT/4TGtbUG/TIXnp
 vRGbFAExzW0h2z8xXfRvBs7NWuXSJKtcUeZGdS+ZXTKlemPrCuLsz6z8DmxVSVT5qRos0fRTB
 wHg8ZSu391mXqYx59odJiP2qiwpJ1x7d7gexcekwm/gAkXHx+row7I0/WQaGxALG6Wm5b7R/m
 MjvesLnQWqm2lfM3xgBUwQH17ZYlEHV+zDiwv8EJRL7FWqlgcZpHn4jJCQS54WMaq/gqMSNj2
 EvvWicgoiy+t4BQzC+b9RdNtTgDn8veteUNgRXtcTisTqRgmb+RvNi24P6ljnX5241nlYBZ4X
 1r3GZ0Abkio6bn0SfY55KwlWTd/O3sV9UMjb6sa3Py1pi4tvmxNKGJ4WlWpYvB8tLMw7c42H9
 FKfyPqhObypB3K60E45nKBJZ1LWpGPPThTYGrgFP9T8ZN3CEUoHqVVj5yMOUeG1GvRshVegaq
 PVRvtPRjut78DB+xJulVqGBM5mZvfU0jgUyGtNQmYGudHsljPeNyNmJVxYCsxjggJBzIhhj9N
 yTHv8pie3M6WJC+zyCmkJ2sOGUH/takRsDbkmUHMtdQnpjwBQ1Tyij9FKLJX4jkwT04D1bwFy
 NBXN8VZgIvRGKPpKzTcVNRav4aUJe45WPOcvzAlvjcvQaAdXx9N41J9ZR

Am 11.11.24 um 22:40 schrieb Thomas Wei=C3=9Fschuh:

> The upcoming extension API will add properties which are not part of the
> the power_supply_desc.
> Use power_supply_has_property() so the properties from extensions are
> also checked.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/power/supply/power_supply_sysfs.c | 17 ++++-------------
>   1 file changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/s=
upply/power_supply_sysfs.c
> index a7351b9c8fe34a464a4e69b1a1a4a4179c1a4b4f..bfe48fe01a8d03828c2e539e=
1e6e5e9fc5c60167 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -378,7 +378,6 @@ static umode_t power_supply_attr_is_visible(struct k=
object *kobj,
>   	struct device *dev =3D kobj_to_dev(kobj);
>   	struct power_supply *psy =3D dev_get_drvdata(dev);
>   	umode_t mode =3D S_IRUSR | S_IRGRP | S_IROTH;
> -	int i;
>
>   	if (!power_supply_attrs[attrno].prop_name)
>   		return 0;
> @@ -386,19 +385,11 @@ static umode_t power_supply_attr_is_visible(struct=
 kobject *kobj,
>   	if (attrno =3D=3D POWER_SUPPLY_PROP_TYPE)
>   		return mode;
>
> -	for (i =3D 0; i < psy->desc->num_properties; i++) {
> -		int property =3D psy->desc->properties[i];
> -
> -		if (property =3D=3D attrno) {
> -			if (power_supply_property_is_writeable(psy, property) > 0)
> -				mode |=3D S_IWUSR;
> -
> -			return mode;
> -		}
> -	}
> -
> -	if (power_supply_battery_info_has_prop(psy->battery_info, attrno))
> +	if (power_supply_has_property(psy, attrno)) {
> +		if (power_supply_property_is_writeable(psy, attrno) > 0)

What happens with properties supplied via battery_info? Are drivers expect=
ing the power supply core
to call property_is_writable() for those too?

Thanks,
Armin Wolf

> +			mode |=3D S_IWUSR;
>   		return mode;
> +	}
>
>   	return 0;
>   }
>

