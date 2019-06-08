Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E51E39B25
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2019 06:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbfFHEo2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 8 Jun 2019 00:44:28 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:54342 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730823AbfFHEoI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Jun 2019 00:44:08 -0400
Received: by mail-qt1-f201.google.com with SMTP id r57so3664761qtj.21
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2019 21:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l7frD8AwQb/664vV6b+eE1fM0p32UKK11iOjCpsV3ZE=;
        b=rCSnOT9kVTQ4zHlkjz/xjtzstPLwTuZJEpaaMJS61bIu3uWnlOAh8wLABGTIsTwBFg
         xm7pMtTt0ypdAcPWZrlIfxGY0FfWBGVRMBwf3jrEwOWI1/JN/wTnSTlN5i1cd56sRXsm
         KAWvWRqDo9/WfmsLrTKeS95TdKlXcGsZ07leJWoYaQiQ/2BftBUQW1pxZhCPELKiQmuO
         2Fm7TvoK3DNvdkM7JRvRZ9dDxlFbZ47rMp3+MReBwsfI/rWbwYCOlkcPWCOuvJCY6fxw
         l+4DTin711JaMkrgqfd0/DsaXe1oWQsh5t0rFqsbtM52XkGYDnq8DSzsuiSHApUJK/KB
         C1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l7frD8AwQb/664vV6b+eE1fM0p32UKK11iOjCpsV3ZE=;
        b=qNEoHHs1Y8F9KID08y9ALD1k0us5vDdD7Hg6Yxizg44aIiilt3c+lFniCbf4TRXui7
         pSSzICW1rx/gLZ23b2Q3BAYrsld+mKn1bUf/6WgN3QhUVJFjVok+S8GI9vxvnT9PZ0NC
         ROaBzcbDchhlK0Znbwyd5ro2rAjnk9ZEPlYDdT6Rc1wqLhUiMmU9SBNRxY6wB3GzvPXT
         aSQvUfDs2pMPr0aoayADNPgtWJNHGqjUBOrjBWTEI/lHO8V22wFGPN0zWnRrgz5OLVFH
         XFScB/jlTyVDSmnqRw3KNMt1E5VQ6Oq24rQrvLNGpu2g343bI5vVFrsQHmHpXXX0vQz0
         nO4w==
X-Gm-Message-State: APjAAAWnkrmaI4tNuvpzatUj2Mbg0zjsLEVHKnBjnBRw9ZqimR/0X4Uo
        S08gZgk5Y1NNjdE+u7vwlQ3LahXA6ICiXvE=
X-Google-Smtp-Source: APXvYqwud8Aypv8gLILj91JHYUlSsreuVUJCq0h7diIstQL9qUtPn0pHHpuSFkdUqf0cnEy7NX6jcTlT8ggl5z8=
X-Received: by 2002:ac8:7c7:: with SMTP id m7mr45776276qth.28.1559969047755;
 Fri, 07 Jun 2019 21:44:07 -0700 (PDT)
Date:   Fri,  7 Jun 2019 21:43:37 -0700
In-Reply-To: <20190608044339.115026-1-saravanak@google.com>
Message-Id: <20190608044339.115026-8-saravanak@google.com>
Mime-Version: 1.0
References: <20190608044339.115026-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v1 7/9] OPP: Add function to look up required OPP's for a
 given OPP
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
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
 drivers/opp/core.c     | 50 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 11 ++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 89a2ece88480..d96d5746eb47 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1881,6 +1881,56 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
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
index 3f30ce55e8eb..13381dc3dd39 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -137,6 +137,9 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index);
 void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
+struct dev_pm_opp *dev_pm_opp_xlate_opp(struct opp_table *src_table,
+					struct opp_table *dst_table,
+					struct dev_pm_opp *src_opp);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
@@ -321,6 +324,14 @@ static inline int dev_pm_opp_xlate_performance_state(struct opp_table *src_table
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

