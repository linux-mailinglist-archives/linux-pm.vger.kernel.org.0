Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A8945354
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 06:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfFNESA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 00:18:00 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:48720 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfFNER5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 00:17:57 -0400
Received: by mail-oi1-f201.google.com with SMTP id a198so384697oii.15
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2019 21:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pA88GQBtAGP1rgMV9ltyoIPWXgCzn/zukoiOtKtlP+A=;
        b=hofCja+avL07axE3R4McdlSXe7Uh1GlxOzhy0doUwhmYDuewv+768/I2/KGsCvyQpo
         M9xTviAi5haf2KYGdovWoHAcGJa7VbsrRtv/AjJKAZwrfpo8FVa5gl4mZhD7XQO8MMzn
         6i6SfA2Zif1JxtMQVS/hnSNwJDVOcv6MPZj/Lm+G7QLJYcJcQevCABuIT5Rvj/HHBNkY
         ZuGV4njreHUAIUWt73jMnymqo3iIeshCrnHg7I3OFkKgIjb9kfLgvirLXt2K+9a+vEqC
         xdb9689SZkzVD9QCCLwB3sMV0UJ3zeXxW4A7eME2k2i/aaxwgVKaysFyt0f8HgTerpTn
         jNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pA88GQBtAGP1rgMV9ltyoIPWXgCzn/zukoiOtKtlP+A=;
        b=YFmRt+cEJhA9ZzPvvF480Zo8+mGUAqFARAs4a/xhHQvhCBnJJt/4fFOATtXODYNKZf
         GrHaBWbgLovwVgONyy1fG1VUMir+cZgSM8aQZoaKT0ac2RczI370FM4USZ1ZDVQZf9Ha
         EuJrSv5n3RFHNO/puanwadON4BrclSrDj35O6+GxnOgGfZkjUfjrMKcprAbmWV+uBmHn
         ekewsYPrK+wMHII+LPZtLhVsD3ZU3HBpOqrYMpcX13dTg8uXWpRHuJQcWkYLwYYLLzjS
         LutEdQIkb2mkPFb5P+EX1aJPwVwqtpbBdHSm8oHZA5BCBzoBdQMFEHn2nRFmW3R5gMI3
         c8vg==
X-Gm-Message-State: APjAAAXPfxGhyQ8hxLndE+etNYWbqq9AvHSgEJ+m5NJ6nue353pzuNf0
        4b0UujkHZdnlEKVYROcA1ZJsGHPZ1SAi78k=
X-Google-Smtp-Source: APXvYqz3ylX7YKsVxmRmx0ILRl96jgFQUhX4Ot0Xk/v6CidHJ6fjT9LuNNkVqkxIwm4aW7E/2qf1NayfUQeABYk=
X-Received: by 2002:aca:6c1:: with SMTP id 184mr563474oig.122.1560485876623;
 Thu, 13 Jun 2019 21:17:56 -0700 (PDT)
Date:   Thu, 13 Jun 2019 21:17:28 -0700
In-Reply-To: <20190614041733.120807-1-saravanak@google.com>
Message-Id: <20190614041733.120807-7-saravanak@google.com>
Mime-Version: 1.0
References: <20190614041733.120807-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2 06/11] OPP: Add helper function for bandwidth OPP tables
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
index 4f7870bffbf8..c9914afd508a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -130,6 +130,29 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
 
+/**
+ * dev_pm_opp_get_bw() - Gets the bandwidth corresponding to an available opp
+ * @opp:	opp for which frequency has to be returned for
+ * @avg_bw:	Pointer where the corresponding average bandwidth is stored.
+ *		Can be NULL.
+ *
+ * Return: Peak bandwidth in KBps corresponding to the opp, else
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
@@ -302,6 +325,34 @@ unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_freq);
 
+/**
+ * dev_pm_opp_get_suspend_opp_bw() - Get peak bandwidth of suspend opp in KBps
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
index bc5c68bdfc8d..2e122af26b8e 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -85,6 +85,7 @@ void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
+unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp, unsigned long *avg_bw);
 
 unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp);
 
@@ -95,6 +96,8 @@ unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev);
 unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev);
 unsigned long dev_pm_opp_get_max_transition_latency(struct device *dev);
 unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev);
+unsigned long dev_pm_opp_get_suspend_opp_bw(struct device *dev,
+					    unsigned long *avg_bw);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      unsigned long freq,
@@ -164,6 +167,11 @@ static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
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
@@ -200,6 +208,12 @@ static inline unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
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
@@ -343,6 +357,11 @@ static inline void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask
 
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
2.22.0.rc2.383.gf4fbbf30c2-goog

