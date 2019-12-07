Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55CE9115A16
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2019 01:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfLGAYg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Dec 2019 19:24:36 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:47656 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfLGAYg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Dec 2019 19:24:36 -0500
Received: by mail-pf1-f201.google.com with SMTP id e62so4959835pfh.14
        for <linux-pm@vger.kernel.org>; Fri, 06 Dec 2019 16:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SV8i18v4GwCQzlFHpNagXzdfAXCmjcaelWYEg2MgtX0=;
        b=fBPot67V4Sr6ihA96kRmN3gOwO52BtcVhar2RPHsFQS1Iiix4vcedwd8b53ksqiMyj
         2yeNsp3pTQ0wtdRfc7OV1ZV0RHmRZTjG9u5LpgPo0rgX+WLKgqQTUAFbRjd9xvywQuPZ
         rj3S1zW3LQOTWjPOXQvJn3kKK2Tv8u72p41G5YAB/+ohzNAimBBuw0nI+KSgUuEooecc
         v3v4cL6tGvESh9/4w5buCfd/UubqjqBSYGv884Fd+79zTI44Od3KCsaFl+qfTyQiZv/l
         ZKuzL00hfvepPD/5MkKkp0wcYY7uTz5Pbretw0oiyZKgjVkkX/bFhTbc58XAY9SPes8N
         ES+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SV8i18v4GwCQzlFHpNagXzdfAXCmjcaelWYEg2MgtX0=;
        b=YGd5Mh1QlNqhDteB/LkoL5EFR4G8dicCvBKETIndYB+2z13vu4PgAcGhhiZpClVm0p
         hqMXEdI6hKvYhDrhhnFh6D45soOjzziAbGRQsPaMOt2QKMZMdKW5Pfds9oUBBjN0XX2W
         WFF/LeTzZMQ06a53Reaxk/JgSQkUO/ZF4PiC7yvzVTo0VJrtXNdSXfH1r7HZzT7QBzsP
         gpgS6Bn2+5PdVnlBsm/c/7OWV4L/z7x+6M/qTL/KVx5EsmJkW3/asQ2gEDR7avMyROg3
         CwUykKagNTUCC3ylrF3S7uzhWH7enQSVnhjR2FE+YSq/UCxC77M5VKByAvcG8CBr6K7F
         nrlA==
X-Gm-Message-State: APjAAAUblY1QK87FKXm37L8w0PiwibPte5MRwHHKaZ/V0S5vWhOyPGy3
        aaoSUVe341TWXfIfUAYlBOtHBU+2cCrrU1U=
X-Google-Smtp-Source: APXvYqw9xkOLUzACH5NGXsGojYyQ6wPkEr/kwbjNXJQocK4PvMVxIEC1zoQq+nZxKhCAeRcPadlGWu/Toa1PCLE=
X-Received: by 2002:a63:5206:: with SMTP id g6mr6727247pgb.49.1575678275167;
 Fri, 06 Dec 2019 16:24:35 -0800 (PST)
Date:   Fri,  6 Dec 2019 16:24:23 -0800
In-Reply-To: <20191207002424.201796-1-saravanak@google.com>
Message-Id: <20191207002424.201796-3-saravanak@google.com>
Mime-Version: 1.0
References: <20191207002424.201796-1-saravanak@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v6 2/3] OPP: Add support for bandwidth OPP tables
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

Not all devices quantify their performance points in terms of frequency.
Devices like interconnects quantify their performance points in terms of
bandwidth. We need a way to represent these bandwidth levels in OPP. So,
add support for parsing bandwidth OPPs from DT.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/opp/core.c | 15 +++++++++--
 drivers/opp/of.c   | 63 ++++++++++++++++++++++++++++++++--------------
 drivers/opp/opp.h  |  5 ++++
 3 files changed, 62 insertions(+), 21 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index be7a7d332332..c79bbfac7289 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1282,11 +1282,21 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
 	return true;
 }
 
