Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3D936391C
	for <lists+linux-pm@lfdr.de>; Mon, 19 Apr 2021 03:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbhDSBaZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Apr 2021 21:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhDSBaZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Apr 2021 21:30:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC53C06174A;
        Sun, 18 Apr 2021 18:29:49 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id mh2so28801936ejb.8;
        Sun, 18 Apr 2021 18:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vWDsiHjf+/A9AetBxgcblwtERScRVbbT/XAQkG0jnaI=;
        b=BSqEGVrVWE5WRx2Qt4BNZyM9T157nDr2Hdsp+OwNLP3sqq+MaBjofQEsrXtyx+x6z7
         bV+nGR7JC5DK13zj0LJ5wL5U0mn5wzbL4YSqHUrAfKvz+5dZNxmFOgYY/myl3YEO0WD/
         CTTMCPzuzIY61RxtmdHAvrPdGgiG0w6mAfVJD0hjlLZMWUKxbbY4Hpl2BPWzXbhv3de6
         rJ1P8AjG8vWK+UhU4GGGqoIbkuhs9IOSexx0tNvDA5AClqlgfGX2fNCQFZeQU2I8hHUi
         QN/ZmcWIJTONUqwvi8EfBpgpSciQVxZXn8h8H2ycVoQEp6vzJS6AYm5xgwfADnBuhfZ/
         h7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vWDsiHjf+/A9AetBxgcblwtERScRVbbT/XAQkG0jnaI=;
        b=Y9lMaARIZgWuBeBhARG3mKYM2xvwyXBV4Na5/7whTT/JSXg1K6DWOME+b2M1S/VUUH
         cQ3lMz53vqDKCq7245kpcpc8hfrLqXRtW4Sj48b+CsxPRSpbegVNkZ6l1tBzCdGmc+ey
         caP7WFtJOsxztBZrJ9SZy3BCNDD4OTMl49lo1OWqT5l9gkb5kTSPPzAFYfpte8QhgTJo
         dGIvWm3idqedylHi3Y3yb+a82Ys6UQkBXaPG0MJcQw1Ztxa2PtEA5gqYg6OIZX9Y+NR/
         FFuQxobd+fpuNavMH/a82LZjVSLV3wj9rw8oYZucdQ0gcKOiNk/lEE28SgBwN4HKzcYn
         0qtA==
X-Gm-Message-State: AOAM5308gNJVweUOelvxm82+xD2msi2L1odwE0XrD7rWTc+yrd2jbQmx
        JciEQHCICgu3vOPupAbUhf48faufyD9F0w==
X-Google-Smtp-Source: ABdhPJz6pki9l6EsU/sEor1DgG33Aa+K5XaasHVCuV6bnDsHWcno0+evodKoHT3WQdImdh/wxzBWSA==
X-Received: by 2002:a17:906:3952:: with SMTP id g18mr19437001eje.104.1618795788617;
        Sun, 18 Apr 2021 18:29:48 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id mj3sm9083579ejb.3.2021.04.18.18.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 18:29:48 -0700 (PDT)
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
Subject: [thermal-next PATCH 1/2] thermal: qcom: tsens: init debugfs only with successful probe
Date:   Mon, 19 Apr 2021 03:29:29 +0200
Message-Id: <20210419012930.7727-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

calibrate and tsens_register can fail or PROBE_DEFER. This will cause a
double or a wrong init of the debugfs information. Init debugfs only
with successful probe fixing warning about directory already present.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 4c7ebd1d3..f9d50a67e 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -918,8 +918,6 @@ int __init init_common(struct tsens_priv *priv)
 	if (tsens_version(priv) >= VER_0_1)
 		tsens_enable_irq(priv);
 
-	tsens_debug_init(op);
-
 err_put_device:
 	put_device(&op->dev);
 	return ret;
@@ -1158,7 +1156,12 @@ static int tsens_probe(struct platform_device *pdev)
 		}
 	}
 
-	return tsens_register(priv);
+	ret = tsens_register(priv);
+
+	if (!ret)
+		tsens_debug_init(pdev);
+
+	return ret;
 }
 
 static int tsens_remove(struct platform_device *pdev)
-- 
2.30.2

