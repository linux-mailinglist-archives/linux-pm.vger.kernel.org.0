Return-Path: <linux-pm+bounces-2663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D941983A6C6
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 11:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C5D1C21736
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 10:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE3318EAD;
	Wed, 24 Jan 2024 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqa4eB30"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A21718E0F;
	Wed, 24 Jan 2024 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092070; cv=none; b=fu2+/NiLEePZ+1HaPo7CuTEtixSM0x/fTyrhEHLD0MXc0NS5NuuWGY21wv/CyEdRWUXow55rXoAgqIHi4zxWIbVRfHm/J1g258JALvrff8L6VWLn/Dgw5+ErnZxyBX3a4kOL35GSK1T4Og+1t+mV+1nPOa/6TvrC0nTxrWsEc1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092070; c=relaxed/simple;
	bh=S92inZi00uz+wuGQUTNbNoY5aHHy9r48+kk+hMCysvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJIdojeWt7qkb5h9Wlj2inB3W1tyETaOpBdaZg2Z4JI/9HC1WntF8d1x3Gh6hAME8IDQ6jMdtZYCBBzFdneDEK47j5g1arzH70O5tJ9xmSBRfhVSF5ksVDPlbM8+hdNu3VmQIhnRfx0YKAZYhsa0dGfzAqiE+dW60KtL3dV/mXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqa4eB30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1894C433C7;
	Wed, 24 Jan 2024 10:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706092069;
	bh=S92inZi00uz+wuGQUTNbNoY5aHHy9r48+kk+hMCysvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pqa4eB30m4OjoEdb7PRULQhD8pfMgaYjYf5H8MB75pxv6IBCOmyWkDCkP1gckciin
	 GyCOz3WKQ9B94h0nWZ8lBH0JwjhhkmoW3F1riItA73+RSbnrE2uW0rAXt+hC6lz+fs
	 SyvTyw5IwXybRXnxlNpJO+z/RbUHZD/mjg54ixBzoS33zH+rqaFeHWWWPrV++MYfb3
	 ZztWewkQSs1fePhqdL5uqBXs+2vMHlU36lRt6tcqFxV1uKKfkBIx+E0dsYUamVHhd3
	 +2Ro4qVe9LEU7iwVJ7rUKCzPVoaHyjsJ3iri+EjaFEsqBbnADkJPF1sR6hJc0tUuM1
	 7pho4f/usGIzA==
Date: Wed, 24 Jan 2024 11:27:46 +0100
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
Subject: Re: [PATCH 01/15] dt-bindings: clock: renesas,cpg-mssr: Document
 R-Car V4M support
Message-ID: <ZbDmIuQgw5qb0mAo@ninjato>
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
 <81f5a2b55795af06f6fd54b3d566156e91138a17.1704726960.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="81jHtklIqL3RAuAj"
Content-Disposition: inline
In-Reply-To: <81f5a2b55795af06f6fd54b3d566156e91138a17.1704726960.git.geert+renesas@glider.be>


--81jHtklIqL3RAuAj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 04:33:40PM +0100, Geert Uytterhoeven wrote:
> Document support for the Clock Pulse Generator (CPG) and Module Standby
> Software Reset (MSSR) module on the Renesas R-Car V4M (R8A779H0) SoC.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--81jHtklIqL3RAuAj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmWw5iEACgkQFA3kzBSg
KbbzDA/+NpoEprtF4Ugr3QFbO4N2HxwMM60AWBEvn3HwXDi0kSZwxMHdJObgljtn
jGt9hd6KRS/QNjVpnTfzagulRKspbGHUMEwFwjIzNdyGeDQ/ms2TI2YGTguhVy2H
/mpv4/Xw0CjokCAuPgdAzoI42QmV2asVXqc5M847iMAQN6NwoC5edVlFSUoMWcdh
KkmffbmOl+Up/L1f7TgExqg/skUyBEk7Uk8sK0yzRr4bEJNHw9xKQwr6ATSU0GSc
hXl1R/kznVLtUeAVsG1bs1+gdMXJ4v3mZKj0LTRW7TjckrlAWbYOPErnypLFXwri
QDQm405NaN7dhpQ4qHxOfcTXK0Nf1kOYYfGWhw3Gl9ZI4JP18RL7QNJ8yuGWylvV
bnlYWqafeB0GAU4LzzXZR0lXP9DlF8oMV+ITo4lQQeUVMoYHb+yRD9/M69xpzSeA
lm4jwuvMitmDXQ6YU9erW5EP47KH0eggrBLkCRAtoD4iCwxFpBnJ2chEXmWUfcgY
Kep6sdCUhst1PJ9P5zcPzYOPGJltxHXTC28xRm/AEFc0Nw9x+7H44p2YL+nN752G
GBuz7OvNxMNml1XEwmiY+6/2NrvLA4/l7WG3ltjN6XTYldGxH9XGIi6u9YO2T9Vs
+BiTYkbLVtajZDxvRM1n044ljAIHFOv4/HFFyHTfyO9Klxy8RIQ=
=40n0
-----END PGP SIGNATURE-----

--81jHtklIqL3RAuAj--

