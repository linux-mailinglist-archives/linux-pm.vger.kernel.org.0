Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2F07D4774
	for <lists+linux-pm@lfdr.de>; Tue, 24 Oct 2023 08:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjJXGaT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Oct 2023 02:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjJXGaT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Oct 2023 02:30:19 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191C8EA;
        Mon, 23 Oct 2023 23:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1698129016; x=1729665016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9AUC3WlKvozWisL0AjNz7g2p54DmQxQY/G1iKkNelTY=;
  b=nX11cSps315ss6+O40IjlsSkOxnWiTbPCaO1lCJO9QgWYGEMgRfzuQDy
   f08YNDE0230LOYIDgkWr51tk9MAXVQL9FstowdYC/zgtADoUquGeW+dKT
   dhXgo6dMtnC2KddSTlNqTQzjpJVX7hWGBvUBpHxD7/Mi6CDmIH2rGyIE6
   xHMQV8u0L0A6s/3ZEDj+Yq/FgQm8W7nQqnCRq6VFbTsme0rpPwPspUnuW
   QANZw89+PKHaE3zOARBFplR77N5GzQFHHyLuMZEQTtv16xwqdquhbLdkp
   vD0M0I77T3Uh3B4WBcydNIaUmg87B7Zu72aJ+iAsi+ZVNbJsc1sI8cMIW
   A==;
X-IronPort-AV: E=Sophos;i="6.03,246,1694728800"; 
   d="scan'208";a="33614186"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 24 Oct 2023 08:30:14 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id B490B28007F;
        Tue, 24 Oct 2023 08:30:13 +0200 (CEST)
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
Date:   Tue, 24 Oct 2023 08:30:16 +0200
Message-ID: <8331331.NyiUUSuA9g@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20231023-quote-wrongly-ed07265e12ac@spud>
References: <20231020130019.665853-1-alexander.stein@ew.tq-group.com> <5986192.lOV4Wx5bFT@steina-w> <20231023-quote-wrongly-ed07265e12ac@spud>
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

Am Montag, 23. Oktober 2023, 18:37:29 CEST schrieb Conor Dooley:
> On Mon, Oct 23, 2023 at 08:27:20AM +0200, Alexander Stein wrote:
> > Am Sonntag, 22. Oktober 2023, 19:39:12 CEST schrieb Conor Dooley:
> > > On Fri, Oct 20, 2023 at 03:00:15PM +0200, Alexander Stein wrote:
> > > > Document the LDB bridge subnode and add the subnode into the exampl=
e.
> > > > For the subnode to work, the block control must scan its subnodes a=
nd
> > > > bind drivers to them, do not misuse either simple-bus or simple-mfd
> > > > here.
> > > >=20
> > > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > > ---
> > > >=20
> > > >  .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 44
> > > >  +++++++++++++++++++
> > > >  1 file changed, 44 insertions(+)
> > > >=20
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctr=
l.y
> > > > aml
> > > > b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctr=
l.y
> > > > aml
> > > > index b3554e7f9e76..5ba66dfb0e05 100644
> > > > ---
> > > > a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctr=
l.y
> > > > aml
> > > > +++
> > > > b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctr=
l.y
> > > > aml>
> > > >=20
> > > > @@ -24,6 +24,12 @@ properties:
> > > >    reg:
> > > >      maxItems: 1
> > > >=20
> > > > +  '#address-cells':
> > > > +    const: 1
> > > > +
> > > > +  '#size-cells':
> > > > +    const: 1
> > > > +
> > > >=20
> > > >    '#power-domain-cells':
> > > >      const: 1
> > > >=20
> > > > @@ -46,9 +52,16 @@ properties:
> > > >        - const: csi
> > > >        - const: dsi
> > > >=20
> > > > +  bridge@20:
> > > > +    type: object
> > > > +    $ref: /schemas/display/bridge/fsl,ldb.yaml#
> > > > +    unevaluatedProperties: false
> > > > +
> > > >=20
> > > >  required:
> > > >    - compatible
> > > >    - reg
> > > >=20
> > > > +  - '#address-cells'
> > > > +  - '#size-cells'
> > >=20
> > > It seems to make little sense to me that these would become required
> > > when the bridge is optional. Is it valid to have one of these
> > > media-blk-ctrls without the ldb subnode?
> >=20
> > fsl,imx93-media-blk-ctrl privides several power-domains (DSI, CSI, ISI,
> > PXP
> > and LCDIF), currently unused. This series introduces the usage for LCDIF
> > power domain. LDB is the LVDS display bridge. So there are several power
> > domains which don't requires the usage of ldb.
> > On the other hand I prefer consistency, so I opted to keep things simil=
ar
> > to commit 1cb0c87d27dc. If it shall not be added here, it should be
> > removed in
> > Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.yaml
> > as well.
>=20
> IIRC the tooling will complain if you have an enabled node containing
> #address-cells and/or #size-cells but no child nodes, so making
> #address-cells or #size-cells required will cause problems. Looks like
> the only user has the child node, so it didn't crop up yet.

I was not able to raise a warning with enabled media_blk_ctrl having #addre=
ss-
cells/#size-cells being set but no subnode.
I don't have a strong opinion on this, but I prefer having both bindings as=
=20
similar as possible.

best regards,
Alexander

=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


