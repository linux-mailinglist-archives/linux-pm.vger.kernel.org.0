Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E584F425975
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 19:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242175AbhJGRbN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 13:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbhJGRbN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 13:31:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00020C061570;
        Thu,  7 Oct 2021 10:29:18 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x7so25121818edd.6;
        Thu, 07 Oct 2021 10:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hYLvmWFA5adKzLqY8vh9rsTQj1QLK0NjY6Bw35bbszk=;
        b=ZxU/kKXF7cyEIXZI9nPCJqFh8bFK61q/s4Xpg3CwLpqPocUeSV2ge0BsFLjYKIQ90g
         SpaiktjcqpUS/FkUxJ/Grbc5CJSMvdWuw42INjaoPWPa17iK0rpQ0hLGr6NAuzubczu4
         eYJ4SUMiyBLNUwwMMQNI9PG28LNtu5g+IuibXsd5SrRu0m7/hJvzPtT27H8GZnWJqFF+
         2bsrvxdZlR65/ZpeFtp6UzHJvaEvFfmAxS2VWgQ0cB8bx2WLbE7kzT9AOd8fn1W5Elde
         SpuCXjfOzRVMQJV/+9C3rf4s8T5cuKtnc1tTFyrtvCkmIbDcA5ANRXGgy9R6IDWprIex
         jy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hYLvmWFA5adKzLqY8vh9rsTQj1QLK0NjY6Bw35bbszk=;
        b=xqrzGu1I70Az7yyibs4cxErKQaolhOSce7Xk5ATogJM7/38wE2V+YTSlyT57d3WI/f
         6j8PAxVZScZoNef0Cpnp1plp/h7B739Wv3wT57rYH5PMnVHxeKy5O+Q34y/VlBsUim5U
         99EfdWoYxNCNJZ4BZV1Cd0oot8+hRwPVa/L0p4ykM0tAZ/ZxhbnXRRESj0jFhbiYghi4
         fXJJLgmCkww8dpLE+ab7HrVY2M6JaPRXhojFI/ySMUA+PWHRIbDnrp9xQxGPzNs7Crya
         sLifFW8qFYu06qYTjJeU2VmRv84VKZlCXDcStBM9D144VLUOjuEP3qWHFQbYrZnYpXLL
         tIWg==
X-Gm-Message-State: AOAM532Vv7SUfZoCyQowOzz3nXMipfDzAuiL9ozMFNgEgZ2kyjf8Vaw8
        pwavSPHydKaG3K84iPqK5QTBsLswDHk=
X-Google-Smtp-Source: ABdhPJxMEDMaeFqCL9p94v6LFA50CgO6F7/U7k5UrDG275Hca+Re167GlxvIKzQniCJ9+OL0sWiNXA==
X-Received: by 2002:a17:906:1e51:: with SMTP id i17mr7221216ejj.528.1633627756962;
        Thu, 07 Oct 2021 10:29:16 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id g23sm35316edt.1.2021.10.07.10.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 10:29:16 -0700 (PDT)
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
Subject: [RESEND PATCH v3] drivers: thermal: tsens: add timeout to get_temp_tsens_valid
Date:   Thu,  7 Oct 2021 19:28:59 +0200
Message-Id: <20211007172859.583-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.32.0
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
While at it also rework the function to improve readability and convert
to poll_timeout generic macro.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index b1162e566a70..99a8d9f3e03c 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -603,22 +603,21 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 	int ret;
 
 	/* VER_0 doesn't have VALID bit */
-	if (tsens_version(priv) >= VER_0_1) {
-		ret = regmap_field_read(priv->rf[valid_idx], &valid);
-		if (ret)
-			return ret;
-		while (!valid) {
-			/* Valid bit is 0 for 6 AHB clock cycles.
-			 * At 19.2MHz, 1 AHB clock is ~60ns.
-			 * We should enter this loop very, very rarely.
-			 */
-			ndelay(400);
-			ret = regmap_field_read(priv->rf[valid_idx], &valid);
-			if (ret)
-				return ret;
-		}
-	}
+	if (tsens_version(priv) == VER_0)
+		goto get_temp;
+
+	/* Valid bit is 0 for 6 AHB clock cycles.
+	 * At 19.2MHz, 1 AHB clock is ~60ns.
+	 * We should enter this loop very, very rarely.
+	 * Wait 1 us since it's the min of poll_timeout macro.
+	 * Old value was 400 ns.
+	 */
+	ret = regmap_field_read_poll_timeout(priv->rf[valid_idx], valid,
+					     valid, 1, 20 * USEC_PER_MSEC);
+	if (ret)
+		return ret;
 
+get_temp:
 	/* Valid bit is set, OK to read the temperature */
 	*temp = tsens_hw_to_mC(s, temp_idx);
 
-- 
2.32.0

