Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9703B48896
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 18:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfFQQPa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 12:15:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46090 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbfFQQPZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 12:15:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id 81so5934454pfy.13;
        Mon, 17 Jun 2019 09:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k6eoJ9xcXnsJZd+Hemm7niOXBdFUm/UTEBKSRrxNhkU=;
        b=nOM2+Mr4/ZWdg9YLUFi1vUmPa+NnhrsZBduzKwbOTXEsdvw4j1+q85sN1qxqpfb4yM
         v3ZKRy8804fzS61vcXWFxLqSGuntUv8vh1ElSkoUAjDuRdiemi+PmBeyuUZidWJrGzby
         2fACc7vVKio97GA6w0Iufr/JR49rw79iObREJMDpASb+X1s5BgYlZPcGDMsfyjgMl+Cv
         /H1VBH72hz3M0KkC6RBsP+ihQD3DAP6/4GDibCoHZbXbmOJYZK90+7n9BCsX6+VlJJET
         xhbNkMY0XWbQdxgZiH79M7WmXwPrknfOsL54XRmaGasZ7KfUiFR0941QPACJNW3VRz2T
         2qfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k6eoJ9xcXnsJZd+Hemm7niOXBdFUm/UTEBKSRrxNhkU=;
        b=JxCBkgC7jfQE3XDV38hLJZUhZpe61+mX9vs/vkHDlH3OZq1fxzMNkljNM2KQLOvKuE
         TFREpDcxoDqutV7i7jTxjxL1YPjBTLx8eaxEFEKfvKgvD3DNxo0cL6R2HzB/pjqoWAHH
         6n7FqtlRgnDDpJIVjcwKDjat+Z3DUjBWlAH3jdQ59+xSdZFVTcgFLLG/j2fhjxUOkZei
         p3OUw1noW4iPjCT8r5lBRPZ66uR2GLDL9fknjqkZw0/NV8QSeMuLDo2nPAd/McJ0w3Hq
         mqkQl6Sw6eOlxoIccXfr26RQNBDrhbDHk/7Z1bUoUt4i3C1MZdFV8Ts2f3DVvGMc68ks
         nggA==
X-Gm-Message-State: APjAAAVW8UJI29NMgOppaFDKWrM2j3/9VCAqYwm86o1q1nsuDQeRjCIh
        XFE8/IDUsM1zXwN8epkdlBcT8+j9vIQ=
X-Google-Smtp-Source: APXvYqzWenjwHPZKTCUVtWeHTsrf7J75/gEJwqgz+joeNQO3l8GrHK1sc1q2Yx7Noe2d4V7UPCHljg==
X-Received: by 2002:a62:8643:: with SMTP id x64mr80128030pfd.7.1560788124067;
        Mon, 17 Jun 2019 09:15:24 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id c9sm14791953pfn.3.2019.06.17.09.15.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 09:15:23 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 12/12] thermal: qoriq: Add hwmon support
Date:   Mon, 17 Jun 2019 09:14:58 -0700
Message-Id: <20190617161458.3754-13-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190617161458.3754-1-andrew.smirnov@gmail.com>
References: <20190617161458.3754-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Expose thermal readings as a HWMON device, so that it could be
accessed using lm-sensors.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 2f8c5feb1a25..56f9927cf63c 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -12,6 +12,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
+#include "thermal_hwmon.h"
 
 #define SITES_MAX	16
 
@@ -115,6 +116,11 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 			regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
 			return ret;
 		}
+
+		if (devm_thermal_add_hwmon_sysfs(tzd))
+			dev_warn(dev,
+				 "Failed to add hwmon sysfs attributes\n");
+
 	}
 
 	return 0;
-- 
2.21.0

