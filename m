Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD9AA855DB
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 00:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389553AbfHGWb0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 18:31:26 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:34178 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389544AbfHGWb0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 18:31:26 -0400
Received: by mail-pf1-f202.google.com with SMTP id i2so57675123pfe.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Aug 2019 15:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DWjpwGhlXJQyl9FQAlOupUp/l9PizFz1wErEWTwJlag=;
        b=hcqK1rm2Kc81+PcpjarLbrP8P4J7ecqPay/pLa2ERjLIRU6yaHy83GRzwH5twgmz77
         p6ZlJr/qRukqde30IsHj5KuzdQD1+nQbX6inahTdo+X9XUkKQKQAxeRMNTPIh4uf+PKe
         qGbHD86j7Qx3tpSx8Z/YKJ18+uSJXxnSMqkRxH41MDNar18DnUwL7cKQ6ANn7wa/rwPj
         c0l7uSoYS6zqTeEr/4qNtDEOtZX1eVO/p6LpbU9jkd+99x2d5iwz4Uwj9RJWdBNSZ/LU
         0a4XqqsHxy0B4SUTTVPu/R3tdbcI+WpwFbgGAskVzLsXhIYf2naq9yFuR5HNsF4448om
         Z37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DWjpwGhlXJQyl9FQAlOupUp/l9PizFz1wErEWTwJlag=;
        b=LEwDhyEdUD/TIa90rEWdRC7pU84nLt2c8R7KkkcjabKkCuBMs9KVM2pRrMQLVVTbct
         TQwABjksZAgxrKJQ8VU0RbWJ6Tj3rA/uQi/OFQKUXMc/RYRzq+HICW3wu3d5spGolyuW
         ieEA0FypQRU5RDDzGdlcC2uddymjdEoGKjTqMnaolMNoxS7WitpCmFjz+yiwAMOnicDr
         cW7d/4sQb2oSdZYdevj1k+pzBH3h623eDusccL+QmxvG0n47jomO1VcwQMoEV7E2feiB
         PY3T79j8omzeF2GF6et4Xp8zEbbjD7WNaBHMVUXyiZlhnjYmK7fQ3XcUZhwuf0jzHJlp
         lQKQ==
X-Gm-Message-State: APjAAAW2yAAmj48pd8C0/go8uF6vU/lAMKGO1tRlOQPe9rVGvHSw47TB
        +M3zlTv5n19RdwAcbyhVKyqgKMWMnhbfjws=
X-Google-Smtp-Source: APXvYqy/1aDhWc3+HFfJ/c7HXcYAOyJ1I9KCDVFdyCtC5/D4WfVyr1uqw90aRy9Chmq3OSW6+nY2hoQfBFxyOEw=
X-Received: by 2002:a63:b102:: with SMTP id r2mr9553166pgf.370.1565217084491;
 Wed, 07 Aug 2019 15:31:24 -0700 (PDT)
Date:   Wed,  7 Aug 2019 15:31:11 -0700
In-Reply-To: <20190807223111.230846-1-saravanak@google.com>
Message-Id: <20190807223111.230846-4-saravanak@google.com>
Mime-Version: 1.0
References: <20190807223111.230846-1-saravanak@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v5 3/3] OPP: Add helper function for bandwidth OPP tables
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The frequency OPP tables have helper functions to search for entries in the
table based on frequency and get the frequency values for a given (or
suspend) OPP entry.

Add similar helper functions for bandwidth OPP tables to search for entries
in the table based on peak bandwidth and to get the peak and average
bandwidth for a given (or suspend) OPP entry.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/opp/core.c     | 51 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 19 ++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 3b7ffd0234e9..22dcf22f908f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -127,6 +127,29 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
 
+/**
+ * dev_pm_opp_get_bw() - Gets the bandwidth corresponding to an available opp
+ * @opp:	opp for which frequency has to be returned for
+ * @avg_bw:	Pointer where the corresponding average bandwidth is stored.
+ *		Can be NULL.
+ *
+ * Return: Peak bandwidth in kBps corresponding to the opp, else
+ * return 0
+ */
+unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp, unsigned long *avg_bw)
+{
+	if (IS_ERR_OR_NULL(opp) || !opp->available) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return 0;
+	}
+
+	if (avg_bw)
+		*avg_bw = opp->avg_bw;
+
+	return opp->rate;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_bw);
+
 /**
  * dev_pm_opp_get_level() - Gets the level corresponding to an available opp
  * @opp:	opp for which level value has to be returned for
@@ -299,6 +322,34 @@ unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_freq);
 
+/**
+ * dev_pm_opp_get_suspend_opp_bw() - Get peak bandwidth of suspend opp in kBps
+ * @dev:	device for which we do this operation
+ * @avg_bw:	Pointer where the corresponding average bandwidth is stored.
+ *		Can be NULL.
+ *
+ * Return: This function returns the peak bandwidth of the OPP marked as
+ * suspend_opp if one is available, else returns 0;
+ */
+unsigned long dev_pm_opp_get_suspend_opp_bw(struct device *dev,
+					    unsigned long *avg_bw)
+{
+	struct opp_table *opp_table;
+	unsigned long peak_bw = 0;
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		return 0;
+
+	if (opp_table->suspend_opp && opp_table->suspend_opp->available)
+		peak_bw = dev_pm_opp_get_bw(opp_table->suspend_opp, avg_bw);
+
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return peak_bw;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_bw);
+
 int _get_opp_count(struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index b8197ab014f2..f4e900f36414 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -82,6 +82,7 @@ void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
+unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp, unsigned long *avg_bw);
 
 unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp);
 
@@ -92,6 +93,8 @@ unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev);
 unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev);
 unsigned long dev_pm_opp_get_max_transition_latency(struct device *dev);
 unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev);
+unsigned long dev_pm_opp_get_suspend_opp_bw(struct device *dev,
+					    unsigned long *avg_bw);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      unsigned long freq,
@@ -160,6 +163,11 @@ static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 {
 	return 0;
 }
+static inline unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp,
+					      unsigned long *avg_bw)
+{
+	return 0;
+}
 
 static inline unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
 {
@@ -196,6 +204,12 @@ static inline unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
 	return 0;
 }
 
+static inline unsigned long dev_pm_opp_get_suspend_opp_bw(struct device *dev,
+							  unsigned long *avg_bw)
+{
+	return 0;
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					unsigned long freq, bool available)
 {
@@ -337,6 +351,11 @@ static inline void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask
 
 #endif		/* CONFIG_PM_OPP */
 
+#define dev_pm_opp_find_peak_bw_exact	dev_pm_opp_find_freq_exact
+#define dev_pm_opp_find_peak_bw_floor	dev_pm_opp_find_freq_floor
+#define dev_pm_opp_find_peak_bw_ceil_by_volt dev_pm_opp_find_freq_ceil_by_volt
+#define dev_pm_opp_find_peak_bw_ceil	dev_pm_opp_find_freq_ceil
+
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
 int dev_pm_opp_of_add_table(struct device *dev);
 int dev_pm_opp_of_add_table_indexed(struct device *dev, int index);
-- 
2.23.0.rc1.153.gdeed80330f-goog

