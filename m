Return-Path: <linux-pm+bounces-9257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9A9909F54
	for <lists+linux-pm@lfdr.de>; Sun, 16 Jun 2024 20:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001661F22F87
	for <lists+linux-pm@lfdr.de>; Sun, 16 Jun 2024 18:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2102E46447;
	Sun, 16 Jun 2024 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coDx3fTC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70611C2A5;
	Sun, 16 Jun 2024 18:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718563791; cv=none; b=olkF2yzwmXB3xJNfFSM0Ox0kVNY/KxIlsSPQOk3uYnwkR9vHaEO0kZnS+CdjUwvyoMEGqTq+caDdIpMC9LVQrFa4vnJVGMx8/JUwZw/WUbGoXQKUh/XCtt/jbB5QKM5/3nhSShp7m7cvi/s/tcSaTHWHADl3VWuwp3fFwMhoXaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718563791; c=relaxed/simple;
	bh=osjHdpENVIPZkE6xIPy2V4BuG0sO5GBaRhifuE5x2O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goSxK1S8naC00aieWRlZwOH3S1DIehCsvMjhg6hQSLDYN4DS0PmeNgec6H1vrB0Giie6DqL2fR22bhm7+4pNEIOUzt04ZvmwkAeoGEv4nu1KoZ+IopU8Ndii0Hk/h2/KE1cjS/9he4BfdHhjKpKeUaqO5J0jS16JmqfZB0UTHEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coDx3fTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF56C2BBFC;
	Sun, 16 Jun 2024 18:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718563790;
	bh=osjHdpENVIPZkE6xIPy2V4BuG0sO5GBaRhifuE5x2O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=coDx3fTCDyHCwcx4phLEdKPE4EnO0+r5shya/UDwFe1tr2yNK3DD5+11me8gnjfCo
	 gcgxjn1nhU11+GPNDlr70AY4FsCrONmAuiz2j8aTXJdQbIHEw7/IF/cnHnan8oigXy
	 tvq9Y/l6Ls0ceOSLpTlOmbdCRh68+btlPNA2k4EMVCSGTLrHAurqhFLet/O9WE3ewA
	 ULmnLzGKFayh2LHgHDLw2ANYsfHGD5rv6QbpyeYy91sjm5K5YywxT3CpwHu0T8N3EE
	 FB5mtdDSfIDYwlg1L/vpD0Dt4nRhV1TbTtB3DeC2Xgpm2Z/P2OyDdyPM5d7b0emAHE
	 c6dz3vR4/Ppkg==
Date: Sun, 16 Jun 2024 19:49:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Guillaume La Roque <glaroque@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Anson Huang <Anson.Huang@nxp.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Heiko Stuebner <heiko@sntech.de>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Pascal Paillet <p.paillet@foss.st.com>, Keerthy <j-keerthy@ti.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-sunxi@lists.linux.dev, imx@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 00/22] dt-bindings: thermal: few cleanups
Message-ID: <20240616-immovably-washboard-5eff43888e6f@spud>
References: <20240614-dt-bindings-thermal-allof-v1-0-30b25a6ae24e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kOA5/bYAEVq+jUn/"
Content-Disposition: inline
In-Reply-To: <20240614-dt-bindings-thermal-allof-v1-0-30b25a6ae24e@linaro.org>


--kOA5/bYAEVq+jUn/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 11:45:59AM +0200, Krzysztof Kozlowski wrote:
>=20
> Few cleanups witout practical impact, except maybe the Amlogic schema
> (bringing required cells).

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--kOA5/bYAEVq+jUn/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZm8zwgAKCRB4tDGHoIJi
0ttlAQCXZrCE/f+fR0kZEWAkq+YZfRQhwyqkNPYsIPr3O9xqAAD+NmeiOYPzL4/8
zTg9dNEipYzGNeR396Pg5r09PcUJDQM=
=AUoM
-----END PGP SIGNATURE-----

--kOA5/bYAEVq+jUn/--

