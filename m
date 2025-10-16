Return-Path: <linux-pm+bounces-36307-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C21DBE5A32
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 00:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05481A65CFC
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 22:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D8928CF49;
	Thu, 16 Oct 2025 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="XZzh14oA"
X-Original-To: linux-pm@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950691E1C02;
	Thu, 16 Oct 2025 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760652326; cv=none; b=Vn83z6OJ5X3F2OQeA779Q3w18UX4hmTXoCfPRcYEOnsmp5t5s2hE1fd9FC1nXsjg2je2iCozgZl+ylc0HZkKrvC8OEGjXYiStS2k14UFFy55onYPwwJlNDlzlRUyVm65PUifBD/vgo13JB+MCLm9vdl92LRob5DwMbezpsAczoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760652326; c=relaxed/simple;
	bh=5JEj39LadNR7rhYPvNgg/UBNja+ntXm8BL0As54t5qU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KHn2DxImFN8wofPQKzW9rUSqVjLJyLG1FiykX0nH2NPyDROlb1RqfquN/hTy4jm5SVRAJYb+OTJXzMrpecHGarqJM6LkIaj3uEicMoMW/FjD+X3zvtUXHjQZeZYSC1WWRYd6tyzVj67idbVdnmeToL3xOA+99q7q1QjS4fbzYmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=XZzh14oA; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202505; t=1760652318;
	bh=5JEj39LadNR7rhYPvNgg/UBNja+ntXm8BL0As54t5qU=;
	h=Date:From:To:Subject:From;
	b=XZzh14oATVTpGoiEls3TWGOMKbnvFWLmdoXm/ebIccbriZLORocDlMam5x8uRHrYO
	 YAMQ3duxJYgy5+j21JjXoazNFWd7REQd9DW4/hU8cfOYYLRBuMwSCZvO6t3MpTnrMa
	 au8E/sZh9s+hEVTUg/s93O//X0Bo3KTBF4wLpnoBsah92j3pk7990Rxn/S1QRhM8uG
	 nyOoegLIiB1unz2unSJsxEQV3bustuXp79ZWpDr23cwIEQ8QDWylXBkxsobnIu8WzS
	 78csjVV1vprkZBnELUf6M3XFgYrJyF8L05Ewht81aqDNSWPyefzx5baww44vXAakdb
	 vHNUQ24C0f6VA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id E393F96A8;
	Fri, 17 Oct 2025 00:05:18 +0200 (CEST)
Date: Fri, 17 Oct 2025 00:05:18 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Sebastian Reichel <sre@kernel.org>, Anton Vorontsov <cbou@mail.ru>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: apm_power: only unset own apm_get_power_status
Message-ID: <xczpgox57hxbunkcbdl5fxhc4gnsajsipldfidi7355afezk64@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pix4lgskgslujr3l"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--pix4lgskgslujr3l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Mirroring drivers/macintosh/apm_emu.c, this means that
  modprobe apm_power && modprobe $anotherdriver && modprobe -r apm_power
leaves $anotherdriver's apm_get_power_status instead of deleting it.

Fixes: 3788ec932bfd ("[BATTERY] APM emulation driver for class batteries")
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 drivers/power/supply/apm_power.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/apm_power.c b/drivers/power/supply/apm_po=
wer.c
index 9236e0078578..9933cdc5c387 100644
--- a/drivers/power/supply/apm_power.c
+++ b/drivers/power/supply/apm_power.c
@@ -364,7 +364,8 @@ static int __init apm_battery_init(void)
=20
 static void __exit apm_battery_exit(void)
 {
-	apm_get_power_status =3D NULL;
+	if (apm_get_power_status =3D=3D apm_battery_apm_get_power_status)
+		apm_get_power_status =3D NULL;
 }
=20
 module_init(apm_battery_init);
--=20
2.39.5

--pix4lgskgslujr3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmjxbB4ACgkQvP0LAY0m
WPFqCQ//fxglfRv+qlGsadB3URTAE0Xt/umw7kK0stSIuGUw7Z/JCuRYCWlqzEPg
UhdbIOsI/2yf1r9dhpurnCaBnx++5HibSgGcxfYWMhCWePxYnx7ebm1HBUB/oYnx
HOPtXv4scCUnnYXvitR1mtNIetUndMg7EAsDjXd/fHaWI3clieY4mWapFHCmya1M
Lx27ld4O8nQgYGsCi8tQO9tG87+Yqly6QUVJDPze1vf4EIr2WjJC0GkAS7wts/bx
qqPdA681wqg9abFNKYRbcBnL9K1U4COgItX+zvgKqpuD+tIXKggK5JZxhVV/CDXN
cCkp+vD1KJWPZtTaF05WCNhNw441NKxhFCgTYlo96OJou0APnlbc5JOt9UPCn+ZN
wwzMaX78SLZxVwXdAebYaw5c5F41W1L0JSWpVG1ULOP6Aa/5KEMQnBu30f7n1Zum
OlNabnWdVbW0Gzl5Qs9xLhtMry5/SLE6i/5xg+9pREadUoqrGXT02IieobiR94Za
OW92QqWWpzdkOCmuxKxKR01k+vdii+o1iYcSET0QQE+m1HmgHjU8M5wmcZYZIguX
L19OrRuF055SLDC16SjKVAgraCkR0E5M0otQLThk/jZME+gOqHctz4WW75NBGB2a
HpJ9R3jEGVdy7xU+CioSWS7/Ch4r7Y8EPT22x3eXwPJhIEoW7Cs=
=noJ1
-----END PGP SIGNATURE-----

--pix4lgskgslujr3l--

