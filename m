Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EA3337AB6
	for <lists+linux-pm@lfdr.de>; Thu, 11 Mar 2021 18:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCKRYN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Mar 2021 12:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhCKRXw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Mar 2021 12:23:52 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCC9C061760;
        Thu, 11 Mar 2021 09:23:52 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id e7so41103982lft.2;
        Thu, 11 Mar 2021 09:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RHqyaVV9xNkvF/r79ZHMYRyngwcH1Np8oMRkBFJWWS4=;
        b=jOzvebEprjH+UNDtQ0eiaWAJpepmixIx4HivkVVMR8DVeATpb0aWVeaHhz3g81NF7J
         m07wO70GxtCYfBv9BhJ5YbjCgqmj3Kf1JgUYLLjm8Ox3DKLn3y1tFDSXKQvsJMD/iwab
         7ia08BpOn9HvG5UgJ25e5xryGGMBgxjuJwtaKP9Q8FRLhDWKwQJXvIRuDfB4cjDBlK7e
         m2YOj2ItToskDt3QLmK2rmM1jcFtOsFmk4MKGgDa2tgg+iBYufZk552MzllFaXINMkn0
         /WAS5i0Z9Xv96ZiW+i9uLVffX/pT2BTiwH9LiMSDRVIXdxBpQEZCoz9BLv/EaYqPCPzN
         7ivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RHqyaVV9xNkvF/r79ZHMYRyngwcH1Np8oMRkBFJWWS4=;
        b=U8jtD7t4ISMf+Uh3UolA9D3PAnVV9kQPpARYBy1oNhaoCD9oZNy2JuLYVjoT+rrL+9
         9pcER6416e2VOW4W52o24zOAU68MpaBSMMVc+kng45Xs7y1V1S898OmlyMQ3DjaCNqrm
         FmjKsCCVrMClU/0cXgEo3U8EfYdjKYrujxEP6iIZhVikEuFpCJC4sFctaoz2OMZzRxaE
         pQprSPKl7aNfmGQf40nyR4+AT1nM8WxKMsDgGpH0ajg24lmVaA4ng/wvv4GBc2tMrnx9
         UHTOdbI1iCGsoMkprYM+r+WXVCOcrgYtFYoROxe/1pxYFi/Wa5YSWEeH+a6AEhdjJVor
         vAdA==
X-Gm-Message-State: AOAM532IZz4NvQxd6JdmkCnZhXGUtvSedkTGD8UHvfy2VR98iY6NFydl
        d4UNXiggPPsiH+DOju/SnSo=
X-Google-Smtp-Source: ABdhPJztAQWmjq2zo62rB08ITil4t3jQrmqfbm1NE0Hhb0bt5ELzc1moRUFI8X2r17ZfHZjaQC25gA==
X-Received: by 2002:a19:d61a:: with SMTP id n26mr2774558lfg.383.1615483430986;
        Thu, 11 Mar 2021 09:23:50 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id p5sm1180088ljj.26.2021.03.11.09.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:23:50 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v15 2/2] drm/tegra: dc: Extend debug stats with total number of events
Date:   Thu, 11 Mar 2021 20:22:55 +0300
Message-Id: <20210311172255.25213-3-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210311172255.25213-1-digetx@gmail.com>
References: <20210311172255.25213-1-digetx@gmail.com>
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

