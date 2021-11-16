Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C895453239
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 13:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbhKPMcm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 07:32:42 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:35667 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236341AbhKPMca (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 07:32:30 -0500
Received: by mail-lf1-f50.google.com with SMTP id p16so52853131lfa.2;
        Tue, 16 Nov 2021 04:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=56xLv6JmcjfsI8FlVRwUTjzLIMUQa2SiRCS0GWh88Nc=;
        b=eN7qZPOF9JMKFyIHAZfSVrrkNaZ+oiUtZuSLB1+x6exlRob7LDLBZylytC26MkqbbS
         VwKlECWCgb4u5XsPy9l1KDP75vXTuZ9dblywl3dbsRXdfA0cWUK34gXsmj5SLIFxWnBH
         fEv/7/HnESgQjPpJ+8CBSqGmgRQR84/0As1Ya/zoDs4V4CAC2uNIxzDBKTjx170hKORK
         H72ynRz7hdXL0Dz+2nfus4jKV4m9nWAOzc5vm9RGcBO6GunVtHN10zgPLzQWAUmz3YPX
         Z90sYy8HVpA5bHJUR7pz60S5ZMgiGJGupLA0S4E1/j4tBP9fpy+9lGyzKnkM2KSeFupC
         sE9Q==
X-Gm-Message-State: AOAM5308t+JTRRDXH6sdZrqfFkn4d4nspkvA9795vKoWlQ+ffH1mES6d
        0CDjPHtzH6qBgTL4X0bzT94/QoPDSzE=
X-Google-Smtp-Source: ABdhPJxBZip9rSM/LC4Ed2xHSYrQ60UwRdqpr/NGMtQcLDhbmG4sIZdwtr2H3T96N6E+kdXL2GHk2A==
X-Received: by 2002:a05:6512:3090:: with SMTP id z16mr6364257lfd.335.1637065772419;
        Tue, 16 Nov 2021 04:29:32 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id e20sm1832964ljo.119.2021.11.16.04.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:29:31 -0800 (PST)
Date:   Tue, 16 Nov 2021 14:29:24 +0200
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
Subject: [RFC PATCH v3 8/9] mfd: bd71828, bd71815 prepare for power-supply
 support
Message-ID: <b8be0e3458185f6c5c80a028c091c63ad1bcbd91.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ldloiiX/4CfTWCfw"
Content-Disposition: inline
In-Reply-To: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ldloiiX/4CfTWCfw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add core support for ROHM BD718(15/28/78) PMIC's charger blocks.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
RFCv3:
 - Updated BD71815 IRQ information

drop include/linux/mfd/rohm-bd71827.h
---
 drivers/mfd/rohm-bd71828.c       | 42 +++++++++++++++++----
 include/linux/mfd/rohm-bd71828.h | 65 ++++++++++++++++++++++++++++++++
 include/linux/mfd/rohm-generic.h |  2 +
 3 files changed, 101 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
index 714d9fcbf07b..0dd56c6f827a 100644
--- a/drivers/mfd/rohm-bd71828.c
+++ b/drivers/mfd/rohm-bd71828.c
@@ -45,8 +45,8 @@ static const struct resource bd71828_rtc_irqs[] =3D {
=20
 static struct resource bd71815_power_irqs[] =3D {
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_DCIN_RMV, "bd71815-dcin-rmv"),
-	DEFINE_RES_IRQ_NAMED(BD71815_INT_CLPS_OUT, "bd71815-clps-out"),
-	DEFINE_RES_IRQ_NAMED(BD71815_INT_CLPS_IN, "bd71815-clps-in"),
+	DEFINE_RES_IRQ_NAMED(BD71815_INT_CLPS_OUT, "bd71815-dcin-clps-out"),
+	DEFINE_RES_IRQ_NAMED(BD71815_INT_CLPS_IN, "bd71815-dcin-clps-in"),
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_DCIN_OVP_RES, "bd71815-dcin-ovp-res"),
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_DCIN_OVP_DET, "bd71815-dcin-ovp-det"),
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_DCIN_MON_RES, "bd71815-dcin-mon-res"),
@@ -56,7 +56,7 @@ static struct resource bd71815_power_irqs[] =3D {
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_LOW_RES, "bd71815-vsys-low-res"),
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_LOW_DET, "bd71815-vsys-low-det"),
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_MON_RES, "bd71815-vsys-mon-res"),
-	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_MON_RES, "bd71815-vsys-mon-det"),
+	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_MON_DET, "bd71815-vsys-mon-det"),
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_CHG_WDG_TEMP, "bd71815-chg-wdg-temp"),
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_CHG_WDG_TIME, "bd71815-chg-wdg"),
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_CHG_RECHARGE_RES, "bd71815-rechg-res"),
@@ -87,10 +87,10 @@ static struct resource bd71815_power_irqs[] =3D {
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_BAT_OVER_CURR_2_DET, "bd71815-bat-oc2-de=
t"),
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_BAT_OVER_CURR_3_RES, "bd71815-bat-oc3-re=
s"),
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_BAT_OVER_CURR_3_DET, "bd71815-bat-oc3-de=
t"),
-	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_LOW_RES, "bd71815-bat-low-res"),
-	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_LOW_DET, "bd71815-bat-low-det"),
-	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_HI_RES, "bd71815-bat-hi-res"),
-	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_HI_DET, "bd71815-bat-hi-det"),
+	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_LOW_RES, "bd71815-temp-bat-low-=
res"),
+	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_LOW_DET, "bd71815-temp-bat-low-=
det"),
+	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_HI_RES, "bd71815-temp-bat-hi-re=
s"),
+	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_HI_DET, "bd71815-temp-bat-hi-de=
t"),
 };
