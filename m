Return-Path: <linux-pm+bounces-2664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A00A83A6DA
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 11:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF55C1C20D94
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 10:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C3B6130;
	Wed, 24 Jan 2024 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNWRQZyO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37715CA69;
	Wed, 24 Jan 2024 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092390; cv=none; b=IQbjjWe6HXer5lE7XkKgMxw6xf49ibT+W9rS7gicRAy5DHm0k49YFkIJ7cMlFu6wGPMzs/zgoegOC06eSOSL9LJBISg4S1dsaHvKpTN0i2PU2eY3ym41G1RlPGf3AkCVhpdmkFsVWUwHFL51yF/UkCK6gO9zPYnKJaDJ0PUocEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092390; c=relaxed/simple;
	bh=QD7I+J4Pf8NtWbUrntxxfjNeIlISBQDWP+H6sxsWVZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VthNXRdB9zfDrdkrtuSZFmpzI3q7Q76xN4iRR1DDvHIAQVwEM9XGrN13jj0Qx3KHKrMuKU29r0tQJjb8C/jsnD3qbAbDgkzBLjRrwaYZfqTzD6hjaKAC8bQJBXRJLzyS01yxZPu6toNh3qGccVpyI3o5z+cI1h3qtHH0wbSjf/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNWRQZyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29668C433F1;
	Wed, 24 Jan 2024 10:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706092388;
	bh=QD7I+J4Pf8NtWbUrntxxfjNeIlISBQDWP+H6sxsWVZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNWRQZyOatwXlBGQvJDsDVJ34Le/H3AxtH/5MDbRKQrDFc6asgcuDrP21wT4Xca2h
	 ZpOIHK7ecnO6r8ERQL4HLej4pAKEZkuqj/kZBeKEFz9Eblr+SNlCEZT211l3rSmMD+
	 xWnB2ELNM5qd1AsjupKnzMWT+3yIuACEO1M45ySTroAH5+pFTLLaqauG1A53qgFRrU
	 yyjXS+/QnDt5byUFx3wG13ulE0AMkK0duU0gyRU04hgPG7pkI8iukDQ5hyn8iX2SQn
	 vAV6DPKmPY0QQnBVgb4q1vycZ7tBCLJZpCMTjLJEBrsmv85Dac2aWYTl8W5GXmnsGN
	 fSTXODTkmo98A==
Date: Wed, 24 Jan 2024 11:33:05 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
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
Subject: Re: [PATCH 02/15] dt-bindings: clock: Add R8A779H0 V4M CPG Core
 Clock Definitions
Message-ID: <ZbDnYf7x8sHd6bG7@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
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
 <2e083461752c9d52fdb251ad9071f6111f13c3c5.1704726960.git.geert+renesas@glider.be>
 <ca0cb671-43ce-4bda-aad5-da38bace4132@linaro.org>
 <CAMuHMdUJYH7YhQ65Bh1K8F2earTM60VwBd2=LH2vnGbaGPU53w@mail.gmail.com>
 <f354cfe1-88eb-4daf-aea3-7acd2de5d106@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JHmIAnmx0irpJ8zR"
Content-Disposition: inline
In-Reply-To: <f354cfe1-88eb-4daf-aea3-7acd2de5d106@linaro.org>


--JHmIAnmx0irpJ8zR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > For new bindings, or also for existing ones?
> > Doing the former means there are inconsistencies among different SoCs
> > in the same family.
>=20
> For the new ones. It's just naming inconsistency which does not cause
> any issues. Otherwise you never move to vendor,device.h format... which
> is not that critical, but in the long term brings uniformity.

I haven't reviewed the patch itself, but for the naming scheme I'd
suggest to follow Krzysztof's suggestion. If he is OK with this level of
uniformity, then all is good, I'd say. Converting existing ones sounds
more messy to me.


--JHmIAnmx0irpJ8zR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmWw52EACgkQFA3kzBSg
Kbayqg//U3URnhB+/r6yDwETdfY9sdnsq0CxUPhFVLCcdNNoIvT4Jr8IBmQcL4Wm
+9hwQxqN9NyjgFJLHxP7bap9G5yJEGP3Wl9Ca7e9HTQfgvfGIdCrmJW/6nTm7G9s
P3v9Gx+vnthNdHFTu2ufapgk34pN99A0aa6jDozVDLqxn8cKWAIFTGUv/djRlJEk
fm+L1nH+l6UZfLXHha5Wz5uM4RzGk1OqWW8wSaYe9Rc06ZX6v86saOyfOy8OiuPX
xyyO970ozg+Uiv9UqFTPV6shuye6HkIR3SJvL4F1qsPQswT4iMTm6f2Cy6UG9ADZ
zoqXLtFFeddDwRiVjsbjf4xX1ni/Qo5HYueYNsoHue2o2YZG3w/ZKi6Ev/zgdmZP
QNQ8zS2IpSo6IIQcbStYtEtVkatu0WgaKrjgXAxHgkL2LEaGGScwyGTrUvkneufD
XttcM6/Ny6jZxjgWg5o6X5ge6Bo0bLxV/VnMhuZvr5YVS8N8HZq78cQV8lyzLjJO
zM5Vyc6myAeOVxTUlU2EG97p1lRiOe9ooXDlFAUl/eIDcmuEE/14eGcVA5kjnKOp
fgWnQ4ASq/U1SpNjte5xkQjbU4KNLG9wQ3xhmtiWF3bk4+9ioExplCQxkWNft/EF
XGhEiUi5ICVj0KG+ezC3BkM9u6cjlbT4j68wvB9owProSTIJiak=
=HrJ+
-----END PGP SIGNATURE-----

--JHmIAnmx0irpJ8zR--

