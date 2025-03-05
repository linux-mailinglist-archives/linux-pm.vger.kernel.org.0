Return-Path: <linux-pm+bounces-23472-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B14DA4F96F
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 10:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B084E7A243B
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 09:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8437200100;
	Wed,  5 Mar 2025 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="FGEdSHsJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="qzcWgjDG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F801FC7D1;
	Wed,  5 Mar 2025 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741165348; cv=none; b=t5ULx4n6ZcTSlo0zH5myketOKdmO64TMObgGSonG+LepUGXRNJBxDD6SJcytoJrhvO7D02ayCasNYvZBb5p1BTI5hVdA17kbHTE/UOgstzX/TnSzyynPlro7ngoD6da95P/Mwbp54gpjfP3KyRRNNiGYWVKD25c3CL6pLszjmz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741165348; c=relaxed/simple;
	bh=7BZUuY0NVXBKg5hilWvkKI6gUrRsdS6N+7BHvgE6STY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOQhZYf9zer4jky7LpeJtklNWuuK7NBDBp/F3Zs7YqpPZsZs2Kc8HyaCg2NOd3DPJT0j4AaVLq6p4/QYS1QLaHY7RxsTEVVk3xCQMdHrlTR2IXQkStlZ4PgAHYImnyHoC7AUEOPcGVXhc4MKwUHHyYOEruPUPhpw/r6UL5akVuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=FGEdSHsJ; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=qzcWgjDG reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1741165346; x=1772701346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vqA7WR0bg0u4G+HAomrK/aLC9+18x4n+S7IKkNThfiM=;
  b=FGEdSHsJUzdScXTdYhZDaxdAawHc2qDZosoNyGgeUVrIIunht89aqQqJ
   HbUFHh48AM65l+XSXqsGhMG9kuBuNclOfyJOb6cJVCMoEll6EDKETj/OH
   jbdIelhBCxMNFMdTse2GCSiSzcYRvC/ukcGFFmT1KzbJ6SScr756bTxD2
   4X2TT9k8TUoH3/Vf7vAgXx/kMNl3nO1ma7HamU/roKjhhF4f1fOGyc5nE
   th+OlHdXuqXo5zwZGT4noy59M1frVRKYYf5yCSt4SJuqEP+v66pLAvPVr
   +39vEol0TS7h4+Txq3T3sL3fkuax/hlRo99rFeytb+WN0uJz7CaxMlNDK
   g==;
X-CSE-ConnectionGUID: IH657TY3Tl23yR3Vv1dR/A==
X-CSE-MsgGUID: cgkFUMvxRU6w9KHMn9F1ow==
X-IronPort-AV: E=Sophos;i="6.14,222,1736809200"; 
   d="scan'208";a="42301885"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 05 Mar 2025 10:02:22 +0100
X-CheckPoint: {67C8131E-23-7141A0B0-E6EDEC14}
X-MAIL-CPID: 0BDC1C9894ABA85FF037DCAB1A11A9B5_3
X-Control-Analysis: str=0001.0A00636C.67C8131F.010A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A72F3170EA5;
	Wed,  5 Mar 2025 10:02:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1741165338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vqA7WR0bg0u4G+HAomrK/aLC9+18x4n+S7IKkNThfiM=;
	b=qzcWgjDGS6jWPY+RITIk8yBviKpMKL0y16KSXMlshqTDttq6zKFd8uRh0rjbusm21alLLO
	0zncE1o54zqa2PkjSbvWyACMubP8NqizUU7F39NtdEyf8B7h5zWhZ3ivT6X25sqtCFjSSc
	Bq3JpoZAEKG0N2u2vqMbhZJRAtcHkfgPLIvm7R5McponzskDZSRi22nXnOhJg1CUW3KHx/
	aVeSFRyy4/ATHnHp/9XUjp3UP5VCYqp6++6rG5zw1KmH82cgRaFpKEHzJKR3F3q1GHoDJc
	hgimR61srqwk7i5wU9S6wvO15O4FIatNLRGINZRrOvbwgrcOGQlB24ojz6hXxA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux@ew.tq-group.com, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject:
 Re: [PATCH v3 2/6] dt-bindings: soc: imx93-media-blk-ctrl: Add LDB subnode
 into schema and example
