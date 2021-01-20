Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7922FC747
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 02:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbhATB55 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 20:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731403AbhATBvi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 20:51:38 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E6C0613CF;
        Tue, 19 Jan 2021 17:50:58 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id u25so31962198lfc.2;
        Tue, 19 Jan 2021 17:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eVk09ZnJUY9uyXFwk3Cabs3mBMuvTnB4aH54dM1ywfI=;
        b=NU/5QDrTPrDL9iOXtRxbCKhZ0FlSpTRuEd9Rj27tlm3SqBobuVwxVGM+TnYTnqjX8S
         3q3LRFwqGUmZRmqekOj3X6pd7nmcDrdoHda8AIOUdFBzqiSn9W1Vri6D2OJHf9zZdfgv
         R5YZ1xMv6JukUEeH97thQNm0Sny4B9vFHX3Vq5rcUr2ayIySLAbOHrFCxV++S4e4tw8/
         ynkrCDUijBPHtw2Br9v2HspnP5gMs7QfNVKtNogY/64D9WFBspfN0gp/m8gW1H+djkLN
         gCo74bxX9QaWi1OzRmX3qAXxTwH7vFr5gmLKlEp5MgrWqPTwrVeM/rZcnqslcgEfYznA
         XgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eVk09ZnJUY9uyXFwk3Cabs3mBMuvTnB4aH54dM1ywfI=;
        b=dHw9Krcl+H6efGkjBZ9U3hFAELqB1IBWwal8j/rKhaO44aWGvHIgBIMwoP4chfs+LH
         pPdwJn4y8T2e3ImaWQzeUlBqGZAmDMIJfgXmXx9b7E00kmfvO8G8hTBb2wSBXa+Fe8X/
         924aHHXuZS2vMCJCSdHaqAaBq41Uhd68hsqfj14Amuq3Zp0SSYhTTnEWJR1RYOj17FDO
         KDqSKG3SSA9uJRl/bgqhKzwnFqKxNF+FMCblToyJsoAwnaqHPzxqLJEYsqn8SzZfwiCj
         16Fjz0pO55u/a9D4UcDDRISa0Pwm+2kkv5qjYLQ4G7HCqd6HJ3qxSJ4mlsPQ4vsHdxTW
         r0Fw==
X-Gm-Message-State: AOAM5337UOcS0OsyxR6edrQnxwvwzmmnl1BYzIqGuLMyZeBAGcSuwLrg
        1lL0rdFmmikRKIGY8lT7+sE=
X-Google-Smtp-Source: ABdhPJw9acL+4MepXSq7I3wrfiQGll5RJ1/qcNzm6o5UaSDFbUux75tKwmQwQYZP5ff3qyM5aHUeWA==
X-Received: by 2002:a19:3f94:: with SMTP id m142mr3099705lfa.196.1611107456801;
        Tue, 19 Jan 2021 17:50:56 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id o14sm56163lfi.92.2021.01.19.17.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 17:50:56 -0800 (PST)
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
Subject: [PATCH v4 3/3] PM: domains: Add "performance" column to debug summary
Date:   Wed, 20 Jan 2021 04:50:10 +0300
Message-Id: <20210120015010.14191-4-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120015010.14191-1-digetx@gmail.com>
References: <20210120015010.14191-1-digetx@gmail.com>
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
index def1299ad085..7c831b00f2ee 100644
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

