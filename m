Return-Path: <linux-pm+bounces-8196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C78B8D0EF9
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 23:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EACB1C211A9
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 21:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069FF155C88;
	Mon, 27 May 2024 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyeY8w8i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE3E53370;
	Mon, 27 May 2024 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716844053; cv=none; b=L+QXwIAmA9Oest6Uo0jN+AE84GinkEdXri03wyEfIteAGsF+IHcgD87zxci4y1qkEL8U/5gE62z/4HwZmtPQ8nghHxfqAmJtU6JPd0UBw3ZZ+BgjNlbJGNjNRJ/Wc2nqMQ6XjtDK4/T4ot/e8R/jC+LGbIqXNid7B5o+D2hHm4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716844053; c=relaxed/simple;
	bh=mhVfWIrto4jIU5ikPnSkoETBiu2Uq0drRspSjx8EjrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcpXWDeDwxG9miGTS/3EvgZ48OyuFljgo+cRgf3iXB8QxAxHzHEsb4iv/J2z/NwGARs5vBevOakAXUCDkRM7j+TXtWYGx8RtlJ5NihsuGKkG4rj41eh+SY/blYUsvAfGKI9EU4Dj+/J4lb2GN/h3gAF+dSYQxqw2as5bw5VoIRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyeY8w8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C3FC2BBFC;
	Mon, 27 May 2024 21:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716844053;
	bh=mhVfWIrto4jIU5ikPnSkoETBiu2Uq0drRspSjx8EjrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nyeY8w8iM3a2bKqXDG6a5LCeGu84qqJ1ghEDJrUibye8UWiHMZ26cN9Srpo8k+Bo0
	 eJcl+jTC0oRs64ZMgJ9MCEcGQjVeCOnGVpnYRgax/rnyX8RdPKjytNF8MxejhswWVq
	 +OckIrSDp2jp5e/QyypniY29hLvJ9uhNul4IrEe2pCVDnmqSP4IlXP1u5iYzEy7EEm
	 xOqcd5JYMYGlMOIOIHmBu7TUiZGIL4TgeLtiQ8wjhrmpbi8qcLE7b1BTT6/lPpEHko
	 jmcFPAm3tRCsuawEQnq9b2CHGIALDfxKli0x6MfJ0EpgvBz+nKxNyhghDSstcL8sKz
	 OhleTPgmzvL8A==
Date: Mon, 27 May 2024 22:07:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Nicolas Pitre <npitre@baylibre.com>
Cc: Julien Panis <jpanis@baylibre.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: thermal: mediatek: Rename thermal
 zone definitions for MT8186 and MT8188
Message-ID: <20240527-reclusive-elderly-5b2d6bfee6b9@spud>
References: <20240524-mtk-thermal-mt818x-dtsi-v5-0-56f8579820e7@baylibre.com>
 <20240524-mtk-thermal-mt818x-dtsi-v5-1-56f8579820e7@baylibre.com>
 <20240524-concerned-fritter-262f5e16293e@spud>
 <20240524-clatter-antivirus-b1939900ee58@spud>
 <61a1be10-7df3-4ba7-b7b4-ccc7f0379656@baylibre.com>
 <20240527-wife-dress-3ecaf1509506@spud>
 <r9q3n5n4-4pqn-53so-4n65-33p432530793@onlyvoer.pbz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wMFiEWgMGRM5yNJl"
Content-Disposition: inline
In-Reply-To: <r9q3n5n4-4pqn-53so-4n65-33p432530793@onlyvoer.pbz>


--wMFiEWgMGRM5yNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 04:57:15PM -0400, Nicolas Pitre wrote:
> On Mon, 27 May 2024, Conor Dooley wrote:

> > > Would Russell's suggestion be acceptable for you ?
> > > I mean, this one:
> > > https://lore.kernel.org/all/ZlDMNkdE2jmFgD8B@shell.armlinux.org.uk/
> > >=20
> > > I could implement it, but before submitting it I would like to make
> > > sure that it suits everyone.
> >=20
> > How's that going to work? MT8188_AP_GPU1 currently means 1, after your
> > series it means 2.
> > You're gonna need to pick a different naming for the new defines to
> > avoid that. Additionally, why even delete the old ones? Just define
> > new names with the same numbering and you don't need to worry about
> > any compatibility issues.
>=20
> Isn't this making a mountain out of a molehill here?
>=20
> Seriously... none of this was present in a released kernel. The naming=20
> can be adjusted "atomically" so compilation doesn't break, and=20
> it is within maintainers' discretion to bypass the checkpatch warning in=
=20
> such particular case.

If that's the case, then great. Provide a fixes tag, and a better commit
message than "Use thermal zone names that make more sense." that
actually explains why it is okay to change the definitions. There'd've
been neither mountain nor molehill were a sufficient commit message
provided.


--wMFiEWgMGRM5yNJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlT2EAAKCRB4tDGHoIJi
0ukrAQDMx2V/zyc186dIn+Ks5bop1v80bcJVAiGhMggRt21d8gD/bXAHQUuzVQKi
99Y5nTyefGk40OXYnqLeWsRQxfcm9wA=
=qebK
-----END PGP SIGNATURE-----

--wMFiEWgMGRM5yNJl--

