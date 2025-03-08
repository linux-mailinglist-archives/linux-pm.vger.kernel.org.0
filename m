Return-Path: <linux-pm+bounces-23675-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86201A57BFC
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 17:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81E31890B39
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 16:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A591E833B;
	Sat,  8 Mar 2025 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="B9RMkmJ7"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA551E51EF;
	Sat,  8 Mar 2025 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741451682; cv=pass; b=dqfD+GBFDYlMXqqFAxzVxU0G4R4jxlBFoBtHdfMYEV0lCaqyaw19HiXrhE+gKljWmjtGZ5/CSxwpuZV7BU6YamMlgTHVtLJPa6BrMDWnyGDRResSee/65VrKZT7yfQFCDCX+hyVOQNwRDMyjOK6NHABBAxprW7hKjtCUSHB0304=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741451682; c=relaxed/simple;
	bh=QZ40omMnQEjE+JXg1B5+8JRvEySfzqrCI4ckFb6QspY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pl0s1vlbDVpvVCCKty/4VFYzK1ZNbqavQwdrprFvlfPjEJyRWXlA0259tbTBEhUem+yQqmgAcVlyzCyNb7miCXMcAki/ruUSz+7Fqf0O7m0GaWrvYF6kgatSjRRDXd6+yNwia6DGMuY8mpdNMXBrEdDzdKgHyFN3N4BidNRjiqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=B9RMkmJ7; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741451594; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Rfzi5+rYi4NcDFW05tntKY/htN29k8Hhwkq5yCyzXl5hrOKBCg/XgsDmSpyKfu9Srq+wo+bN0gjoitXTlY5IOYD08zUlFQhYwxR1j4a5L7rZ+8JU49AlzN+gQJc0MK4yQ1SQ4v2YHQ/Pbgy7+or9dgapw+FAiX5va2oPRScNUIc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741451594; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OW81xSgzV1fBuGgf9rWiWPp51pHmz1hWzao7UrnpPhs=; 
	b=VgTA9ihYfrb9bvBLqmCiAnN9wd5/JXrmK6SetNF2/xpaHSLJXYzuOkTE6STMRg5LifowrmaaI09sESC2ZjRRPNXM68L5qd2NfTAjColl8Rdvy1Yjvez22TxZvOYYdcpdXeEBUxbX7yuk5BYHsywAUVXgfB/eZr1Ff9/K6Q382hY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741451594;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=OW81xSgzV1fBuGgf9rWiWPp51pHmz1hWzao7UrnpPhs=;
	b=B9RMkmJ7l1WoU4e9j6CQ7iW3B3AULNdi/tMLiEVgcLTsMTPWWOREUmD+v3VNOxyH
	bJyKm7tHAg1wOCSmPwia7ldtb9qZGlk3z42c/Lv8it2o7HxMoYAdcJgN2Sj2AeRKkaM
	hLh5PKuKKVS3NSXFsBqmaj99zN5d9AGUeZs9cyJ4=
Received: by mx.zohomail.com with SMTPS id 174145159345355.16251987069427;
	Sat, 8 Mar 2025 08:33:13 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id DA823180B9B; Sat, 08 Mar 2025 17:33:05 +0100 (CET)
Date: Sat, 8 Mar 2025 17:33:05 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Chen-Yu Tsai <wens@csie.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Paul Cercueil <paul@crapouillou.net>, 
	Samuel Holland <samuel@sholland.org>, David Lechner <david@lechnology.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Konrad Dybcio <konradybcio@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/7] usb: common: usb-conn-gpio: switch psy_cfg from
 of_node to fwnode
Message-ID: <eqfqv2tkfretqzvt74o5dvj5yixkfc3h3my4bhskvhtsrbmtwp@poryvs4oipnp>
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
 <20250225-psy-core-convert-to-fwnode-v1-3-d5e4369936bb@collabora.com>
 <2025022542-recital-ebony-d9b5@gregkh>
 <lhtljyn52wkhotaf2cn6fcj2vqx3dzipv2663kzwtw2tjjlxye@5l3xytkyvocy>
 <2025030845-pectin-facility-a474@gregkh>
 <0401fdf9-7665-40d6-9ec7-7222b2eda866@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r2mmt44pwozkdwuy"
Content-Disposition: inline
In-Reply-To: <0401fdf9-7665-40d6-9ec7-7222b2eda866@oss.qualcomm.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/241.192.19
X-ZohoMailClient: External


--r2mmt44pwozkdwuy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/7] usb: common: usb-conn-gpio: switch psy_cfg from
 of_node to fwnode
MIME-Version: 1.0

Hi,

