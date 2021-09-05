Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD606401113
	for <lists+linux-pm@lfdr.de>; Sun,  5 Sep 2021 19:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhIERsk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Sep 2021 13:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbhIERsj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Sep 2021 13:48:39 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDACC061575;
        Sun,  5 Sep 2021 10:47:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id x11so8626821ejv.0;
        Sun, 05 Sep 2021 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QboeAPIj7q4xYx6MRMC7Q7dkylvLtoIsEfoKZWMl7EI=;
        b=PHzbwSxBuU+mOLEBcNDRVmH/3cVAyv/EcPAG4r4oVh5ef5VXgRtVZILa31pDVMfPVU
         iF4lhCVoHI053siTkzpyQ+jP6wQUGW334epu6y6ScLVtmfGzCz+L/N0dy/Tc4/AEIr8q
         wYy3HjglIz5JInnxv9f0jTkB/qopjySSmp+UdZiuVHhuD+69ARv3e7cuYCvRtxwdxkqo
         Vx36BFH3zzoahBazuarmcN9T4DRwixf2KR0PthoCrjresTNfuxQjYX91cgWhBc9x38P3
         9WCGU+86FqoOZboE8Dff1IA1QexLFIyitYegdxx6ALQM6nmWk9l16RUCWCf2C4bFr72S
         CD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QboeAPIj7q4xYx6MRMC7Q7dkylvLtoIsEfoKZWMl7EI=;
        b=dV5GQtUJPOaucsDYNzdg/XA+PJo9ujAZt4Oz6c/ayH5VZyDkt0njROQIAnsONUuV/q
         cyvxxB1RL5XsQahvzi+K0aquVuVf1L84lZdRERVzDyC4s/onHRsj3AVzG0OhKE2OmtIB
         +m2XcaJZz6RWUy9IzQ29GH9ueUQ1xKa8Ut+YqzoZLZiHsQvknZ04UHLUfpRp+WMUhEAt
         E1Tq/UhoZL3pdV1eOIrCKqy5drQwAeu4zg/uQ0eX5d8I0g7+bc01jPm7XBu+mh45tdVL
         gaqk69Ii+n/olnfIbowJ8yQMZfE8Qb1S/usWsqX4/ZpefvbiSe3MINPj7PqPgrTav6P1
         ZSAg==
X-Gm-Message-State: AOAM532sZPCMhQLdKCw9KFHzmG+eLH3wQgQrenZOXL82deYqxYHM+OEE
        qaWwy6pIZpRbzdmS4vWesgM=
X-Google-Smtp-Source: ABdhPJyZcx0foOr2Kvb2vzkM5aprQd4iqZZueHVT/jssgrfXHI3pwZYdOVU0awzLKSTLLHj8P3J7nA==
X-Received: by 2002:a17:906:417:: with SMTP id d23mr9991169eja.383.1630864054059;
        Sun, 05 Sep 2021 10:47:34 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-19-158-155.retail.telecomitalia.it. [79.19.158.155])
        by smtp.googlemail.com with ESMTPSA id j13sm3165986edt.72.2021.09.05.10.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 10:47:33 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 2/2] drivers: thermal: tsens: add timeout to get_tem_tsens_valid
Date:   Sun,  5 Sep 2021 19:47:08 +0200
Message-Id: <20210905174708.4605-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210905174708.4605-1-ansuelsmth@gmail.com>
References: <20210905174708.4605-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function can loop and lock the system if for whatever reason the bit
for the target sensor is NEVER valid. This is the case if a sensor is
disabled by the factory and the valid bit is never reported as actually
valid. Add a timeout check and exit if a timeout occurs. As this is
a very rare condition, handle the timeout only if the first read fails.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index b1162e566a70..38afde1a599f 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -599,6 +599,7 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 	int hw_id = s->hw_id;
 	u32 temp_idx = LAST_TEMP_0 + hw_id;
 	u32 valid_idx = VALID_0 + hw_id;
+	unsigned long timeout;
 	u32 valid;
 	int ret;
 
@@ -607,13 +608,21 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 		ret = regmap_field_read(priv->rf[valid_idx], &valid);
 		if (ret)
 			return ret;
-		while (!valid) {
-			/* Valid bit is 0 for 6 AHB clock cycles.
-			 * At 19.2MHz, 1 AHB clock is ~60ns.
-			 * We should enter this loop very, very rarely.
-			 */
-			ndelay(400);
-			ret = regmap_field_read(priv->rf[valid_idx], &valid);
+
+		if (!valid) {
+			timeout = jiffies + msecs_to_jiffies(20);
+
+			do {
+				/* Valid bit is 0 for 6 AHB clock cycles.
+				 * At 19.2MHz, 1 AHB clock is ~60ns.
+				 * We should enter this loop very, very rarely.
+				 */
+				ndelay(400);
+				ret = regmap_field_read(priv->rf[valid_idx], &valid);
+				if (valid || ret)
+					break;
+			} while (!(ret = time_after_eq(jiffies, timeout)));
+
 			if (ret)
 				return ret;
 		}
-- 
2.32.0

