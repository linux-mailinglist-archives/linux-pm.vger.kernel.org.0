Return-Path: <linux-pm+bounces-12755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C8695BC4B
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 18:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873591C23669
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 16:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5451CDA27;
	Thu, 22 Aug 2024 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvxWs3Tq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1FA19995D;
	Thu, 22 Aug 2024 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345182; cv=none; b=LueaASm+e/tzkIuV/yTG2TMlPlOtVgQJ6ACqAh35QoqUcE/wQCxFx0xwogijbLwrSOdLzW2MHTpYgCL+jKzzabOB5HpDOaoZOnbY0dE/UTH7/x6GTtuZ6z0lHUpe/NpUxYZUUS7h4y8K2sKp7bRyv9atKe8leEZrKdhXx/HQASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345182; c=relaxed/simple;
	bh=at2jGYed94rBd41ln5QjqjDRA9cbMcgERaHl5UP9H88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3lig7Zww42NaOPS1XP+20Fc/rirg8igCPO6HIOhqjQpiAFxzjJN85iMxNjaPaLh5e2oKUVl24K2e2R1pbUmdb5zl7WNQTF+Q6DnXBw3CwUh89zopNKLeQppiksNTya2B/mtBVxMRWLezEFesSscy/wy5rdfeK+gSGSnyuiWHVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvxWs3Tq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A083AC4AF0B;
	Thu, 22 Aug 2024 16:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724345182;
	bh=at2jGYed94rBd41ln5QjqjDRA9cbMcgERaHl5UP9H88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GvxWs3Tq4IT0UVfWQiSFtzytZ94M0iLcK4Wgkz5Xmr2vOTGsVf2NR5mBrLtTSTeiW
	 WdDum80RaXSldqLfPyKs4yfYjMqfBiiIgxXLNTgOy/AU2fTqUBKZUbe6yKBedy9ayq
	 Sytb8FozfLXBUKvLhIe/v3pfw2iZsnDIMhwzozIFX+FBkNa8lVLjYRwxErH4UbjqaK
	 rCvnPzHK/KXg1fCuALp2Xfcaz7czlAHguqtgQJR7jj0Xpbmb8R6DCFwQiCJaOjanlX
	 lexCshb2deERus9lTlgrIlV+3hp9F7nDU+Klum4ZixyOrWSOtYuzse7pwmwhniwg4H
	 f69gq5K570aaA==
Date: Thu, 22 Aug 2024 17:46:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	gregkh@linuxfoundation.org, mturquette@baylibre.com,
	sboyd@kernel.org, yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com, ulf.hansson@linaro.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 09/16] dt-bindings: usb: renesas,usbhs: Document RZ/G3S
 SoC
Message-ID: <20240822-encrypt-putdown-cc8770aa781d@spud>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-10-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5UGYhxQz8p7q9/9a"
Content-Disposition: inline
In-Reply-To: <20240822152801.602318-10-claudiu.beznea.uj@bp.renesas.com>


--5UGYhxQz8p7q9/9a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 06:27:54PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The USBHS IP block on RZ/G3S SoC is identitcal to the one found on the
> RZ/G2L device. Document the RZ/G3S USBHS IP block.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--5UGYhxQz8p7q9/9a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsdrVwAKCRB4tDGHoIJi
0qBlAQCdmgDx2vSq44d6AZcY/EME/mmHOP2w0IAW97mAF6MKJQEA7fBLbHgGSw8b
n5k//O/k2RK4u2MfswfPY9B40HEOUwM=
=L2pF
-----END PGP SIGNATURE-----

--5UGYhxQz8p7q9/9a--

