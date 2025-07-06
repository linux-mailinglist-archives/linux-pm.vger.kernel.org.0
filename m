Return-Path: <linux-pm+bounces-30228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8FCAFA856
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 01:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B74BC7A2811
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 23:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEDA1F4717;
	Sun,  6 Jul 2025 23:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="HIT91SYD"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C4D1E86E;
	Sun,  6 Jul 2025 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751843665; cv=pass; b=TbKeeMv+xwM32cePwgR+Rj0yX4VWUoi2kkOJxc+yeD61OwR1BpuiUIzVsmbuCK9sbSO4oSX0qe2j0b2PJQB0Ht4d9QNPkNskgSO13GEN2aiFkx3ubNQU+ZWzWKsP/tPmRfFcMvblBnMWkvMEGpw1DQdWTMi3TI36GwVQ/yoZGDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751843665; c=relaxed/simple;
	bh=b1oTof9XHsD6TWvzUALGVJhu6zyuarKFaH9BBs5xfQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSEFC8HPoVOW4gFJ/KhD5vNeDvBeDwdyT6dxRrM/rG5cqmFSWM+XvkeVc0Suq6NumDwBd9k78yxbZr83VHvqqDXNwS3PTvs56bmqgjU51JUlEJeMxPvUOfIS0yNbmUnFEqsHboGp8h8lGbX3rnuVwmy/LKbcUQLV7yVz0kXZbk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=HIT91SYD; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751843656; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UwWhPUPVN4uPSTRFlR5Rkj6uzrlQnZYuSUF4EcNJrRdH3hUa796BV/Y0+++UTS3tKg2yNSXpzpHtBFhxX3sBOuQDYyK3ALmZ0QlaDK9ogFec3qculnftkeJmJ2Bqj+D0EDsAbAN0d8U3ZIqBuA2+UblW7Dm1I3BZlBCQhUJZvu0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751843656; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=b1oTof9XHsD6TWvzUALGVJhu6zyuarKFaH9BBs5xfQ4=; 
	b=I0jOzjlRiuVnaFgv7nMcNZt8BLKi84EENPdnKMsTL/epCJVUYTw+E5qVRWnIlDym7MT0AmAqb3xQScRF/G0bVwBjH8Jjvd+CfYjVa2vaPP0Eg8ianbmp9vedhRsiVwkZEm2DaGEOyK/RVkux5gCx9hp5rvwJ6FMJyyX+Ivg1Ljk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751843656;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=b1oTof9XHsD6TWvzUALGVJhu6zyuarKFaH9BBs5xfQ4=;
	b=HIT91SYDiPr6LT3EaDa78c69b8m8ZopgYOf0YqjvamGqBSyD4Kl90Hfh3dXSxTAR
	TSOFTswIGVeHGLhLY3DqJoIOktgLNlVWhtE21zVCd8PuIyTk7PZxMEyJddWFUeq9VnX
	MbMj8vk94viPmXwq0xu6ZF4tehKxja3PgF69WAQ4=
Received: by mx.zohomail.com with SMTPS id 1751843653394405.22398881437505;
	Sun, 6 Jul 2025 16:14:13 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 4CE1E180F17; Mon, 07 Jul 2025 01:14:10 +0200 (CEST)
Date: Mon, 7 Jul 2025 01:14:10 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hansg@kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] power: supply: core: Add
 power_supply_get/set_property_direct()
Message-ID: <6lgsjfgug5mvsj55n3hc2egvi5hjfemsxuhsfkookgpqrzgqfr@woud4h7bdhvj>
References: <20250627205124.250433-1-W_Armin@gmx.de>
 <b4e077d9-a5f5-47ec-abc7-9e957c32cd5b@kernel.org>
 <4e28458b-baba-456a-bae6-08c2818aedf8@gmx.de>
 <66dbff89-131b-4bc5-1059-c97342b2efca@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bo3tsc62dh4x3mul"
Content-Disposition: inline
In-Reply-To: <66dbff89-131b-4bc5-1059-c97342b2efca@linux.intel.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/251.827.75
X-ZohoMailClient: External


