Return-Path: <linux-pm+bounces-2118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CA882AFA2
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 14:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA4C2869E4
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB63515EA1;
	Thu, 11 Jan 2024 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="emTFPLho"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E03171C2;
	Thu, 11 Jan 2024 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1704979600; x=1736515600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lc0mfrR0brTHHoM4aeTwhDwKfsnEdj9csKTdzY8eoBs=;
  b=emTFPLhoXtQmPxq5TWmkR9vP8GY0yao9RyO91N3QiDC4mq8oQSZXAR5f
   TkAdKTc8S6iKmgIgq8zeFU3+uAruZprkiBBBp5QcHydA6tZ0Auxp3U9gC
   UnndLKJ2fl6W3i8zRUEf/FHnvkmUAm5cJqAPc1ik++Os8Fzyj7T8rV9+l
   NPgWECetA1d0hnRxWmRIKBZseoJXg3N3goF9rNQ+rcZn9xq9qOh/xi4Xs
   jbrrKk5BoJ5rUVbI1n1XLelGjisQFmwYufMMLlBaKIE53HHu8WNZpmR6O
   xLRa5e5EBwWs+9kZT865VJHk1qfP4HxGCu55usANcd+ofCVfQJeJ7zTt+
   Q==;
X-IronPort-AV: E=Sophos;i="6.04,186,1695679200"; 
   d="scan'208";a="34852285"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 11 Jan 2024 14:26:36 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 1C4CF280075;
	Thu, 11 Jan 2024 14:26:36 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Marek Vasut <marex@denx.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: soc: imx93-media-blk-ctrl: Add LDB subnode into schema and example
Date: Thu, 11 Jan 2024 14:26:36 +0100
Message-ID: <1985138.usQuhbGJ8B@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20231024-reimburse-domain-893407e09833@spud>
References: <20231020130019.665853-1-alexander.stein@ew.tq-group.com> <8331331.NyiUUSuA9g@steina-w> <20231024-reimburse-domain-893407e09833@spud>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Conor,

Am Dienstag, 24. Oktober 2023, 11:08:56 CET schrieb Conor Dooley:
> On Tue, Oct 24, 2023 at 08:30:16AM +0200, Alexander Stein wrote:
> > Am Montag, 23. Oktober 2023, 18:37:29 CEST schrieb Conor Dooley:
> > > On Mon, Oct 23, 2023 at 08:27:20AM +0200, Alexander Stein wrote:
> > > > Am Sonntag, 22. Oktober 2023, 19:39:12 CEST schrieb Conor Dooley:
> > > > > On Fri, Oct 20, 2023 at 03:00:15PM +0200, Alexander Stein wrote:
> > > > > > Document the LDB bridge subnode and add the subnode into the
> > > > > > example.
> > > > > > For the subnode to work, the block control must scan its subnod=
es
> > > > > > and
> > > > > > bind drivers to them, do not misuse either simple-bus or
> > > > > > simple-mfd
> > > > > > here.
> > > > > >=20
> > > > > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > > > > ---
> > > > > >=20
> > > > > >  .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 44
> > > > > >  +++++++++++++++++++
> > > > > >  1 file changed, 44 insertions(+)
> > > > > >=20
> > > > > > diff --git
> > > > > > a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk=
=2Dct
> > > > > > rl.y
> > > > > > aml
> > > > > > b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk=
=2Dct
> > > > > > rl.y
> > > > > > aml
> > > > > > index b3554e7f9e76..5ba66dfb0e05 100644
> > > > > > ---
> > > > > > a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk=
=2Dct
> > > > > > rl.y
> > > > > > aml
> > > > > > +++
> > > > > > b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk=
=2Dct
> > > > > > rl.y
> > > > > > aml>
> > > > > >=20
> > > > > > @@ -24,6 +24,12 @@ properties:
> > > > > >    reg:
> > > > > >      maxItems: 1
> > > > > >=20
> > > > > > +  '#address-cells':
> > > > > > +    const: 1
> > > > > > +
> > > > > > +  '#size-cells':
> > > > > > +    const: 1
> > > > > > +
> > > > > >=20
> > > > > >    '#power-domain-cells':
> > > > > >      const: 1
> > > > > >=20
> > > > > > @@ -46,9 +52,16 @@ properties:
> > > > > >        - const: csi
> > > > > >        - const: dsi
> > > > > >=20
> > > > > > +  bridge@20:
> > > > > > +    type: object
> > > > > > +    $ref: /schemas/display/bridge/fsl,ldb.yaml#
> > > > > > +    unevaluatedProperties: false
> > > > > > +
> > > > > >=20
> > > > > >  required:
> > > > > >    - compatible
> > > > > >    - reg
> > > > > >=20
> > > > > > +  - '#address-cells'
> > > > > > +  - '#size-cells'
> > > > >=20
> > > > > It seems to make little sense to me that these would become requi=
red
> > > > > when the bridge is optional. Is it valid to have one of these
> > > > > media-blk-ctrls without the ldb subnode?
> > > >=20
> > > > fsl,imx93-media-blk-ctrl privides several power-domains (DSI, CSI,
> > > > ISI,
> > > > PXP
> > > > and LCDIF), currently unused. This series introduces the usage for
> > > > LCDIF
> > > > power domain. LDB is the LVDS display bridge. So there are several
> > > > power
> > > > domains which don't requires the usage of ldb.
> > > > On the other hand I prefer consistency, so I opted to keep things
> > > > similar
> > > > to commit 1cb0c87d27dc. If it shall not be added here, it should be
> > > > removed in
> > > > Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl=
=2Eya
> > > > ml
> > > > as well.
> > >=20
> > > IIRC the tooling will complain if you have an enabled node containing
> > > #address-cells and/or #size-cells but no child nodes, so making
> > > #address-cells or #size-cells required will cause problems. Looks like
> > > the only user has the child node, so it didn't crop up yet.
> >=20
> > I was not able to raise a warning with enabled media_blk_ctrl having
> > #address- cells/#size-cells being set but no subnode.
> > I don't have a strong opinion on this, but I prefer having both bindings
> > as
> > similar as possible.
>=20
> The complaint is from dtc, possibly only at W=3D1:
> unnecessary #address-cells/#size-cells without "ranges" or child "reg"
> property

I was still not able to trigger this. But anyway this binding is for i.MX93=
=20
MEDIAMIX Block Control. There is exactly one of this instance in the SoC. S=
o=20
there is always the LVDS bridge included, thus the ldb subnode shall be add=
ed.
Given this IMHO #address-cells/#size-cells can be required.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



