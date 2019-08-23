Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9E59AB7B
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 11:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbfHWJil (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 05:38:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33085 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732394AbfHWJil (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2019 05:38:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id p77so8908650wme.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2019 02:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kSm+naO1TQ4hxm8sdmnltc6wBBt1pT3kTvijAemrFOg=;
        b=CqaEWp9vXrcgx71U1LQb55TsRuPNoG8rmkrXQ8X5sHwFcnSxPwoCg9lXBaaH+0tw1k
         CMM5rb4PA5nwWraz+RDI8T+eL8eVbVFoz6ZJW9jJ1fhrKZN5/WGWyqN3KC+QUX6gdLw4
         5Faavj9nT61sdyvb/advtCjwLry7p0AWI7h2lKC1ikUL5qxJN5SelVmUoJObBqXaLYD+
         0hST1EHHus44eznVF5mxXoXJedZTIfIYEznEfpzXRbax+8iBBHZCm6KgsZYGYcKjjTCr
         uWH4Yv12Q/bOO3a7oVsdZNAdfKoU31sQ/u4jok0rFFoEdGIqejk6bmD495hdxFC9XnyV
         nWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kSm+naO1TQ4hxm8sdmnltc6wBBt1pT3kTvijAemrFOg=;
        b=pcb0pgcMxp6j8hfnaeJKz+D1bhnNXFpHXlfxUFIiE5NDc8wOV6Si3J5A163UPbrJV6
         Q7EYsk1X0zFeb4KFGRexJrW5ylNT5X8ULjToalHyAjq9k254c2SACRxPnWsMVFMIKz4S
         6cGoJs67mskwguKipcLLICV54ajrZLcdcfoR38fKkYKFNHy9XFzxOHNRfFaolUQEUqri
         j88S4pOwZduLflVtIa565w6RawSGTTL1Gz0LBW+CNjHkxmOQPaSDLHYj6sqpYcUzirFL
         llDBQH5jYvyF20QARiWQ7nQ/AFxLr/aLIfVIt/kIi7JE1nY4LZxcC2Y5TUqh+DFnINnA
         i51w==
X-Gm-Message-State: APjAAAXAEOTM4WwDKuUR5uuLCtiPsXeg+GZfi2x+fSY05ugNG/Ouuj2n
        SmK2jyUA/BeaXf9PfEsLmNaf5A==
X-Google-Smtp-Source: APXvYqymDWjlMLeQ5b0qVpVPvGSB5xjyytSxLX4F9srQBPXDtDIp8nuwsT3oqVKUnmUStQKJkvBckQ==
X-Received: by 2002:a1c:721a:: with SMTP id n26mr3984740wmc.88.1566553118783;
        Fri, 23 Aug 2019 02:38:38 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id s64sm2860089wmf.16.2019.08.23.02.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 02:38:37 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        edubezval@gmail.com
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] drivers: thermal: qcom: tsens: Fix memory leak from qfprom read
Date:   Fri, 23 Aug 2019 10:38:35 +0100
Message-Id: <20190823093835.32655-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

memory returned as part of nvmem_read via qfprom_read should be
freed by the consumer once done.
Existing code is not doing it so fix it.

Below memory leak detected by kmemleak
   [<ffffff80088b7658>] kmemleak_alloc+0x50/0x84
    [<ffffff80081df120>] __kmalloc+0xe8/0x168
    [<ffffff80086db350>] nvmem_cell_read+0x30/0x80
    [<ffffff8008632790>] qfprom_read+0x4c/0x7c
    [<ffffff80086335a4>] calibrate_v1+0x34/0x204
    [<ffffff8008632518>] tsens_probe+0x164/0x258
    [<ffffff80084e0a1c>] platform_drv_probe+0x80/0xa0
    [<ffffff80084de4f4>] really_probe+0x208/0x248
    [<ffffff80084de2c4>] driver_probe_device+0x98/0xc0
    [<ffffff80084dec54>] __device_attach_driver+0x9c/0xac
    [<ffffff80084dca74>] bus_for_each_drv+0x60/0x8c
    [<ffffff80084de634>] __device_attach+0x8c/0x100
    [<ffffff80084de6c8>] device_initial_probe+0x20/0x28
    [<ffffff80084dcbb8>] bus_probe_device+0x34/0x7c
    [<ffffff80084deb08>] deferred_probe_work_func+0x6c/0x98
    [<ffffff80080c3da8>] process_one_work+0x160/0x2f8

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/thermal/qcom/tsens-8960.c |  2 ++
 drivers/thermal/qcom/tsens-v0_1.c | 12 ++++++++++--
 drivers/thermal/qcom/tsens-v1.c   |  1 +
 drivers/thermal/qcom/tsens.h      |  1 +
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 8d9b721dadb6..e46a4e3f25c4 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -229,6 +229,8 @@ static int calibrate_8960(struct tsens_priv *priv)
 	for (i = 0; i < num_read; i++, s++)
 		s->offset = data[i];
 
+	kfree(data);
+
 	return 0;
 }
 
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 6f26fadf4c27..055647bcee67 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -145,8 +145,10 @@ static int calibrate_8916(struct tsens_priv *priv)
 		return PTR_ERR(qfprom_cdata);
 
 	qfprom_csel = (u32 *)qfprom_read(priv->dev, "calib_sel");
-	if (IS_ERR(qfprom_csel))
+	if (IS_ERR(qfprom_csel)) {
+		kfree(qfprom_cdata);
 		return PTR_ERR(qfprom_csel);
+	}
 
 	mode = (qfprom_csel[0] & MSM8916_CAL_SEL_MASK) >> MSM8916_CAL_SEL_SHIFT;
 	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
@@ -181,6 +183,8 @@ static int calibrate_8916(struct tsens_priv *priv)
 	}
 
 	compute_intercept_slope(priv, p1, p2, mode);
+	kfree(qfprom_cdata);
+	kfree(qfprom_csel);
 
 	return 0;
 }
@@ -198,8 +202,10 @@ static int calibrate_8974(struct tsens_priv *priv)
 		return PTR_ERR(calib);
 
 	bkp = (u32 *)qfprom_read(priv->dev, "calib_backup");
-	if (IS_ERR(bkp))
+	if (IS_ERR(bkp)) {
+		kfree(calib);
 		return PTR_ERR(bkp);
+	}
 
 	calib_redun_sel =  bkp[1] & BKP_REDUN_SEL;
 	calib_redun_sel >>= BKP_REDUN_SHIFT;
@@ -313,6 +319,8 @@ static int calibrate_8974(struct tsens_priv *priv)
 	}
 
 	compute_intercept_slope(priv, p1, p2, mode);
+	kfree(calib);
+	kfree(bkp);
 
 	return 0;
 }
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 10b595d4f619..870f502f2cb6 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -138,6 +138,7 @@ static int calibrate_v1(struct tsens_priv *priv)
 	}
 
 	compute_intercept_slope(priv, p1, p2, mode);
+	kfree(qfprom_cdata);
 
 	return 0;
 }
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 2fd94997245b..b89083b61c38 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -17,6 +17,7 @@
 
 #include <linux/thermal.h>
 #include <linux/regmap.h>
+#include <linux/slab.h>
 
 struct tsens_priv;
 
-- 
2.21.0

