Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780816588FA
	for <lists+linux-pm@lfdr.de>; Thu, 29 Dec 2022 04:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiL2DBj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Dec 2022 22:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbiL2DBV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2022 22:01:21 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDDF13CE2
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:17 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j17so16406058lfr.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGyTSulvaKjPEZiY77IpLwagE5A3412rOxjmhJUBt5Q=;
        b=A5xPMntNFyQ6KopZpzpO0jZhk5UpNcbfc7yLbKJWf1Lcf121H7CuF5aWGE3dy8WUyH
         lw5SJN46SHPksbYBFMMxpD0N49Sv/080Svk9+4HXr57Pe25Sr0ruu/2v1TetrSUlbl/S
         Vba0havF9It2qw1ZZ+lRIS2uqdyfXXA5pDNqo0NVf3g2HmzeFF2ux0oEWBTuaUV3RMPh
         ka/BX+SUda3aUL1mnZHClRItm1ylQNaFcxO8/++Co85lzgApm9uUuZ8OY7bWR4XvNPe6
         FWEiSxk+i5CK1ws1UcB04T9Js/tA68SxhXwcCItxg/G999zhOQeSFw2fZEG/RgcpzAgn
         YZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGyTSulvaKjPEZiY77IpLwagE5A3412rOxjmhJUBt5Q=;
        b=xd1Hke8SMgtPuhldu5LU7HdA5sePaAOMKZzokxPDhlK0900t3CNuFceYH9nWDNCWmR
         v/K/n24K+eksHhrYHPv6higd53L0UaxRDX3/ZlibalYBdjz/5CSpxUYQG1tPUzkMQqJp
         JNXNagXrL0FYHEO4Mno3xDkyj/5tuXJ3aR/7WiecPtWWC6OJyjdHI9uJXXg1m/9KZCJs
         4nYyAMTwQCdvtNsmWIVs2zQxYdexr/iQXw+l2WKHWUGdIpkwwIV8vfQ3wo/IE9IAFKtm
         m/JuHDubG/1Z3raNmSlpsOS4f27imitt+z+BCUS0IEPTcEbEQw+o7QaglxfcMAgbyXcm
         LeHA==
X-Gm-Message-State: AFqh2koEMg2YGbNFIKp07XKzZ1WLZ17RMubS50RL4n1Xvxyx6SiHc4mK
        prKbIDW/0vnNZ5hqLXvyxc21yw==
X-Google-Smtp-Source: AMrXdXtPGHx8ruc8grAZ9ktEKFWfPwZz9cP6Y+uHUnJlAq/shcGwsJBC7jkwQJdZDIPm5eAlaHK1Ow==
X-Received: by 2002:a05:6512:340a:b0:4b4:f212:6173 with SMTP id i10-20020a056512340a00b004b4f2126173mr7439927lfr.4.1672282877067;
        Wed, 28 Dec 2022 19:01:17 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b11-20020a056512024b00b004b57277474esm2883070lfo.106.2022.12.28.19.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 19:01:16 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v5 11/20] thermal/drivers/tsens: Rework legacy calibration data parsers
Date:   Thu, 29 Dec 2022 05:00:57 +0200
Message-Id: <20221229030106.3303205-12-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
References: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rework existing calibration parsing code to use simple data structure
describing data layout. This allows us to drop all the mask & shift
values, replacing them with data tables.

The code for msm8974 is not reworked, as it has separate calibration and
backup data.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens-v0_1.c | 591 ++++++++----------------------
 drivers/thermal/qcom/tsens-v1.c   | 266 +++-----------
 drivers/thermal/qcom/tsens.c      |  64 ++++
 drivers/thermal/qcom/tsens.h      |  38 ++
 4 files changed, 297 insertions(+), 662 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 3c08ad640940..f8b50bf14190 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2015, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/bitfield.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/platform_device.h>
 #include "tsens.h"
@@ -16,221 +17,113 @@
 #define TM_Sn_STATUS_OFF			0x0030
 #define TM_TRDY_OFF				0x005c
 
