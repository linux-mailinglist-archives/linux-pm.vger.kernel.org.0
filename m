Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB1F408178
	for <lists+linux-pm@lfdr.de>; Sun, 12 Sep 2021 22:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbhILUai (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Sep 2021 16:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbhILUaf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Sep 2021 16:30:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B3EC061762;
        Sun, 12 Sep 2021 13:29:20 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d6so11341176wrc.11;
        Sun, 12 Sep 2021 13:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JTbm+Ivds98cb9V5q8q1C/zZH2NCdOMIxgLjAuUIi4Y=;
        b=QdWTkWXDkHr1OL1oUfrE+dECJvDZkBMO98M5MBCU2R8F6tt47tXHBM72yq7z85SzOs
         b8T/Lgz5zoU/tOWehQFeBfYsFU7xBSPFKMjO+dErY2llrYtII90K67dkk0qVCgqoL/XS
         KGUjU8e870h2J57SuTHzRDxat/KdQKvk/aFP7TnQclG2P+60qLgV6FRoZLa/k9wHCs8i
         TCXdOJWrxlpbr6i6KFKYJJxspQqmWeKgPA8kssvCRWoH+w/4jbOnaHh13mVXx0M8mk6t
         1UrD5h+oNXFl9CTzMXoclhEsy/1hUMmZ83918ADBhOFCt+gpH3yIG3R5iW4eRoQ+ebf/
         jTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JTbm+Ivds98cb9V5q8q1C/zZH2NCdOMIxgLjAuUIi4Y=;
        b=TgdFdWDHvqVdmxlk9GESheysw+LC+BIXXm9IQS/D/1LkL+v7uL+72VtkD7AGiGI18I
         qd4zeGsF490PtYZHptoCrLnZH+ZsTVDXwq7Pt9Q0apWc6iQmTK/2Z7Z2AVI/YsAMzcaA
         RlbqttehqdRpSsLzpdGw0fMCCLMBrxRM2/fEMemyVH7BLEEb7vqchIu7LogOjqqbDS85
         8KmEtZIO2nklPJYkPsm8lIQ0BJ4tNeH6wisNzfLSsZhpeofVBYHmHdNLRNc8ow22N1tl
         ixBIR+uMRd93ytkjjbbwPKylnozqsl54+gyB1vQvBJNaUVUc/Ph6vhsb7Fv+bXWU4EXZ
         g6RQ==
X-Gm-Message-State: AOAM5310hRXSpI28s5sCr8+jdlyPSA9IGK5U6cvXB9NTm+MklJGfHxui
        JJVwBKBVljdteiU0DRhXvGE=
X-Google-Smtp-Source: ABdhPJwx6tSscBJiPzgeceppiIUbf4P3AF4lYVjjAILZ4ZG14NRxwmFtq7F+tTtUa6kn6EIHen6JjQ==
X-Received: by 2002:a5d:67c8:: with SMTP id n8mr1616735wrw.122.1631478559016;
        Sun, 12 Sep 2021 13:29:19 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id k29sm4847466wms.24.2021.09.12.13.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:29:18 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/6] soc/tegra: irq: Add stubs needed for compile testing
Date:   Sun, 12 Sep 2021 23:29:03 +0300
Message-Id: <20210912202907.28471-3-digetx@gmail.com>
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
 include/soc/tegra/irq.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/soc/tegra/irq.h b/include/soc/tegra/irq.h
index 8eb11a7109e4..94539551c8c1 100644
--- a/include/soc/tegra/irq.h
+++ b/include/soc/tegra/irq.h
@@ -6,8 +6,15 @@
 #ifndef __SOC_TEGRA_IRQ_H
 #define __SOC_TEGRA_IRQ_H
 
-#if defined(CONFIG_ARM)
+#include <linux/types.h>
+
+#if defined(CONFIG_ARM) && defined(CONFIG_ARCH_TEGRA)
 bool tegra_pending_sgi(void);
+#else
+static inline bool tegra_pending_sgi(void)
+{
+	return false;
+}
 #endif
 
 #endif /* __SOC_TEGRA_IRQ_H */
-- 
2.32.0