--bo3tsc62dh4x3mul
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] power: supply: core: Add
 power_supply_get/set_property_direct()
MIME-Version: 1.0

Hi,

On Mon, Jun 30, 2025 at 11:58:39AM +0300, Ilpo J=E4rvinen wrote:
> On Sat, 28 Jun 2025, Armin Wolf wrote:
>=20
> > Am 28.06.25 um 11:25 schrieb Hans de Goede:
> >=20
> > > Hi Armin,
> > >=20
> > > On 27-Jun-25 10:51 PM, Armin Wolf wrote:
> > > > Power supply extensions might want to interact with the underlying
> > > > power supply to retrieve data like serial numbers, charging status
> > > > and more. However doing so causes psy->extensions_sem to be locked
> > > > twice, possibly causing a deadlock.
> > > >=20
> > > > Provide special variants of power_supply_get/set_property() that
> > > > ignore any power supply extensions and thus do not touch the
> > > > associated psy->extensions_sem lock.
> > > >=20
> > > > Suggested-by: Hans de Goede <hansg@kernel.org>
> > > > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > > Thank you for your work on this.
> > >=20
> > > The entire series looks good to me:
> > >=20
> > > Reviewed-by: Hans de Goede <hansg@kernel.org>
> > >=20
> > > for the series.
> > >=20
> > > There is the question of how to merge this. I think it might
> > > be best for the entire series to go through the power-supply
> > > tree.
> > >=20
> > > Ilpo would that work for you and if yes can we have your ack ?
> > >=20
> > > Sebastian, IMHO this should be merged as fixed not as for-next
> > > material.
> > >=20
> > > Regards,
> > >=20
> > > Hans
> >=20
> > Personally i would prefer to merge this through the pdx86 tree as the
> > uniwill-laptop driver currently under review will also require this
> > functionality.
>=20
> Sebastian, are you okay if I take this through pdx86 fixes branch as=20
> requested by Armin? If yes, can I have your ack please.

Sorry, took me a bit to figure out if that works, since the core is
also patched in my next branch. But I think git should figure
everything out on its own. Feel free to merge the whole series.

Greetings,

-- Sebastian

--bo3tsc62dh4x3mul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhrA0EACgkQ2O7X88g7
+prjTQ/6A/ebnZx4CpcXEfs6tLc584R2AXn8T9uoqSiFJZH007lkyjrG6+as4mZq
4GhVEfbl/tfpTAy6nfe1NqvI7rUlzlhU44BnRcC6YfIkWU7dRx1Th7YvYQsQZEK6
XCOeUERVBwn/FpZfj+nr0VM6PN1s05Q+QL6JdUriq03BzOsKgNnK0M86p7vTpNKG
qkjp7AbrcuezPlydY0C31rF+zESz82jxc7DO+/ItKTH6LbdU7oBjF8FJk58mMO5p
ZyvGqy7DXTCStpOcckRmPRWV+KYMkr9uIGTB/+xuy0Wr/NuAJA1alsZKSDUXWY1N
NqBPus5qVHaW/h8t9XU8W89q69ooncDwhPbatBR1czq/n+YfClVfTpoAZw6FVx7n
WhqnB2L2/a8O5+HY25muBB3FmIvAe9RFRxkFgNLNdvXa5MdARaddWAc7eNygHTdJ
VE/AEjzivpjv9ZTuPxJKhidG+WVv7DSy/wJSIfyvbmTZLJE5TeOsqJ6PTQ707wwA
zDN7vIdBCF681GvLfuRWham/WsmHlJzbypRF17NKjk/HLOdbVgUyC76X0hE4zEdb
x9CsctuL3SIQUBtGWACgawNH7NADpLKlleXVQDWChj8siv6tQrJxTYrA82/5pdyM
xN+8pEPH9h5wur+nCK8AfXdK4B36wuqyaxjkg/3zXPUZe+z6omc=
=FCxe
-----END PGP SIGNATURE-----

--bo3tsc62dh4x3mul--

