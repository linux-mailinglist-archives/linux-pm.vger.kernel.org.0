Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895B2596B03
	for <lists+linux-pm@lfdr.de>; Wed, 17 Aug 2022 10:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbiHQIIy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Aug 2022 04:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiHQIIx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Aug 2022 04:08:53 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6338551A15
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2022 01:08:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z16so15263368wrh.12
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2022 01:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=XFhFdGS4gab18LiNO0E9EIMJdc3E4TwobGsMEPo69aw=;
        b=6SH+adSirsQoZZ7hs2noCxi688TUpUJhcU0j79bRwxs/rHH8544iWt2GNS+4gkg1Kt
         c+MnCThDyXByjMNz0sV7zovfXokhtb0HR/SiCUCAGgZHY0OS2dOtmQz/bAHKDxmS8GJk
         vP0AxBjik0XVs6MwvhVZfc/BIJ3GZgclGg5oneyMi5gs/wKyEWhyRkUi27jZtM43z5h9
         0XHhLuJDzHRsazjbBd6fWRBVaxIiBV4K5FfofPp0Ny+k0SgGARP21sXNORwQXC94c9eB
         NId4tZ6/v6t8A5eX7JGmiiZ8PasGUvXyQ3V0NUGQq6KPtV6WQg49X6tJ7PSlv+yxb6An
         wBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=XFhFdGS4gab18LiNO0E9EIMJdc3E4TwobGsMEPo69aw=;
        b=Rr4qDdB1m+4AgEGyjwz8vmUOQDUBoHDdLUnKsN1q+EbSHKJs/UVFkaV0XGYGJPwbEO
         L8d6+KO+fI2dz1UvLrvExIaemSfYKFIDnjIv/7HSPIS3wxp2O9ICyNHdBcSUgBLZz/xP
         sZAr5LG1etvwYDDo8qunGXMWXbQL9uvgbhHG2HrJrolaEw9c2MUS7+ElNEIC7ax0UViA
         Zc7LjdD2eIieEj/99FTF70gijkQyf1CRSvMYn6g5Q1uVRxvAukYjzlCP1beT3Em5NGBy
         zQDneyr97m8sxkh+riN1QjpO0IpgCHnEmDESFG4QKWMANl0ZUetxuW5iPpsOLLgkhpMM
         FkhQ==
X-Gm-Message-State: ACgBeo3mR3/X8Cb6+M8iPT3vRxzX9Wwf+a//c4rK8/tX77boSiCQl9PG
        6CW2bNnzH13wlNZmYH7JQkskMw==
X-Google-Smtp-Source: AA6agR51Zl6xt+vxQT7gT7KACFEBbbFyESTGV94CTa/rv4g0vzVgLg37XjUImbsILtMPON9atLrVTQ==
X-Received: by 2002:a5d:6f05:0:b0:223:8bfc:dd0f with SMTP id ay5-20020a5d6f05000000b002238bfcdd0fmr13349400wrb.547.1660723730931;
        Wed, 17 Aug 2022 01:08:50 -0700 (PDT)
Received: from Balsam-ThinkPad-T480.civfrance.com (58.188.158.77.rev.sfr.net. [77.158.188.58])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b003a54d610e5fsm1391992wmq.26.2022.08.17.01.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 01:08:50 -0700 (PDT)
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
Subject: [PATCH v9,5/7] arm64: dts: mt8195: Add efuse node to mt8195
Date:   Wed, 17 Aug 2022 10:07:55 +0200
Message-Id: <20220817080757.352021-6-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817080757.352021-1-bchihi@baylibre.com>
References: <20220817080757.352021-1-bchihi@baylibre.com>
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

From: Alexandre Bailon <abailon@baylibre.com>

Add efuse node.
This will be required by the thermal driver to get the calibration data.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Co-developed-by: Balsam CHIHI <bchihi@baylibre.com>
Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 066c14989708..95967a0196d8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
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

