Return-Path: <linux-pm+bounces-9196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC761908D65
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 16:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657C11F22F9A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 14:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61AFDDA5;
	Fri, 14 Jun 2024 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2/JkoUx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7B1C129;
	Fri, 14 Jun 2024 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375509; cv=none; b=S6eRW9c4SFqnQdWQDpjC7IubzbF+Cmk3TtqawIQDZnhSNFtgoevXcmwf8+4OtDWXLSN5bxNGMT4eHhwNZIBpEPv4w64e82kx8+HemfattI9j8qy+Byxrxx24Gd5WpS+rCymKM/LRD46nZUbsrf+E1P4czCNq/qr3k6rxlvUF6Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375509; c=relaxed/simple;
	bh=AW1z+gl+oeKjTe4GvT99ogDWt4IRrSVZcPLIPpAqsm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGJb9p/+ttHDjzA1rJKMgPnYKeuI6T6fqf7EV/145eD2leAKLEtaDqJYZzkop0dqMw1+71bwEIdroA/h231tEkA6fAeWLyre5Qu2bFzA2gqiP2dLgBH5rVsewg0kjJJdqq3TxeSBfMz4O5Q3GcR0uopCJNePrgLl6gcAxEDoM8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2/JkoUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D483C2BD10;
	Fri, 14 Jun 2024 14:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718375509;
	bh=AW1z+gl+oeKjTe4GvT99ogDWt4IRrSVZcPLIPpAqsm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h2/JkoUxtNjUvTfAWxSI7vwU5K8bFxjDMrF63rXl+rCX7vgKzK5yQFnwGri9Duvwf
	 Aij5kmKi+P4MSXS+uxM+7mDEXI71kx2pnp2Oy1vidk13g0UL1sgFst7NVSh5cokfpw
	 U+XhoFk0cqgSDWR/tUikMCUWaTyq0tDhIaQz873BB5QwHKcyOIvSdYS1/qz299GgvY
	 YlaE8+nFV7qHyKjxMSaoQ/dmjmgsnuTbmSYxoFSE64r4LALN9evUZ1x8hsQJWdK+xd
	 Mj5KsKRrlTHCNaQK4LEVyz6JbYWnRwt51DUg71F+K8lGHkJDjPU8j/qsD549jaOelT
	 ARxy0F9O2QHjw==
Date: Fri, 14 Jun 2024 15:31:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"biju.das.au" <biju.das.au@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] regulator: core: Add helper for allow access to
 enable register
Message-ID: <ZmxUUbpGZiZMlHVE@finisterre.sirena.org.uk>
References: <20240611110402.58104-1-biju.das.jz@bp.renesas.com>
 <20240611110402.58104-4-biju.das.jz@bp.renesas.com>
 <ZmhmWrvyQiCzzeYi@finisterre.sirena.org.uk>
 <TY3PR01MB11346B807820F681E7EEF7A6786C72@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ZmnDwKUlXCWFJ8W0@finisterre.sirena.org.uk>
 <TY3PR01MB113467AD31470F72C75DBF41986C22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ois24WsttoXepZBR"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB113467AD31470F72C75DBF41986C22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-Cookie: Your love life will be... interesting.


--Ois24WsttoXepZBR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 14, 2024 at 11:43:39AM +0000, Biju Das wrote:

> To access the hardware register for enabling/disabling the regulator,
> consumers must use regulator_get_exclusive(), as it can't work if there's
> more than one consumer. To enable/disable regulator use::

>        int regulator_hardware_enable(struct regulator *regulator, bool enable);

We should also enforce this.

> OK, will remove the restriction

> -       if (enable) {
> -               if (ops->enable == regulator_enable_regmap)
> -                       ret = ops->enable(rdev);
> -       } else {
> -               if (ops->disable == regulator_disable_regmap)
> -                       ret = rdev->desc->ops->disable(rdev);
> -       }
> +       if (enable)
> +               ret = ops->enable(rdev);
> +       else
> +               ret = ops->disable(rdev);

> Please let me know if anything wrong.

Sure.

--Ois24WsttoXepZBR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZsVFAACgkQJNaLcl1U
h9CpXAf/a6pVjdmFuqfVIs8/VbMeT2v0gancEFoB/8TnUVXKt99DCyJrnPRgI1qL
NPPs2Br6otvvVQFCoDIefCPlD2sex+j0Sp5oweC/5SOCYiqm60A/CyK30Zvt67c2
gfHcE5qxKuI6zHEHuYmaJHBxmyKvvOi54eepDW78+xmbT1+Z+dykZ5PhrKdaPGQC
ylKeHsEspsy8deQ3ohQWXejUQ4oNx8uboXDK0eoffxrRMeAg6l5btX73eZmRvb+m
o2BrhlA6UJUgIxwxx6SEs8fkG/gjBSHATKIZFM1MyDSblwls7BGCNYjnYA3cn//+
WszyzfZG4cIRu1C8eyRRklR9cX1SSg==
=r8RQ
-----END PGP SIGNATURE-----

--Ois24WsttoXepZBR--