-/* eeprom layout data for 8916 */
-#define MSM8916_BASE0_MASK	0x0000007f
-#define MSM8916_BASE1_MASK	0xfe000000
-#define MSM8916_BASE0_SHIFT	0
-#define MSM8916_BASE1_SHIFT	25
-
-#define MSM8916_S0_P1_MASK	0x00000f80
-#define MSM8916_S1_P1_MASK	0x003e0000
-#define MSM8916_S2_P1_MASK	0xf8000000
-#define MSM8916_S3_P1_MASK	0x000003e0
-#define MSM8916_S4_P1_MASK	0x000f8000
-
-#define MSM8916_S0_P2_MASK	0x0001f000
-#define MSM8916_S1_P2_MASK	0x07c00000
-#define MSM8916_S2_P2_MASK	0x0000001f
-#define MSM8916_S3_P2_MASK	0x00007c00
-#define MSM8916_S4_P2_MASK	0x01f00000
-
-#define MSM8916_S0_P1_SHIFT	7
-#define MSM8916_S1_P1_SHIFT	17
-#define MSM8916_S2_P1_SHIFT	27
-#define MSM8916_S3_P1_SHIFT	5
-#define MSM8916_S4_P1_SHIFT	15
-
-#define MSM8916_S0_P2_SHIFT	12
-#define MSM8916_S1_P2_SHIFT	22
-#define MSM8916_S2_P2_SHIFT	0
-#define MSM8916_S3_P2_SHIFT	10
-#define MSM8916_S4_P2_SHIFT	20
-
-#define MSM8916_CAL_SEL_MASK	0xe0000000
-#define MSM8916_CAL_SEL_SHIFT	29
-
-/* eeprom layout data for 8939 */
-#define MSM8939_BASE0_MASK	0x000000ff
-#define MSM8939_BASE1_MASK	0xff000000
-#define MSM8939_BASE0_SHIFT	0
-#define MSM8939_BASE1_SHIFT	24
-
-#define MSM8939_S0_P1_MASK	0x000001f8
-#define MSM8939_S1_P1_MASK	0x001f8000
-#define MSM8939_S2_P1_MASK_0_4	0xf8000000
-#define MSM8939_S2_P1_MASK_5	0x00000001
-#define MSM8939_S3_P1_MASK	0x00001f80
-#define MSM8939_S4_P1_MASK	0x01f80000
-#define MSM8939_S5_P1_MASK	0x00003f00
-#define MSM8939_S6_P1_MASK	0x03f00000
-#define MSM8939_S7_P1_MASK	0x0000003f
-#define MSM8939_S8_P1_MASK	0x0003f000
-#define MSM8939_S9_P1_MASK	0x07e00000
-
-#define MSM8939_S0_P2_MASK	0x00007e00
-#define MSM8939_S1_P2_MASK	0x07e00000
-#define MSM8939_S2_P2_MASK	0x0000007e
-#define MSM8939_S3_P2_MASK	0x0007e000
-#define MSM8939_S4_P2_MASK	0x7e000000
-#define MSM8939_S5_P2_MASK	0x000fc000
-#define MSM8939_S6_P2_MASK	0xfc000000
-#define MSM8939_S7_P2_MASK	0x00000fc0
-#define MSM8939_S8_P2_MASK	0x00fc0000
-#define MSM8939_S9_P2_MASK_0_4	0xf8000000
-#define MSM8939_S9_P2_MASK_5	0x00002000
-
-#define MSM8939_S0_P1_SHIFT	3
-#define MSM8939_S1_P1_SHIFT	15
-#define MSM8939_S2_P1_SHIFT_0_4	27
-#define MSM8939_S2_P1_SHIFT_5	0
-#define MSM8939_S3_P1_SHIFT	7
-#define MSM8939_S4_P1_SHIFT	19
-#define MSM8939_S5_P1_SHIFT	8
-#define MSM8939_S6_P1_SHIFT	20
-#define MSM8939_S7_P1_SHIFT	0
-#define MSM8939_S8_P1_SHIFT	12
-#define MSM8939_S9_P1_SHIFT	21
-
-#define MSM8939_S0_P2_SHIFT	9
-#define MSM8939_S1_P2_SHIFT	21
-#define MSM8939_S2_P2_SHIFT	1
-#define MSM8939_S3_P2_SHIFT	13
-#define MSM8939_S4_P2_SHIFT	25
-#define MSM8939_S5_P2_SHIFT	14
-#define MSM8939_S6_P2_SHIFT	26
-#define MSM8939_S7_P2_SHIFT	6
-#define MSM8939_S8_P2_SHIFT	18
-#define MSM8939_S9_P2_SHIFT_0_4	27
-#define MSM8939_S9_P2_SHIFT_5	13
-
-#define MSM8939_CAL_SEL_MASK	0x7
-#define MSM8939_CAL_SEL_SHIFT	0
-
-/* eeprom layout data for 8974 */
-#define BASE1_MASK		0xff
-#define S0_P1_MASK		0x3f00
-#define S1_P1_MASK		0xfc000
-#define S2_P1_MASK		0x3f00000
-#define S3_P1_MASK		0xfc000000
-#define S4_P1_MASK		0x3f
-#define S5_P1_MASK		0xfc0
-#define S6_P1_MASK		0x3f000
-#define S7_P1_MASK		0xfc0000
-#define S8_P1_MASK		0x3f000000
-#define S8_P1_MASK_BKP		0x3f
-#define S9_P1_MASK		0x3f
-#define S9_P1_MASK_BKP		0xfc0
-#define S10_P1_MASK		0xfc0
-#define S10_P1_MASK_BKP		0x3f000
-#define CAL_SEL_0_1		0xc0000000
-#define CAL_SEL_2		0x40000000
-#define CAL_SEL_SHIFT		30
-#define CAL_SEL_SHIFT_2		28
-
-#define S0_P1_SHIFT		8
-#define S1_P1_SHIFT		14
-#define S2_P1_SHIFT		20
-#define S3_P1_SHIFT		26
-#define S5_P1_SHIFT		6
-#define S6_P1_SHIFT		12
-#define S7_P1_SHIFT		18
-#define S8_P1_SHIFT		24
-#define S9_P1_BKP_SHIFT		6
-#define S10_P1_SHIFT		6
-#define S10_P1_BKP_SHIFT	12
-
-#define BASE2_SHIFT		12
-#define BASE2_BKP_SHIFT		18
-#define S0_P2_SHIFT		20
-#define S0_P2_BKP_SHIFT		26
-#define S1_P2_SHIFT		26
-#define S2_P2_BKP_SHIFT		6
-#define S3_P2_SHIFT		6
-#define S3_P2_BKP_SHIFT		12
-#define S4_P2_SHIFT		12
-#define S4_P2_BKP_SHIFT		18
-#define S5_P2_SHIFT		18
-#define S5_P2_BKP_SHIFT		24
-#define S6_P2_SHIFT		24
-#define S7_P2_BKP_SHIFT		6
-#define S8_P2_SHIFT		6
-#define S8_P2_BKP_SHIFT		12
-#define S9_P2_SHIFT		12
-#define S9_P2_BKP_SHIFT		18
-#define S10_P2_SHIFT		18
-#define S10_P2_BKP_SHIFT	24
-
-#define BASE2_MASK		0xff000
-#define BASE2_BKP_MASK		0xfc0000
-#define S0_P2_MASK		0x3f00000
-#define S0_P2_BKP_MASK		0xfc000000
-#define S1_P2_MASK		0xfc000000
-#define S1_P2_BKP_MASK		0x3f
-#define S2_P2_MASK		0x3f
-#define S2_P2_BKP_MASK		0xfc0
-#define S3_P2_MASK		0xfc0
-#define S3_P2_BKP_MASK		0x3f000
-#define S4_P2_MASK		0x3f000
-#define S4_P2_BKP_MASK		0xfc0000
-#define S5_P2_MASK		0xfc0000
-#define S5_P2_BKP_MASK		0x3f000000
-#define S6_P2_MASK		0x3f000000
-#define S6_P2_BKP_MASK		0x3f
-#define S7_P2_MASK		0x3f
-#define S7_P2_BKP_MASK		0xfc0
-#define S8_P2_MASK		0xfc0
-#define S8_P2_BKP_MASK		0x3f000
-#define S9_P2_MASK		0x3f000
-#define S9_P2_BKP_MASK		0xfc0000
-#define S10_P2_MASK		0xfc0000
-#define S10_P2_BKP_MASK		0x3f000000
-
+/* extra data for 8974 */
 #define BKP_SEL			0x3
 #define BKP_REDUN_SEL		0xe0000000
-#define BKP_REDUN_SHIFT		29
 
 #define BIT_APPEND		0x3
 
