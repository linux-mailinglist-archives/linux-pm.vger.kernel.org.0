Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096A83C4041
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 02:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhGLAGe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Jul 2021 20:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGLAGd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Jul 2021 20:06:33 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1F0C0613DD;
        Sun, 11 Jul 2021 17:03:45 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id g8so722136qtj.1;
        Sun, 11 Jul 2021 17:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zQP7uhtwMAP/xCI1kCq0LZ0EbLp5qp053nAfBZhyU9Y=;
        b=J4u3yhPAhAtjuvIRRn1TdzVGS/4ebB1nEVV1wnoiT0/p5/xt0yYKUs/SqmXM0uIhQv
         MIhD5CsBn1CJCLcWJzVtXdFGpoEFbyfDl7hedAb1/+Kx2WGk4O43hQLP79WvECNkOKGn
         tZPkJ7dg7g/4Po2318/d2YiJDmo1oWaTz5csk20EH5krDLDEt9Ndobx6dHpCfSjE5FRn
         sfw5gwRpa95g/0ci9cdnyS8tBtTJ7PamSkBujxGUtYXgY4VhMojwvckhW/KJE0LCLm70
         QQtmv0da8v48AWtT3iQNsGPaqzdsZqh8rO1DK8VN3IxcLTW8aOCc8wiNL+Ds4oOrumAy
         ekpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zQP7uhtwMAP/xCI1kCq0LZ0EbLp5qp053nAfBZhyU9Y=;
        b=pkOFxnm8gaUVnED4LqFuv0KLjItx1T46T6rCR9Ok2EF7pqluesROVnaFRcW0KL0B+g
         iO76MVTSFamDvGm04I1d0gYj5Rdp/3M6bTiOKmZV0yFpjeMKG3/AJ6IwWcMcqxxrFjus
         OaK1lbkWNpO9N6PZua0ZEDJ7bC8XqPnIumBuFxsGSXFedrt0rlZlGngtBaRrqd9qvRph
         EZWnK5FK+/OT9TfT7++JK6MqQD36SRQYYy+KH36hwkpdF+vea7UFRcEvzeOxd1OKxRSn
         FOz4mvuigrd5cu/oGcsTMMQ6wooQx2tu5tvhnm26/dBc1KhhRZ1aa7I24iXxNivdtVib
         Ijbg==
X-Gm-Message-State: AOAM533+On8k4cw9K6kF1HPj44m+QwzdHlJbo6/rdnqlyLRZ9y0MvHj1
        1Jq6hKBldIo3ZWpZ2DJ16HA=
X-Google-Smtp-Source: ABdhPJwgm5PsFTU1DDOS4lYwywnx0CNgatuabbGoOcLP+2pzN3vUwDmdM8dsaD2v6HOVGre+3sjGCA==
X-Received: by 2002:ac8:5e12:: with SMTP id h18mr45885460qtx.365.1626048224932;
        Sun, 11 Jul 2021 17:03:44 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id h10sm4970290qta.74.2021.07.11.17.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 17:03:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 1/5] soc/tegra: fuse: Add stubs needed for compile testing
Date:   Mon, 12 Jul 2021 03:03:18 +0300
Message-Id: <20210712000322.4224-2-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210712000322.4224-1-digetx@gmail.com>
References: <20210712000322.4224-1-digetx@gmail.com>
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

