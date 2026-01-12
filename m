Return-Path: <linux-pm+bounces-40618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFC6D10366
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 01:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E723303752A
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 00:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954ED2010EE;
	Mon, 12 Jan 2026 00:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="QQq04QTE"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9A12BAF4;
	Mon, 12 Jan 2026 00:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768179254; cv=pass; b=OfhuPNNAseiQzpHGqoi+r67uxCSK+5Mfm6IbwR6dwB6I1n6wB9YiH2eM07BR8wg4cgdIGGl/I4YKi+NaSo2esyLIhQA6S3OX8xeojBCpSC7e9WwbJm+M+kNdYRyWO+Bni+uI+aJlVt5bPwdmNM3/1pzh/xQQgRTomN5hnv2t+r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768179254; c=relaxed/simple;
	bh=+OlCe0L8FtqTbO+EJZ5Rpg2vR2nskkVXZvBMl1XbcDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/c8nyur/Jq+HMUXqfnJK8UIaRy6bpru2CnMHDbKxo+tryCSFR1FpgTRbDv0/Zo6LH0q3gBPa1bbAO45EhKDd0jSw1QuA9VQRVtztXD2un4LMypViSbzVsULYj1gdOLkTSNIeNVScv4eJAF2Gd6uUt9I2H7YAuWhr9p+aFombDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=QQq04QTE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1768179238; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EUIsk1PVSGfo2Q2uU/ypgCCie1y4R+ZEmMdsE8YfRhOqjQSQ2Rj99aN0GFUGRCapbLJkUVqkKVinI+bdhcqzx+meDw05q2/+Y1rH3AFGwn/T203fqgzlKm+HFkIwYAwfeLuMISDFwypTcASStL/Sbspxe2BLOd9NwzSby5aVsIE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768179238; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+OlCe0L8FtqTbO+EJZ5Rpg2vR2nskkVXZvBMl1XbcDw=; 
	b=WmH352C7BSaTYI8J9mleaV6RErEm0TdL7SPg92UcH3uw3cWhJbh2sHDrAMBYLY15W/hsBbeA9a/1aIw3qb+iZ87uxINpwCwI8Q+pZfH7DP0ijQroserPVRw+5M8HtJVM8tAFAcj7cseIrsajtKB8afDL/n3jhITQeUk6sKIHoVI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768179238;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=+OlCe0L8FtqTbO+EJZ5Rpg2vR2nskkVXZvBMl1XbcDw=;
	b=QQq04QTEsoMkVyuXJWCEK2frpPnsTif+pQdC1MhwwlsjNwlK+HDHeaSEYXhNZ3vw
	4aMKGL+1sekcdyYFI6m8klGlDYiptkVXiZ2vl4LkzUHA8qlt8mjMGTB/X2Ko3xxbUfc
	z2t5ScRMyy55qkXHcj5HL6C0/ypM4lz+KVrBBkz4=
Received: by mx.zohomail.com with SMTPS id 1768179235482358.67420259126015;
	Sun, 11 Jan 2026 16:53:55 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 607881803AD; Mon, 12 Jan 2026 01:53:48 +0100 (CET)
Date: Mon, 12 Jan 2026 01:53:48 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Lee Jones <lee@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, 
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org, 
	Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH RESEND v6 00/17] Support ROHM BD72720 PMIC
Message-ID: <aWRFs3CJvd37BaoH@venus>
References: <cover.1765804226.git.mazziesaccount@gmail.com>
 <20260108172735.GK302752@google.com>
 <63bc889a-b97e-43c3-9f46-9ca444873b70@gmail.com>
 <20260109093831.GB1118061@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="njvmbtnaoaenudkq"
Content-Disposition: inline
In-Reply-To: <20260109093831.GB1118061@google.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.5.1/268.172.5
X-ZohoMailClient: External


--njvmbtnaoaenudkq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND v6 00/17] Support ROHM BD72720 PMIC
MIME-Version: 1.0

Hi,

On Fri, Jan 09, 2026 at 09:38:31AM +0000, Lee Jones wrote:
> [...]
> > > The MFD parts LGTM.
> >=20
> > Thanks Lee!
> >=20
> > > What Acks are you waiting on? What's the merge strategy?
> >=20
> > I think everything else has been acked by maintainers, except the
> > power-supply parts. I think those have only been looked at by Andreas a=
nd
> > Linus W. Haven't heard anything from Sebastian :(

Yes, I'm lacking behind quite a bit, sorry for that.

> > I would love to see the patches 1 - 14 and 17 to be merged (via MFD?). I
> > could then re-spin the 15 and 16 to limited audience as I hope Sebastia=
n had
> > time to take a look at them. However, I don't think any of the other pa=
tches
> > in the series depend on the last .

Sounds good to me.

Greetings,

-- Sebastian

--njvmbtnaoaenudkq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmlkRhwACgkQ2O7X88g7
+prO/Q//RUeU3aRLy6/gKRT0eG9pAJSbph2Ikd41UGeuXKFa2nIc0KBZU0fGmveO
f0UYGXIyOhauQPguvy3qO2YluOgw4NoBbyKms2TKrkLcFeL/Cga674Vjc7XKFaQP
wphwlW62PUT4MLo67D/apHwCoLmY34Ncm4t0k+6uDRvLklvt7+uWawLidX3exlev
JrjkLMog5C/ifh1V2UDIyQ9Haa6lWjSSNvfsrRzD5n3qU0eQmL/PNwaChIq9QyLL
v216cavM55KLOl0NmyiMTnt1O4tg6tTXKeEbN/nqxVXba1Wgl4gQf08i5pWWvaP8
EtyDHe0kHdzh4kC2VN29Qy+8f8/xHQUUkqAoO442mITI7F6a7riUhVvFySgkQ1DZ
y/cQ3+it8Hoxw3n8vxGnzeUgJ8wDpQphKihcax3iAQtOw382y5XOau+/N0ErZIPb
QPlqfrZ0Io7Uu2DaZQyVChungrNQqL3wdnVUzZxjAC4+Ih56nsIe4ZM76T/dpy99
djRrwzphkiVqWE2izhi/A78FOXyME/+PtpuwvHgK53na+6qESZDKfNSVEAUtn8qt
2A5LheVMPETkaNFTjaJD4Pme9P8Bt93+V5ePwi/nqXE7EpjXP+/OZa/wPvrhUFEK
+KAhuSHD6dXmB58zw5ZjlQVc1ocKe4GdiX22g72Wn8/RWByJs6E=
=a6To
-----END PGP SIGNATURE-----

--njvmbtnaoaenudkq--

