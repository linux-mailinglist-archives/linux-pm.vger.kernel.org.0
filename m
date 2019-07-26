Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 073D5774DA
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2019 01:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387626AbfGZXQP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 19:16:15 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:41246 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387516AbfGZXQO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 19:16:14 -0400
Received: by mail-pl1-f202.google.com with SMTP id i3so29314623plb.8
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2019 16:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fNB7qnI3bdYKnt/Y7nwqVEyFkilceT/R7ii1SBBbpUg=;
        b=LHarGmzTEPysrcMIeJATx6XiX40OooWzDYDrNxST2Z/MGCg3Q+JnXW3m8ALRa7i5er
         9wxiWsIEkJAUILz3lCVvn0SVIpM/8VoLhwjC7duR+HXI1G1sj6qfF/liSPxCi3/qZBMk
         FEF3r5fZJIHidcu2q/jem64rfJEgMR0rDjOkKlvm9TIJ+qbpMx96wb7QRoY3vGLlWvM5
         J1UX6OpBEYofI/8snQyxdbNwIWRcVSkQnFXx11epk1CIp31EK3Y32pS8pcfWs1W3HN4D
         tfSMC04k3dj7ZjBnQnDnEGscYpPNa+5yeFfDzZZod4RqOMiHnOUFew+7hqqbn4PK4rYy
         iVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fNB7qnI3bdYKnt/Y7nwqVEyFkilceT/R7ii1SBBbpUg=;
        b=iaEA4VFf2AFR9QrMIzoJLjSaPPbvT7UUqBEh/K32PcMyDCPC0yGMDpM43/aawQEDXm
         0yn19C5Z8jbT9gU9wkjJz5y8ji4lmxDPLaUgrU74p2PSGoZuu1vZuxo0aktF/JdkYTM8
         MK3bDBnBTHxdzTBPK8SRL6rDBHwTtr1iFdVVZYq46OwAKsfTGqjWMs6ttiXrW2X9lhBN
         njvh8oAsjNamO2N7orvFU2SwL7oFCntJKCh+tAsoHkyZ+DAeHdvVS89mt0368k+JcLNx
         rXnovMGBH+QCVtcaxpskhQ+tY+V56I7LMk6lrrJ50ufg+fyfcxCui8IOLEFx7S7WmneM
         aaIg==
X-Gm-Message-State: APjAAAXmCPIe3PiW8NiZFsKANJBn96u35beEEbnGK6+FGg0rLcjRZV1I
        E9or44uwE9x8LU3stVLIS3WXXEJWWq8Zrr8=
X-Google-Smtp-Source: APXvYqxckDAGi2179Dss4TNW7V5oQ+KtInskdy6iWs9OFmEWPem90rqPCK4YbUftHHL1Fka02rlirzxvHKTOXzs=
X-Received: by 2002:a63:e306:: with SMTP id f6mr92102901pgh.39.1564182973407;
 Fri, 26 Jul 2019 16:16:13 -0700 (PDT)
Date:   Fri, 26 Jul 2019 16:15:57 -0700
In-Reply-To: <20190726231558.175130-1-saravanak@google.com>
Message-Id: <20190726231558.175130-4-saravanak@google.com>
Mime-Version: 1.0
References: <20190726231558.175130-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v4 3/3] OPP: Add helper function for bandwidth OPP tables
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
index c094d5d20fd7..b36bc69341dc 100644
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
@@ -299,6 +322,34 @@ unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
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
index af5021f27cb7..799b1defe1f7 100644
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
@@ -158,6 +161,11 @@ static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
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
@@ -194,6 +202,12 @@ static inline unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
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
@@ -329,6 +343,11 @@ static inline void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask
 
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
2.22.0.709.g102302147b-goog

