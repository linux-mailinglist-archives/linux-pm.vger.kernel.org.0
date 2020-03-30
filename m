Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5EE91971A9
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 03:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgC3BKA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 21:10:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35046 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgC3BJ6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 21:09:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id k21so16333361ljh.2;
        Sun, 29 Mar 2020 18:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vPqDxoQDIqKqbTClKBTFY/GuSR/u7mIa4tRLiNa4khw=;
        b=b2Wk9D3nd02S1yBEw9VfNDHynpLIG1M19fnbYk4/jKvJE6gnNPd6fx/N9rmAc3h1WJ
         0W4cIvLJs4zAoKqlmKnVdTm/7JOiI2jcLsTRUwkogWpygEHuBr7tnXXjJKfMFhu8jCzi
         YNL7hvXCo/KE3R0Er5Z7L0GQKBMAtnPchxE9PvlT2PvaEMODvg/pRIs15ZIS8BfaXRGD
         7qCFNCiqYt3gQNpoHKhM8w1hg292Gntwo2n6q4Cw4K3lczlaaHnH9gTmwB2oxgsIKVAj
         voa3vghwgz+YfoFB1PGPeHCDGheL2yfhAk0ebY3wbFhZODm3AdVX9swEnK1snhMnnzA5
         G39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vPqDxoQDIqKqbTClKBTFY/GuSR/u7mIa4tRLiNa4khw=;
        b=U+MSYHN1RurowozjbCw9o9b2SBdqN0fn65m5n44spwJt52qpDkZAnbnV/MAt34AStS
         c8uKasm4KnwU/CMyg9NrbgmDd0LUCEYC4RS388lCdSG1Stjri4xoF2fDtWxegnxc+fvM
         w4X0JUShJFzn1PoferHvg47NV3epqQTtA2rFcMIok+Aw5JxoMVA9B2dsrtfbtRwNiNWg
         Cvi0E6munGHW1GR7E+Yt/QMjNtQTu+NSYYw1WJf3rfnvpkoSYPcbEVDCwTjTXOvDa1jU
         7nHi/fsB+nzVhtZdicR8RjSFT4yp282Cijxw5ER/CdV80EaMoLRnWx8yEI4CZ3WhL2nY
         MGWg==
X-Gm-Message-State: AGi0PuZtC5s+NAzpJLlsccWBMM/sWQChDQhHErk7al2HW45cI/3OwOjF
        bBUwGk0K0u99ayTxT1ccHkQ=
X-Google-Smtp-Source: APiQypJKpYIkMoYh3zusIktDsInbffTBT2Ewun8AAXofUfmOfattVIpgibKPpUp/ustF4Zz22EcaHQ==
X-Received: by 2002:a2e:740e:: with SMTP id p14mr5716504ljc.290.1585530595270;
        Sun, 29 Mar 2020 18:09:55 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f23sm2449005lja.60.2020.03.29.18.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:09:54 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 20/22] drm/tegra: dc: Extend debug stats with total number of events
Date:   Mon, 30 Mar 2020 04:09:02 +0300
Message-Id: <20200330010904.27643-21-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330010904.27643-1-digetx@gmail.com>
References: <20200330010904.27643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's useful to know the total number of underflow events and currently
the debug stats are getting reset each time CRTC is being disabled. Let's
account the overall number of events that doesn't get reset.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 10 ++++++++++
 drivers/gpu/drm/tegra/dc.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 564af302a965..7112f80ff9e8 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1616,6 +1616,11 @@ static int tegra_dc_show_stats(struct seq_file *s, void *data)
 	seq_printf(s, "underflow: %lu\n", dc->stats.underflow);
 	seq_printf(s, "overflow: %lu\n", dc->stats.overflow);
 
+	seq_printf(s, "frames total: %lu\n", dc->stats.frames_total);
+	seq_printf(s, "vblank total: %lu\n", dc->stats.vblank_total);
+	seq_printf(s, "underflow total: %lu\n", dc->stats.underflow_total);
+	seq_printf(s, "overflow total: %lu\n", dc->stats.overflow_total);
+
 	return 0;
 }
 
@@ -2187,6 +2192,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): frame end\n", __func__);
 		*/
+		dc->stats.frames_total++;
 		dc->stats.frames++;
 	}
 
@@ -2195,6 +2201,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		dev_dbg(dc->dev, "%s(): vertical blank\n", __func__);
 		*/
 		drm_crtc_handle_vblank(&dc->base);
+		dc->stats.vblank_total++;
 		dc->stats.vblank++;
 	}
 
@@ -2202,6 +2209,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): underflow\n", __func__);
 		*/
+		dc->stats.underflow_total++;
 		dc->stats.underflow++;
 	}
 
@@ -2209,11 +2217,13 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
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
index 3a0ff57c5169..3eb4eddc2288 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -41,6 +41,11 @@ struct tegra_dc_stats {
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
2.25.1