Date: Wed, 05 Mar 2025 10:02:16 +0100
Message-ID: <4414669.ejJDZkT8p0@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250305-dandelion-axolotl-of-excitement-05fa70@krzk-bin>
References:
 <20250304154929.1785200-1-alexander.stein@ew.tq-group.com>
 <20250304154929.1785200-3-alexander.stein@ew.tq-group.com>
 <20250305-dandelion-axolotl-of-excitement-05fa70@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Mittwoch, 5. M=E4rz 2025, 08:13:04 CET schrieb Krzysztof Kozlowski:
> On Tue, Mar 04, 2025 at 04:49:21PM +0100, Alexander Stein wrote:
> > Document the LDB bridge subnode and add the subnode into the example.
> > For the subnode to work, the block control must scan its subnodes and
>=20
> Don't describe drivers, but describe the hardware.

Thanks, I'll rephrase to describe the hardware better regarding LVDS.

>=20
> > bind drivers to them, do not misuse either simple-bus or simple-mfd
> > here.
>=20
> I don't understand that simple-bus or simple-mfd statement. There are no
> such compatibles here.

Same as above, the wording stems from 1cb0c87d27dcc ("dt-bindings: soc:
imx8mp-media-blk-ctrl: Add LDB subnode into schema and example").
I'll drop it to avoid confusion.

>=20
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >  .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 51 +++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-=
blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-b=
lk-ctrl.yaml
> > index b3554e7f9e76d..cd785111928bf 100644
> > --- a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctr=
l.yaml
> > +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctr=
l.yaml
> > @@ -24,6 +24,14 @@ properties:
> >    reg:
> >      maxItems: 1
> > =20
> > +  ranges: true
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 1
> > +
> >    '#power-domain-cells':
> >      const: 1
> > =20
> > @@ -46,9 +54,20 @@ properties:
> >        - const: csi
> >        - const: dsi
> > =20
> > +  bridge@20:
>=20
> @20 looks wrong. Use 'ranges;' and try again your DTS...
>=20
> Binding is supposed to be complete. We have several examples when people
> added children one-by-one, everytime with different reasoning about
> child addressing.
>=20
> So please confirm: this is complete and no other children will ever be
> added here... or you are 100% sure that all future children will be
> unit-addressable (will have unit address and appropriate properties).

This block control is a collection of registers for different purposes:
* MIPI-DSI
* MIPI-CSI
* Parallel camera
* LVDS
* CAMERA_MUX

At lease for parallel camera, another subnode is expected ([1]).

[1] https://lore.kernel.org/all/20240819024001.850065-1-victor.liu@nxp.com/

> BTW, I don't quite get why this is both syscon and has translation for
> child addresses. Does it mean your child does not use the same MMIO as
> parent, thus leading to unsynchronized reg access?

I'm not sure what the best practices are. This LDB has two registers
inside this block. So it seems reasonable to me to indicate this using
a reg property. On the other hand, access is solely done by accessing
via syscon, so unsynchronized reg access is not an issue.

What I am getting from your comments this node should not have 'reg'
property, as it uses syscon anyway.

> > +    type: object
> > +    additionalProperties: true
> > +    properties:
> > +      compatible:
> > +        contains:
> > +          const: fsl,imx93-ldb
> > +
> >  required:
> >    - compatible
> >    - reg
> > +  - ranges
> > +  - '#address-cells'
> > +  - '#size-cells'
> >    - power-domains
> >    - clocks
> >    - clock-names
> > @@ -77,4 +96,36 @@ examples:
> >                 clock-names =3D "apb", "axi", "nic", "disp", "cam",
> >                               "pxp", "lcdif", "isi", "csi", "dsi";
> >        #power-domain-cells =3D <1>;
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <1>;
> > +      ranges =3D <0x0 0x4ac10000 0x10000>;
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
>=20
> Messed indentation.

This is already from the original binding. I'll fix in a separate commit.

Best regards,
Alexander

>=20
> > +        };
>=20
> Best regards,
> Krzysztof
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



