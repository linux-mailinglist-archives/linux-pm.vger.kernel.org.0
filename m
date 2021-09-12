Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D9440817D
	for <lists+linux-pm@lfdr.de>; Sun, 12 Sep 2021 22:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbhILUar (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Sep 2021 16:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbhILUae (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Sep 2021 16:30:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946F4C061574;
        Sun, 12 Sep 2021 13:29:19 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d6so11341150wrc.11;
        Sun, 12 Sep 2021 13:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zQP7uhtwMAP/xCI1kCq0LZ0EbLp5qp053nAfBZhyU9Y=;
        b=IKAN2GUCQ6Mv9/F+gKmY0ucfBSeNT+//byyZ0qnBJUDUJ65wewSlJRWn7tLuQAoJQN
         9JOI3DjTJrje01FdNcni+7qr19VPe3VgcQKOnmwP4mpNmMmkOhzWAC/s1ZBdmKRzNXLx
         0ll8XxKBISVzElno+yHHnX+jOq9epJUdGl/BhhnxLyqq5gIklNotRSEfi8p4vecXTcRw
         4bvTkr5dNkwmTLOAhxFxQIb2g0bpX6p95psqF9WqoQWuMI8R2Z22Mn6ZWgLF9eMIhrux
         rSkUgWVG7BrGo+hHiFz7R624vfQpxZKIP5tvmWtYNbpigTQ/52YV+RJQPnm7Rt0sN0hL
         w3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zQP7uhtwMAP/xCI1kCq0LZ0EbLp5qp053nAfBZhyU9Y=;
        b=cds04iTwtSC2+Xz8tBAK4A+3ykRTYX6D9ckb+V1c290HRW8ZcCjHtSEImJ5KJTlYq7
         cjwLLMIcotEBTSNAW2qkaQsHKtAhHclCjsZjmoD3iLjR40JaQtRlrd/BAlak3GUtOSls
         EX2vwJ/fHB4sS574/YqHGQg3j/Qp6x5Lg3b5ajT+Bg0KrIRfcKg3QHmgFW17Ix9WAEYz
         HhwR+E12DK+CIC3SjOTb6XEWc2na/aHiu0yBs+zPfYWSqQ2g6tjRafR7DjcnFLoTKqda
         d3owG9MyhsmUOKCbytJqtaUh+0Ax6o1UEa1+PwkVsLrObqBDEZ5GP3rFJxHP1T8F1v4E
         cPfQ==
X-Gm-Message-State: AOAM533YAd70O3xfc48tBaK9OgW8bpVCwqBO1kkkco/qkqdLuDCu2nFp
        gYcFdzjukRKeetN4YTkXat0=
X-Google-Smtp-Source: ABdhPJybfeg9iibdbGDxMWZO+26ryO8/vNJBqwfU3phrQQs8rkpNaIpW7aPJzLJpwj1dl/L1lBaxCg==
X-Received: by 2002:a5d:6a8f:: with SMTP id s15mr4191081wru.15.1631478558194;
        Sun, 12 Sep 2021 13:29:18 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id k29sm4847466wms.24.2021.09.12.13.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:29:18 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/6] soc/tegra: fuse: Add stubs needed for compile testing
Date:   Sun, 12 Sep 2021 23:29:02 +0300
Message-Id: <20210912202907.28471-2-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210912202907.28471-1-digetx@gmail.com>
References: <20210912202907.28471-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add stubs needed for compile-testing of tegra-cpuidle driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/soc/tegra/fuse.h | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/soc/tegra/fuse.h b/include/soc/tegra/fuse.h
index 990701f788bc..67d2bc856fbc 100644
--- a/include/soc/tegra/fuse.h
+++ b/include/soc/tegra/fuse.h
@@ -6,6 +6,8 @@
 #ifndef __SOC_TEGRA_FUSE_H__
 #define __SOC_TEGRA_FUSE_H__
 
+#include <linux/types.h>
+
 #define TEGRA20		0x20
 #define TEGRA30		0x30
 #define TEGRA114	0x35
@@ -22,11 +24,6 @@
 
 #ifndef __ASSEMBLY__
 
-u32 tegra_read_chipid(void);
-u8 tegra_get_chip_id(void);
-u8 tegra_get_platform(void);
-bool tegra_is_silicon(void);
-
 enum tegra_revision {
 	TEGRA_REVISION_UNKNOWN = 0,
 	TEGRA_REVISION_A01,
@@ -57,6 +54,10 @@ extern struct tegra_sku_info tegra_sku_info;
 u32 tegra_read_straps(void);
 u32 tegra_read_ram_code(void);
 int tegra_fuse_readl(unsigned long offset, u32 *value);
+u32 tegra_read_chipid(void);
+u8 tegra_get_chip_id(void);
+u8 tegra_get_platform(void);
+bool tegra_is_silicon(void);
 #else
 static struct tegra_sku_info tegra_sku_info __maybe_unused;
 
@@ -74,6 +75,26 @@ static inline int tegra_fuse_readl(unsigned long offset, u32 *value)
 {
 	return -ENODEV;
 }
+
+static inline u32 tegra_read_chipid(void)
+{
+	return 0;
+}
+
+static inline u8 tegra_get_chip_id(void)
+{
+	return 0;
+}
+
+static inline u8 tegra_get_platform(void)
+{
+	return 0;
+}
+
+static inline bool tegra_is_silicon(void)
+{
+	return false;
+}
 #endif
 
 struct device *tegra_soc_device_register(void);
-- 
2.32.0

