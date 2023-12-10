Return-Path: <linux-pm+bounces-872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAD780BBDB
	for <lists+linux-pm@lfdr.de>; Sun, 10 Dec 2023 15:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE911F21005
	for <lists+linux-pm@lfdr.de>; Sun, 10 Dec 2023 14:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB5F156FA;
	Sun, 10 Dec 2023 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3/cPbWP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AAA156E7;
	Sun, 10 Dec 2023 14:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44411C433C7;
	Sun, 10 Dec 2023 14:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702219970;
	bh=3/binooFi17goHCXvXfp9GQ4CBOkGguAl3I2yBDFOjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3/cPbWPscFAWlCe5wL/lqpU3Ooy2W8I5e72LHGbXcfNDwJi0vSy6vA1h0qxE3Tkc
	 hd4MTbqDZOUsmlJ1Bs4oRdsIB/BUsc98SZ8gVo9A4+ZqvLK1nQyGJW7gEtXqui8LQ3
	 nmKhWv7Q99V6n+3a88+xXVLmxBlEpAlELaP+c2cPfqd+MBM9IrhSgTipljtMg6gZi3
	 4PCmhcCv3CXrPjC9jDyBv0k/Vm5WYcovBTWHLhc/NZ/Y1xAXco5Ghd/fDbDeikdjrA
	 j/0DBWzLQG4R+tn4o5FK0w7XuSQE7dQ5F/eXbG4j5C55eQm+E9jTcSynQNUQZ//o/B
	 +/vKW3AYbja5g==
Date: Sun, 10 Dec 2023 14:52:45 +0000
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, daniel.lezcano@linaro.org,
	rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org, conor+dt@kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: thermal: qoriq-thermal: Adjust
 fsl,tmu-range min/maxItems
Message-ID: <20231210-stimulant-halogen-e3aaca2279c5@spud>
References: <20230928222130.580487-1-festevam@gmail.com>
 <20231002-unheard-copy-f9dceb6498a9@spud>
 <CAOMZO5Di6Saq_r2k8AkGeANRvXwwx26U=Vf5-Eu-_2Qhu5sDCw@mail.gmail.com>
 <20231209-singular-tighten-eef5f7909dcd@spud>
 <a591318fbba10b764075e9395ddd9f7f@denx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BJsV5mgfpFyB2h7+"
Content-Disposition: inline
In-Reply-To: <a591318fbba10b764075e9395ddd9f7f@denx.de>


--BJsV5mgfpFyB2h7+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 09, 2023 at 05:59:17PM -0300, Fabio Estevam wrote:
> Hi Conor,
>=20
> On 09/12/2023 17:23, Conor Dooley wrote:
>=20
> > You're adding the constraints and items at the wrong level AFAICT.
> > I think something like the below better matches your constraints?
>=20
> Thanks for your example.
>=20
> With your change the fsl,imx93-tmu case works correctly:
> if I pass the number of fsl,tmu-range entries different than 7,
> dt_binding_check correctly complains.
>=20
> However, if I pass 7 entries to fsl,qoriq-tmu it should complain as it
> expects 4, but it

btw, unrelated - minItems seems (from a grep) like it needs to be 2 not
4.

> does not.
>=20
> On top of your patch:
>=20
> --- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> @@ -104,7 +104,7 @@ additionalProperties: false
>  examples:
>    - |
>      tmu@f0000 {
> -        compatible =3D "fsl,imx93-tmu";
> +        compatible =3D "fsl,qoriq-tmu";
>          reg =3D <0xf0000 0x1000>;
>          interrupts =3D <18 2 0 0>;
>          fsl,tmu-range =3D <0x000a0000 0x00090026 0x0008004a 0x0001006a 0=
 0
> 0>;
>=20
> make dt_binding_check DT_SCHEMA_FILES=3Dqoriq-thermal.yaml
>   LINT    Documentation/devicetree/bindings
>   DTEX
> Documentation/devicetree/bindings/thermal/qoriq-thermal.example.dts
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC_CHK
> Documentation/devicetree/bindings/thermal/qoriq-thermal.example.dtb
>=20
> Any suggestions?

I dunno. I spent far far longer than I would like to admit trying to fix
this. Firstly my suggestion here is crap I think and only applies to
___matrices___. I think it needs to be the way you had it in your diff,
but I cannot figure out why it doesn't apply the maxItems constraint.

Perhaps Rob or Krzysztof can figure out what we were overlooking.
The diff in question was something like:

diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml b=
/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
index 145744027234..50787938d605 100644
--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
@@ -21,6 +21,7 @@ properties:
     enum:
       - fsl,qoriq-tmu
       - fsl,imx8mq-tmu
+      - fsl,imx93-tmu
=20
   reg:
     maxItems: 1
@@ -33,7 +34,15 @@ properties:
     description: |
       The values to be programmed into TTRnCR, as specified by the SoC
       reference manual. The first cell is TTR0CR, the second is TTR1CR, et=
c.
-    maxItems: 4
+    minItems: 2
+    items:
+      - description: TTR0CR
+      - description: TTR1CR
+      - description: TTR2CR
+      - description: TTR3CR
+      - description: TTR4CR
+      - description: TTR5CR
+      - description: TTR6CR
=20
   fsl,tmu-calibration:
     $ref: /schemas/types.yaml#/definitions/uint32-matrix
@@ -69,15 +78,30 @@ required:
   - fsl,tmu-calibration
   - '#thermal-sensor-cells'
=20
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx93-tmu
+    then:
+      properties:
+        fsl,tmu-range:
+          minItems: 7
+    else:
+      properties:
+        fsl,tmu-range:
+          maxItems: 4
+
 additionalProperties: false
=20
 examples:
   - |
     tmu@f0000 {
-        compatible =3D "fsl,qoriq-tmu";
+        compatible =3D "fsl,imx8mq-tmu";
         reg =3D <0xf0000 0x1000>;
         interrupts =3D <18 2 0 0>;
-        fsl,tmu-range =3D <0x000a0000 0x00090026 0x0008004a 0x0001006a>;
+        fsl,tmu-range =3D <0x000a0000 0x00090026 0x0008004a 0x0001006a 0x0=
 0x0>;
         fsl,tmu-calibration =3D <0x00000000 0x00000025>,
                               <0x00000001 0x00000028>,
                               <0x00000002 0x0000002d>,


--BJsV5mgfpFyB2h7+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXXQvQAKCRB4tDGHoIJi
0miJAQDX/vQBKsTG7TT8JupLwYME+WkVN4QIUKAEhFGaguZAqAEA3msLFrvO/j00
stHDztSNrHCO4ftHkl6UmATlsCNQiQs=
=txUP
-----END PGP SIGNATURE-----

--BJsV5mgfpFyB2h7+--

