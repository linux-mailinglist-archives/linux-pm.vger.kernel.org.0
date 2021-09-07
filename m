Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42781403045
	for <lists+linux-pm@lfdr.de>; Tue,  7 Sep 2021 23:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347194AbhIGV1P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Sep 2021 17:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347162AbhIGV1O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Sep 2021 17:27:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3357AC061575;
        Tue,  7 Sep 2021 14:26:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jg16so998394ejc.1;
        Tue, 07 Sep 2021 14:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vXNO3olbtma7hE++jUWc8ulS7UJFRFsM1r+fEg/Xcr4=;
        b=HAVHm8zN9QEe7OrVNoo+oKh4DguUxWBObO+mW8cUZbceKX0u4PqXMzCnOUmyaGzfRX
         zYSYgRhUgH5K1QHLtrD/Oitonl8impOAq46EeEiZDmb+B2floTTd8hvhRHkyXniyK8cU
         +Sgxzks3H7DQil7UiUjiLl0eJF0WCGOFWp140DuhgFIHvVs11VmPVuZ5KMNSzalBvTZ/
         wbNvY/fi6V1OtPsY+hKuk/ovxu3Pnnz20a7RLlJW3tF70g81/YXM1xbmN1w37V2mLZhd
         1EiC3EDfb2MljCQRrkQpiqY/RYE+xMVReUWEV6hbCrx5B7ZGEFCxTmc18wCg+P3tEENw
         L/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vXNO3olbtma7hE++jUWc8ulS7UJFRFsM1r+fEg/Xcr4=;
        b=IBB1hcMLw3nf7Bj2xa+76QlL3G04s7ND/MYiXgcFixZxv8YshwgGh8Po0haiVMxmks
         sKRJ9sHydv82EBeK/Xk7nPEpbyeH5XA+nEiP8TWDd17IbtvDZYEuHgP+0WWLciNUurFZ
         75QtZSOjIGuVj1nxmfoFCIvqnCWUhd5+o6gQHICzOA7eJya6Ltk/g+DjRpfYMhYTzoWv
         el44BAHlYZ9ETCvpedctVxdHHEzknd+Ch5ApUcQ4ci+m4jEUUZNtCs7cxPTJQPUz8o88
         3WhG6gC1S30k8b/Gy2SB5LJci51lv3FrvvEQ3jo7JwJQKRMeEnjOPe/P0/zlo5TWzniJ
         lXrw==
X-Gm-Message-State: AOAM532dqdGSwMzHQrHUiStPqJGOXxm1xsWOgplmlD73f8Bgy8W9RWSS
        iJB/qXkrhSAepeq5/GXgNVw=
X-Google-Smtp-Source: ABdhPJyPV8hLqzZZs74jWSed62ing6ThzHcIExC67z5gLH5M8CmTD/ZC1M/mFQdvLFp6AdlyxFQkvA==
X-Received: by 2002:a17:906:7848:: with SMTP id p8mr410174ejm.212.1631049965630;
        Tue, 07 Sep 2021 14:26:05 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-87-0-193-30.retail.telecomitalia.it. [87.0.193.30])
        by smtp.googlemail.com with ESMTPSA id k6sm105954edv.77.2021.09.07.14.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:26:05 -0700 (PDT)
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
Subject: [PATCH v2 2/2] drivers: thermal: tsens: add timeout to get_tem_tsens_valid
Date:   Tue,  7 Sep 2021 23:25:43 +0200
Message-Id: <20210907212543.20220-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210907212543.20220-1-ansuelsmth@gmail.com>
References: <20210907212543.20220-1-ansuelsmth@gmail.com>
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
While at it also rework the function to improve readability.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 40 +++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index b1162e566a70..1ff244176beb 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -599,26 +599,38 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 	int hw_id = s->hw_id;
 	u32 temp_idx = LAST_TEMP_0 + hw_id;
 	u32 valid_idx = VALID_0 + hw_id;
+	unsigned long timeout;
 	u32 valid;
 	int ret;
 
 	/* VER_0 doesn't have VALID bit */
-	if (tsens_version(priv) >= VER_0_1) {
+	if (tsens_version(priv) == VER_0)
+		goto get_temp;
+
+	ret = regmap_field_read(priv->rf[valid_idx], &valid);
+	if (ret || valid)
+		goto check_valid;
+
+	timeout = jiffies + msecs_to_jiffies(20);
+	do {
+		/* Valid bit is 0 for 6 AHB clock cycles.
+		 * At 19.2MHz, 1 AHB clock is ~60ns.
+		 * We should enter this loop very, very rarely.
+		 */
+		ndelay(400);
 		ret = regmap_field_read(priv->rf[valid_idx], &valid);
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
+		if (ret || valid)
+			goto check_valid;
+	} while (time_before(jiffies, timeout));
+
+	return -ETIMEDOUT;
+
+check_valid:
+	/* Check ret of valid bit read */
+	if (ret)
+		return ret;
 
+get_temp:
 	/* Valid bit is set, OK to read the temperature */
 	*temp = tsens_hw_to_mC(s, temp_idx);
 
-- 
2.32.0

