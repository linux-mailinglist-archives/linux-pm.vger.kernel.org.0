Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41A92B02F0
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 11:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgKLKkS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 05:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgKLKkN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 05:40:13 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C8EC0613D1;
        Thu, 12 Nov 2020 02:40:13 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id c20so4142392pfr.8;
        Thu, 12 Nov 2020 02:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pAL7VJIKxzvdehowDaCmn7j/SyMHBaQCLka41WyDZsU=;
        b=JnVuVUksi5qT8KJIYrcpbMcb2BDQyX0PAS+KIweM3uVZPKry4l9nqR9Uy3i8Di6jIp
         PD8G0wGUZvbYP/I1jcXPpJwzvUKWc8JyAu1LJph+Ry0vBvWisI+Ma20ktCRD+gIlPwFP
         /1hEDK1WmioGnUf5BplvlkL4+3u2gdi8PvfV2uS2yQHJNJHIzEaNwYcYwO6Ve97/X7va
         MexM/PYPwuVocVjBiVpgOVPjKvtuB6LcUA+zZZD6rIQ/kRqxZ9eqSPDAmQ0OWZ5mHeWT
         TLrZnss2oJ70g4GlEyPAQRyK1ZrCm4Oj3DLKXcNp9dGF1p2IIUFiZzrMSFMIubmCkxBQ
         RLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pAL7VJIKxzvdehowDaCmn7j/SyMHBaQCLka41WyDZsU=;
        b=Iy7gZWuFRm94fEYUJIDEprq2z29TlZ8BLWb2HSFP7L9m9cIBfnbAyDWiCc9ArzNlFS
         HfjxGFlOUkFCp9+dp4fDzEwaX8Av/FJwgVKVpQk9InfGB1glOkIbcxF88l0RRcvHq5qR
         riNn3l8pV90XMuSdwlGZhTiApwxxTO+/zif56q12gc2XWWHVStZgl9hoF5mqb7S6oLFD
         GkBKYP/MaRUhTPrTbRdrEziROqMLQqU0AQcJTv1Puyi6Y6y49ZsC6FNIDbR1H1fo+Tk3
         GldtkKv2mnyaoYIQDim3P9zfrCfdf24AoCR+B5EASStS7zYuRz8qhIE4LH02erlc5dFf
         0L+w==
X-Gm-Message-State: AOAM531cISMKwiOaIyDGM6p5WiZnJxrKinadRodJKE6tcFqOpm4v+jyp
        y6Kas1tckEqOhjHgE/j7AKw=
X-Google-Smtp-Source: ABdhPJxGVswqb4zq42HcShw0xR41Em7+hik8S5Ymt86nJndWan6qxrvXICJzi9+oq1PlpyWFpZilBg==
X-Received: by 2002:a63:c55:: with SMTP id 21mr24420259pgm.392.1605177612679;
        Thu, 12 Nov 2020 02:40:12 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:47a:a27:cf8e:7817:51df:a883])
        by smtp.gmail.com with ESMTPSA id mp16sm6414094pjb.13.2020.11.12.02.40.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 02:40:12 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v7 02/11] mfd: mt6360: Remove redundant brackets around raw numbers
Date:   Thu, 12 Nov 2020 18:39:49 +0800
Message-Id: <1605177598-23501-3-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Remove redundant brackets around raw numbers.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c  | 172 +++++++++----------
 include/linux/mfd/mt6360.h | 410 ++++++++++++++++++++++-----------------------
 2 files changed, 291 insertions(+), 291 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index c7a955f..befee70 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -17,107 +17,107 @@
 #include <linux/mfd/mt6360.h>
 
 /* reg 0 -> 0 ~ 7 */
-#define MT6360_CHG_TREG_EVT		(4)
-#define MT6360_CHG_AICR_EVT		(5)
-#define MT6360_CHG_MIVR_EVT		(6)
-#define MT6360_PWR_RDY_EVT		(7)
+#define MT6360_CHG_TREG_EVT		4
+#define MT6360_CHG_AICR_EVT		5
+#define MT6360_CHG_MIVR_EVT		6
+#define MT6360_PWR_RDY_EVT		7
 /* REG 1 -> 8 ~ 15 */
-#define MT6360_CHG_BATSYSUV_EVT		(9)
-#define MT6360_FLED_CHG_VINOVP_EVT	(11)
-#define MT6360_CHG_VSYSUV_EVT		(12)
-#define MT6360_CHG_VSYSOV_EVT		(13)
-#define MT6360_CHG_VBATOV_EVT		(14)
-#define MT6360_CHG_VBUSOV_EVT		(15)
+#define MT6360_CHG_BATSYSUV_EVT		9
+#define MT6360_FLED_CHG_VINOVP_EVT	11
+#define MT6360_CHG_VSYSUV_EVT		12
+#define MT6360_CHG_VSYSOV_EVT		13
+#define MT6360_CHG_VBATOV_EVT		14
+#define MT6360_CHG_VBUSOV_EVT		15
 /* REG 2 -> 16 ~ 23 */
 /* REG 3 -> 24 ~ 31 */
-#define MT6360_WD_PMU_DET		(25)
-#define MT6360_WD_PMU_DONE		(26)
-#define MT6360_CHG_TMRI			(27)
-#define MT6360_CHG_ADPBADI		(29)
-#define MT6360_CHG_RVPI			(30)
-#define MT6360_OTPI			(31)
+#define MT6360_WD_PMU_DET		25
+#define MT6360_WD_PMU_DONE		26
+#define MT6360_CHG_TMRI			27
+#define MT6360_CHG_ADPBADI		29
+#define MT6360_CHG_RVPI			30
+#define MT6360_OTPI			31
 /* REG 4 -> 32 ~ 39 */
