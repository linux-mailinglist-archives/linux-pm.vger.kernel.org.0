Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479422CEE53
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 13:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgLDMsa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 07:48:30 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45825 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgLDMs3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 07:48:29 -0500
Received: by mail-lj1-f195.google.com with SMTP id q8so6432093ljc.12;
        Fri, 04 Dec 2020 04:48:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=voM8CIdlVjogp2cZAMUdQ7vlFQs6bZFYlhKRFXAOqlQ=;
        b=VXG/YO2GEkIBWSNzxq9vvC8g9zscmfEQ2hQwZUQsdG0afEwNVuoGRzxL4v/bqSzjX6
         zRDKY42dCs+03X83TqyBleaTr4yVFulUyKuySQiiI932zgE2TR2AZz7fb7FrIP1l2LWT
         ZI6e868j+Q9vSQ1ehOJeRQRRz5Pf0ug4DSkyUzNMG93n9nV90Xm14JQM1sX5+nC11usv
         vJZpGinTxohPnupWIi3Jiml3fPKQWolQ7N+AqvFgrls5aYeq9CVXr9EKTFHacOKkoYTq
         lsdiG4b+EbHIHHYjQ32p9boX3ECk5SbRaxk4dCFmj7TCerTkroQ7OdnGRHurxAg78ATr
         3Umg==
X-Gm-Message-State: AOAM5323C+KX1a+NaVIfbN4g/zL/pk9A4Nmli+9Uu3AiMn9gujoQMADa
        6SLaFLPYz/HHe3NCnRnt0ts=
X-Google-Smtp-Source: ABdhPJy1XOH4L6tEIzyYtRblGbiMDgqDFMY3POHBaiCdobtelzoAtH2S0rx52L9BlMl2VI0QzTbtQg==
X-Received: by 2002:a2e:a40e:: with SMTP id p14mr1007400ljn.63.1607086061254;
        Fri, 04 Dec 2020 04:47:41 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id f2sm1714164ljn.39.2020.12.04.04.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 04:47:40 -0800 (PST)
Date:   Fri, 4 Dec 2020 14:47:34 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Cong Pham <cpham2403@gmail.com>, rostokus@gmail.com,
        fan.chen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [RFC PATCH v2 3/6] mfd: prepare to support BD718xx-charger
Message-ID: <ebcd976ba60a8cf417787b8b0643f12dcc68cf0a.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add definitions for ROHM BD718(27/28/78) PMIC's charger blocks.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

This patch was not in v1. This brings in some charger registers
for the BD71828 charger driver which is in following patches. Patch
split here reflects the subsystem change (for non RFC submitted for
inclusion this would probably be Lee's territory). Now provided in
this RFC series to give more context

 include/linux/mfd/rohm-bd71828.h | 65 ++++++++++++++++++++++++++++++++
 include/linux/mfd/rohm-generic.h |  2 +
 2 files changed, 67 insertions(+)

diff --git a/include/linux/mfd/rohm-bd71828.h b/include/linux/mfd/rohm-bd71828.h
index 017a4c01cb31..1a6a7804d28b 100644
--- a/include/linux/mfd/rohm-bd71828.h
+++ b/include/linux/mfd/rohm-bd71828.h
@@ -185,6 +185,71 @@ enum {
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
 
 /* LEDs */
 #define BD71828_REG_LED_CTRL		0x4A
diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-generic.h
index 4283b5b33e04..48af41d22d3f 100644
--- a/include/linux/mfd/rohm-generic.h
+++ b/include/linux/mfd/rohm-generic.h
@@ -12,6 +12,8 @@ enum rohm_chip_type {
 	ROHM_CHIP_TYPE_BD71847,
 	ROHM_CHIP_TYPE_BD70528,
 	ROHM_CHIP_TYPE_BD71828,
+	ROHM_CHIP_TYPE_BD71827,
+	ROHM_CHIP_TYPE_BD71878,
 	ROHM_CHIP_TYPE_AMOUNT
 };
 
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
