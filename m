Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E3024B0A3
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 09:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgHTH5J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 03:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgHTH4o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 03:56:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E615AC061386
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 00:56:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h2so679057plr.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 00:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xmu7H0E+tFg4FErq7QIubnUbkqLX4YsFmMjBv8snFjM=;
        b=XeiN7jhzKtl+qc8zYJeYP04FEkec+TZuADSi0PKem0kyofYbjO4yrpZIEMlrJHIQR7
         mj5Esq/GTfN/ZYF9OXmHMeIDIEjaLrFoXuYn7idXzBm3Nquh1dSU9enaxPZAjA/JYcdn
         C5LMaanseLjriumFoBuVFmsBjF0KyB2MR11rKB9+NZ/dKVQTvxy7KcT3Tw4lOJ4VDQdo
         oLj39R9AGF900jmwJp49Dodn8o+o5FwO9f7uu6QGtQESBGxtN0RxB5tZC2ZP05Oxhckq
         Hd5TEsf4yTk7fZ/Y9de8Ka6RiGaXIy0lCItr2P8hHkPOqPCvhV3LH5fZZ8BnLnS/ky2b
         Ig8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xmu7H0E+tFg4FErq7QIubnUbkqLX4YsFmMjBv8snFjM=;
        b=JF2S3f13XXGxlCWKXIYXdfnCyG+s7vpgMfNAynaB2CYrSFfWcwfvhu0QVQPzpU/aVb
         nRyV1ZbeIi/C7VQDid93mlmYpYB8oZoJ2ZDibbz2fkVegHr6Cu36kSkpBCcShLqNJwDK
         PlVKeF96ldLWX1N7ZqH+j/pcCFfWudcajgWRZ3tpQEkzTtbKxOCZCGMuh2h1ZeqhizES
         YyOiW97+zSxEHoEWBlR+tzfM6cHc56cihIDtMPJsVco85Zi2qfEyVR+yGvwMDH8XB2U0
         K/xoxgeOQusEhD2AztMtgojbAysBVcX2m+teT8EngWYBIX+JFoDwgA+AvzWY2UVd5rBB
         ogug==
X-Gm-Message-State: AOAM533bPl2v7slkPZiF2xhlioTJZwGR4T5fJ2Cv8OM+EqxYJGES3saI
        DwVNJkg2ldiu0K0voHRy+2FfLQ==
X-Google-Smtp-Source: ABdhPJyAvAYnc5QIqJi41Th1jUA4+WoiklJUB5kqWpWjYvrHM4DPKLUuw4aNfDM/Y/rRLlRwJJlP2A==
X-Received: by 2002:a17:902:a585:: with SMTP id az5mr1692694plb.172.1597910203441;
        Thu, 20 Aug 2020 00:56:43 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id f6sm1777666pfa.23.2020.08.20.00.56.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 00:56:42 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, sibis@codeaurora.org,
        sbhanu@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/4] opp: Rename regulator_enabled and use it as status of all resources
Date:   Thu, 20 Aug 2020 13:26:31 +0530
Message-Id: <38740bd2a53a0f4778e9a8719ac2c590423f745a.1597909885.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1597909885.git.viresh.kumar@linaro.org>
References: <cover.1597909885.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Expand the scope of the regulator_enabled flag and use it to track
status of all the resources. This will be used for other stuff in the
next patch.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 19 +++++++++----------
 drivers/opp/opp.h  |  4 ++--
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 9668ea04cc80..6f43ef4945b7 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -703,12 +703,10 @@ static int _generic_set_opp_regulator(struct opp_table *opp_table,
 	 * Enable the regulator after setting its voltages, otherwise it breaks
 	 * some boot-enabled regulators.
 	 */
-	if (unlikely(!opp_table->regulator_enabled)) {
+	if (unlikely(!opp_table->enabled)) {
 		ret = regulator_enable(reg);
 		if (ret < 0)
 			dev_warn(dev, "Failed to enable regulator: %d", ret);
-		else
-			opp_table->regulator_enabled = true;
 	}
 
 	return 0;
@@ -909,12 +907,12 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		if (ret)
 			goto put_opp_table;
 
-		if (opp_table->regulator_enabled) {
+		if (opp_table->regulators)
 			regulator_disable(opp_table->regulators[0]);
-			opp_table->regulator_enabled = false;
-		}
 
 		ret = _set_required_opps(dev, opp_table, NULL);
+
+		opp_table->enabled = false;
 		goto put_opp_table;
 	}
 
@@ -1001,8 +999,11 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 			dev_err(dev, "Failed to set required opps: %d\n", ret);
 	}
 
-	if (!ret)
+	if (!ret) {
 		ret = _set_opp_bw(opp_table, opp, dev, false);
+		if (!ret)
+			opp_table->enabled = true;
+	}
 
 put_opp:
 	dev_pm_opp_put(opp);
@@ -1796,11 +1797,9 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
 	/* Make sure there are no concurrent readers while updating opp_table */
 	WARN_ON(!list_empty(&opp_table->opp_list));
 
-	if (opp_table->regulator_enabled) {
+	if (opp_table->enabled) {
 		for (i = opp_table->regulator_count - 1; i >= 0; i--)
 			regulator_disable(opp_table->regulators[i]);
-
-		opp_table->regulator_enabled = false;
 	}
 
 	for (i = opp_table->regulator_count - 1; i >= 0; i--)
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index e51646ff279e..0c3de3f6db5c 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -147,11 +147,11 @@ enum opp_table_access {
  * @clk: Device's clock handle
  * @regulators: Supply regulators
  * @regulator_count: Number of power supply regulators. Its value can be -1
- * @regulator_enabled: Set to true if regulators were previously enabled.
  * (uninitialized), 0 (no opp-microvolt property) or > 0 (has opp-microvolt
  * property).
  * @paths: Interconnect path handles
  * @path_count: Number of interconnect paths
+ * @enabled: Set to true if the device's resources are enabled/configured.
  * @genpd_performance_state: Device's power domain support performance state.
  * @is_genpd: Marks if the OPP table belongs to a genpd.
  * @set_opp: Platform specific set_opp callback
@@ -195,9 +195,9 @@ struct opp_table {
 	struct clk *clk;
 	struct regulator **regulators;
 	int regulator_count;
-	bool regulator_enabled;
 	struct icc_path **paths;
 	unsigned int path_count;
+	bool enabled;
 	bool genpd_performance_state;
 	bool is_genpd;
 
-- 
2.25.0.rc1.19.g042ed3e048af

