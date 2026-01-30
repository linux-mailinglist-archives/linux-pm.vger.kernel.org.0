Return-Path: <linux-pm+bounces-41801-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNnXGHMgfWmkQQIAu9opvQ
	(envelope-from <linux-pm+bounces-41801-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 22:19:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF41BEC65
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 22:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96EF63005AA7
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 21:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E3C344D81;
	Fri, 30 Jan 2026 21:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="h1jpLJOc"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B54831197B;
	Fri, 30 Jan 2026 21:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769807982; cv=pass; b=trxr6tLQ50hSGzf0RbXmnBkQs3sqGZDhRWQ/vkM6eLC09wnxAnu/HmHMoDIomiDMnMPcjFzdX+ctGDfxv+85AS+N3u6RtDa7H649Qf86PuSifmB4fLc6q046pb5B8qDEmC+Gq+0zqh10jCCMB/dXWgk0EYj7hHZvoeR10d3ItrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769807982; c=relaxed/simple;
	bh=Gsl4VS0fN+FlmWAIyHKY4JEalZsSdsJVSccP7i2dpKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOEzLzFQdGowAjNCsVVEZD5Rt1+Dq9FtZPXDCaLPSs1o1C8jwrv0LQmspfme7qt5AXBuFf93GYd8dIinUeUcvzQabsdf8goobhZOsbmyh4o2mUT0PQXU5EJmZQtx9RjzBUTFjXn4LxjmdB80iuWFmSo3m2fJehNdfxNdHMuCPZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=h1jpLJOc; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1769807968; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RjDbDBoQoxBZhqwqnewjnYBUMQoFm3R+3RqJTv1nf03N6mVdkpoVC5bQsO9nZT9J1645BMqtrn8R6UDymdP4ngNo5NJDCanDJnBs01WZE8OTJ5o7UUWVFlvWNFlLopt/1xyWaCgYSXWdPsOstM3eyc/2yT7bW6vlIuruoyvXW2s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769807968; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=diijtnHg8t4ZAaEt36v7Cv+XgapUuCn8b1za2jKSKBU=; 
	b=OPnS+rPStdRi/cE5Hmr+IV8eu0U6OdpQyBkwNWJhhBfcmDnNZ3XN9+18THnB4yHs10eoFn/4g+cmeUsm0YLMghXn9v1hOGQxT89BlZrInsysBcJFVXZrQvYW0ECnpeRH7xE1FmffGGzq35JfejPJxuAPbTU1UOr5HtcZ/L8lhqc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769807968;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=diijtnHg8t4ZAaEt36v7Cv+XgapUuCn8b1za2jKSKBU=;
	b=h1jpLJOcLklAfNVS8CToiKYOw1WvGDIcCPzklGoZkRSih+w0Ky1Y20DhJGfxtA12
	xCrskLzs7OBNANBkJfZpOJAzVeRW+OvjDWhFpfAOuU11RGwlGU0ztbTSM1zhU1NJ3VO
	QFO03dSTZuF6XxxbnTS360XfZit4FJBmw2etEzmE=
Received: by mx.zohomail.com with SMTPS id 1769807966815477.73938929265046;
	Fri, 30 Jan 2026 13:19:26 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id EA1DB18050E; Fri, 30 Jan 2026 22:19:19 +0100 (CET)
Date: Fri, 30 Jan 2026 22:19:19 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH 1/2] power: supply: sbs-battery: Reject all-zero readings
 as battery absent
Message-ID: <aX0dmorBDaipndP7@venus>
References: <20251231093152.2817579-1-Qing-wu.Li@leica-geosystems.com.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hlknkmszrkxw3dpe"
Content-Disposition: inline
In-Reply-To: <20251231093152.2817579-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.1.1.4.3/269.789.21
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41801-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-pm@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,leica-geosystems.com.cn:email]
X-Rspamd-Queue-Id: EBF41BEC65
X-Rspamd-Action: no action


--hlknkmszrkxw3dpe
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] power: supply: sbs-battery: Reject all-zero readings
 as battery absent
MIME-Version: 1.0

Hi,

