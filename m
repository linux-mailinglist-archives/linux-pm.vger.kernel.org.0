Return-Path: <linux-pm+bounces-16252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA6B9AB40E
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 18:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E41283955
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 16:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71B71BB6B3;
	Tue, 22 Oct 2024 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXREBZhn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E8D19AA53;
	Tue, 22 Oct 2024 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614680; cv=none; b=dzcQBo+NtVD1/pEPOLubAdKZOgs5e0KBqiwM7J08MK1rc++j/6ByMFhd73JkDxzZ8TTGL2Z/vPYeLDP4wXOUIGsGnavJlzNek6YuJxV3pvLke4P+dxJRXof73mjycJPJpwS0eNauouvWaI3cagvtzVAncKWDgnkpA7J6v5dHBZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614680; c=relaxed/simple;
	bh=KVLjpT7ZX9iWAD/24xl4Rm7ljfOUWX5ZNEqXbQPnM3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlYzZRtSP9FDL0ScAS9yTbnND3vj71lyWk3h9Vld4k5PalFe+fU+xT4ANqNEjr6ygMnXI2/VbM/7NjiLzxh7lisb7p/Fr76NLH3Hcfoo6n1c1WSlOMqUC++2XnaAlI9Zw2YhmnAk3i6AmSqS1er+j0inBrPuuQtgU2DVaUVmd/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXREBZhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9B1C4CEC3;
	Tue, 22 Oct 2024 16:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729614679;
	bh=KVLjpT7ZX9iWAD/24xl4Rm7ljfOUWX5ZNEqXbQPnM3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dXREBZhnbOCRyRJEiURpCXE06H6GgDVmaDwtKIv+czCXlz1h/52ulbmftS6fG+Tnx
	 dCqMNvASD8vVoYHQuGjLuqnhuKgGT8YDa0kOiJrDe35i2qr8Xh7/WrZmIU/bQIj1Ja
	 u30hBzV0fpl90CzpENJ2z/BI6VyMbl71Yerxkvgzd8zsB2t35BZoH4heOmmCy9BY8Q
	 0x7oCYfVw9yi5tpbQnalxiSW58VaD+NMdTcur4P28wR9wzlnUBUAaesH5UAqDhbsnn
	 XyVe6/bHCA3EvoAZYBCp7ayqhIy3gaKahLp8UPxoMAOTZ5y32gz4Kr5ULC1fgxFVw+
	 XBDrdYm83U25Q==
Date: Tue, 22 Oct 2024 17:31:10 +0100
From: Mark Brown <broonie@kernel.org>
To: Yassine Oudjana <yassine.oudjana@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	jason-ch chen <Jason-ch.Chen@mediatek.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	Flora Fu <flora.fu@mediatek.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 5/6] regulator: Add driver for MediaTek MT6328 PMIC
 regulators
Message-ID: <8b4814d7-15da-4c0d-8d6d-0707a8c2eb74@sirena.org.uk>
References: <20241018081050.23592-1-y.oudjana@protonmail.com>
 <20241018081050.23592-6-y.oudjana@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="33tXnPvbLYFDgAR7"
Content-Disposition: inline
In-Reply-To: <20241018081050.23592-6-y.oudjana@protonmail.com>
X-Cookie: Surprise due today.  Also the rent.


--33tXnPvbLYFDgAR7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2024 at 11:10:47AM +0300, Yassine Oudjana wrote:

> +static int mt6328_ldo_table_set_mode(struct regulator_dev *rdev, unsigned int mode)
> +{
> +	int ret, val = 0;
> +	struct mt6328_regulator_info *info = rdev_get_drvdata(rdev);
> +
> +	if (!info->modeset_mask) {
> +		dev_err(&rdev->dev, "regulator %s doesn't support set_mode\n",
> +			info->desc.name);
> +		return -EINVAL;
> +	}

If the regulator doesn't support setting modes it shouldn't have any
mode operations, then the core will take care of handling things
appropriately.

Otherwise this looks good.

--33tXnPvbLYFDgAR7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcX000ACgkQJNaLcl1U
h9Ce+wf/ZIulqT3K3IhJ+KVWRcq3tjdhPl/Mej1+R59I03LxzaQpb8o43HQxSAxe
SU0os389dSUkyF+kdhdT9f6YnIbW+vKIYPS38wU/5vfJN83xndKz8fBXDIxypF+W
p9CnJwD0oQdITaqwTv3R5hfguCOZjh4YZLOgF4lLnhrxE5n3xHTAd3xaDK8gFhDb
3igU5G1wWXv1t4bo88lF+fVeV/UvAllmm/cMimxvkDXpC+0rVwyVE+TMXZ6+70j0
HzjxF8MNukQREubLvlekRPkCKzcNJ69HTiMYsDNN8YEf2YNWgbfzTJIap31+vm1U
wiwCOzsm/3hF/CDv5/gVqprY892Ehw==
=zs8D
-----END PGP SIGNATURE-----

--33tXnPvbLYFDgAR7--

