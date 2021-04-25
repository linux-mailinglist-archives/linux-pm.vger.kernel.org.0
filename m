Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F4936A8A7
	for <lists+linux-pm@lfdr.de>; Sun, 25 Apr 2021 19:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhDYRtQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Apr 2021 13:49:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51428 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhDYRtQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Apr 2021 13:49:16 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lairz-0005Bu-7C
        for linux-pm@vger.kernel.org; Sun, 25 Apr 2021 17:48:35 +0000
Received: by mail-ed1-f69.google.com with SMTP id v5-20020a0564023485b029037ff13253bcso21696232edc.3
        for <linux-pm@vger.kernel.org>; Sun, 25 Apr 2021 10:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kVodXUWFIv1StlNhsCxeISwWmMQVwpJ7c9xxG779QVA=;
        b=dxKKHw0Nxjhj1O9EzJ1gAr0NSACUB73kawM7kvAK16RtBrYGQpCp1Ja1RZe3EL+dVP
         LIKc1pbvoVb87XAHpvfkqDxt2e/eNt+fS/TrQhjjujPXIYl3dFrEMJWpoNlN+VzLd6Be
         e+tKoQ3SdGrpFkT33cx3zuDGNQixvrK4nMF+MHEIEmkqg2NOqE3p9Z3BGpG+2Y66Xj/z
         0N7Ce33v6cinDtehrPAVI3UtaWIzS2EG2UqWUy+4xCbYcgScJsBGINrh17lgFcVhBuR2
         dS7XyxN/wH2P+3q0aCBRhd4cxlMyoXFkJ3aDRcOu8PcN3Rxm+CpJ0XQojqhQjqBpH4n9
         3/0w==
X-Gm-Message-State: AOAM533Y1pyUAIFg/wTw4426RRFdomMrm194d+pBbp2MjBx0+klRyvwV
        SQim3p1HNPlBh4yeaHinGA4LARiiOlp2P8HJIuJx9F45V9844LFUY9yVHg7wsz0+NFV9v2YpZnE
        SUb5KxdyRvbxZlBvkuG0iObUpH0DOkVzxZ+YG
X-Received: by 2002:a05:6402:254c:: with SMTP id l12mr16391008edb.278.1619372914974;
        Sun, 25 Apr 2021 10:48:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzolb7zLjAcU4+/dDd+2aB9KGmAzm0XhLGhZiJ9wmqpb2ijBM0MhQ3z5v8iz+L3Nl+EgH6O+A==
X-Received: by 2002:a05:6402:254c:: with SMTP id l12mr16390994edb.278.1619372914855;
        Sun, 25 Apr 2021 10:48:34 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id c12sm10306849eja.12.2021.04.25.10.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 10:48:34 -0700 (PDT)
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
Subject: [PATCH 1/2] thermal: imx_sc: add missing of_node_put for loop iteration
Date:   Sun, 25 Apr 2021 19:48:30 +0200
Message-Id: <20210425174831.164332-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Early exits from for_each_available_child_of_node() should decrement the
node reference counter.  Reported by Coccinelle:

  drivers/thermal/imx_sc_thermal.c:93:1-33: WARNING:
    Function "for_each_available_child_of_node" should have of_node_put() before return around line 97.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/thermal/imx_sc_thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index b01d28eca7ee..8d76dbfde6a9 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -93,6 +93,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 	for_each_available_child_of_node(np, child) {
 		sensor = devm_kzalloc(&pdev->dev, sizeof(*sensor), GFP_KERNEL);
 		if (!sensor) {
+			of_node_put(child);
 			of_node_put(sensor_np);
 			return -ENOMEM;
 		}
@@ -104,6 +105,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"failed to get valid sensor resource id: %d\n",
 				ret);
+			of_node_put(child);
 			break;
 		}
 
@@ -114,6 +116,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 		if (IS_ERR(sensor->tzd)) {
 			dev_err(&pdev->dev, "failed to register thermal zone\n");
 			ret = PTR_ERR(sensor->tzd);
+			of_node_put(child);
 			break;
 		}
 
-- 
2.25.1

