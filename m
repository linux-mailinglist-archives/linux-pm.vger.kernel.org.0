Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE88C3F5706
	for <lists+linux-pm@lfdr.de>; Tue, 24 Aug 2021 06:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhHXEKu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Aug 2021 00:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhHXEKs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Aug 2021 00:10:48 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF40C061575;
        Mon, 23 Aug 2021 21:10:05 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id s21-20020a4ae495000000b0028e499b5921so3361829oov.12;
        Mon, 23 Aug 2021 21:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NAtkwAyVgtC8y4CNGOEmiC9zMuGUaINxIPtLd7hC3ZU=;
        b=dG1wkXNV5VoM4ScyVn9N4wPqsE5IvRdKEu/+pUIIbybOU3C/0Hcf77Smfs+z6F4Ma3
         RyjQa2rlj/ZJAl6AoqrNN+QyG/IK8e0dbYbz/mcGRy+BLlc6dWzfqioNPPZ64RElORtE
         d+JlG9CCyhv9XIAU3qjWZpLz0F87aYVaOIbub6yu/IAtYmjUc3uLDvEVdfJdFIOt1cUU
         gqxzh+qBaVznktKtuwnqWK8bK5+bjIdSG3aXRnHQ7fZBR+gCuziKo1U3TT03N3VJSSCO
         jFr3a0j6WZjTO/0bubyZWLJn6+n1dLKuChrc9okczu25n7ixgo6K0OERNzOW6uN6jaf9
         18hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NAtkwAyVgtC8y4CNGOEmiC9zMuGUaINxIPtLd7hC3ZU=;
        b=ZGP2l56x/w6xfcYUYSEBuROmr5JoUfLuHgfDQgNmASUVoEMqt89NJe4+47rcX/veQX
         BUg9zAGGAtdGs4VQg804zNQeulc4C21sdWcJqTRmsebju/tFc8caA4TACYI2AlBzDcd1
         PxvOSCB2Uixjk9PFsusvuw4Kjd/5WZl+GZub4lw3GhbO3D9yOw7Ny+qvoLmi/Eq78jAS
         1FOrhzVRIQSOwQ23yq8HqQ91xWTFtCqBMgBUA4zdfMmpnSN/jUxBFN3mR0wf4sWDUH08
         6h0tLLT1x8F3Zt8qmzHigBWvjlRXTdPLjLleMuZO887t0o8PdAuAkl5h6UzKCKG6US96
         pI6A==
X-Gm-Message-State: AOAM530P3n7vRiG98x9OXWDe8qWyNwJTqcVWtooEXaR9iPrdKBjbZirB
        HATMMbKjMWb2lztq7GU4SRY=
X-Google-Smtp-Source: ABdhPJwS3M6QPX2haALylLQ5aSlMxyVYdPF6jOprt+PVUI98odnvcMGBaRBq9ibNOLn7jODLKWkqvw==
X-Received: by 2002:a4a:b34c:: with SMTP id n12mr702475ooo.19.1629778204440;
        Mon, 23 Aug 2021 21:10:04 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id i19sm3922818ooe.44.2021.08.23.21.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 21:10:03 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lee.jones@linaro.org, robh+dt@kernel.org, heiko@sntech.de,
        sre@kernel.org, maccraft123mc@gmail.com,
        devicetree@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v4 2/4] mfd: Add Rockchip rk817 battery charger support
Date:   Mon, 23 Aug 2021 23:09:53 -0500
Message-Id: <20210824040955.29112-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824040955.29112-1-macroalpha82@gmail.com>
References: <20210824040955.29112-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Add rk817 charger support cell to rk808 mfd driver.

Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 drivers/mfd/rk808.c       | 16 ++++++-
 include/linux/mfd/rk808.h | 87 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 77ccd31ca1d9..edc779aee667 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -66,6 +66,10 @@ static bool rk817_is_volatile_reg(struct device *dev, unsigned int reg)
 	case RK817_SECONDS_REG ... RK817_WEEKS_REG:
 	case RK817_RTC_STATUS_REG:
 	case RK817_CODEC_DTOP_LPT_SRST:
