Return-Path: <linux-pm+bounces-12367-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D0F954E68
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 18:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C919284EC2
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0CB1BDA94;
	Fri, 16 Aug 2024 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJEtdsG0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FED31BB68D;
	Fri, 16 Aug 2024 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723824279; cv=none; b=D7Z/VyEw8+l2bbfHsCUg6XqGee6GaxU0g9wx0hheQfog96DbVGk4ohYjD3RFY3rA5zeGaGz/FPY9KuyaDx0wart/PrUfZurQuwIBK3DQud3pI6D0Bwn8L15IOyoiQ0ysLi4kfu3qcsDb7talWxlIUTm57kr0fo/D+M7dCrD9Ykg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723824279; c=relaxed/simple;
	bh=EPuQ2Nh1roM0N2s8I0Ls0NSMzC1GbSyB3GEWBTBguSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoiibVe4oevHWYnjHJ8jEYVBm9dbdVDuAbBhmSqw7lLM+ZBe3ONew/aavzdolL1qE/TWIqKUHsdXAhfj6Pi/XG6fIDSqlQS7tGTrEDSdVS+dTcGIGmVt7LfK53Vy/SJFdf2g2/A0v5zFz33m244bqIFp7/aJRoVqg1DEgVvU+Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJEtdsG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CFDC32782;
	Fri, 16 Aug 2024 16:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723824278;
	bh=EPuQ2Nh1roM0N2s8I0Ls0NSMzC1GbSyB3GEWBTBguSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJEtdsG0vhlBjP+YaxfIfo6ESwYNVAYYNjiDRgScyXLluWnBOQUJmupTpGka3kTCU
	 eXFOGR6mBmD3PkZnCUThKrCJh89wknjtz3zGsrcoeUojbjcqrfbgBUTBzH1EbyEokm
	 3HDqNXRvTFhRMnSUh6Zs4AezX+naz+Bt7jMKFjWi6XCwp9zZB0Pj/igN5Pl5h+g6Tn
	 bWGnCSMHvLNPR7BKfSkc7TfMYfVtmbb3FzqoVpmq6ukWpzDRS0ofmtsMvr37yb20qR
	 EbfB1nkh5UQVSsZZ4p5VJPLg3iObPIM3MuhiHiIbxqn4iqDQZyVhts5Pt+2gyCK0B8
	 hUHapenwRazPQ==
Date: Fri, 16 Aug 2024 17:04:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: supply: sc27xx-fg: add low voltage
 alarm IRQ
Message-ID: <20240816-licorice-dealing-b67197d3f88f@spud>
References: <Zr3SAHlq5A78QvrW@standask-GA-A55M-S2HP>
 <20240815-winnings-waving-1ec5561f90e7@spud>
 <Zr74o7/4uurJeRnF@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iSN+i34vU373tBO4"
Content-Disposition: inline
In-Reply-To: <Zr74o7/4uurJeRnF@standask-GA-A55M-S2HP>


--iSN+i34vU373tBO4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 08:58:43AM +0200, Stanislav Jakubek wrote:
> Hi Conor,
>=20
> On Thu, Aug 15, 2024 at 03:46:18PM +0100, Conor Dooley wrote:
> > On Thu, Aug 15, 2024 at 12:01:36PM +0200, Stanislav Jakubek wrote:
> > > The SC27XX fuel gauge supports a low voltage alarm IRQ, which is used
> > > for more accurate battery capacity measurements with lower voltages.
> > >=20
> > > This was unfortunately never documented in bindings, do so now.
> > >=20
> > > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > > ---
> > > Initial Linux driver submission adding this feature:
> > > https://lore.kernel.org/lkml/ee1dd39f126bd03fb88381de9663d32df994d341=
=2E1542185618.git.baolin.wang@linaro.org/
> > >=20
> > > The only in-tree user (sc2731.dtsi) has had interrupts specified sinc=
e its
> > > initial fuel-gauge submission:
> > > https://lore.kernel.org/lkml/4f66af3b47ba241380f8092e08879aca6d7c35b3=
=2E1548052878.git.baolin.wang@linaro.org/
> >=20
> > This context could go into the commit message I think, as justification
> > for making the interrupt required.
>=20
> TBH I'm not 100% sure that the interrupt is required, I just looked at
> the Linux driver, and that it returns from probe if it doesn't get the IR=
Q.
>=20
> >=20
> > Also, this binding is odd in that it has several compatibles in an enum,
> > but the driver (added at the same time) only has one compatible in it.
>=20
> I think the intent was to document the entire sc27xx series of PMICs, as
> they're supposedly very similar (this is just my guess), while initially
> adding support only for sc2731.
>=20
> > Are you using the sc2731 in your device?
>=20
> No, I do not have any such device.

No worries.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--iSN+i34vU373tBO4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZr94kgAKCRB4tDGHoIJi
0vpUAP9/LGLlbZaexYAUrcsXDwmy4v19apWfDrSJIyQ5JkbDUwD/dXPvd5xOVdio
mNhHQWgiVWlpF6IdZk+8Hu8UlcfVBwM=
=7TZU
-----END PGP SIGNATURE-----

--iSN+i34vU373tBO4--

