Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE021B3F4
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 12:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfEMKZs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 06:25:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37230 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfEMKZs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 06:25:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so6551319pgc.4
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2019 03:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cs4aUpEKLgkAcSCD22Xunu2gCyCIqjqZsKFA+jxsKFs=;
        b=E6ocS6ygS7TjcWC/tuQWZe961EteD5fozF5U2IzltzajiuzaGrAl/WYpQLDLnVnY+U
         RB57sfO59hNfQPNEtTKoyaPMQ09qdDd7et3LcQLqrsfxiJEnkoZh6bLriw+Fa429kfW+
         Bj2LA/6jXXR4vcXuvP7HK5cNpXmPm4sTz9lnyT39q06YBRzmyiAFjqIK9tPxC+3Ngumr
         ltBJxwtQkucUsL00OsYT4kOEARRYCA28M3W6BuTUAzJ7O+zvsH629DV5UAxqcRqBkx/X
         66eWmxQJG3DLaud5TjbhXlZkwfV+biYQtpaK6I98+8E4Lqculi7X4A48ziAVspAA6OEX
         2OSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cs4aUpEKLgkAcSCD22Xunu2gCyCIqjqZsKFA+jxsKFs=;
        b=lBMqh/K+Yzd96dhp3bofQBZNoBXQ8Cr8exKky1ykCkDbNLKoc2HdFph6oFwFXcilfZ
         gs6tz5xejdP+jiiJl8MgSTduiTtxgBOOfCe8uSsh3FCwiP2d9aZHmG1D8HOS2LszO5LQ
         MtDLKgaHTiVGIOr7G7+9wG7l9W1bqasmv+2BrGSoAM+Ab1Ap/XVVLmfxgJ8wIXyJs488
         LCGejldjbbTBoyECt7FnBZUCxytFumoTgdL+omw1zn4xHlN5uvxWQqHJ+CqUZl18I2sz
         VrhE19+DXvJsPD3a9DJBCJ5DpjXEFY1Sj0IQO3AHnnG5onenuAr+tfVXHejylWinplwt
         lB7Q==
X-Gm-Message-State: APjAAAWLhfT5CaA8XiJt3LiLk0yWOqBiYVDwP/i+IdZFS8S/rhLjq/pi
        ZkeSCI1T3okXGOg/gYLE5Ru2IA==
X-Google-Smtp-Source: APXvYqzbmJsX+4GZxq8SyAHW3ZX9wWVFmYis7J+0XfnuY/KUNMOwb4XKqykwaRAzLZpuya52PEcK2A==
X-Received: by 2002:a65:56c5:: with SMTP id w5mr30123588pgs.434.1557743147101;
        Mon, 13 May 2019 03:25:47 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id s5sm3927132pgj.60.2019.05.13.03.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 03:25:46 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, niklas.cassel@linaro.org,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] opp: Allocate genpd_virt_devs from dev_pm_opp_attach_genpd()
Date:   Mon, 13 May 2019 15:54:11 +0530
Message-Id: <9f22d5954319fc315bc98e347e69839931648ecc.1557742920.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <1bc9053f5c41a10832b58a2a81decbad7f1aded9.1557742920.git.viresh.kumar@linaro.org>
References: <1bc9053f5c41a10832b58a2a81decbad7f1aded9.1557742920.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the space for the array of virtual devices is allocated along
with the OPP table, but that isn't going to work well from now onwards.
For single power domain case, a driver can either use the original
device structure for setting the performance state (if genpd attached
with dev_pm_domain_attach()) or use the virtual device structure (if
genpd attached with dev_pm_domain_attach_by_name(), which returns the
virtual device) and so we can't know in advance if we are going to need
genpd_virt_devs array or not.

Lets delay the allocation a bit and do it along with
dev_pm_opp_attach_genpd() rather. The deallocation is done from
dev_pm_opp_detach_genpd().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 10 ++++++++++
 drivers/opp/of.c   | 30 ++----------------------------
 2 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 67d6b0caeab1..764e05a2fa66 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1755,6 +1755,9 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
 		dev_pm_domain_detach(opp_table->genpd_virt_devs[index], false);
 		opp_table->genpd_virt_devs[index] = NULL;
 	}
+
+	kfree(opp_table->genpd_virt_devs);
+	opp_table->genpd_virt_devs = NULL;
 }
 
 /**
@@ -1798,6 +1801,12 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names
 
 	mutex_lock(&opp_table->genpd_virt_dev_lock);
 
+	opp_table->genpd_virt_devs = kcalloc(opp_table->required_opp_count,
+					     sizeof(*opp_table->genpd_virt_devs),
+					     GFP_KERNEL);
+	if (!opp_table->genpd_virt_devs)
+		goto unlock;
+
 	while (*name) {
 		index = of_property_match_string(dev->of_node,
 						 "power-domain-names", *name);
@@ -1836,6 +1845,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names
 
 err:
 	_opp_detach_genpd(opp_table);
+unlock:
 	mutex_unlock(&opp_table->genpd_virt_dev_lock);
 
 put_table:
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index c10c782d15aa..a637f30552a3 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -141,7 +141,6 @@ static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
 static void _opp_table_free_required_tables(struct opp_table *opp_table)
 {
 	struct opp_table **required_opp_tables = opp_table->required_opp_tables;
-	struct device **genpd_virt_devs = opp_table->genpd_virt_devs;
 	int i;
 
 	if (!required_opp_tables)
@@ -155,10 +154,8 @@ static void _opp_table_free_required_tables(struct opp_table *opp_table)
 	}
 
 	kfree(required_opp_tables);
-	kfree(genpd_virt_devs);
 
 	opp_table->required_opp_count = 0;
-	opp_table->genpd_virt_devs = NULL;
 	opp_table->required_opp_tables = NULL;
 }
 
@@ -171,9 +168,8 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 					     struct device_node *opp_np)
 {
 	struct opp_table **required_opp_tables;
-	struct device **genpd_virt_devs = NULL;
 	struct device_node *required_np, *np;
-	int count, count_pd, i;
+	int count, i;
 
 	/* Traversing the first OPP node is all we need */
 	np = of_get_next_available_child(opp_np, NULL);
@@ -186,33 +182,11 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 	if (!count)
 		goto put_np;
 
-	/*
-	 * Check the number of power-domains to know if we need to deal
-	 * with virtual devices. In some cases we have devices with multiple
-	 * power domains but with only one of them being scalable, hence
-	 * 'count' could be 1, but we still have to deal with multiple genpds
-	 * and virtual devices.
-	 */
-	count_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
-					      "#power-domain-cells");
-	if (!count_pd)
-		goto put_np;
-
-	if (count_pd > 1) {
-		genpd_virt_devs = kcalloc(count, sizeof(*genpd_virt_devs),
-					GFP_KERNEL);
-		if (!genpd_virt_devs)
-			goto put_np;
-	}
-
 	required_opp_tables = kcalloc(count, sizeof(*required_opp_tables),
 				      GFP_KERNEL);
-	if (!required_opp_tables) {
-		kfree(genpd_virt_devs);
+	if (!required_opp_tables)
 		goto put_np;
-	}
 
-	opp_table->genpd_virt_devs = genpd_virt_devs;
 	opp_table->required_opp_tables = required_opp_tables;
 	opp_table->required_opp_count = count;
 
-- 
2.21.0.rc0.269.g1a574e7a288b

