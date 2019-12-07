Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEC9115A1A
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2019 01:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfLGAYl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Dec 2019 19:24:41 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:32966 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfLGAYj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Dec 2019 19:24:39 -0500
Received: by mail-pf1-f202.google.com with SMTP id c72so3779643pfc.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Dec 2019 16:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7F9wb0NeoAKdzSfGIj2zPf1bY1Y5o8kRPmqEXmlUWks=;
        b=gM6r1m2Jt3TZbjyVT2Qgup37OFOpREzlnoZ0YQj2opNISflbi53vOFHeIBXHlqf0Ay
         u54WROsH2hReAtfCxsDWD6QGd0X9z9CZnbyLV1rlXSuSyAhDfha5KAa31B/mxbAjyt8p
         5WqaeTs7PnO/auaQJyzC6qLBBpQ/t18Cyh9/9XmiEof3j66DhBzIxzLfaPiBnxOCJWkf
         KypK6AlNgRUIW/4SYNh+9X61dZBrLSILvjlmXgv03FVfG13hfegVR7oaG9sULBT7FoU8
         knoatL0fNlaWIMEGiDkt/oQugWlJC3U0rHrp5s7OS9dnOd55MqpDnWq7rcF3vO1KatPo
         9Xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7F9wb0NeoAKdzSfGIj2zPf1bY1Y5o8kRPmqEXmlUWks=;
        b=f1Az9/j/chPQPYlhluEZxvlxrAePaGrNUXVmIHASlxxY9mCMjhKhkFcl4HbcPpKORb
         W7CmaRWr/GHCbQYZpz/Cy3eE029681wndykQC2hd1vXLsudQ6wWN4Jd93Cyndkha+a6G
         StXwKN7e16OGjHlj8z/NpUqhPVEyUVwzIfO29gDtIKJDenh706ZVEAQdN8hhFIUHfxzx
         YHIKBpQpZoVookVIcUOSXfOAtzczrSP2cEhhda4eVFD8ovctjhJyr9KfvYzTV3jh07RT
         t7dWJkSRDjsi3GawMpwajRLKd9YRow4GriZetHgE0d4SU0KQO5/jZLed4BvQfrT4A7sQ
         18Bg==
X-Gm-Message-State: APjAAAVAw9oMC72NgsFrs/ow3Jt8cpAANWwrxgff+hEh3aLLmaBgZxVr
        9NFhkmHCIUfP6L8yVz5P1v+1GBd4PClF+hA=
X-Google-Smtp-Source: APXvYqzcTrFr9aq9fGrzZa2rf927VYsYaEXCY55XTj+oMy5jDEFCOUsdHu6zkV9aZcXcJ6L8H7bB4A9RmoBUM18=
X-Received: by 2002:a63:d551:: with SMTP id v17mr6694357pgi.365.1575678278342;
 Fri, 06 Dec 2019 16:24:38 -0800 (PST)
Date:   Fri,  6 Dec 2019 16:24:24 -0800
In-Reply-To: <20191207002424.201796-1-saravanak@google.com>
Message-Id: <20191207002424.201796-4-saravanak@google.com>
Mime-Version: 1.0
References: <20191207002424.201796-1-saravanak@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v6 3/3] OPP: Add helper function for bandwidth OPP tables
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
 drivers/opp/core.c     | 301 +++++++++++++++++++++++++++++++++++------
 include/linux/pm_opp.h |  43 ++++++
 2 files changed, 305 insertions(+), 39 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c79bbfac7289..3ff33a08198e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -127,6 +127,29 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
 
