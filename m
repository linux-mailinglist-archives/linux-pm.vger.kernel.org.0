Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC84130320
	for <lists+linux-pm@lfdr.de>; Sat,  4 Jan 2020 16:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgADPWo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Jan 2020 10:22:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgADPWo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 4 Jan 2020 10:22:44 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D89D224670;
        Sat,  4 Jan 2020 15:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578151363;
        bh=/tnEtZ/TQAfcjo0cVjVkZvyHZiO0bR42EkUMFvapC2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uCjQ1su6dl11XuyF3/k0rBXB/c+9gCY1BmI2mHLizi5V4D9v0RMEnC3etCR/ylhu5
         fm4SxxKKoAqRMBCR9+Gkcpmd9ZqdoA+WjRVLfUqZOxye4OUINKx6ZIOLRA96wMzM9r
         E6YWHu43tywYMyUGyqR/e80eGb8X9kt3BEcdJxWU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 13/20] devfreq: exynos: Rename Exynos to lowercase
Date:   Sat,  4 Jan 2020 16:21:00 +0100
Message-Id: <20200104152107.11407-14-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200104152107.11407-1-krzk@kernel.org>
References: <20200104152107.11407-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix up inconsistent usage of upper and lowercase letters in "Exynos"
name.

"EXYNOS" is not an abbreviation but a regular trademarked name.
Therefore it should be written with lowercase letters starting with
capital letter.

The lowercase "Exynos" name is promoted by its manufacturer Samsung
Electronics Co., Ltd., in advertisement materials and on website.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/devfreq/Kconfig             | 2 +-
 drivers/devfreq/event/Kconfig       | 4 ++--
 drivers/devfreq/event/exynos-nocp.c | 2 +-
 drivers/devfreq/event/exynos-nocp.h | 2 +-
 drivers/devfreq/event/exynos-ppmu.c | 2 +-
 drivers/devfreq/event/exynos-ppmu.h | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 1526f758daeb..0b1df12e0f21 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -77,7 +77,7 @@ config DEVFREQ_GOV_PASSIVE
 comment "DEVFREQ Drivers"
 
 config ARM_EXYNOS_BUS_DEVFREQ
-	tristate "ARM EXYNOS Generic Memory Bus DEVFREQ Driver"
+	tristate "ARM Exynos Generic Memory Bus DEVFREQ Driver"
 	depends on ARCH_EXYNOS || COMPILE_TEST
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select DEVFREQ_GOV_PASSIVE
diff --git a/drivers/devfreq/event/Kconfig b/drivers/devfreq/event/Kconfig
index a53e0a6ffdfe..878825372f6f 100644
--- a/drivers/devfreq/event/Kconfig
+++ b/drivers/devfreq/event/Kconfig
@@ -15,7 +15,7 @@ menuconfig PM_DEVFREQ_EVENT
 if PM_DEVFREQ_EVENT
 
 config DEVFREQ_EVENT_EXYNOS_NOCP
-	tristate "EXYNOS NoC (Network On Chip) Probe DEVFREQ event Driver"
+	tristate "Exynos NoC (Network On Chip) Probe DEVFREQ event Driver"
 	depends on ARCH_EXYNOS || COMPILE_TEST
 	select PM_OPP
 	select REGMAP_MMIO
@@ -24,7 +24,7 @@ config DEVFREQ_EVENT_EXYNOS_NOCP
 	  (Network on Chip) Probe counters to measure the bandwidth of AXI bus.
 
 config DEVFREQ_EVENT_EXYNOS_PPMU
-	tristate "EXYNOS PPMU (Platform Performance Monitoring Unit) DEVFREQ event Driver"
+	tristate "Exynos PPMU (Platform Performance Monitoring Unit) DEVFREQ event Driver"
 	depends on ARCH_EXYNOS || COMPILE_TEST
 	select PM_OPP
 	help
diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
index 1c565926db9f..ccc531ee6938 100644
--- a/drivers/devfreq/event/exynos-nocp.c
+++ b/drivers/devfreq/event/exynos-nocp.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * exynos-nocp.c - EXYNOS NoC (Network On Chip) Probe support
+ * exynos-nocp.c - Exynos NoC (Network On Chip) Probe support
  *
  * Copyright (c) 2016 Samsung Electronics Co., Ltd.
  * Author : Chanwoo Choi <cw00.choi@samsung.com>
diff --git a/drivers/devfreq/event/exynos-nocp.h b/drivers/devfreq/event/exynos-nocp.h
index 55cc96284a36..2d6f08cfd0c5 100644
--- a/drivers/devfreq/event/exynos-nocp.h
+++ b/drivers/devfreq/event/exynos-nocp.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * exynos-nocp.h - EXYNOS NoC (Network on Chip) Probe header file
+ * exynos-nocp.h - Exynos NoC (Network on Chip) Probe header file
  *
  * Copyright (c) 2016 Samsung Electronics Co., Ltd.
  * Author : Chanwoo Choi <cw00.choi@samsung.com>
diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index 055deea42c37..17ed980d9099 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * exynos_ppmu.c - EXYNOS PPMU (Platform Performance Monitoring Unit) support
+ * exynos_ppmu.c - Exynos PPMU (Platform Performance Monitoring Unit) support
  *
  * Copyright (c) 2014-2015 Samsung Electronics Co., Ltd.
  * Author : Chanwoo Choi <cw00.choi@samsung.com>
diff --git a/drivers/devfreq/event/exynos-ppmu.h b/drivers/devfreq/event/exynos-ppmu.h
index 284420047455..97f667d0cbdd 100644
--- a/drivers/devfreq/event/exynos-ppmu.h
+++ b/drivers/devfreq/event/exynos-ppmu.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * exynos_ppmu.h - EXYNOS PPMU header file
+ * exynos_ppmu.h - Exynos PPMU header file
  *
  * Copyright (c) 2015 Samsung Electronics Co., Ltd.
  * Author : Chanwoo Choi <cw00.choi@samsung.com>
-- 
2.17.1

