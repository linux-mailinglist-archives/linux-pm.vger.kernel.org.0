Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3A00EEF15
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 23:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389422AbfKDWTL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 17:19:11 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41491 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388974AbfKDWBM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 17:01:12 -0500
Received: by mail-lf1-f65.google.com with SMTP id j14so13448551lfb.8;
        Mon, 04 Nov 2019 14:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DjmXiphEj07PA2UBQ1Hu0F6jo40/2DwonMVrwbYxHC4=;
        b=hxiuORP6XfkMPL7hYETvI1R7UGZJg1RRsvu6RE+K+jruMTpnzXRtQGBL3yz97KYT/7
         vxDqVcdchqidjMkOMoL8IST46v2Y+LrfLbYWP3jL0FpynbbG9Uz1vD54M6l1mBF6rwdQ
         /xg02E/v+yYy0nKSqLBgLxz9IDsikOVwgcxTdNdKTZxr/VPXRmZga0T/AW68AlGK42c1
         VcmQJLL3S7YIU7bXLdQpHm+2r4plW7ARxwoASQZRTDOz31Uz6yyQtyq4OpLPMjX03ZDK
         hRhmel73Btv/f19/6e58WzD+J2hfiCuu8yWAG4OJNJpV9dyA7Iqfs+uCPtqTdM7Y0Ge8
         zaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DjmXiphEj07PA2UBQ1Hu0F6jo40/2DwonMVrwbYxHC4=;
        b=FdWQFdx7WqvuSn5zMrHFBWm88VrD+H7Lv8d+hAtALcjxVnA7100jXmRNwrZHfSCzJW
         z9G+aidz7ZnxprtUTq7silh3RRo54Uttt9ctkv8JwJydFJZ8HPhQphH0uEArqD0d++yG
         x9uv3r2qodCtUkHPYDDWeJeWZ3LV65FjKVqt+xt9sR34ZB/FYxBfqSqJ7w7/Q+LLZgkG
         HkZouSMcYLIUmLUw0tCzlYZYA3EFJGKOsvNjBPy0iA7+4u8PhXneISVyvTyeCYoPUTLH
         UuPnBBfpIA5YdNhqEtzII+ayqHf2/TRBlbBhRzoEV0mK6yYhuw/3eex8RULJhP+RWH34
         B0Rg==
X-Gm-Message-State: APjAAAVnL7oZ2uTnvlnbUewzQa1W7jUGN753tQeYEQXoLktqZp3pexLH
        NKqqzUTiGbhXLem4gpBeF6w=
X-Google-Smtp-Source: APXvYqwPUNwk60VBN+9D8hxM0iRLNxIuCjMxQD2kbfuS7YKAm4CWDBCRFT0IVamMwv0K0yvJXu/Sjg==
X-Received: by 2002:ac2:5b42:: with SMTP id i2mr18356665lfp.164.1572904870097;
        Mon, 04 Nov 2019 14:01:10 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id g3sm7454669ljj.59.2019.11.04.14.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:01:09 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 11/19] PM / devfreq: tegra30: Constify structs
Date:   Tue,  5 Nov 2019 00:56:09 +0300
Message-Id: <20191104215617.25544-12-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104215617.25544-1-digetx@gmail.com>
References: <20191104215617.25544-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Constify unmodifiable structs, for consistency.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index bc46af155b99..9bd4dd982927 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -108,7 +108,7 @@ enum tegra_actmon_device {
 	MCCPU,
 };
 
-static struct tegra_devfreq_device_config actmon_device_configs[] = {
+static const struct tegra_devfreq_device_config actmon_device_configs[] = {
 	{
 		/* MCALL: All memory accesses (including from the CPUs) */
 		.offset = 0x1c0,
@@ -177,7 +177,7 @@ struct tegra_actmon_emc_ratio {
 	unsigned long emc_freq;
 };
 
-static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
+static const struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
 	{ 1400000,    KHZ_MAX },
 	{ 1200000,    750000 },
 	{ 1100000,    600000 },
@@ -295,7 +295,7 @@ static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
 					    unsigned long cpu_freq)
 {
 	unsigned int i;
-	struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
+	const struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
 
 	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++, ratio++) {
 		if (cpu_freq >= ratio->cpu_freq) {
-- 
2.23.0

