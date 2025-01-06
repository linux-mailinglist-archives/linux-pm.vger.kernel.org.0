Return-Path: <linux-pm+bounces-19984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DCBA0251B
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 13:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83A777A3999
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 12:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16111DE2D7;
	Mon,  6 Jan 2025 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guOseR4U"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892641DDA0C;
	Mon,  6 Jan 2025 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736165574; cv=none; b=U+6icLLFaFklzdZk3x/hbPBDz9nP4aG/QCjPXO4kFYL/pgDUokaiwUCt7kKy5i1UMnwTJ8DR9sUuuPjFQ790Jw1v7A8lAVLyeuJXEj52qMpJvuHAXj76qKhwjbX8oGg9dURzTKJyCs3R3FkGfwXUXfsN6oiQnuyoqaJd7jOPs1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736165574; c=relaxed/simple;
	bh=oGYg4VihaN9XekRqQm/v8gi29KzPEeuneKq4SGL6rdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zru95F1ZFWS9FjF+M8FebUqkudybHwGY9zvuVyj7uitblvO4iZlsOv5PGMRLjX4mpAweYSyQ97zGOu9LSLA3Qzyg5cMvUETWTAX8W0ElTr3N7Qv30tlggD+x4CfsdPMl5ovDcetvmhpUIHBfG8O9fdhSuK2g2soYgNkdEClL4Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guOseR4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73A5C4CED2;
	Mon,  6 Jan 2025 12:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736165574;
	bh=oGYg4VihaN9XekRqQm/v8gi29KzPEeuneKq4SGL6rdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=guOseR4UG0uXGKRR23FZgdM6BoLTyaxbU1wGbXA/2JTs6envVsy11jvxhXZE/xRhm
	 q+RTP46onPVsM5lZHKRVE5j9SNAT2b7QgxZIhJMIYOMzx2Lp8cFrgXw3GZiZW+hghR
	 ZWdSuZWF8GSQ7t4uIdMptKgtOCbUWggS0kUhON1qsnOVA9cMX0+m30ZbcFDU6BtFOJ
	 3A2KWtJiK+LnUcETVr7ZfeoKTob9ZCbHnm0Rjcj9j4GJlmTv0UZtrYQjdbe9qLBKwn
	 anGb12ucv9UmTbo3XAaCH5daqLX8F3a3IpzWguOba9vNJEuO4r+t6xyZWZ7UqWtxiw
	 FzCxZ8Ue+9P7w==
Date: Mon, 6 Jan 2025 12:12:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Val Packett <val@packett.cool>
Cc: Fabien Parent <parent.f@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 6/9] regulator: mt6392: Add support for MT6392 regulator
Message-ID: <70a3dc99-4e2e-44f0-ab9d-7770d2df94c0@sirena.org.uk>
References: <20241226050205.30241-1-val@packett.cool>
 <20241226050205.30241-7-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/vYbwmcb+QbC4fzk"
Content-Disposition: inline
In-Reply-To: <20241226050205.30241-7-val@packett.cool>
X-Cookie: Do not pick the flowers.


--/vYbwmcb+QbC4fzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2024 at 01:58:06AM -0300, Val Packett wrote:
> From: Fabien Parent <parent.f@gmail.com>
>=20
> The MT6392 is a regulator found on boards based on the MediaTek
> MT8167, MT8516, and probably other SoCs. It is a so called PMIC and
> connects as a slave to a SoC using SPI, wrapped inside PWRAP.

Acked-by: Mark Brown <broonie@kernel.org>

--/vYbwmcb+QbC4fzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmd7yL0ACgkQJNaLcl1U
h9AoUgf9E5E6xhnmqTj1rf9LLDmAhOGp/lZ9yE5VY7gE1bCykncwvblk6l9QuC9X
fPYWdX6juy9GMMTcMVRyPojqI87AQ0/8/wNo4gPirl/B5Dd9Co7iExwWDmOLxPw5
a7ddRO2vZtowXdwfnKa3kMl/BY/GVSl1BveULOCiqQphB19siW68OROHgPQyDVEn
K1NowlyYiJkKqievI1RDhyHiOqwrniY+QIjDS2Umoka/PW+/dykRF2mvrGbkST1E
tDs2HQKZUwjffJxMKPKbyP37yM1v8XgmSTq8dy8WU3BQub+eGQS/SO+jINwv2kKx
v7DXLjDwH51s1Oxx01Rc14JvWpTRYQ==
=HUz0
-----END PGP SIGNATURE-----

--/vYbwmcb+QbC4fzk--

