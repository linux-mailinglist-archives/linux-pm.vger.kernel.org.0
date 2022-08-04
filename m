Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8A8589C44
	for <lists+linux-pm@lfdr.de>; Thu,  4 Aug 2022 15:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbiHDNKT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Aug 2022 09:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbiHDNKN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2022 09:10:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CCF18366
        for <linux-pm@vger.kernel.org>; Thu,  4 Aug 2022 06:10:05 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l22so25241425wrz.7
        for <linux-pm@vger.kernel.org>; Thu, 04 Aug 2022 06:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WNYml0pJZwTGwtJKLLK7VkX/NLD3rdkLagQmwO0aon0=;
        b=ZIF8770Ihf88JsnID2E4OKI0p+G1KqCThV1B61k6ZnS8dsLIOYFWyCkB7bDfs7agFr
         d0wl7p9RVQBrWZNoxLdVC2hu2PCA9l0ZYwEDNXpC8RlnTcJ87X/Owzk6sQ4MCvd9WyWR
         1MuXn+M5hdTC9n6LvkQ33zzNgRbfwSqFW4ZK4nqYWDhkeg1VCLHk6odj7c4kLWKxG2eg
         4qdrFDyQbKjanHaWKGYQ5WuWEGMR+Pan0cQPTsTT2Q4dRqMxCxyWtWZ/sPAaEegUKBOA
         CCcutBRhbY4YNhFVm9AwHvlxP0QBOKRffr9nlfwiomPmmuSXw1iMyW6s4PsoDtUihjbP
         O6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WNYml0pJZwTGwtJKLLK7VkX/NLD3rdkLagQmwO0aon0=;
        b=tEcGXhwfIAVKLihN9YgLJkw4VS7RFsKdYgjZqfhjgH3LhJUfQNGPJEh/6b2l18n7Px
         CmUf1DwuvrswHT6HV5Er5DabiYTxLNAO0Yfnj/zy55tmBVPCOIN7KB9RIpclqvhif9I7
         awJuUlV5O4PwEJINkH2t+3OYxF/xGndll6yw6Tz5kciTIkbAiBJehkbXLXzEkjusRku8
         iMIHsN9ULL6IUMwGLZAB3xl16Q4vBAsO7+lCmKydGPWRempV4lVUAypzFzNaa7nYvlYC
         jXWXdnKy9XtB9QKSPlaq9GHflkruY6nfbmNej37+br09ABgqHgJ7iZS9mt7kCOBQiVQH
         vhnA==
X-Gm-Message-State: ACgBeo2E2v/vioBUZ6S8ltYtaNo8Ym206FiW/pSc3S+T3PKTDhASoGoK
        XsWP9wGXaGFDGtOJGil3rn/OaA==
X-Google-Smtp-Source: AA6agR4i2eds1JM8hnk2a0haj7V4iukZavQOGw33veGLMXvkiAhhA/wBiCQmQspA8M6Bxt5N1Bt3zQ==
X-Received: by 2002:adf:ef8b:0:b0:220:8235:124 with SMTP id d11-20020adfef8b000000b0022082350124mr1378639wro.628.1659618605481;
        Thu, 04 Aug 2022 06:10:05 -0700 (PDT)
Received: from Balsam-ThinkPad-T480.. (235.163.185.81.rev.sfr.net. [81.185.163.235])
        by smtp.gmail.com with ESMTPSA id o15-20020adfcf0f000000b0021d6a520ce9sm1156817wrj.47.2022.08.04.06.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 06:10:05 -0700 (PDT)
From:   bchihi@baylibre.com
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Subject: [PATCH v8.1, 5/7] arm64: dts: mt8195: Add efuse node to mt8195
Date:   Thu,  4 Aug 2022 15:09:10 +0200
Message-Id: <20220804130912.676043-6-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220804130912.676043-1-bchihi@baylibre.com>
References: <20220804130912.676043-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Alexandre Bailon <abailon@baylibre.com>

This adds the efuse node. This will be required by the thermal driver
to get the calibration data.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 73a0e2103b83..cbd0401968a2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
- * Copyright (c) 2021 MediaTek Inc.
+ * Copyright (c) 2022 MediaTek Inc.
  * Author: Seiya Wang <seiya.wang@mediatek.com>
  */
 
@@ -733,6 +733,18 @@ u2_intr_p3: usb2-intr-p3@189,2 {
 				reg = <0x189 0x2>;
 				bits = <7 5>;
 			};
+
+			lvts_efuse_data1: lvts1-calib@1bc {
+				reg = <0x1bc 0x14>;
+			};
+
+			lvts_efuse_data2: lvts2-calib@1d0 {
+				reg = <0x1d0 0x38>;
+			};
+
+			svs_calibration: calib@580 {
+				reg = <0x580 0x64>;
+			};
 		};
 
 		u3phy2: t-phy@11c40000 {
-- 
2.34.1

