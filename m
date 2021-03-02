Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D67832B33B
	for <lists+linux-pm@lfdr.de>; Wed,  3 Mar 2021 04:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352497AbhCCDuS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 22:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572943AbhCBOIH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Mar 2021 09:08:07 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABBBC0611C0;
        Tue,  2 Mar 2021 04:45:16 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id h4so23555456ljl.0;
        Tue, 02 Mar 2021 04:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AsAU40DSj2V8WyiPA2FnCGE9liTgJLKy+L+ScTeuyXY=;
        b=PPIYu9Codq6bxO4eijFwZSN7sqEF6h57TWa30qKtAgsbaS4NOYln26tnSZmm5A06uQ
         HSlmfOCo200P2iltZ9IwZ3LVzotYpr96QK26ldWtZ1io+7hsCOxGGza2jnPCIW7gQhes
         E2qgUVYUSoZ9Xowjg+T/1rNu+7Ar7PGHkaY0TNLM9j0VPAO0OrQDDruTCl2ILmbeMcZF
         SgrOs9o/x/0fX6ImLbQCF8YBtoj3QVsoatFFqr9eVXXmfkKtG/s7zCrfJVLi6kVCRqxm
         AzhWl+4obu7lprBNtTsAlS4O3r0A2DkNlNIJrPl9HWM/qCcsqF2sx5bj8gT+vh91l8b4
         9Tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AsAU40DSj2V8WyiPA2FnCGE9liTgJLKy+L+ScTeuyXY=;
        b=dXz7N9YhMy7Lgari/MoAmOd5xtOzmeG3+6kkIUSElI8wWKaw6Vn4nL1Wk4BdkbOBV4
         vULchD2n8+O24pOGosAcANyjWLUjkYX83wDumlIjL8ChhFatJGawdUPispbc3TebAQZu
         UizNJMprJXHvCzECWalARuTshAQHmBdpCCBqNzvkmsAHt8CMqoDJqA+hx6NzRau+sHG+
         vm4e+rSPsqg3JzVSK7baOKKdi9lyb2lqeRmHEyL/mOF6igXcQMsCnUVkxeUXMZezWRpk
         2ckt3gLdDaUiMPVBbpR0z75N4tYJya+/Kl+BNZ6r37bXrgdY/l7ixZaoiK0HJCbVqDXE
         A8gg==
X-Gm-Message-State: AOAM531hB0IuZPLkAXw62hAsrmFEnv+2K41x0a0bkRjZbrzX4oijANDa
        N3l9UyPNBUmeAIYk+lhitaA=
X-Google-Smtp-Source: ABdhPJzhcU+vHPyphQdH9ezeBIdtlG/p4Ceab1j1WVSTIZLVrG5Q9r0fuGhUTYPcz3EHVcVEQbwfLg==
X-Received: by 2002:a2e:8e28:: with SMTP id r8mr12675196ljk.156.1614689115461;
        Tue, 02 Mar 2021 04:45:15 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id m16sm2634705lfh.109.2021.03.02.04.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 04:45:15 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v13 2/2] drm/tegra: dc: Extend debug stats with total number of events
Date:   Tue,  2 Mar 2021 15:44:45 +0300
Message-Id: <20210302124445.29444-3-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210302124445.29444-1-digetx@gmail.com>
References: <20210302124445.29444-1-digetx@gmail.com>
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
index 7c6079984906..1399e4032701 100644
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
 
@@ -2310,6 +2315,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): frame end\n", __func__);
 		*/
+		dc->stats.frames_total++;
 		dc->stats.frames++;
 	}
 
@@ -2318,6 +2324,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		dev_dbg(dc->dev, "%s(): vertical blank\n", __func__);
 		*/
 		drm_crtc_handle_vblank(&dc->base);
+		dc->stats.vblank_total++;
 		dc->stats.vblank++;
 	}
 
@@ -2325,6 +2332,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): underflow\n", __func__);
 		*/
+		dc->stats.underflow_total++;
 		dc->stats.underflow++;
 	}
 
@@ -2332,11 +2340,13 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
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
index 0d7bdf66a1ec..ba4ed35139fb 100644
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

