Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A377068D88E
	for <lists+linux-pm@lfdr.de>; Tue,  7 Feb 2023 14:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjBGNKp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Feb 2023 08:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjBGNKg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2023 08:10:36 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5374B3B0DE
        for <linux-pm@vger.kernel.org>; Tue,  7 Feb 2023 05:10:09 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id z13so3520354wmp.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Feb 2023 05:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEZ62LqDvDzX1VguBPg2bF9iW8q30+KnwJCoYFfoSfE=;
        b=HZLccW93Ea9VpcjJ8rUdS91FX1dJE90KE5ylp3upj3AhKDndLy+svyKHyOxct5xT/I
         ye4BZlHwANYP9K8hR9AoEit9zS3zIYRtNk+8KaZ+CwLWDRGmGES2qNzl4x0Tptd8/vbJ
         s68mX5t1nF1J5hFFLWPCu5Y9P0sWtwMqV2TmYf0T23HzbocV0Ect2GKhDAkwYA0ojyl7
         4i6h5AVU5C4VLJx3WnfFHJQYTc1CJ/DwVTh0VrzE++qJ3+dikR+iZp7kH8zC+5DN6JjZ
         50TN9pCMwFdKlvePN+Dzy8xdaZIT83h+cuis06B1Vvm/238q3nsLxHo849s1JKhGrg1Q
         jz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEZ62LqDvDzX1VguBPg2bF9iW8q30+KnwJCoYFfoSfE=;
        b=tyKGl3Hs1ptAsz7hBgwr68OeaV55kAi3FeWmyqp79vbMvyyrGNWChufVbrqob+5VGu
         L2Syo0WdzUHdmYxqIjqc4l0eNU1SYwRQcAFqBuxdNbbrRszHhxuSIoMggT+RkfyEKHC9
         QLELhsQPHIyOnOfQT2o6b0dUFd7XGIKauNk+tVV8UDgVmBr2ZdnquqbFSCGN/NharWjC
         cFPF1Jsn+N/9yh8lNtw5GeuqYN/f31hqLUyTIHSz5eGute3dy+Tc14i6NgEceBTiiUEs
         SEuhYxUTNBXhnD6NJtpEHHN2HAYZoURzJf4DddCwUy52UdqZUljRcZUFMZXzD3FgodpJ
         sK2g==
X-Gm-Message-State: AO0yUKUhsmy5Jw+48rjfvg65H1HGjIyiYBziTHc9LTJTnsC9GM+kuJ98
        qadyRVkWBEyiiM8NUSbyny62ow==
X-Google-Smtp-Source: AK7set8/kziMcUYX6ThGKn0ND5WTsk1Xc6t8EQEjkj2EEnSOpANJAHf7t89xlR5rt5EhQwVLYIhujg==
X-Received: by 2002:a05:600c:3296:b0:3dd:dd46:1274 with SMTP id t22-20020a05600c329600b003dddd461274mr3071054wmp.4.1675775403813;
        Tue, 07 Feb 2023 05:10:03 -0800 (PST)
Received: from t480-bl003.civfrance.com (58.188.158.77.rev.sfr.net. [77.158.188.58])
        by smtp.gmail.com with ESMTPSA id g24-20020a7bc4d8000000b003df30c94850sm17987385wmk.25.2023.02.07.05.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 05:10:03 -0800 (PST)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: [PATCH v13 3/6] arm64: dts: mt8195: Add efuse node to mt8195
Date:   Tue,  7 Feb 2023 14:09:55 +0100
Message-Id: <20230207130958.608305-4-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207130958.608305-1-bchihi@baylibre.com>
References: <20230207130958.608305-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add efuse node.
This will be required by the thermal driver to get the calibration data.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20230124131717.128660-4-bchihi@baylibre.com
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
no changes.
---
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 5d31536f4c48..09df105f4606 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1380,6 +1380,12 @@ pciephy_glb_intr: pciephy-glb-intr@193 {
 			dp_calibration: dp-data@1ac {
 				reg = <0x1ac 0x10>;
 			};
+			lvts_efuse_data1: lvts1-calib@1bc {
+				reg = <0x1bc 0x14>;
+			};
+			lvts_efuse_data2: lvts2-calib@1d0 {
+				reg = <0x1d0 0x38>;
+			};
 		};
 
 		u3phy2: t-phy@11c40000 {
-- 
2.34.1

