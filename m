Return-Path: <linux-pm+bounces-862-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC20380B631
	for <lists+linux-pm@lfdr.de>; Sat,  9 Dec 2023 21:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422571F2107A
	for <lists+linux-pm@lfdr.de>; Sat,  9 Dec 2023 20:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A10D1A5B7;
	Sat,  9 Dec 2023 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hH+mozRq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AD779D0;
	Sat,  9 Dec 2023 20:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E23C433C7;
	Sat,  9 Dec 2023 20:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702153403;
	bh=lvbLWoL6I300vce9V6sV8LitQgamS5joKtOrv2MdGWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hH+mozRqu5e5u9Brka0MUiJSCNAUW7OlDT5vZ9s+++S8JQs8j4lfCCDgCuzbdfKTo
	 ysYeJzW8MCCXTm66FmDcjbkKkeRVQ44YhMePOG5YoLZWXpq4RwaYM+reqIsEd1PLCK
	 7bNMoP84dljX5USDquJ8JvsrMG7U71xfWm0Zr8cpBQZK7iRO9b046k93vRX8yEyc9h
	 64kuZVwT6Qh4TXJ9HOB9qW96UQQdI+T+rKrzNX2LADW8HHH183AfnnFc0tR7eeb6e+
	 XdNG7iVovVTbl6B1M6tXVdcUGFsJjLQ/1OBiMpYZLr3mGDux0YOEfpkesgsfJM+JA4
	 KjzgfqrS7dXmA==
Date: Sat, 9 Dec 2023 20:23:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: daniel.lezcano@linaro.org, rafael@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	conor+dt@kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v3] dt-bindings: thermal: qoriq-thermal: Adjust
 fsl,tmu-range min/maxItems
Message-ID: <20231209-singular-tighten-eef5f7909dcd@spud>
References: <20230928222130.580487-1-festevam@gmail.com>
 <20231002-unheard-copy-f9dceb6498a9@spud>
 <CAOMZO5Di6Saq_r2k8AkGeANRvXwwx26U=Vf5-Eu-_2Qhu5sDCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IaUpqXCtiq54SVnX"
Content-Disposition: inline
In-Reply-To: <CAOMZO5Di6Saq_r2k8AkGeANRvXwwx26U=Vf5-Eu-_2Qhu5sDCw@mail.gmail.com>


--IaUpqXCtiq54SVnX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 09, 2023 at 04:22:31PM -0300, Fabio Estevam wrote:
> Hi Conor,
>=20
> On Mon, Oct 2, 2023 at 9:27=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>=20
> > tbh, this seems like a situation where per compatible constraints should
> > be added, since each of the devices listed above has different
> > requirements.
>=20
> Ok, I am trying to add the device constraints as suggested.
>=20
> For example: I am trying to describe that imx93 has 7 items for fsl,tmu-r=
ange:
>=20
> --- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> @@ -21,6 +21,7 @@ properties:
>      enum:
>        - fsl,qoriq-tmu
>        - fsl,imx8mq-tmu
> +      - fsl,imx93-tmu
>=20
>    reg:
>      maxItems: 1
> @@ -33,7 +34,15 @@ properties:
>      description: |
>        The values to be programmed into TTRnCR, as specified by the SoC
>        reference manual. The first cell is TTR0CR, the second is TTR1CR, =
etc.
> -    maxItems: 4
> +    items:
> +      - description: TTR0CR
> +      - description: TTR1CR
> +      - description: TTR2CR
> +      - description: TTR3CR
> +      - description: TTR4CR
> +      - description: TTR5CR
> +      - description: TTR6CR
> +    minItems: 4
>=20
>    fsl,tmu-calibration:
>      $ref: /schemas/types.yaml#/definitions/uint32-matrix
> @@ -69,15 +78,33 @@ required:
>    - fsl,tmu-calibration
>    - '#thermal-sensor-cells'
>=20
> +

^^ extra newline here I think.

> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx93-tmu
> +    then:
> +      properties:
> +        fsl,tmu-range:
> +          minItems: 7
> +          maxItems: 7
> +    else:
> +      properties:
> +        fsl,tmu-range:
> +          maxItems: 4
> +
>  additionalProperties: false
>=20
>  examples:
>    - |
>      tmu@f0000 {
> -        compatible =3D "fsl,qoriq-tmu";
> +        compatible =3D "fsl,imx93-tmu";
>          reg =3D <0xf0000 0x1000>;
>          interrupts =3D <18 2 0 0>;
> -        fsl,tmu-range =3D <0x000a0000 0x00090026 0x0008004a 0x0001006a>;
> +        fsl,tmu-range =3D <0x000a0000 0x00090026 0x0008004a 0x0001006a 0=
 0 0>;
>          fsl,tmu-calibration =3D <0x00000000 0x00000025>,
>                                <0x00000001 0x00000028>,
>                                <0x00000002 0x0000002d>,
>=20
> but dt_binding_check fails:
>=20
> $ make dt_binding_check DT_SCHEMA_FILES=3Dqoriq-thermal.yaml -j12
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/thermal/qoriq-thermal.example=
=2Edts
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC_CHK Documentation/devicetree/bindings/thermal/qoriq-thermal.example=
=2Edtb
> /home/fabio/linux-next/Documentation/devicetree/bindings/thermal/qoriq-th=
ermal.example.dtb:
> tmu@f0000: fsl,tmu-range: [[655360, 589862, 524362, 65642, 0, 0, 0]]
> is too short
> from schema $id: http://devicetree.org/schemas/thermal/qoriq-thermal.yaml#
>=20
> What is wrong with the yaml changes to tell that imx93 has 7 items for
> fsl,tmu-range?

You're adding the constraints and items at the wrong level AFAICT.
I think something like the below better matches your constraints?

diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml b=
/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
index 145744027234..540169806cc8 100644
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
@@ -33,7 +34,17 @@ properties:
     description: |
       The values to be programmed into TTRnCR, as specified by the SoC
       reference manual. The first cell is TTR0CR, the second is TTR1CR, et=
c.
-    maxItems: 4
+    items:
+      items:
+        - description: TTR0CR
+        - description: TTR1CR
+        - description: TTR2CR
+        - description: TTR3CR
+        - description: TTR4CR
+        - description: TTR5CR
+        - description: TTR6CR
+      minItems: 4
+    maxItems: 1
=20
   fsl,tmu-calibration:
     $ref: /schemas/types.yaml#/definitions/uint32-matrix
@@ -69,15 +80,34 @@ required:
   - fsl,tmu-calibration
   - '#thermal-sensor-cells'
=20
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx93-tmu
+    then:
+      properties:
+        fsl,tmu-range:
+          items:
+            minItems: 7
+    else:
+      properties:
+        fsl,tmu-range:
+          items:
+            maxItems: 4
+
 additionalProperties: false
=20
 examples:
   - |
     tmu@f0000 {
-        compatible =3D "fsl,qoriq-tmu";
+        compatible =3D "fsl,imx93-tmu";
         reg =3D <0xf0000 0x1000>;
         interrupts =3D <18 2 0 0>;
-        fsl,tmu-range =3D <0x000a0000 0x00090026 0x0008004a 0x0001006a>;
+        fsl,tmu-range =3D <0x000a0000 0x00090026 0x0008004a 0x0001006a 0 0=
 0>;
         fsl,tmu-calibration =3D <0x00000000 0x00000025>,
                               <0x00000001 0x00000028>,
                               <0x00000002 0x0000002d>,


--IaUpqXCtiq54SVnX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXTMswAKCRB4tDGHoIJi
0poOAQDVaSuM5mYw5qzIXEsS+8v/59y72ceqp2QwLSd/4nrS0QD/TlYfFeDYl4Wp
lwvXoHXrgEgB3ukZMOJp7RUfEbFCYws=
=S9ye
-----END PGP SIGNATURE-----

--IaUpqXCtiq54SVnX--

