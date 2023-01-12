Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077D466798A
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jan 2023 16:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbjALPjN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Jan 2023 10:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240572AbjALPis (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Jan 2023 10:38:48 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3808225F8
        for <linux-pm@vger.kernel.org>; Thu, 12 Jan 2023 07:29:57 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e3so9236682wru.13
        for <linux-pm@vger.kernel.org>; Thu, 12 Jan 2023 07:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uqegivo06ni2uw8aCUgMRe2pmSyBI28Ht6YBxVVOckk=;
        b=IRAFQCNtHY/UvGlzxoyB13GflYu7GWMy5iKQE0dPIHmEFVdLre8sY5yc5AyuxnmXML
         EvxiThKaM9NnLePX289opg8ijNnokMNMrnVfDLeedkehG163Lzq1lHb7WszuRZbS6l1P
         Qz8emFJJ/Uvr2hm108nUV1PpZuGJkH4sn7GhTuK7Az2l4qAFPv8yaIKpGjPRVQQxMIy1
         Nli5ttNg+ck+zZ+h2J+iETYhjtzKRiKm7KhYJGIJ96yWiZHnEXfWOLo6hFRJ0wcB5YLa
         8Os7EmawAlRpNivq9fvwO15HlmrdjZaLuTnseGgJmmHZ16ZcVJzTmIastJaMXWfMO7XZ
         jk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uqegivo06ni2uw8aCUgMRe2pmSyBI28Ht6YBxVVOckk=;
        b=OergQBmaAYZ5OnP0jmPRfhqS9YtxzoYSO+GCvNJST+XTdEleUTbXbwr+PGGM65jMjQ
         0wF66hpE1f5oogLOue+a290HYvf0o0UaOf0CWerTB1RUr4ygCVgQf+I/x8nmQCq41M2g
         wPfu393j5KO6q+AdXO0KBGjZ+WSSlBQJRZfc/zLNmZl4uePUE3WMamg1LeMGM6n2+Snv
         yaPbewtXGRxe+xd0cfDbAyxX2kz5wj4gcWGWSWzzxJY6s80Gp9vhD4eHeXCirG9AtNtS
         wKzNx0pLkhxeVDpgaTyK+ottEPPjmchIGwO4AydpU9dh2lGP4L0AekXKJkpufWBEbmS2
         8o1w==
X-Gm-Message-State: AFqh2kqNb/yTY0iL9OBtkEfV5f8bBfzK8yhaxWyTEwg2Q/PR/ntwjJmU
        3f+WaoB68vBZXcnba5YbPAAMZfkRiE/seJgg
X-Google-Smtp-Source: AMrXdXvrv25II5DU9O9FfCGJOwCGvgerXAk0j62cqG3N+/NSvc0qssMR2zDta0ueNbMu8xG2JDx5SA==
X-Received: by 2002:adf:e987:0:b0:2bb:e891:1829 with SMTP id h7-20020adfe987000000b002bbe8911829mr11869254wrm.4.1673537395581;
        Thu, 12 Jan 2023 07:29:55 -0800 (PST)
Received: from t480-bl003.civfrance.com (58.188.158.77.rev.sfr.net. [77.158.188.58])
        by smtp.gmail.com with ESMTPSA id l24-20020a1ced18000000b003d99da8d30asm26395909wmh.46.2023.01.12.07.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:29:55 -0800 (PST)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: [PATCH v10 3/6] arm64/dts/mt8195: Add efuse node to mt8195
Date:   Thu, 12 Jan 2023 16:28:52 +0100
Message-Id: <20230112152855.216072-4-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112152855.216072-1-bchihi@baylibre.com>
References: <20230112152855.216072-1-bchihi@baylibre.com>
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

