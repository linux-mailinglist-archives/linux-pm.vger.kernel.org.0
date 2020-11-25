Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E892C4D38
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 03:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733069AbgKZCMb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 21:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732838AbgKZCM2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 21:12:28 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A23FC0613D4;
        Wed, 25 Nov 2020 18:12:28 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id k4so588104edl.0;
        Wed, 25 Nov 2020 18:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O0qe7oIz20vmKxuGqEFKoOxtqbsQn05TcW7sLZuS3Bs=;
        b=N0aQDwHhQHzYRqKfp748d+z7YntGYV7ipjMrz8zV5WB1ORzQfrnI/mj4fXk+5WeGaD
         J39vlU5abGU/1KD1JIPFPyj0y2ekQJW/D2hEPyBHRjalGHBHknhA4S14ZhWY07wGWQ/M
         C1nFR4mdiN4PNoRRWXbG7NcI+qOFgXNkNcJeKLHuxgVPKP87yTYvdDS2b0HSjjvI9DKk
         lkEWrUd4K2qDUwFizlwFgxCRuV+BxNYfRBtfwjOV+EJ/880KJKLSULtGGgNW8eHOGP1z
         QRAXXiyaVO6j4VItcY66wkjAS9QdzpX1DlqNMcCsCMmhUZ5UgfMyq/q9/oicILxpPdB/
         jOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O0qe7oIz20vmKxuGqEFKoOxtqbsQn05TcW7sLZuS3Bs=;
        b=ZSgNAR7+jAKcT3hj0qaHTv/pH34MRnMMHJF7C667zQh2qV5jrmaRZo3rEJKR0qsDx/
         a2au8XPPssUpH/MMU8KeDiSGumPdkM20ws5FlkAMFf6I1jkC+3fgIst3osmJT10vf8bR
         f8cJ6Qu+Sij9olCDI459eF249bILBc6OpX3wCKFYFzcYcg2YX0ccKE8Ze2zNSsRBgE/r
         1xXQ/b6qOuktQ1pzV7st23I1NSmXmsrdX9eTXy4RmyWMhqmQV8tVPBEcMiLwiTCijE+z
         nfbAXAue6zuviZzKFsMp4wwwL7/9ukbDjX4A4LcPX2azokVatzpa1ilkvYPxm4E8ai5p
         QrTg==
X-Gm-Message-State: AOAM533LGfghnpgGbrz4JbTxlSUojePrXFYpQa8yN8Iyepj3czxUhr2u
        EOK3hvYxpHRZ4pQ/HKCQDJc=
X-Google-Smtp-Source: ABdhPJyBvkkG/E1UWL4vQBngd6UbbvfU36I65vCOb+wVVnnC5bmA29N5JVtN5Bhle8xaa2vi87DRdg==
X-Received: by 2002:aa7:c44d:: with SMTP id n13mr529533edr.138.1606356747115;
        Wed, 25 Nov 2020 18:12:27 -0800 (PST)
Received: from ansuel-xps20.localdomain (93-39-149-95.ip76.fastwebnet.it. [93.39.149.95])
        by smtp.googlemail.com with ESMTPSA id d7sm417276edv.17.2020.11.25.18.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 18:12:26 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/8] drivers: thermal: tsens: Don't hardcode sensor slope
Date:   Wed, 25 Nov 2020 18:48:19 +0100
Message-Id: <20201125174826.24462-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125174826.24462-1-ansuelsmth@gmail.com>
References: <20201125174826.24462-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Function compute_intercept_slope hardcode the sensor slope to
SLOPE_DEFAULT. Change this and use the default value only if a slope is
not defined. This is needed for tsens VER_0 that has a hardcoded slope
table.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index bda965b3ac05..80551e17cdbe 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -86,7 +86,8 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 			"%s: sensor%d - data_point1:%#x data_point2:%#x\n",
 			__func__, i, p1[i], p2[i]);
 
-		priv->sensor[i].slope = SLOPE_DEFAULT;
+		if (!priv->sensor[i].slope)
+			priv->sensor[i].slope = SLOPE_DEFAULT;
 		if (mode == TWO_PT_CALIB) {
 			/*
 			 * slope (m) = adc_code2 - adc_code1 (y2 - y1)/
-- 
2.29.2

