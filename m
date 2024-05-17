Return-Path: <linux-pm+bounces-7938-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23948C89C1
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 18:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF641C21443
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 16:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F51812F5A5;
	Fri, 17 May 2024 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQVUWZd0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A5612F58E;
	Fri, 17 May 2024 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715961903; cv=none; b=J8xs4CDRQrnEsoxiwYEXHDUMxhRg+bAxz9rTEgYVwgCu0cUciym7Mvlscha/VB9elRoXkpB5EdleyN0X9czJEKWrjeVxvK3vSTaBTvM4boo5WGCDrbtrf6dFSyK0+iCo4/qtT4hMbXjYaerUWJli1e79/w0plC2jV0xu+L/Fw4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715961903; c=relaxed/simple;
	bh=dCTYsvvxFgi7FATRWxnawc0wrUUcw+8JKULz4rwaMvc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DXvfKxBiTCDw2MetnUid83slyDaV3G7rjkqBBlHUAh8nEdRmTc1Kjf9Wld9EPhuJZEMLpO6NbFIo/tlLw54KBSm8Fpx5MWCS3oJVq/LsihcaIINb9OAQ45P6wyfOYNVbBp4UrV1EZ+e8cHPy7jvoiiBcq0mLBmifT0fR4cfwRzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQVUWZd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3728C2BD10;
	Fri, 17 May 2024 16:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715961902;
	bh=dCTYsvvxFgi7FATRWxnawc0wrUUcw+8JKULz4rwaMvc=;
	h=Date:From:To:Cc:Subject:From;
	b=nQVUWZd0RsJNH89xwvk+2P8RVGpzPLxFi7RhoGr6u0tRlUfSrDpeHozk32B1dnp+/
	 spdu7Vm4J3tXc11w4suJTQJmcp30RUaKq8ER555DYbWs3XpBwuJFI1/8vdi42WPEEY
	 hfi2QbnIKi8rnUuy5dlnOz41ppmUTGDK2bhrT9JrNpNLFhfEpeuNgHf4qKB4RHNPM2
	 CP5jAw2L9ehVSQ7Z6yUg0KKoXBiLzXgVWlT3ucf4vAthk8+4FL3K/2YLSVs5fZoO7f
	 Sq0w7v9YP6Uk0G+c4bvDkBN53IlDIJseojeglbWkNVso3XX0BOy3gZgzTL7I4//6uH
	 bVxsyKLsR4xAA==
Received: by mercury (Postfix, from userid 1000)
	id 9709E10605D4; Fri, 17 May 2024 18:05:00 +0200 (CEST)
Date: Fri, 17 May 2024 18:05:00 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.10
Message-ID: <cxfqbs4vvzniebbpvajkymvjfztst75z5di6dvuk3gyvyiodnl@s5phlkjujcon>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pzfq6bthdjrnx7d2"
Content-Disposition: inline


--pzfq6bthdjrnx7d2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Just a few changes this time. All patches have been in -next for 7
weeks except for the dt-binding change, which I apparently forgot
to push out. I still included it in the pull request, since it is
just a simple documentation fix. There should be no merge conflicts.

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/for-v6.10

for you to fetch changes up to 55f7073f6f59ef2c9e98b70f74118dba62e1aabc:

  dt-bindings: power: supply: max8903: specify flt-gpios as input (2024-04-=
30 16:43:09 +0200)

----------------------------------------------------------------
power supply and reset changes for the 6.10 series

 * core: simplify POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR handling
 * test-power: add POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR support
 * chrome EC drivers: add ID based probing
 * bq27xxx: simplify update loop to reduce I2C traffic
 * max8903 binding: fix GPIO polarity description

----------------------------------------------------------------
Andrew Davis (6):
      power: supply: bq27xxx: Move temperature reading out of update loop
      power: supply: bq27xxx: Move time reading out of update loop
      power: supply: bq27xxx: Move charge reading out of update loop
      power: supply: bq27xxx: Move energy reading out of update loop
      power: supply: bq27xxx: Move cycle count reading out of update loop
      power: supply: bq27xxx: Move health reading out of update loop

Herman van Hazendonk (1):
      dt-bindings: power: supply: max8903: specify flt-gpios as input

Thomas Wei=DFschuh (2):
      power: supply: test-power: implement charge_behaviour property
      power: supply: core: simplify charge_behaviour formatting

Tzung-Bi Shih (2):
      power: supply: cros_usbpd: provide ID table for avoiding fallback mat=
ch
      power: supply: cros_pchg: provide ID table for avoiding fallback match

 .../bindings/power/supply/maxim,max8903.yaml       |   2 +-
 drivers/power/supply/bq27xxx_battery.c             | 116 ++++++++++++-----=
----
 drivers/power/supply/cros_peripheral_charger.c     |  11 +-
 drivers/power/supply/cros_usbpd-charger.c          |  11 +-
 drivers/power/supply/power_supply_sysfs.c          |  20 +---
 drivers/power/supply/test_power.c                  |  36 +++++++
 include/linux/power/bq27xxx_battery.h              |   8 --
 7 files changed, 121 insertions(+), 83 deletions(-)

--pzfq6bthdjrnx7d2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZHgCcACgkQ2O7X88g7
+pqzuw/+ORVHAzMgh0FyQO6Wr2S5aV8o7QoTBxJc0WX35/QU2j+xbf7d72x2Jray
VJdbRW1nZX1pG5nrDhfw5Fbl7wI542qCMDGX1KYgGDzJRTEh7S5qv1bXIqi5k7D9
99V6gYz0Kaquo4sx7vrQhDCGR8Sc3NE4s4sTDixMEjPeq7x51i/Y1xa/YT8fEo0q
x3Qu9KoSwKDGsMF4ZTZ3oMUbrbGSXkWd1YC4tio47medVBAZoeJNgO6ZxOSqmzb5
ZHT3REZd4tAB7J+DONUWqREUZlb9jyNo9tCQ8S1UDPUe1zV3uruJqr4vQvTx4Xc5
47ZeLIR1SghZEedryh4JdMt/PZZeRI52bu9PFXLmmspVy6iZMp+PRKY/jNZqXDsq
nEyk5lpxHYCVJgYchCBt1wlfFitc9Xyfz2ZSj70XaUQtqOl3XOqKmwwEjdK5Wygg
k+6pS9HlCVCuIviXPhwYeuLKTnTNVqPU0m2nXdc0ofT1x+p3p71nacq4sqN/gtX5
0/konxwvaVKEVPZL/nnC63JU/wvUxH1Oyr7G+/hJBbzwveyR93qvyGR8rJngS3mx
4djZ42aNBVMSc95bvPgLKcgh+YtVfMzlGGm5bujiSCWk+Xt/90Z7Zgo4k0JM5q4k
tBEYotnffgUdJQ4ZH6F6sMq+8IvQOTIO7ZmO5eaKboDuk6AeCzE=
=JCrL
-----END PGP SIGNATURE-----

--pzfq6bthdjrnx7d2--

