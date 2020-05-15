Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED50B1D477B
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 09:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgEOH5h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 03:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727116AbgEOH5g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 03:57:36 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1C5C05BD09
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 00:57:36 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g11so616568plp.1
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 00:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i82OIY1bYQbyJzRSDLLGone074RtLiKElmKq69ozmwo=;
        b=rchzu2MyGa3HyG/512UyVQcFwnXN1N1nsah8b+GSkQszpRWGuaiE4uwiOslb1NylNS
         q5Urs27/53sZjq57KD8ZcAu1OIvv/XArlobMbXhYVUu8jXlOhKw4slrY3UjYzBJF8iMC
         lUiglLAX8tHM7n8kuPkA5LbUgfeuqV27fvyZgHx0A+4H2gDHNe7K3KvtdAgZ+Q4hSDrh
         c6Ydrs5aPEY0IpLIIGmpUw8WD0JPQw6PnURPuFrxqGOBMgKtj5OgWInZMJFT98G0/rRD
         MQ/xN8LiROtmmkPlDRFvZjjIBzrrGx0l5VXAGaHjLWbauSzisC8qsjfzQ5gMZ+zBpBE3
         d3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i82OIY1bYQbyJzRSDLLGone074RtLiKElmKq69ozmwo=;
        b=mnGmO+tmuAX+NP1aSX9AiSeaVsDGpxlYaW/FyJOXE9dnPZbti5m9t2yomqSgffbt9R
         D2EBIPHLsPJUws/5ULgei5YKH12pbInRzBpwXOffRQX3a0nVhw/bAKdYHYTp+zZyydQJ
         ZObgtwSoo7WnS0E3rcLdudABszxFpffOei0caMFJEbslu0bbpVF25OuGGUfWlh6Gdmh0
         ziB92SlIga+nFijgi0B2AvqkDA6sGv84sB+ilEMtsUT1sgDU8ssqHoYG26aapcZKnamO
         ceOmdbWHGLOrtx7x5XZcXhWZPeKl3fmkqNYp5Ac48nyvcMA7GkbDDFU9QXAU8Qp8aDLI
         +MRw==
X-Gm-Message-State: AOAM531532wr8iVixb5lXxOHcK2V8ybLRSI47DSHhSfdUMrhjhjPUPJ6
        zfV0JtgFWgxRElV2Sej6AeefKw==
X-Google-Smtp-Source: ABdhPJwne+EPKn2djmWv8FItxoMi+OtCkrj/QUPK/4bzdDvflDHpDZXhuSrh/+p6cZXR+cwCcluF6g==
X-Received: by 2002:a17:90a:d703:: with SMTP id y3mr2076859pju.75.1589529455681;
        Fri, 15 May 2020 00:57:35 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id i14sm1272294pfo.162.2020.05.15.00.57.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2020 00:57:35 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     k.konieczny@samsung.com, peron.clem@gmail.com,
        m.szyprowski@samsung.com, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] opp: core: add regulators enable and disable
Date:   Fri, 15 May 2020 13:27:21 +0530
Message-Id: <81eb2efeeed1556d124065252f32777838a6d850.1589528491.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1589528491.git.viresh.kumar@linaro.org>
References: <cover.1589528491.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Kamil Konieczny <k.konieczny@samsung.com>

Add enable regulators to dev_pm_opp_set_regulators() and disable
regulators to dev_pm_opp_put_regulators(). Even if bootloader
leaves regulators enabled, they should be enabled in kernel in
order to increase the reference count.

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
[ Viresh: Enable the regulator only after it is programmed and add a
	  flag to track its status. ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 28 ++++++++++++++++++++++++++--
 drivers/opp/opp.h  |  2 ++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index dda8164fad56..da6533d5526f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -664,7 +664,7 @@ static inline int _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
 	return ret;
 }
 
-static int _generic_set_opp_regulator(const struct opp_table *opp_table,
+static int _generic_set_opp_regulator(struct opp_table *opp_table,
 				      struct device *dev,
 				      unsigned long old_freq,
 				      unsigned long freq,
@@ -699,6 +699,18 @@ static int _generic_set_opp_regulator(const struct opp_table *opp_table,
 			goto restore_freq;
 	}
 
+	/*
+	 * Enable the regulator after setting its voltages, otherwise it breaks
+	 * some boot-enabled regulators.
+	 */
+	if (unlikely(!opp_table->regulator_enabled)) {
+		ret = regulator_enable(reg);
+		if (ret < 0)
+			dev_warn(dev, "Failed to enable regulator: %d", ret);
+		else
+			opp_table->regulator_enabled = true;
+	}
+
 	return 0;
 
 restore_freq:
@@ -825,11 +837,16 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		if (!_get_opp_count(opp_table))
 			return 0;
 
-		if (!opp_table->required_opp_tables) {
+		if (!opp_table->required_opp_tables && !opp_table->regulators) {
 			dev_err(dev, "target frequency can't be 0\n");
 			ret = -EINVAL;
 		}
 
+		if (opp_table->regulator_enabled) {
+			regulator_disable(opp_table->regulators[0]);
+			opp_table->regulator_enabled = false;
+		}
+
 		ret = _set_required_opps(dev, opp_table, NULL);
 		goto put_opp_table;
 	}
@@ -1675,6 +1692,13 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
 	/* Make sure there are no concurrent readers while updating opp_table */
 	WARN_ON(!list_empty(&opp_table->opp_list));
 
+	if (opp_table->regulator_enabled) {
+		for (i = opp_table->regulator_count - 1; i >= 0; i--)
+			regulator_disable(opp_table->regulators[i]);
+
+		opp_table->regulator_enabled = false;
+	}
+
 	for (i = opp_table->regulator_count - 1; i >= 0; i--)
 		regulator_put(opp_table->regulators[i]);
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index d14e27102730..b4b2713d84f1 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -144,6 +144,7 @@ enum opp_table_access {
  * @clk: Device's clock handle
  * @regulators: Supply regulators
  * @regulator_count: Number of power supply regulators. Its value can be -1
+ * @regulator_enabled: Set to true if regulators were previously enabled.
  * (uninitialized), 0 (no opp-microvolt property) or > 0 (has opp-microvolt
  * property).
  * @genpd_performance_state: Device's power domain support performance state.
@@ -189,6 +190,7 @@ struct opp_table {
 	struct clk *clk;
 	struct regulator **regulators;
 	int regulator_count;
+	bool regulator_enabled;
 	bool genpd_performance_state;
 	bool is_genpd;
 
-- 
2.25.0.rc1.19.g042ed3e048af

