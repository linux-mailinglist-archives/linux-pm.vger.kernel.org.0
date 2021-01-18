Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EA42F9732
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 02:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbhARBPd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 20:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730611AbhARBOh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 20:14:37 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2619C061575;
        Sun, 17 Jan 2021 17:13:56 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o17so21705198lfg.4;
        Sun, 17 Jan 2021 17:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nCuBXNhGojlrgJVxSay00xtDttizwyfPZHpVA3kvWHc=;
        b=oszOrekknXS9fkwgtul+5DMPuV0bcT2R17dEPyNlxmF5V8qqrCiR/PYZlrPH4FvAKv
         NQGq3zrIW/aFj5OzgxIzhYnIDLkneLKWXkyOxrChrYQxsb3W/VRXaWjVKyQr00nwF1HX
         Y7mJERYIIGCzZQ/OKIaYxA0Y51eq0yXy6Pqej5kmqjj28a/T+Fn4ylCwcwkEwdpU+KMT
         XVdRgswyw49QRSzkf+BsqjA6M8B6iK98k6J8z15HqJLGV9SyHx71FHn6X5o0AqO2zu62
         9D1s7gFO+bB4DkhKSQ0+ej5xehNOJ9FaSIstrVO1ldNXBj7ZLxFBOGNrYEfIGphZulFz
         iAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nCuBXNhGojlrgJVxSay00xtDttizwyfPZHpVA3kvWHc=;
        b=nff3WvxcXtohYgDWKt5+zIRE6Fic5eaA1hwx4vLoxxA92Va5M29IHeRz3UDNbnFpBS
         NNAxCP3WKa3+DUccXZXZPCHGhnd6aO+KDUWBPQmcnHbyt9imCCAuN+DyE4em8VQgjt64
         /27BtaZZHOcB6f4tafUgR5cnzyMDOwL7/QisyC18mBaFzZ3hsZnRiQRZtQJBtE/hh/4k
         6Ndcs9KrL/j4SmF6hIoVpbRmJ0+WV5C9gDNf4zo9bDELYoo+/AcMbGzdVPkyPhaMwLBS
         w+dXd56nTbFV95iwxxxfc8D28A1z/NxWytIE5ncIXZVVR+V3NG7QI5ykG8FyWbQhxFEB
         Sg+w==
X-Gm-Message-State: AOAM533gkRF9U7vIZnAPbseRfC7mdH45ihHQk1pmH5k0jDwhVu3MYGUM
        8oRyC78LLYDV9e7xTZQCP80=
X-Google-Smtp-Source: ABdhPJz0XMurcJmPJ3DTpkXeeGjl31IA9sGKlHz+e92BjWIqjVlBNPlNEO69/gxvaNhBszp3jKaAMg==
X-Received: by 2002:ac2:4a71:: with SMTP id q17mr9711227lfp.11.1610932435222;
        Sun, 17 Jan 2021 17:13:55 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id l84sm1710836lfd.75.2021.01.17.17.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 17:13:54 -0800 (PST)
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
Subject: [PATCH v3 2/3] PM: domains: Add "performance" column to debug summary
Date:   Mon, 18 Jan 2021 04:13:29 +0300
Message-Id: <20210118011330.4145-3-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118011330.4145-1-digetx@gmail.com>
References: <20210118011330.4145-1-digetx@gmail.com>
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
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/base/power/domain.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a3e1bfc233d4..2ab77aa516eb 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2951,7 +2951,15 @@ static void rtpm_status_str(struct seq_file *s, struct device *dev)
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
@@ -2979,7 +2987,7 @@ static int genpd_summary_one(struct seq_file *s,
 	else
 		snprintf(state, sizeof(state), "%s",
 			 status_lookup[genpd->status]);
-	seq_printf(s, "%-30s  %-15s ", genpd->name, state);
+	seq_printf(s, "%-30s  %-50s %u", genpd->name, state, genpd->performance_state);
 
 	/*
 	 * Modifications on the list require holding locks on both
@@ -2987,6 +2995,8 @@ static int genpd_summary_one(struct seq_file *s,
 	 * Also genpd->name is immutable.
 	 */
 	list_for_each_entry(link, &genpd->parent_links, parent_node) {
+		if (list_is_first(&link->parent_node, &genpd->parent_links))
+			seq_printf(s, "\n%48s", " ");
 		seq_printf(s, "%s", link->child->name);
 		if (!list_is_last(&link->parent_node, &genpd->parent_links))
 			seq_puts(s, ", ");
@@ -3001,6 +3011,7 @@ static int genpd_summary_one(struct seq_file *s,
 
 		seq_printf(s, "\n    %-50s  ", kobj_path);
 		rtpm_status_str(s, pm_data->dev);
+		perf_status_str(s, pm_data->dev);
 		kfree(kobj_path);
 	}
 
@@ -3016,9 +3027,9 @@ static int summary_show(struct seq_file *s, void *data)
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

