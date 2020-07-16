Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00F92219F0
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 04:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGPC2d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 22:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgGPC22 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 22:28:28 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE9EC061755;
        Wed, 15 Jul 2020 19:28:28 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so5249936wrm.4;
        Wed, 15 Jul 2020 19:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NMGpsGsTomyvbhuxUBbF2KBZ5U7/Gj4W0Zm7Cz/Tuck=;
        b=l8cR4NU56aOZ3mHbYkRDNMhvVeRyLGj1gne9YoLCdF45QWddvdGfSTQoVMt4jSHnan
         sD1BLjXjlUbcUyWf9KYEzw7XkXdBpsv/zXhJ4UZo+23E8TX9y7iWGrxxPviqy76fCR20
         an/vgp6jlxa1LmK+X6s6ZfZxdkqae5svzQAb33Po1C8G8E98cUFjxVomblId6v8P+LtI
         ppkeAMnCIc6DNCYcG3RLxrqglDo/pD1AxP4IgXlwr7CNu8Z92t0C52OnRYLi/PLpbgV/
         tGMlzNoEoIyBrghcBIAZYgrUFK8AOzG05tFHDd4bh/rfq83JNqZI1JwpQbRSJBG65sO7
         DQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NMGpsGsTomyvbhuxUBbF2KBZ5U7/Gj4W0Zm7Cz/Tuck=;
        b=OckZ1HD/sZke8VDowamon4DymowUkxPa5TSZguOYNffk/OiGoA0RLeED17kQN0KZXM
         qG28hqax8BSLURGhoDc5MVEZsVRMfGmhanrCrlowtsc0MHdoni/hEgWRZJvBslYDKdr7
         q3Za3RUtG7+ZibHznouhhPqFWSgPMbx0LSAxgiJo8ZNmZuh67ZUPa6SHYbriUJIxJprF
         Cv1ysY+l23cOCzSIS7wxvUGz0shbOquzn4K8KoITjzeU7ZrAKb+Oq7eS6nZDYSktYyoo
         nHHuEsApfTP0fYouAfv8MaO6RWJgLJfZxLMXTL+YHr3LXrMhVh87y9ZbNK4IdvZ/o6gt
         MHYg==
X-Gm-Message-State: AOAM531w4MR8OblfKA2biQSrU9KJa/qwK53cQNwuKSznq5dkquVEVPRf
        CFblrJvfo6KqITVtj7UyuZU=
X-Google-Smtp-Source: ABdhPJxJAsBtiMpZ3+Al418gUaONCeToX/sTi4riGXieRkPadBAWYCNCqBF6C+rfo4Gp8wicLCmFNg==
X-Received: by 2002:adf:e9c4:: with SMTP id l4mr2644495wrn.9.1594866506692;
        Wed, 15 Jul 2020 19:28:26 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-7-31-173.retail.telecomitalia.it. [87.7.31.173])
        by smtp.googlemail.com with ESMTPSA id u1sm7477611wrb.78.2020.07.15.19.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 19:28:26 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 2/7] drivers: thermal: tsens: try load regmap from parent for 8960
Date:   Thu, 16 Jul 2020 04:28:11 +0200
Message-Id: <20200716022817.30439-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716022817.30439-1-ansuelsmth@gmail.com>
References: <20200716022817.30439-1-ansuelsmth@gmail.com>
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

