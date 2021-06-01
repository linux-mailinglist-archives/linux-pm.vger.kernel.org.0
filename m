Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987EF396C11
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 06:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhFAEXE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Jun 2021 00:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbhFAEXD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jun 2021 00:23:03 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE62C061756;
        Mon, 31 May 2021 21:21:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f30so19727062lfj.1;
        Mon, 31 May 2021 21:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WcZrwLvNGthpdEMZsdsYJnWu6LlV6UEvtCLvpde2CIU=;
        b=mcB9i5jSHhqC/GtCYTTfHDPNJKJUIzWoJpEKe8UI2xLjhXPy4RrtrMOhmvX6OTrgnu
         G2s5zONt5zIepkBTLa1e+UnzBTiA/Zp/9xXmKNtwWojFOffUwDpouBwyuF8ELcKLYfwE
         lVixaK8Kah2k2ha8kSbovwwLgqEdA9py5IkE4gJg5sklfgDy6wRxQrKSytTysL0EJKy/
         cDLtqZy5JuajzTfWILLCVr1five9gkKL4087JDOyLw0Za/8AXHRBxxbmvgJpCzym3NI+
         CjY1jJM9IJ6BaFJZGiLVOzPeZNTXirSY91xO6zw8RvTmeGXm2bngOFWFR7gJD8vciQKB
         CYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WcZrwLvNGthpdEMZsdsYJnWu6LlV6UEvtCLvpde2CIU=;
        b=tzZYl+OZ+aNLIJhbzUCOrVVygJVl6P8YOdECeRD+KTwSfVRkmmXyN/6Fd6bwCocIG9
         xrbraFFnUtcjdKA947RSXW3bBuKITz7RVE210y37EHq7gzAanU5F7Dws/Cy7zyp4zoOj
         6AtMwwd08yblwp/lIqHPRd3NTApmJMIFLl1qKtGc8kpWcAsDYVUsK6Y9wgqSEaYHWSNU
         3yITnPtTeAJqvDWce26rDwO+Ge2llUIeepweZ6ipHvWWtF+ytovGQaYyIiVd7xzO5aSj
         KF5hfk5FhJp//+HC9H0Xa2+/uUuIS5yo75KD8Pnb3x0wSA8uswEyvzp7lkYpFRhhTW83
         s6Yg==
X-Gm-Message-State: AOAM532cGh+i7Wx/PFONe5uESByHTRQr4wQJlNJLMb/eCAHFUlqlfW/R
        GpNquWPNPQq0/Uj2qcWOPHg=
X-Google-Smtp-Source: ABdhPJy7zQ/jxMDe+PoPfXpzjCf7fFzoGCi8nggVzZpymadTblEykyA8LUavoIX4czVKAMtpqwRiVw==
X-Received: by 2002:a19:4c85:: with SMTP id z127mr17231923lfa.336.1622521279399;
        Mon, 31 May 2021 21:21:19 -0700 (PDT)
Received: from localhost.localdomain (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.gmail.com with ESMTPSA id d9sm931627lfv.47.2021.05.31.21.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 21:21:19 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v18 2/2] drm/tegra: dc: Extend debug stats with total number of events
Date:   Tue,  1 Jun 2021 07:21:08 +0300
Message-Id: <20210601042108.1942-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210601042108.1942-1-digetx@gmail.com>
References: <20210601042108.1942-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's useful to know the total number of underflow events and currently
the debug stats are getting reset each time CRTC is being disabled. Let's
account the overall number of events that doesn't get a reset.

Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 10 ++++++++++
 drivers/gpu/drm/tegra/dc.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 7dfe3250761f..173304f3467d 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1602,6 +1602,11 @@ static int tegra_dc_show_stats(struct seq_file *s, void *data)
 	seq_printf(s, "underflow: %lu\n", dc->stats.underflow);
 	seq_printf(s, "overflow: %lu\n", dc->stats.overflow);
 
+	seq_printf(s, "frames total: %lu\n", dc->stats.frames_total);
+	seq_printf(s, "vblank total: %lu\n", dc->stats.vblank_total);
+	seq_printf(s, "underflow total: %lu\n", dc->stats.underflow_total);
+	seq_printf(s, "overflow total: %lu\n", dc->stats.overflow_total);
+
 	return 0;
 }
 
@@ -2368,6 +2373,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): frame end\n", __func__);
 		*/
+		dc->stats.frames_total++;
 		dc->stats.frames++;
 	}
 
@@ -2376,6 +2382,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		dev_dbg(dc->dev, "%s(): vertical blank\n", __func__);
 		*/
 		drm_crtc_handle_vblank(&dc->base);
+		dc->stats.vblank_total++;
 		dc->stats.vblank++;
 	}
 
@@ -2383,6 +2390,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): underflow\n", __func__);
 		*/
+		dc->stats.underflow_total++;
 		dc->stats.underflow++;
 	}
 
@@ -2390,11 +2398,13 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
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
index 581263c7614a..dd171daace9e 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -46,6 +46,11 @@ struct tegra_dc_stats {
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
2.30.2

