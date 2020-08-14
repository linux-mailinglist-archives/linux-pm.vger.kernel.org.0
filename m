Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B33244252
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgHNAJX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgHNAHU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:20 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88013C061757;
        Thu, 13 Aug 2020 17:07:20 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v9so8114834ljk.6;
        Thu, 13 Aug 2020 17:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wfJYL8aXUf9lRrXprT0mqkyze705HA4O8j1DWQetbEI=;
        b=my3A4tKVBigkrRYLF1Krc4GOtlJzt0P2g/74fhD9KzbIrJF9Rg1/HqU0XunxgkRVXJ
         0FdyKYeH4eUOR4RPJYf3FiJcF7epo3GUGlRNEqvrbmMe9iqUMSIxNckhigAteTzaLd1I
         2Io7dwqd0cJI7yaz59glwIEHCaM8CGHDJPsjz0usOWF8ybTnxeYx5kBM6dE6Nyj6REzd
         J76Z6dFcRURlrNDn0wL97VmnHxgv+HGrJBgBlZE58Ok6kj2NH3svnBCl50rsFBI/pVvk
         TbPF//ryb3sRYuAXPlKp7Lm7zEEOAnpyzWsv0v8SutNb2hj0pcW6hm4PDcCC+HOJ5RP0
         6JIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wfJYL8aXUf9lRrXprT0mqkyze705HA4O8j1DWQetbEI=;
        b=m8BCiuD/DgWnCCr8b0uuAPSK6cj5inSW4jQzLuzh72G+eiP5Q4nBf+3xs3XHkTyIQE
         vuUl0lgCzIWeeaZzi2iYHutjYhTeyK8u3ReVCvAgJcQQpcWq3URR1gbkwLZNKiYv4laV
         VPgwsSAyaKXChXiej1xxfo6+RRI2qRB60Y2epIhe5Vq5tDPg1+JaGUHsTTVNCTPqyMLL
         EHRbiMlnq8Gwl1q0Zf1IgeiiF1hRQX1aQHlh67sFirOTECMBwvJ4ePDVkS5N+uxmzXJC
         P/+8q0R0sqEYg2v2sRHfc0cbDC8M0Nm1IYrUuw6TFPqI+fJ32znSQ2S5jq61U+i0NdLG
         /f+g==
X-Gm-Message-State: AOAM531l3Ju6JTrtjJ1ez2LcVvOZs3JDBvWTDxSIoZ1rrv3VATGNbaqK
        ntdLu+K81vNL77lU13GjKAs=
X-Google-Smtp-Source: ABdhPJxBvuBmhhAkFkBbI6TMp1X9JwSDrFst/K/Lm16UeyfuogFsx1dcqkjUA2IrQ44jEvFcr159wA==
X-Received: by 2002:a2e:a556:: with SMTP id e22mr88364ljn.317.1597363639026;
        Thu, 13 Aug 2020 17:07:19 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:18 -0700 (PDT)
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
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 16/36] PM / devfreq: tegra20: Adjust clocks conversion ratio and polling interval
Date:   Fri, 14 Aug 2020 03:06:01 +0300
Message-Id: <20200814000621.8415-17-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
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

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra20-devfreq.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
index bc43284996de..ebfc5ac9e5c3 100644
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
2.27.0

