Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F342F33F8A5
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 20:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhCQTAY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 15:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbhCQS7w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 14:59:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C838C06175F;
        Wed, 17 Mar 2021 11:59:52 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j11so538429lfg.12;
        Wed, 17 Mar 2021 11:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ipiAo/zFdoxmHMg8AWua2BzcAdGe0Ogzj6yRlLPPOUs=;
        b=MBV2/gBuCp22XDC4MSSlbszycii4D8No5J2A00NeO5JKUedUUhV4zpkLgBdEdas1a2
         YkdIFxAmIDKNTahutCnF5VTg5BImlyHK0pdqQ4Q0GXMOwGZpTr1UXcXrnHPf5DUs7AZX
         waXojytC63LEku8cZI6y27ZJocD21wl7xOHhB3YFmyvIutTw87datXAsn7TjQuIQzntv
         qqTbqLo2LIN8ouoyGwi2e8/+gyxSIIlFfJLJjqEiQPg7vSl6PaqM/xUbXm5GmRVrTQ2G
         eWBbVvaL2ndcmyvP+0u3T/psk25gughRt0zoW6qtCd5xjT8AStjrc5nIpEQDmkYInfuB
         1Kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ipiAo/zFdoxmHMg8AWua2BzcAdGe0Ogzj6yRlLPPOUs=;
        b=PXfckNZD4r3duVVzs0jUD+rkiQekVpBaqFg1vKbIJqnCJfzJmPG+qU91J+3NdwIj7W
         LYfKKinvdCcOU6e9MnyeLioR02zSPReZT5K0KmBCX+D5JT/ySbXy9lfWLNhBs1Kkp54w
         Ku5TRdqFHqa8j4x7imM524ygyLicyIYP26frv4gp1AckzJ5GzRQ6DAUdqC2E94zo/8Ww
         Du/Fdl12bUp/pNw+J56/xKEkmkEPKIi3mSH8Fk/X1QNsbXhjDgCc3AcJI1djPPMCXo4F
         Q4eRrQRtqlRQ7lhMF61m+tUGji3TUzFoBeb3xgY3adfsuqTfqKXbW8akNQauZsk0+Ej/
         Tfig==
X-Gm-Message-State: AOAM530wycLKgWyaFtZefIHtWWEUJI8QCJvKAyeNiiS2M3YsLQ3qmm24
        3DIWKnMGySiw729WOuWfzwo=
X-Google-Smtp-Source: ABdhPJxXALK2JGzXVYySDferkWlXhCtMFtiONzK9B5d8m/64YAwpuNTpNgtzX+4FRNigIGo7/QEhQA==
X-Received: by 2002:ac2:465c:: with SMTP id s28mr3108039lfo.135.1616007591063;
        Wed, 17 Mar 2021 11:59:51 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id b28sm3442482lfo.219.2021.03.17.11.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:59:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v16 2/2] drm/tegra: dc: Extend debug stats with total number of events
Date:   Wed, 17 Mar 2021 21:57:34 +0300
Message-Id: <20210317185734.14661-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317185734.14661-1-digetx@gmail.com>
References: <20210317185734.14661-1-digetx@gmail.com>
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
index 96e3a27dc98d..0ecf7027085d 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1551,6 +1551,11 @@ static int tegra_dc_show_stats(struct seq_file *s, void *data)
 	seq_printf(s, "underflow: %lu\n", dc->stats.underflow);
 	seq_printf(s, "overflow: %lu\n", dc->stats.overflow);
 
+	seq_printf(s, "frames total: %lu\n", dc->stats.frames_total);
+	seq_printf(s, "vblank total: %lu\n", dc->stats.vblank_total);
+	seq_printf(s, "underflow total: %lu\n", dc->stats.underflow_total);
+	seq_printf(s, "overflow total: %lu\n", dc->stats.overflow_total);
+
 	return 0;
 }
 
@@ -2325,6 +2330,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): frame end\n", __func__);
 		*/
+		dc->stats.frames_total++;
 		dc->stats.frames++;
 	}
 
@@ -2333,6 +2339,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		dev_dbg(dc->dev, "%s(): vertical blank\n", __func__);
 		*/
 		drm_crtc_handle_vblank(&dc->base);
+		dc->stats.vblank_total++;
 		dc->stats.vblank++;
 	}
 
@@ -2340,6 +2347,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): underflow\n", __func__);
 		*/
+		dc->stats.underflow_total++;
 		dc->stats.underflow++;
 	}
 
@@ -2347,11 +2355,13 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
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
2.30.2

