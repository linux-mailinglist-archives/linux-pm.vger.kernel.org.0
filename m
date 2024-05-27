Return-Path: <linux-pm+bounces-8191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EC88D095E
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 19:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6829B23B1C
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 17:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFE715A879;
	Mon, 27 May 2024 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5uJoSqx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC8873443;
	Mon, 27 May 2024 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716830942; cv=none; b=cFvXqtyUr4CaAZXirTtTwrK8xbqbBnr1+opBsXVV5nxDJrrI6g5kXWsyGu1XG4VPA5Uh+iQM2MLMt/2qJCJ615x/KK3Iaol4F4/E8RIdMEqfFsK8VBdwOCdbmkHLK2e6pHFNI1nRQWAhGwQR1/8+zX0BUnHtdLAnQKOKb8sQztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716830942; c=relaxed/simple;
	bh=7i3HHxr+FZXrpHZk66CJoa9lBp61kJPFRiR8dLMG28U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGFY6sI1PMwrTMJBP4pM7ZKDNT7DPAciZFkOg6satqjbzh/oNIuFkaCDcTh3G6fhKPfCFgrvBA9d32YsFxBf1GXj0KEsZoUMVwdvMMFRV7ve0PrcnO9/SzcnYIQ8kvRemMQaOX9auYNUfj+kw/qajH8xvrVgEPHGAtT6UXv7Nfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5uJoSqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AB3C2BBFC;
	Mon, 27 May 2024 17:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716830942;
	bh=7i3HHxr+FZXrpHZk66CJoa9lBp61kJPFRiR8dLMG28U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H5uJoSqx3pJ+EzYT62rpf1TlQZ23hQZdtjGFmPN85Nji9cZDtYuv6V+smkqyDa0tC
	 UwAwL4vwO8xLPz9e7trjDNstvhY2tCil6W8FKRJMW7Ey8Bh/f3+rPprBPP3q5xowQ4
	 47ORJPSJOe9uv4cSz8gJz/m9E8zJ/S8BB0yaiCU+pizhycf60XKq+05r5xNrnIzDda
	 rSSf7Y4jV/FicQHw6V1b5C4VGRXRky8YIsmpGXFbtTkOva36k1CDq2nT3T+0FNi9IF
	 A6ISG84RRuhHjHNkb/8qQaj6xmAi4PeUSOKIbQoYJRPwVDNVK/lkY9hd3xKIKsg4Vo
	 1qPZ1N53beKJQ==
Date: Mon, 27 May 2024 18:28:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Julien Panis <jpanis@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: thermal: mediatek: Rename thermal
 zone definitions for MT8186 and MT8188
Message-ID: <20240527-wife-dress-3ecaf1509506@spud>
References: <20240524-mtk-thermal-mt818x-dtsi-v5-0-56f8579820e7@baylibre.com>
 <20240524-mtk-thermal-mt818x-dtsi-v5-1-56f8579820e7@baylibre.com>
 <20240524-concerned-fritter-262f5e16293e@spud>
 <20240524-clatter-antivirus-b1939900ee58@spud>
 <61a1be10-7df3-4ba7-b7b4-ccc7f0379656@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bM4p+zZXQPt+WasM"
Content-Disposition: inline
In-Reply-To: <61a1be10-7df3-4ba7-b7b4-ccc7f0379656@baylibre.com>


--bM4p+zZXQPt+WasM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 05:25:35PM +0200, Julien Panis wrote:
> On 5/24/24 20:27, Conor Dooley wrote:
> > On Fri, May 24, 2024 at 07:24:47PM +0100, Conor Dooley wrote:
> > > On Fri, May 24, 2024 at 11:04:34AM +0200, Julien Panis wrote:
> > > > Use thermal zone names that make more sense.
> > > >=20
> > > > Signed-off-by: Julien Panis <jpanis@baylibre.com>
> > > Removing the defines is an ABI break. If these are all the same devic=
es,
> > > but with more accurate naming, then keep the old defines and add new
> > > ones. However, the GPU1 define changes in the course of this patch wh=
ich
> > > is more problematic.
> > > > [RFC] When PATCH 1/6 and 2/6 are squashed, checkpatch raises this W=
ARNING:
> > > > "DT binding docs and includes should be a separate patch." That's w=
hy I
> > > > split them in this v5. The problem is that the driver can't be comp=
iled
> > > > any more at PATCH 1/6. It needs PATCH 2/6 to be compiled. Should the
> > > > checkpatch warning be ignored here ? Should I finally squash PATCH =
1/6
> > > > and PATCH 2/6 ?
> > Heh, and there's just one of the issues caused by your ABI break...
>=20
> Conor,
>=20
> Would Russell's suggestion be acceptable for you ?
> I mean, this one:
> https://lore.kernel.org/all/ZlDMNkdE2jmFgD8B@shell.armlinux.org.uk/
>=20
> I could implement it, but before submitting it I would like to make
> sure that it suits everyone.

How's that going to work? MT8188_AP_GPU1 currently means 1, after your
series it means 2.
You're gonna need to pick a different naming for the new defines to
avoid that. Additionally, why even delete the old ones? Just define
new names with the same numbering and you don't need to worry about
any compatibility issues.

Thanks,
Conor.

--bM4p+zZXQPt+WasM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlTC2AAKCRB4tDGHoIJi
0kYaAQCBeeWym98m0dKTR3H3Xk4DUECdqWHnyikIkpibSIdLBQEA0YSS+Kyv4IH8
jOjyvUdcAS6mMC++BHn0WX/1xnIDNwY=
=lnm9
-----END PGP SIGNATURE-----

--bM4p+zZXQPt+WasM--

