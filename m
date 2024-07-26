Return-Path: <linux-pm+bounces-11461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF6593DA17
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 23:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CAE71F245B8
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 21:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58ED1465BC;
	Fri, 26 Jul 2024 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MUSv0zhT"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C88E381DF;
	Fri, 26 Jul 2024 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722027986; cv=none; b=Oh4bmrsaLKSsijFcfhHK4mzzXCN2n3pinWHCPV29W4cHmOjofGJ6f52JN2BboFMrpG/jxbJNHwZp5DqlXOUGPqkABentJw4en7SUGeuxi7DOdYIrGRhgtWm5RoTxpCtbXg+3OD8tj8gqMRQTnyXFaqygkfTmi5OSP443/E4KhRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722027986; c=relaxed/simple;
	bh=dRXQdOX5p0F/7LyukkLtrmbXNq2DLYargesfwnVLE6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8wOrZ0X81xJvmCsa0qFEC3Y9t1hriWZV2xAfuHLxPdiUIfbIXOHYaYN05urCTo+K9RDSpU75vAhSENCigIEI7TPLWQ+yARHvBmqTVIv8YecANk2W/O58twSCx1avjRa9ybF/1OxNJW3yKcrKTsEiHahQrIl5C9zLnr0NFRzjJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MUSv0zhT; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722027982;
	bh=dRXQdOX5p0F/7LyukkLtrmbXNq2DLYargesfwnVLE6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MUSv0zhTBz9N/Cf7w48J7P+PIA/svEeJGEw+j3TPSe0yEt1WUbTJ5HV3wDBiw7g6u
	 u3BdjKr4LVMNFO5Raedkkt8eQMVHDrSxJirfUgbJ4muw4JwhPWhPNRl6g/LXtCKVou
	 JZSfBi8ATqXp9fm4A2PoxWz5s9p1T2fWyjOk5Es7i3D37qEg68zS9fTbVKM3/0oVuM
	 gaYOrKYN6YCoXw/4f+Sm9kNgszA9E72FmQ5PRALSWPWGHwGYTnm70N5wCG12bsG1MW
	 YSH0WW4Z9DlUkU+VRP3lJ+f0NQadPjqqU4SUxqR4xxR4fevPMad55knnMaDgVqdxWm
	 +IIcICV/mEbHg==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 510873781185;
	Fri, 26 Jul 2024 21:06:22 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id BB20E106097F; Fri, 26 Jul 2024 23:06:21 +0200 (CEST)
Date: Fri, 26 Jul 2024 23:06:21 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, jagan@edgeble.ai, andyshrk@163.com, jonas@kwiboo.se, 
	t.schramm@manjaro.org, heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 2/5] power: supply: cw2015: Add support for dual-cell
 configurations
Message-ID: <eimocj6mlvo6u4x54heywblwrfnftxelzpvfcogpjp7vjmunor@5eqlqsszk6ni>
References: <20240726194948.109326-1-macroalpha82@gmail.com>
 <20240726194948.109326-3-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="as2mi4krtxmu7mhn"
Content-Disposition: inline
In-Reply-To: <20240726194948.109326-3-macroalpha82@gmail.com>


--as2mi4krtxmu7mhn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 26, 2024 at 02:49:45PM GMT, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> The Cellwise cw2015 datasheet reports that it can handle two cells
> in a series configuration. Allow a device tree parameter to note
> this condition so that the driver reports the correct voltage values
> to userspace.

I found this:

http://www.cellwise-semi.com/Public/assests/menu/20230302/6400076806706.pdf

Which says:

  CW2015 can be used in 2 or more batteries connected in series, or
  several cells connected in parallel.

So dual-cell seems like a bad property name. Instead the number of
serial cells should be provided. This property is then not really
specific to the Cellwise fuel gauge and instead a property of the
battery pack (i.e. simple-battery.yaml).

> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  drivers/power/supply/cw2015_battery.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply=
/cw2015_battery.c
> index f63c3c410451..b23a6d4fa4fa 100644
> --- a/drivers/power/supply/cw2015_battery.c
> +++ b/drivers/power/supply/cw2015_battery.c
> @@ -77,6 +77,8 @@ struct cw_battery {
>  	u32 poll_interval_ms;
>  	u8 alert_level;
> =20
> +	bool dual_cell;
> +
>  	unsigned int read_errors;
>  	unsigned int charge_stuck_cnt;
>  };
> @@ -325,6 +327,9 @@ static int cw_get_voltage(struct cw_battery *cw_bat)
>  	 */
>  	voltage_mv =3D avg * 312 / 1024;
> =20
> +	if (cw_bat->dual_cell)
> +		voltage_mv *=3D 2;

Unfortunately there are no details in the document, but this looks
very fishy. Does it only measure the first cell and hope that the
other cells have the same voltage?

This (unmerged) series also applies to your problem to some degree:

https://lore.kernel.org/all/20240416121818.543896-3-mike.looijmans@topic.nl/

-- Sebastian

>  	dev_dbg(cw_bat->dev, "Read voltage: %d mV, raw=3D0x%04x\n",
>  		voltage_mv, reg_val);
>  	return voltage_mv;
> @@ -587,6 +592,8 @@ static int cw2015_parse_properties(struct cw_battery =
*cw_bat)
>  			return ret;
>  	}
> =20
> +	cw_bat->dual_cell =3D device_property_read_bool(dev, "cellwise,dual-cel=
l");
> +
>  	ret =3D device_property_read_u32(dev, "cellwise,monitor-interval-ms",
>  				       &cw_bat->poll_interval_ms);
>  	if (ret) {
> --=20
> 2.34.1
>=20
>=20

--as2mi4krtxmu7mhn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmakD8MACgkQ2O7X88g7
+poMWg//VA9EuwQknC63eScPILOGznNuQY6GAyQxZ8ji3kha7/gD9JUtBrxFSct3
p7BGtG1wqVA2EDnLYFilHuG5uG1SPDjYFsd/qK8BzOL1fU+0b8tBd75LqlbrIZWS
9DwzKRDrWaYQGuwZAgNfIe77MYIF6h5uu1+/ifcA3//mJHaGK7muDPvfNkdwrKgt
odB7BcQEAJkVgq7ABwbIobHrb8srzJLRGF5V2E9eVzyilfjb853uCupBp7AG02ru
4bulkBo2caJq7nXNcMKXSWmyPy4BxtXvvzGaANy+f5NP4jy03Z4sxb0fcE0aX8cc
rhmAcbZLOZ4oBXMTQWSK/1DxSIOr3eAypOSMGYWR7KBN/unibriZesp4xheeI8kn
S9sSErh1+927eONcHUW3j6fWZyKr6FCjxNQwQdk7nMQjPfWgE3bBOoI4WRbwTfND
nkvsfl1oyqAxumc97hibU+vPECl94PBfLYOQM5DOi3pDgJqes3tXIwOaQ/2LCZVv
9sKUGwxp+EzOMNsK89AeDIFrosllc3LlxG65NgXI//+t0ETqD0oU+TFYekW7FT3q
+1qSvo4TerJjb2K/4igW4ZoscX/XHGXySOBFwAdts25vBNFLpIA9QFVbZ8Z0YxTS
vdwlQ5D+nP+KN2V8rAw1lEHnVkLutJkEa4UpjfUZfh+PXNrKaVo=
=mSc7
-----END PGP SIGNATURE-----

--as2mi4krtxmu7mhn--