On Wed, Dec 31, 2025 at 09:31:51AM +0000, LI Qingwu wrote:
> The driver reports battery present when status register read succeeds,
> without checking the actual register values. Some systems return all
> zeros when no battery is connected, causing false presence detection.
>=20
> Add validation: when status reads zero, cross-check voltage and capacity.
> Report battery absent only if all three registers return zero.
>=20
> Tested on i.MX 8M Plus platform with SBS-compliant battery.
>=20
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---

Can you provide some more details about the platform / SBS compliant
battery?

The SBS battery chip is supposed to be part of the battery [*], so
by removing the battery you are removing the I2C device. Accessing a
non-existing device surely should not give you 0, but an error. That
suggests either your hardware design is broken and you disconnect
the battery cells from the IC or your I2C/SMbus driver is buggy and
should be fixed.

[*] This is the whole point of calling it a 'smart battery'. The
    battery cells and the chip are supposed to be one unit. This
    allows the chip to use a coloumb counter to measure energy
    stored/taken out of the battery and learn how the battery
    behaves.

Greetings,

-- Sebastian

>  drivers/power/supply/sbs-battery.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index 943c82ee978f..0b9ecfc1f3f7 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -594,9 +594,19 @@ static int sbs_get_battery_presence_and_health(
>  		return ret;
>  	}
> =20
> -	if (psp =3D=3D POWER_SUPPLY_PROP_PRESENT)
> +	if (psp =3D=3D POWER_SUPPLY_PROP_PRESENT) {
>  		val->intval =3D 1; /* battery present */
> -	else { /* POWER_SUPPLY_PROP_HEALTH */
> +		if (ret =3D=3D 0) {
> +			int voltage, capacity;
> +
> +			voltage =3D sbs_read_word_data(
> +				client, sbs_data[REG_VOLTAGE].addr);
> +			capacity =3D sbs_read_word_data(
> +				client, sbs_data[REG_CAPACITY].addr);
> +			if (voltage =3D=3D 0 && capacity =3D=3D 0)
> +				val->intval =3D 0;
> +		}
> +	} else { /* POWER_SUPPLY_PROP_HEALTH */
>  		if (sbs_bat_needs_calibration(client)) {
>  			val->intval =3D POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED;
>  		} else {
> --=20
> 2.43.0
>=20

--hlknkmszrkxw3dpe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAml9IFQACgkQ2O7X88g7
+ppxyBAAgs9cAUGAkfGrthk37Cdwc58V2DvggeTWEtX+Pp7JlYC+IUDN+5nzi96x
eTg2HWiE/ajPiTfrPrIpwIavZoUO669QsQb7SraQhjlPniVh+xxK8frArdptqWXo
Xw4i7IIZbrIZMRdD7gj3MrtFxzrCzLY2AezQcbM7mDXQbLUgEQSmFuTuyKecPLpW
KtSSfkUN/we6HFJMxFJfwc36QqkgfMRdvdF4WKEamvg1cdmkrZkpVtg8u7Vvyws3
U+4Ota6ciB+vK0ntsImCPH6HsUPh4ZW+eu3qTLcMo3fEvlV1CfTbQheWxNALxzOg
lL8m4Z8l5WvpdkzXjNdHDNZRJroEZ/WCMpe5BEAEZgwzWoO+bYFAXVRpIwRjY6jv
zMyGi33WygKKdIF/hWeg2vmTlCnU3priGbbpWin68lUeV16aWl802kb/5MpMFYFt
wKQhJW/D3vV5Ggsdl+GHLZaQ+FMtITeLSQ5wp4ApiE4myaAeHQitU5/3gJy2pBvF
tSLNQFnqcCfo9uYzC3kNJzVodCM9P65I28AShMKgQ2f/Lx5YSyi7kAuKK7mISjcO
iUkADfKBrBglE+XQDzWKJ8wvrqr3j9pmGTvnMd1awHTrPLUvHYgMPUQ3so7g02PP
yHyOa80QnpwoYnyXAz4L+WRkgwdwtRt9rWuMGm/PGkFPkGtLYYQ=
=qx1L
-----END PGP SIGNATURE-----

--hlknkmszrkxw3dpe--

