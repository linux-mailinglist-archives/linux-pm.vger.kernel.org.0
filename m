Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D5C532D7D
	for <lists+linux-pm@lfdr.de>; Tue, 24 May 2022 17:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbiEXP2e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 May 2022 11:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238912AbiEXP2V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2022 11:28:21 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634E69CF39
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2022 08:28:12 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z15so2390845wrg.11
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2022 08:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oy1kZAZOz3Zat+eCWp1ANSEO/o3HnHK4I7yTTp9RPUg=;
        b=y2QIOTyTAkw1SY+KmTimrQNjMGU50fuosL+870SicdiajGcu0by8NuImsQxD51qLzP
         owwT9JnOcOzd7FnxNVgO97ya+zTjP5oEHJIq7XplQEO/rEcPTIOpd0DEMR6rC4uFoKg/
         yU9ZoJBwdx6NxF5+OITCdq3g9p5xhXnLn35COO0ThATeBHYqRl2e4mFhAg4KLPvSNvdo
         MA70ngH1QCdxPFyurlqEY4IOjIcVNEctaKjbinz7xp5eE13XQidMbTQ6nqtQPvCEoxdm
         qztsKLP0WoizYJUbBhu0bj+HjTP1Mrv8zTQh5bkyQu+becx/FiijWnBRcVGw4jueRZXb
         S4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oy1kZAZOz3Zat+eCWp1ANSEO/o3HnHK4I7yTTp9RPUg=;
        b=iClvqOD/s0cheRRQ94WVycdHtco+505lp4+OjWso6cgiUNakiag2psw9ulc7M5xiYA
         NFgC14YO5ajtHxDGrgwDZSPpQi5Ux4wrp7mMQPRljasTb1G7n2bNSZFf2H0ZSmY98uH1
         mSy4lmnd/nXwF4ffhXmvB3LmwWPdJT/ZpDq16G+PJPY3jcEISx1JvzSTL1l7cW7sXZJH
         WJHS+bC1+qv6VOLxrqIpslRSYBdm7ukokIDoeTTWOlbCQLf6x1DNAbRjANhieGSUOX0w
         U0Uf4jBPCYDvgYHceA5VutFdXyUYYSFRp0li8zu7+ZAMJIzM8fZ68qROwE3Tx4o8Svfu
         RErg==
X-Gm-Message-State: AOAM530HEkbySPlUsb/8wFCihWBc+QXHlpAgYllL+7F6lTLaH9Ke2R7H
        PE9KHLmMdQOZ8/lIBabX2xi1jA==
X-Google-Smtp-Source: ABdhPJzHXNQGnyXKK6XqhtJp7RswjDASwaTe1SVr75wS7O0TZMXeZJBZKo4mgwr9U6fU/8lBOyibbg==
X-Received: by 2002:a05:6000:1a8d:b0:20f:e61b:5203 with SMTP id f13-20020a0560001a8d00b0020fe61b5203mr7093450wry.109.1653406090517;
        Tue, 24 May 2022 08:28:10 -0700 (PDT)
Received: from xps-9300.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k24-20020a05600c1c9800b003974027722csm2703693wms.47.2022.05.24.08.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 08:28:09 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v7 5/6] arm64: dts: mt8195: Add efuse node to mt8195
Date:   Tue, 24 May 2022 17:25:52 +0200
Message-Id: <20220524152552.246193-6-abailon@baylibre.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524152552.246193-1-abailon@baylibre.com>
References: <20220524152552.246193-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds the efuse node. This will be required by the thermal driver
to get the calibration data.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 0011a8ba8f96..51443e83d906 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1238,6 +1238,23 @@ nor_flash: spi@1132c000 {
 			status = "disabled";
 		};
 
+		efuse: efuse@11c10000 {
+			compatible = "mediatek,efuse";
+			reg = <0 0x11c10000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			lvts_e_data1: data1 {
+				reg = <0x1bc 0x14>;
+			};
+			lvts_e_data2: data1-1 {
+				reg = <0x1d0 0x38>;
+			};
+			svs_calibration: calib@580 {
+				reg = <0x580 0x64>;
+			};
+		};
+
 		u3phy2: t-phy@11c40000 {
 			compatible = "mediatek,mt8195-tphy", "mediatek,generic-tphy-v3";
 			#address-cells = <1>;
-- 
2.35.1