+int opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2)
+{
+	if (opp1->rate != opp2->rate)
+		return opp1->rate < opp2->rate ? -1 : 1;
+	if (opp1->peak_bw != opp2->peak_bw)
+		return opp1->peak_bw < opp2->peak_bw ? -1 : 1;
+	return 0;
+}
+
 static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp *new_opp,
 			     struct opp_table *opp_table,
 			     struct list_head **head)
 {
 	struct dev_pm_opp *opp;
+	int opp_cmp;
 
 	/*
 	 * Insert new OPP in order of increasing frequency and discard if
@@ -1297,12 +1307,13 @@ static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp *new_opp,
 	 * loop.
 	 */
 	list_for_each_entry(opp, &opp_table->opp_list, node) {
-		if (new_opp->rate > opp->rate) {
+		opp_cmp = opp_compare_key(new_opp, opp);
+		if (opp_cmp > 0) {
 			*head = &opp->node;
 			continue;
 		}
 
-		if (new_opp->rate < opp->rate)
+		if (opp_cmp < 0)
 			return 0;
 
 		/* Duplicate OPPs */
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 1cbb58240b80..b565da5a2b1f 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -521,6 +521,44 @@ void dev_pm_opp_of_remove_table(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
+static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np,
+			 bool *rate_not_available)
+{
+	int ret;
+	u64 rate;
+	u32 bw;
+
+	ret = of_property_read_u64(np, "opp-hz", &rate);
+	if (!ret) {
+		/*
+		 * Rate is defined as an unsigned long in clk API, and so
+		 * casting explicitly to its type. Must be fixed once rate is 64
+		 * bit guaranteed in clk API.
+		 */
+		new_opp->rate = (unsigned long)rate;
+		goto out;
+	}
+
+	ret = of_property_read_u32(np, "opp-peak-kBps", &bw);
+	if (!ret) {
+		new_opp->peak_bw = bw;
+
+		if (!of_property_read_u32(np, "opp-avg-kBps", &bw))
+			new_opp->avg_bw = bw;
+	}
+
+out:
+	*rate_not_available = !!ret;
+	/*
+	 * If ret is 0 at this point, we have already found a key. If we
+	 * haven't found a key yet, then ret already has an error value. In
+	 * either case, we don't need to update ret.
+	 */
+	of_property_read_u32(np, "opp-level", &new_opp->level);
+
+	return ret;
+}
+
 /**
  * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
  * @opp_table:	OPP table
@@ -558,26 +596,12 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	if (!new_opp)
 		return ERR_PTR(-ENOMEM);
 
-	ret = of_property_read_u64(np, "opp-hz", &rate);
-	if (ret < 0) {
-		/* "opp-hz" is optional for devices like power domains. */
-		if (!opp_table->is_genpd) {
-			dev_err(dev, "%s: opp-hz not found\n", __func__);
-			goto free_opp;
-		}
-
-		rate_not_available = true;
-	} else {
-		/*
-		 * Rate is defined as an unsigned long in clk API, and so
-		 * casting explicitly to its type. Must be fixed once rate is 64
-		 * bit guaranteed in clk API.
-		 */
-		new_opp->rate = (unsigned long)rate;
+	ret = _read_opp_key(new_opp, np, &rate_not_available);
+	if (ret) {
+		dev_err(dev, "%s: opp key field not found\n", __func__);
+		goto free_opp;
 	}
 
-	of_property_read_u32(np, "opp-level", &new_opp->level);
-
 	/* Check if the OPP supports hardware's hierarchy of versions or not */
 	if (!_opp_is_supported(dev, opp_table, np)) {
 		dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
@@ -616,7 +640,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	if (of_property_read_bool(np, "opp-suspend")) {
 		if (opp_table->suspend_opp) {
 			/* Pick the OPP with higher rate as suspend OPP */
-			if (new_opp->rate > opp_table->suspend_opp->rate) {
+			if (opp_compare_key(new_opp,
+					    opp_table->suspend_opp) > 1) {
 				opp_table->suspend_opp->suspend = false;
 				new_opp->suspend = true;
 				opp_table->suspend_opp = new_opp;
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 01a500e2c40a..0def3154d07b 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -57,6 +57,8 @@ extern struct list_head opp_tables;
  * @suspend:	true if suspend OPP
  * @pstate: Device's power domain's performance state.
  * @rate:	Frequency in hertz
+ * @peak_bw:	Peak bandwidth in kilobytes per second
+ * @avg_bw:	Average bandwidth in kilobytes per second
  * @level:	Performance level
  * @supplies:	Power supplies voltage/current values
  * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
@@ -78,6 +80,8 @@ struct dev_pm_opp {
 	bool suspend;
 	unsigned int pstate;
 	unsigned long rate;
+	unsigned int peak_bw;
+	unsigned int avg_bw;
 	unsigned int level;
 
 	struct dev_pm_opp_supply *supplies;
@@ -213,6 +217,7 @@ struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_
 void _dev_pm_opp_find_and_remove_table(struct device *dev);
 struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
 void _opp_free(struct dev_pm_opp *opp);
+int opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table, bool rate_not_available);
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
 void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cpu);
-- 
2.24.0.393.g34dc348eaf-goog

