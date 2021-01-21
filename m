Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DB22FE973
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 12:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbhAUL6J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 06:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbhAULUp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 06:20:45 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF79C061794
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:18:52 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id x20so1455715pjh.3
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YF247aIKbCY2/r4PGlk3GxBCCQW3KMMZcpJEZOc5/Q0=;
        b=q4aQO8etJergPAghmEtuVxVLdykQPpd3HcPHMD6EQfoX4tjuP7MhEF6K18XC4Inuvs
         RKy9SstcZSdr5meQkznW9PfhKeD+22MQjTjs4PHJH9L58N3mnjyCGPezVaH7gzv1IJhs
         bT8Lesss5bsMcmN703omHfIN795Q3hMsxgr9GzjVPd43t1fDQ4eATXjN6CiHR+qCOpzC
         8WvFnYva6RL0BKdBzgnMwkV+jxxe4VLJOt1F2Jbz//EiJliXk3CRa8qY5cwHxmXPFaho
         DxRROl7t7RugdR/omHIBFABHDp6JPTYdUWtoOf4Stb2KFicJr+1c4y7rqExGmMRTsAS4
         tcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YF247aIKbCY2/r4PGlk3GxBCCQW3KMMZcpJEZOc5/Q0=;
        b=EcSbPH5lSWjlthIekLhiLgQ4GfuCj2vby5ennTLPhwTjcypFyWucLE1pQXOmAr3zcY
         aA0tDHoU45MUS6LJ/vWW0/oOVDs7r1lY7j91H0d5QtCVnSs8WPAZrpHjiNnl2qq1wKFp
         nS/NouHt7ceJXmSV5e6efmOZK8CRD1p9vAwsDdAOWI7M5fOyaqM2klOtDL1mVmjgJYyY
         g4U890r6j6+DGMZC3l2ad7hr47MxK3lQTNC9IXO5WpLvzFatR8YjRVKd1u/wf7S4qf4X
         eC9bqihA1I2J6A8gc6WTvlpySEPerwN3vlccHjJN1VBMK3Ocb+0G91k5WfZYC9LxMqfL
         R27w==
X-Gm-Message-State: AOAM530Y52AjlsJ1usJ3kH1eydlMF44MZysIpIj9dsfbMnbAo+ABJsvw
        D2Os3YNqNxbRwfLIO1i+Xj5ecQ==
X-Google-Smtp-Source: ABdhPJwfrY+H9LpE/xzRxcE/UG1SyICoTj1JCeeOTMnUNb06bH1CDejbbABKsIFbSOnrOGELyi32/w==
X-Received: by 2002:a17:902:c509:b029:de:c3c7:9433 with SMTP id o9-20020a170902c509b02900dec3c79433mr14234653plx.71.1611227931401;
        Thu, 21 Jan 2021 03:18:51 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id z13sm5392343pgf.89.2021.01.21.03.18.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 03:18:50 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/13] opp: Keep track of currently programmed OPP
Date:   Thu, 21 Jan 2021 16:47:43 +0530
Message-Id: <96b57316a2a307a5cc5ff7302b3cd0084123a2ed.1611227342.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611227342.git.viresh.kumar@linaro.org>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The dev_pm_opp_set_rate() helper needs to know the currently programmed
OPP to make few decisions and currently we try to find it on every
invocation of this routine.

Lets start keeping track of the current_opp programmed for the devices
of the opp table, that will be quite useful going forward.

If we fail to find the current OPP, we pick the first one available in
the list, as the list is in ascending order of frequencies, level, or
bandwidth and that's the best guess we can make anyway.

Note that we used to do the frequency comparison a bit early in
dev_pm_opp_set_rate() previously, and now instead we check the target
opp, which shall be more accurate anyway.

We need to make sure that current_opp's memory doesn't get freed while
it is being used and so we keep a reference of it until the time it is
used.

Now that current_opp will always be set, we can drop some unnecessary
checks as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 83 +++++++++++++++++++++++++++++-----------------
 drivers/opp/opp.h  |  2 ++
 2 files changed, 55 insertions(+), 30 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index cb5b67ccf5cf..4ee598344e6a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -788,8 +788,7 @@ static int _generic_set_opp_regulator(struct opp_table *opp_table,
 			__func__, old_freq);
 restore_voltage:
 	/* This shouldn't harm even if the voltages weren't updated earlier */
-	if (old_supply)
-		_set_opp_voltage(dev, reg, old_supply);
+	_set_opp_voltage(dev, reg, old_supply);
 
 	return ret;
 }
@@ -839,10 +838,7 @@ static int _set_opp_custom(const struct opp_table *opp_table,
 
 	data->old_opp.rate = old_freq;
 	size = sizeof(*old_supply) * opp_table->regulator_count;
-	if (!old_supply)
-		memset(data->old_opp.supplies, 0, size);
-	else
-		memcpy(data->old_opp.supplies, old_supply, size);
+	memcpy(data->old_opp.supplies, old_supply, size);
 
 	data->new_opp.rate = freq;
 	memcpy(data->new_opp.supplies, new_supply, size);
@@ -943,6 +939,31 @@ int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_bw);
 
