Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A9857D155
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jul 2022 18:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbiGUQSq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jul 2022 12:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbiGUQSM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jul 2022 12:18:12 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E0E89E9A;
        Thu, 21 Jul 2022 09:17:35 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id s204so2570326oif.5;
        Thu, 21 Jul 2022 09:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eGxcFia+56uzVoruJ6OmLxji9P6kTMXtUnj8BikXIyE=;
        b=KUnRyuBEWuC50+ECJCXz8WMMpMgrmbeWAfuYAxtkQq0dHyGSdx3EeyKsZU+BYcckXS
         Pu9UW6HeUNWsluPh7uV58c2XPm9hRp5lgvlUd+5B02ah3E3V83Xe4boOmmBaa8h8GJiS
         x4AWhrD3Wx/Yd1z7W8smD6UQz5kF32VmJJcv2Flr3rUgHrnPC30QEbSKX1KBtyosn7wQ
         f2vbvRtn/l9nTgy6AuuDbGKw8k1H0NFqZPvHbmBAP9JXPBpw0rEEtBf+kVWnCFgcuN90
         zMS/VJHYgtuDu2Nm1U9Zp5s6UItYM+xG+uJe9lcSFx3ukX0uw7V9txuGdTJJxqIEFSYg
         YTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eGxcFia+56uzVoruJ6OmLxji9P6kTMXtUnj8BikXIyE=;
        b=OUnjB2T0OnMWchp8IUUHwvQaW5f4a2LziSSIomd2YesbppczBOy0EhhkqtASu5G9m9
         824LMZTsvcewgp8ernMs6VjMU1gttbyZLS/H8efxj/GSpo3sGPybLZb2ZfzWK9Qj9PCD
         sDWetJwMmdzomRHxpx7QxArGDk4q0Rblsij7wVe9cqFTZp4IFSdTiRAgNwffPnkpaD9L
         X4UuJfm9vkV9xGhE8OJzrMIjnb4KhGzK0CpYh5rfB5qkdY+bDSAza6syQ5rViauA2TRH
         02DknBwUwQzSmNAPEu7rEcLCSJQ49LJX01Uipcd+xeX2laif4oZdkkaovZ1Be5ZO90AG
         41zg==
X-Gm-Message-State: AJIora/ZPMuBK92mdYeyPMoTXqT8wraGWMDw50MyE0g/aq5WnGXgbdFD
        xbs0KqynnrQrkZEauXQVBeDunzTLSek=
X-Google-Smtp-Source: AGRyM1vY1NW/3mI+fQupiNp2OkjhZ8cj2WGuMHa7CZWTplyvcVeo3hlhYOQHuwRNJ7aiw5YaaYiiug==
X-Received: by 2002:a05:6808:159d:b0:33a:7ebf:5385 with SMTP id t29-20020a056808159d00b0033a7ebf5385mr3919415oiw.68.1658420254863;
        Thu, 21 Jul 2022 09:17:34 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id cy18-20020a056830699200b0061cc06a886csm951732otb.9.2022.07.21.09.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:17:34 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, sre@kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lee.jones@linaro.org, Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: [RESEND 2/4 v7] mfd: Add Rockchip rk817 battery charger support
Date:   Thu, 21 Jul 2022 11:17:16 -0500
Message-Id: <20220721161718.29800-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721161718.29800-1-macroalpha82@gmail.com>
References: <20220721161718.29800-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Add rk817 charger support cell to rk808 mfd driver.

Acked-for-mfd-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 drivers/mfd/rk808.c       | 16 ++++++-
 include/linux/mfd/rk808.h | 91 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 4142b638e5fa..283a65b64d2c 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -67,6 +67,10 @@ static bool rk817_is_volatile_reg(struct device *dev, unsigned int reg)
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
@@ -74,7 +78,7 @@ static bool rk817_is_volatile_reg(struct device *dev, unsigned int reg)
 		return true;
 	}
 
-	return true;
+	return false;
 }
 
 static const struct regmap_config rk818_regmap_config = {
@@ -127,6 +131,11 @@ static const struct resource rk817_pwrkey_resources[] = {
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
@@ -166,6 +175,11 @@ static const struct mfd_cell rk817s[] = {
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
index 58602032e642..9af1f3105f80 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -519,6 +519,77 @@ enum rk809_reg_id {
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
+#define RK817_VOL_CUR_CALIB_UPD		BIT(7)
+
+#define RK817_GAS_GAUGE_GG_CON		0x56
+#define RK817_GAS_GAUGE_GG_STS		0x57
+
+#define RK817_BAT_CON			(0x1 << 4)
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
+#define RK817_GAS_GAUGE_DATA0		0x9d
+#define RK817_GAS_GAUGE_DATA1		0x9e
+#define RK817_GAS_GAUGE_DATA2		0x9f
+#define RK817_GAS_GAUGE_DATA3		0xa0
+#define RK817_GAS_GAUGE_DATA4		0xa1
+#define RK817_GAS_GAUGE_DATA5		0xa2
+#define RK817_GAS_GAUGE_CUR_ADC_K0	0xb0
+
 #define RK817_POWER_EN_REG(i)		(0xb1 + (i))
 #define RK817_POWER_SLP_EN_REG(i)	(0xb5 + (i))
 
@@ -544,10 +615,30 @@ enum rk809_reg_id {
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
+#define RK817_BAT_EXS			BIT(7)
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

