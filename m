Return-Path: <linux-pm+bounces-1156-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA85E81320A
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 14:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B491C21793
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 13:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DAF56B76;
	Thu, 14 Dec 2023 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/Diy8RF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E324EB38;
	Thu, 14 Dec 2023 13:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03207C433C8;
	Thu, 14 Dec 2023 13:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702561641;
	bh=lWqoyY+Lp0x9QIy2h5s/P2Ib5HZKYH1QdBbOLtUFQsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/Diy8RFki0Xj0UHq3i2rCZfhaqQg8EttcvF9psMEeM0+YTNy7zkRYMakriJZiqLK
	 dBOBbHJ+2pqIQ0Qiwgg2Tr1V9wqcoRJR7PDuwBSk4mBYFvTth01psHiZwYVmPnOXFz
	 5ZxP23bDpK1suw9uvM+qoQSUZ5tw10ARjNfqk6zQtsFdG1PWOwxgbD2ZmqHv2CYbpC
	 9VPpcEJFmiFv05M30RH9pLf4nm5OPAT2tauPWu6Qol9Fq1zAhY/NLJC7PSJXfnbV27
	 uuzPsug4M8oVleSFbo6yHZdfymHCVUNOMf/YNt6auGzR7/YglzJO7oLpFmFiQT9mXD
	 5eH3JiIG3ZIhQ==
Date: Thu, 14 Dec 2023 13:47:14 +0000
From: Conor Dooley <conor@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Yangtao Li <tiny.windzz@gmail.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/5] riscv: dts: allwinner: Update opp table to allow CPU
 frequency scaling
Message-ID: <20231214-junkyard-corset-d35b01bad69f@spud>
References: <20231214103342.30775-1-fusibrandon13@gmail.com>
 <20231214103342.30775-2-fusibrandon13@gmail.com>
 <20231214111446.camz2krqanaieybh@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4Bt0sbK2SeaAxN2v"
Content-Disposition: inline
In-Reply-To: <20231214111446.camz2krqanaieybh@vireshk-i7>


--4Bt0sbK2SeaAxN2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 04:44:46PM +0530, Viresh Kumar wrote:
> On 14-12-23, 11:33, Brandon Cheo Fusi wrote:
> > Two OPPs are currently defined for the D1/D1s; one at 408MHz and
> > another at 1.08GHz. Switching between these can be done with the
> > "sun50i-cpufreq-nvmem" driver. This patch populates the opp table
> > appropriately, with inspiration from
> > https://github.com/Tina-Linux/linux-5.4/blob/master/arch/riscv/boot/dts=
/sunxi/sun20iw1p1.dtsi
> >=20
> > The supply voltages are PWM-controlled, but support for that IP
> > is still in the works. So stick to a fixed 0.9V vdd-cpu supply,
> > which seems to be the default on most D1 boards.
> >=20
> > Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > ---
> >  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv=
/boot/dts/allwinner/sun20i-d1s.dtsi
> > index 64c3c2e6c..e211fe4c7 100644
> > --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > @@ -39,16 +39,22 @@ cpu0_intc: interrupt-controller {
> >  	};
> > =20
> >  	opp_table_cpu: opp-table-cpu {
> > -		compatible =3D "operating-points-v2";
> > +		compatible =3D "allwinner,sun20i-d1-operating-points",
>=20
> I don't think you should add a new compatible for every SoC that needs
> to be supported by a DT bindings and cpufreq driver. Maybe you should
> just reuse "allwinner,sun50i-h6-operating-points" and it will work
> fine for you ?
>=20
> Rob ?

The driver can definitely just reuse sun50i-h6, but the binding and
devicetree should have a soc-specific compatible for the sun20i-d1.

That said, the compatible does need to be documented, there's a
dt-bindings patch missing from this series.

Cheers,
Conor.

--4Bt0sbK2SeaAxN2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXsHYgAKCRB4tDGHoIJi
0llNAPwPlCtHYqdw3PHm/F9o63nh77wIsWE9SawYpIg6XvVYSQEA3ontbKuKxaUy
sMpsYI0c/7MsH2HbQPLjiFJVxobR5wo=
=L6Mk
-----END PGP SIGNATURE-----

--4Bt0sbK2SeaAxN2v--