-/* eeprom layout data for mdm9607 */
-#define MDM9607_BASE0_MASK	0x000000ff
-#define MDM9607_BASE1_MASK	0x000ff000
-#define MDM9607_BASE0_SHIFT	0
-#define MDM9607_BASE1_SHIFT	12
-
-#define MDM9607_S0_P1_MASK	0x00003f00
-#define MDM9607_S1_P1_MASK	0x03f00000
-#define MDM9607_S2_P1_MASK	0x0000003f
-#define MDM9607_S3_P1_MASK	0x0003f000
-#define MDM9607_S4_P1_MASK	0x0000003f
-
-#define MDM9607_S0_P2_MASK	0x000fc000
-#define MDM9607_S1_P2_MASK	0xfc000000
-#define MDM9607_S2_P2_MASK	0x00000fc0
-#define MDM9607_S3_P2_MASK	0x00fc0000
-#define MDM9607_S4_P2_MASK	0x00000fc0
-
-#define MDM9607_S0_P1_SHIFT	8
-#define MDM9607_S1_P1_SHIFT	20
-#define MDM9607_S2_P1_SHIFT	0
-#define MDM9607_S3_P1_SHIFT	12
-#define MDM9607_S4_P1_SHIFT	0
-
-#define MDM9607_S0_P2_SHIFT	14
-#define MDM9607_S1_P2_SHIFT	26
-#define MDM9607_S2_P2_SHIFT	6
-#define MDM9607_S3_P2_SHIFT	18
-#define MDM9607_S4_P2_SHIFT	6
-
-#define MDM9607_CAL_SEL_MASK	0x00700000
-#define MDM9607_CAL_SEL_SHIFT	20
+struct tsens_legacy_calibration_format tsens_8916_nvmem = {
+	.base_len = 7,
+	.base_shift = 3,
+	.sp_len = 5,
+	.mode = { 0, 29, 1 },
+	.invalid = { 0, 31, 1 },
+	.base = { { 0, 0 }, { 1, 25 } },
+	.sp = {
+		{ { 0, 7 },  { 0, 12 } },
+		{ { 0, 17 }, { 0, 22 } },
+		{ { 0, 27 }, { 1, 0 } },
+		{ { 1, 5 },  { 1, 10 } },
+		{ { 1, 15 }, { 1, 20 } },
+	},
+};
+
+struct tsens_legacy_calibration_format tsens_8939_nvmem = {
+	.base_len = 8,
+	.base_shift = 2,
+	.sp_len = 6,
+	.mode = { 12, 0 },
+	.invalid = { 12, 2 },
+	.base = { { 0, 0 }, { 1, 24 } },
+	.sp = {
+		{ { 12, 3 },  { 12, 9 } },
+		{ { 12, 15 }, { 12, 21 } },
+		{ { 12, 27 }, { 13, 1 } },
+		{ { 13, 7 },  { 13, 13 } },
+		{ { 13, 19 }, { 13, 25 } },
+		{ { 0, 8 },   { 0, 14 } },
+		{ { 0, 20 },  { 0, 26 } },
+		{ { 1, 0 },   { 1, 6 } },
+		{ { 1, 12 },  { 1, 18 } },
+	},
+};
+
+struct tsens_legacy_calibration_format tsens_8974_nvmem = {
+	.base_len = 8,
+	.base_shift = 2,
+	.sp_len = 6,
+	.mode = { 1, 30 },
+	.invalid = { 3, 30 },
+	.base = { { 0, 0 }, { 2, 12 } },
+	.sp = {
+		{ { 0, 8 },  { 2, 20 } },
+		{ { 0, 14 }, { 2, 26 } },
+		{ { 0, 20 }, { 3, 0 } },
+		{ { 0, 26 }, { 3, 6 } },
+		{ { 1, 0 },  { 3, 12 } },
+		{ { 1, 6 },  { 3, 18 } },
+		{ { 1, 12 }, { 3, 24 } },
+		{ { 1, 18 }, { 4, 0 } },
+		{ { 1, 24 }, { 4, 6 } },
+		{ { 2, 0 },  { 4, 12 } },
+		{ { 2, 6 },  { 4, 18 } },
+	},
+};
+
+struct tsens_legacy_calibration_format tsens_8974_backup_nvmem = {
+	.base_len = 8,
+	.base_shift = 2,
+	.sp_len = 6,
+	.mode = { 4, 30, 1 },
+	.invalid = { 5, 30, 1 },
+	.base = { { 0, 0 }, { 2, 18 } },
+	.sp = {
+		{ { 0, 8 },  { 2, 26 } },
+		{ { 0, 14 }, { 3, 0 } },
+		{ { 0, 20 }, { 3, 6 } },
+		{ { 0, 26 }, { 3, 12 } },
+		{ { 1, 0 },  { 3, 18 } },
+		{ { 1, 6 },  { 3, 24, 1 } },
+		{ { 1, 12 }, { 4, 0, 1 } },
+		{ { 1, 18 }, { 4, 6, 1 } },
+		{ { 2, 0 },  { 4, 12, 1 } },
+		{ { 2, 6 },  { 4, 18, 1 } },
+		{ { 2, 12 }, { 4, 24, 1 } },
+	},
+};
+
+struct tsens_legacy_calibration_format tsens_9607_nvmem = {
+	.base_len = 8,
+	.base_shift = 2,
+	.sp_len = 6,
+	.mode = { 2, 20 },
+	.invalid = { 2, 22 },
+	.base = { { 0, 0 }, { 2, 12 } },
+	.sp = {
+		{ { 0, 8 },  { 0, 14 } },
+		{ { 0, 20 }, { 0, 26 } },
+		{ { 1, 0 },  { 1, 6 } },
+		{ { 1, 12 }, { 1, 18 } },
+		{ { 2, 0 },  { 2, 6 } },
+	},
+};
 
 static int calibrate_8916(struct tsens_priv *priv)
 {
-	int base0 = 0, base1 = 0, i;
 	u32 p1[5], p2[5];
-	int mode = 0;
 	u32 *qfprom_cdata, *qfprom_csel;
-	int ret;
+	int mode, ret;
 
 	ret = tsens_calibrate_nvmem(priv, 3);
 	if (!ret)
@@ -246,37 +139,9 @@ static int calibrate_8916(struct tsens_priv *priv)
 		return PTR_ERR(qfprom_csel);
 	}
 
-	mode = (qfprom_csel[0] & MSM8916_CAL_SEL_MASK) >> MSM8916_CAL_SEL_SHIFT;
-	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
-
-	switch (mode) {
-	case TWO_PT_CALIB:
-		base1 = (qfprom_cdata[1] & MSM8916_BASE1_MASK) >> MSM8916_BASE1_SHIFT;
-		p2[0] = (qfprom_cdata[0] & MSM8916_S0_P2_MASK) >> MSM8916_S0_P2_SHIFT;
-		p2[1] = (qfprom_cdata[0] & MSM8916_S1_P2_MASK) >> MSM8916_S1_P2_SHIFT;
-		p2[2] = (qfprom_cdata[1] & MSM8916_S2_P2_MASK) >> MSM8916_S2_P2_SHIFT;
-		p2[3] = (qfprom_cdata[1] & MSM8916_S3_P2_MASK) >> MSM8916_S3_P2_SHIFT;
-		p2[4] = (qfprom_cdata[1] & MSM8916_S4_P2_MASK) >> MSM8916_S4_P2_SHIFT;
-		for (i = 0; i < priv->num_sensors; i++)
-			p2[i] = ((base1 + p2[i]) << 3);
-		fallthrough;
-	case ONE_PT_CALIB2:
-		base0 = (qfprom_cdata[0] & MSM8916_BASE0_MASK);
-		p1[0] = (qfprom_cdata[0] & MSM8916_S0_P1_MASK) >> MSM8916_S0_P1_SHIFT;
-		p1[1] = (qfprom_cdata[0] & MSM8916_S1_P1_MASK) >> MSM8916_S1_P1_SHIFT;
-		p1[2] = (qfprom_cdata[0] & MSM8916_S2_P1_MASK) >> MSM8916_S2_P1_SHIFT;
-		p1[3] = (qfprom_cdata[1] & MSM8916_S3_P1_MASK) >> MSM8916_S3_P1_SHIFT;
-		p1[4] = (qfprom_cdata[1] & MSM8916_S4_P1_MASK) >> MSM8916_S4_P1_SHIFT;
-		for (i = 0; i < priv->num_sensors; i++)
-			p1[i] = (((base0) + p1[i]) << 3);
-		break;
-	default:
-		for (i = 0; i < priv->num_sensors; i++) {
-			p1[i] = 500;
-			p2[i] = 780;
-		}
-		break;
-	}
+	mode = tsens_read_calibration_legacy(priv, &tsens_8916_nvmem,
+					     p1, p2,
+					     qfprom_cdata, qfprom_csel);
 
 	compute_intercept_slope(priv, p1, p2, mode);
 	kfree(qfprom_cdata);
