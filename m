Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D967D2A61
	for <lists+linux-pm@lfdr.de>; Mon, 23 Oct 2023 08:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjJWG1X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Oct 2023 02:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjJWG1X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Oct 2023 02:27:23 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD481DF;
        Sun, 22 Oct 2023 23:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1698042440; x=1729578440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B4cdU/iC1dUVeB9k49fZxtcHN1oJA8yJgehxpOxX72I=;
  b=YtSpZJ2J824Ok1NK+o4a7hgSJmenFLdvn/Ss3kvBi0oHQ6xIi8894V8m
   5RgitfL9VFr5P1iGHWYKGs7M3APadeCv9Vh/hpTQKpWeQqqUdqLL8z5WQ
   lZam5ehrWE9sR49zJfBsVqXRFuIebQ3H+kqdKxeRHcpWbXBPDo7fqkPsJ
   pfKiR7qR9wCrjzRrlFlUm0FLGuydtMFjOsifH/ndAjQnXTIjMO0laf3Xn
   PJwuHYHZIK6t2VSmkJGjUedDdeGjXJU90Mfk3n3vAppXjEBD32H9O0kxj
   E2qWLPbMvLuvZ9aPRxuGs+SZNLvlb0kXyh/39dE+GSlH3autmMMVSEFyK
   w==;
X-IronPort-AV: E=Sophos;i="6.03,244,1694728800"; 
   d="scan'208";a="33590173"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Oct 2023 08:27:17 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id E556728007F;
        Mon, 23 Oct 2023 08:27:16 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Conor Dooley <conor@kernel.org>
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
Subject: Re: [PATCH 2/5] dt-bindings: soc: imx93-media-blk-ctrl: Add LDB subnode into schema and example
Date:   Mon, 23 Oct 2023 08:27:20 +0200
Message-ID: <5986192.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20231022-helper-dating-a0f65a8f6f72@spud>
References: <20231020130019.665853-1-alexander.stein@ew.tq-group.com> <20231020130019.665853-3-alexander.stein@ew.tq-group.com> <20231022-helper-dating-a0f65a8f6f72@spud>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Conor,

Am Sonntag, 22. Oktober 2023, 19:39:12 CEST schrieb Conor Dooley:
> Yo,
>=20
> On Fri, Oct 20, 2023 at 03:00:15PM +0200, Alexander Stein wrote:
> > Document the LDB bridge subnode and add the subnode into the example.
> > For the subnode to work, the block control must scan its subnodes and
> > bind drivers to them, do not misuse either simple-bus or simple-mfd
> > here.
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >=20
> >  .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 44 +++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.ya=
ml
> > b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.ya=
ml
> > index b3554e7f9e76..5ba66dfb0e05 100644
> > ---
> > a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.ya=
ml
> > +++
> > b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.ya=
ml>=20
> > @@ -24,6 +24,12 @@ properties:
> >    reg:
> >      maxItems: 1
> >=20
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 1
> > +
> >=20
> >    '#power-domain-cells':
> >      const: 1
> >=20
> > @@ -46,9 +52,16 @@ properties:
> >        - const: csi
> >        - const: dsi
> >=20
> > +  bridge@20:
> > +    type: object
> > +    $ref: /schemas/display/bridge/fsl,ldb.yaml#
> > +    unevaluatedProperties: false
> > +
> >=20
> >  required:
> >    - compatible
> >    - reg
> >=20
> > +  - '#address-cells'
> > +  - '#size-cells'
>=20
> It seems to make little sense to me that these would become required
> when the bridge is optional. Is it valid to have one of these
> media-blk-ctrls without the ldb subnode?

fsl,imx93-media-blk-ctrl privides several power-domains (DSI, CSI, ISI, PXP=
=20
and LCDIF), currently unused. This series introduces the usage for LCDIF po=
wer=20
domain. LDB is the LVDS display bridge. So there are several power domains=
=20
which don't requires the usage of ldb.
On the other hand I prefer consistency, so I opted to keep things similar t=
o=20
commit 1cb0c87d27dc. If it shall not be added here, it should be removed in=
=20
Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.yaml as=
=20
well.

Best regards,
Alexander

>=20
> >    - power-domains
> >    - clocks
> >    - clock-names
> >=20
> > @@ -77,4 +90,35 @@ examples:
> >                 clock-names =3D "apb", "axi", "nic", "disp", "cam",
> >                =20
> >                               "pxp", "lcdif", "isi", "csi", "dsi";
> >       =20
> >        #power-domain-cells =3D <1>;
> >=20
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <1>;
> > +
> > +      bridge@20 {
> > +          compatible =3D "fsl,imx93-ldb";
> > +          reg =3D <0x20 0x4>, <0x24 0x4>;
> > +          reg-names =3D "ldb", "lvds";
> > +          clocks =3D <&clk IMX93_CLK_LVDS_GATE>;
> > +          clock-names =3D "ldb";
> > +
> > +          ports {
> > +              #address-cells =3D <1>;
> > +              #size-cells =3D <0>;
> > +
> > +              port@0 {
> > +                  reg =3D <0>;
> > +
> > +                  ldb_from_lcdif2: endpoint {
> > +                      remote-endpoint =3D <&lcdif2_to_ldb>;
> > +                  };
> > +              };
> > +
> > +              port@1 {
> > +                  reg =3D <1>;
> > +
> > +                  ldb_lvds: endpoint {
> > +                      remote-endpoint =3D <&ldb_to_panel>;
> > +                  };
> > +              };
> > +          };
> > +        };
> >=20
> >      };


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


