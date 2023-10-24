Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167BC7D4B94
	for <lists+linux-pm@lfdr.de>; Tue, 24 Oct 2023 11:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjJXJJF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Oct 2023 05:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjJXJJF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Oct 2023 05:09:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B50E8;
        Tue, 24 Oct 2023 02:09:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4235C433C8;
        Tue, 24 Oct 2023 09:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698138542;
        bh=tXHeRev7TDX6RphiYrjhkOj9XbHdnjXSBQGfuia//+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JSEMSTi3sW+WIDxLX6FFLS2JeC8kyHR04eVJbkDfQV0CAHBzkCVSIlDcnlwkDw8MZ
         5XcnFwFiZ+qKb6ENh820LtXOiY89z48lIgcV12lUE+efdHFVX004C7+eras9DRnvdn
         qbOI5vsMAcZQcao4cQrH1Xfgnw3HZWUXFDJ8G6TiQXWH89gBlzGi/x79nTGFR7lAbG
         QLY2sGblURh+R0LyXyvgx3IoVcSsuENyd02sJRlOFfy0fHm1NWUBDCkTEd7rK/S2FN
         zBmYIIxlOi7agCQaxsDkCzLrgQQp6iSRNBNGEvYGHL1KiANxOqpUq24+nxjbK5dzkR
         GSDoleG711kHA==
Date:   Tue, 24 Oct 2023 10:08:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Vasut <marex@denx.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@ew.tq-group.com, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: soc: imx93-media-blk-ctrl: Add LDB
 subnode into schema and example
Message-ID: <20231024-reimburse-domain-893407e09833@spud>
References: <20231020130019.665853-1-alexander.stein@ew.tq-group.com>
 <5986192.lOV4Wx5bFT@steina-w>
 <20231023-quote-wrongly-ed07265e12ac@spud>
 <8331331.NyiUUSuA9g@steina-w>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gm5wsyKv10PD0tI4"
Content-Disposition: inline
In-Reply-To: <8331331.NyiUUSuA9g@steina-w>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--gm5wsyKv10PD0tI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 08:30:16AM +0200, Alexander Stein wrote:
> Am Montag, 23. Oktober 2023, 18:37:29 CEST schrieb Conor Dooley:
> > On Mon, Oct 23, 2023 at 08:27:20AM +0200, Alexander Stein wrote:
> > > Am Sonntag, 22. Oktober 2023, 19:39:12 CEST schrieb Conor Dooley:
> > > > On Fri, Oct 20, 2023 at 03:00:15PM +0200, Alexander Stein wrote:
> > > > > Document the LDB bridge subnode and add the subnode into the exam=
ple.
> > > > > For the subnode to work, the block control must scan its subnodes=
 and
> > > > > bind drivers to them, do not misuse either simple-bus or simple-m=
fd
> > > > > here.
> > > > >=20
> > > > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > > > ---
> > > > >=20
> > > > >  .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 44
> > > > >  +++++++++++++++++++
> > > > >  1 file changed, 44 insertions(+)
> > > > >=20
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-c=
trl.y
> > > > > aml
> > > > > b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-c=
trl.y
> > > > > aml
> > > > > index b3554e7f9e76..5ba66dfb0e05 100644
> > > > > ---
> > > > > a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-c=
trl.y
> > > > > aml
> > > > > +++
> > > > > b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-c=
trl.y
> > > > > aml>
> > > > >=20
> > > > > @@ -24,6 +24,12 @@ properties:
> > > > >    reg:
> > > > >      maxItems: 1
> > > > >=20
> > > > > +  '#address-cells':
> > > > > +    const: 1
> > > > > +
> > > > > +  '#size-cells':
> > > > > +    const: 1
> > > > > +
> > > > >=20
> > > > >    '#power-domain-cells':
> > > > >      const: 1
> > > > >=20
> > > > > @@ -46,9 +52,16 @@ properties:
> > > > >        - const: csi
> > > > >        - const: dsi
> > > > >=20
> > > > > +  bridge@20:
> > > > > +    type: object
> > > > > +    $ref: /schemas/display/bridge/fsl,ldb.yaml#
> > > > > +    unevaluatedProperties: false
> > > > > +
> > > > >=20
> > > > >  required:
> > > > >    - compatible
> > > > >    - reg
> > > > >=20
> > > > > +  - '#address-cells'
> > > > > +  - '#size-cells'
> > > >=20
> > > > It seems to make little sense to me that these would become required
> > > > when the bridge is optional. Is it valid to have one of these
> > > > media-blk-ctrls without the ldb subnode?
> > >=20
> > > fsl,imx93-media-blk-ctrl privides several power-domains (DSI, CSI, IS=
I,
> > > PXP
> > > and LCDIF), currently unused. This series introduces the usage for LC=
DIF
> > > power domain. LDB is the LVDS display bridge. So there are several po=
wer
> > > domains which don't requires the usage of ldb.
> > > On the other hand I prefer consistency, so I opted to keep things sim=
ilar
> > > to commit 1cb0c87d27dc. If it shall not be added here, it should be
> > > removed in
> > > Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.y=
aml
> > > as well.
> >=20
> > IIRC the tooling will complain if you have an enabled node containing
> > #address-cells and/or #size-cells but no child nodes, so making
> > #address-cells or #size-cells required will cause problems. Looks like
> > the only user has the child node, so it didn't crop up yet.
>=20
> I was not able to raise a warning with enabled media_blk_ctrl having #add=
ress-
> cells/#size-cells being set but no subnode.
> I don't have a strong opinion on this, but I prefer having both bindings =
as=20
> similar as possible.

The complaint is from dtc, possibly only at W=3D1:
unnecessary #address-cells/#size-cells without "ranges" or child "reg" prop=
erty

--gm5wsyKv10PD0tI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTeJqAAKCRB4tDGHoIJi
0uUzAQC031R4thbZ37BFnpSE5+qX/374uopzziZtAGu6k4496wEAkKFCo6wlMcvc
SYQ7z2EVJdvqdqQIJ8JRoTJgpyutqwk=
=ElME
-----END PGP SIGNATURE-----

--gm5wsyKv10PD0tI4--