+/**
+ * dev_pm_opp_get_bw() - Gets the bandwidth corresponding to an available opp
+ * @opp:	opp for which peak bandwidth has to be returned for
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
+	return opp->peak_bw;
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
@@ -343,6 +394,40 @@ int dev_pm_opp_get_opp_count(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
 
+struct dev_pm_opp *dev_pm_opp_find_opp_exact(struct device *dev,
+					      struct dev_pm_opp *opp_key,
+					      bool available)
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		int r = PTR_ERR(opp_table);
+
+		dev_err(dev, "%s: OPP table not found (%d)\n", __func__, r);
+		return ERR_PTR(r);
+	}
+
+	mutex_lock(&opp_table->lock);
+
+	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
+		if (temp_opp->available == available &&
+		    !opp_compare_key(temp_opp, opp_key)) {
+			opp = temp_opp;
+
+			/* Increment the reference count of OPP */
+			dev_pm_opp_get(opp);
+			break;
+		}
+	}
+
+	mutex_unlock(&opp_table->lock);
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return opp;
+}
+
 /**
  * dev_pm_opp_find_freq_exact() - search for an exact frequency
  * @dev:		device for which we do this operation
@@ -370,36 +455,53 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      unsigned long freq,
 					      bool available)
 {
-	struct opp_table *opp_table;
-	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
-
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table)) {
-		int r = PTR_ERR(opp_table);
+	struct dev_pm_opp opp_key;
 
-		dev_err(dev, "%s: OPP table not found (%d)\n", __func__, r);
-		return ERR_PTR(r);
-	}
+	opp_key.rate = freq;
+	opp_key.peak_bw = 0;
+	opp_key.level = 0;
 
-	mutex_lock(&opp_table->lock);
+	return dev_pm_opp_find_opp_exact(dev, &opp_key, available);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
 
-	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
-		if (temp_opp->available == available &&
-				temp_opp->rate == freq) {
-			opp = temp_opp;
+/**
+ * dev_pm_opp_find_peak_bw_exact() - search for an exact peak bandwidth
+ * @dev:		device for which we do this operation
+ * @peak_bw:		peak bandwidth to search for
+ * @available:		true/false - match for available opp
+ *
+ * Return: Searches for exact match in the opp table and returns pointer to the
+ * matching opp if found, else returns ERR_PTR in case of error and should
+ * be handled using IS_ERR. Error return values can be:
+ * EINVAL:	for bad pointer
+ * ERANGE:	no match found for search
+ * ENODEV:	if device not found in list of registered devices
+ *
+ * Note: available is a modifier for the search. if available=true, then the
+ * match is for exact matching peak bandwidth and is available in the stored
+ * OPP table. if false, the match is for exact peak bandwidth which is not
+ * available.
+ *
+ * This provides a mechanism to enable an opp which is not available currently
+ * or the opposite as well.
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *dev_pm_opp_find_peak_bw_exact(struct device *dev,
+						 unsigned int peak_bw,
+						 bool available)
+{
+	struct dev_pm_opp opp_key;
 
-			/* Increment the reference count of OPP */
-			dev_pm_opp_get(opp);
-			break;
-		}
-	}
+	opp_key.rate = 0;
+	opp_key.peak_bw = peak_bw;
+	opp_key.level = 0;
 
-	mutex_unlock(&opp_table->lock);
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return opp;
+	return dev_pm_opp_find_opp_exact(dev, &opp_key, available);
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_peak_bw_exact);
 
 /**
  * dev_pm_opp_find_level_exact() - search for an exact level
@@ -449,18 +551,17 @@ struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_exact);
 
-static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
-						   unsigned long *freq)
+static struct dev_pm_opp *_find_opp_ceil(struct opp_table *opp_table,
+					 struct dev_pm_opp *opp_key)
 {
 	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
 	mutex_lock(&opp_table->lock);
 
 	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
-		if (temp_opp->available && temp_opp->rate >= *freq) {
+		if (temp_opp->available &&
+		    opp_compare_key(temp_opp, opp_key) >= 0) {
 			opp = temp_opp;
-			*freq = opp->rate;
-
 			/* Increment the reference count of OPP */
 			dev_pm_opp_get(opp);
 			break;
@@ -472,6 +573,23 @@ static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
 	return opp;
 }
 
