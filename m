Return-Path: <linux-pm+bounces-2666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF0083A6E4
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 11:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC5C1C21B10
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 10:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E60CA71;
	Wed, 24 Jan 2024 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxWDgCKi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26835FBFD;
	Wed, 24 Jan 2024 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092513; cv=none; b=gIEy2h5PNVC8DAWLCaBMVaOtSbd1S40cpweqYEzq5VGpwLujiX4HxmtYKCaXAuWCKk4bbugdc5EY+hGZJe0XiNRulFEJyqjYairteZrI2yRnHa/29PtHQA4D5WRwQ17+MUxtU+iFEO5BOGjYg5xSJUCRA1MeQNpF14KTafBDEwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092513; c=relaxed/simple;
	bh=YKiOt4RPcE1+0/nw8KrfU0BwLstTDoGL0RMIhRE8eVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWJ6ZPyCfppAdt4WjWan0jE2uxc1WNc0JkwTwf8qTQP5vV0IIFUBpHeeaXAdiuMxZkUvA+nsPOXP6DhhGtHZmECW0LUYmIetbR91+9xWS5tvw7br1DToE6RzKvcaXydqmFHbb8Cy1WwSks0g+GQ2EgXmpBYedolQTTXGrOZRD9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxWDgCKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03E2C43390;
	Wed, 24 Jan 2024 10:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706092512;
	bh=YKiOt4RPcE1+0/nw8KrfU0BwLstTDoGL0RMIhRE8eVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IxWDgCKipxCwb4IXxEf2J3XbPKsCvbzwKlQQ3dxU/oLF3VlkFjOnwCSymsAyLTEML
	 Cc5mchTAhhBKo6AABALdYpN+mtJHNtMiWFflHIWZnVQpZmLkL3QdCSm3kUyQHp810W
	 rbS7pLI/N07tTImVrJcr+e9wAokZdwcdXS0DNs+YxXnUHAgW4Mrm5vR6FzBfTxt0Oa
	 yJZTReY+tAwEvVnxQGjukRCUdTKIlMQZL8g6ZKuMn3cl4VCSUdRkfWdvNRmTrvUB4T
	 Nf+HUPhDl1OPmuWPnV3FDzOOjEFqbwP7DaUfktANsw9dQfJ5MRxuTHiQ88jssc6EvL
	 /ZYpA6qXligGw==
Date: Wed, 24 Jan 2024 11:35:09 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
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
Subject: Re: [PATCH 03/15] dt-bindings: power: renesas,rcar-sysc: Document
 R-Car V4M support
Message-ID: <ZbDn3aJX3vpmKGCE@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Conor Dooley <conor@kernel.org>,
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
 <1196419f3ade9a27b3c7906b6a898376b817601d.1704726960.git.geert+renesas@glider.be>
 <20240108-usual-opacity-4257f2e55107@spud>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hXTrRqJ6f27YOBe+"
Content-Disposition: inline
In-Reply-To: <20240108-usual-opacity-4257f2e55107@spud>


--hXTrRqJ6f27YOBe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >        - renesas,r8a779g0-sysc # R-Car V4H
> > +      - renesas,r8a779h0-sysc # R-Car V4M
>=20
> I like that the g0 is the v4h and the h0 is a v4m. Makes complete sense
> to me!

Hey, at least the number is constantly increasing! Well, mostly... ;)


--hXTrRqJ6f27YOBe+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmWw590ACgkQFA3kzBSg
KbaENg/7Bux37kSDJC7i7LLUEIT2NVX4R1I7bGEO7PnzPpGQkFfcdI3YKYbH2nJI
kJs5YVt7GYS7VjGFNtRy7i5WOFsM8UekgP1pvPih9s8gK3G8Kyj5SCdo7I287GfR
a/qJTzPMQRAdFjBBjYhmiPBHTXwNbGEEIg0bOs61FblK1wuPEAbb+Kc6cByePtoW
MOjV6Xyq60LQnxYiV6hk6u1+13nshT9zsMMy0LpqauPsHmTHdbVVU1Eih4ktWKtj
ch5PyjG02u/gSFsObgAbFHTw5RK8cWjNb7kHNqLtbOVnZV6bbMCyVzqHDxnRsqPh
6Uqz3MWNADh5wpd0frmFCyjJoN/mc9H89bq78dq33u+Yv+hhpWZbp13ZFz6wJjE/
APcEw0GKISe1LCxQwC62CVEGFmNsc20+3krn+tSVgD1Kt/W7nS6x2N9068o+7pwc
XA7zR/q++h6nMeayMRSDIqrqj3LmZOWEHLprD//9jQ+00GE/07yPTOcOT73vQm1v
s2QGXiRPPpsm7bN5Vq2ncREmOzTBfsp3EWmxI3HtGqKksRve9hge9Vk9Iv0Qlw1m
NbcmFDgHydgde3si03TBoE7Jj2vQuZ5X6s7P9DiN4S25SV17RPhMqKWf1BrKN9XD
PFjFza8cC62fK4FqQJmdbeC2X+CE6YdU6GET2YmlIOuu7IKqjWo=
=HcJZ
-----END PGP SIGNATURE-----

--hXTrRqJ6f27YOBe+--

