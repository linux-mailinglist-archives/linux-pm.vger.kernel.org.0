Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEFEF45360
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 06:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfFNERp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 00:17:45 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:52862 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfFNERp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 00:17:45 -0400
Received: by mail-pf1-f202.google.com with SMTP id i123so831278pfb.19
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2019 21:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aquWBLmVdfTsfPmb1EWD0BsWvbkQBS182ArgyBvCIFk=;
        b=SALd+e5WH1k6h9KcX/9goKx7DKFiD/tzpEIBpi1VyWU7XvDu2xfmpkkCjFagLgLKso
         k1F40bZQT27d7k8eZ/rO9FhFjh+RR+wKxJlzQBp9VaLE8hPlY104nQTZUPgpBNn2mBPT
         ++1C4AFj9N2cFkqt3XQBxF6i5xX1XSSOJtAeBM2KoD1aCwZr+WpBiJTtGYSyIu8/SEA6
         Ev3DN/C/EBTdnmu7GB6Qeihyh1trdVho2bgPh4i+MQk6bPv0Y3nBGorTJMx2a7I+qcye
         +Q96sesGXGqkm4m66kbYNy19Ae8APrRe2uRpJPw13DLMOyKylYFGNOgNFe/yzbhVkTk9
         c4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aquWBLmVdfTsfPmb1EWD0BsWvbkQBS182ArgyBvCIFk=;
        b=BxhKIgNId7aemUccDOlPSf9+Iibzy4tJjY1exGKSoW5QJ9tA6dV6hVYG/pOIvla0U+
         lzCkjUezZ5N9mzeSDALeqZpRvI07xb5GhuWHMFDHCu8p+Q/3j5gcjbEQoSmjcgU/beDW
         Bgk6+WK2rfMsM+rJVwrK0ABV7uO8UvAFJoeo5Q8CY5os3w05V7Y35/9Vwnft0POe5WTt
         mP3szaW+xC6j4Aeiv9a7ze7/RZCJ7lXxquznNFRnvqnXIrBc0jrWawknzzlxjhulJHyn
         jX3sMTBWiriyA980pokkIoH5budC5XgnCWnG9pKzUxaqm8puMmhYGV5f9DZBGfwQcObb
         Jv2A==
X-Gm-Message-State: APjAAAVtToBzxFIDqNERNF2PnUyxQCQRp970iqJpsJhPZE3Dda6yoTh2
        1yrrYZ9DY20SXrlLXAzrc5t4iTnBlrCYDWg=
X-Google-Smtp-Source: APXvYqym9Smv41BgCCmiAxP4QJzXUTCJZc6yClVmbeev+9UXzl8/lbDcRgOPKtGKnbxQirgLhVl4xHH9dmQ7rSQ=
X-Received: by 2002:a63:de0e:: with SMTP id f14mr14823969pgg.348.1560485864345;
 Thu, 13 Jun 2019 21:17:44 -0700 (PDT)
Date:   Thu, 13 Jun 2019 21:17:24 -0700
In-Reply-To: <20190614041733.120807-1-saravanak@google.com>
Message-Id: <20190614041733.120807-3-saravanak@google.com>
Mime-Version: 1.0
References: <20190614041733.120807-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2 02/11] OPP: Add function to look up required OPP's for a
 given OPP
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        sibis@codeaurora.org, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
2.22.0.rc2.383.gf4fbbf30c2-goog

