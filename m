Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64482FE974
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 12:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbhAUL6I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 06:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbhAULUp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 06:20:45 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BF5C061798
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:18:55 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id be12so1115138plb.4
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yGSozZ62BYCUnvHz15lG2EnbQmWJ88vlwijLJGHrCgo=;
        b=jMznsEDClSg4+xGGHd4ynKf8aBhP9BTp/c1fcRIW0bwCmouHvmrSfMLRDtlokUPLPV
         7uZ6cisbhC2/bCQhc1Sf8gCz0qzy7gUIZQPY641HZOSD9Ne58dPVd1v3P52FQQFJDQ5r
         BIEh2MsMfTZXAeF2tHcy4OjrZF5MSsSSxlisois1xZMV8twzKfyA/YgxLL7chity4eV6
         HqMTn0S0YphcvWIdJERsciBUfz3VyFW4wXWKZaGZwJW8ZeXt2D84zqcdL5KTQc00Owqp
         EKOGoSCDNRgLk8dZXgxqPtahXM2N2MsO9eo7nghpRuI4W7dDgRIhCNczCqPqveO8WmTe
         iNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yGSozZ62BYCUnvHz15lG2EnbQmWJ88vlwijLJGHrCgo=;
        b=Ij0IynPHyPEfb67kUA/hjhinZzWKmWju0Ta2EWljmxjEZkijMrkGuZuqbn1hbXSA2p
         Kx09HKFMBvmt9qs8VJB7gdFRPGMdIvSqGpGiGdht9vsgFPaMUdogx6pMKl+ztUWyd9PE
         GFlkNQZMrHGOVH+IcL05q8gesbuM3TfQSPHC4zRuoJtHQi3R4UFm1L6DPc6m3BvcRLu2
         ELDSbsZJvouLr2fBzyckvIzZXJaCSPBHpRR7Eu9Mq2E9k8aqhA1I1qVsDeL2TBkrRbwL
         r9iDk3LUszJLq5Eiz1bAE5ugChteO1Y7iZsJwLGdYc08Sz8zqFuE/HmGVTDWky5+//eJ
         wIfA==
X-Gm-Message-State: AOAM530dRGw3b1BCX8KJI2rbiOqbzvawWr4JlQg4yifNFTz1q/PaAQrd
        9IcpoyB36Hp5l7/parOEo+6Y/A==
X-Google-Smtp-Source: ABdhPJxCDceYWRati28gRyR2MZg5jIN0/VdJ4+0q1+AusUpULOSN9NiaiWRtWjYKJucbY9Swc+dQTw==
X-Received: by 2002:a17:90a:2947:: with SMTP id x7mr11321170pjf.157.1611227934689;
        Thu, 21 Jan 2021 03:18:54 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id g5sm5980697pfb.194.2021.01.21.03.18.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 03:18:54 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/13] opp: Split _set_opp() out of dev_pm_opp_set_rate()
Date:   Thu, 21 Jan 2021 16:47:44 +0530
Message-Id: <c6eed208018610123c451d4dd0b2583046c5e294.1611227342.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611227342.git.viresh.kumar@linaro.org>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The _set_opp() helper will be used for devices which don't change their
frequency (like power domains, etc.) later on, prepare for that by
breaking the generic part out of dev_pm_opp_set_rate().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 126 +++++++++++++++++++++++++--------------------
 1 file changed, 71 insertions(+), 55 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 4ee598344e6a..5313dc322bdd 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -992,72 +992,27 @@ static int _disable_opp_table(struct device *dev, struct opp_table *opp_table)
 	return ret;
 }
 
