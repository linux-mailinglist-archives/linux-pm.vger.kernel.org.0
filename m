Return-Path: <linux-pm+bounces-35779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8634BC0BB3
	for <lists+linux-pm@lfdr.de>; Tue, 07 Oct 2025 10:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B4264F54DC
	for <lists+linux-pm@lfdr.de>; Tue,  7 Oct 2025 08:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58092DAFB5;
	Tue,  7 Oct 2025 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBQNsH68"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2511C2D9780
	for <linux-pm@vger.kernel.org>; Tue,  7 Oct 2025 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826115; cv=none; b=hyiYng/uRDEBEZ3QOA+bAsVOFmydxzUztCFeSoekaSZlvUHFSip74Q7eL3X5HITdFnuBp7q/l7R8YHSyJpr/bQVFqWZSJSB2smQkG+0XXKdRwTUYEEFqZgY7FuZBOgI68GGBboXkR9gbHexy72Gn59k87Ln8T2guQCUjUjf2CoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826115; c=relaxed/simple;
	bh=DjJ1vgjQstdJaFuNqie2mOz+vz+GQCcJqKmvB1Vo+W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNZOtdEjOG3qa/+j12l2IFUv8NV2O1zM/Mk9eq19eyK0SpJ5hRtJpxApo9QlLBpwJe4NiOrueQIyzDzLRAG+4tJNBNJpenCy6CUadGckelochnsHNLZM+MOLIcGOBakjV6N4f6ljeoR4JhDBpeiUIQlZF+O3zYS+ouUlSVGGF6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBQNsH68; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57bf912cbf6so6310664e87.3
        for <linux-pm@vger.kernel.org>; Tue, 07 Oct 2025 01:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759826110; x=1760430910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WjfifAnvt7omtcWtAC6HoiCGnm3cPbQmEnl3NjpQZmY=;
        b=fBQNsH68id1Y/kGkhNjpd7mPS+ntU6aJIwJYi9q+xekuYm6mMUkcUCQaRkihQQ22a9
         DOf3wUC4/aUqa0JAqz24yfaION5AgPLOEkEu9eNS9H/8g71voFzT1mjAzNLTUFqrLtYc
         KbZ6M3ji6yN5GgN5iFiGwUcME5Vv11s4xqaLD5X+4Epw1PemuJVsJG+HOgjP/MpVZSlN
         MZaLnnETUhmLrim/zMgFJUVfwquBV6vzszS50Kaz+KlKzWzpuwsEcmJnc5KfugSgDoqb
         9hjKtsv9HIFyd0d+MSyG4YqyNyAbkdj84WI068DMKDdsLC6+rws7AGvN7vqFpLpd8qxg
         PaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759826110; x=1760430910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjfifAnvt7omtcWtAC6HoiCGnm3cPbQmEnl3NjpQZmY=;
        b=BqPR5WD+iPUBwUCgvNJOHKAmJH6z3pn45nc3MO+3XvbAs+4O63mrn00yS+fAR7Kgtj
         r+jyZd5tjkuWJOob0pnKRGxlc/u0pwvE1wEpBDZdqvZVjly0Xmgd5eHy4Rs8hiQXOWcA
         6gFAFbQ2fzNAWe978vRuAH7Gqy2HuLJNBM6Iez58gspByxYgdw2etDNLGEPN/KAMs2F9
         AFz2gs5SxFtI1I66H04gb8aTHnc2ModyDzObd0fJBDO5yDJ1rZyrj0g8qqoBHrIgZQX9
         z+n8V1k0wuKWW1KARjyhpd8pd9ZHVlqo36mk+UtLp/6Gf7yHHwmn+KBKx+fPGTFbKTzp
         1skw==
X-Forwarded-Encrypted: i=1; AJvYcCVvdHib/uAiT5TThhy4FZlUJxerPmDbQUF37h2ANz9ooQ5aO3UIkgqFKL1izgR7RQmL8XNGoMC3Cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKf2F3n5S9mjF8T5oSTrbNI/HiIMKpbMztmjiKMbe7XS/hSHRx
	BNL0yn913jCMtB+jSkX9r6NU5+K7ZPp7o7CqEqJs71PNNxtewD0B54M+
