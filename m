Return-Path: <linux-pm+bounces-37541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D089BC3CCE1
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 18:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B256504787
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 17:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C642334F27A;
	Thu,  6 Nov 2025 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAsOBwYv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CBF3128AF;
	Thu,  6 Nov 2025 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449468; cv=none; b=SC634XNlmBbJH4TQJ0wwbSPYN2F2D2jFAB6WcY2Vy/jHyx8Pxq8bJjoaD1MIXT2t5OFGKa3lk0j1CRJbIZl0lw9t8D7EMLmaPcuq45vmXMgCYSkXbiC2wUXhMAiz4x3TJMLlqoQr4TrDjKZXaocsnLFjInvpbLlmlD9W/kIJID8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449468; c=relaxed/simple;
	bh=0ScbR3dIWZuGfPd/m1biwfKr5EFkVq/9KvUzKV5rBsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scp647JQr2uG7mNqJErb0ohZFsVl5b1B1AfSxWo0lfVaPCjQmZxZRk9Heu6ubB4Z8h8EcaVw9w4LiX6FoNz1rDLoHjJZyC37qYKTAQod0veJ6GndtBL1wecVhaxS54Gjo8sS1+7GdWBcpM5hO7DVKrHwrdwafbGb0ZNmCT9Td8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAsOBwYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C7FC4CEF7;
	Thu,  6 Nov 2025 17:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762449466;
	bh=0ScbR3dIWZuGfPd/m1biwfKr5EFkVq/9KvUzKV5rBsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAsOBwYvSmiWBMkQvbyIQQUdabHtyWtGNDm2Zs7IuGAanDw185mLPt8Q+b4oaGs/7
	 fwAkld0A+9b7DGUprifrQaeQN6t95BxZwy5DVS0atkInBH7LX40WHQOKiXreAKH2C5
	 2ViTH1EWk9AQKWOXZpSswEQVdYDO3g+x9Wb+seK2w2hgQIHEZM1gOetalL6zwLl9QQ
	 DiE9mCfmPHf2CT5GgBUjyCV2jVh72XIy/+FZubQmI+BG1h3jRx4BcFHYg+iXysgkJ0
	 PzsiQ50lKXdeBvlfl36vkQcn5DLi7oW/qmNzNsbb5w4qoGOx4yG4WMVju/LqjWycEH
	 5RZL8xdsWGE0g==
Date: Thu, 6 Nov 2025 17:17:39 +0000
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "irving.ch.lin" <irving-ch.lin@mediatek.com>,
	linux-kernel@vger.kernel.org, sirius.wang@mediatek.com,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, netdev@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>, jh.hsu@mediatek.com,
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
	Qiqi Wang <qiqi.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Michael Turquette <mturquette@baylibre.com>,
	vince-wl.liu@mediatek.com,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 02/21] dt-bindings: power: mediatek: Add MT8189 power
 domain definitions
Message-ID: <20251106-spearhead-cornmeal-1a03eead6e8a@spud>
References: <20251106124330.1145600-1-irving-ch.lin@mediatek.com>
 <20251106124330.1145600-3-irving-ch.lin@mediatek.com>
 <176243607706.3652517.3944575874711134298.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+Xv0HMX2DI7Xds1A"
Content-Disposition: inline
In-Reply-To: <176243607706.3652517.3944575874711134298.robh@kernel.org>


--+Xv0HMX2DI7Xds1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2025 at 07:34:37AM -0600, Rob Herring (Arm) wrote:
>=20
> On Thu, 06 Nov 2025 20:41:47 +0800, irving.ch.lin wrote:
> > From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> >=20
> > Add device tree bindings for the power domains of MediaTek MT8189 SoC.
> >=20
> > Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> > ---
> >  .../power/mediatek,power-controller.yaml      |  1 +
> >  .../dt-bindings/power/mediatek,mt8189-power.h | 38 +++++++++++++++++++
> >  2 files changed, 39 insertions(+)
> >  create mode 100644 include/dt-bindings/power/mediatek,mt8189-power.h
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/clock/mediatek,mt8189-clock.yaml:25:9=
: [warning] wrong indentation: expected 10 but found 8 (indentation)

pw-bot: changes-requested

--+Xv0HMX2DI7Xds1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQzYMwAKCRB4tDGHoIJi
0nmhAQDiZU8wBW88clHOFWBW6EUlbvwg8hpQsJHRsU0zYUeD8wEAhV9ZSL1yJnwX
Pto0YC70zerSxjKSh9vPW47pcpFiOgg=
=mZSZ
-----END PGP SIGNATURE-----

--+Xv0HMX2DI7Xds1A--

