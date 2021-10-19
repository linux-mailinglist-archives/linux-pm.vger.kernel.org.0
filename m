Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9C543326A
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 11:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbhJSJiq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 05:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbhJSJin (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 05:38:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B05BC06161C
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 02:36:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so2422812wmz.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 02:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4iBt5PaBb/SQkmIAGIPWPkHg9L+YHvcMfnSpD3LPoVg=;
        b=RK+5r5PwEA/nuA6SQzYqBleLenuGSzS9bmVPSgmr30nYakGL83fg5O29IqmUhqTMSz
         7Gcz6od5O0ScvHxpYw0qK/0TwGLi3UWhkIfrTfMGbSwCLg5oaQx9td5xU7dA+1t42YNS
         u5hERCsAx9QENchxYFqV61KzePoxXK+NZXQ+e9kBphHBFw/qeQ0V6w5NeIVUthLNaA5e
         xHwd3UTYdP3K4iZYTZcCrBuz2qpb/+kToloaGtsFIYqF1Tr9+OavLKXW99ZOKyJFtmg9
         buEnZ1+oqdBqcvf30QXT0uh+is2HrMukQHi68HyrBp6FuwEVzhWH0SaghAHfuqtjPo6Z
         Faew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4iBt5PaBb/SQkmIAGIPWPkHg9L+YHvcMfnSpD3LPoVg=;
        b=x7KkUcqIZuuOF0EfNz224qZnlqZbVNys1hw+HWjDjTlDWfvnqqn53bDc2TFEgmAxmc
         dTwf5MqW9LXWxwO3rHxU5GNOTEh7mWAAFSKmEifiyqoBAZb0UO/ma7FFL7g7r8LpPnhh
         vOV9RX3wgEPm51mCTQ3XBxIA43O+/5HyklJUWPlEGKmUZpZ+qsLUErvyp44a0c/cv48R
         1KKaHnoUlzEAGU46QPHYQKWLngABz7luZMfIYEtgP+0SBd6taIIQL87uylOxZrW237KA
         MH9bpn/G/j6A+3HbV701/uxUU0HDGQ/Lfwwz9InK35pQND9GyDWSgDlyCbGX0mpLR4YS
         t7Bg==
X-Gm-Message-State: AOAM5300g28agkCxJbXziZAk87eubgDYUSdcqwJRKq3rNxnvKQ3JI+B3
        7SlTxeH6YqM43R3vjnTBltC1Kw==
X-Google-Smtp-Source: ABdhPJyWlQB++OW76/yEH4NmsYV5AtI/qYWUDcxm+rP4W3MU5xU76g2eBRuPCVnJT3D8VtWE+sU+Ow==
X-Received: by 2002:a1c:4b08:: with SMTP id y8mr5016066wma.98.1634636189302;
        Tue, 19 Oct 2021 02:36:29 -0700 (PDT)
Received: from blmsp.lan ([2a02:2454:3e6:c900:5142:5fbb:5821:5dc3])
        by smtp.gmail.com with ESMTPSA id o23sm1765765wms.18.2021.10.19.02.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 02:36:28 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fparent@baylibre.com,
        khilman@baylibre.com, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 3/4] thermal: mediatek: Remove data void casts
Date:   Tue, 19 Oct 2021 11:34:03 +0200
Message-Id: <20211019093404.1913357-4-msp@baylibre.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019093404.1913357-1-msp@baylibre.com>
References: <20211019093404.1913357-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It is not necessary to cast struct mtk_thermal_data to (void*).

This patch removes these casts.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/thermal/mtk_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 93ee043d70da..af6cd11eb221 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -941,23 +941,23 @@ static int mtk_thermal_get_calibration_data(struct device *dev,
 static const struct of_device_id mtk_thermal_of_match[] = {
 	{
 		.compatible = "mediatek,mt8173-thermal",
-		.data = (void *)&mt8173_thermal_data,
+		.data = &mt8173_thermal_data,
 	},
 	{
 		.compatible = "mediatek,mt2701-thermal",
-		.data = (void *)&mt2701_thermal_data,
+		.data = &mt2701_thermal_data,
 	},
 	{
 		.compatible = "mediatek,mt2712-thermal",
-		.data = (void *)&mt2712_thermal_data,
+		.data = &mt2712_thermal_data,
 	},
 	{
 		.compatible = "mediatek,mt7622-thermal",
-		.data = (void *)&mt7622_thermal_data,
+		.data = &mt7622_thermal_data,
 	},
 	{
 		.compatible = "mediatek,mt8183-thermal",
-		.data = (void *)&mt8183_thermal_data,
+		.data = &mt8183_thermal_data,
 	}, {
 	},
 };
-- 
2.33.0