+static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
+						   unsigned long *freq)
+{
+	struct dev_pm_opp opp_key, *opp;
+
+	opp_key.rate = *freq;
+	opp_key.peak_bw = 0;
+	opp_key.level = 0;
+
+	opp = _find_opp_ceil(opp_table, &opp_key);
+
+	if (!IS_ERR(opp))
+		*freq = opp->rate;
+
+	return opp;
+}
+
 /**
  * dev_pm_opp_find_freq_ceil() - Search for an rounded ceil freq
  * @dev:	device for which we do this operation
@@ -514,14 +632,14 @@ struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
 
 /**
- * dev_pm_opp_find_freq_floor() - Search for a rounded floor freq
+ * dev_pm_opp_find_peak_bw_ceil() - Search for an rounded ceil peak bandwidth
  * @dev:	device for which we do this operation
- * @freq:	Start frequency
+ * @peak_bw:	Start peak bandwidth
  *
- * Search for the matching floor *available* OPP from a starting freq
+ * Search for the matching ceil *available* OPP from a starting peak bandwidth
  * for a device.
  *
- * Return: matching *opp and refreshes *freq accordingly, else returns
+ * Return: matching *opp and refreshes *peak_bw accordingly, else returns
  * ERR_PTR in case of error and should be handled using IS_ERR. Error return
  * values can be:
  * EINVAL:	for bad pointer
@@ -531,17 +649,43 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
  * The callers are required to call dev_pm_opp_put() for the returned OPP after
  * use.
  */
-struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
-					      unsigned long *freq)
+struct dev_pm_opp *dev_pm_opp_find_peak_bw_ceil(struct device *dev,
+						unsigned long *peak_bw)
 {
 	struct opp_table *opp_table;
-	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
+	struct dev_pm_opp *opp;
+	struct dev_pm_opp opp_key;
 
-	if (!dev || !freq) {
-		dev_err(dev, "%s: Invalid argument freq=%p\n", __func__, freq);
+	if (!dev || !peak_bw) {
+		dev_err(dev, "%s: Invalid argument peak_bw=%p\n", __func__,
+			peak_bw);
 		return ERR_PTR(-EINVAL);
 	}
 
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		return ERR_CAST(opp_table);
+
+	opp_key.rate = 0;
+	opp_key.peak_bw = *peak_bw;
+	opp_key.level = 0;
+	opp = _find_opp_ceil(opp_table, &opp_key);
+
+	if (!IS_ERR(opp))
+		*peak_bw = opp->rate;
+
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return opp;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_peak_bw_ceil);
+
+struct dev_pm_opp *dev_pm_opp_find_opp_floor(struct device *dev,
+					     struct dev_pm_opp *opp_key)
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
+
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return ERR_CAST(opp_table);
@@ -551,7 +695,7 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
 		if (temp_opp->available) {
 			/* go to the next node, before choosing prev */
-			if (temp_opp->rate > *freq)
+			if (opp_compare_key(temp_opp, opp_key) > 0)
 				break;
 			else
 				opp = temp_opp;
@@ -564,6 +708,43 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 	mutex_unlock(&opp_table->lock);
 	dev_pm_opp_put_opp_table(opp_table);
 
+	return opp;
+}
+
+/**
+ * dev_pm_opp_find_freq_floor() - Search for a rounded floor freq
+ * @dev:	device for which we do this operation
+ * @freq:	Start frequency
+ *
+ * Search for the matching floor *available* OPP from a starting freq
+ * for a device.
+ *
+ * Return: matching *opp and refreshes *freq accordingly, else returns
+ * ERR_PTR in case of error and should be handled using IS_ERR. Error return
+ * values can be:
+ * EINVAL:	for bad pointer
+ * ERANGE:	no match found for search
+ * ENODEV:	if device not found in list of registered devices
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
+					      unsigned long *freq)
+{
+	struct dev_pm_opp opp_key, *opp;
+
+	if (!dev || !freq) {
+		dev_err(dev, "%s: Invalid argument freq=%p\n", __func__, freq);
+		return ERR_PTR(-EINVAL);
+	}
+
+	opp_key.rate = *freq;
+	opp_key.peak_bw = 0;
+	opp_key.level = 0;
+
+	opp = dev_pm_opp_find_opp_floor(dev, &opp_key);
+
 	if (!IS_ERR(opp))
 		*freq = opp->rate;
 
@@ -571,6 +752,48 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
+/**
+ * dev_pm_opp_find_peak_bw_floor() - Search for a rounded floor peak bandwidth
+ * @dev:	device for which we do this operation
+ * @peak_bw:	Start peak bandwidth
+ *
+ * Search for the matching floor *available* OPP from a starting peak bandwidth
+ * for a device.
+ *
+ * Return: matching *opp and refreshes *peak_bw accordingly, else returns
+ * ERR_PTR in case of error and should be handled using IS_ERR. Error return
+ * values can be:
+ * EINVAL:	for bad pointer
+ * ERANGE:	no match found for search
+ * ENODEV:	if device not found in list of registered devices
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *dev_pm_opp_find_peak_bw_floor(struct device *dev,
+						 unsigned int *peak_bw)
+{
+	struct dev_pm_opp opp_key, *opp;
+
+	if (!dev || !peak_bw) {
+		dev_err(dev, "%s: Invalid argument peak_bw=%p\n", __func__,
+			peak_bw);
+		return ERR_PTR(-EINVAL);
+	}
+
+	opp_key.rate = 0;
+	opp_key.peak_bw = *peak_bw;
+	opp_key.level = 0;
+
+	opp = dev_pm_opp_find_opp_floor(dev, &opp_key);
+
+	if (!IS_ERR(opp))
+		*peak_bw = opp->peak_bw;
+
+	return opp;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_peak_bw_floor);
+
 /**
  * dev_pm_opp_find_freq_ceil_by_volt() - Find OPP with highest frequency for
  *					 target voltage.
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 747861816f4f..aab1b9c143ac 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -83,6 +83,7 @@ void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
+unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp, unsigned long *avg_bw);
 
 unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp);
 
@@ -93,20 +94,29 @@ unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev);
 unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev);
 unsigned long dev_pm_opp_get_max_transition_latency(struct device *dev);
 unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev);
+unsigned long dev_pm_opp_get_suspend_opp_bw(struct device *dev,
+					    unsigned long *avg_bw);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      unsigned long freq,
 					      bool available);
+struct dev_pm_opp *dev_pm_opp_find_peak_bw_exact(struct device *dev,
+						 unsigned int peak_bw,
+						 bool available);
 struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
 					       unsigned int level);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq);
+struct dev_pm_opp *dev_pm_opp_find_peak_bw_floor(struct device *dev,
+						 unsigned int *peak_bw);
 struct dev_pm_opp *dev_pm_opp_find_freq_ceil_by_volt(struct device *dev,
 						     unsigned long u_volt);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq);
+struct dev_pm_opp *dev_pm_opp_find_peak_bw_ceil(struct device *dev,
+						unsigned long *peak_bw);
 void dev_pm_opp_put(struct dev_pm_opp *opp);
 
 int dev_pm_opp_add(struct device *dev, unsigned long freq,
@@ -165,6 +175,11 @@ static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
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
@@ -201,12 +216,26 @@ static inline unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
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
 	return ERR_PTR(-ENOTSUPP);
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_find_peak_bw_exact(
+							struct device *dev,
+							unsigned int peak_bw,
+							bool available)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
 					unsigned int level)
 {
@@ -219,6 +248,13 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 	return ERR_PTR(-ENOTSUPP);
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_find_peak_bw_floor(
+							struct device *dev,
+							unsigned int *peak_bw)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil_by_volt(struct device *dev,
 					unsigned long u_volt)
 {
@@ -231,6 +267,13 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 	return ERR_PTR(-ENOTSUPP);
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_find_peak_bw_ceil(
+							struct device *dev,
+							unsigned long *peak_bw)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 static inline void dev_pm_opp_put(struct dev_pm_opp *opp) {}
 
 static inline int dev_pm_opp_add(struct device *dev, unsigned long freq,
-- 
2.24.0.393.g34dc348eaf-goog