On Sat, Mar 08, 2025 at 10:34:45AM +0100, Konrad Dybcio wrote:
> On 8.03.2025 6:57 AM, Greg Kroah-Hartman wrote:
> > On Sat, Mar 08, 2025 at 02:10:29AM +0100, Sebastian Reichel wrote:
> >> On Tue, Feb 25, 2025 at 04:32:50AM +0100, Greg Kroah-Hartman wrote:
> >>> On Tue, Feb 25, 2025 at 12:21:36AM +0100, Sebastian Reichel wrote:
> >>>> In order to remove .of_node from the power_supply_config struct,
> >>>> use .fwnode instead.
> >>>>
> >>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> >>>> ---
> >>>>  drivers/usb/common/usb-conn-gpio.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common=
/usb-conn-gpio.c
> >>>> index aa710b50791b0282be0a6a26cffdd981b794acaa..1e36be2a28fd5ca5e149=
5b7923e4d3e25d7cedef 100644
> >>>> --- a/drivers/usb/common/usb-conn-gpio.c
> >>>> +++ b/drivers/usb/common/usb-conn-gpio.c
> >>>> @@ -158,7 +158,7 @@ static int usb_conn_psy_register(struct usb_conn=
_info *info)
> >>>>  	struct device *dev =3D info->dev;
> >>>>  	struct power_supply_desc *desc =3D &info->desc;
> >>>>  	struct power_supply_config cfg =3D {
> >>>> -		.of_node =3D dev->of_node,
> >>>> +		.fwnode =3D dev_fwnode(dev),
> >>>>  	};
> >>>> =20
> >>>>  	desc->name =3D "usb-charger";
> >>>>
> >>>> --=20
> >>>> 2.47.2
> >>>
> >>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>
> >> Please just merge this patch through the USB tree.
> >>
> >> There are no dependencies and I will send a new version for the
> >> later patches, but they won't make it to 6.15 as I want enough
> >> time in linux-next for them. This patch is rather simple and
> >> getting it merged now means we avoid immutable branches or
> >> merging through the wrong tree in the 6.16 cycle.
> >=20
> > Attempting to merge a single patch out of a series is hard with our
> > current tools, you know that.

Sorry, I did not know your tooling has issues with that. AFAIK most
maintainers are using b4 nowadays, which makes it really easy. Might
be I am biased because I mostly work on ARM stuff where series often
have patches for the driver and the device tree and thus merging
partial patch series is basically the norm.

> > Please resend just the single patch if you want that applied.
>=20
> b4 shazam <msgid> -P 3
>=20
> to apply the third patch (such as this one) in a thread
> unless you use some other set of tools..

Exactly.

But I can send this patch separately of course.

Greetings,

-- Sebastian

--r2mmt44pwozkdwuy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfMcTYACgkQ2O7X88g7
+prJhg/+P1CLDpcgJzoT2YDB0oM6oosAappPICXcYCwnk+WuTqXqqoOLm99fCqOe
gmMU3O21cf81ZGOgxQShW468/2rqdEuv3rr8LXuHJeNgROu2XpI2abuus1Gijwep
1B/xU3aG0IbYKTXnnLrf3h8KEykCdXhxqh+34dYfsOTHFAKcKKDc6yVXcVeEmX9b
jq1iZ8qyP1+UX6ISMDpQ/2dqoZYoJtG5JEt4iGOqqcS6gNEjVJ4rrY/Qy2lOaj1Q
ncj9WP7C/Vd/DC0rRD08Fo8UCi5AOJb8zr7mKo6A+1zsf9pIb4eoEp6+JCa0YeOd
gAhGkx3DAQTxAPoNlpv8NmhyaNM7e0QgOf15BfkMEkAuSbhaqte+0PDKWeLIOU8x
76uvrykbBefBKgmxzzMnMK4IGIJwMRGSD1Zd1J6b7bwKEFq4SewPQUqR00f7OUmF
PPVpxhHy+i8nLKJUgYqGDvdBv7fTM4y0daQM5xdjOtkYosB5ACjAApdGnx+e1uT2
bhelcjLlwl2x5MHsGbLUZaxka/UB8n+BE3FUVE4BlArGpecUgbkcYkiOuKh9lC0a
BFRZxB99mGLvNwEO+qRie8IA4JUfyzXne9OradEp1LZdufuOuNT3NXYgoeJbiWfm
Dpnmw2XruBy5CMn7Nl1ke/ESwvBOWoJ7FUme591xZ6w7LvBXmd0=
=LBxd
-----END PGP SIGNATURE-----

--r2mmt44pwozkdwuy--