-#define MT6360_CHG_AICCMEASL		(32)
-#define MT6360_CHGDET_DONEI		(34)
-#define MT6360_WDTMRI			(35)
-#define MT6360_SSFINISHI		(36)
-#define MT6360_CHG_RECHGI		(37)
-#define MT6360_CHG_TERMI		(38)
-#define MT6360_CHG_IEOCI		(39)
+#define MT6360_CHG_AICCMEASL		32
+#define MT6360_CHGDET_DONEI		34
+#define MT6360_WDTMRI			35
+#define MT6360_SSFINISHI		36
+#define MT6360_CHG_RECHGI		37
+#define MT6360_CHG_TERMI		38
+#define MT6360_CHG_IEOCI		39
 /* REG 5 -> 40 ~ 47 */
-#define MT6360_PUMPX_DONEI		(40)
-#define MT6360_BAT_OVP_ADC_EVT		(41)
-#define MT6360_TYPEC_OTP_EVT		(42)
-#define MT6360_ADC_WAKEUP_EVT		(43)
-#define MT6360_ADC_DONEI		(44)
-#define MT6360_BST_BATUVI		(45)
-#define MT6360_BST_VBUSOVI		(46)
-#define MT6360_BST_OLPI			(47)
+#define MT6360_PUMPX_DONEI		40
+#define MT6360_BAT_OVP_ADC_EVT		41
+#define MT6360_TYPEC_OTP_EVT		42
+#define MT6360_ADC_WAKEUP_EVT		43
+#define MT6360_ADC_DONEI		44
+#define MT6360_BST_BATUVI		45
+#define MT6360_BST_VBUSOVI		46
+#define MT6360_BST_OLPI			47
 /* REG 6 -> 48 ~ 55 */
-#define MT6360_ATTACH_I			(48)
-#define MT6360_DETACH_I			(49)
-#define MT6360_QC30_STPDONE		(51)
-#define MT6360_QC_VBUSDET_DONE		(52)
-#define MT6360_HVDCP_DET		(53)
-#define MT6360_CHGDETI			(54)
-#define MT6360_DCDTI			(55)
+#define MT6360_ATTACH_I			48
+#define MT6360_DETACH_I			49
+#define MT6360_QC30_STPDONE		51
+#define MT6360_QC_VBUSDET_DONE		52
+#define MT6360_HVDCP_DET		53
+#define MT6360_CHGDETI			54
+#define MT6360_DCDTI			55
 /* REG 7 -> 56 ~ 63 */
-#define MT6360_FOD_DONE_EVT		(56)
-#define MT6360_FOD_OV_EVT		(57)
-#define MT6360_CHRDET_UVP_EVT		(58)
-#define MT6360_CHRDET_OVP_EVT		(59)
-#define MT6360_CHRDET_EXT_EVT		(60)
-#define MT6360_FOD_LR_EVT		(61)
-#define MT6360_FOD_HR_EVT		(62)
-#define MT6360_FOD_DISCHG_FAIL_EVT	(63)
+#define MT6360_FOD_DONE_EVT		56
+#define MT6360_FOD_OV_EVT		57
+#define MT6360_CHRDET_UVP_EVT		58
+#define MT6360_CHRDET_OVP_EVT		59
+#define MT6360_CHRDET_EXT_EVT		60
+#define MT6360_FOD_LR_EVT		61
+#define MT6360_FOD_HR_EVT		62
+#define MT6360_FOD_DISCHG_FAIL_EVT	63
 /* REG 8 -> 64 ~ 71 */
-#define MT6360_USBID_EVT		(64)
-#define MT6360_APWDTRST_EVT		(65)
-#define MT6360_EN_EVT			(66)
-#define MT6360_QONB_RST_EVT		(67)
-#define MT6360_MRSTB_EVT		(68)
-#define MT6360_OTP_EVT			(69)
-#define MT6360_VDDAOV_EVT		(70)
-#define MT6360_SYSUV_EVT		(71)
+#define MT6360_USBID_EVT		64
+#define MT6360_APWDTRST_EVT		65
+#define MT6360_EN_EVT			66
+#define MT6360_QONB_RST_EVT		67
+#define MT6360_MRSTB_EVT		68
+#define MT6360_OTP_EVT			69
+#define MT6360_VDDAOV_EVT		70
+#define MT6360_SYSUV_EVT		71
 /* REG 9 -> 72 ~ 79 */
-#define MT6360_FLED_STRBPIN_EVT		(72)
-#define MT6360_FLED_TORPIN_EVT		(73)
-#define MT6360_FLED_TX_EVT		(74)
-#define MT6360_FLED_LVF_EVT		(75)
-#define MT6360_FLED2_SHORT_EVT		(78)
-#define MT6360_FLED1_SHORT_EVT		(79)
+#define MT6360_FLED_STRBPIN_EVT		72
+#define MT6360_FLED_TORPIN_EVT		73
+#define MT6360_FLED_TX_EVT		74
+#define MT6360_FLED_LVF_EVT		75
+#define MT6360_FLED2_SHORT_EVT		78
+#define MT6360_FLED1_SHORT_EVT		79
 /* REG 10 -> 80 ~ 87 */