X-Gm-Gg: ASbGncvJ3d6AZw82nIxUhbB29xCIgjgSB3BGCxoOW4VvscBntjuQgdFDY2XUUaDlYEO
	tdsesXAC2gylwdnQiLltzNbo8xzfgyhQmRHoaQwuOLaV2btXj57Auo3/3KUhYNHH68AvOdGg8Ie
	vG6Pky3kXI4IrjBBLPNnjhKwAw8GfKyNUAMMU/XuRlQfG6mdMDWU9hjHzrXvkJckQWMu61+9lru
	vZU5815l1s6hwZ3FqIz1vS2JnW7KpwV/Z7Y0qw4jFQ2SQEzDMdsincfJwWTt9EtBdMdC54lvtCD
	xkNJ0Iq324v4CInYIlkMzI7XrRcSNosS7LvnL4UtopaDyzVOyNJ3zFEmqxUt1SDYmjeQnye5Gsz
	wOmSIA4/sOq83hl4GhC30/Ju4IvRznlN5wGDNKG1WTRIr1T9XMnbPZA==
X-Google-Smtp-Source: AGHT+IGeAjD9L5LXbUGqgoDzxxWOv4cpq97R3lyvrrA9crXR7Irv8HRoFJ8h4YjD9CHyjmPOUB0knw==
X-Received: by 2002:a05:6512:3e04:b0:58b:151:bc0a with SMTP id 2adb3069b0e04-58cbbfc322fmr4367193e87.49.1759826109942;
        Tue, 07 Oct 2025 01:35:09 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118d6e6sm5862425e87.78.2025.10.07.01.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 01:35:08 -0700 (PDT)
Date: Tue, 7 Oct 2025 11:35:05 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [RFC PATCH 12/13] power: supply: bd71828-power: Support ROHM BD72720
Message-ID: <bc0020c6777c324ec6639a94a1492dff493b7950.1759824376.git.mazziesaccount@gmail.com>
References: <cover.1759824376.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FNeSZYeqkJDtuOLg"
Content-Disposition: inline
In-Reply-To: <cover.1759824376.git.mazziesaccount@gmail.com>


--FNeSZYeqkJDtuOLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD72720 is a power management IC with a charger and coulomb
counter block which is closely related to the charger / coulomb counter
found from the BD71815, BD71828, BD71879 which are all supported by the
bd71828-power driver. Due to the similarities it makes sense to support
also the BD72720 with the same driver.

Add basic support for the charger logic on ROHM BD72720.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Note: This patch depends on the series: "power: supply: add charger for
BD71828" by Andreas:
https://lore.kernel.org/all/20250918-bd71828-charger-v5-0-851164839c28@kemn=
ade.info/

NOTE: Fuel-gauging is not supported. You can find an unmaintained
downstream reference-driver with a fuel-gauge example from:
https://github.com/RohmSemiconductor/Linux-Kernel-PMIC-Drivers/releases/tag=
/bd72720-reference-driver-v1
---
 drivers/power/supply/bd71828-power.c | 172 +++++++++++++++++++++++++--
 1 file changed, 160 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/bd71828-power.c b/drivers/power/supply/bd=
71828-power.c
index f667baedeb77..29fda7a52013 100644
--- a/drivers/power/supply/bd71828-power.c
+++ b/drivers/power/supply/bd71828-power.c
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/mfd/rohm-bd71815.h>
 #include <linux/mfd/rohm-bd71828.h>
+#include <linux/mfd/rohm-bd72720.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
@@ -57,6 +58,7 @@ struct pwr_regs {
 	u8 vbat_alm_limit_u;
 	u8 conf;
 	u8 vdcin;
+	u8 vdcin_himask;
 };