-/**
- * dev_pm_opp_set_rate() - Configure new OPP based on frequency
- * @dev:	 device for which we do this operation
- * @target_freq: frequency to achieve
- *
- * This configures the power-supplies to the levels specified by the OPP
- * corresponding to the target_freq, and programs the clock to a value <=
- * target_freq, as rounded by clk_round_rate(). Device wanting to run at fmax
- * provided by the opp, should have already rounded to the target OPP's
- * frequency.
- */
-int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
+static int _set_opp(struct device *dev, struct opp_table *opp_table,
+		    struct dev_pm_opp *opp, unsigned long freq)
 {
-	struct opp_table *opp_table;
-	unsigned long freq, old_freq, temp_freq;
-	struct dev_pm_opp *old_opp, *opp;
+	struct dev_pm_opp *old_opp;
+	unsigned long old_freq;
 	int ret;
 
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table)) {
-		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
-		return PTR_ERR(opp_table);
-	}
-
-	if (unlikely(!target_freq)) {
-		ret = _disable_opp_table(dev, opp_table);
-		goto put_opp_table;
-	}
-
-	freq = clk_round_rate(opp_table->clk, target_freq);
-	if ((long)freq <= 0)
-		freq = target_freq;
-
-	/*
-	 * For IO devices which require an OPP on some platforms/SoCs
-	 * while just needing to scale the clock on some others
-	 * we look for empty OPP tables with just a clock handle and
-	 * scale only the clk. This makes dev_pm_opp_set_rate()
-	 * equivalent to a clk_set_rate()
-	 */
-	if (!_get_opp_count(opp_table)) {
-		ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
-		goto put_opp_table;
-	}
+	if (unlikely(!opp))
+		return _disable_opp_table(dev, opp_table);
 
 	/* Find the currently set OPP if we don't know already */
 	if (unlikely(!opp_table->current_opp))
 		_find_current_opp(dev, opp_table);
 
-	temp_freq = freq;
-	opp = _find_freq_ceil(opp_table, &temp_freq);
-	if (IS_ERR(opp)) {
-		ret = PTR_ERR(opp);
-		dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",
-			__func__, freq, ret);
-		goto put_opp_table;
-	}
-
 	old_opp = opp_table->current_opp;
 	old_freq = old_opp->rate;
 
 	/* Return early if nothing to do */
 	if (opp_table->enabled && old_opp == opp) {
 		dev_dbg(dev, "%s: OPPs are same, nothing to do\n", __func__);
-		ret = 0;
-		goto put_opp;
+		return 0;
 	}
 
 	dev_dbg(dev, "%s: switching OPP: %lu Hz --> %lu Hz\n", __func__,
@@ -1067,7 +1022,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	if (freq >= old_freq) {
 		ret = _set_required_opps(dev, opp_table, opp, true);
 		if (ret)
-			goto put_opp;
+			return ret;
 	}
 
 	if (opp_table->set_opp) {
@@ -1101,8 +1056,69 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		}
 	}
 
-put_opp:
-	dev_pm_opp_put(opp);
+	return ret;
+}
+
+/**
+ * dev_pm_opp_set_rate() - Configure new OPP based on frequency
+ * @dev:	 device for which we do this operation
+ * @target_freq: frequency to achieve
+ *
+ * This configures the power-supplies to the levels specified by the OPP
+ * corresponding to the target_freq, and programs the clock to a value <=
+ * target_freq, as rounded by clk_round_rate(). Device wanting to run at fmax
+ * provided by the opp, should have already rounded to the target OPP's
+ * frequency.
+ */
+int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
+{
+	struct opp_table *opp_table;
+	unsigned long freq = 0, temp_freq;
+	struct dev_pm_opp *opp = NULL;
+	int ret;
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		dev_err(dev, "%s: device's opp table doesn't exist\n", __func__);
+		return PTR_ERR(opp_table);
+	}
+
+	if (target_freq) {
+		/*
+		 * For IO devices which require an OPP on some platforms/SoCs
+		 * while just needing to scale the clock on some others
+		 * we look for empty OPP tables with just a clock handle and
+		 * scale only the clk. This makes dev_pm_opp_set_rate()
+		 * equivalent to a clk_set_rate()
+		 */
+		if (!_get_opp_count(opp_table)) {
+			ret = _generic_set_opp_clk_only(dev, opp_table->clk, target_freq);
+			goto put_opp_table;
+		}
+
+		freq = clk_round_rate(opp_table->clk, target_freq);
+		if ((long)freq <= 0)
+			freq = target_freq;
+
+		/*
+		 * The clock driver may support finer resolution of the
+		 * frequencies than the OPP table, don't update the frequency we
+		 * pass to clk_set_rate() here.
+		 */
+		temp_freq = freq;
+		opp = _find_freq_ceil(opp_table, &temp_freq);
+		if (IS_ERR(opp)) {
+			ret = PTR_ERR(opp);
+			dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",
+				__func__, freq, ret);
+			goto put_opp_table;
+		}
+	}
+
+	ret = _set_opp(dev, opp_table, opp, freq);
+
+	if (opp)
+		dev_pm_opp_put(opp);
 put_opp_table:
 	dev_pm_opp_put_opp_table(opp_table);
 	return ret;
-- 
2.25.0.rc1.19.g042ed3e048af