-#define MT6360_FLED2_STRB_EVT		(80)
-#define MT6360_FLED1_STRB_EVT		(81)
-#define MT6360_FLED2_STRB_TO_EVT	(82)
-#define MT6360_FLED1_STRB_TO_EVT	(83)
-#define MT6360_FLED2_TOR_EVT		(84)
-#define MT6360_FLED1_TOR_EVT		(85)
+#define MT6360_FLED2_STRB_EVT		80
+#define MT6360_FLED1_STRB_EVT		81
+#define MT6360_FLED2_STRB_TO_EVT	82
+#define MT6360_FLED1_STRB_TO_EVT	83
+#define MT6360_FLED2_TOR_EVT		84
+#define MT6360_FLED1_TOR_EVT		85
 /* REG 11 -> 88 ~ 95 */
 /* REG 12 -> 96 ~ 103 */
-#define MT6360_BUCK1_PGB_EVT		(96)
-#define MT6360_BUCK1_OC_EVT		(100)
-#define MT6360_BUCK1_OV_EVT		(101)
-#define MT6360_BUCK1_UV_EVT		(102)
+#define MT6360_BUCK1_PGB_EVT		96
+#define MT6360_BUCK1_OC_EVT		100
+#define MT6360_BUCK1_OV_EVT		101
+#define MT6360_BUCK1_UV_EVT		102
 /* REG 13 -> 104 ~ 111 */
-#define MT6360_BUCK2_PGB_EVT		(104)
-#define MT6360_BUCK2_OC_EVT		(108)
-#define MT6360_BUCK2_OV_EVT		(109)
-#define MT6360_BUCK2_UV_EVT		(110)
+#define MT6360_BUCK2_PGB_EVT		104
+#define MT6360_BUCK2_OC_EVT		108
+#define MT6360_BUCK2_OV_EVT		109
+#define MT6360_BUCK2_UV_EVT		110
 /* REG 14 -> 112 ~ 119 */
-#define MT6360_LDO1_OC_EVT		(113)
-#define MT6360_LDO2_OC_EVT		(114)
-#define MT6360_LDO3_OC_EVT		(115)
-#define MT6360_LDO5_OC_EVT		(117)
-#define MT6360_LDO6_OC_EVT		(118)
-#define MT6360_LDO7_OC_EVT		(119)
+#define MT6360_LDO1_OC_EVT		113
+#define MT6360_LDO2_OC_EVT		114
+#define MT6360_LDO3_OC_EVT		115
+#define MT6360_LDO5_OC_EVT		117
+#define MT6360_LDO6_OC_EVT		118
+#define MT6360_LDO7_OC_EVT		119
 /* REG 15 -> 120 ~ 127 */
