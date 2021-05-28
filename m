Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD3F39422F
	for <lists+linux-pm@lfdr.de>; Fri, 28 May 2021 13:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbhE1LxC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 May 2021 07:53:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41038 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbhE1LxA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 May 2021 07:53:00 -0400
Received: from mail-ua1-f69.google.com ([209.85.222.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmb1R-00041O-Kb
        for linux-pm@vger.kernel.org; Fri, 28 May 2021 11:51:25 +0000
Received: by mail-ua1-f69.google.com with SMTP id j17-20020ab018510000b029020db76022bbso1781488uag.12
        for <linux-pm@vger.kernel.org>; Fri, 28 May 2021 04:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+A7NmETeNVsWXQhhgLVcq4I2U3ly5GO/4a+00+Ltec0=;
        b=EoF6G2fXPBrVTsuvx2tzmGzqo8w7FsWMP1apMJ5OIR18VgrefADCaUxO1Rwe+K49eD
         ZUVUSeah+uOh2rid73T7xl5scZH4aEgwBiQhBRyxGRxOmOrjxFARqivj91ZF1h01zUDJ
         rUdJJ35NahImMZ+epqHCCyF8c84r4siEHcVKIffVKcaoJRrHXsaA3hODlyDAxImV3ZNS
         2l8KNKPZnUAQ6SiQX4TwwqY0ioq/m3u8L8kdZ5Ni/GU2tz9uBYGIN7/N/gNiA2UTwAoC
         92qyrnzIC3ziTpavvTzxxTnC4YqfSZdSp5AgXN2LSopiuqke9vlaKbYYI+U09pX4NGTC
         SKLw==
X-Gm-Message-State: AOAM532hqIEDCXB1rryDplSp2xNwHGvYdnujuSvHGGTQALcXPqNyFMtr
        Ip2UtT1wLVkJiEgoOBaGbtzFJJHTy/LX7uQvZhM+wFjXoZ7uiynWr1joXVSenfYR7w2ppUNKosq
        ivX2H69R5chx31t6JFI79HkvcOZ08SZxt1vxV
X-Received: by 2002:a67:6a02:: with SMTP id f2mr6264731vsc.49.1622202680526;
        Fri, 28 May 2021 04:51:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8wp965ZXdOS/URJI0BlvrioKqZR1rbzc1/KfnNkSONQtzH+C+OVVa8fj46i7Np0GVLTF3wQ==
X-Received: by 2002:a67:6a02:: with SMTP id f2mr6264723vsc.49.1622202680342;
        Fri, 28 May 2021 04:51:20 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.5])
        by smtp.gmail.com with ESMTPSA id 189sm669831vkz.51.2021.05.28.04.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:51:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [RESEND PATCH 2/2] thermal: sprd: add missing of_node_put for loop iteration
Date:   Fri, 28 May 2021 07:50:36 -0400
Message-Id: <20210528115036.18222-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528115036.18222-1-krzysztof.kozlowski@canonical.com>
References: <20210528115036.18222-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Early exits from for_each_available_child_of_node() should decrement the
node reference counter.  Reported by Coccinelle:

  drivers/thermal/sprd_thermal.c:387:1-23: WARNING:
    Function "for_each_child_of_node" should have of_node_put() before goto around lines 391.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 drivers/thermal/sprd_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index 3682edb2f466..2778971aaf03 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -388,6 +388,7 @@ static int sprd_thm_probe(struct platform_device *pdev)
 		sen = devm_kzalloc(&pdev->dev, sizeof(*sen), GFP_KERNEL);
 		if (!sen) {
 			ret = -ENOMEM;
+			of_node_put(sen_child);
 			goto disable_clk;
 		}
 
@@ -397,12 +398,14 @@ static int sprd_thm_probe(struct platform_device *pdev)
 		ret = of_property_read_u32(sen_child, "reg", &sen->id);
 		if (ret) {
 			dev_err(&pdev->dev, "get sensor reg failed");
+			of_node_put(sen_child);
 			goto disable_clk;
 		}
 
 		ret = sprd_thm_sensor_calibration(sen_child, thm, sen);
 		if (ret) {
 			dev_err(&pdev->dev, "efuse cal analysis failed");
+			of_node_put(sen_child);
 			goto disable_clk;
 		}
 
@@ -416,6 +419,7 @@ static int sprd_thm_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "register thermal zone failed %d\n",
 				sen->id);
 			ret = PTR_ERR(sen->tzd);
+			of_node_put(sen_child);
 			goto disable_clk;
 		}
 
-- 
2.27.0

