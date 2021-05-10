Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB873379AB9
	for <lists+linux-pm@lfdr.de>; Tue, 11 May 2021 01:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhEJX2m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 19:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhEJX2j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 19:28:39 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F31AC061574;
        Mon, 10 May 2021 16:27:33 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s25so22876116lji.0;
        Mon, 10 May 2021 16:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FD5e0kXld+e5Kxkx76LyrlwOIZee5a/sDEiwHf4/1Cw=;
        b=dbYAcfg7kHsDBxBhskmuu96pKg8wW5TxRWm0PZ1RG/E++Y886fZ+tCAq6cXp42xhGI
         nUK92vMCHAcFgim2BNt87Ga2Drm73oZU02BCNIeFwmUTfunS5id2r9W0rnb2BecVXjhS
         9D6RhicRQTZT0ihSBCwUtpp6smlGmHNBd6/Y4Gqi1UqH/m6Pe3xVRgz/pEB8TQ28ud08
         1vwyqvN+QUmIHfM7mwZJ6vBnWHLSAS0sXM0pYQwtjADwNdNn+b/xG8QYiwxlWeBxKpm/
         zEVOUOi6QSUIgn29Co8eEGbs5ZCFHz+83DCage/LM+a/cLNx0D2GCI1RRBM+LrIZpb4D
         PKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FD5e0kXld+e5Kxkx76LyrlwOIZee5a/sDEiwHf4/1Cw=;
        b=IhHNTf5ZO0RzGuJJe9g/NBcNn43o19zwsZ7NqtCIg9EOWCWuERWxZNY3z5OFzPklc/
         1Y+OkkUhCnKo4bpvwRn2o7PFFYlQiq2OAtPVhpQ5m3CRzdZtagO++x0CnypzvIhvyFh2
         IQGaWpkRbLt2W8XK5TqSsIncxLC9tYFy3PL7SBAPskg0VHCCBIGAqiUGoUqCV+ysd8bK
         4PpTk3o3J5p45VEp5lCz8DQEzxddwgCj7iMGfhcSiH2h58kEYA3CQTy1/bSu8mtuhNNY
         sWFDxUn4XX0Zl85dgfEqPl4qgjBplSlHFzyUX84cA/Ji3yl7ehXUrqJMwHNmTB/yZwfX
         657w==
X-Gm-Message-State: AOAM532vVUZljchUbZ7Mkn6ORBq9uQKRlcMqOVnyOufa+lyF8lErNtjz
        jxzSeZCo8QSs60WrxUgeCAA=
X-Google-Smtp-Source: ABdhPJx5tpD7a/eUU7UYVP1wFdoR6wqlq91pmlIgF59LZs8NLescfTs5AihD+eXvxElsIWa5rnbYdg==
X-Received: by 2002:a2e:8859:: with SMTP id z25mr1350342ljj.186.1620689252080;
        Mon, 10 May 2021 16:27:32 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.gmail.com with ESMTPSA id f29sm3354203ljo.69.2021.05.10.16.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 16:27:31 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v17 2/2] drm/tegra: dc: Extend debug stats with total number of events
Date:   Tue, 11 May 2021 02:27:09 +0300
Message-Id: <20210510232709.1349-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510232709.1349-1-digetx@gmail.com>
References: <20210510232709.1349-1-digetx@gmail.com>
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
index 9997e4942bf8..d87ef2550e26 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1596,6 +1596,11 @@ static int tegra_dc_show_stats(struct seq_file *s, void *data)
 	seq_printf(s, "underflow: %lu\n", dc->stats.underflow);
 	seq_printf(s, "overflow: %lu\n", dc->stats.overflow);
 
+	seq_printf(s, "frames total: %lu\n", dc->stats.frames_total);
+	seq_printf(s, "vblank total: %lu\n", dc->stats.vblank_total);
+	seq_printf(s, "underflow total: %lu\n", dc->stats.underflow_total);
+	seq_printf(s, "overflow total: %lu\n", dc->stats.overflow_total);
+
 	return 0;
 }
 
@@ -2370,6 +2375,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): frame end\n", __func__);
 		*/
+		dc->stats.frames_total++;
 		dc->stats.frames++;
 	}
 
@@ -2378,6 +2384,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		dev_dbg(dc->dev, "%s(): vertical blank\n", __func__);
 		*/
 		drm_crtc_handle_vblank(&dc->base);
+		dc->stats.vblank_total++;
 		dc->stats.vblank++;
 	}
 
@@ -2385,6 +2392,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): underflow\n", __func__);
 		*/
+		dc->stats.underflow_total++;
 		dc->stats.underflow++;
 	}
 
@@ -2392,11 +2400,13 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
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
index db10af097033..063bb777d607 100644
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
2.30.2