-#define MT6360_LDO1_PGB_EVT		(121)
-#define MT6360_LDO2_PGB_EVT		(122)
-#define MT6360_LDO3_PGB_EVT		(123)
-#define MT6360_LDO5_PGB_EVT		(125)
-#define MT6360_LDO6_PGB_EVT		(126)
-#define MT6360_LDO7_PGB_EVT		(127)
+#define MT6360_LDO1_PGB_EVT		121
+#define MT6360_LDO2_PGB_EVT		122
+#define MT6360_LDO3_PGB_EVT		123
+#define MT6360_LDO5_PGB_EVT		125
+#define MT6360_LDO6_PGB_EVT		126
+#define MT6360_LDO7_PGB_EVT		127
 
 static const struct regmap_irq mt6360_pmu_irqs[] =  {
 	REGMAP_IRQ_REG_LINE(MT6360_CHG_TREG_EVT, 8),
diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
index ea13040..72edf13 100644
--- a/include/linux/mfd/mt6360.h
+++ b/include/linux/mfd/mt6360.h
@@ -16,10 +16,10 @@ enum {
 	MT6360_SLAVE_MAX,
 };
 
-#define MT6360_PMU_SLAVEID	(0x34)
-#define MT6360_PMIC_SLAVEID	(0x1A)
-#define MT6360_LDO_SLAVEID	(0x64)
-#define MT6360_TCPC_SLAVEID	(0x4E)
+#define MT6360_PMU_SLAVEID	0x34
+#define MT6360_PMIC_SLAVEID	0x1A
+#define MT6360_LDO_SLAVEID	0x64
+#define MT6360_TCPC_SLAVEID	0x4E
 
 struct mt6360_pmu_data {
 	struct i2c_client *i2c[MT6360_SLAVE_MAX];
@@ -30,211 +30,211 @@ struct mt6360_pmu_data {
 };
 
 /* PMU register defininition */
-#define MT6360_PMU_DEV_INFO			(0x00)
-#define MT6360_PMU_CORE_CTRL1			(0x01)
-#define MT6360_PMU_RST1				(0x02)
-#define MT6360_PMU_CRCEN			(0x03)
-#define MT6360_PMU_RST_PAS_CODE1		(0x04)
-#define MT6360_PMU_RST_PAS_CODE2		(0x05)
-#define MT6360_PMU_CORE_CTRL2			(0x06)
-#define MT6360_PMU_TM_PAS_CODE1			(0x07)
-#define MT6360_PMU_TM_PAS_CODE2			(0x08)
-#define MT6360_PMU_TM_PAS_CODE3			(0x09)
-#define MT6360_PMU_TM_PAS_CODE4			(0x0A)
-#define MT6360_PMU_IRQ_IND			(0x0B)
-#define MT6360_PMU_IRQ_MASK			(0x0C)
-#define MT6360_PMU_IRQ_SET			(0x0D)
-#define MT6360_PMU_SHDN_CTRL			(0x0E)
-#define MT6360_PMU_TM_INF			(0x0F)
-#define MT6360_PMU_I2C_CTRL			(0x10)
-#define MT6360_PMU_CHG_CTRL1			(0x11)
-#define MT6360_PMU_CHG_CTRL2			(0x12)
-#define MT6360_PMU_CHG_CTRL3			(0x13)
-#define MT6360_PMU_CHG_CTRL4			(0x14)
-#define MT6360_PMU_CHG_CTRL5			(0x15)
-#define MT6360_PMU_CHG_CTRL6			(0x16)
-#define MT6360_PMU_CHG_CTRL7			(0x17)
-#define MT6360_PMU_CHG_CTRL8			(0x18)
-#define MT6360_PMU_CHG_CTRL9			(0x19)
-#define MT6360_PMU_CHG_CTRL10			(0x1A)
-#define MT6360_PMU_CHG_CTRL11			(0x1B)
-#define MT6360_PMU_CHG_CTRL12			(0x1C)
-#define MT6360_PMU_CHG_CTRL13			(0x1D)
-#define MT6360_PMU_CHG_CTRL14			(0x1E)
-#define MT6360_PMU_CHG_CTRL15			(0x1F)
-#define MT6360_PMU_CHG_CTRL16			(0x20)
-#define MT6360_PMU_CHG_AICC_RESULT		(0x21)
-#define MT6360_PMU_DEVICE_TYPE			(0x22)
-#define MT6360_PMU_QC_CONTROL1			(0x23)
-#define MT6360_PMU_QC_CONTROL2			(0x24)
-#define MT6360_PMU_QC30_CONTROL1		(0x25)
-#define MT6360_PMU_QC30_CONTROL2		(0x26)
-#define MT6360_PMU_USB_STATUS1			(0x27)
-#define MT6360_PMU_QC_STATUS1			(0x28)
-#define MT6360_PMU_QC_STATUS2			(0x29)
-#define MT6360_PMU_CHG_PUMP			(0x2A)
-#define MT6360_PMU_CHG_CTRL17			(0x2B)
-#define MT6360_PMU_CHG_CTRL18			(0x2C)
-#define MT6360_PMU_CHRDET_CTRL1			(0x2D)
-#define MT6360_PMU_CHRDET_CTRL2			(0x2E)
-#define MT6360_PMU_DPDN_CTRL			(0x2F)
-#define MT6360_PMU_CHG_HIDDEN_CTRL1		(0x30)
-#define MT6360_PMU_CHG_HIDDEN_CTRL2		(0x31)
-#define MT6360_PMU_CHG_HIDDEN_CTRL3		(0x32)
-#define MT6360_PMU_CHG_HIDDEN_CTRL4		(0x33)
-#define MT6360_PMU_CHG_HIDDEN_CTRL5		(0x34)
-#define MT6360_PMU_CHG_HIDDEN_CTRL6		(0x35)
-#define MT6360_PMU_CHG_HIDDEN_CTRL7		(0x36)
-#define MT6360_PMU_CHG_HIDDEN_CTRL8		(0x37)
-#define MT6360_PMU_CHG_HIDDEN_CTRL9		(0x38)
-#define MT6360_PMU_CHG_HIDDEN_CTRL10		(0x39)
-#define MT6360_PMU_CHG_HIDDEN_CTRL11		(0x3A)
-#define MT6360_PMU_CHG_HIDDEN_CTRL12		(0x3B)
-#define MT6360_PMU_CHG_HIDDEN_CTRL13		(0x3C)
-#define MT6360_PMU_CHG_HIDDEN_CTRL14		(0x3D)
-#define MT6360_PMU_CHG_HIDDEN_CTRL15		(0x3E)
-#define MT6360_PMU_CHG_HIDDEN_CTRL16		(0x3F)
-#define MT6360_PMU_CHG_HIDDEN_CTRL17		(0x40)
-#define MT6360_PMU_CHG_HIDDEN_CTRL18		(0x41)
-#define MT6360_PMU_CHG_HIDDEN_CTRL19		(0x42)
-#define MT6360_PMU_CHG_HIDDEN_CTRL20		(0x43)
-#define MT6360_PMU_CHG_HIDDEN_CTRL21		(0x44)
-#define MT6360_PMU_CHG_HIDDEN_CTRL22		(0x45)
-#define MT6360_PMU_CHG_HIDDEN_CTRL23		(0x46)
-#define MT6360_PMU_CHG_HIDDEN_CTRL24		(0x47)
-#define MT6360_PMU_CHG_HIDDEN_CTRL25		(0x48)
-#define MT6360_PMU_BC12_CTRL			(0x49)
-#define MT6360_PMU_CHG_STAT			(0x4A)
-#define MT6360_PMU_RESV1			(0x4B)
-#define MT6360_PMU_TYPEC_OTP_TH_SEL_CODEH	(0x4E)
-#define MT6360_PMU_TYPEC_OTP_TH_SEL_CODEL	(0x4F)
-#define MT6360_PMU_TYPEC_OTP_HYST_TH		(0x50)
-#define MT6360_PMU_TYPEC_OTP_CTRL		(0x51)
-#define MT6360_PMU_ADC_BAT_DATA_H		(0x52)
-#define MT6360_PMU_ADC_BAT_DATA_L		(0x53)
-#define MT6360_PMU_IMID_BACKBST_ON		(0x54)
-#define MT6360_PMU_IMID_BACKBST_OFF		(0x55)
-#define MT6360_PMU_ADC_CONFIG			(0x56)
-#define MT6360_PMU_ADC_EN2			(0x57)
-#define MT6360_PMU_ADC_IDLE_T			(0x58)
-#define MT6360_PMU_ADC_RPT_1			(0x5A)
-#define MT6360_PMU_ADC_RPT_2			(0x5B)
-#define MT6360_PMU_ADC_RPT_3			(0x5C)
-#define MT6360_PMU_ADC_RPT_ORG1			(0x5D)
-#define MT6360_PMU_ADC_RPT_ORG2			(0x5E)
-#define MT6360_PMU_BAT_OVP_TH_SEL_CODEH		(0x5F)
-#define MT6360_PMU_BAT_OVP_TH_SEL_CODEL		(0x60)
-#define MT6360_PMU_CHG_CTRL19			(0x61)
-#define MT6360_PMU_VDDASUPPLY			(0x62)
-#define MT6360_PMU_BC12_MANUAL			(0x63)
-#define MT6360_PMU_CHGDET_FUNC			(0x64)
-#define MT6360_PMU_FOD_CTRL			(0x65)
-#define MT6360_PMU_CHG_CTRL20			(0x66)
-#define MT6360_PMU_CHG_HIDDEN_CTRL26		(0x67)
-#define MT6360_PMU_CHG_HIDDEN_CTRL27		(0x68)
-#define MT6360_PMU_RESV2			(0x69)
-#define MT6360_PMU_USBID_CTRL1			(0x6D)
-#define MT6360_PMU_USBID_CTRL2			(0x6E)
-#define MT6360_PMU_USBID_CTRL3			(0x6F)
-#define MT6360_PMU_FLED_CFG			(0x70)
-#define MT6360_PMU_RESV3			(0x71)
-#define MT6360_PMU_FLED1_CTRL			(0x72)
-#define MT6360_PMU_FLED_STRB_CTRL		(0x73)
-#define MT6360_PMU_FLED1_STRB_CTRL2		(0x74)
-#define MT6360_PMU_FLED1_TOR_CTRL		(0x75)
-#define MT6360_PMU_FLED2_CTRL			(0x76)
-#define MT6360_PMU_RESV4			(0x77)
-#define MT6360_PMU_FLED2_STRB_CTRL2		(0x78)
-#define MT6360_PMU_FLED2_TOR_CTRL		(0x79)
-#define MT6360_PMU_FLED_VMIDTRK_CTRL1		(0x7A)
-#define MT6360_PMU_FLED_VMID_RTM		(0x7B)
-#define MT6360_PMU_FLED_VMIDTRK_CTRL2		(0x7C)
-#define MT6360_PMU_FLED_PWSEL			(0x7D)
-#define MT6360_PMU_FLED_EN			(0x7E)
-#define MT6360_PMU_FLED_Hidden1			(0x7F)
-#define MT6360_PMU_RGB_EN			(0x80)
-#define MT6360_PMU_RGB1_ISNK			(0x81)
-#define MT6360_PMU_RGB2_ISNK			(0x82)
-#define MT6360_PMU_RGB3_ISNK			(0x83)
-#define MT6360_PMU_RGB_ML_ISNK			(0x84)
-#define MT6360_PMU_RGB1_DIM			(0x85)
-#define MT6360_PMU_RGB2_DIM			(0x86)
-#define MT6360_PMU_RGB3_DIM			(0x87)
-#define MT6360_PMU_RESV5			(0x88)
-#define MT6360_PMU_RGB12_Freq			(0x89)
-#define MT6360_PMU_RGB34_Freq			(0x8A)
-#define MT6360_PMU_RGB1_Tr			(0x8B)
-#define MT6360_PMU_RGB1_Tf			(0x8C)
-#define MT6360_PMU_RGB1_TON_TOFF		(0x8D)
-#define MT6360_PMU_RGB2_Tr			(0x8E)
-#define MT6360_PMU_RGB2_Tf			(0x8F)
-#define MT6360_PMU_RGB2_TON_TOFF		(0x90)
-#define MT6360_PMU_RGB3_Tr			(0x91)
-#define MT6360_PMU_RGB3_Tf			(0x92)
-#define MT6360_PMU_RGB3_TON_TOFF		(0x93)
-#define MT6360_PMU_RGB_Hidden_CTRL1		(0x94)
-#define MT6360_PMU_RGB_Hidden_CTRL2		(0x95)
-#define MT6360_PMU_RESV6			(0x97)
-#define MT6360_PMU_SPARE1			(0x9A)
-#define MT6360_PMU_SPARE2			(0xA0)
-#define MT6360_PMU_SPARE3			(0xB0)
-#define MT6360_PMU_SPARE4			(0xC0)
-#define MT6360_PMU_CHG_IRQ1			(0xD0)
-#define MT6360_PMU_CHG_IRQ2			(0xD1)
-#define MT6360_PMU_CHG_IRQ3			(0xD2)
-#define MT6360_PMU_CHG_IRQ4			(0xD3)
-#define MT6360_PMU_CHG_IRQ5			(0xD4)
-#define MT6360_PMU_CHG_IRQ6			(0xD5)
-#define MT6360_PMU_QC_IRQ			(0xD6)
-#define MT6360_PMU_FOD_IRQ			(0xD7)
-#define MT6360_PMU_BASE_IRQ			(0xD8)
-#define MT6360_PMU_FLED_IRQ1			(0xD9)
-#define MT6360_PMU_FLED_IRQ2			(0xDA)
-#define MT6360_PMU_RGB_IRQ			(0xDB)
-#define MT6360_PMU_BUCK1_IRQ			(0xDC)
-#define MT6360_PMU_BUCK2_IRQ			(0xDD)
-#define MT6360_PMU_LDO_IRQ1			(0xDE)
-#define MT6360_PMU_LDO_IRQ2			(0xDF)
-#define MT6360_PMU_CHG_STAT1			(0xE0)
-#define MT6360_PMU_CHG_STAT2			(0xE1)
-#define MT6360_PMU_CHG_STAT3			(0xE2)
-#define MT6360_PMU_CHG_STAT4			(0xE3)
-#define MT6360_PMU_CHG_STAT5			(0xE4)
-#define MT6360_PMU_CHG_STAT6			(0xE5)
-#define MT6360_PMU_QC_STAT			(0xE6)
-#define MT6360_PMU_FOD_STAT			(0xE7)
-#define MT6360_PMU_BASE_STAT			(0xE8)
-#define MT6360_PMU_FLED_STAT1			(0xE9)
-#define MT6360_PMU_FLED_STAT2			(0xEA)
-#define MT6360_PMU_RGB_STAT			(0xEB)
-#define MT6360_PMU_BUCK1_STAT			(0xEC)
-#define MT6360_PMU_BUCK2_STAT			(0xED)
-#define MT6360_PMU_LDO_STAT1			(0xEE)
-#define MT6360_PMU_LDO_STAT2			(0xEF)
-#define MT6360_PMU_CHG_MASK1			(0xF0)
-#define MT6360_PMU_CHG_MASK2			(0xF1)
-#define MT6360_PMU_CHG_MASK3			(0xF2)
-#define MT6360_PMU_CHG_MASK4			(0xF3)
-#define MT6360_PMU_CHG_MASK5			(0xF4)
-#define MT6360_PMU_CHG_MASK6			(0xF5)
-#define MT6360_PMU_QC_MASK			(0xF6)
-#define MT6360_PMU_FOD_MASK			(0xF7)
-#define MT6360_PMU_BASE_MASK			(0xF8)
-#define MT6360_PMU_FLED_MASK1			(0xF9)
-#define MT6360_PMU_FLED_MASK2			(0xFA)
-#define MT6360_PMU_FAULTB_MASK			(0xFB)
-#define MT6360_PMU_BUCK1_MASK			(0xFC)
-#define MT6360_PMU_BUCK2_MASK			(0xFD)
-#define MT6360_PMU_LDO_MASK1			(0xFE)
-#define MT6360_PMU_LDO_MASK2			(0xFF)
-#define MT6360_PMU_MAXREG			(MT6360_PMU_LDO_MASK2)
+#define MT6360_PMU_DEV_INFO			0x00
+#define MT6360_PMU_CORE_CTRL1			0x01
+#define MT6360_PMU_RST1				0x02
+#define MT6360_PMU_CRCEN			0x03
+#define MT6360_PMU_RST_PAS_CODE1		0x04
+#define MT6360_PMU_RST_PAS_CODE2		0x05
+#define MT6360_PMU_CORE_CTRL2			0x06
+#define MT6360_PMU_TM_PAS_CODE1			0x07
+#define MT6360_PMU_TM_PAS_CODE2			0x08
+#define MT6360_PMU_TM_PAS_CODE3			0x09
+#define MT6360_PMU_TM_PAS_CODE4			0x0A
+#define MT6360_PMU_IRQ_IND			0x0B
+#define MT6360_PMU_IRQ_MASK			0x0C
+#define MT6360_PMU_IRQ_SET			0x0D
+#define MT6360_PMU_SHDN_CTRL			0x0E
+#define MT6360_PMU_TM_INF			0x0F
+#define MT6360_PMU_I2C_CTRL			0x10
+#define MT6360_PMU_CHG_CTRL1			0x11
+#define MT6360_PMU_CHG_CTRL2			0x12
+#define MT6360_PMU_CHG_CTRL3			0x13
+#define MT6360_PMU_CHG_CTRL4			0x14
+#define MT6360_PMU_CHG_CTRL5			0x15
+#define MT6360_PMU_CHG_CTRL6			0x16
+#define MT6360_PMU_CHG_CTRL7			0x17
+#define MT6360_PMU_CHG_CTRL8			0x18
+#define MT6360_PMU_CHG_CTRL9			0x19
+#define MT6360_PMU_CHG_CTRL10			0x1A
+#define MT6360_PMU_CHG_CTRL11			0x1B
+#define MT6360_PMU_CHG_CTRL12			0x1C
+#define MT6360_PMU_CHG_CTRL13			0x1D
+#define MT6360_PMU_CHG_CTRL14			0x1E
+#define MT6360_PMU_CHG_CTRL15			0x1F
+#define MT6360_PMU_CHG_CTRL16			0x20
+#define MT6360_PMU_CHG_AICC_RESULT		0x21
+#define MT6360_PMU_DEVICE_TYPE			0x22
+#define MT6360_PMU_QC_CONTROL1			0x23
+#define MT6360_PMU_QC_CONTROL2			0x24
+#define MT6360_PMU_QC30_CONTROL1		0x25
+#define MT6360_PMU_QC30_CONTROL2		0x26
+#define MT6360_PMU_USB_STATUS1			0x27
+#define MT6360_PMU_QC_STATUS1			0x28
+#define MT6360_PMU_QC_STATUS2			0x29
+#define MT6360_PMU_CHG_PUMP			0x2A
+#define MT6360_PMU_CHG_CTRL17			0x2B
+#define MT6360_PMU_CHG_CTRL18			0x2C
+#define MT6360_PMU_CHRDET_CTRL1			0x2D
+#define MT6360_PMU_CHRDET_CTRL2			0x2E
+#define MT6360_PMU_DPDN_CTRL			0x2F
+#define MT6360_PMU_CHG_HIDDEN_CTRL1		0x30
+#define MT6360_PMU_CHG_HIDDEN_CTRL2		0x31
+#define MT6360_PMU_CHG_HIDDEN_CTRL3		0x32
+#define MT6360_PMU_CHG_HIDDEN_CTRL4		0x33
+#define MT6360_PMU_CHG_HIDDEN_CTRL5		0x34
+#define MT6360_PMU_CHG_HIDDEN_CTRL6		0x35
+#define MT6360_PMU_CHG_HIDDEN_CTRL7		0x36
+#define MT6360_PMU_CHG_HIDDEN_CTRL8		0x37
+#define MT6360_PMU_CHG_HIDDEN_CTRL9		0x38
+#define MT6360_PMU_CHG_HIDDEN_CTRL10		0x39
+#define MT6360_PMU_CHG_HIDDEN_CTRL11		0x3A
+#define MT6360_PMU_CHG_HIDDEN_CTRL12		0x3B
+#define MT6360_PMU_CHG_HIDDEN_CTRL13		0x3C
+#define MT6360_PMU_CHG_HIDDEN_CTRL14		0x3D
+#define MT6360_PMU_CHG_HIDDEN_CTRL15		0x3E
+#define MT6360_PMU_CHG_HIDDEN_CTRL16		0x3F
+#define MT6360_PMU_CHG_HIDDEN_CTRL17		0x40
+#define MT6360_PMU_CHG_HIDDEN_CTRL18		0x41
+#define MT6360_PMU_CHG_HIDDEN_CTRL19		0x42
+#define MT6360_PMU_CHG_HIDDEN_CTRL20		0x43
+#define MT6360_PMU_CHG_HIDDEN_CTRL21		0x44
+#define MT6360_PMU_CHG_HIDDEN_CTRL22		0x45
+#define MT6360_PMU_CHG_HIDDEN_CTRL23		0x46
+#define MT6360_PMU_CHG_HIDDEN_CTRL24		0x47
+#define MT6360_PMU_CHG_HIDDEN_CTRL25		0x48
+#define MT6360_PMU_BC12_CTRL			0x49
+#define MT6360_PMU_CHG_STAT			0x4A
+#define MT6360_PMU_RESV1			0x4B
+#define MT6360_PMU_TYPEC_OTP_TH_SEL_CODEH	0x4E
+#define MT6360_PMU_TYPEC_OTP_TH_SEL_CODEL	0x4F
+#define MT6360_PMU_TYPEC_OTP_HYST_TH		0x50
+#define MT6360_PMU_TYPEC_OTP_CTRL		0x51
+#define MT6360_PMU_ADC_BAT_DATA_H		0x52
+#define MT6360_PMU_ADC_BAT_DATA_L		0x53
+#define MT6360_PMU_IMID_BACKBST_ON		0x54
+#define MT6360_PMU_IMID_BACKBST_OFF		0x55
+#define MT6360_PMU_ADC_CONFIG			0x56
+#define MT6360_PMU_ADC_EN2			0x57
+#define MT6360_PMU_ADC_IDLE_T			0x58
+#define MT6360_PMU_ADC_RPT_1			0x5A
+#define MT6360_PMU_ADC_RPT_2			0x5B
+#define MT6360_PMU_ADC_RPT_3			0x5C
+#define MT6360_PMU_ADC_RPT_ORG1			0x5D
+#define MT6360_PMU_ADC_RPT_ORG2			0x5E
+#define MT6360_PMU_BAT_OVP_TH_SEL_CODEH		0x5F
+#define MT6360_PMU_BAT_OVP_TH_SEL_CODEL		0x60
+#define MT6360_PMU_CHG_CTRL19			0x61
+#define MT6360_PMU_VDDASUPPLY			0x62
+#define MT6360_PMU_BC12_MANUAL			0x63
+#define MT6360_PMU_CHGDET_FUNC			0x64
+#define MT6360_PMU_FOD_CTRL			0x65
+#define MT6360_PMU_CHG_CTRL20			0x66
+#define MT6360_PMU_CHG_HIDDEN_CTRL26		0x67
+#define MT6360_PMU_CHG_HIDDEN_CTRL27		0x68
+#define MT6360_PMU_RESV2			0x69
+#define MT6360_PMU_USBID_CTRL1			0x6D
+#define MT6360_PMU_USBID_CTRL2			0x6E
+#define MT6360_PMU_USBID_CTRL3			0x6F
+#define MT6360_PMU_FLED_CFG			0x70
+#define MT6360_PMU_RESV3			0x71
+#define MT6360_PMU_FLED1_CTRL			0x72
+#define MT6360_PMU_FLED_STRB_CTRL		0x73
+#define MT6360_PMU_FLED1_STRB_CTRL2		0x74
+#define MT6360_PMU_FLED1_TOR_CTRL		0x75
+#define MT6360_PMU_FLED2_CTRL			0x76
+#define MT6360_PMU_RESV4			0x77
+#define MT6360_PMU_FLED2_STRB_CTRL2		0x78
+#define MT6360_PMU_FLED2_TOR_CTRL		0x79
+#define MT6360_PMU_FLED_VMIDTRK_CTRL1		0x7A
+#define MT6360_PMU_FLED_VMID_RTM		0x7B
+#define MT6360_PMU_FLED_VMIDTRK_CTRL2		0x7C
+#define MT6360_PMU_FLED_PWSEL			0x7D
+#define MT6360_PMU_FLED_EN			0x7E
+#define MT6360_PMU_FLED_Hidden1			0x7F
+#define MT6360_PMU_RGB_EN			0x80
+#define MT6360_PMU_RGB1_ISNK			0x81
+#define MT6360_PMU_RGB2_ISNK			0x82
+#define MT6360_PMU_RGB3_ISNK			0x83
+#define MT6360_PMU_RGB_ML_ISNK			0x84
+#define MT6360_PMU_RGB1_DIM			0x85
+#define MT6360_PMU_RGB2_DIM			0x86
+#define MT6360_PMU_RGB3_DIM			0x87
+#define MT6360_PMU_RESV5			0x88
+#define MT6360_PMU_RGB12_Freq			0x89
+#define MT6360_PMU_RGB34_Freq			0x8A
+#define MT6360_PMU_RGB1_Tr			0x8B
+#define MT6360_PMU_RGB1_Tf			0x8C
+#define MT6360_PMU_RGB1_TON_TOFF		0x8D
+#define MT6360_PMU_RGB2_Tr			0x8E
+#define MT6360_PMU_RGB2_Tf			0x8F
+#define MT6360_PMU_RGB2_TON_TOFF		0x90
+#define MT6360_PMU_RGB3_Tr			0x91
+#define MT6360_PMU_RGB3_Tf			0x92
+#define MT6360_PMU_RGB3_TON_TOFF		0x93
+#define MT6360_PMU_RGB_Hidden_CTRL1		0x94
+#define MT6360_PMU_RGB_Hidden_CTRL2		0x95
+#define MT6360_PMU_RESV6			0x97
+#define MT6360_PMU_SPARE1			0x9A
+#define MT6360_PMU_SPARE2			0xA0
+#define MT6360_PMU_SPARE3			0xB0
+#define MT6360_PMU_SPARE4			0xC0
+#define MT6360_PMU_CHG_IRQ1			0xD0
+#define MT6360_PMU_CHG_IRQ2			0xD1
+#define MT6360_PMU_CHG_IRQ3			0xD2
+#define MT6360_PMU_CHG_IRQ4			0xD3
+#define MT6360_PMU_CHG_IRQ5			0xD4
+#define MT6360_PMU_CHG_IRQ6			0xD5
+#define MT6360_PMU_QC_IRQ			0xD6
+#define MT6360_PMU_FOD_IRQ			0xD7
+#define MT6360_PMU_BASE_IRQ			0xD8
+#define MT6360_PMU_FLED_IRQ1			0xD9
+#define MT6360_PMU_FLED_IRQ2			0xDA
+#define MT6360_PMU_RGB_IRQ			0xDB
+#define MT6360_PMU_BUCK1_IRQ			0xDC
+#define MT6360_PMU_BUCK2_IRQ			0xDD
+#define MT6360_PMU_LDO_IRQ1			0xDE
+#define MT6360_PMU_LDO_IRQ2			0xDF
+#define MT6360_PMU_CHG_STAT1			0xE0
+#define MT6360_PMU_CHG_STAT2			0xE1
+#define MT6360_PMU_CHG_STAT3			0xE2
+#define MT6360_PMU_CHG_STAT4			0xE3
+#define MT6360_PMU_CHG_STAT5			0xE4
+#define MT6360_PMU_CHG_STAT6			0xE5
+#define MT6360_PMU_QC_STAT			0xE6
+#define MT6360_PMU_FOD_STAT			0xE7
+#define MT6360_PMU_BASE_STAT			0xE8
+#define MT6360_PMU_FLED_STAT1			0xE9
+#define MT6360_PMU_FLED_STAT2			0xEA
+#define MT6360_PMU_RGB_STAT			0xEB
+#define MT6360_PMU_BUCK1_STAT			0xEC
+#define MT6360_PMU_BUCK2_STAT			0xED
+#define MT6360_PMU_LDO_STAT1			0xEE
+#define MT6360_PMU_LDO_STAT2			0xEF
+#define MT6360_PMU_CHG_MASK1			0xF0
+#define MT6360_PMU_CHG_MASK2			0xF1
+#define MT6360_PMU_CHG_MASK3			0xF2
+#define MT6360_PMU_CHG_MASK4			0xF3
+#define MT6360_PMU_CHG_MASK5			0xF4
+#define MT6360_PMU_CHG_MASK6			0xF5
+#define MT6360_PMU_QC_MASK			0xF6
+#define MT6360_PMU_FOD_MASK			0xF7
+#define MT6360_PMU_BASE_MASK			0xF8
+#define MT6360_PMU_FLED_MASK1			0xF9
+#define MT6360_PMU_FLED_MASK2			0xFA
+#define MT6360_PMU_FAULTB_MASK			0xFB
+#define MT6360_PMU_BUCK1_MASK			0xFC
+#define MT6360_PMU_BUCK2_MASK			0xFD
+#define MT6360_PMU_LDO_MASK1			0xFE
+#define MT6360_PMU_LDO_MASK2			0xFF
+#define MT6360_PMU_MAXREG			MT6360_PMU_LDO_MASK2
 
 /* MT6360_PMU_IRQ_SET */
 #define MT6360_PMU_IRQ_REGNUM	(MT6360_PMU_LDO_IRQ2 - MT6360_PMU_CHG_IRQ1 + 1)
 #define MT6360_IRQ_RETRIG	BIT(2)
 
-#define CHIP_VEN_MASK				(0xF0)
-#define CHIP_VEN_MT6360				(0x50)
-#define CHIP_REV_MASK				(0x0F)
+#define CHIP_VEN_MASK				0xF0
+#define CHIP_VEN_MT6360				0x50
+#define CHIP_REV_MASK				0x0F
 
 #endif /* __MT6360_H__ */
-- 
2.7.4

