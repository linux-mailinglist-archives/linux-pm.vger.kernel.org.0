Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543312C4D44
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 03:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbgKZCMf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 21:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732838AbgKZCMe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 21:12:34 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB8CC0613D4;
        Wed, 25 Nov 2020 18:12:33 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id oq3so608830ejb.7;
        Wed, 25 Nov 2020 18:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ILjgLO1gu3OAaJ22R8SZw9mkrx615wQIxgl8+dYN3Gg=;
        b=IVWWFORNV5BHhFaYS+NvMN3osEnjqv7jCERz48upU8l2dI5uDmpS2Fr24s95chsXFi
         FBxQ+H54wYOPVxTQ7LzyxGGY162GbqGLaTbP/oSAmYPFAGSiTtq1PW34z+lecYeNa3k0
         wqgeO7PSvwj2xZEMuyT1fQVJU9IUftjG3qd0A3QcAusd+AWhUKm7dUZJ3idaOobjqWbb
         ITH/QEKj9DUA4CicU6sCUSimcr8riZoF254Q0ALKPg3uj6dgVZ03NQUIGdkkmnMo+NZR
         DyBgICtW98GGYWW7hQgyCVAp/t6RUCCRrBblZm3M8XitZapYntGtGFhBYkVJ62/GixcL
         alQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ILjgLO1gu3OAaJ22R8SZw9mkrx615wQIxgl8+dYN3Gg=;
        b=sZwWIHV5PQaOOzi3Rr6iEHerbZc7p8HkOVwcyuwTg/JQ7IWYe5sVIRJkBiXphRXHEM
         MQN1tAn8szrju6iOt5AUnPZg1NYPVxUjvrEV2qlSvTfj86yqvWv3tBcVzRi2ZtLCrUmG
         yehOJwZu/kjBPq9sE0zpglla9oiAqzyUxBReMBR3twJZVRZYkroQZjywmV8R13x0l9PV
         A28CQajPd8NUHhS+0k4NowRAZDZOzqC+UapN+fTVxjaoMcsDMZfCV6Re2hnH0MKuvLjI
         wmr+e4RV1wDhWy9jTCBnJyIXaBqZuRVMD1K04/JCRyId/mawFXsiX+xQn/LB1+bpQMM7
         MfGg==
X-Gm-Message-State: AOAM533HXEA61qj2NWX48HpDMx38f5DBz+dcrAVomsZrwBuIhEsaM39o
        6KMcT4E7gUJV+AJrSnKmhuE=
X-Google-Smtp-Source: ABdhPJxbDo53ZIGywt/XVzIMgDLvC5bng5aRcQkFz7cZYZDdlAMe6RlLz245mtl3Zqpim/SmadiRJw==
X-Received: by 2002:a17:906:7b49:: with SMTP id n9mr730677ejo.418.1606356752572;
        Wed, 25 Nov 2020 18:12:32 -0800 (PST)
Received: from ansuel-xps20.localdomain (93-39-149-95.ip76.fastwebnet.it. [93.39.149.95])
        by smtp.googlemail.com with ESMTPSA id d7sm417276edv.17.2020.11.25.18.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 18:12:31 -0800 (PST)
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
Subject: [PATCH v7 5/8] drivers: thermal: tsens: Fix bug in sensor enable for msm8960
Date:   Wed, 25 Nov 2020 18:48:22 +0100
Message-Id: <20201125174826.24462-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125174826.24462-1-ansuelsmth@gmail.com>
References: <20201125174826.24462-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's present a hardware bug in tsens VER_0 where if sensors upper to id
6 are enabled selectively, underfined results are expected. Fix this by
enabling all the remaining sensor in one step.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens-8960.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 93d2c6c7d1bd..f786f44f5d5d 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -27,9 +27,9 @@
 #define EN			BIT(0)
 #define SW_RST			BIT(1)
 #define SENSOR0_EN		BIT(3)
+#define MEASURE_PERIOD		BIT(18)
 #define SLP_CLK_ENA		BIT(26)
 #define SLP_CLK_ENA_8660	BIT(24)
-#define MEASURE_PERIOD		1
 #define SENSOR0_SHIFT		3
 
 /* INT_STATUS_ADDR bitmasks */
@@ -132,11 +132,26 @@ static int enable_8960(struct tsens_priv *priv, int id)
 	if (ret)
 		return ret;
 
-	mask = BIT(id + SENSOR0_SHIFT);
+	/* HARDWARE BUG:
+	 * On platform with more than 5 sensors, all the remaining
+	 * sensors needs to be enabled all togheder or underfined
+	 * results are expected. (Sensor 6-7 disabled, Sensor 3
+	 * disabled...) In the original driver, all the sensors
+	 * are enabled in one step hence this bug is not triggered.
+	 */
+	if (id > 5)
+		mask = GENMASK(10, 6);
+	else
+		mask = BIT(id);
+
+	mask <<= SENSOR0_SHIFT;
+
 	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg | SW_RST);
 	if (ret)
 		return ret;
 
+	reg |= MEASURE_PERIOD;
+
 	if (priv->num_sensors > 1)
 		reg |= mask | SLP_CLK_ENA | EN;
 	else
-- 
2.29.2