=20
 static struct mfd_cell bd71815_mfd_cells[] =3D {
@@ -109,6 +109,29 @@ static struct mfd_cell bd71815_mfd_cells[] =3D {
 	},
 };
=20
+static const struct resource bd71828_power_irqs[] =3D {
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_CHG_TOPOFF_TO_DONE,
+			     "bd71828-chg-done"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_DCIN_DET, "bd71828-pwr-dcin-in"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_DCIN_RMV, "bd71828-pwr-dcin-out"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_BAT_LOW_VOLT_RES,
+			     "bd71828-vbat-normal"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_BAT_LOW_VOLT_DET, "bd71828-vbat-low"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_BAT_HI_DET, "bd71828-btemp-hi"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_BAT_HI_RES, "bd71828-btemp-cool"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_BAT_LOW_DET, "bd71828-btemp-lo"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_BAT_LOW_RES,
+			     "bd71828-btemp-warm"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_CHIP_OVER_VF_DET,
+			     "bd71828-temp-hi"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_CHIP_OVER_VF_RES,
+			     "bd71828-temp-norm"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_CHIP_OVER_125_DET,
+			     "bd71828-temp-125-over"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_CHIP_OVER_125_RES,
+			     "bd71828-temp-125-under"),
+};
+
 static struct mfd_cell bd71828_mfd_cells[] =3D {
 	{ .name =3D "bd71828-pmic", },
 	{ .name =3D "bd71828-gpio", },
@@ -118,8 +141,11 @@ static struct mfd_cell bd71828_mfd_cells[] =3D {
 	 * BD70528 clock gate are the register address and mask.
 	 */
 	{ .name =3D "bd71828-clk", },
-	{ .name =3D "bd71827-power", },
 	{
+		.name =3D "bd71828-power",
+		.resources =3D bd71828_power_irqs,
+		.num_resources =3D ARRAY_SIZE(bd71828_power_irqs),
+	}, {
 		.name =3D "bd71828-rtc",
 		.resources =3D bd71828_rtc_irqs,
 		.num_resources =3D ARRAY_SIZE(bd71828_rtc_irqs),
diff --git a/include/linux/mfd/rohm-bd71828.h b/include/linux/mfd/rohm-bd71=
828.h
index 3b5f3a7db4bd..7e0674f184ee 100644
--- a/include/linux/mfd/rohm-bd71828.h
+++ b/include/linux/mfd/rohm-bd71828.h
@@ -188,6 +188,71 @@ enum {
 /* Charger/Battey */
 #define BD71828_REG_CHG_STATE		0x65
 #define BD71828_REG_CHG_FULL		0xd2
+#define BD71828_REG_CHG_EN		0x6F
+#define BD71828_REG_DCIN_STAT		0x68
+#define BD71828_MASK_DCIN_DET		0x01
+#define BD71828_REG_VDCIN_U		0x9c
+#define BD71828_MASK_CHG_EN		0x01
+#define BD71828_CHG_MASK_DCIN_U		0x0f
+#define BD71828_REG_BAT_STAT		0x67
+#define BD71828_REG_BAT_TEMP		0x6c
+#define BD71828_MASK_BAT_TEMP		0x07
+#define BD71828_BAT_TEMP_OPEN		0x07
+#define BD71828_MASK_BAT_DET		0x20
+#define BD71828_MASK_BAT_DET_DONE	0x10
+#define BD71828_REG_CHG_STATE		0x65
+#define BD71828_REG_VBAT_U		0x8c
+#define BD71828_MASK_VBAT_U		0x0f
+#define BD71828_REG_VBAT_REX_AVG_U	0x92
+
+#define BD71828_REG_OCV_PWRON_U		0x8A
+
+#define BD71828_REG_VBAT_MIN_AVG_U	0x8e
+#define BD71828_REG_VBAT_MIN_AVG_L	0x8f
+
+#define BD71828_REG_CC_CNT3		0xb5
+#define BD71828_REG_CC_CNT2		0xb6
+#define BD71828_REG_CC_CNT1		0xb7
+#define BD71828_REG_CC_CNT0		0xb8
+#define BD71828_REG_CC_CURCD_AVG_U	0xb2
+#define BD71828_MASK_CC_CURCD_AVG_U	0x3f
+#define BD71828_MASK_CC_CUR_DIR		0x80
+#define BD71828_REG_VM_BTMP_U		0xa1
+#define BD71828_REG_VM_BTMP_L		0xa2
+#define BD71828_MASK_VM_BTMP_U		0x0f
+#define BD71828_REG_COULOMB_CTRL	0xc4
+#define BD71828_REG_COULOMB_CTRL2	0xd2
+#define BD71828_MASK_REX_CC_CLR		0x01
+#define BD71828_MASK_FULL_CC_CLR	0x10
+#define BD71828_REG_CC_CNT_FULL3	0xbd
+#define BD71828_REG_CC_CNT_CHG3		0xc1
+
+#define BD71828_REG_VBAT_INITIAL1_U	0x86
+#define BD71828_REG_VBAT_INITIAL1_L	0x87
+
+#define BD71828_REG_VBAT_INITIAL2_U	0x88
+#define BD71828_REG_VBAT_INITIAL2_L	0x89
+
+#define BD71828_REG_IBAT_U		0xb0
+#define BD71828_REG_IBAT_L		0xb1
+
+#define BD71828_REG_IBAT_AVG_U		0xb2
+#define BD71828_REG_IBAT_AVG_L		0xb3
+
+#define BD71828_REG_VSYS_AVG_U		0x96
+#define BD71828_REG_VSYS_AVG_L		0x97
+#define BD71828_REG_VSYS_MIN_AVG_U	0x98
+#define BD71828_REG_VSYS_MIN_AVG_L	0x99
+#define BD71828_REG_CHG_SET1		0x75
+#define BD71828_REG_ALM_VBAT_LIMIT_U	0xaa
+#define BD71828_REG_BATCAP_MON_LIMIT_U	0xcc
+#define BD71828_REG_CONF		0x64
+
+#define BD71828_REG_DCIN_CLPS		0x71
+
+#define BD71828_REG_MEAS_CLEAR		0xaf
+
+
=20
 /* LEDs */
 #define BD71828_REG_LED_CTRL		0x4A
diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-gene=
ric.h
index 35b392a0d73a..b60c2ea3e37c 100644
--- a/include/linux/mfd/rohm-generic.h
+++ b/include/linux/mfd/rohm-generic.h
@@ -14,9 +14,11 @@ enum rohm_chip_type {
 	ROHM_CHIP_TYPE_BD9576,
 	ROHM_CHIP_TYPE_BD70528,
 	ROHM_CHIP_TYPE_BD71815,
+	ROHM_CHIP_TYPE_BD71827,
 	ROHM_CHIP_TYPE_BD71828,
 	ROHM_CHIP_TYPE_BD71837,
 	ROHM_CHIP_TYPE_BD71847,
+	ROHM_CHIP_TYPE_BD71878,
 	ROHM_CHIP_TYPE_AMOUNT
 };
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

--ldloiiX/4CfTWCfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGTpCQACgkQeFA3/03a
ocW8kwgAqhkVVU+KoeklLBg7yRZP7Yc15jxnWIn1ETLT894bhk1/hdUrTL/Ll+nm
y9fXwNfsW9+nU5ydfXTRJ7yEo/5QlNoEECRWt5JcD5PAGC1pWYW2B3r2RawEiWVk
SfhOoPzpHhcELDBWLZSMy9VF9UZEAmqdThWEnDJVpY75aCIbaS0AY8hECNGIgwup
9PPLIRlgPv9kn6BDvUC7OnokKX62N3cnOkjOxL8e0w24gLtQcqkWxIqjoHUB55ru
zlOPMcwWFHE6lCNO4JKoVVyK1Pn3hE0Ez2rytadeYpRSUTPkAwwanbG0DY9qZlTp
O896MwEryfORgXCD4d7x9TY70meNRA==
=TMbO
-----END PGP SIGNATURE-----

--ldloiiX/4CfTWCfw--