=20
 static const struct pwr_regs pwr_regs_bd71828 =3D {
@@ -73,6 +75,7 @@ static const struct pwr_regs pwr_regs_bd71828 =3D {
 	.vbat_alm_limit_u =3D BD71828_REG_ALM_VBAT_LIMIT_U,
 	.conf =3D BD71828_REG_CONF,
 	.vdcin =3D BD71828_REG_VDCIN_U,
+	.vdcin_himask =3D BD7182x_MASK_VDCIN_U,
 };
=20
 static const struct pwr_regs pwr_regs_bd71815 =3D {
@@ -92,10 +95,35 @@ static const struct pwr_regs pwr_regs_bd71815 =3D {
 	.conf =3D BD71815_REG_CONF,
=20
 	.vdcin =3D BD71815_REG_VM_DCIN_U,
+	.vdcin_himask =3D BD7182x_MASK_VDCIN_U,
+};
+
+static struct pwr_regs pwr_regs_bd72720 =3D {
+	.vbat_avg =3D BD72720_REG_VM_SA_VBAT_U,
+	.ibat =3D BD72720_REG_CC_CURCD_U,
+	.ibat_avg =3D BD72720_REG_CC_SA_CURCD_U,
+	.btemp_vth =3D BD72720_REG_VM_BTMP_U,
+	/*
+	 * Note, state 0x40 IMP_CHK. not documented
+	 * on other variants but was still handled in
+	 * existing code. No memory traces as to why.
+	 */
+	.chg_state =3D BD72720_REG_CHG_STATE,
+	.bat_temp =3D BD72720_REG_CHG_BAT_TEMP_STAT,
+	.dcin_stat =3D BD72720_REG_INT_VBUS_SRC,
+	.dcin_collapse_limit =3D -1, /* Automatic. Setting not supported */
+	.chg_set1 =3D BD72720_REG_CHG_SET_1,
+	.chg_en =3D BD72720_REG_CHG_EN,
+	/* 15mV note in data-sheet */
+	.vbat_alm_limit_u =3D BD72720_REG_ALM_VBAT_TH_U,
+	.conf =3D BD72720_REG_CONF, /* o XSTB, only PON. Seprate slave addr */
+	.vdcin =3D BD72720_REG_VM_VBUS_U, /* 10 bits not 11 as with other ICs */
+	.vdcin_himask =3D BD72720_MASK_VDCIN_U,
 };
=20
 struct bd71828_power {
 	struct regmap *regmap;
+	struct regmap *bd72720_genregmap;
 	enum rohm_chip_type chip_type;
 	struct device *dev;
 	struct power_supply *ac;
@@ -107,6 +135,7 @@ struct bd71828_power {
 	int rsens;
 	int (*get_temp)(struct bd71828_power *pwr, int *temp);
 	int (*bat_inserted)(struct bd71828_power *pwr);
+	int (*get_chg_online)(struct bd71828_power *pwr, int *chg_online);
 };
=20
 static int bd7182x_write16(struct bd71828_power *pwr, int reg, u16 val)
@@ -289,6 +318,25 @@ static int bd71828_charge_status(struct bd71828_power =
*pwr,
 	return ret;
 }
=20
+static int bd72720_get_chg_online(struct bd71828_power *pwr, int *chg_onli=
ne)
+{
+	int r, ret;
+
+	/*
+	 * Just a sanity check. Calling this without the bd72720_genregmap
+	 * populated is a driver error.
+	 */
+	WARN_ON(!pwr->bd72720_genregmap);
+	ret =3D regmap_read(pwr->bd72720_genregmap, pwr->regs->dcin_stat, &r);
+	if (ret) {
+		dev_err(pwr->dev, "Failed to read DCIN status. %d\n", ret);
+		return ret;
+	}
+	*chg_online =3D ((r & BD72720_MASK_DCIN_DET) !=3D 0);
+
+	return 0;
+}
+
 static int get_chg_online(struct bd71828_power *pwr, int *chg_online)
 {
 	int r, ret;
@@ -317,24 +365,41 @@ static int get_bat_online(struct bd71828_power *pwr, =
int *bat_online)
 	return 0;
 }
=20
-static int bd71828_bat_inserted(struct bd71828_power *pwr)
+static int __conf_bat_inserted(struct device *dev, struct regmap *regmap, =
int conf_reg)
 {
 	int ret, val;
=20
-	ret =3D regmap_read(pwr->regmap, pwr->regs->conf, &val);
+	ret =3D regmap_read(regmap, conf_reg, &val);
 	if (ret) {
-		dev_err(pwr->dev, "Failed to read CONF register\n");
+		dev_err(dev, "Failed to read CONF register\n");
 		return 0;
 	}
 	ret =3D val & BD7182x_MASK_CONF_PON;
=20
 	if (ret)
-		regmap_update_bits(pwr->regmap, pwr->regs->conf,
-				   BD7182x_MASK_CONF_PON, 0);
+		if (regmap_update_bits(regmap, conf_reg, BD7182x_MASK_CONF_PON, 0))
+			dev_err(dev, "Failed to write CONF register\n");
=20
 	return ret;
 }
=20
+static int bd72720_bat_inserted(struct bd71828_power *pwr)
+{
+	/*
+	 * Just a sanity check. Calling this without the bd72720_genregmap
+	 * populated is a driver error.
+	 */
+	WARN_ON(!pwr->bd72720_genregmap);
+
+	return __conf_bat_inserted(pwr->dev, pwr->bd72720_genregmap,
+				   pwr->regs->conf);
+}
+
+static int bd71828_bat_inserted(struct bd71828_power *pwr)
+{
+	return __conf_bat_inserted(pwr->dev, pwr->regmap, pwr->regs->conf);
+}
+
 static int bd71815_bat_inserted(struct bd71828_power *pwr)
 {
 	int ret, val;
@@ -358,11 +423,13 @@ static int bd71828_init_hardware(struct bd71828_power=
 *pwr)
 	int ret;
=20
 	/* TODO: Collapse limit should come from device-tree ? */
-	ret =3D regmap_write(pwr->regmap, pwr->regs->dcin_collapse_limit,
-			   BD7182x_DCIN_COLLAPSE_DEFAULT);
-	if (ret) {
-		dev_err(pwr->dev, "Failed to write DCIN collapse limit\n");
-		return ret;
+	if (pwr->regs->dcin_collapse_limit !=3D (u8)-1) {
+		ret =3D regmap_write(pwr->regmap, pwr->regs->dcin_collapse_limit,
+				   BD7182x_DCIN_COLLAPSE_DEFAULT);
+		if (ret) {
+			dev_err(pwr->dev, "Failed to write DCIN collapse limit\n");
+			return ret;
+		}
 	}
=20
 	ret =3D pwr->bat_inserted(pwr);
@@ -413,13 +480,13 @@ static int bd71828_charger_get_property(struct power_=
supply *psy,
=20
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
-		ret =3D get_chg_online(pwr, &online);
+		ret =3D pwr->get_chg_online(pwr, &online);
 		if (!ret)
 			val->intval =3D online;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		ret =3D bd7182x_read16_himask(pwr, pwr->regs->vdcin,
-					    BD7182x_MASK_VDCIN_U, &tmp);
+					    pwr->regs->vdcin_himask, &tmp);
 		if (ret)
 			return ret;
=20
@@ -630,6 +697,9 @@ BD_ISR_AC(dcin_ovp_det, "DCIN OVER VOLTAGE", true)
 BD_ISR_DUMMY(dcin_mon_det, "DCIN voltage below threshold")
 BD_ISR_DUMMY(dcin_mon_res, "DCIN voltage above threshold")
=20
+BD_ISR_DUMMY(vbus_curr_limit, "VBUS current limited")
+BD_ISR_DUMMY(vsys_ov_res, "VSYS over-voltage cleared")
+BD_ISR_DUMMY(vsys_ov_det, "VSYS over-voltage")
 BD_ISR_DUMMY(vsys_uv_res, "VSYS under-voltage cleared")
 BD_ISR_DUMMY(vsys_uv_det, "VSYS under-voltage")
 BD_ISR_DUMMY(vsys_low_res, "'VSYS low' cleared")
@@ -878,6 +948,51 @@ static int bd7182x_get_irqs(struct platform_device *pd=
ev,
 		BDIRQ("bd71828-temp-125-over", bd71828_temp_vf125_det),
 		BDIRQ("bd71828-temp-125-under", bd71828_temp_vf125_res),
 	};
+	static const struct bd7182x_irq_res bd72720_irqs[] =3D {
+		BDIRQ("bd72720_int_vbus_rmv", BD_ISR_NAME(dcin_removed)),
+		BDIRQ("bd72720_int_vbus_det", bd7182x_dcin_detected),
+		BDIRQ("bd72720_int_vbus_mon_res", BD_ISR_NAME(dcin_mon_res)),
+		BDIRQ("bd72720_int_vbus_mon_det", BD_ISR_NAME(dcin_mon_det)),
+		BDIRQ("bd72720_int_vsys_mon_res", BD_ISR_NAME(vsys_mon_res)),
+		BDIRQ("bd72720_int_vsys_mon_det", BD_ISR_NAME(vsys_mon_det)),
+		BDIRQ("bd72720_int_vsys_uv_res", BD_ISR_NAME(vsys_uv_res)),
+		BDIRQ("bd72720_int_vsys_uv_det", BD_ISR_NAME(vsys_uv_det)),
+		BDIRQ("bd72720_int_vsys_lo_res", BD_ISR_NAME(vsys_low_res)),
+		BDIRQ("bd72720_int_vsys_lo_det", BD_ISR_NAME(vsys_low_det)),
+		BDIRQ("bd72720_int_vsys_ov_res", BD_ISR_NAME(vsys_ov_res)),
+		BDIRQ("bd72720_int_vsys_ov_det", BD_ISR_NAME(vsys_ov_det)),
+		BDIRQ("bd72720_int_bat_ilim", BD_ISR_NAME(vbus_curr_limit)),
+		BDIRQ("bd72720_int_chg_done", bd718x7_chg_done),
+		BDIRQ("bd72720_int_extemp_tout", BD_ISR_NAME(chg_wdg_temp)),
+		BDIRQ("bd72720_int_chg_wdt_exp", BD_ISR_NAME(chg_wdg)),
+		BDIRQ("bd72720_int_bat_mnt_out", BD_ISR_NAME(rechg_res)),
+		BDIRQ("bd72720_int_bat_mnt_in", BD_ISR_NAME(rechg_det)),
+		BDIRQ("bd72720_int_chg_trns", BD_ISR_NAME(chg_state_changed)),
+
+		BDIRQ("bd72720_int_vbat_mon_res", BD_ISR_NAME(bat_mon_res)),
+		BDIRQ("bd72720_int_vbat_mon_det", BD_ISR_NAME(bat_mon)),
+		BDIRQ("bd72720_int_vbat_sht_res", BD_ISR_NAME(bat_short_res)),
+		BDIRQ("bd72720_int_vbat_sht_det", BD_ISR_NAME(bat_short)),
+		BDIRQ("bd72720_int_vbat_lo_res", BD_ISR_NAME(bat_low_res)),
+		BDIRQ("bd72720_int_vbat_lo_det", BD_ISR_NAME(bat_low)),
+		BDIRQ("bd72720_int_vbat_ov_res", BD_ISR_NAME(bat_ov_res)),
+		BDIRQ("bd72720_int_vbat_ov_det", BD_ISR_NAME(bat_ov)),
+		BDIRQ("bd72720_int_bat_rmv", BD_ISR_NAME(bat_removed)),
+		BDIRQ("bd72720_int_bat_det", BD_ISR_NAME(bat_det)),
+		BDIRQ("bd72720_int_dbat_det", BD_ISR_NAME(bat_dead)),
+		BDIRQ("bd72720_int_bat_temp_trns", BD_ISR_NAME(temp_transit)),
+		BDIRQ("bd72720_int_lobtmp_res", BD_ISR_NAME(temp_bat_low_res)),
+		BDIRQ("bd72720_int_lobtmp_det", BD_ISR_NAME(temp_bat_low)),
+		BDIRQ("bd72720_int_ovbtmp_res", BD_ISR_NAME(temp_bat_hi_res)),
+		BDIRQ("bd72720_int_ovbtmp_det", BD_ISR_NAME(temp_bat_hi)),
+		BDIRQ("bd72720_int_ocur1_res", BD_ISR_NAME(bat_oc1_res)),
+		BDIRQ("bd72720_int_ocur1_det", BD_ISR_NAME(bat_oc1)),
+		BDIRQ("bd72720_int_ocur2_res", BD_ISR_NAME(bat_oc2_res)),
+		BDIRQ("bd72720_int_ocur2_det", BD_ISR_NAME(bat_oc2)),
+		BDIRQ("bd72720_int_ocur3_res", BD_ISR_NAME(bat_oc3_res)),
+		BDIRQ("bd72720_int_ocur3_det", BD_ISR_NAME(bat_oc3)),
+		BDIRQ("bd72720_int_cc_mon2_det", BD_ISR_NAME(bat_cc_mon)),
+	};
 	int num_irqs;
 	const struct bd7182x_irq_res *irqs;
=20
@@ -890,6 +1005,10 @@ static int bd7182x_get_irqs(struct platform_device *p=
dev,
 		irqs =3D &bd71815_irqs[0];
 		num_irqs =3D ARRAY_SIZE(bd71815_irqs);
 		break;
+	case ROHM_CHIP_TYPE_BD72720:
+		irqs =3D &bd72720_irqs[0];
+		num_irqs =3D ARRAY_SIZE(bd72720_irqs);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -979,11 +1098,39 @@ static int bd71828_power_probe(struct platform_devic=
e *pdev)
 		pwr->bat_inserted =3D bd71828_bat_inserted;
 		pwr->get_temp =3D bd71828_get_temp;
 		pwr->regs =3D &pwr_regs_bd71828;
+		pwr->get_chg_online =3D get_chg_online;
 		break;
 	case ROHM_CHIP_TYPE_BD71815:
 		pwr->bat_inserted =3D bd71815_bat_inserted;
 		pwr->get_temp =3D bd71815_get_temp;
 		pwr->regs =3D &pwr_regs_bd71815;
+		pwr->get_chg_online =3D get_chg_online;
+		break;
+	case ROHM_CHIP_TYPE_BD72720:
+
+		/*
+		 * The BD72720 has (most of) the charger related registers
+		 * behind a secondary I2C slave address instead of paging. Most
+		 * of the other BD72720 sub-devices need only access to
+		 * registers behind the other slave addres. Thus the BD72720
+		 * core driver registers the first regmap for the real MFD I2C
+		 * device - and this is what we get here when using the
+		 * dev_get_regmap(parent...). For the charger we however
+		 * (mostly) need the other regmap. The MFD hands it to us via
+		 * platform-data and here we aquire it and use it as main
+		 * regmap for the BD72720 power-supply.
+		 */
+		pwr->bd72720_genregmap =3D pwr->regmap;
+		pwr->regmap =3D *(struct regmap **)dev_get_platdata(&pdev->dev);
+		if (!pwr->regmap)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+					     "No charger regmap\n");
+
+		pwr->bat_inserted =3D bd72720_bat_inserted;
+		pwr->regs =3D &pwr_regs_bd72720;
+		pwr->get_chg_online =3D bd72720_get_chg_online;
+		pwr->get_temp =3D bd71828_get_temp;
+		dev_dbg(pwr->dev, "Found ROHM BD72720\n");
 		break;
 	default:
 		dev_err(pwr->dev, "Unknown PMIC\n");
@@ -1030,6 +1177,7 @@ static int bd71828_power_probe(struct platform_device=
 *pdev)
 static const struct platform_device_id bd71828_charger_id[] =3D {
 	{ "bd71815-power", ROHM_CHIP_TYPE_BD71815 },
 	{ "bd71828-power", ROHM_CHIP_TYPE_BD71828 },
+	{ "bd72720-power", ROHM_CHIP_TYPE_BD72720 },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, bd71828_charger_id);
--=20
2.51.0


--FNeSZYeqkJDtuOLg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmjk0LkACgkQeFA3/03a
ocUhigf/RxuNQ/pDDX/6n8N5+dBB2BR4/LFddU5z2klDK7wailWxNbHyIZW/MFc1
yGUevB3s3Q6nHx2IUxaIQjRMD/XvQcIvQ3SzpI0XKarECX/XBwGBni6T8Z4LMF0P
7gse55E1vYDvd0mHk2Nh6llT1Alr1imMlu4HNmmlgjExLeWrsht2Gpe4x8WHwBih
kgS44WR2eld1Gtf//Aw4B99ea7kpqxmN2UJvrz6khiYnUKAX7ztvFQZQUa0NK3XH
l/GlZO6B0uCGjJQggpfR2an8tQibaGMig+HvHBeFsEz3aQbPLYj7oGMVzArJ5XLD
vqTjYnFTu0Bq23vBLn5YpnzDp5+Lgg==
=5Fzq
-----END PGP SIGNATURE-----

--FNeSZYeqkJDtuOLg--

