Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E082388342
	for <lists+linux-pm@lfdr.de>; Wed, 19 May 2021 01:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbhERXod (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 May 2021 19:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhERXod (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 May 2021 19:44:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CD4C061573;
        Tue, 18 May 2021 16:43:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id lg14so17197251ejb.9;
        Tue, 18 May 2021 16:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x6BN/PyTHg0vWjClj6KF7Z9rFUMiX9eq6dsc19wtdr4=;
        b=n6wyx8OsDzlIlED4O93DtiZhz6eERcfdK3k6vpm3EXg5zXa+1oUGm01Phbrrpzs5E5
         qQ3tdtBZEEq8WSlUxVi2s6/MX6K+dRSVOMGlPGRcbCYXmOZ98RF7KLngTJLuRvkRM2bZ
         DXUJtqfYPDb7zHt8Kyxccd5hrAG/hjvmfISMkpLyhd7prJ5RoLlvljk37X/Sa3VoK94d
         9zpcJJs5+jU7YZfoLm7PPZLZt1ZjlfzqMnOl2EFg+vb9QDqLxZdp570J0cascxregwnP
         ArFOogQv4PVTn1HGagK12A7ksXTgk1dCRcYDClJtElglk+t436DyUbYSrRI0dyEWIq8g
         eMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x6BN/PyTHg0vWjClj6KF7Z9rFUMiX9eq6dsc19wtdr4=;
        b=OS+eSAbOyDTWXeTOziUkrVex3I0qXPQPajvq9JP8RlqutYtb8ZAt4OTLx3e9WJXClt
         xdVFnZ6XK65AqrEz5Zf1fyZsu3GcnbV9sagM22QUTzC9cZKescUF55oYkcCxV3+6DmYm
         H6ZdwF84QdiHO7WslXQl+2w3dxFDi3SF6y2Y90hObEAXmMAqwj4CQLYvC3EGFrIw8UFn
         E9c5SnNWr4Ueykpj71l6cUPVa96EE8YfvwzAVvuQPcMA+X0EsdXSyU2PtT5e4/u2AvJ6
         jBvKnSV2kzqNO/w1KbWqw9Q7tW7FUoycAg0qiBOU7OKFhpdbscDOVoRtg6mYYH8kNDW6
         uLJQ==
X-Gm-Message-State: AOAM532Sz6+r/efZcgrBOG1LppOWk6Oc0mLZ3II6jAtx+RHSyPGXim6F
        +SX8y8TuNVnwrQ2HMegID30=
X-Google-Smtp-Source: ABdhPJyx4g0eF9jK3jR9GNaW4zcqF2TMglN8q9DN3A6CTzKP9unCmlTL3ltDAQYjzDHsTxzjwkO/DQ==
X-Received: by 2002:a17:906:640c:: with SMTP id d12mr8429650ejm.70.1621381392638;
        Tue, 18 May 2021 16:43:12 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id bm13sm11220567ejb.75.2021.05.18.16.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 16:43:12 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drivers: thermal: tsens: add timeout to get_tem_tsens_valid
Date:   Wed, 19 May 2021 01:43:06 +0200
Message-Id: <20210518234309.29014-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
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
2.30.2