@@ -287,12 +152,9 @@ static int calibrate_8916(struct tsens_priv *priv)
 
 static int calibrate_8939(struct tsens_priv *priv)
 {
-	int base0 = 0, base1 = 0, i;
 	u32 p1[10], p2[10];
-	int mode = 0;
 	u32 *qfprom_cdata;
-	u32 cdata[4];
-	int ret;
+	int mode, ret;
 
 	ret = tsens_calibrate_common(priv);
 	if (!ret)
@@ -302,52 +164,9 @@ static int calibrate_8939(struct tsens_priv *priv)
 	if (IS_ERR(qfprom_cdata))
 		return PTR_ERR(qfprom_cdata);
 
-	/* Mapping between qfprom nvmem and calibration data */
-	cdata[0] = qfprom_cdata[12];
-	cdata[1] = qfprom_cdata[13];
-	cdata[2] = qfprom_cdata[0];
-	cdata[3] = qfprom_cdata[1];
-
-	mode = (cdata[0] & MSM8939_CAL_SEL_MASK) >> MSM8939_CAL_SEL_SHIFT;
-	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
-
-	switch (mode) {
-	case TWO_PT_CALIB:
-		base1 = (cdata[3] & MSM8939_BASE1_MASK) >> MSM8939_BASE1_SHIFT;
-		p2[0] = (cdata[0] & MSM8939_S0_P2_MASK) >> MSM8939_S0_P2_SHIFT;
-		p2[1] = (cdata[0] & MSM8939_S1_P2_MASK) >> MSM8939_S1_P2_SHIFT;
-		p2[2] = (cdata[1] & MSM8939_S2_P2_MASK) >> MSM8939_S2_P2_SHIFT;
-		p2[3] = (cdata[1] & MSM8939_S3_P2_MASK) >> MSM8939_S3_P2_SHIFT;
-		p2[4] = (cdata[1] & MSM8939_S4_P2_MASK) >> MSM8939_S4_P2_SHIFT;
-		p2[5] = (cdata[2] & MSM8939_S5_P2_MASK) >> MSM8939_S5_P2_SHIFT;
-		p2[6] = (cdata[2] & MSM8939_S6_P2_MASK) >> MSM8939_S6_P2_SHIFT;
-		p2[7] = (cdata[3] & MSM8939_S7_P2_MASK) >> MSM8939_S7_P2_SHIFT;
-		p2[8] = (cdata[3] & MSM8939_S8_P2_MASK) >> MSM8939_S8_P2_SHIFT;
-		for (i = 0; i < priv->num_sensors; i++)
-			p2[i] = (base1 + p2[i]) << 2;
-		fallthrough;
-	case ONE_PT_CALIB2:
-		base0 = (cdata[2] & MSM8939_BASE0_MASK) >> MSM8939_BASE0_SHIFT;
-		p1[0] = (cdata[0] & MSM8939_S0_P1_MASK) >> MSM8939_S0_P1_SHIFT;
-		p1[1] = (cdata[0] & MSM8939_S1_P1_MASK) >> MSM8939_S1_P1_SHIFT;
-		p1[2] = (cdata[0] & MSM8939_S2_P1_MASK_0_4) >> MSM8939_S2_P1_SHIFT_0_4;
-		p1[2] |= ((cdata[1] & MSM8939_S2_P1_MASK_5) >> MSM8939_S2_P1_SHIFT_5) << 5;
-		p1[3] = (cdata[1] & MSM8939_S3_P1_MASK) >> MSM8939_S3_P1_SHIFT;
-		p1[4] = (cdata[1] & MSM8939_S4_P1_MASK) >> MSM8939_S4_P1_SHIFT;
-		p1[5] = (cdata[2] & MSM8939_S5_P1_MASK) >> MSM8939_S5_P1_SHIFT;
-		p1[6] = (cdata[2] & MSM8939_S6_P1_MASK) >> MSM8939_S6_P1_SHIFT;
-		p1[7] = (cdata[3] & MSM8939_S7_P1_MASK) >> MSM8939_S7_P1_SHIFT;
-		p1[8] = (cdata[3] & MSM8939_S8_P1_MASK) >> MSM8939_S8_P1_SHIFT;
-		for (i = 0; i < priv->num_sensors; i++)
-			p1[i] = ((base0) + p1[i]) << 2;
-		break;
-	default:
-		for (i = 0; i < priv->num_sensors; i++) {
-			p1[i] = 500;
-			p2[i] = 780;
-		}
-		break;
-	}
+	mode = tsens_read_calibration_legacy(priv, &tsens_8939_nvmem,
+					     p1, p2,
+					     qfprom_cdata, NULL);
 
 	compute_intercept_slope(priv, p1, p2, mode);
 	kfree(qfprom_cdata);
@@ -355,21 +174,9 @@ static int calibrate_8939(struct tsens_priv *priv)
 	return 0;
 }
 
