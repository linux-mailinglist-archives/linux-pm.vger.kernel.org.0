Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8633C617F7
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 00:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfGGWgN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 18:36:13 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42228 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbfGGWfp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 18:35:45 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so9737148qkm.9;
        Sun, 07 Jul 2019 15:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w2SkU/kiQlK9KjmJW3W/jPsk8xR5ZQI/E8W0Q3/C+/Q=;
        b=tm/R7LVy2UWjQUmsKzQOkeAsefDhWe13WEriO+dhNltE0hsjZfwC0q0Cr/nnF3ze6N
         qTaWSLB9ox9xPuFwG+6QCtIvZpegDsRY2OkcFVm0I6xZ0zyJqum72oKjKeHfyo1OTKmW
         TzJ/CdspGqNJ/7ZiWxA1pZ3pFvfRw6F7TtWXQxSIlJ59f7zKDi+BSLFqXJ9/6n4NGHk3
         Tikhg14cwr0L53m1hbkWl+R/aidFH+XoNUVXYgXKLUbIYfIUkUNQ94Q86WfArKdQQMP8
         Br2u6oEpyIMmCJmicCn/oKPE9i9uBWqVSTLYzT+rq6TAsQOJi/UYVuxcNnosFgeyW7Ew
         20dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w2SkU/kiQlK9KjmJW3W/jPsk8xR5ZQI/E8W0Q3/C+/Q=;
        b=V03uWmPjNn/izwEw4lk9DGCCAGaqhYPX17hzPPfO+x9XPjGu0cfhUucKG3gkEIkF7U
         0GURZYzFXFag5mxHXwU+B775PKw6AZjIfNoZpZc8rsjr4e355SS4WN6q0G6/b5WHW1ed
         D1iQGlUzOuX+CoCl0+ssymoQnfpeSkgI5bnRz/c68GdgEfgzoocNgDr0kVaRq2AirbBv
         hU4yjJyP6Ap6yXCvodA22dF4UvD+OKH1j7ImdieXjN1I/P6EcDxruoEyDsw8oTqRyC1n
         uz/yoUjn0EIXneCFqMISUnVvsoLj+YnWVxAb1ai6VTGj+tG9BjEmT53OdJ6l9+5xTEQM
         lJmw==
X-Gm-Message-State: APjAAAU2ARCqTvYTNsn/7KGCMGdB6Jktomdy7A1yvD2Pz9PzDY0mFjY9
        3G1Tp6KyBJqyQPA7JkEt1f8=
X-Google-Smtp-Source: APXvYqxYNebNG6DjAMT41lHdG2cJwlHjljpvSPLiJDNrcCLKHLLeIB+yKckfxTYNJLQDdPs1wpg/lg==
X-Received: by 2002:ae9:ddc3:: with SMTP id r186mr11968892qkf.497.1562538944342;
        Sun, 07 Jul 2019 15:35:44 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p4sm6998453qkb.84.2019.07.07.15.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:35:43 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 19/24] PM / devfreq: tegra30: Optimize upper consecutive watermark selection
Date:   Mon,  8 Jul 2019 01:32:58 +0300
Message-Id: <20190707223303.6755-20-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707223303.6755-1-digetx@gmail.com>
References: <20190707223303.6755-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The memory activity counter may get a bit higher than a watermark which
is selected based on OPP that corresponds to a highest EMC rate, in this
case watermark is lower than the actual memory activity is and thus
results in unwanted "upper" interrupts.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 8d6bf6e9f1ae..c3cf87231d25 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -363,7 +363,18 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 	tegra_actmon_get_lower_upper(tegra, dev, freq - 1, &lower, &upper);
 
 	delta = do_percent(upper - lower, dev->config->boost_up_threshold);
-	device_writel(dev, lower + delta, ACTMON_DEV_UPPER_WMARK);
+
+	/*
+	 * The memory events count could go a bit higher than the maximum
+	 * defined by the OPPs, hence make the upper watermark infinitely
+	 * high to avoid unnecessary upper interrupts in that case.
+	 */
+	if (freq == tegra->max_freq)
+		upper = ULONG_MAX;
+	else
+		upper = lower + delta;
+
+	device_writel(dev, upper, ACTMON_DEV_UPPER_WMARK);
 
 	/*
 	 * Meanwhile the lower mark is based on the average value
-- 
2.22.0

