Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2692217F8
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 00:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgGOWpj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 18:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgGOWpi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 18:45:38 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16125C061755;
        Wed, 15 Jul 2020 15:45:38 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so7542946wmh.4;
        Wed, 15 Jul 2020 15:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NMGpsGsTomyvbhuxUBbF2KBZ5U7/Gj4W0Zm7Cz/Tuck=;
        b=VTw/EenjHg9eQcYDVFcDf6W2uX4oCqGrAXTDlOI8To0QXZsCmYqI6r7ZhbfoxjYbmF
         swyUDZGSHBSmFm2JhU+HSTUL12xeRcGr2qkorbYZt7bzSNDJHlUVwoNPZxHiDL8Dra2k
         qyGfNXnq1fWXJbrVOrl/L5888J+5EY7VBlSN1PnvemkkV6WN1alozCgxq1k5uws7GDcE
         8ZKQ251dbm5POrpVYMdG9kuYyGyJiF1Dq8/s5c28fZAV5vxi7eP8zGFuGBUhdhVPTGnh
         lV2km3WmnNSaK18uD/FbZB9uYkmXcp8VaMS6BJNgq4/89Hf8vuC2JMuuS7VeJw1o3nqQ
         ykqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NMGpsGsTomyvbhuxUBbF2KBZ5U7/Gj4W0Zm7Cz/Tuck=;
        b=Xkb8Wb1FixSHcjAzN/pVDu76Zgfa/e+ognMMdtEVQKsnrOOgEwt4DDnumGKuD8Gtyo
         wsNW1G+Agd7WpBxrgWaM6/IMBJ2GcFZZuksppOSpapJE4Z4e+/rMt4yEeIaFk+YtISYF
         uCJ5kDrAmOcLxEcE3PUDGWS/CZtY8URUDHARpBpZ4zfIp0jC/Vbpr78RNxoM2d/IpJ+q
         vLS+n2GCt2Itbw9LdwLEM+4LwSBgbQ8Es2+05TRyrSxITCDXMyusbtVZZBqWLUIvXeT8
         Zo7+QktJKPPqylVBTuHLQMAAZj8UXPDwFT/hXI3NRhTanGT/R+1IF+6hmn/g2YJ9cGi0
         oRHw==
X-Gm-Message-State: AOAM531YYyZLc3ByjFS1zuNBsWF8wmNEeVUgt7O0Hdx6FO+tcsbbcY+4
        RW9JZhrTBCMl6+vC1AiUv7c=
X-Google-Smtp-Source: ABdhPJyTSJas4sCv/QyWfka6X6q0Nu+BkSg5RVP351kIoFh7+8x30AHm/OJUHCm7Cq2r3Oaib39pzA==
X-Received: by 2002:a1c:c3c5:: with SMTP id t188mr1760579wmf.53.1594853136767;
        Wed, 15 Jul 2020 15:45:36 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-7-31-173.retail.telecomitalia.it. [87.7.31.173])
        by smtp.googlemail.com with ESMTPSA id b186sm5759898wme.1.2020.07.15.15.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 15:45:36 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 2/7] drivers: thermal: tsens: try load regmap from parent for 8960
Date:   Thu, 16 Jul 2020 00:44:57 +0200
Message-Id: <20200715224503.30462-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200715224503.30462-1-ansuelsmth@gmail.com>
References: <20200715224503.30462-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Devices based on 8060 tsens driver (ipq8064) use the reg of the gcc
driver. Try to load the regmap of the parent as they share the same
regs.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens-8960.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 2a28a5af209e..45788eb3c666 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/bitops.h>
 #include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 #include <linux/thermal.h>
 #include "tsens.h"
 
@@ -168,8 +169,17 @@ static int init_8960(struct tsens_priv *priv)
 	u32 reg_cntl;
 
 	priv->tm_map = dev_get_regmap(priv->dev, NULL);
-	if (!priv->tm_map)
+	if (!priv->tm_map) {
+		struct device *parent = priv->dev->parent;
+
+		if (parent)
+			priv->tm_map = syscon_node_to_regmap(parent->of_node);
+	}
+
+	if (!priv->tm_map || IS_ERR(priv->tm_map)) {
+		dev_err(priv->dev, "failed to get tsens regmap\n");
 		return -ENODEV;
+	}
 
 	/*
 	 * The status registers for each sensor are discontiguous
-- 
2.27.0

