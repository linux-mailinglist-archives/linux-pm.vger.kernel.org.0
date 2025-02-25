Return-Path: <linux-pm+bounces-22908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E7DA44932
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 18:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B7D1885A7E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 17:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF4219AD86;
	Tue, 25 Feb 2025 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWkp5SfV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2DC156F3A;
	Tue, 25 Feb 2025 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506361; cv=none; b=BT0sky72j8uUMuILMvjQYsVz/UCJ6oxHjrxf5VRw6xpZCGWiaWANJwPgIHo29Satn512IrmWUy08ZkSJs4triGK+9TIfY12HlD1k6lFCCVdSiWEcIacIVtxttN5vme0Vh6vgv8TE0FTAodtTrSMK2yNLKfZ/2UxauYetA5rrlpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506361; c=relaxed/simple;
	bh=yBULEnieTf/nQ04VsVNsRxbU8OeMLTkbgocf2i5ZY0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCSo91Sn31P2jd5PRUDo4mi6INFyj9XuVxXMkHCUOY/ACv6AQjNAbxvPJhNqQM6yiFfTxpl0p9GA90SgiSPP9aLjrXS712kULwCsAaIxNW2PQckeaGAjUJCq7zuCvNvgiGBACzxYb7FVl2MAVBmO4XjwbVZolRv/DLfAlsP6LhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWkp5SfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C258C4CEE2;
	Tue, 25 Feb 2025 17:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740506361;
	bh=yBULEnieTf/nQ04VsVNsRxbU8OeMLTkbgocf2i5ZY0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWkp5SfVATCU6JXaCE4TayPuVL+eCHSYSxbJ3H1xQhC0vAS40u98f1WrKObFiVBgh
	 yqVqMjhZ/YO18OlGgUp0l5NDa/hkbIklidIn82bUP2vJTvJp6yw+73Dh7bHNfqYjHN
	 +ZQr73CANA2OvIk1XXw4dx2S4aewx69rt6eH3fnc9wALnp3bpQewmBdza28ubI06dG
	 1dYTu+HfjsJ0i+/DbEsJBcrK1PTDJ/jtaWtpE34VPnAVeQ6EtNFG1BJ+KBYu3uGvnt
	 MW7NV3+F74bLsP96vaa9QMsK8x6t2brZChzW3h0j/0Us4zQdbR1ruz1320aM+dyxlC
	 EbdtbJ99OKDAQ==
Date: Tue, 25 Feb 2025 17:59:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	=?iso-8859-1?Q?Adri=E1n_Mart=EDnez?= Larumbe <adrian.larumbe@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Peter Geis <pgwipeout@gmail.com>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Vignesh Raman <vignesh.raman@collabora.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/8] regulator: Add (devm_)of_regulator_get()
Message-ID: <3360051d-1699-46cc-a4c9-0f379fcf8de0@sirena.org.uk>
References: <20250220-rk3588-gpu-pwr-domain-regulator-v6-0-a4f9c24e5b81@kernel.org>
 <20250220-rk3588-gpu-pwr-domain-regulator-v6-1-a4f9c24e5b81@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6DahNsJj491Prgx/"
Content-Disposition: inline
In-Reply-To: <20250220-rk3588-gpu-pwr-domain-regulator-v6-1-a4f9c24e5b81@kernel.org>
X-Cookie: I'm not available for comment..


--6DahNsJj491Prgx/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2025 at 07:58:04PM +0100, Sebastian Reichel wrote:
> The Rockchip power-domain controller also plans to make use of
> per-domain regulators similar to the MediaTek power-domain controller.
> Since existing DTs are missing the regulator information, the kernel
> should fallback to the automatically created dummy regulator if
> necessary. Thus the version without the _optional suffix is needed.

The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319:

  Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-devm-of-get

for you to fetch changes up to 0dffacbbf8d044456d50c893adb9499775c489f4:

  regulator: Add (devm_)of_regulator_get() (2025-02-24 15:26:08 +0000)

----------------------------------------------------------------
regulator: Add (devm_)of_regulator_get()

This introduces devm_of_regulator_get without the _optional suffix, since
that is more sensible for the Rockchip usecase.

----------------------------------------------------------------
Sebastian Reichel (1):
      regulator: Add (devm_)of_regulator_get()

 drivers/regulator/devres.c         | 17 +++++++++++++++++
 drivers/regulator/of_regulator.c   | 21 +++++++++++++++++++++
 include/linux/regulator/consumer.h |  6 ++++++
 3 files changed, 44 insertions(+)

--6DahNsJj491Prgx/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme+BPIACgkQJNaLcl1U
h9A55wf/defOMhqJG1AXSmf7/jp/1X3vDIPMsTOOh0tDNUJtT8RdlyJ/1G15zthm
Ox921lEC1kReTUTejPD2nPrh+9WGu66Fcsm9T61U1q6bAZeAMclhcM6guiw66nXp
Dx7seGYTztQQY3PdtZmGK7jouFWjKA9f8CPEIENafSPzm6VMuQ50i/+snwRKcsKU
aM8r9w6ordMdNXq1ZG8lb7Y+gQuwpBBQ2/yELkpoLg/ONyGeR2YikE9Vm5h8jXEE
LpZh0x1iCwDVWgAJT+bE8g5u8IboaG8D8slK3sUb4f0VN9IiZSDcVOh9yKt4DZR5
oSNOuTmiEVVNTswy+nw3QdpvMLDTbg==
=rB2k
-----END PGP SIGNATURE-----

--6DahNsJj491Prgx/--

