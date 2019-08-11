Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C77D8944A
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 23:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfHKVYk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 17:24:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35752 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfHKVYj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 17:24:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id p197so72932614lfa.2;
        Sun, 11 Aug 2019 14:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bdIejvgC5kaa3wn/Z/zklRDPf5qDMoTs2AWg86KAKyQ=;
        b=JsbeilFh064YudHZNhzW9vVIdbpx9qansY2Bq3s4vLP+pGg5hJyEf6KJCqLfRE3/Nk
         A4AdH1EgJvm1GbQ6wkpA/DXOZoQQSEHtEy01mJQSxYC6kwULizV8a7ZDkXdQ8VFPxU86
         3MXGgj2V2Bv+0ZpVZ5Vyp5P0xlvKqfuq+4czREsmdf6f/ZaCN/llezpAQ9GKRGgldcGj
         VaKV/lYIFDbkpBzocqzWm9joY8z+bO7Tx/1FIHkco8y8UmjqD/W8gVJwAU91B1UmyOyb
         U+jendFhxmgbKLYWzAMBnVgligEZvgfgLgKV0DBoAtpoLgVAhM8gavEuAOqs6GfD2kBD
         MiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bdIejvgC5kaa3wn/Z/zklRDPf5qDMoTs2AWg86KAKyQ=;
        b=MN5Bj4Ljn+Rw+jCH+rTvMvCGy9sSxaLzvmLMLY0U4n0Y/OCUfAB35wli75f70iwNR7
         Hl8gkuLNFtTPOLCJ4Q+MnNj7oRoqzB/dBOgavcPDERqfwlc+ypLtKdxORAeJUKYEQ+Q6
         795L7R0lY59UlgvjJ8Ua/YZd1BzmK0kMTlUZoCtryFqSeBYjDLB+3hIa3i+exrM/Qp9/
         2j4dOD16Ef6/Aeo4i3jg6A8i2tMa1RFsK9RY8ocxGwvBOCThpMaiSL1drV6GbiIhlMC+
         M90aMUPKz4q+GeftrgvHdNCmKHN4BLWL2GmorLKJj1tRgseP6XQWcPHbAzrQhi/gv7Fn
         GNZw==
X-Gm-Message-State: APjAAAVoz/ZR+P2XDoTkYdLvSfnwEwzFSp/D+YGsMdg5xKBJJxRMNCnO
        bjM0ERl82r9xNB//a5j3TXs=
X-Google-Smtp-Source: APXvYqws9Pr8A3WN64dmdxHD+coa1H/LB/wrGZOVjEKesT82UJlWeU3RKD9qOFnzg2VLBJADWphvGg==
X-Received: by 2002:ac2:546c:: with SMTP id e12mr9902736lfn.133.1565558677699;
        Sun, 11 Aug 2019 14:24:37 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id f1sm20470806ljk.86.2019.08.11.14.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:24:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/19] PM / devfreq: tegra30: Drop write-barrier
Date:   Mon, 12 Aug 2019 00:23:00 +0300
Message-Id: <20190811212315.12689-5-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811212315.12689-1-digetx@gmail.com>
References: <20190811212315.12689-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no need in a write-barrier now, given that interrupt masking is
handled by CPU's GIC now. Hence we know exactly that interrupt won't fire
after stopping the devfreq's governor. In other cases we don't care about
potential buffering of the writes to hardware and thus there is no need to
stall CPU.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index bfee9d43de1e..ee14bf534c0d 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -230,12 +230,6 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 		      ACTMON_DEV_LOWER_WMARK);
 }
 
-static void actmon_write_barrier(struct tegra_devfreq *tegra)
-{
-	/* ensure the update has reached the ACTMON */
-	readl(tegra->regs + ACTMON_GLB_STATUS);
-}
-
 static void actmon_isr_device(struct tegra_devfreq *tegra,
 			      struct tegra_devfreq_device *dev)
 {
@@ -287,8 +281,6 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
 
 	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
-
-	actmon_write_barrier(tegra);
 }
 
 static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
@@ -376,8 +368,6 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 		tegra_devfreq_update_wmark(tegra, dev);
 	}
 
-	actmon_write_barrier(tegra);
-
 	return NOTIFY_OK;
 }
 
@@ -423,8 +413,6 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
 		tegra_actmon_configure_device(tegra, &tegra->devices[i]);
 
-	actmon_write_barrier(tegra);
-
 	enable_irq(tegra->irq);
 }
 
@@ -439,8 +427,6 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 		device_writel(&tegra->devices[i], ACTMON_INTR_STATUS_CLEAR,
 			      ACTMON_DEV_INTR_STATUS);
 	}
-
-	actmon_write_barrier(tegra);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
-- 
2.22.0

