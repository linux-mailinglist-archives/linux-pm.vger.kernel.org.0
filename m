Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EE359ED2B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 22:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbiHWUK7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 16:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiHWUKm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 16:10:42 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97CD9C503;
        Tue, 23 Aug 2022 12:30:21 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 92-20020a9d0be5000000b0063946111607so1129725oth.10;
        Tue, 23 Aug 2022 12:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=eGxcFia+56uzVoruJ6OmLxji9P6kTMXtUnj8BikXIyE=;
        b=QIBY3RUfRPB49TKI0I9a+9yLyc4zDx7RGyFuOQoI6lpMzwFMngro7q2f1JwRbuSweK
         bfnxb5bnoiHAEUKT0vg8fz5gDJnc8YgUdgliEf90yXMgDnmUdYzeV6+fEw7DO7Piafnj
         gUq6yQ5EEB1V6w9cAv5l/0swlIUtyiGg9aBMwz7XxHA3nUjHSWIabLGoVdEOLNQsns5q
         7ToB0PYkj8bnE3GrPFWxwBt2/hjuq+y9FImKwKoGEUezr7gFpZLKOxFY+Lfy6HJp8XY4
         6DcJWL2b+0pcITr8wlERkH0xcDUbemDCfc5zk8vmcPVslkMoc7HdHaHsPEv5Pb167rr3
         8Low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=eGxcFia+56uzVoruJ6OmLxji9P6kTMXtUnj8BikXIyE=;
        b=dMLCTvtvYAO9Y6zli7jvdkIISaWjQeaNDL/R2rbS+0bGWh4WpFPgFv4DljDpCDPgYA
         NTKDa/0jY31VR01gRYbQotogu1/ZksqH975wI5BPFj4D1/S3BohUaTuM5rsADE6AyBDi
         Suyt4HgMPqBsu1wKwoFDAtIaPegHaU7JImMI+l2+dYJYbpCuBxyFGPiG1N/m1HjLptqP
         0zJsaF8QlOtBOC7U5wLP0EYDM59l5I3Pdt8OCTWz+AcVhJ4PkbIpnMFVDD5Ojxu7QIoR
         EpxStodVkwDsurP0YNyEt7hemi1/Q4+gJ8BZT3Xko/WlzTos0sdIB77gQLDO9C7GfcY8
         +nAQ==
X-Gm-Message-State: ACgBeo2U5jg9zQRhN76AUu5ZKQlOJMgkwXyDdt5/oCzPlUITx67mgt5Z
        pOqn6KA5wSdEJEf1PPfcid0=
X-Google-Smtp-Source: AA6agR7oxyEhh5hOQfCrisSksEIxPIBNgDZz/jrNizYoU+zDxihuDD1a2IYT3AsfIRiMLNLHF84PHA==
X-Received: by 2002:a05:6830:25d0:b0:638:c8aa:3eea with SMTP id d16-20020a05683025d000b00638c8aa3eeamr9400544otu.254.1661283021131;
        Tue, 23 Aug 2022 12:30:21 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id f36-20020a056871072400b0011382da43aesm4070372oap.16.2022.08.23.12.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 12:30:20 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, maccraft123mc@gmail.com, sre@kernel.org,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, lee@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH V9 2/4] mfd: Add Rockchip rk817 battery charger support
Date:   Tue, 23 Aug 2022 14:30:13 -0500
Message-Id: <20220823193015.10229-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823193015.10229-1-macroalpha82@gmail.com>
References: <20220823193015.10229-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

