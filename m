Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06553559F9
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 23:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfFYVdu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 17:33:50 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:38587 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfFYVdt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 17:33:49 -0400
Received: by mail-yw1-f73.google.com with SMTP id p76so390298ywg.5
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 14:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=55ECQLYpQeuYJFjToVK2bkLCDXOJV5cNzofiMV5ttzw=;
        b=Spli0ntDMpZ6dRXQDnlLhHi0fVx1WJuQhhfvcZPaGNmfW7Y/kXel+iFyKdsv2i5jfn
         CFQ2CGGfAQ9miZBR4q346MAMIACb09Gafnlrr1Onm9mlLpE/MV5UmAor4wbEgj4CS205
         d/NmuMjGqTEkJwbO3TlKcTrFEf63tafgWWCWMrw/l5qzS6AvehlP0MmNi7JbgkGjBlwk
         s/kQ3B9QNKelCtt9BVx0DZ0UriXid+4I82Jz4XgbzE7qFgiAJCXVetqbRckxngxP+Qos
         QDfPN2FcKkTbrGon55ExRecGZsnBkbu8MrLHNkaeG2zSzf3Sj+o/h4bPNVM1DatH/rs2
         iKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=55ECQLYpQeuYJFjToVK2bkLCDXOJV5cNzofiMV5ttzw=;
        b=Dwz1ISJO4BxNYkzWzPeQDyJi7WLJQPR2SY2gDG4XXou+eBirYE5AWIpygIIYRK9MhU
         7NKLt/pNpRbf3PvT9CvoI7bTFPHgQogXIWC6PvOJTcwZnX3GdAWCFdpD78f3gbjJFF7K
         rYOoBMYcWNjisXc2nsrfoQkYTbVE2Fc+8H7vrYxInuPzYT8mU9UpScywR0V7vdmcmxgQ
         UnpXPRmBR/Fe39xXAbF9Iy5Y2Z6bQeVpI127j/ad3Ls2/7eO8Sgu3GT3mqP6BurbZ1R0
         J9E9JYWRFmuPwfXTJlX/m5giJQDG6HgkFFehzPvlsOmBbxKYKbfzNP8rGlJd2rRi36mr
         k9Eg==
X-Gm-Message-State: APjAAAX2PHmkpiQsihteKbUJvSNJhJHoLMDV2LWduL/ara5MyuYjqspW
        qwJV5uJ07VTI8jM6Sxuy1PI3xbUOEygDaI0=
X-Google-Smtp-Source: APXvYqw+f9I5AdpreQTdWIxzunUw0GN0xNNYn4xBkvVphAfkvd6FHaFlAPqfXXr6EO/T4PdMGZ8Qho/qiU/ovqk=
X-Received: by 2002:a81:7746:: with SMTP id s67mr563043ywc.257.1561498428384;
 Tue, 25 Jun 2019 14:33:48 -0700 (PDT)
Date:   Tue, 25 Jun 2019 14:33:35 -0700
In-Reply-To: <20190625213337.157525-1-saravanak@google.com>
Message-Id: <20190625213337.157525-3-saravanak@google.com>
Mime-Version: 1.0
References: <20190625213337.157525-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2 2/4] OPP: Add function to look up required OPP's for a
 given OPP
From:   Saravana Kannan <saravanak@google.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a function that allows looking up required OPPs given a source OPP
table, destination OPP table and the source OPP.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/opp/core.c     | 54 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 11 +++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 74c7bdc6f463..4f7870bffbf8 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1830,6 +1830,60 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
 		dev_err(virt_dev, "Failed to find required device entry\n");
 }
 
+/**
+ * dev_pm_opp_xlate_opp() - Find required OPP for src_table OPP.
+ * @src_table: OPP table which has dst_table as one of its required OPP table.
+ * @dst_table: Required OPP table of the src_table.
+ * @pstate: OPP of the src_table.
+ *
+ * This function returns the OPP (present in @dst_table) pointed out by the
+ * "required-opps" property of the OPP (present in @src_table).
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ *
+ * Return: destination table OPP on success, otherwise NULL on errors.
+ */
+struct dev_pm_opp *dev_pm_opp_xlate_opp(struct opp_table *src_table,
+					struct opp_table *dst_table,
+					struct dev_pm_opp *src_opp)
+{
+	struct dev_pm_opp *opp, *dest_opp = NULL;
+	int i;
+
+	if (!src_table || !dst_table || !src_opp)
+		return NULL;
+
+	for (i = 0; i < src_table->required_opp_count; i++) {
+		if (src_table->required_opp_tables[i]->np == dst_table->np)
+			break;
+	}
+
+	if (unlikely(i == src_table->required_opp_count)) {
+		pr_err("%s: Couldn't find matching OPP table (%p: %p)\n",
+		       __func__, src_table, dst_table);
+		return NULL;
+	}
+
+	mutex_lock(&src_table->lock);
+
+	list_for_each_entry(opp, &src_table->opp_list, node) {
+		if (opp == src_opp) {
+			dest_opp = opp->required_opps[i];
+			dev_pm_opp_get(dest_opp);
+			goto unlock;
+		}
+	}
+
+	pr_err("%s: Couldn't find matching OPP (%p: %p)\n", __func__, src_table,
+	       dst_table);
+
+unlock:
+	mutex_unlock(&src_table->lock);
+
+	return dest_opp;
+}
+
 /**
  * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
  * @src_table: OPP table which has dst_table as one of its required OPP table.
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index b150fe97ce5a..bc5c68bdfc8d 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -134,6 +134,9 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index);
 void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
+struct dev_pm_opp *dev_pm_opp_xlate_opp(struct opp_table *src_table,
+					struct opp_table *dst_table,
+					struct dev_pm_opp *src_opp);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
@@ -307,6 +310,14 @@ static inline int dev_pm_opp_xlate_performance_state(struct opp_table *src_table
 	return -ENOTSUPP;
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_xlate_opp(
+						struct opp_table *src_table,
+						struct opp_table *dst_table,
+						struct dev_pm_opp *src_opp)
+{
+	return NULL;
+}
+
 static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
 	return -ENOTSUPP;
-- 
2.22.0.410.gd8fdbe21b5-goog

