Return-Path: <linux-pm+bounces-14514-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9875497D53D
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 14:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B9B1F24586
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 12:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865DD14A636;
	Fri, 20 Sep 2024 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jF53a+nN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414D313B2B0;
	Fri, 20 Sep 2024 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726834138; cv=none; b=WfPdV8jxjOU0I9gIsTMqyz98PUCXrimnhDEVOWTpqgp+tCWI0fGobcH3UOAyRaY2EGRHo8HCj/DYzKVlOwBhL4x8uW+UHaLK47OU3VZgnpo/ZHwi+hjuf6ZbTph6ocs8Ono9se9ITKx90+D8XF5/HQt1d6Evaet7SUgc5kFVlIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726834138; c=relaxed/simple;
	bh=Dveo4hxEkYa0QfM+j/lxJ05ymd8w4pLl6DdgOtEoiLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3jtx32ST7AmDso8uf7FPhduIp9X/QVo16WEEuDPTcEB1av5nazcnr0YQ/2NjWu8daDgi/eFyfN4AcphPG4mAdpqzj+gtSGa7xWskQ88Dou8OOkNsGzWJHU0W7kwzmBhE4Ybf5ACxLNzReVJIOB4AycQp1cv7SSk4cBtZwbrHd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jF53a+nN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78E8C4CEC3;
	Fri, 20 Sep 2024 12:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726834137;
	bh=Dveo4hxEkYa0QfM+j/lxJ05ymd8w4pLl6DdgOtEoiLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jF53a+nNNaE4e1rFkQxXGSP2HCmw0KAgztnLogKOJM241gdQCkwZzetbpk40xcHfU
	 i8kGbn3aIMAsyVE6uWJdj5s+Vwif+vST8JbsqSjvqeQZjj2f0l7HaO+3wimcQgF6nq
	 4UEKLXtMvGcWT9IJaOO3Lj5b4Nupjk+c81awNXvESu4O/VWKXzS3jj/0q24+WAImgE
	 wc1nhLAqRS4JAnOtYuEcZOP0KdNNiHWm4Fh9iPFEd5L6HCjA1FaKrY5U+BDZ/9Ogeb
	 ep943ptCeoVmm7ri/L43JI2LaRpnV2BhHhmLUCz+7sUtapO/l1KZWjL/eAASKjH11W
	 6qm95xrR9H77w==
Date: Fri, 20 Sep 2024 14:08:53 +0200
From: Mark Brown <broonie@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Sen Chu <sen.chu@mediatek.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-sound@vger.kernel.org,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v6 1/2] regulator: dt-bindings: mt6323: Convert to DT
 schema
Message-ID: <Zu1l1Tx7OeJ_Sw9z@finisterre.sirena.org.uk>
References: <20240918064955.6518-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WEu7YOiBPgD/ryln"
Content-Disposition: inline
In-Reply-To: <20240918064955.6518-1-macpaul.lin@mediatek.com>
X-Cookie: Editing is a rewording activity.


--WEu7YOiBPgD/ryln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 18, 2024 at 02:49:54PM +0800, Macpaul Lin wrote:
> Convert the MT6323 regulator binding from the old text-based format to
> the new DT schema style. The property "regulator-name" has been added
> as required property to reflect current usage in mt6323.dtsi.

Acked-by: Mark Brown <broonie@kernel.org>

--WEu7YOiBPgD/ryln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbtZdIACgkQJNaLcl1U
h9D6ngf/VZ7i9q1LeXU8VJ3HxrkMAX0WECwtWNu9qZxhaPiMOepEhNtSpPFkUAn+
++QnnA56FwzRbteydQ8KQAO5odIeuPue/fBbFYOyugnXuASOUrKPo9DrK0ndH3Tt
gL3J5neZq38dtz5E0/+lvB5V0OfzVOG0h19AaHiY9dsompN0NpZfiQteFhuJb/nm
o3Y5qYJc2fJg1fEUr+bW36AgyYutLsaCvL5Vqxp9B7kpxtkvnZTeLGM+NJtqMwCp
elPRl6clsrLyQQk1LrPLLGBqrrmsXoeUVRgpQccT5Bl2q5iNdEGZw81W7Dv+hv7c
232TH+zLfaBTiYpzLFHcD8BysoeOug==
=j0pA
-----END PGP SIGNATURE-----

--WEu7YOiBPgD/ryln--

