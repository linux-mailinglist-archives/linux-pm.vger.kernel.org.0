Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EABA1F3B97
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgFINO5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729097AbgFINOq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:46 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4206EC08C5C3;
        Tue,  9 Jun 2020 06:14:46 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id x18so8496014lji.1;
        Tue, 09 Jun 2020 06:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=061hlrRfunwkyZki3oWiaKmN7ev2U21u3B6yt3cimTc=;
        b=axZSjAneUL42duObpUbjthqYAX09o70VhMiVjh8mLUewcbETS1bIjcyYywet8A7b1z
         shfyFgjs0qHecOJRZElkTka5Op0ww6i0Ro/YCmC5GwNWA37Iiw4Awd8ExzkwjMs/Ht6V
         J65nyAt9LZl3xQDeLvEs+u41oNK1R9JQkJpZEXQRCQ7rcakNP6pwk+SXDd6c/IFR/ujn
         +wk9B97Dwfr0UmQs2VuARV2mueB1bWmirTeZjxOZLJSQ2iVf6dWm5NSooVgtBNAAJiAz
         gAoPgEB24t/PNPO719An12piy22azY0O4+hgxKfbMLGC9AQazSLGQO8AANPw3W+2iNiW
         QG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=061hlrRfunwkyZki3oWiaKmN7ev2U21u3B6yt3cimTc=;
        b=EGtHYSHjUDvp10sPKdWlUJRcj2eJp2PEnj/7rsPou1S7MtLSwd3LWMZata9xgroNqS
         z0p+d2cEfcJLEhFwIs5JZhVdw2cYp150/othA/8jUHpQkMNtv0j1pl+1RwewA54BRRUb
         qfXzCZo2uusfF0dFIx1mvuUMICMfNQb2FS+BaIcUk+CCnyW/dFKCIr9ZAriTZt2BVHAn
         hTXUXn2s4Om5hzRlWUTdvKWuqn/RLCdJQUAVCXZFUZ/cwcnxhyG53jiOCXdWs7RwOlru
         gnUpiej6LwvZEvPngI0mHV0sXN+mtVkWbG6tdd4KK/j/50wAGVXdzu4s9WSPrHcBuKEF
         cntQ==
X-Gm-Message-State: AOAM533p4s9sjDzezZAm9hYB7hnoKxaonQbZ5q7+JWX60VIxvdNgJhir
        avCe3KkCMKeDED9DXC+TcCs=
X-Google-Smtp-Source: ABdhPJwmd7mQIA1zlol7FDcTPL+eVrsqyXZIVfZNkLkmHPGjO5Ho3fGM+DIMTGsL+TWXXlRInKK/VQ==
X-Received: by 2002:a2e:8809:: with SMTP id x9mr12288313ljh.442.1591708484744;
        Tue, 09 Jun 2020 06:14:44 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:44 -0700 (PDT)
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
Subject: [PATCH v4 16/37] PM / devfreq: tegra20: Adjust clocks conversion ratio and polling interval
Date:   Tue,  9 Jun 2020 16:13:43 +0300
Message-Id: <20200609131404.17523-17-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
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

