Return-Path: <linux-pm+bounces-40773-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17718D1BCC2
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 01:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82EB63023D7F
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 00:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501141E9906;
	Wed, 14 Jan 2026 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="J83zjl/g"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2740A59;
	Wed, 14 Jan 2026 00:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768350413; cv=pass; b=B/e5yqgEG7HLsgf9GY0ntx8pr76JGKkbNnBAulvKWXkLahe5Z0QHMgF/MhJhxd++vL8VYsCVGQehSx7b3Ld1trnQBd+FmDGXEHgfLnK8OpZvsBEnSpDcrw2hqg8gjTk4eYetClZdTGsKhArXo4K6kNRuZDNeAkfplNwlZ86iPv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768350413; c=relaxed/simple;
	bh=8GF8mdMqO42VpHXmcHhn6Rd2npsDpkhfv448ZcXuDOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fp5C9n5coHFtlU6vw9mfZrV9fJVX80Y+uVB4NURVx5gOqsmvk6rqtGIpLxuFCBOWKi/WieMyi/k1YMCdpd1bgiJpKWT4wz8HVLc9ZWJ9cwBj0q7TAPdbBVhlxRj7iWVHUjP6bXnXfFaXuxcYrqXmKaqJAP8hp2KUsMZQvOZ5fSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=J83zjl/g; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1768350389; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PZLFWYd0p8ZCUQbhq2E2e0G1rTnMvY70rbrX5ddbVjaVVUL3jmSlF6TCgB6ndDnxOHmldZA999g72uZxoDBKHbD8hQGQryW4nxcu8Cwaef7Syu2La5wsZAhcKNo+qVHApi3cC0MclSSrztYyOgbILVTDMwNCDON2tO6wyXFz9IQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768350389; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8GF8mdMqO42VpHXmcHhn6Rd2npsDpkhfv448ZcXuDOE=; 
	b=S1Gl2gNo/QR7tV/HZLAvxu2uWFRRF583nMezuUtcD4B8U7lJD0j35OhbF6pUWCSFWT9fAeZmKXTStxEurqo1FFkJePair08A86l/4wNREydTHobUYMZSBxbMD60a/ROu77PDganRigyw6f0P9T6nH9FjpbuQQqcOUEc/c8oUEVw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768350389;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=8GF8mdMqO42VpHXmcHhn6Rd2npsDpkhfv448ZcXuDOE=;
	b=J83zjl/gr+Giru9ZrvebGie4XonpdcF69R/3yVnB6erNhSMiwGlCveLyiPbEX74G
	kAZ3CaMqEPfBgF01RXP54TwMkHlmEEnC3k5Zqoglge8Q0xpcB6vb6IHFV5fH1OgxmnC
	iuvL9cyCoEWK0eqjDYMcH4b+q1YQO8t4yCZZUFws=
Received: by mx.zohomail.com with SMTPS id 1768350388284515.6380475328023;
	Tue, 13 Jan 2026 16:26:28 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 00C2D181010; Wed, 14 Jan 2026 01:26:21 +0100 (CET)
Date: Wed, 14 Jan 2026 01:26:21 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lee Jones <lee@kernel.org>, 
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
Message-ID: <aWbg3PTf677Jt9rG@venus>
References: <cover.1765804226.git.mazziesaccount@gmail.com>
 <20260108172735.GK302752@google.com>
 <63bc889a-b97e-43c3-9f46-9ca444873b70@gmail.com>
 <20260109093831.GB1118061@google.com>
 <aWRFs3CJvd37BaoH@venus>
 <ebb14cef-9927-4211-94ef-2f209abeb406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7npdp75ywl7qg3g2"
Content-Disposition: inline
In-Reply-To: <ebb14cef-9927-4211-94ef-2f209abeb406@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.5.1/268.322.40
X-ZohoMailClient: External


--7npdp75ywl7qg3g2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND v6 00/17] Support ROHM BD72720 PMIC
MIME-Version: 1.0

Hi,

On Mon, Jan 12, 2026 at 02:04:47PM +0200, Matti Vaittinen wrote:
> On 12/01/2026 02:53, Sebastian Reichel wrote:
> > On Fri, Jan 09, 2026 at 09:38:31AM +0000, Lee Jones wrote:
> > > [...]
> > > > > The MFD parts LGTM.
> > > >=20
> > > > Thanks Lee!
> > > >=20
> > > > > What Acks are you waiting on? What's the merge strategy?
> > > >=20
> > > > I think everything else has been acked by maintainers, except the
> > > > power-supply parts. I think those have only been looked at by Andre=
as and
> > > > Linus W. Haven't heard anything from Sebastian :(
> >=20
> > Yes, I'm lacking behind quite a bit, sorry for that.
> >=20
> > > > I would love to see the patches 1 - 14 and 17 to be merged (via MFD=
?). I
> > > > could then re-spin the 15 and 16 to limited audience as I hope Seba=
stian had
> > > > time to take a look at them. However, I don't think any of the othe=
r patches
> > > > in the series depend on the last .
> >=20
> > Sounds good to me.
>=20
> Ah. Since the 15/17:
> "[PATCH RESEND v6 15/17] power: supply: bd71828: Support wider register
> addresses" was now acked by Sebastian, then it can also go via MFD?
>=20
> Also, if it is Ok to address all the "dev_err() + return ERRNO" =3D> "ret=
urn
> dev_err_probe(,ERRNO,)" conversions in a follow-up, then I guess the whole
> series, including 16/17 is good to go? If this is the case, please just l=
et
> me know and I'll send the follow-up. Otherwise, I will re-spin the 16/17 =
and
> add a new patch for the remaining "dev_err() + return ERRNO" =3D> "return
> dev_err_probe(,ERRNO,)" case(s)

That's fine with me.

Greetings,

-- Sebastian

--7npdp75ywl7qg3g2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmlm4qoACgkQ2O7X88g7
+ppD3A//R8n9hZADutZUgDRTVjqCd71YvQdLiff2FiW3L6d0QvZ46c9INcqhNLUQ
ciUNNmgtac7YtIi7Lt7SXL1W3wgWfrnHY98jIrnUrZuGj+NSGrqxqK4PhlCyv1Jg
iqO2wIC2EQey4Cc5qZlY1ajvvyfx06h8FOzliNZX/hmjXe9Mn6Xuy262yW84d6OR
3wNtrje0geiPezOYHqF/9FtHuodaKAqaPNQdm1NvPjBFTwE/fzfLS2a0WGLLpq02
DthCyaGj/N7+CnezA7jyJjB/1Oz6XelEvS2OkUwZnyD5l6frQhRaC1tkEOre4BX3
UGBxQVd3mUGgLl7dkgvnwCEOs0wGnqzfR7tvYqXaSmuQktOcJ17HF+PsudCX1BGi
S4hhWXW5XPIhJj1c7wZIiqz0ewyv9ZuKuov4w8oaMkdVqpLYxCMtKlN6tZdZfdFO
fyK9E8DxmkjTl0/HwKNpOHO1BN+QEohnlAxCOI724seBoStdHpYMt0jUH+hoYkym
7Hbfmg1+qi1Zx265b89yGW9cn325br79sZ1o1yFd3LIzPaTiRgiAO3UUiYRiqPiu
NxMqGzU5wYZ2o8zR+bG/KXavXrzx/WDMzKU5QvSvPYUo3QJkTnqbZrfFrW8SmMeX
Qqox+xoHhBekn9ZcIszzBS0j5JFs4+egcIzfT254DL5AJSDjQMU=
=0iKX
-----END PGP SIGNATURE-----

--7npdp75ywl7qg3g2--

