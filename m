Return-Path: <linux-pm+bounces-2676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C46983A73F
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 11:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC111C2283F
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 10:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57A51AAA9;
	Wed, 24 Jan 2024 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6QjzuYR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F531A702;
	Wed, 24 Jan 2024 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706093574; cv=none; b=XFpW1kjVaUYYeG0MEZiRpCnBEFs4IC45J/lLbp983pfRVQ6nBJRPShgDa/W8wJCiCg9fewt6T2+i5Z8sHITyTFOYWp1gyWi1J/E91pbkLy+Puvg0QijwKu9Own4CJ524eslpGPVcFQFzK22ZLbo1JTpD/qt66YfovuzBtJYvl24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706093574; c=relaxed/simple;
	bh=Uzs+O7o19StJ6CqigcycPyzMhwU2e+vJB0oP/LRpLPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tt54ANtVEwdB3sUBE76SqgVXawNsMQJndY15TL4dJA+E2h0TrSQyyYJBC0uOL8UfXOOHc0I2vJN632QSPQO1PSIDSXnwtZ46o5FGgs671YyeGCVwhMztzcsjktZHljdDl3p4n76Oo/6/qHS4q9bLyVhUBsBKbhRnlc3GQFsWAbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6QjzuYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87727C433C7;
	Wed, 24 Jan 2024 10:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706093574;
	bh=Uzs+O7o19StJ6CqigcycPyzMhwU2e+vJB0oP/LRpLPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k6QjzuYRBbr7l/ZDEaUu7i/aFaguiRliv1vuZazw9kHFJdPQ/yKN5oS5Jxo23VugH
	 505EFDfgTTKaM+nUOIeAJ6q1nLTuPnGgq5/9VNq4AZihVRvvz0XSwEwk6fi1HMvsYt
	 PZaeHcm7JE81fpoh1izQ13rVYYnIR0xiUzp5knw8FozFP4mligTTtrRJ4ejaWoEFC7
	 99igB3iJ0ytBKYxRkBvjPuUWtUUdzRHuRxgSg7izDQo9MuK3d71lp4F1ms7TtmqAz/
	 zCtdR4uSiwV/tEHSzk/9agu3J83S3qnnxkhfjKVZS+xmrkvskaAZ01/G92iiAPJ8jS
	 V2JHmT+pNBVWA==
Date: Wed, 24 Jan 2024 11:52:50 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Cong Dang <cong.dang.xn@renesas.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Hai Pham <hai.pham.ud@renesas.com>,
	Linh Phung <linh.phung.jy@renesas.com>,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 14/15] arm64: dts: renesas: Add Gray Hawk Single board
 support
Message-ID: <ZbDsAmxZSvv7n2hL@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Cong Dang <cong.dang.xn@renesas.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Hai Pham <hai.pham.ud@renesas.com>,
	Linh Phung <linh.phung.jy@renesas.com>,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
References: <cover.1704726960.git.geert+renesas@glider.be>
 <3ba3eae34719e6141ab04077586c9ebd849a0346.1704726960.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BOSOlrlg4mcljAvo"
Content-Disposition: inline
In-Reply-To: <3ba3eae34719e6141ab04077586c9ebd849a0346.1704726960.git.geert+renesas@glider.be>


--BOSOlrlg4mcljAvo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 04:33:53PM +0100, Geert Uytterhoeven wrote:
> Add initial support for the Renesas Gray Hawk Single board, which is
> based on the R-Car V4M (R8A779H0) SoC:
>   - Memory,
>   - Crystal oscillators,
>   - Serial console.
>=20
> Based on the White Hawk Single DTS, and on a patch for the Gray Hawk
> board stack in the BSP by Hai Pham.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> An alternative naming candidate would be "r8a779h0-gray-hawk-s.dts".

As said in another patch, I like the current naming.

> As the Gray Hawk and White Hawk board stacks share all boards except for
> the CPU board, we might be able to reuse white-hawk-common.dtsi[1] once
> all needed SoC support has been added to r8a779h0.dtsi.

Sounds great.

> [1] "[PATCH/RFC 0/7] arm64: dts: renesas: Add support for more R-Car V4H
>      and White Hawk variants"
>     https://lore.kernel.org/all/cover.1702309604.git.geert+renesas@glider=
=2Ebe

I will check it next.


--BOSOlrlg4mcljAvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmWw7AIACgkQFA3kzBSg
KbZe4w/9HQlQnF9BV8RuM6krBego5+iWmlK9IfE49+qry5el0Q+mwC7Rc1xPwVt8
r6CxMEHXyzKSMcg6Nb4xQpnAGuTWXz7A6uOD2i1yZ+8Auy3Y+YN9/EcorCbkbcf0
bRfEZ+i/zMmqmFA1OGMv9FO3oF2qJgUfedNB84jMNBDOFd9R3B/sm1d49S/ZaYvN
fHj19JW45cTUPAxALO2S+GkKFWbICMOzdYBlj5DgM6jKfij9gbwcFE5eesetwd7v
cH8QXOscmhzJkzFB4Su2J7ONYWNScfeEakBSBq/d4zvYSGh64kQWwi+bXUEe2bCw
+d+LXKq9LvylJIF1BCWXz67s5tDOc6wyzrvFrzY6hObPtiIowY7cvHEcIEzw/wzK
s9L+MeAsBlbZXLw/vLSfiyOHmxqSC0TDEfU9qXWnu4UqLIVO6erHK+qAN9L4wUry
P3b78V8B/xDplFQHpjXIw/g3L7RLkLpILGkwb+AAODXU4x2XpkALGVfaUxjjyMwM
q3PjzrATSuz7Hfvrl3zGud9NKHflQTE6DhF7fiFtpWtyB3ebbkCcHihq1xlwt+O+
+E3gnucQLzIDy8zCvgdc/B2jJIW7zGNFsrsD7Nwx6crNJtExygncrLwQMDXA7oGM
yhN+/9178ZhbIIqPH2xUn+D+fuWI06xAZKfcPjAFXN3f8eR7JZY=
=Nqqd
-----END PGP SIGNATURE-----

--BOSOlrlg4mcljAvo--

