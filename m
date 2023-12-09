Return-Path: <linux-pm+bounces-861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EAC80B605
	for <lists+linux-pm@lfdr.de>; Sat,  9 Dec 2023 20:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A91A2B20BD0
	for <lists+linux-pm@lfdr.de>; Sat,  9 Dec 2023 19:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1949E1A279;
	Sat,  9 Dec 2023 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFRBIXcf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596D9AC;
	Sat,  9 Dec 2023 11:22:44 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-286f3e0d010so886471a91.0;
        Sat, 09 Dec 2023 11:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702149764; x=1702754564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jJkDKWbLv2FIBDpQN/BsF6DzATvUZpOfdreFTxN8aM=;
        b=RFRBIXcfxwb65YKnV5ii+7i4aIn2mf3lCU443qTInflj870RGijwiauRFAfUdn59zQ
         KIVLDskJaBUBLgqHF0L3/0sHQf9Cc37gRSHN8l80G1ZWXmFb6HYMWejpO1tV4EXs0gv+
         Q1ERw6s/l9mDMdwtgvhytWiaiWBsJYTstL6/nVm8GGyBGW/vVFv+Cs739NpNVGOO3lju
         jzHTzZHwI+TS8fLkQS7Z+A68G+rCG+uy/TXOdCjqYgNMpqq5XsNbE1hsgbnpkq/KGUjF
         6WoxK2tk8nliLsAzx9ud8coIFQxFQymq0vnad9YGqF6WNKU2COT+s10VCADXQoXMg8vQ
         h3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702149764; x=1702754564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jJkDKWbLv2FIBDpQN/BsF6DzATvUZpOfdreFTxN8aM=;
        b=LeVUMIq5z5xhZj1PUjZyYQ0VfUXAS6YSXDI28IUMjMx0ogi+ot+xgcjhRLyXps1Fgv
         sLdjxPW4PEwBsHJQJtSV3Fso9VYT4QKco5K2aG1QQGQd5DmkhcACysku346XE0bjRKvM
         rBak0yr6TF12XoubZkwZSriNBHdvAwC3qQNOvGWceIijyNQ8wxGtw6hi8g/v5Q9/XeOs
         CJUhppLei8LsZqA3cMk5M+3KsxrScbkN2bSXKDWp5jkSu8JfzIJKUg+fJAx47BbUqWJ8
         2MqZJ5r3CwZEsulQd+6P7RlL85ToX9U/uPWODIgmHKPnGjzjVEPbJq8/DFzv6AC1Gims
         +QGw==
X-Gm-Message-State: AOJu0YxB2I0143Y33Ai3NaRAsTK5zvJpSkbAxcUKdXZPoZMar3zK9L2S
	m49AJaWFDqTHxd50mwLdZ/1iFVSTqMT1X/7vzAg=
X-Google-Smtp-Source: AGHT+IGBpR1wprhPk7ZEmewk26/xx6kB/0TkbNILSN+bOdYBAWVaE9AV8jUx/6ZYbCTEEk3C5Vb5QGb/K83YJdxIWeA=
X-Received: by 2002:a17:90a:7e8b:b0:286:8fa5:7bc7 with SMTP id
 j11-20020a17090a7e8b00b002868fa57bc7mr3569872pjl.2.1702149763703; Sat, 09 Dec
 2023 11:22:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928222130.580487-1-festevam@gmail.com> <20231002-unheard-copy-f9dceb6498a9@spud>
In-Reply-To: <20231002-unheard-copy-f9dceb6498a9@spud>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 9 Dec 2023 16:22:31 -0300
Message-ID: <CAOMZO5Di6Saq_r2k8AkGeANRvXwwx26U=Vf5-Eu-_2Qhu5sDCw@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: thermal: qoriq-thermal: Adjust
 fsl,tmu-range min/maxItems
To: Conor Dooley <conor@kernel.org>
Cc: daniel.lezcano@linaro.org, rafael@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, conor+dt@kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Mon, Oct 2, 2023 at 9:27=E2=80=AFAM Conor Dooley <conor@kernel.org> wrot=
e:

> tbh, this seems like a situation where per compatible constraints should
> be added, since each of the devices listed above has different
> requirements.

Ok, I am trying to add the device constraints as suggested.

For example: I am trying to describe that imx93 has 7 items for fsl,tmu-ran=
ge:

--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
@@ -21,6 +21,7 @@ properties:
     enum:
       - fsl,qoriq-tmu
       - fsl,imx8mq-tmu
+      - fsl,imx93-tmu

   reg:
     maxItems: 1
@@ -33,7 +34,15 @@ properties:
     description: |
       The values to be programmed into TTRnCR, as specified by the SoC
       reference manual. The first cell is TTR0CR, the second is TTR1CR, et=
c.
-    maxItems: 4
+    items:
+      - description: TTR0CR
+      - description: TTR1CR
+      - description: TTR2CR
+      - description: TTR3CR
+      - description: TTR4CR
+      - description: TTR5CR
+      - description: TTR6CR
+    minItems: 4

   fsl,tmu-calibration:
     $ref: /schemas/types.yaml#/definitions/uint32-matrix
@@ -69,15 +78,33 @@ required:
   - fsl,tmu-calibration
   - '#thermal-sensor-cells'

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
+          minItems: 7
+          maxItems: 7
+    else:
+      properties:
+        fsl,tmu-range:
+          maxItems: 4
+
 additionalProperties: false

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

but dt_binding_check fails:

$ make dt_binding_check DT_SCHEMA_FILES=3Dqoriq-thermal.yaml -j12
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/thermal/qoriq-thermal.example.d=
ts
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK Documentation/devicetree/bindings/thermal/qoriq-thermal.example.d=
tb
/home/fabio/linux-next/Documentation/devicetree/bindings/thermal/qoriq-ther=
mal.example.dtb:
tmu@f0000: fsl,tmu-range: [[655360, 589862, 524362, 65642, 0, 0, 0]]
is too short
from schema $id: http://devicetree.org/schemas/thermal/qoriq-thermal.yaml#

What is wrong with the yaml changes to tell that imx93 has 7 items for
fsl,tmu-range?

Thanks

