Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8ACB96ED8
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 03:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfHUB1D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 21:27:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37741 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfHUB1C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 21:27:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so328088pgp.4;
        Tue, 20 Aug 2019 18:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k6eoJ9xcXnsJZd+Hemm7niOXBdFUm/UTEBKSRrxNhkU=;
        b=PFnh99i6yL6RcBYufaw1fwNBMagDPubteMhMHgLTo+phx8sm1SMGQkVhMhZ7epH8Jg
         o8hJOe7olG8Zu76+KHlBC+YFK3+f95U+hSqhW3cQ1YdzSqwtRh1Z/FzlyIQo3F4+nAQR
         4CHjqZoFxO4fWipbJIH47JWSLozOAn6oIvgmuV2gn3UQ4uT1ma9pakP+YjQDlnvQynn/
         0VFucxZFWLAaoKkKjmdBBHBze6dH86+/LRNHf6TwlCD+7DYUHvQvfpaZpemTt4ZphERe
         LxQcj0fAUPpGqFD9DafVya0xv7NQfBw4wIlhyJXt/VNKojYCMQg1/Bhz9qG5s/DR/td/
         wOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k6eoJ9xcXnsJZd+Hemm7niOXBdFUm/UTEBKSRrxNhkU=;
        b=D8+wEzNhK7wPsE9fvQSulNLrUSAXejMD4Q22VBaOZ6T9N/sa0pO+NfeLhH5XxsNfGh
         n7u5j84aVho0QJq8E5haUfa2uzi+VuIonnOCItQKC/+ZcBtJYIikvfouCZvQUCi9J0Nk
         DHSC7P/67VGdCSWidHPn0miD2tZqm3kitWm35Qi9jdHsW3ZjLlqG499DFy3cl/NdSZOn
         RII0fFTrYBbwpU77rsIir9YueLJrh7EgBdW6xM9oJlcsreO9Ksr76hdBI+mnj3L2ecIE
         NDg/GctJPL1FJDXo6itbdQ9ajMvnRXhYTk/HpdXgV6UBZwDifbS0SIYDa78ZontxARGl
         X4Mg==
X-Gm-Message-State: APjAAAXBG1Cwh1SVRK5jbdLO5HWd+YnAm3p5WnUrKWVAokPxaxma2vUk
        x6zsR3lhb0psDMdIjLCaaGPKrSyv4qI=
X-Google-Smtp-Source: APXvYqw6aFXkWrC804FuCGVNvsUNdg50jKTKGcyvz/QzQdRD9mgsITmuoFz3RmMCbWifehiMMLnPaw==
X-Received: by 2002:a17:90a:23d0:: with SMTP id g74mr2911990pje.115.1566350821065;
        Tue, 20 Aug 2019 18:27:01 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id bt18sm1162700pjb.1.2019.08.20.18.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 18:27:00 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v6 12/12] thermal: qoriq: Add hwmon support
Date:   Tue, 20 Aug 2019 18:26:12 -0700
Message-Id: <20190821012612.7823-13-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821012612.7823-1-andrew.smirnov@gmail.com>
References: <20190821012612.7823-1-andrew.smirnov@gmail.com>
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

