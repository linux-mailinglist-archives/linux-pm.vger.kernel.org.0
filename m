Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFA3A1D8F
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2019 16:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfH2OsN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Aug 2019 10:48:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44031 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfH2OsN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Aug 2019 10:48:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id q27so2727935lfo.10
        for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2019 07:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IDKt2aAXkJXSDAZlnyGOh55R8DuS2AbznpFvj37Ib1E=;
        b=DbPcEctP3Ry5pepk3axgMtKQCCNHSi2sXy55WR7ENYh5OPznWwkgs+CY913L6atlLm
         zoJvIjSWRSUtf6HBsx8PfS9sg2VVDspEkoMasKryurZxuSlZxO8k3b+uvw1dMCp9oV3D
         gu5IFVnff7uj5QNLDvIfOYfenZSuKXjYkEa2vbLpivgl+7YVjqhX2Ihg1P2ejZebwxr8
         TvnUMaOdWGbKIpGcUQZeiLgWO5X13nsIX9oXwSpQhLl7ClEu0T1I0RximGJxmXh9ug14
         JNnq25JG8n+bndS54REDJqXpykUUq1xIm4oLb6+IxvgrYXNpj33xAX792kNnOkeUkzF5
         /Jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IDKt2aAXkJXSDAZlnyGOh55R8DuS2AbznpFvj37Ib1E=;
        b=rv8Uj+V1KibVVvu1OvtX+/YlNgl92h4sAFOj430JPAe8uErvNPLvTJPdqvd19GbZwb
         NMQcLo2neh4dgnMQqjRpzOECZTYnY8NZHscu8vsP1ZU7Jyklf40juCB6EAt+DYoCy05g
         fk6FGlGxmZ7rAOYj1ivqZOe2HYAR8MLPTExOxrIBpfgmk16VJcNcS/E0sxZUAGs75Nv6
         0fj/oZoiclj0t2W1W7jmHqVT/t2ATv5TWu8FBxD9ZWkDZMbWzFks+3a4/jhMigIdGhm2
         4colMYZ5sfdj9rGcT6aXISiazGqLXXllw/LQOijEpDZ5ZCfVwI3GlhDN8d3NSQV3NTV2
         ohoQ==
X-Gm-Message-State: APjAAAXsf6K1u7uG2yBxTSMospVFVWLfFpPjI3lct53zz77dn7L4Mh3i
        3ujBxznVMJX7IJK7RuK8gh7M+A==
X-Google-Smtp-Source: APXvYqyDKTbeQuvUKaZCqmtX0m+IudlJBTlBE1KtR84ApMpOXrdkFn2EciiAqUntKe/GdxgUBK7+0w==
X-Received: by 2002:ac2:52b8:: with SMTP id r24mr1857926lfm.131.1567090091398;
        Thu, 29 Aug 2019 07:48:11 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id t16sm437836ljj.54.2019.08.29.07.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 07:48:10 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH 1/2] PM / Domains: Simplify genpd_lookup_dev()
Date:   Thu, 29 Aug 2019 16:48:05 +0200
Message-Id: <20190829144805.634-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

genpd_lookup_dev(), is a bit unnecessary heavy, as it walks the gpd_list to
try to find a valid PM domain corresponding to the device's attached genpd.

Instead of walking the gpd_list, let's use the fact that a genpd always has
the ->runtime_suspend() callback assigned to the genpd_runtime_suspend()
function.

While changing this, let's take the opportunity to also rename
genpd_lookup_dev(), into dev_to_genpd_safe() to better reflect its purpose.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index b063bc41b0a9..27592b73061d 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -149,29 +149,24 @@ static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
 	return ret;
 }
 
+static int genpd_runtime_suspend(struct device *dev);
+
 /*
  * Get the generic PM domain for a particular struct device.
  * This validates the struct device pointer, the PM domain pointer,
- * and checks that the PM domain pointer is a real generic PM domain.
+ * and checks that the PM domain pointer is real generic PM domain.
  * Any failure results in NULL being returned.
  */
-static struct generic_pm_domain *genpd_lookup_dev(struct device *dev)
+static struct generic_pm_domain *dev_to_genpd_safe(struct device *dev)
 {
-	struct generic_pm_domain *genpd = NULL, *gpd;
-
 	if (IS_ERR_OR_NULL(dev) || IS_ERR_OR_NULL(dev->pm_domain))
 		return NULL;
 
-	mutex_lock(&gpd_list_lock);
-	list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
-		if (&gpd->domain == dev->pm_domain) {
-			genpd = gpd;
-			break;
-		}
-	}
-	mutex_unlock(&gpd_list_lock);
+	/* A genpd's always have its ->runtime_suspend() callback assigned. */
+	if (dev->pm_domain->ops.runtime_suspend == genpd_runtime_suspend)
+		return pd_to_genpd(dev->pm_domain);
 
-	return genpd;
+	return NULL;
 }
 
 /*
@@ -1610,7 +1605,7 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
  */
 int pm_genpd_remove_device(struct device *dev)
 {
-	struct generic_pm_domain *genpd = genpd_lookup_dev(dev);
+	struct generic_pm_domain *genpd = dev_to_genpd_safe(dev);
 
 	if (!genpd)
 		return -EINVAL;
-- 
2.17.1

