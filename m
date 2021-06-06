Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF8739D1EC
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 00:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhFFWdK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Jun 2021 18:33:10 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:40571 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhFFWdK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Jun 2021 18:33:10 -0400
Received: by mail-lf1-f50.google.com with SMTP id w33so22967488lfu.7;
        Sun, 06 Jun 2021 15:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zEnQnzK4FfYQ9Av8T/zWnWahbRfClGvzMlhIDU4oMMc=;
        b=uM98FGwfg7fGDX/p5gXsn+NM0kEbleS6lEDKE0hGEZPHWLh5FgACvW95Ss6B9hzapU
         ZZi8AipOZZo16r2koQMEsn6hqUYlj+S4dglLtLZNTb3ry85/HI/Y0MjcCGI8BSja+nIW
         vJwCcczMHVfAASxVhgDFbu+KwKnaqP7VHLu4G1+XgUV2GjuRw4h6Y8y1nfcjpkTuUZis
         UA5H4ath1e+N1i+Hl20NU/G7mkl5J1eBWMl634EiShklAXxClhDm+Mc7lrcB47pl144y
         6HUwJsRJ2N/SUexVE0NJ5RZhCCX08GUphqZ19CtEFD32Duy9OKGmR54HlhsNH7gV180q
         DAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zEnQnzK4FfYQ9Av8T/zWnWahbRfClGvzMlhIDU4oMMc=;
        b=FQ4iJdNu+6Krcga2KKdkdychkrxEirmVzHNG6arhsRyQyicp85ALwrRyDbw9ViP/RP
         0lkK9rOwlrRtgBBimJL0c7G3nXN0iGBtcPaMYiozJtJjMNF02r61QMt3KrM3ghVc7YNq
         fcHXOKzVvX7Ao3zAkS+mN+ijHs2Js8VUwwIyh3mDG+20FYgXGcqdmzu0uAUyvxbzp6WE
         6Vrq7w4NS+3835Ut+B2x7yFRuSFDWjucTdAr3Mz/lWsF8FCh5rHQ+Koq7j6KKz3ZTO+L
         N/eec7RX5sf8PBr7TFTx4OX1P3nJBMgcsyT/I+vO8EI8jc5P2xkhqcvVdIL1xfZHfOB2
         GPxA==
X-Gm-Message-State: AOAM530bGUiJ3MwVGWHpK+MaRUM+7XWIi7ctG8TcrQqsApWu7lUrvev/
        s6bqHMc9h6lRHw0VYFyGy/g=
X-Google-Smtp-Source: ABdhPJx6nVUgQD3itGieHN1c1h1YiRuxMGaSBkMrnzQAdJnuTAWi7j8eGbs7/c4KJcElfvgNoXXtIg==
X-Received: by 2002:ac2:4198:: with SMTP id z24mr9908979lfh.335.1623018602497;
        Sun, 06 Jun 2021 15:30:02 -0700 (PDT)
Received: from localhost.localdomain (94-29-51-134.dynamic.spd-mgts.ru. [94.29.51.134])
        by smtp.gmail.com with ESMTPSA id i23sm1017778ljg.38.2021.06.06.15.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 15:30:02 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 1/5] soc/tegra: fuse: Add stubs needed for compile testing
Date:   Mon,  7 Jun 2021 01:28:13 +0300
Message-Id: <20210606222817.12388-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210606222817.12388-1-digetx@gmail.com>
References: <20210606222817.12388-1-digetx@gmail.com>
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
2.30.2

