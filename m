Return-Path: <linux-pm+bounces-8198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C84E8D0F9D
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 23:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED201C223A0
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 21:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213CA53389;
	Mon, 27 May 2024 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nnTBKl8M"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E1317BA7;
	Mon, 27 May 2024 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716845827; cv=none; b=E7wupaJQKSfG7InIeK64/NZRwqezKUjZO5jkuAKEpg8FZqzS8qNok8QklN5QUciAen3YYOJFy45FVJ8ahIojGb9za7PmQyPca2jxXbjd1ppGXIIPbiqCV+keDMCaw3QFpUdH8BENIM4gOhpw0mm0voEwnKbOCEar7WasuXO7lcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716845827; c=relaxed/simple;
	bh=ZzymRwiag4vNy1Ln3C5qFthv78Z+ynceuh6OsQPfIQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLfE+RDiNbIWomlevWpsepoW727twyZ3so5HjuIY+mUbzPzC2xBbkPaH15EkOiKzBP7v+2LH8bPcza6xVeI114sHG0Jnr8488AIYOGPxzgtaeTd4vfS3wju6IsNUHk+PlPNQxs3fGecHS9Rsh3xMwQlxaIF/vOiczvgoHm0enb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nnTBKl8M; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716845823;
	bh=ZzymRwiag4vNy1Ln3C5qFthv78Z+ynceuh6OsQPfIQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nnTBKl8M7Y4tz//0JHIUhjwi9s08B65Fl64ebhW7/naw6b9ddp2QNsz0Bf8rUl6Nl
	 5W/z4oIDPaBw19//FUeR9uuZFzFJPrDDyXiiT+UgkVU3Fyb+9YgDyBuPtB6K2qtasp
	 +WKFdruT12BdxrnafLPjvulTP5HPpu8Uy4jVQZMQdV4E8UZrc8m0KFxawXsFVTytks
	 j3KUoXHzTa9x/hTIBah6IZxQ0yYifLUA+AvyHui1+hA2simpfJItvvdOseAcGR7ZWQ
	 v/KXlzFn+jyF3Sa9SVx5ooDbbkHzIHq0mc65Be0VEs7gHJNXdScPAzKGJD87tCO1nF
	 RyUsr8q+IHauA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A68003780480;
	Mon, 27 May 2024 21:37:03 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 2CF3E10612B3; Mon, 27 May 2024 23:37:03 +0200 (CEST)
Date: Mon, 27 May 2024 23:37:03 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	Kate Hsuan <hpa@redhat.com>, platform-driver-x86@vger.kernel.org, 
	=?utf-8?B?QW5kcsOp?= Apitzsch <git@apitzsch.eu>, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/3] power: supply: power-supply-leds: Add activate()
 callback to triggers
Message-ID: <zkdtnbeidvlswrchxpwwpqhun2smx4575gzfpi4r35qowjoycm@e53yblr2ytjz>
References: <20240510194012.138192-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cpji5p6yjwsnbo2w"
Content-Disposition: inline
In-Reply-To: <20240510194012.138192-1-hdegoede@redhat.com>


--cpji5p6yjwsnbo2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 10, 2024 at 09:40:09PM +0200, Hans de Goede wrote:
> This series adds an activate callback to the power-supply LED triggers to
> ensure that power-supply LEDs get the correct initial value when the LED
> gets registered after the power_supply has been registered.
>=20
> Patches 1-2 do some refactoring / prep work and patch 3 adds the actual
> activate callback.
>=20
> This series applies on top of "[PATCH v9 6/7] power: supply: power-supply=
-leds:
> Add charging_orange_full_green trigger for RGB LED":
> https://lore.kernel.org/all/20240504164105.114017-7-hdegoede@redhat.com/

Apart from Andy's comments LGTM.

-- Sebastian

--cpji5p6yjwsnbo2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZU/PsACgkQ2O7X88g7
+ppBJw/6AvFN8+Mf82SILotJgidN4q3el5SRQuRk5X1+EPKLeWuw3o+JJ5lJ9N3H
dnCnlrib2727BqYUiXJ8UNjQevjsrIQxWDVacVphTWP8HJ5uP3F8CE2NTkdeRll8
wb6OlJOdWpR2tlu/oAclhBngd61Yc4qDnk/H3X5HDkfI7dSPQKTb8sFcmC1PY7Lp
FwjAcXp4yTNw3wxuzPvXcfuCBrkjZU497geQVJpwOVhj/L3JgVW6VtMxavWc3kib
es04kNSNYoHUxUfBhGE0Elj2iQ5uSMR8wtwq6N2JA6tFVLurSDNH5903ROehiy8I
A9r+TSSv/0Y8T5SZT978KbH5bA1NPA2l4MvKB4K+Wuj3uvxCDRj0Kob0eL5iLIN8
gAdP26EXHOFphqg8nhWl03YDRyuyPoKnn/s0s2+R823JgCwKzhlTxhNH6420SHXs
HXRh1QvARXXs9Ze5kARQevmJBN38JRLRzfUUDNKTsTP2yioyz9xmi2PWvzGr9M+8
oEitS41DREVzE/7C7XNyINO2uxLTTWj9sl3dTsopciizM9KcD2bA68WZIVJUDf2X
rfrvD+SrUotbzQXoDfwuMrts5n522Ss8s6haIatEXtCdSqYZsApzFx6Ocp4JVOql
bzPt0l/eeBGFY3RkYgsUYHa7XSzOGy9V/Jar/wRgVoPXG29sZAY=
=7OpP
-----END PGP SIGNATURE-----

--cpji5p6yjwsnbo2w--

