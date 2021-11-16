Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96A1453215
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 13:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbhKPM15 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 07:27:57 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:37652 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbhKPM1z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 07:27:55 -0500
Received: by mail-lf1-f49.google.com with SMTP id c32so52748280lfv.4;
        Tue, 16 Nov 2021 04:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WMO0t1uurBTIxOJVQPcqP087oNF80LPwcuDfiYz5sTc=;
        b=HGeLvGa63Ga9JaPrU2ZSdYPGKAm0gvY0YhnMlXeA1KGDFf+dn7k1Y4rnbYChZv/XNt
         2gPNxrxgRHSDFk8maNd0yhYonXBB6zNGLv2YbDVFMXb81OAxA9TX+zdmC1oTtAmDqTh3
         2ysO5bCXQUYepISwaNok876bsfmWFdLLb3RNCRi2BnTSA7wpXIHqCttfMAWyRpTorxtD
         EAGgaI26VKGkgeev+5hqhlN0Neyt0ErGSOlMIoMvCNEi8JTUY0XF9OSDneTXpCGB6Mfn
         tL48V9Wvxq6sZ1nWPM4WpqUu6HzVZ73euU85U0zbkgaPi3/QnMCHDvyAiPNPIhF/uTF8
         2R9Q==
X-Gm-Message-State: AOAM5320dKnR6uHvt3k6AhVsgMT/T37VUmdP3S/XDE4BOKBQRkTrSU5M
        oXh6Ol7oAq01eabGq5cjvt6NoeYISH8=
X-Google-Smtp-Source: ABdhPJzyWC25zTahuHJUiyGqcWfYWpCE1g//4OwXQ3ZQhPay2qJv95aklcqE7RGr4Wqyt9UJNVNJTA==
X-Received: by 2002:a19:c50f:: with SMTP id w15mr6320960lfe.479.1637065496615;
        Tue, 16 Nov 2021 04:24:56 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id i18sm1745409lfe.186.2021.11.16.04.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:24:56 -0800 (PST)
Date:   Tue, 16 Nov 2021 14:24:48 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, rostokus@gmail.com,
        fan.chen@mediatek.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [RFC PATCH v3 1/9] dt-bindings: battery: Add temperature-capacity
 degradation table
Message-ID: <740503b6b6439e01959016223f1ae464e82824c3.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="deyEGaacXWkbtlxU"
Content-Disposition: inline
In-Reply-To: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--deyEGaacXWkbtlxU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some charger/battery vendors describe the temperature impact to
battery capacity by providing tables with capacity change at
given temperature. Support providing this temperature - capacity
dependency using the simple-battery DT nodes.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 .../bindings/power/supply/battery.yaml        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/=
Documentation/devicetree/bindings/power/supply/battery.yaml
index d56ac484fec5..98cc85b92a71 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
@@ -114,6 +114,25 @@ properties:
       - description: alert when battery temperature is lower than this val=
ue
       - description: alert when battery temperature is higher than this va=
lue
=20
+  temp-degrade-table:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description: |
+      An array of value triplets. First value is "capacity change per degr=
ee C"
+      when temperature differs from 'set point'. Second value is "capacity
+      degradation at given 'set point' temperature" and third value is "the
+      'set-point' temperature" where given degradation is correct.
+      Up to 100 value triplets can be provided to specify different degrad=
ation
+      for different temperature ranges. When capacity change caused by
+      temperatures is computed the range which 'set point' is closest to t=
he
+      current temperature is used. Capacity change should be in units of
+      micro Ah. Temperature is in units of 0.1 C degree.
+    maxItems: 100
+    items:
+      items:
+        - description: capacity drop per degree C in micro Ah
+        - description: capacity drop at 'set point' temperature in micro Ah
+        - description: 'set point' temperature for this range in 0.1 degre=
e C
+
 required:
   - compatible
=20
--=20
2.31.1


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--deyEGaacXWkbtlxU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGToxAACgkQeFA3/03a
ocW2nwgApfdRfgvoVgE1OYI8/dYQ4zoxpWTS4LgDekH3LpcVpox+YXVqzTIznE9M
7Db5cOiqASjiFCp8CYAr7UirTwZl3X6kfbM6bTC1DeqW/Dl6W+FD1bkJego6Zb2e
cUsS6ELoQBLtBEXGlgQp66PH+yI80cydFRUpamI0BDedQDDOcI7cVxXACIyPucZq
6ay1NAavy0w4v68PyfJ/njU+oWnDs1W/Xs2LM7DKISpITOfEyeRVkuz1QMPFmbV6
bKd/sdi43OUhSDhR6a1t5D44phY5GjUqJWCY9hdiGuSXQy68R/+wU3q/tv5b+EIx
ElfEpElXsOiYHKE+OAFLe0kmNdl0Cw==
=a5Bz
-----END PGP SIGNATURE-----

--deyEGaacXWkbtlxU--