-static int calibrate_8974_nvmem(struct tsens_priv *priv)
+static void fixup_8974_points(int mode, u32 *p1, u32 *p2)
 {
-	int i, ret, mode;
-	u32 p1[11], p2[11];
-	u32 backup;
-
-	ret = nvmem_cell_read_variable_le_u32(priv->dev, "use_backup", &backup);
-	if (ret == -ENOENT)
-		dev_warn(priv->dev, "Please migrate to separate nvmem cells for calibration data\n");
-	if (ret < 0)
-		return ret;
-
-	mode = tsens_read_calibration(priv, 2, p1, p2, backup == BKP_SEL);
-	if (mode < 0)
-		return mode;
+	int i;
 
 	if (mode == NO_PT_CALIB) {
 		p1[0] += 2;
@@ -384,7 +191,7 @@ static int calibrate_8974_nvmem(struct tsens_priv *priv)
 		p1[9] += 9;
 		p1[10] += 8;
 	} else {
-		for (i = 0; i < priv->num_sensors; i++) {
+		for (i = 0; i < 11; i++) {
 			/*
 			 * ONE_PT_CALIB requires using addition here instead of
 			 * using OR operation.
@@ -394,6 +201,26 @@ static int calibrate_8974_nvmem(struct tsens_priv *priv)
 		}
 	}
 
+}
+
+static int calibrate_8974_nvmem(struct tsens_priv *priv)
+{
+	u32 p1[11], p2[11];
+	u32 backup;
+	int ret, mode;
+
+	ret = nvmem_cell_read_variable_le_u32(priv->dev, "use_backup", &backup);
+	if (ret == -ENOENT)
+		dev_warn(priv->dev, "Please migrate to separate nvmem cells for calibration data\n");
+	if (ret < 0)
+		return ret;
+
+	mode = tsens_read_calibration(priv, 2, p1, p2, backup == BKP_SEL);
+	if (mode < 0)
+		return mode;
+
+	fixup_8974_points(mode, p1, p2);
+
 	compute_intercept_slope(priv, p1, p2, mode);
 
 	return 0;
@@ -401,12 +228,10 @@ static int calibrate_8974_nvmem(struct tsens_priv *priv)
 
 static int calibrate_8974(struct tsens_priv *priv)
 {
-	int base1 = 0, base2 = 0, i;
 	u32 p1[11], p2[11];
-	int mode = 0;
 	u32 *calib, *bkp;
 	u32 calib_redun_sel;
-	int ret;
+	int mode, ret;
 
 	ret = calibrate_8974_nvmem(priv);
 	if (ret == 0)
@@ -422,116 +247,18 @@ static int calibrate_8974(struct tsens_priv *priv)
 		return PTR_ERR(bkp);
 	}
 
-	calib_redun_sel =  bkp[1] & BKP_REDUN_SEL;
-	calib_redun_sel >>= BKP_REDUN_SHIFT;
-
-	if (calib_redun_sel == BKP_SEL) {
-		mode = (calib[4] & CAL_SEL_0_1) >> CAL_SEL_SHIFT;
-		mode |= (calib[5] & CAL_SEL_2) >> CAL_SEL_SHIFT_2;
-
-		switch (mode) {
-		case TWO_PT_CALIB:
-			base2 = (bkp[2] & BASE2_BKP_MASK) >> BASE2_BKP_SHIFT;
-			p2[0] = (bkp[2] & S0_P2_BKP_MASK) >> S0_P2_BKP_SHIFT;
-			p2[1] = (bkp[3] & S1_P2_BKP_MASK);
-			p2[2] = (bkp[3] & S2_P2_BKP_MASK) >> S2_P2_BKP_SHIFT;
-			p2[3] = (bkp[3] & S3_P2_BKP_MASK) >> S3_P2_BKP_SHIFT;
-			p2[4] = (bkp[3] & S4_P2_BKP_MASK) >> S4_P2_BKP_SHIFT;
-			p2[5] = (calib[4] & S5_P2_BKP_MASK) >> S5_P2_BKP_SHIFT;
-			p2[6] = (calib[5] & S6_P2_BKP_MASK);
-			p2[7] = (calib[5] & S7_P2_BKP_MASK) >> S7_P2_BKP_SHIFT;
-			p2[8] = (calib[5] & S8_P2_BKP_MASK) >> S8_P2_BKP_SHIFT;
-			p2[9] = (calib[5] & S9_P2_BKP_MASK) >> S9_P2_BKP_SHIFT;
-			p2[10] = (calib[5] & S10_P2_BKP_MASK) >> S10_P2_BKP_SHIFT;
-			fallthrough;
-		case ONE_PT_CALIB:
-		case ONE_PT_CALIB2:
-			base1 = bkp[0] & BASE1_MASK;
-			p1[0] = (bkp[0] & S0_P1_MASK) >> S0_P1_SHIFT;
-			p1[1] = (bkp[0] & S1_P1_MASK) >> S1_P1_SHIFT;
-			p1[2] = (bkp[0] & S2_P1_MASK) >> S2_P1_SHIFT;
-			p1[3] = (bkp[0] & S3_P1_MASK) >> S3_P1_SHIFT;
-			p1[4] = (bkp[1] & S4_P1_MASK);
-			p1[5] = (bkp[1] & S5_P1_MASK) >> S5_P1_SHIFT;
-			p1[6] = (bkp[1] & S6_P1_MASK) >> S6_P1_SHIFT;
-			p1[7] = (bkp[1] & S7_P1_MASK) >> S7_P1_SHIFT;
-			p1[8] = (bkp[2] & S8_P1_MASK_BKP) >> S8_P1_SHIFT;
-			p1[9] = (bkp[2] & S9_P1_MASK_BKP) >> S9_P1_BKP_SHIFT;
-			p1[10] = (bkp[2] & S10_P1_MASK_BKP) >> S10_P1_BKP_SHIFT;
-			break;
-		}
-	} else {
-		mode = (calib[1] & CAL_SEL_0_1) >> CAL_SEL_SHIFT;
-		mode |= (calib[3] & CAL_SEL_2) >> CAL_SEL_SHIFT_2;
-
-		switch (mode) {
-		case TWO_PT_CALIB:
-			base2 = (calib[2] & BASE2_MASK) >> BASE2_SHIFT;
-			p2[0] = (calib[2] & S0_P2_MASK) >> S0_P2_SHIFT;
-			p2[1] = (calib[2] & S1_P2_MASK) >> S1_P2_SHIFT;
-			p2[2] = (calib[3] & S2_P2_MASK);
-			p2[3] = (calib[3] & S3_P2_MASK) >> S3_P2_SHIFT;
-			p2[4] = (calib[3] & S4_P2_MASK) >> S4_P2_SHIFT;
-			p2[5] = (calib[3] & S5_P2_MASK) >> S5_P2_SHIFT;
-			p2[6] = (calib[3] & S6_P2_MASK) >> S6_P2_SHIFT;
-			p2[7] = (calib[4] & S7_P2_MASK);
-			p2[8] = (calib[4] & S8_P2_MASK) >> S8_P2_SHIFT;
-			p2[9] = (calib[4] & S9_P2_MASK) >> S9_P2_SHIFT;
-			p2[10] = (calib[4] & S10_P2_MASK) >> S10_P2_SHIFT;
-			fallthrough;
-		case ONE_PT_CALIB:
-		case ONE_PT_CALIB2:
-			base1 = calib[0] & BASE1_MASK;
-			p1[0] = (calib[0] & S0_P1_MASK) >> S0_P1_SHIFT;
-			p1[1] = (calib[0] & S1_P1_MASK) >> S1_P1_SHIFT;
-			p1[2] = (calib[0] & S2_P1_MASK) >> S2_P1_SHIFT;
-			p1[3] = (calib[0] & S3_P1_MASK) >> S3_P1_SHIFT;
-			p1[4] = (calib[1] & S4_P1_MASK);
-			p1[5] = (calib[1] & S5_P1_MASK) >> S5_P1_SHIFT;
-			p1[6] = (calib[1] & S6_P1_MASK) >> S6_P1_SHIFT;
-			p1[7] = (calib[1] & S7_P1_MASK) >> S7_P1_SHIFT;
-			p1[8] = (calib[1] & S8_P1_MASK) >> S8_P1_SHIFT;
-			p1[9] = (calib[2] & S9_P1_MASK);
-			p1[10] = (calib[2] & S10_P1_MASK) >> S10_P1_SHIFT;
-			break;
-		}
-	}
+	calib_redun_sel = FIELD_GET(BKP_REDUN_SEL, bkp[1]);
 
-	switch (mode) {
-	case ONE_PT_CALIB:
-		for (i = 0; i < priv->num_sensors; i++)
-			p1[i] += (base1 << 2) | BIT_APPEND;
-		break;
-	case TWO_PT_CALIB:
-		for (i = 0; i < priv->num_sensors; i++) {
-			p2[i] += base2;
-			p2[i] <<= 2;
-			p2[i] |= BIT_APPEND;
-		}
-		fallthrough;
-	case ONE_PT_CALIB2:
-		for (i = 0; i < priv->num_sensors; i++) {
-			p1[i] += base1;
-			p1[i] <<= 2;
-			p1[i] |= BIT_APPEND;
-		}
-		break;
-	default:
-		for (i = 0; i < priv->num_sensors; i++)
-			p2[i] = 780;
-		p1[0] = 502;
-		p1[1] = 509;
-		p1[2] = 503;
-		p1[3] = 509;
-		p1[4] = 505;
-		p1[5] = 509;
-		p1[6] = 507;
-		p1[7] = 510;
-		p1[8] = 508;
-		p1[9] = 509;
-		p1[10] = 508;
-		break;
-	}
+	if (calib_redun_sel == BKP_SEL)
+		mode = tsens_read_calibration_legacy(priv, &tsens_8974_backup_nvmem,
+						     p1, p2,
+						     bkp, calib);
+	else
+		mode = tsens_read_calibration_legacy(priv, &tsens_8974_nvmem,
+						     p1, p2,
+						     calib, NULL);
+
+	fixup_8974_points(mode, p1, p2);
 
 	compute_intercept_slope(priv, p1, p2, mode);
 	kfree(calib);
@@ -542,11 +269,9 @@ static int calibrate_8974(struct tsens_priv *priv)
 
 static int calibrate_9607(struct tsens_priv *priv)
 {
-	int base, i;
 	u32 p1[5], p2[5];
-	int mode = 0;
 	u32 *qfprom_cdata;
-	int ret;
+	int mode, ret;
 
 	ret = tsens_calibrate_common(priv);
 	if (!ret)
@@ -556,37 +281,9 @@ static int calibrate_9607(struct tsens_priv *priv)
 	if (IS_ERR(qfprom_cdata))
 		return PTR_ERR(qfprom_cdata);
 
-	mode = (qfprom_cdata[2] & MDM9607_CAL_SEL_MASK) >> MDM9607_CAL_SEL_SHIFT;
-	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
-
-	switch (mode) {
-	case TWO_PT_CALIB:
-		base = (qfprom_cdata[2] & MDM9607_BASE1_MASK) >> MDM9607_BASE1_SHIFT;
-		p2[0] = (qfprom_cdata[0] & MDM9607_S0_P2_MASK) >> MDM9607_S0_P2_SHIFT;
-		p2[1] = (qfprom_cdata[0] & MDM9607_S1_P2_MASK) >> MDM9607_S1_P2_SHIFT;
-		p2[2] = (qfprom_cdata[1] & MDM9607_S2_P2_MASK) >> MDM9607_S2_P2_SHIFT;
-		p2[3] = (qfprom_cdata[1] & MDM9607_S3_P2_MASK) >> MDM9607_S3_P2_SHIFT;
-		p2[4] = (qfprom_cdata[2] & MDM9607_S4_P2_MASK) >> MDM9607_S4_P2_SHIFT;
-		for (i = 0; i < priv->num_sensors; i++)
-			p2[i] = ((base + p2[i]) << 2);
-		fallthrough;
-	case ONE_PT_CALIB2:
-		base = (qfprom_cdata[0] & MDM9607_BASE0_MASK);
-		p1[0] = (qfprom_cdata[0] & MDM9607_S0_P1_MASK) >> MDM9607_S0_P1_SHIFT;
-		p1[1] = (qfprom_cdata[0] & MDM9607_S1_P1_MASK) >> MDM9607_S1_P1_SHIFT;
-		p1[2] = (qfprom_cdata[1] & MDM9607_S2_P1_MASK) >> MDM9607_S2_P1_SHIFT;
-		p1[3] = (qfprom_cdata[1] & MDM9607_S3_P1_MASK) >> MDM9607_S3_P1_SHIFT;
-		p1[4] = (qfprom_cdata[2] & MDM9607_S4_P1_MASK) >> MDM9607_S4_P1_SHIFT;
-		for (i = 0; i < priv->num_sensors; i++)
-			p1[i] = ((base + p1[i]) << 2);
-		break;
-	default:
-		for (i = 0; i < priv->num_sensors; i++) {
-			p1[i] = 500;
-			p2[i] = 780;
-		}
-		break;
-	}
+	mode = tsens_read_calibration_legacy(priv, &tsens_9607_nvmem,
+					     p1, p2,
+					     qfprom_cdata, NULL);
 
 	compute_intercept_slope(priv, p1, p2, mode);
 	kfree(qfprom_cdata);
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 5bba75a845c5..6d1ea430f90b 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -21,129 +21,54 @@
 #define TM_HIGH_LOW_INT_STATUS_OFF		0x0088
 #define TM_HIGH_LOW_Sn_INT_THRESHOLD_OFF	0x0090
 
-/* eeprom layout data for msm8956/76 (v1) */
-#define MSM8976_BASE0_MASK	0xff
-#define MSM8976_BASE1_MASK	0xff
-#define MSM8976_BASE1_SHIFT	8
-
-#define MSM8976_S0_P1_MASK	0x3f00
-#define MSM8976_S1_P1_MASK	0x3f00000
-#define MSM8976_S2_P1_MASK	0x3f
-#define MSM8976_S3_P1_MASK	0x3f000
-#define MSM8976_S4_P1_MASK	0x3f00
-#define MSM8976_S5_P1_MASK	0x3f00000
-#define MSM8976_S6_P1_MASK	0x3f
-#define MSM8976_S7_P1_MASK	0x3f000
-#define MSM8976_S8_P1_MASK	0x1f8
-#define MSM8976_S9_P1_MASK	0x1f8000
-#define MSM8976_S10_P1_MASK	0xf8000000
-#define MSM8976_S10_P1_MASK_1	0x1
-
-#define MSM8976_S0_P2_MASK	0xfc000
-#define MSM8976_S1_P2_MASK	0xfc000000
-#define MSM8976_S2_P2_MASK	0xfc0
-#define MSM8976_S3_P2_MASK	0xfc0000
-#define MSM8976_S4_P2_MASK	0xfc000
-#define MSM8976_S5_P2_MASK	0xfc000000
-#define MSM8976_S6_P2_MASK	0xfc0
-#define MSM8976_S7_P2_MASK	0xfc0000
-#define MSM8976_S8_P2_MASK	0x7e00
-#define MSM8976_S9_P2_MASK	0x7e00000
-#define MSM8976_S10_P2_MASK	0x7e
-
-#define MSM8976_S0_P1_SHIFT	8
-#define MSM8976_S1_P1_SHIFT	20
-#define MSM8976_S2_P1_SHIFT	0
-#define MSM8976_S3_P1_SHIFT	12
-#define MSM8976_S4_P1_SHIFT	8
-#define MSM8976_S5_P1_SHIFT	20
-#define MSM8976_S6_P1_SHIFT	0
-#define MSM8976_S7_P1_SHIFT	12
-#define MSM8976_S8_P1_SHIFT	3
-#define MSM8976_S9_P1_SHIFT	15
-#define MSM8976_S10_P1_SHIFT	27
-#define MSM8976_S10_P1_SHIFT_1	0
-
-#define MSM8976_S0_P2_SHIFT	14
-#define MSM8976_S1_P2_SHIFT	26
-#define MSM8976_S2_P2_SHIFT	6
-#define MSM8976_S3_P2_SHIFT	18
-#define MSM8976_S4_P2_SHIFT	14
-#define MSM8976_S5_P2_SHIFT	26
-#define MSM8976_S6_P2_SHIFT	6
-#define MSM8976_S7_P2_SHIFT	18
-#define MSM8976_S8_P2_SHIFT	9
-#define MSM8976_S9_P2_SHIFT	21
-#define MSM8976_S10_P2_SHIFT	1
-
-#define MSM8976_CAL_SEL_MASK	0x3
-
-/* eeprom layout data for qcs404/405 (v1) */
-#define BASE0_MASK	0x000007f8
-#define BASE1_MASK	0x0007f800
-#define BASE0_SHIFT	3
-#define BASE1_SHIFT	11
-
-#define S0_P1_MASK	0x0000003f
-#define S1_P1_MASK	0x0003f000
-#define S2_P1_MASK	0x3f000000
-#define S3_P1_MASK	0x000003f0
-#define S4_P1_MASK	0x003f0000
-#define S5_P1_MASK	0x0000003f
-#define S6_P1_MASK	0x0003f000
-#define S7_P1_MASK	0x3f000000
-#define S8_P1_MASK	0x000003f0
-#define S9_P1_MASK	0x003f0000
-
-#define S0_P2_MASK	0x00000fc0
-#define S1_P2_MASK	0x00fc0000
-#define S2_P2_MASK_1_0	0xc0000000
-#define S2_P2_MASK_5_2	0x0000000f
-#define S3_P2_MASK	0x0000fc00
-#define S4_P2_MASK	0x0fc00000
-#define S5_P2_MASK	0x00000fc0
-#define S6_P2_MASK	0x00fc0000
-#define S7_P2_MASK_1_0	0xc0000000
-#define S7_P2_MASK_5_2	0x0000000f
-#define S8_P2_MASK	0x0000fc00
-#define S9_P2_MASK	0x0fc00000
-
-#define S0_P1_SHIFT	0
-#define S0_P2_SHIFT	6
-#define S1_P1_SHIFT	12
-#define S1_P2_SHIFT	18
-#define S2_P1_SHIFT	24
-#define S2_P2_SHIFT_1_0	30
-
-#define S2_P2_SHIFT_5_2	0
-#define S3_P1_SHIFT	4
-#define S3_P2_SHIFT	10
-#define S4_P1_SHIFT	16
-#define S4_P2_SHIFT	22
-
-#define S5_P1_SHIFT	0
-#define S5_P2_SHIFT	6
-#define S6_P1_SHIFT	12
-#define S6_P2_SHIFT	18
-#define S7_P1_SHIFT	24
-#define S7_P2_SHIFT_1_0	30
-
-#define S7_P2_SHIFT_5_2	0
-#define S8_P1_SHIFT	4
-#define S8_P2_SHIFT	10
-#define S9_P1_SHIFT	16
-#define S9_P2_SHIFT	22
-
-#define CAL_SEL_MASK	7
-#define CAL_SEL_SHIFT	0
+struct tsens_legacy_calibration_format tsens_qcs404_nvmem = {
+	.base_len = 8,
+	.base_shift = 2,
+	.sp_len = 6,
+	.mode = { 4, 0 },
+	.invalid = { 4, 2 },
+	.base = { { 4, 3 }, { 4, 11 } },
+	.sp = {
+		{ { 0, 0 }, { 0, 6 } },
+		{ { 0, 12 }, { 0, 18 } },
+		{ { 0, 24 }, { 0, 30 } },
+		{ { 1, 4 },  { 1, 10 } },
+		{ { 1, 16 }, { 1, 22 } },
+		{ { 2, 0 },  { 2, 6 } },
+		{ { 2, 12 }, { 2, 18 } },
+		{ { 2, 24 }, { 2, 30 } },
+		{ { 3, 4 },  { 3, 10 } },
+		{ { 3, 16 }, { 3, 22 } },
+	},
+};
+
+struct tsens_legacy_calibration_format tsens_8976_nvmem = {
+	.base_len = 8,
+	.base_shift = 2,
+	.sp_len = 6,
+	.mode = { 4, 0 },
+	.invalid = { 4, 2 },
+	.base = { { 0, 0 }, { 2, 8 } },
+	.sp = {
+		{ { 0, 8 },  { 0, 14 } },
+		{ { 0, 20 }, { 0, 26 } },
+		{ { 1, 0 },  { 1, 6 } },
+		{ { 1, 12 }, { 1, 18 } },
+		{ { 2, 8 },  { 2, 14 } },
+		{ { 2, 20 }, { 2, 26 } },
+		{ { 3, 0 },  { 3, 6 } },
+		{ { 3, 12 }, { 3, 18 } },
+		{ { 4, 2 },  { 4, 9 } },
+		{ { 4, 14 }, { 4, 21 } },
+		{ { 4, 26 }, { 5, 1 } },
+	},
+};
 
 static int calibrate_v1(struct tsens_priv *priv)
 {
-	u32 base0 = 0, base1 = 0;
 	u32 p1[10], p2[10];
-	u32 mode = 0, lsb = 0, msb = 0;
 	u32 *qfprom_cdata;
-	int i, ret;
+	int mode, ret;
 
 	ret = tsens_calibrate_common(priv);
 	if (!ret)
@@ -153,53 +78,9 @@ static int calibrate_v1(struct tsens_priv *priv)
 	if (IS_ERR(qfprom_cdata))
 		return PTR_ERR(qfprom_cdata);
 
-	mode = (qfprom_cdata[4] & CAL_SEL_MASK) >> CAL_SEL_SHIFT;
-	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
-
-	switch (mode) {
-	case TWO_PT_CALIB:
-		base1 = (qfprom_cdata[4] & BASE1_MASK) >> BASE1_SHIFT;
-		p2[0] = (qfprom_cdata[0] & S0_P2_MASK) >> S0_P2_SHIFT;
-		p2[1] = (qfprom_cdata[0] & S1_P2_MASK) >> S1_P2_SHIFT;
-		/* This value is split over two registers, 2 bits and 4 bits */
-		lsb   = (qfprom_cdata[0] & S2_P2_MASK_1_0) >> S2_P2_SHIFT_1_0;
-		msb   = (qfprom_cdata[1] & S2_P2_MASK_5_2) >> S2_P2_SHIFT_5_2;
-		p2[2] = msb << 2 | lsb;
-		p2[3] = (qfprom_cdata[1] & S3_P2_MASK) >> S3_P2_SHIFT;
-		p2[4] = (qfprom_cdata[1] & S4_P2_MASK) >> S4_P2_SHIFT;
-		p2[5] = (qfprom_cdata[2] & S5_P2_MASK) >> S5_P2_SHIFT;
-		p2[6] = (qfprom_cdata[2] & S6_P2_MASK) >> S6_P2_SHIFT;
-		/* This value is split over two registers, 2 bits and 4 bits */
-		lsb   = (qfprom_cdata[2] & S7_P2_MASK_1_0) >> S7_P2_SHIFT_1_0;
-		msb   = (qfprom_cdata[3] & S7_P2_MASK_5_2) >> S7_P2_SHIFT_5_2;
-		p2[7] = msb << 2 | lsb;
-		p2[8] = (qfprom_cdata[3] & S8_P2_MASK) >> S8_P2_SHIFT;
-		p2[9] = (qfprom_cdata[3] & S9_P2_MASK) >> S9_P2_SHIFT;
-		for (i = 0; i < priv->num_sensors; i++)
-			p2[i] = ((base1 + p2[i]) << 2);
-		fallthrough;
-	case ONE_PT_CALIB2:
-		base0 = (qfprom_cdata[4] & BASE0_MASK) >> BASE0_SHIFT;
-		p1[0] = (qfprom_cdata[0] & S0_P1_MASK) >> S0_P1_SHIFT;
-		p1[1] = (qfprom_cdata[0] & S1_P1_MASK) >> S1_P1_SHIFT;
-		p1[2] = (qfprom_cdata[0] & S2_P1_MASK) >> S2_P1_SHIFT;
-		p1[3] = (qfprom_cdata[1] & S3_P1_MASK) >> S3_P1_SHIFT;
-		p1[4] = (qfprom_cdata[1] & S4_P1_MASK) >> S4_P1_SHIFT;
-		p1[5] = (qfprom_cdata[2] & S5_P1_MASK) >> S5_P1_SHIFT;
-		p1[6] = (qfprom_cdata[2] & S6_P1_MASK) >> S6_P1_SHIFT;
-		p1[7] = (qfprom_cdata[2] & S7_P1_MASK) >> S7_P1_SHIFT;
-		p1[8] = (qfprom_cdata[3] & S8_P1_MASK) >> S8_P1_SHIFT;
-		p1[9] = (qfprom_cdata[3] & S9_P1_MASK) >> S9_P1_SHIFT;
-		for (i = 0; i < priv->num_sensors; i++)
-			p1[i] = (((base0) + p1[i]) << 2);
-		break;
-	default:
-		for (i = 0; i < priv->num_sensors; i++) {
-			p1[i] = 500;
-			p2[i] = 780;
-		}
-		break;
-	}
+	mode = tsens_read_calibration_legacy(priv, &tsens_qcs404_nvmem,
+					     p1, p2,
+					     qfprom_cdata, NULL);
 
 	compute_intercept_slope(priv, p1, p2, mode);
 	kfree(qfprom_cdata);
@@ -209,11 +90,9 @@ static int calibrate_v1(struct tsens_priv *priv)
 
 static int calibrate_8976(struct tsens_priv *priv)
 {
-	int base0 = 0, base1 = 0, i;
 	u32 p1[11], p2[11];
-	int mode = 0, tmp = 0;
 	u32 *qfprom_cdata;
-	int ret;
+	int mode, ret;
 
 	ret = tsens_calibrate_common(priv);
 	if (!ret)
@@ -223,53 +102,10 @@ static int calibrate_8976(struct tsens_priv *priv)
 	if (IS_ERR(qfprom_cdata))
 		return PTR_ERR(qfprom_cdata);
 
-	mode = (qfprom_cdata[4] & MSM8976_CAL_SEL_MASK);
-	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
-
-	switch (mode) {
-	case TWO_PT_CALIB:
-		base1 = (qfprom_cdata[2] & MSM8976_BASE1_MASK) >> MSM8976_BASE1_SHIFT;
-		p2[0] = (qfprom_cdata[0] & MSM8976_S0_P2_MASK) >> MSM8976_S0_P2_SHIFT;
-		p2[1] = (qfprom_cdata[0] & MSM8976_S1_P2_MASK) >> MSM8976_S1_P2_SHIFT;
-		p2[2] = (qfprom_cdata[1] & MSM8976_S2_P2_MASK) >> MSM8976_S2_P2_SHIFT;
-		p2[3] = (qfprom_cdata[1] & MSM8976_S3_P2_MASK) >> MSM8976_S3_P2_SHIFT;
-		p2[4] = (qfprom_cdata[2] & MSM8976_S4_P2_MASK) >> MSM8976_S4_P2_SHIFT;
-		p2[5] = (qfprom_cdata[2] & MSM8976_S5_P2_MASK) >> MSM8976_S5_P2_SHIFT;
-		p2[6] = (qfprom_cdata[3] & MSM8976_S6_P2_MASK) >> MSM8976_S6_P2_SHIFT;
-		p2[7] = (qfprom_cdata[3] & MSM8976_S7_P2_MASK) >> MSM8976_S7_P2_SHIFT;
-		p2[8] = (qfprom_cdata[4] & MSM8976_S8_P2_MASK) >> MSM8976_S8_P2_SHIFT;
-		p2[9] = (qfprom_cdata[4] & MSM8976_S9_P2_MASK) >> MSM8976_S9_P2_SHIFT;
-		p2[10] = (qfprom_cdata[5] & MSM8976_S10_P2_MASK) >> MSM8976_S10_P2_SHIFT;
-
-		for (i = 0; i < priv->num_sensors; i++)
-			p2[i] = ((base1 + p2[i]) << 2);
-		fallthrough;
-	case ONE_PT_CALIB2:
-		base0 = qfprom_cdata[0] & MSM8976_BASE0_MASK;
-		p1[0] = (qfprom_cdata[0] & MSM8976_S0_P1_MASK) >> MSM8976_S0_P1_SHIFT;
-		p1[1] = (qfprom_cdata[0] & MSM8976_S1_P1_MASK) >> MSM8976_S1_P1_SHIFT;
-		p1[2] = (qfprom_cdata[1] & MSM8976_S2_P1_MASK) >> MSM8976_S2_P1_SHIFT;
-		p1[3] = (qfprom_cdata[1] & MSM8976_S3_P1_MASK) >> MSM8976_S3_P1_SHIFT;
-		p1[4] = (qfprom_cdata[2] & MSM8976_S4_P1_MASK) >> MSM8976_S4_P1_SHIFT;
-		p1[5] = (qfprom_cdata[2] & MSM8976_S5_P1_MASK) >> MSM8976_S5_P1_SHIFT;
-		p1[6] = (qfprom_cdata[3] & MSM8976_S6_P1_MASK) >> MSM8976_S6_P1_SHIFT;
-		p1[7] = (qfprom_cdata[3] & MSM8976_S7_P1_MASK) >> MSM8976_S7_P1_SHIFT;
-		p1[8] = (qfprom_cdata[4] & MSM8976_S8_P1_MASK) >> MSM8976_S8_P1_SHIFT;
-		p1[9] = (qfprom_cdata[4] & MSM8976_S9_P1_MASK) >> MSM8976_S9_P1_SHIFT;
-		p1[10] = (qfprom_cdata[4] & MSM8976_S10_P1_MASK) >> MSM8976_S10_P1_SHIFT;
-		tmp = (qfprom_cdata[5] & MSM8976_S10_P1_MASK_1) << MSM8976_S10_P1_SHIFT_1;
-		p1[10] |= tmp;
-
-		for (i = 0; i < priv->num_sensors; i++)
-			p1[i] = (((base0) + p1[i]) << 2);
-		break;
-	default:
-		for (i = 0; i < priv->num_sensors; i++) {
-			p1[i] = 500;
-			p2[i] = 780;
-		}
-		break;
-	}
+	mode = tsens_read_calibration_legacy(priv, &tsens_8976_nvmem,
+					     p1, p2,
+					     qfprom_cdata, NULL);
+
 
 	compute_intercept_slope(priv, p1, p2, mode);
 	kfree(qfprom_cdata);
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 6facdb0246a5..6d785ffe8fac 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -171,6 +171,70 @@ int tsens_calibrate_common(struct tsens_priv *priv)
 	return tsens_calibrate_nvmem(priv, 2);
 }
 
+static u32 tsens_read_cell(const struct tsens_single_value *cell, u8 len, u32 *data0, u32 *data1)
+{
+	u32 val;
+	u32 *data = cell->blob ? data1 : data0;
+
+	if (cell->shift + len <= 32) {
+		val = data[cell->idx] >> cell->shift;
+	} else {
+		u8 part = 32 - cell->shift;
+
+		val = data[cell->idx] >> cell->shift;
+		val |= data[cell->idx + 1] << part;
+	}
+
+	return val & ((1 << len) - 1);
+}
+
+int tsens_read_calibration_legacy(struct tsens_priv *priv,
+				  const struct tsens_legacy_calibration_format *format,
+				  u32 *p1, u32 *p2,
+				  u32 *cdata0, u32 *cdata1)
+{
+	u32 mode, invalid;
+	u32 base1, base2;
+	int i;
+
+	mode = tsens_read_cell(&format->mode, 2, cdata0, cdata1);
+	invalid = tsens_read_cell(&format->invalid, 1, cdata0, cdata1);
+	if (invalid)
+		mode = NO_PT_CALIB;
+	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
+
+	base1 = tsens_read_cell(&format->base[0], format->base_len, cdata0, cdata1);
+	base2 = tsens_read_cell(&format->base[1], format->base_len, cdata0, cdata1);
+
+	for (i = 0; i < priv->num_sensors; i++) {
+		p1[i] = tsens_read_cell(&format->sp[i][0], format->sp_len, cdata0, cdata1);
+		p2[i] = tsens_read_cell(&format->sp[i][1], format->sp_len, cdata0, cdata1);
+	}
+
+	switch (mode) {
+	case ONE_PT_CALIB:
+		for (i = 0; i < priv->num_sensors; i++)
+			p1[i] = p1[i] + (base1 << format->base_shift);
+		break;
+	case TWO_PT_CALIB:
+		for (i = 0; i < priv->num_sensors; i++)
+			p2[i] = (p2[i] + base2) << format->base_shift;
+		fallthrough;
+	case ONE_PT_CALIB2:
+		for (i = 0; i < priv->num_sensors; i++)
+			p1[i] = (p1[i] + base1) << format->base_shift;
+		break;
+	default:
+		dev_dbg(priv->dev, "calibrationless mode\n");
+		for (i = 0; i < priv->num_sensors; i++) {
+			p1[i] = 500;
+			p2[i] = 780;
+		}
+	}
+
+	return mode;
+}
+
 /*
  * Use this function on devices where slope and offset calculations
  * depend on calibration data read from qfprom. On others the slope
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index a9ae8df9f810..dba9cd38f637 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -584,7 +584,45 @@ struct tsens_priv {
 	struct tsens_sensor		sensor[];
 };
 
+/**
+ * struct tsens_single_value - internal representation of a single field inside nvmem calibration data
+ * @idx: index into the u32 data array
+ * @shift: the shift of the first bit in the value
+ * @blob: index of the data blob to use for this cell
+ */
+struct tsens_single_value {
+	u8 idx;
+	u8 shift;
+	u8 blob;
+};
+
+/**
+ * struct tsens_legacy_calibration_format - description of calibration data used when parsing the legacy nvmem blob
+ * @base_len: the length of the base fields inside calibration data
+ * @base_shift: the shift to be applied to base data
+ * @sp_len: the length of the sN_pM fields inside calibration data
+ * @mode: descriptor of the calibration mode field
+ * @invalid: descriptor of the calibration mode invalid field
+ * @base: descriptors of the base0 and base1 fields
+ * @sp: descriptors of the sN_pM fields
+ */
+struct tsens_legacy_calibration_format {
+	unsigned int base_len;
+	unsigned int base_shift;
+	unsigned int sp_len;
+	/* just two bits */
+	struct tsens_single_value mode;
+	/* on all platforms except 8974 invalid is the third bit of what downstream calls 'mode' */
+	struct tsens_single_value invalid;
+	struct tsens_single_value base[2];
+	struct tsens_single_value sp[][2];
+};
+
 char *qfprom_read(struct device *dev, const char *cname);
+int tsens_read_calibration_legacy(struct tsens_priv *priv,
+				  const struct tsens_legacy_calibration_format *format,
+				  u32 *p1, u32 *p2,
+				  u32 *cdata, u32 *csel);
 int tsens_read_calibration(struct tsens_priv *priv, int shift, u32 *p1, u32 *p2, bool backup);
 int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift);
 int tsens_calibrate_common(struct tsens_priv *priv);
-- 
2.39.0

