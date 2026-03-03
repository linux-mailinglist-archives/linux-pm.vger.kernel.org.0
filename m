Return-Path: <linux-pm+bounces-43470-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICNLDTslpmlrLAAAu9opvQ
	(envelope-from <linux-pm+bounces-43470-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 01:03:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3BC1E6F3B
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 01:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26A1130832C5
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 00:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF5835BDC9;
	Tue,  3 Mar 2026 00:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="R7Sc3mME"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11267342C88;
	Tue,  3 Mar 2026 00:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496079; cv=pass; b=pSR00D76DxWZJS9Cj5TLafeoo4Zj+TFJvbYinLO4j33j8MMvY5NwMdbQDDlec73Hzt6675fRCHLyluf01K75Nn4PdkDvDGB1OcipzVfMkXosEqqEV6vmIr1iFjjRmLZGbgPFh/gNSr8FrdFn5lDi9NadmfmPd6YjdMfcuChI8TE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496079; c=relaxed/simple;
	bh=ioGr+nk8fi9NYjdV0OIUJe4BpGL8TdYgG41Pew4uTmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmZcdWbDONH5oqyT9/VyDO/KgdUUZLNNYjxd6XuQ9XpLBB+ngGzyUgiAACFejCOFVTg140CMW0tdmrdR5vXwRQ58V3eUODgcGEtnehUtfTNBpXlACL1pskbsfUk1ERm5SbTAYx2rC2Iks3sO9LfVfoNd9JMJXIk/4H6jZlcRA64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=R7Sc3mME; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1772496053; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SZAENPhpCVc5KCiFdrk/pr+sWKRZl+95DN9q+hnlsBwaN0wOumWDKLa1JIgwZXc5xf2tYoRVq43oILVW7srDICw46NvMpIxrxAfL4TTX5gJ4SdMzEe5A9/joogroTH1P19ViVfZML8HA7Kl473KqNjNuSusteT5Q6mx4dDHSjNk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772496053; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=l3PYFCVcWjGQaSSZj39sm1aZzw9LlSKfmhEhHtoI7MY=; 
	b=RGVfAtl7QXtEdlOV89ZYwG1zqyY/yt291EyWsC2qmDEauoE7Sk53CwHAv00TBGCIqYO4aiID27ew2SfkFYAtZ6WTrkLTRkh3JOLLA4R/jgM6abT6sh14HIPUG1oWoKPaC/OAZdZkZrwGEiI06L4kEuW7ZPtmeunL1x5M/LeYEiU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772496052;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=l3PYFCVcWjGQaSSZj39sm1aZzw9LlSKfmhEhHtoI7MY=;
	b=R7Sc3mME6oQ9arKfbh/G4lQNo6DTFlUSvKAaPdsCDMw1w97KKSxv7X9sIT/F1IL+
	MeO6JkQn9Wt1+pqAwJiRF0SQ/2UPHe+tZCxE8yI9LiEwXa2kWFGyPgeATdv0E5lOrjm
	pvw3kbKAUdiMUjOepHr06zsnwro3H/5AlEdzKoIM=
Received: by mx.zohomail.com with SMTPS id 1772496050787810.127324350416;
	Mon, 2 Mar 2026 16:00:50 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 062E9180D08; Tue, 03 Mar 2026 01:00:45 +0100 (CET)
Date: Tue, 3 Mar 2026 01:00:45 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Otto =?utf-8?Q?Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/6] power: reset: sc27xx: Add platform_device_id table
Message-ID: <aaYkhIGP2pexbxt7@venus>
References: <20260222-sc27xx-mfd-cells-v1-0-69526fe74c77@abscue.de>
 <20260222-sc27xx-mfd-cells-v1-5-69526fe74c77@abscue.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="adszrmxnyvdyek6f"
