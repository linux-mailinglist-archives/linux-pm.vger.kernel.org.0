Return-Path: <linux-pm+bounces-11954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61607949A41
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 23:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3242B23063
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 21:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6DC158DC0;
	Tue,  6 Aug 2024 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5IhPkCC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA43382863;
	Tue,  6 Aug 2024 21:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980104; cv=none; b=PapRSbqZtL178X3Dx/Bttyh1QDrpnYY5Fp9caL051yDcRCRmAixrb12G8/vXYY4ZTK0rLbAvJIRXV/taeeHlW1AqOF+YEZJqlFTDn8hS/Tb9Lx6UiQq4S9wJQsl1at2LFsMdtoky0oNoD3eHJhFLVSKnQHJ5imVECa067qfw9V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980104; c=relaxed/simple;
	bh=4B0VqZXX8e0Xp86ft/ZY22AsMqEwkyCGIdkBRMWV1yM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fMv3oz3XHJWEwt+jax8EIZvVbL8rSGk609/rReU06dfjhcZb7alv3/EeWOvZ8Ib+mLRJLAdKMHxUPW3tIT287Xelm6CLvBQ5oc7F2pj3hX7nkRxOPYx/qJ/H0/Bfh6+/JLxwpHynYgp7jYw6Fj01fvRgVJoXvVpTi16kicajjuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5IhPkCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AA0C32786;
	Tue,  6 Aug 2024 21:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722980104;
	bh=4B0VqZXX8e0Xp86ft/ZY22AsMqEwkyCGIdkBRMWV1yM=;
	h=Date:From:To:Cc:Subject:From;
	b=C5IhPkCC73C0WrIXz/uZpToLCxoL49pVnrCdjLjJOS5zvMPETmL1aqNKSR8S/MKHZ
	 EMSFA2Xf3bh5kxw81z82ULQ6QvThk5SOQl73d35e2U8a8qaq4VZr9vg+zRvG6hwtlV
	 rfjOKidNAk63H1faNXhfuj9HO5BTr8ZPPVrxF8oyGdZJ1OSVoOYelQmJE0c3XfUeav
	 Xvq+twhT72wm3/M3gVoMCHGjf/LKiJpUJW/V7LJp5hGZA2gfWOv/r3IHKnj8ZxwmLb
	 accbqaDkW/TNtwmQxkAtOOp+s5EeTHMzPBlH8YfWvUpfX/QYIggnFepUkrEYUvOE0C
	 x2ysMP5EO8CSQ==
Received: by mercury (Postfix, from userid 1000)
	id 1423B106066C; Tue, 06 Aug 2024 23:35:01 +0200 (CEST)
Date: Tue, 6 Aug 2024 23:35:01 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.11-rc3
Message-ID: <uw3qk5vbjkonzirjhsrjlkq34sj73g5dtf4uw4yhprf6y6dn3e@umuf6mghw3f6>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ixfyut5kjxo53sav"
Content-Disposition: inline


--ixfyut5kjxo53sav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.11-rc

for you to fetch changes up to d6cca7631a4b54a8995e3bc53e5afb11d3b0c8ff:

  power: supply: qcom_battmgr: Ignore extra __le32 in info payload (2024-07-27 00:18:40 +0200)

----------------------------------------------------------------
Power Supply Fixes for 6.11 cycle

* rt5033: fix driver regression causing kernel oops
* axp288-charger: fix charge voltage setup
* qcom-battmgr: fix thermal zone spamming errors
* qcom-battmgr: fix init on Qualcomm X Elite

----------------------------------------------------------------
Hans de Goede (2):
      power: supply: axp288_charger: Fix constant_charge_voltage writes
      power: supply: axp288_charger: Round constant_charge_voltage writes down

Neil Armstrong (1):
      power: supply: qcom_battmgr: return EAGAIN when firmware service is not up

Nikita Travkin (1):
      power: supply: rt5033: Bring back i2c_set_clientdata

Stephan Gerhold (1):
      power: supply: qcom_battmgr: Ignore extra __le32 in info payload

 drivers/power/supply/axp288_charger.c | 24 ++++++++++++------------
 drivers/power/supply/qcom_battmgr.c   | 12 +++++++-----
 drivers/power/supply/rt5033_battery.c |  1 +
 3 files changed, 20 insertions(+), 17 deletions(-)

--ixfyut5kjxo53sav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmaylwQACgkQ2O7X88g7
+polKA//VycZvY96wXNSB4eLTUJIudH6BWB0n7gypu5ln5d/zM4YAoaFCwy9K0y3
iBoJopFeX/N1mOhRLhYbNCvAOfj1YSGcC6HJ3NKre5ALMzpVplpOTtxjuPhxxmWL
ZlLCA2sJNozYySip9jPq6kOgsk/GvEMckoqb/r4l/6lkuMZHva0uM4BUZZ5TgzyQ
jO3WJxVRtJ/2Gzz7s0Z2CFIVFBiCaoZZzWpWqzJBqYbDd3FfgPbECPFUpxMURgjd
gpCEmDVF0QdJY5ncksMgWEbk1Xe8vp8ppvo2Usf29x+ohbMpps6nVoO6T+11vc/p
LQUQtNV9YZpRj1beqzCzNAR3MTNeCXJJC2cK5nTOxa2or5vVGoKnAAb8Da9kvzBJ
NUTq7b8sx35rOFWr5QFal+f+i3zyfJ7vHyXLoxuubRyXSKp5LW6P0o9YgcRYr2qu
vTwZY7+XoLf9+tjEg3s3MxNMe4m91ywLT0XSEa/yyk9K5+uVAL5cM8cWrN7hbUqA
oonKeXd3hUShIhFvyre2LfajEBjmaJJLXvl7Zvzh7FG2GPXOPxedeWTgrJIhchwr
l3olSw3cLZjaRFRxKxeRkYyxV8PxHbsJQZR01QyFDouVRNiOaLXjgS/kq0G+X4Iy
jPPMtMr1LKWo0pbo8Th4NLrM1XWrtqIMZ/GOce9Q5yc4kY2gjd0=
=3gdF
-----END PGP SIGNATURE-----

--ixfyut5kjxo53sav--

