Return-Path: <linux-pm+bounces-19775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C519FD538
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 15:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C688164C63
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 14:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC6F1F1309;
	Fri, 27 Dec 2024 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0ax+H+Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5921D320B;
	Fri, 27 Dec 2024 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735310189; cv=none; b=MeJeiMAZz4pachOvy1IFtNXMhgxCiwr/5lxycr2PTFPulfQqBMpPcF08toOAbSTDB35bcDJkiPGDhO0HppoTJCDXBDMbJJ2clzF9mQFKKrPXKcik5YNK8DbRNbOJjg0EhxC9Ewad5GR9tiUiu/CzmxRgcJk0LB6pEiWZJx6Uksw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735310189; c=relaxed/simple;
	bh=pq7010BNV1xJsPFemxnyupXmgRDPFoR+ta0PzJZxfzY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B+hMAkyo6XRJseZY/ntVCTh5OLVmMQgJA03/aqUr3iz3bEdEHdOVUVoqfOOmEoIOVAqYnX0gsUY6JK7RgoVv98pgIJKqeaW1jy8NKRwkkF3helRuWmDlO1TJtofvk3UYXvJH8QE3M2DaWjSjG4i+iv+fdBABmhcBLV+je5FrJCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0ax+H+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4444C4CED0;
	Fri, 27 Dec 2024 14:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735310189;
	bh=pq7010BNV1xJsPFemxnyupXmgRDPFoR+ta0PzJZxfzY=;
	h=Date:From:To:Cc:Subject:From;
	b=n0ax+H+Q0KshT0sacSvg66e5R+X6KTRzzMAUXMM2PjWg2sOWNiUfWpxsbgRehf8rJ
	 xeN9W1cFDTdgaXRqQMNtutmhzSOX+z52p5+cGeFn/OyoeF1vptR1Jo7O8KcXrFbOXR
	 XoGcP0E+RCp77VPzFV6J/dlAUEtERAPblhEip8dCDP8CjKs96asTjOLRt6JlMwsQyL
	 i3tpDanbxgPZQPfIQcuQR/lm9E5PlWfPbJZFwtupXSlKOUCCQjqs9KDq3MdEMFas9t
	 hB95gyp5WRoE4nQeZV5cEe5RT4F2KRdVnDFFs1jzM1uCpS6/bJ0uooWUmhqOedTde5
	 FCtwrQa50ucKA==
Received: by mercury (Postfix, from userid 1000)
	id 249771060343; Fri, 27 Dec 2024 15:36:26 +0100 (CET)
Date: Fri, 27 Dec 2024 15:36:26 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.13-rc
Message-ID: <ynsgbm7pdff4ywjkzrdqcr5zdpiexuvg7zalj3atxiryegbuel@yrxewux2mt6j>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2n2yeud7w2e2zd7l"
Content-Disposition: inline


--2n2yeud7w2e2zd7l
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] power-supply changes for 6.13-rc
MIME-Version: 1.0

Hi Linus,

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/for-v6.13-rc

for you to fetch changes up to b3ded6072c5600704cfa3ce3a8dc8718d34bda66:

  power: supply: bq24190: Fix BQ24296 Vbus regulator support (2024-12-19 00=
:35:30 +0100)

----------------------------------------------------------------
Power Supply Fixes for 6.13 cycle

* gpio-charger: fix potential array out of bounds access
* cros_charge-control: fix concurrent sysfs access
* cros_charge-control: allow start_threshold =3D=3D end_threshold
* cros_charge-control: workaround limited v2 charge threshold API
* bq24296: fix vbus regulator handling

----------------------------------------------------------------
Dimitri Fedrau (1):
      power: supply: gpio-charger: Fix set charge current limits

Hans de Goede (1):
      power: supply: bq24190: Fix BQ24296 Vbus regulator support

Thomas Wei=DFschuh (3):
      power: supply: cros_charge-control: add mutex for driver data
      power: supply: cros_charge-control: allow start_threshold =3D=3D end_=
threshold
      power: supply: cros_charge-control: hide start threshold on v2 cmd

 drivers/power/supply/bq24190_charger.c     | 12 +++++++---
 drivers/power/supply/cros_charge-control.c | 36 ++++++++++++++++++++++----=
----
 drivers/power/supply/gpio-charger.c        |  8 +++++++
 3 files changed, 44 insertions(+), 12 deletions(-)

--2n2yeud7w2e2zd7l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmduu2kACgkQ2O7X88g7
+prsIA/9GnlYxQJzqDk1317qze9ZWimwdKpmKqR7N069swSswhD8ID5lm2t2HgJy
MGKx3Z69Q5g8jKey1zCGnNViqYwDjyetNmMgmya0R27WvabEaEOKG2L+4bcPIbuq
CfuUBYwX+JdRmpnwdHjL8S4tozhPC7ib+04P4IPGepv7UKYK+m3jKWgsn8CnsUwb
76+zPBcRLVjmjP9jYemCf9w5lE5EKoQU2x5kkuI8ujmhq8HFD1XhSkemPaKCwKAX
u7xutj0/vfZ2GAQiE6mqfFvAYmzP39gCVz1aNMmWXQzkQQkfis2j8FiuibeKmekF
gvJTFm5Z+Rp46Eovpvf1s5I3sC4DDip8Xfbpq4MVNELnmQHbUOy0fxXQxIAmZnxM
7RdRuwTgk4Fha3Rusjbbk7lUkXJobUwlx/j0oiUt0QO09tJetqpDjPZAB5Zxo+L+
x0akThesbSPKg/EpKWZByYJM9R264P3ate85yJjoCqfoqBXh/rAqy5JA1jrJ7/22
ne4QxvYs728R3yEf1NK51yr+5Md6LF8m+bbfJHNhxHSAykyGlS/mwJ7QBMwACkmL
hQJML1hX1Ryxr12Ogm7M8D9KThLY96mNSCO+ib20VpF5gZecT97yFIJ9CL5l8ffi
ZMch99aPUaXvu5UKK2A0lj7qbv+TZk7oMc3HJp8P8zFWsMO7nE0=
=MMyT
-----END PGP SIGNATURE-----

--2n2yeud7w2e2zd7l--

