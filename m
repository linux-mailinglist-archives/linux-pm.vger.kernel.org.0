Return-Path: <linux-pm+bounces-37301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0BCC2C715
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 15:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227BE188FA9A
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 14:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD70281503;
	Mon,  3 Nov 2025 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="VeYd96dS"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A08280332;
	Mon,  3 Nov 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180912; cv=pass; b=nhDzq3ulEOgRF4eGBYuqRmFA+w9CObQuIzD1UBRPZ2VouwES4n2/wyqgCdaYbMmuuRrAm7bDE14awDFifK9vZDTVV42DFqqbJZgdKex1/2Ex3onyCao2KH7sOl5Byv6fhVU898rXEuTbubjfwwCfDuDvji/hp/6WRlaTmVGzHbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180912; c=relaxed/simple;
	bh=BUl4881EemL8NcxQjWfrxFrtq5eOPgoL55eAIrCawk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4apDUwHBOackVLXXl3O6lfRC4pjZBpephyWDS36/hGXpWxmSUOe5SY+/5pt9TegLB62biwzVc6/f+3zDhP8vBmEjySFOkKbUPR5xR5c3NfXq7AF31v1TV6b0nqcC30f3yIZ3N63oVRv0XJ2hFrg0PRX6PraVgUqGV8VBqkWj4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=VeYd96dS; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1762180904; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OlKkFhWTkkZmHDRb7PemfXYw1xb1t5cwjCkAoGPiLLeS6ZxLAoiqRtfWJhipl9/1fkVIw7MVd6RpBrmZRiijQbXg12AVF/qL/m2t4hvG1emCRz4sA+qRSEBPwFkdcp9RNZkYxNrDK0OIlmj413oF7UpY/ap0GSdjgRBWRTLkNe4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762180904; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CFrpz06o4t32EOpXiL8ubv+Q3woK4DQ1oFqsHtdiZec=; 
	b=YXjkVHlhXsHdABlm8TETglEK+4r0xGY7J5QyJvgGHlPigO1oJyFxdP7+AohBdPdiDmONh8V2n5V0t8r/SlHvnMI1Y5RLuBQafZIjyhbqnBwraBpAaoI2NwX+xOe4KzcaA73kKkW14wxr67IgaIJx87gjI68mrUaurh+ZveK9khY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762180904;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=CFrpz06o4t32EOpXiL8ubv+Q3woK4DQ1oFqsHtdiZec=;
	b=VeYd96dSXPT6JQzaR2aiEzRpoywFReKq7haWEhOYFMYfz7a4gckgZljsCh8N9Hdd
	e2k0D8vkL7p/Jf+MRulSPQo96n1w4qmobo2NOonGOiFjO82Yc/ALAwtYttlvoa+rom7
	H+kICzSsXW9z3CD8E3pfmzxiZx3bPtO8hdSDyYrM=
Received: by mx.zohomail.com with SMTPS id 1762180900981611.5667236444241;
	Mon, 3 Nov 2025 06:41:40 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 5BEDD182F6C; Mon, 03 Nov 2025 15:41:35 +0100 (CET)
Date: Mon, 3 Nov 2025 15:41:35 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Val Packett <val@packett.cool>
Cc: Fenglin Wu <fenglin.wu@oss.qualcomm.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] power: supply: qcom_battmgr: improve charge control
 threshold handling
Message-ID: <3nauihzsyl2flnwiim7e42dhitoubhuzimrbdddasy4z7abqyi@sjm4gd3jtjpy>
References: <20251012233333.19144-2-val@packett.cool>
 <176213091335.301408.9120443011267055817.b4-ty@collabora.com>
 <8f003bfb-8279-4c65-a271-c1e4a029043d@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="amxtoasgmrgegheu"
Content-Disposition: inline
In-Reply-To: <8f003bfb-8279-4c65-a271-c1e4a029043d@packett.cool>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.5.1/262.144.53
X-ZohoMailClient: External


--amxtoasgmrgegheu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] power: supply: qcom_battmgr: improve charge control
 threshold handling
MIME-Version: 1.0

Hi,

On Mon, Nov 03, 2025 at 12:46:13AM -0300, Val Packett wrote:
> On 11/2/25 9:48 PM, Sebastian Reichel wrote:
>=20
> > On Sun, 12 Oct 2025 20:32:17 -0300, Val Packett wrote:
> > > Currently, upowerd is unable to turn off the battery preservation mod=
e[1]
> > > on Qualcomm laptops, because it does that by setting the start thresh=
old to
> > > zero and the driver returns an error:
> > >=20
> > > pmic_glink.power-supply.0: charge control start threshold exceed rang=
e: [50 - 95]
> > >=20
> > > Kernel documentation says the end threshold must be clamped[2] but do=
es
> > > not say anything about the start threshold.
> > >=20
> > > [...]
> > Applied, thanks!
> >=20
> > [1/2] power: supply: qcom_battmgr: clamp charge control thresholds
> >        commit: 8809980fdc8a86070667032fa4005ee83f1c62f3
> > [2/2] power: supply: qcom_battmgr: support disabling charge control
> >        commit: 446fcf494691da4e685923e5fad02b163955fc0e
>=20
>=20
> Woahh.. please revert the second one.
>=20
> I'm sorry, I thought this was discussed here but apparently it was only on
> IRC and I must've assumed that the patches weren't going anywhere because=
 of
> the lack of R-b..
>=20
> The disable bit was acting rather strange after all, we'd need more work =
to
> figure out if that's even possible. Let's leave it at the clamp only.

DONE.

Greetings,

-- Sebastian

--amxtoasgmrgegheu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmkIvxsACgkQ2O7X88g7
+prgiA//ftqPbxE2sIyhCq0WRMBAt1kjIgiF/UrKpgrgSHNrW97LCCAq/ZfT+at3
zWb0tiy0xblcgrrg4Uyq7qOoCJitoS3HoJeRAzboIAPZ9BTm8a2MNP9b+4uvCD8O
w8Cc2mejVj1nYWaFRClhHtYS5rrXZYF+xUCOweGIzrSeqiBgaRBTaQYKHK3iMnuT
tFCDEfrr92CJ3z3geOEPbiAf/rsxxoOhkARa347YTJr+fU4F3j4Jv7S2KKfKTjd4
w14yqkiRBiQQODJjM4jTZpoR1nT/AfIbOb868Mxb5x/cTYEY/+BjyfAHhM/xlzqa
vP0eMQQZw366b9Q6kPm0YSipxc1LI9Ci7OotPKn5Nj4V4d0zEC5jFPnwmxJgMY+a
TgIxZkB4CWZtOknWqtQ5zPTB2shabJNrK9GhBCfAec/h+TySxXzv/fF8bRx63DXn
YtP3Zs7m/mJ2jN4EaKUEz3BSSCTGGnYz+eULSxgNQtEh1zHxVl/yrmBwBtRhxTCV
29DKKG3lJiIqp4sAixdsL11X1K4moff2sJHneG78QCOoFfqBR+R3cxv0dVTW1gCL
rrYBehwolL/BG1xtOiDI4wq3QYZTDxUBwlKB3piZ9zIw75/JfL1IFF7hN1+qTwIw
Y33jWKbCcHUWMLvv+QCylgEepaCTfpeSoYEJkpxicDX3c9u1IuQ=
=2Ym3
-----END PGP SIGNATURE-----

--amxtoasgmrgegheu--

