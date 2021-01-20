Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A18D2FDCE8
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 00:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbhATVZ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 16:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbhATVYv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 16:24:51 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07248C0613CF;
        Wed, 20 Jan 2021 13:13:55 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id v67so36099853lfa.0;
        Wed, 20 Jan 2021 13:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KjwS82fYqqkv4xPlnla6S9j26In+4jWKlglRsnCKUho=;
        b=EmysAZqHCtHWslXxtghv190tfnK9KVVE01KhsXjEV21KwwZ8fvmvnbV9bozew3fksr
         BRNtH8BL0tIuVGNWzvn18YPp6GhXZQPjKPDIBlR9z4lFbOGIVRPBpHLsPmi4iH2Lmcx8
         Vrsu8jLBHyBFjRb/RVLnHv4BuCkAUoWzh/e7OvgK0PLxIzDkk/M5i+1dhViQhgiIIO0X
         StMTRS0PRA8BhHq7tpBdUeol5Mh7vwy1B9ZIwqeEus/O8Utjck6P5zXwCortKdkgfw63
         f8GiDBK6z8HREsMGmVCgjjSZSnVZZtNcWjRa+89kNE73kqa1+659eJ4hqYBQh2oMOmJy
         saHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KjwS82fYqqkv4xPlnla6S9j26In+4jWKlglRsnCKUho=;
        b=Y+MoB9Rm7SizMki9XnJqMz6rA4riQJOyYOePine0CI4SbWTp7CmMHHzdGoBAWarubt
         r0f7G2LN783jrTXgnQp8dZkI7Vx5e3VwgwzrTAaaIUqoxFQO5waKw3jKKThCYD15oWKD
         3gjBAfWmNC3S0IycUOe9SoEZuuwD3zWz6kVlfOKUrO2pmu6vLb/e9hX/GVdedczYAHgE
         swTj6CpIUly9LJDn2NDG19zKkDaK0ExrAxuakB/Udq/cttrpjKGkxwkRdp90rtVzIXeV
         mt7yOU/KMnsFNxlRUCGvmEL9t+jQGgAG036u8QlJCNufxRec6s3OJ8xmU9DbktR3sLSQ
         PoJA==
X-Gm-Message-State: AOAM532+pOePXRh/XaQBd8HquVMu8RHxYbZDZ5ktqS13XSciFk0QWNHL
        A8cSSDRIK+Yx6HFoE7b/xMo=
X-Google-Smtp-Source: ABdhPJzFbfdCzVoQJkISeG4Rz4RWsAmu98GhPnEYYfDeTQBLSEyPyyrlRWvyypuYoFYyWVC4Ekyfjw==
X-Received: by 2002:a05:6512:131b:: with SMTP id x27mr4615717lfu.593.1611177233593;
        Wed, 20 Jan 2021 13:13:53 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id 196sm298131lfj.219.2021.01.20.13.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 13:13:53 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 3/3] PM: domains: Add "performance" column to debug summary
Date:   Thu, 21 Jan 2021 00:12:32 +0300
Message-Id: <20210120211232.17299-4-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120211232.17299-1-digetx@gmail.com>
References: <20210120211232.17299-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add "performance" column to debug summary which shows performance state
of all power domains and theirs devices.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
[tested on NVIDIA Tegra20/30/124 SoCs]
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/base/power/domain.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 25b346bb2d97..40b72b1d8e8f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2955,7 +2955,15 @@ static void rtpm_status_str(struct seq_file *s, struct device *dev)
 	else
 		WARN_ON(1);
 
-	seq_puts(s, p);
+	seq_printf(s, "%-25s  ", p);
+}
+
+static void perf_status_str(struct seq_file *s, struct device *dev)
+{
+	struct generic_pm_domain_data *gpd_data;
+
+	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
+	seq_put_decimal_ull(s, "", gpd_data->performance_state);
 }
 
 static int genpd_summary_one(struct seq_file *s,
@@ -2983,7 +2991,7 @@ static int genpd_summary_one(struct seq_file *s,
 	else
 		snprintf(state, sizeof(state), "%s",
 			 status_lookup[genpd->status]);
-	seq_printf(s, "%-30s  %-15s ", genpd->name, state);
+	seq_printf(s, "%-30s  %-50s %u", genpd->name, state, genpd->performance_state);
 
 	/*
 	 * Modifications on the list require holding locks on both
@@ -2991,6 +2999,8 @@ static int genpd_summary_one(struct seq_file *s,
 	 * Also genpd->name is immutable.
 	 */
 	list_for_each_entry(link, &genpd->parent_links, parent_node) {
+		if (list_is_first(&link->parent_node, &genpd->parent_links))
+			seq_printf(s, "\n%48s", " ");
 		seq_printf(s, "%s", link->child->name);
 		if (!list_is_last(&link->parent_node, &genpd->parent_links))
 			seq_puts(s, ", ");
@@ -3005,6 +3015,7 @@ static int genpd_summary_one(struct seq_file *s,
 
 		seq_printf(s, "\n    %-50s  ", kobj_path);
 		rtpm_status_str(s, pm_data->dev);
+		perf_status_str(s, pm_data->dev);
 		kfree(kobj_path);
 	}
 
@@ -3020,9 +3031,9 @@ static int summary_show(struct seq_file *s, void *data)
 	struct generic_pm_domain *genpd;
 	int ret = 0;
 
-	seq_puts(s, "domain                          status          children\n");
+	seq_puts(s, "domain                          status          children                           performance\n");
 	seq_puts(s, "    /device                                             runtime status\n");
-	seq_puts(s, "----------------------------------------------------------------------\n");
+	seq_puts(s, "----------------------------------------------------------------------------------------------\n");
 
 	ret = mutex_lock_interruptible(&gpd_list_lock);
 	if (ret)
-- 
2.29.2

