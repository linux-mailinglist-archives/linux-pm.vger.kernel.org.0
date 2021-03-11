Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C426337A6C
	for <lists+linux-pm@lfdr.de>; Thu, 11 Mar 2021 18:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCKRG3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Mar 2021 12:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhCKRGS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Mar 2021 12:06:18 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D84DC061574;
        Thu, 11 Mar 2021 09:06:18 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id q25so40932747lfc.8;
        Thu, 11 Mar 2021 09:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RHqyaVV9xNkvF/r79ZHMYRyngwcH1Np8oMRkBFJWWS4=;
        b=n0UNIFzJl7UvpSVi8okqSi+a0qw8Q426ONaQ6UgCg5oXVBJmpclx3raIAebYj2fLpb
         i5K5SM65TApPeTTWxMfmOtVa9ByKnIiod0Z3oHDV7sQE2dn00wcTxLFOwfv2DPHV8yRi
         P/EKvTYLNnSeqGvSc+2XjKw1KYKBVMwMWD4PLq4U7hkeURvSQUvimglvgG7bLJEJF5vC
         JxYXkbsD2ZtlX3Uevfv2syC9uMzZQIJ8nULU7RQzaz2XOZT1vmmpqer4FomgbdT/QmDb
         ReprJRvphmy60GYWtAf2Xf+pRonxJohKCU/GFPGMxHCz+X/1U6XamMlJ306+qWjkgs8c
         rxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RHqyaVV9xNkvF/r79ZHMYRyngwcH1Np8oMRkBFJWWS4=;
        b=km1M/f9gHzf/DOlHrl7OWNPAIRGXckSHyXfD1pBmk0TaExkGydydwXcD/9NCKHxXmz
         XMQy1VJ1DWkLHsMSP7JmjQCAwwBciRiRqkwCthmf4m44sVd+0zv+9BljjbzMGCqOzPgb
         lm7xnrg+M7HpeVGMfa8O9wSTEGNduC3bpQEeKjIR85Gs5lxqOiM2ZXO3xGsKZMu/aWLe
         HgAE8C/rR39r9y0GFvKayMv7iC2PtWb7SJETskEcIegTXsNhCFWFFzTWTLP7x9rOGuPw
         R6oHjAn6WBeJryC8n5rxcxMHbmuyOuJj2sHkkAqo92MgvtMr0L2UxuDWH/egVvQF8Rdf
         7a4Q==
X-Gm-Message-State: AOAM533vnYQRD/boOjV6VFH5hQ71qYfXsV20ywk74k/zBl+xNahuK0Gc
        YNOh9LB+e+9pgCHJ554eoI0=
X-Google-Smtp-Source: ABdhPJwp4zBM8qRRb3oSJtBT+UcNGKSJDJT5fRb/x0pjJ5KtFNZq3VhLvWYKp295CuBc74ao+oTU4A==
X-Received: by 2002:ac2:53a1:: with SMTP id j1mr2827639lfh.298.1615482376537;
        Thu, 11 Mar 2021 09:06:16 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id p5sm1166009ljj.26.2021.03.11.09.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:06:16 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v14 2/2] drm/tegra: dc: Extend debug stats with total number of events
Date:   Thu, 11 Mar 2021 20:06:06 +0300
Message-Id: <20210311170606.7543-3-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210311170606.7543-1-digetx@gmail.com>
References: <20210311170606.7543-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's useful to know the total number of underflow events and currently
the debug stats are getting reset each time CRTC is being disabled. Let's
account the overall number of events that doesn't get a reset.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 10 ++++++++++
 drivers/gpu/drm/tegra/dc.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 49fa488cf930..ecac28e814ec 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1539,6 +1539,11 @@ static int tegra_dc_show_stats(struct seq_file *s, void *data)
 	seq_printf(s, "underflow: %lu\n", dc->stats.underflow);
 	seq_printf(s, "overflow: %lu\n", dc->stats.overflow);
 
+	seq_printf(s, "frames total: %lu\n", dc->stats.frames_total);
+	seq_printf(s, "vblank total: %lu\n", dc->stats.vblank_total);
+	seq_printf(s, "underflow total: %lu\n", dc->stats.underflow_total);
+	seq_printf(s, "overflow total: %lu\n", dc->stats.overflow_total);
+
 	return 0;
 }
 
@@ -2313,6 +2318,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): frame end\n", __func__);
 		*/
+		dc->stats.frames_total++;
 		dc->stats.frames++;
 	}
 
@@ -2321,6 +2327,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		dev_dbg(dc->dev, "%s(): vertical blank\n", __func__);
 		*/
 		drm_crtc_handle_vblank(&dc->base);
+		dc->stats.vblank_total++;
 		dc->stats.vblank++;
 	}
 
@@ -2328,6 +2335,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): underflow\n", __func__);
 		*/
+		dc->stats.underflow_total++;
 		dc->stats.underflow++;
 	}
 
@@ -2335,11 +2343,13 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): overflow\n", __func__);
 		*/
+		dc->stats.overflow_total++;
 		dc->stats.overflow++;
 	}
 
 	if (status & HEAD_UF_INT) {
 		dev_dbg_ratelimited(dc->dev, "%s(): head underflow\n", __func__);
+		dc->stats.underflow_total++;
 		dc->stats.underflow++;
 	}
 
diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index 69d4cca2e58c..ad8d51a55a00 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -48,6 +48,11 @@ struct tegra_dc_stats {
 	unsigned long vblank;
 	unsigned long underflow;
 	unsigned long overflow;
+
+	unsigned long frames_total;
+	unsigned long vblank_total;
+	unsigned long underflow_total;
+	unsigned long overflow_total;
 };
 
 struct tegra_windowgroup_soc {
-- 
2.29.2

