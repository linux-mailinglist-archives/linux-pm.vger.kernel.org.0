Return-Path: <linux-pm+bounces-23895-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307B4A5D126
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 21:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F9767A8CE7
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 20:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25984264A6D;
	Tue, 11 Mar 2025 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQ6+6LZ8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E642F23F378;
	Tue, 11 Mar 2025 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741726274; cv=none; b=NRXYDzat2CI4Qe+NXiMuXOzxHiqJHss6jQT5gtRKboc8paMCTWwbX46UbdfYrvgwPuzNnBa1IC8gUcgK/ksEhUw8k0D7S1kjV9/GwxE+uXVV7NMzvTnUs+QNDf+VZCFqB2XthZ2x0kgBW9BRPLYfXiUBdAqrxJp2sEZKRGiaf+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741726274; c=relaxed/simple;
	bh=+X7hgr7jF2if8yShSezZxlfQeaoI5V4WeDPLfqIDNcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DX8wkXcZ4+a4lebDqJvHcccR5rEhtbg3xL0lJaq8Ch1F/SIdF0uHcPyTApUcIcTzVq+osKsXmViJujfvCwy4G9vKrZrzvcVO7uYmuLDSgxX0tZ03lHd8SJK9tXvqHtMVgTcRuz4EDp3ro8wocZje57CPWEOZ3RMk2dZoNGHHAuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQ6+6LZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EE5C4CEEA;
	Tue, 11 Mar 2025 20:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741726273;
	bh=+X7hgr7jF2if8yShSezZxlfQeaoI5V4WeDPLfqIDNcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uQ6+6LZ8UwEXAS1h+f6cX3MVwFEGEtxRo99VIVLKzcJN1MFwNcOOi8eoQ38soJjzt
	 ss6UFGhzUPIUqnlb58/VUBhhWxpPSKORACRWj1HTz64GzriG7bSiEfGkwSOVpGL1FP
	 XXsV+Hopn6XSBx3z/44uYFnhmIgz78WT9jA5KiS9TdhFaY8e3NeeXoKtYmP3rqnEk/
	 pmgLhxnseLnwiqua1mvRGzLZgiGeGXadacDsJUisihHnlW/KQ+7RP0NmSYk+fg1Z6S
	 AU+Nzi0OP9NX0fqQMznqSXud+LCGp08xgAyWN+Rc6YtnSR816ES712EzL8+SAV/eFK
	 aGRej0e3PRRqQ==
Date: Tue, 11 Mar 2025 20:51:07 +0000
From: Conor Dooley <conor@kernel.org>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	"magnus.damm@gmail.com" <magnus.damm@gmail.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"rui.zhang@intel.com" <rui.zhang@intel.com>,
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"john.madieu@gmail.com" <john.madieu@gmail.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 3/7] dt-bindings: thermal: r9a09g047-tsu: Document the
 TSU unit
Message-ID: <20250311-immature-quit-81066aec062e@spud>
References: <20250227122453.30480-1-john.madieu.xa@bp.renesas.com>
 <20250227122453.30480-4-john.madieu.xa@bp.renesas.com>
 <20250228-shampoo-uprising-44ae0d3bd68b@spud>
 <OSBPR01MB2775DFC184F78E9FB50F28FFFFD52@OSBPR01MB2775.jpnprd01.prod.outlook.com>
 <20250307-everyone-ragweed-e05a10a9646b@spud>
 <OSBPR01MB277531D7C872C9EB0B287069FFD52@OSBPR01MB2775.jpnprd01.prod.outlook.com>
 <20250307-barbell-pretzel-368d6a4d1336@spud>
 <OSBPR01MB2775D121B55A0C543F251BAEFFD72@OSBPR01MB2775.jpnprd01.prod.outlook.com>
 <20250310-blurry-scam-bee8233878bc@spud>
 <OSBPR01MB2775B3826A9FE602AC08172BFFD12@OSBPR01MB2775.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+5vlRAFPk4HzuSfw"
Content-Disposition: inline
In-Reply-To: <OSBPR01MB2775B3826A9FE602AC08172BFFD12@OSBPR01MB2775.jpnprd01.prod.outlook.com>


--+5vlRAFPk4HzuSfw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 11:24:59AM +0000, John Madieu wrote:
> Hi Conor,
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Monday, March 10, 2025 5:15 PM
> > To: John Madieu <john.madieu.xa@bp.renesas.com>
> > Subject: Re: [PATCH v2 3/7] dt-bindings: thermal: r9a09g047-tsu: Docume=
nt
> > the TSU unit
> >=20
> > On Sun, Mar 09, 2025 at 10:39:27AM +0000, John Madieu wrote:
> > > Hi Conor,
> > > > > Changes are not possible at runtime. Some customers may want
> > > > > software, while other may want the external trigger, and this is
> > > > > immutable configuration.
> > > >
> > > > What makes it immutable? Set by some wiring on the board? I couldn't
> > > > find the user in your driver patches to better understand how you
> > > > were using it.
> > >
> > > I haven't prototyped ELC trigger yet. Since the hardware manual
> > > describes about ELC trigger, I have documented it in bindings. If you
> > > think, it is not needed at this stage, then I can drop it now and
> > > revisit later.
> >=20
> > Ideally a binding is complete, even if the driver isn't. To me "immutab=
le"
> > would mean something like "the trigger type is determined by hardware or
> > firmware configuration", but if it is determined by register writes (e.=
g.
> > wired up for elc trigger, but you can opt for software trigger in the
> > driver) then it should be a userspace control.
>=20
> It is complete, and I confirm, this can be changed by register writes.
> Apart from defining default to 0, should I implement userspace change
> support now ?
>=20
> Or should I keep it as it is, just setting default to 0 (thus making
> the property optional), and add support for userspace change when I add
> ELC support.
>=20
> My other question is, in case I must add userspace change support now, wo=
uld
> sysfs be Ok ? If yes, is there any path recommendations ?

How to change it from userspace ain't my domain, sorry. Just drop the
property since isn't something determined by the hardware, but rather by
what you put into the registers.

--+5vlRAFPk4HzuSfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ9CiOwAKCRB4tDGHoIJi
0rLpAP4nP6wGoxRKYgBDm3VvemmjsSAGmmOqP64lzu3zDlgH6gD/YvTeAmTBk8Zp
oIKYspNwcyW/0MPrFQ7FL7dkEyoCAgM=
=VZy1
-----END PGP SIGNATURE-----

--+5vlRAFPk4HzuSfw--

