Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407B07D3CB7
	for <lists+linux-pm@lfdr.de>; Mon, 23 Oct 2023 18:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjJWQhi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Oct 2023 12:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjJWQhh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Oct 2023 12:37:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DE1D6E;
        Mon, 23 Oct 2023 09:37:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DFFC433C7;
        Mon, 23 Oct 2023 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698079055;
        bh=4j4zRVpdENg4gFv1kRMTIK1mdiei4ouowMHUHlbMvdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UGXh1vBIm6GumULitSKCEjbrLw/iuKY7Ps0Fn88fe0oLBpQKW5p6V9Ryv1rA5z0pl
         EMJ333zl57pM9ZI0iRgqwVD67mvzLR0N6XdO+rvLmTCFcP/ElWFhrs10gNZNPyKDCu
         JTgR4zI2YsIR9DfrAmi5bmIKPq4hRgeagt2GtBdepM9vDYyd8wt3vvcEgl6BBVdeWT
         ZUhhDw21xgZtbhpe1uXMkaPKqWquaxdMYpSIk0sTtqO0pQDFUHIusVHKj+Ojlb0HiE
         A2b+OjQmp0GYcDrPHtCNMHcOiC5ah1nv8gcAp7g6q9YEG8hqSV6+5eZWo+dhSdvkKN
         UczVhSBh3Ajbg==
Date:   Mon, 23 Oct 2023 17:37:29 +0100
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
Message-ID: <20231023-quote-wrongly-ed07265e12ac@spud>
References: <20231020130019.665853-1-alexander.stein@ew.tq-group.com>
 <20231020130019.665853-3-alexander.stein@ew.tq-group.com>
 <20231022-helper-dating-a0f65a8f6f72@spud>
 <5986192.lOV4Wx5bFT@steina-w>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xhT/qDoRzBha/YYS"
Content-Disposition: inline
In-Reply-To: <5986192.lOV4Wx5bFT@steina-w>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--xhT/qDoRzBha/YYS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 08:27:20AM +0200, Alexander Stein wrote:
> Am Sonntag, 22. Oktober 2023, 19:39:12 CEST schrieb Conor Dooley:
> > On Fri, Oct 20, 2023 at 03:00:15PM +0200, Alexander Stein wrote:
> > > Document the LDB bridge subnode and add the subnode into the example.
> > > For the subnode to work, the block control must scan its subnodes and
> > > bind drivers to them, do not misuse either simple-bus or simple-mfd
> > > here.
> > >=20
> > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > ---
> > >=20
> > >  .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 44 +++++++++++++++++=
++
> > >  1 file changed, 44 insertions(+)
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.=
yaml
> > > b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.=
yaml
> > > index b3554e7f9e76..5ba66dfb0e05 100644
> > > ---
> > > a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.=
yaml
> > > +++
> > > b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.=
yaml>=20
> > > @@ -24,6 +24,12 @@ properties:
> > >    reg:
> > >      maxItems: 1
> > >=20
> > > +  '#address-cells':
> > > +    const: 1
> > > +
> > > +  '#size-cells':
> > > +    const: 1
> > > +
> > >=20
> > >    '#power-domain-cells':
> > >      const: 1
> > >=20
> > > @@ -46,9 +52,16 @@ properties:
> > >        - const: csi
> > >        - const: dsi
> > >=20
> > > +  bridge@20:
> > > +    type: object
> > > +    $ref: /schemas/display/bridge/fsl,ldb.yaml#
> > > +    unevaluatedProperties: false
> > > +
> > >=20
> > >  required:
> > >    - compatible
> > >    - reg
> > >=20
> > > +  - '#address-cells'
> > > +  - '#size-cells'
> >=20
> > It seems to make little sense to me that these would become required
> > when the bridge is optional. Is it valid to have one of these
> > media-blk-ctrls without the ldb subnode?
>=20
> fsl,imx93-media-blk-ctrl privides several power-domains (DSI, CSI, ISI, P=
XP=20
> and LCDIF), currently unused. This series introduces the usage for LCDIF =
power=20
> domain. LDB is the LVDS display bridge. So there are several power domain=
s=20
> which don't requires the usage of ldb.
> On the other hand I prefer consistency, so I opted to keep things similar=
 to=20
> commit 1cb0c87d27dc. If it shall not be added here, it should be removed =
in=20
> Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.yaml =
as=20
> well.

IIRC the tooling will complain if you have an enabled node containing
#address-cells and/or #size-cells but no child nodes, so making
#address-cells or #size-cells required will cause problems. Looks like
the only user has the child node, so it didn't crop up yet.

--xhT/qDoRzBha/YYS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTahSAAKCRB4tDGHoIJi
0vS+AQC45ElFCzZEUe5/Th99QAcnTpLwpHp/8fZYeUbBNEHJSgEAv/Eh5gQhIGd6
z2Ep4eW1LJXgSQL1VLTN6vznUdXFtgQ=
=U4hY
-----END PGP SIGNATURE-----

--xhT/qDoRzBha/YYS--