+	case RK817_GAS_GAUGE_ADC_CONFIG0 ... RK817_GAS_GAUGE_CUR_ADC_K0:
+	case RK817_PMIC_CHRG_STS:
+	case RK817_PMIC_CHRG_OUT:
+	case RK817_PMIC_CHRG_IN:
 	case RK817_INT_STS_REG0:
 	case RK817_INT_STS_REG1:
 	case RK817_INT_STS_REG2:
@@ -73,7 +77,7 @@ static bool rk817_is_volatile_reg(struct device *dev, unsigned int reg)
 		return true;
 	}
 
-	return true;
+	return false;
 }
 
 static const struct regmap_config rk818_regmap_config = {
@@ -126,6 +130,11 @@ static const struct resource rk817_pwrkey_resources[] = {
 	DEFINE_RES_IRQ(RK817_IRQ_PWRON_FALL),
 };
 
+static const struct resource rk817_charger_resources[] = {
+	DEFINE_RES_IRQ(RK817_IRQ_PLUG_IN),
+	DEFINE_RES_IRQ(RK817_IRQ_PLUG_OUT),
+};
+
 static const struct mfd_cell rk805s[] = {
 	{ .name = "rk808-clkout", },
 	{ .name = "rk808-regulator", },
@@ -165,6 +174,11 @@ static const struct mfd_cell rk817s[] = {
 		.resources = &rk817_rtc_resources[0],
 	},
 	{ .name = "rk817-codec",},
+	{
+		.name = "rk817-charger",
+		.num_resources = ARRAY_SIZE(rk817_charger_resources),
+		.resources = &rk817_charger_resources[0],
+	},
 };
 
 static const struct mfd_cell rk818s[] = {
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index a96e6d43ca06..1390432c0222 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -518,6 +518,74 @@ enum rk809_reg_id {
 #define MIC_DIFF_DIS			(0x0 << 7)
 #define MIC_DIFF_EN			(0x1 << 7)
 
+/* RK817 Battery Registers */
+#define RK817_GAS_GAUGE_ADC_CONFIG0	0x50
+#define RK817_GG_EN			(0x1 << 7)
+#define RK817_SYS_VOL_ADC_EN		(0x1 << 6)
+#define RK817_TS_ADC_EN			(0x1 << 5)
+#define RK817_USB_VOL_ADC_EN		(0x1 << 4)
+#define RK817_BAT_VOL_ADC_EN		(0x1 << 3)
+#define RK817_BAT_CUR_ADC_EN		(0x1 << 2)
+
+#define RK817_GAS_GAUGE_ADC_CONFIG1	0x55
+
+#define RK817_CUR_CALIB_UPD		(0x1 << 7)
+#define RK817_VOL_CALIB_UPD		(0x1 << 6)
+
+#define RK817_GAS_GAUGE_GG_CON		0x56
+#define RK817_GAS_GAUGE_GG_STS		0x57
+
+#define RK817_RELAX_VOL_UPD		(0x3 << 2)
+#define RK817_RELAX_STS			(0x1 << 1)
+
+#define RK817_GAS_GAUGE_RELAX_THRE_H	0x58
+#define RK817_GAS_GAUGE_RELAX_THRE_L	0x59
+#define RK817_GAS_GAUGE_OCV_THRE_VOL	0x62
+#define RK817_GAS_GAUGE_OCV_VOL_H	0x63
+#define RK817_GAS_GAUGE_OCV_VOL_L	0x64
+#define RK817_GAS_GAUGE_PWRON_VOL_H	0x6b
+#define RK817_GAS_GAUGE_PWRON_VOL_L	0x6c
+#define RK817_GAS_GAUGE_PWRON_CUR_H	0x6d
+#define RK817_GAS_GAUGE_PWRON_CUR_L	0x6e
+#define RK817_GAS_GAUGE_OFF_CNT		0x6f
+#define RK817_GAS_GAUGE_Q_INIT_H3	0x70
+#define RK817_GAS_GAUGE_Q_INIT_H2	0x71
+#define RK817_GAS_GAUGE_Q_INIT_L1	0x72
+#define RK817_GAS_GAUGE_Q_INIT_L0	0x73
+#define RK817_GAS_GAUGE_Q_PRES_H3	0x74
+#define RK817_GAS_GAUGE_Q_PRES_H2	0x75
+#define RK817_GAS_GAUGE_Q_PRES_L1	0x76
+#define RK817_GAS_GAUGE_Q_PRES_L0	0x77
+#define RK817_GAS_GAUGE_BAT_VOL_H	0x78
+#define RK817_GAS_GAUGE_BAT_VOL_L	0x79
+#define RK817_GAS_GAUGE_BAT_CUR_H	0x7a
+#define RK817_GAS_GAUGE_BAT_CUR_L	0x7b
+#define RK817_GAS_GAUGE_USB_VOL_H	0x7e
+#define RK817_GAS_GAUGE_USB_VOL_L	0x7f
+#define RK817_GAS_GAUGE_SYS_VOL_H	0x80
+#define RK817_GAS_GAUGE_SYS_VOL_L	0x81
+#define RK817_GAS_GAUGE_Q_MAX_H3	0x82
+#define RK817_GAS_GAUGE_Q_MAX_H2	0x83
+#define RK817_GAS_GAUGE_Q_MAX_L1	0x84
+#define RK817_GAS_GAUGE_Q_MAX_L0	0x85
+#define RK817_GAS_GAUGE_SLEEP_CON_SAMP_CUR_H	0x8f
+#define RK817_GAS_GAUGE_SLEEP_CON_SAMP_CUR_L	0x90
+#define RK817_GAS_GAUGE_CAL_OFFSET_H	0x91
+#define RK817_GAS_GAUGE_CAL_OFFSET_L	0x92
+#define RK817_GAS_GAUGE_VCALIB0_H	0x93
+#define RK817_GAS_GAUGE_VCALIB0_L	0x94
+#define RK817_GAS_GAUGE_VCALIB1_H	0x95
+#define RK817_GAS_GAUGE_VCALIB1_L	0x96
+#define RK817_GAS_GAUGE_IOFFSET_H	0x97
+#define RK817_GAS_GAUGE_IOFFSET_L	0x98
+#define RK817_GAS_GAUGE_BAT_R1		0x9a
+#define RK817_GAS_GAUGE_BAT_R2		0x9b
+#define RK817_GAS_GAUGE_BAT_R3		0x9c
+#define RK817_GAS_GAUGE_DATA3		0xa0
+#define RK817_GAS_GAUGE_DATA4		0xa1
+#define RK817_GAS_GAUGE_DATA5		0xa2
+#define RK817_GAS_GAUGE_CUR_ADC_K0	0xb0
+
 #define RK817_POWER_EN_REG(i)		(0xb1 + (i))
 #define RK817_POWER_SLP_EN_REG(i)	(0xb5 + (i))
 
@@ -543,10 +611,29 @@ enum rk809_reg_id {
 #define RK817_LDO_ON_VSEL_REG(idx)	(0xcc + (idx) * 2)
 #define RK817_BOOST_OTG_CFG		(0xde)
 
+#define RK817_PMIC_CHRG_OUT		0xe4
+#define RK817_CHRG_VOL_SEL		(0x07 << 4)
+#define RK817_CHRG_CUR_SEL		(0x07 << 0)
+
+#define RK817_PMIC_CHRG_IN		0xe5
+#define RK817_USB_VLIM_EN		(0x01 << 7)
+#define RK817_USB_VLIM_SEL		(0x07 << 4)
+#define RK817_USB_ILIM_EN		(0x01 << 3)
+#define RK817_USB_ILIM_SEL		(0x07 << 0)
+#define RK817_PMIC_CHRG_TERM		0xe6
+#define RK817_CHRG_TERM_ANA_DIG		(0x01 << 2)
+#define RK817_CHRG_TERM_ANA_SEL		(0x03 << 0)
+#define RK817_CHRG_EN			(0x01 << 6)
+
+#define RK817_PMIC_CHRG_STS		0xeb
+#define RK817_CHG_STS			(0x07 << 4)
+
 #define RK817_ID_MSB			0xed
 #define RK817_ID_LSB			0xee
 
 #define RK817_SYS_STS			0xf0
+#define RK817_PLUG_IN_STS		(0x1 << 6)
+
 #define RK817_SYS_CFG(i)		(0xf1 + (i))
 
 #define RK817_ON_SOURCE_REG		0xf5
-- 
2.25.1

