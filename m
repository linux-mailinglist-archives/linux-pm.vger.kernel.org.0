Return-Path: <linux-pm+bounces-39418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CD0CB37CC
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 17:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C85F3112708
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 16:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AEC30F52A;
	Wed, 10 Dec 2025 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZC5I9VH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909503B8D68;
	Wed, 10 Dec 2025 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765384430; cv=none; b=EJ1/DenI9sGrNfsaU0us/0wiJ+OjoHYmHnZc+MBKTGcZuQVl6tXPpBx6tX6Q7AkQ1NJs/UCp+JY7AGqx4Ke10ZLCNJHPdGAQ/70HPIc2yjdawgzf86DW1Z0nknuVa9F+XP3oGeTOLkjsp9JKJ1h0bUA1Y1gw57wEyc0euvjngAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765384430; c=relaxed/simple;
	bh=RAVkpptHG6oJO9hSoLDzB0Os+BfA+qYSejoiWrxKU4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMaY/0u7hczkhzBXnOmnxcPVo8OERvNOy75H1g+lnmYX3rS4Zel/DkRTbgA7mFRHQ0m56/t1SSG2zYh5Yde9Gi7fODbv5aZA45rWHq2nCmYOMfVjXlZwCqZKRwkpiCbNjVDfjujHtpbCcCGdpxcUi7aTp3bO6JqHKlnaEm+Vgzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZC5I9VH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3253CC4CEF1;
	Wed, 10 Dec 2025 16:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765384430;
	bh=RAVkpptHG6oJO9hSoLDzB0Os+BfA+qYSejoiWrxKU4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZC5I9VHWyMXJ19/yNiYo6ezpCM8sOhmTUF41m72Jtm2iABVgaS/27p0ZTqrKHh9Z
	 bG0D7vM+v6w9EOFpDUmmi2mR2Ji9klQGmuoEEXdKT5sH0LKV1NfwG5SyCqR+rwBf22
	 3f+xgcZscWmZnVWb0mlWjJ+ro/SQtsRiA3jQjRDuC/qc2XyaggmxLmTS0DwfMaRSmE
	 C5m96GavAQ+CxKaR2ahdr0K0iov94ANatToT9spS59SQ6+q9r08QSUAbHCFTuPXNdh
	 aJhFk/5B0+DjpskV68Wmb2QqHCarNXOW4Z8+UUSbyglElBaHthmaEo+PNHTbBeOO8u
	 U6553F6TADWJA==
Date: Wed, 10 Dec 2025 16:33:43 +0000
From: Conor Dooley <conor@kernel.org>
To: Irving-CH Lin =?utf-8?B?KOael+W7uuW8mCk=?= <Irving-CH.Lin@mediatek.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	Sirius Wang =?utf-8?B?KOeOi+eak+aYsSk=?= <Sirius.Wang@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Vince-WL Liu =?utf-8?B?KOWKieaWh+m+jSk=?= <Vince-WL.Liu@mediatek.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	Jh Hsu =?utf-8?B?KOioseW4jOWtnCk=?= <Jh.Hsu@mediatek.com>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"sboyd@kernel.org" <sboyd@kernel.org>,
	Qiqi Wang =?utf-8?B?KOeOi+eQpueQpik=?= <Qiqi.Wang@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 01/21] dt-bindings: clock: mediatek: Add MT8189 clock
 definitions
Message-ID: <20251210-progress-overdue-bded69c47048@spud>
References: <20251106124330.1145600-1-irving-ch.lin@mediatek.com>
 <20251106124330.1145600-2-irving-ch.lin@mediatek.com>
 <20251106-hug-stingray-2d3ff42fd365@spud>
 <626b5c4b810678a7f0de1f109371a6d6694bd2a8.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6/aPeWQhkTkgoOqT"
Content-Disposition: inline
In-Reply-To: <626b5c4b810678a7f0de1f109371a6d6694bd2a8.camel@mediatek.com>


--6/aPeWQhkTkgoOqT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 10:01:24AM +0000, Irving-CH Lin (=E6=9E=97=E5=BB=BA=
=E5=BC=98) wrote:
> Hi Conor,
>=20
> On Thu, 2025-11-06 at 17:19 +0000, Conor Dooley wrote:
> > On Thu, Nov 06, 2025 at 08:41:46PM +0800, irving.ch.lin wrote:
> > > From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> > >=20
> > > Add device tree bindings for the clock of MediaTek MT8189 SoC.
> > >=20
> > > Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> >=20
> > Before I approve this, can you share the dts that actually uses it?
> > This many different syscons really does look suspect, and that not
> > all
> > of these should be nodes of their own. They may very well be, I would
> > just like to see what the dts looks like. Doesn't need to be a patch,
> > a
> > link to your tree will suffice.
> >=20
> > Cheers,
> > Conor.
> >=20
> https://patchwork.kernel.org/project/linux-mediatek/patch/20251111070031.=
305281-10-jh.hsu@mediatek.com/
> Please refer to link for mt8189 dts.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--6/aPeWQhkTkgoOqT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaTmg5wAKCRB4tDGHoIJi
0gQLAQDlf0YH1hYoXc9Bdh1D48xuvf9j1Xm/38X050i72dQjuAEA3Ycuor/nuZxO
KtGQq2Rg+DlffLIgFceLi1KapRxZVQo=
=RQBU
-----END PGP SIGNATURE-----

--6/aPeWQhkTkgoOqT--