+static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
+{
+	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
+	unsigned long freq;
+
+	if (!IS_ERR(opp_table->clk)) {
+		freq = clk_get_rate(opp_table->clk);
+		opp = _find_freq_ceil(opp_table, &freq);
+	}
+
+	/*
+	 * Unable to find the current OPP ? Pick the first from the list since
+	 * it is in ascending order, otherwise rest of the code will need to
+	 * make special checks to validate current_opp.
+	 */
+	if (IS_ERR(opp)) {
+		mutex_lock(&opp_table->lock);
+		opp = list_first_entry(&opp_table->opp_list, struct dev_pm_opp, node);
+		dev_pm_opp_get(opp);
+		mutex_unlock(&opp_table->lock);
+	}
+
+	opp_table->current_opp = opp;
+}
+
 static int _disable_opp_table(struct device *dev, struct opp_table *opp_table)
 {
 	int ret;
@@ -1004,16 +1025,6 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	if ((long)freq <= 0)
 		freq = target_freq;
 
-	old_freq = clk_get_rate(opp_table->clk);
-
-	/* Return early if nothing to do */
-	if (opp_table->enabled && old_freq == freq) {
-		dev_dbg(dev, "%s: old/new frequencies (%lu Hz) are same, nothing to do\n",
-			__func__, freq);
-		ret = 0;
-		goto put_opp_table;
-	}
-
 	/*
 	 * For IO devices which require an OPP on some platforms/SoCs
 	 * while just needing to scale the clock on some others
@@ -1026,12 +1037,9 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		goto put_opp_table;
 	}
 
-	temp_freq = old_freq;
-	old_opp = _find_freq_ceil(opp_table, &temp_freq);
-	if (IS_ERR(old_opp)) {
-		dev_err(dev, "%s: failed to find current OPP for freq %lu (%ld)\n",
-			__func__, old_freq, PTR_ERR(old_opp));
-	}
+	/* Find the currently set OPP if we don't know already */
+	if (unlikely(!opp_table->current_opp))
+		_find_current_opp(dev, opp_table);
 
 	temp_freq = freq;
 	opp = _find_freq_ceil(opp_table, &temp_freq);
@@ -1039,7 +1047,17 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		ret = PTR_ERR(opp);
 		dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",
 			__func__, freq, ret);
-		goto put_old_opp;
+		goto put_opp_table;
+	}
+
+	old_opp = opp_table->current_opp;
+	old_freq = old_opp->rate;
+
+	/* Return early if nothing to do */
+	if (opp_table->enabled && old_opp == opp) {
+		dev_dbg(dev, "%s: OPPs are same, nothing to do\n", __func__);
+		ret = 0;
+		goto put_opp;
 	}
 
 	dev_dbg(dev, "%s: switching OPP: %lu Hz --> %lu Hz\n", __func__,
@@ -1054,11 +1072,10 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	if (opp_table->set_opp) {
 		ret = _set_opp_custom(opp_table, dev, old_freq, freq,
-				      IS_ERR(old_opp) ? NULL : old_opp->supplies,
-				      opp->supplies);
+				      old_opp->supplies, opp->supplies);
 	} else if (opp_table->regulators) {
 		ret = _generic_set_opp_regulator(opp_table, dev, old_freq, freq,
-						 IS_ERR(old_opp) ? NULL : old_opp->supplies,
+						 old_opp->supplies,
 						 opp->supplies);
 	} else {
 		/* Only frequency scaling */
@@ -1074,15 +1091,18 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	if (!ret) {
 		ret = _set_opp_bw(opp_table, opp, dev, false);
-		if (!ret)
+		if (!ret) {
 			opp_table->enabled = true;
+			dev_pm_opp_put(old_opp);
+
+			/* Make sure current_opp doesn't get freed */
+			dev_pm_opp_get(opp);
+			opp_table->current_opp = opp;
+		}
 	}
 
 put_opp:
 	dev_pm_opp_put(opp);
-put_old_opp:
-	if (!IS_ERR(old_opp))
-		dev_pm_opp_put(old_opp);
 put_opp_table:
 	dev_pm_opp_put_opp_table(opp_table);
 	return ret;
@@ -1276,6 +1296,9 @@ static void _opp_table_kref_release(struct kref *kref)
 	list_del(&opp_table->node);
 	mutex_unlock(&opp_table_lock);
 
+	if (opp_table->current_opp)
+		dev_pm_opp_put(opp_table->current_opp);
+
 	_of_clear_opp_table(opp_table);
 
 	/* Release clk */
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 4408cfcb0f31..359fd89d5770 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -135,6 +135,7 @@ enum opp_table_access {
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
  * @parsed_static_opps: Count of devices for which OPPs are initialized from DT.
  * @shared_opp: OPP is shared between multiple devices.
+ * @current_opp: Currently configured OPP for the table.
  * @suspend_opp: Pointer to OPP to be used during device suspend.
  * @genpd_virt_dev_lock: Mutex protecting the genpd virtual device pointers.
  * @genpd_virt_devs: List of virtual devices for multiple genpd support.
@@ -183,6 +184,7 @@ struct opp_table {
 
 	unsigned int parsed_static_opps;
 	enum opp_table_access shared_opp;
+	struct dev_pm_opp *current_opp;
 	struct dev_pm_opp *suspend_opp;
 
 	struct mutex genpd_virt_dev_lock;
-- 
2.25.0.rc1.19.g042ed3e048af

