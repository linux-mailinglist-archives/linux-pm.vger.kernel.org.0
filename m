Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CA71F0EB1
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 21:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgFGS7t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbgFGS5c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:32 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5A7C061A0E;
        Sun,  7 Jun 2020 11:57:32 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z9so17737181ljh.13;
        Sun, 07 Jun 2020 11:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=061hlrRfunwkyZki3oWiaKmN7ev2U21u3B6yt3cimTc=;
        b=OpeCLlYVr3IRPV2bWVGeZGoM/AcV5A0pdWEKydgN/1uX4UBx4HRNJyI65ktEmJN67Y
         U+upq4RGVxvRV1fPu3I4yvBa0omogL/IXYDm/kVNOeIJ9UnIrnMT/9RSfu2Qg+aP2BuS
         rL9JvCGvgrtRGYYnSQv28MPXPPFz4CIxrOl31hBUgVagyt3F59onvYlhKTeREiCBvLnG
         htgLq7n9SV+LgHR3+chUjMZVFCd+NzBJj9LYzKD21Cn60rNJzB9gItbsV+OMoFzIyr+B
         pomvyTmtSZfEqRu/1Kc2UW7k+MRV5pKHVum2Ch8QAjw68aGtVG1TMUxNb7byOwAuLf6W
         eiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=061hlrRfunwkyZki3oWiaKmN7ev2U21u3B6yt3cimTc=;
        b=FW9ZJ6Tu/GWrq3woU5KvLGxSckt3kaFvJ7U6tBF9GLiWuQQGETzxgBa1yYsuiIFOOD
         I2+17IinjtNiOi1IESkMsXNyZZCQ+l5OgcVpVSkRM16UZ0AeKQ4YVN6MlHiGTGGk7a14
         CFAXE+7FAtmTHB5LT9n5ERVbFcgvAy1bhZLZt9rf0O8t4ZJIlx4cm24S+bVaLsuB013L
         HMS+6N9P6LQ8h73NwjowjUIkHvJ9XUY0N6cuwVWQ/VFOvyju7s2zJFTLPjJSMktT6hz4
         VljmQoyVdyEXVwIZeKEhDmRl3zZpMd3m/Vq0Njpq3NrcyRktVY+74NB+42wVriPPlw8F
         WMLA==
X-Gm-Message-State: AOAM533dMyVyPdrmUENRZDf9wyo7Yb31kmt7YwfeSibt9QtInATsZbee
        ioQB9dmwjQ5KjuJn0P1zNCM=
X-Google-Smtp-Source: ABdhPJz7379nhczt27dgiUBvJO9L0ly/gGz6aROzdQPsGh2iExP9kIqzL5tstRWYuiTHNaiqba385Q==
X-Received: by 2002:a2e:9987:: with SMTP id w7mr8917913lji.215.1591556250974;
        Sun, 07 Jun 2020 11:57:30 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:30 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 16/39] PM / devfreq: tegra20: Adjust clocks conversion ratio and polling interval
Date:   Sun,  7 Jun 2020 21:55:07 +0300
Message-Id: <20200607185530.18113-17-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The current conversion ratio results in a higher frequency than needed,
that is not very actual now since the Display Controller driver got
support for memory bandwidth management and hence memory frequency can
go lower now without bad consequences. Since memory freq now goes to a
lower rates, the responsiveness of interactive applications become worse
due to a quite high polling interval value that is currently set to 500ms.
Changing polling interval to 30ms results in a good responsiveness of the
system.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra20-devfreq.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
index 249d0dc44f6c..7cdea4ba38f7 100644
--- a/drivers/devfreq/tegra20-devfreq.c
+++ b/drivers/devfreq/tegra20-devfreq.c
@@ -79,16 +79,12 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 
 	/*
 	 * EMC_COUNT returns number of memory events, that number is lower
-	 * than the number of clocks. Conversion ratio of 1/8 results in a
-	 * bit higher bandwidth than actually needed, it is good enough for
-	 * the time being because drivers don't support requesting minimum
-	 * needed memory bandwidth yet.
-	 *
-	 * TODO: adjust the ratio value once relevant drivers will support
-	 * memory bandwidth management.
+	 * than the number of total EMC clocks over the sampling period.
+	 * The clocks number is converted to maximum possible number of
+	 * memory events using the ratio of 1/4.
 	 */
 	stat->busy_time = readl_relaxed(tegra->regs + MC_STAT_EMC_COUNT);
-	stat->total_time = readl_relaxed(tegra->regs + MC_STAT_EMC_CLOCKS) / 8;
+	stat->total_time = readl_relaxed(tegra->regs + MC_STAT_EMC_CLOCKS) / 4;
 	stat->current_frequency = clk_get_rate(tegra->emc_clock);
 
 	writel_relaxed(EMC_GATHER_CLEAR, tegra->regs + MC_STAT_CONTROL);
@@ -98,7 +94,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 }
 
 static struct devfreq_dev_profile tegra_devfreq_profile = {
-	.polling_ms	= 500,
+	.polling_ms	= 30,
 	.target		= tegra_devfreq_target,
 	.get_dev_status	= tegra_devfreq_get_dev_status,
 };
-- 
2.26.0

