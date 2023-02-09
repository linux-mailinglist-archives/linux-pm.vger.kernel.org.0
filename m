Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D6A6905D2
	for <lists+linux-pm@lfdr.de>; Thu,  9 Feb 2023 11:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjBIK4w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Feb 2023 05:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjBIK4i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Feb 2023 05:56:38 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A4025960
        for <linux-pm@vger.kernel.org>; Thu,  9 Feb 2023 02:56:36 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so1231885wms.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Feb 2023 02:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8K5BTAdm/41pw2lI++GgH00C0SE0jCet8VtGW2Mqre8=;
        b=Zef6VMLJZcfIVwCEekVCGv46hyyCGghuKPKSuvfPuQIezDx0/rQw54pw8u2yiN+WYp
         TTf1AUz/4bTwe8hSJwa8Ima0TJ5CCAMKpQhfOyM48yqlU2u++7JCly8TWrbhbyYy+4kB
         bzftMcStydIOzoGjZu+WwOpzU3PgoUXfa7A8jbqqBZTyMqyDxQSfLn5FRNdbphnaGTQG
         zd82cxmc8KGuzaYxru54ywSbpldfm56Jc9bsRYSFG8CZcIq9MdJldOc5riEqVF0rlZU7
         cwdPkYA3myNUisWVWPJW1AUcZONHlBxuBG6VDYAnyEmyZkUKXtyV9iiILoT4V68NankR
         9hmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8K5BTAdm/41pw2lI++GgH00C0SE0jCet8VtGW2Mqre8=;
        b=yRKXPzvjx4XYHsWLx1PeKvWu56MyvGSUYAfWJlCSd25nnQO4Q7UKiMsSdFUNPW6e9S
         q7mfsxYHc1SLMu2WuWsQbKNms5gXvxMKP9L6uk8w8SBI1WB398POmxDyn8kIEHeWXOHz
         Ltwk8W7bBJor0NdlIzN8N2pMwHGzSihclFHy5M6/QJQx0OT8L0qdNzKxnd8ZLZkr+ecu
         FBE/jKYdHllTzUouTdp5xlF9e2fo8vbk8kuYvDs3Z3HZ7sgW2QIZPUeoQMstwMmjys/T
         hQ0POJm6z+Qn2Qaychxqpnu+AqHjrP1w2fP3/oFH/af70ZHwBbjgpUomiWu8eYcksvKN
         lqoA==
X-Gm-Message-State: AO0yUKVE274LJDW7BElErFJr0Me+WrhMTCYdG0ksY+J+nF87f0h2bYgR
        oPJZmTN0+8PgckvyXbhAyyRDwA==
X-Google-Smtp-Source: AK7set8J2kRY8jrOhNBF+a/ygnyy2766CJqX11hnvdRms+/MtEyECj/QlPAhN6+Rqaf0oo8W9j5OmQ==
X-Received: by 2002:a05:600c:3198:b0:3e1:12d1:fde0 with SMTP id s24-20020a05600c319800b003e112d1fde0mr2357401wmp.6.1675940195567;
        Thu, 09 Feb 2023 02:56:35 -0800 (PST)
Received: from t480-bl003.. (185.173.185.81.rev.sfr.net. [81.185.173.185])
        by smtp.gmail.com with ESMTPSA id j37-20020a05600c1c2500b003daf6e3bc2fsm9140466wms.1.2023.02.09.02.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 02:56:35 -0800 (PST)
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
Subject: [PATCH v14 3/6] arm64: dts: mt8195: Add efuse node to mt8195
Date:   Thu,  9 Feb 2023 11:56:25 +0100
Message-Id: <20230209105628.50294-4-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209105628.50294-1-bchihi@baylibre.com>
References: <20230209105628.50294-1-bchihi@baylibre.com>
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

From: Balsam CHIHI <bchihi@baylibre.com>

Add efuse node.
This will be required by the thermal driver to get the calibration data.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20230124131717.128660-4-bchihi@baylibre.com
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 5d31536f4c486..09df105f4606d 100644
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