Content-Disposition: inline
In-Reply-To: <20260222-sc27xx-mfd-cells-v1-5-69526fe74c77@abscue.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.1.1.4.3/272.480.55
X-ZohoMailClient: External
X-Rspamd-Queue-Id: DA3BC1E6F3B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43470-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[bootlin.com,kernel.org,gmail.com,linux.alibaba.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[abscue.de:email,collabora.com:dkim,collabora.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


--adszrmxnyvdyek6f
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5/6] power: reset: sc27xx: Add platform_device_id table
MIME-Version: 1.0

Hi,

On Sun, Feb 22, 2026 at 02:16:49PM +0100, Otto Pfl=FCger wrote:
> Make the poweroff driver for SC27xx-series PMICs probe automatically.
> Since the device representing the poweroff functionality of the SC27xx
> PMIC is not supposed to have a dedicated device tree node without any
> corresponding DT resources [1], an of_device_id table cannot be used
> here. Instead, use a platform_device_id table to match the poweroff
> sub-device instantiated by the parent MFD driver.
>=20
> Signed-off-by: Otto Pfl=FCger <otto.pflueger@abscue.de>
>=20
> [1]: https://lore.kernel.org/all/20251002025344.GA2958334-robh@kernel.org/
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/reset/sc27xx-poweroff.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/power/reset/sc27xx-poweroff.c b/drivers/power/reset/=
sc27xx-poweroff.c
> index 393bd1c33b73..6376706bf561 100644
> --- a/drivers/power/reset/sc27xx-poweroff.c
> +++ b/drivers/power/reset/sc27xx-poweroff.c
> @@ -6,6 +6,7 @@
> =20
>  #include <linux/cpu.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
> @@ -70,11 +71,18 @@ static int sc27xx_poweroff_probe(struct platform_devi=
ce *pdev)
>  	return 0;
>  }
> =20
> +static const struct platform_device_id sc27xx_poweroff_id_table[] =3D {
> +	{ "sc2731-poweroff" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, sc27xx_poweroff_id_table);
> +
>  static struct platform_driver sc27xx_poweroff_driver =3D {
>  	.probe =3D sc27xx_poweroff_probe,
>  	.driver =3D {
>  		.name =3D "sc27xx-poweroff",
>  	},
> +	.id_table =3D sc27xx_poweroff_id_table,
>  };
>  module_platform_driver(sc27xx_poweroff_driver);
> =20
>=20
> --=20
> 2.51.0
>=20
>=20

--adszrmxnyvdyek6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmmmJKkACgkQ2O7X88g7
+pqKDA/5AV136yvRe7RqNNIT156QrAc+9gAeOqzQ6oPlahmYFlPYeIeqFAdyRbFP
CUks1Q7xZp4kcIlL9Qi0tdHM/em2QpHpx2Grh4nk3ZCv6oSp+ENj8xblRua85aPJ
DQAM/xfskwuVATHFfRc6Aus6wSJpbmlXwGelvP2/Sxiq9FSmmn4CSPP7b8Lw41iA
/tp6p3UuXPY8B8PkLApLBwECZ757Y/DZPTbfHkdUunt25qHvr5gOM0cUJ42kadVG
WbmXtd4GRzkdT+IOgYhbWKhbbtjLIFkE1F3OLuJF/JfnpHs9WLuvgdnfyTy2kEc1
D/ogyBvec9PqAFHpgymYgTRVcLHw3Lp7Yfane9f6PtTjsn5/A5vZmr8vi9xG2RuS
UMThn+0OKwURaABK90z6udRR66+EDT3TClJLyK8P7tqmFNJ7YGtAa6K5r/VQikJi
qzdHpJLRR2h0OVHJN/zyfitZHiJrE7EPwGd6p4w7EfuuG9emNRSDXZetZX+45dLA
f/scfcVGxOB3KYpoB6r2rrF9yCQBJV/M9G3tgShq65WLLIfedUaM2NbcOEk7KYrn
Dkb8c64EzMPOA/i4TWeZKpw2xpr6DSLl4VEC+1BApiux86+rsfw21bjASWq/2gX/
KgibKzWdkv0HXK7/QU5g7gNPPnRNZPA3PhPEQE6PAr9TGtHSJNY=
=U7O7
-----END PGP SIGNATURE-----

--adszrmxnyvdyek6f--

