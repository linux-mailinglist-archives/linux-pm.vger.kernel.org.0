Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 912776C315
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 00:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfGQWX6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 18:23:58 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:32967 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729723AbfGQWX5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 18:23:57 -0400
Received: by mail-pg1-f201.google.com with SMTP id a21so8586661pgv.0
        for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2019 15:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7ut4pV8VU2XMvAiC0EUAug5uzDTyE8K6amY1HkNFP0k=;
        b=O70FLfpIET7sMGLffRwo9AG66vfmK6/bnvOuCCmJJljFc5byVD6IxQzah2oKNGO1MX
         If8mLMWT2xN01n97Sdv+4N2ZIz7/t4N6FFW+j1wRyw60Oj+yZ+T1Cf9laQ1gzrXFRGXf
         C8pcBSw2jxl8JJzTwshcULF8NjGFZkIGv8vzLSK9hNMDAKnMTn2gznqaCTtXyW6jp9k3
         MdlWdVJKOCGmzC5xaHBp3YNAcZYwy4cb8+AMd9Q2xdYl3DzhzEsav8qwDeoz1iXXTzKB
         GEOifcTdRKauqamU4ynDhamTF5T6eo7kCix4f6d4+md2JcKcFxZN7dwRIuIbPJ3uODZo
         MPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7ut4pV8VU2XMvAiC0EUAug5uzDTyE8K6amY1HkNFP0k=;
        b=Al2qfuI8m2d7/mFcrRGOmkwU6S0TAU9MrAMO5rffTGG9LUp1rz7fPw22J6uUcAthKx
         TO12voXSneeAGgRnUgvg0I5iXalaW9OdLxxJ61puDu4L/iI4N06YJmCYi/4/gQx8cqE3
         hRIckOlu2yukDYbWjgHOLJ6u6i+oVek7D1Y69fxJ0Vo3ExMdR2afcAoQVYhG6w4/BTBP
         UAwR9EA1ILj5kBZtgnnExsiyKGfR4vaukqbv9OlIjqDU/LGLtawP5J8dxUwkuav120eZ
         HS2Suo4w8b14yuiet6A6e/Uc4dsq2ZMJlL58oX/pHZRT8lfRJIFxY6e4NHE+/hZc5Gy+
         vU5g==
X-Gm-Message-State: APjAAAUN/qEGi8lqqDGTUv6Vft7osPCp+xhFQSzjCgBHdsNET6BVfFOp
        neV3FmQ+NKzWCJKlTc0nAktwGV1YPeePo94=
X-Google-Smtp-Source: APXvYqxpyhog97eYpe3tvuoeEK3ZGMJGr/4T2l9mqy6Eov3lFXO4Yz0bxpt58Gu+SD0h2HiGys1wFILZH+fiExc=
X-Received: by 2002:a63:d415:: with SMTP id a21mr42685588pgh.229.1563402236508;
 Wed, 17 Jul 2019 15:23:56 -0700 (PDT)
Date:   Wed, 17 Jul 2019 15:23:37 -0700
In-Reply-To: <20190717222340.137578-1-saravanak@google.com>
Message-Id: <20190717222340.137578-3-saravanak@google.com>
Mime-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v3 2/5] OPP: Add function to look up required OPP's for a
 given OPP
From:   Saravana Kannan <saravanak@google.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Sibi Sankar <sibis@codeaurora.org>, kernel-team@android.com,
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
index 438fcd134d93..72c055a3f6b7 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1883,6 +1883,60 @@ void dev_pm_opp_detach_genpd(struct opp_table *opp_table)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_detach_genpd);
 
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
index af5021f27cb7..36f52b9cf24a 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -131,6 +131,9 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names);
 void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
+struct dev_pm_opp *dev_pm_opp_xlate_opp(struct opp_table *src_table,
+					struct opp_table *dst_table,
+					struct dev_pm_opp *src_opp);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
@@ -304,6 +307,14 @@ static inline int dev_pm_opp_xlate_performance_state(struct opp_table *src_table
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
2.22.0.510.g264f2c817a-goog

