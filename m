Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A44C243356
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 06:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHME3W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 00:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgHME3V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 00:29:21 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BE1C061757
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 21:29:21 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y206so2150379pfb.10
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 21:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=FnqSmZl+R1cGEwJxsBmPrjhnE5qy7kpLT7a0PkymWnw=;
        b=BPdliqHQ2ac8a7pDlzzKWFbfJ7zncwNDnULEgX3wbaKLhjzg2QdF/0gtOmzTTYuAp3
         8mTDmClt4jyQJN0kSTsNE7PoI6Re7qQWNqKIQtkHXtaFLeGx+g8KoXteYTQyONnYSWom
         fQXfY+X5oBNxy7r/JFqmEgje4ndjG0/J12iQVbhdgCJVPM7FX1EE64/dOhY/N6qmg686
         YFf6Pu7Mj2gpfvmbQOM635n01REzkt/liLaHUJYO9EdoInCA+6RazqqkyRi95QI5ScF4
         ehUCXXEaLTlyJT/7TzPmqiTfEfHuEzM87KvtXDSNKdBVO0b85ikaDYwKNXCBvJhCBp2o
         /FOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FnqSmZl+R1cGEwJxsBmPrjhnE5qy7kpLT7a0PkymWnw=;
        b=l92nVmqEGSOx/SwIZTNhvt12j7r55KYOk3KXJNTQwblPPsFO/LJH3tjeGR1fv2dQF+
         ZSXqpp455QZbp6vU1jo1mfUXZvWOctFX2lyqw892KXuQqLRa0sjxD2dTKexMrUjtpjW+
         t54LswfcRsR8dPjfrJkJQr6rUkMx5NI8eTEnVRUrS6xJK6vRpidOi995ZIyD/b9lvk/m
         P5TPkw2qQpDTl2RaSFwFiuVQ+t/xNl8+vL77BDfswNWqf2/VGDe1q5UuPYMyw7Nk0oPx
         xSl9eD9P8Fb/pZozjhsSJ+1hBkRd0ZIWgiY+WMbt51+4AnZOyDAL8kcXSbkkZC9E0mNf
         UMgg==
X-Gm-Message-State: AOAM532NMuICCuevkTs0sfAiXC0MPam3/VEpUivkyqLHuRvziH6FaCSe
        VTZSNenFCjPCur+VErPdhz+7OQ==
X-Google-Smtp-Source: ABdhPJwUbcNskbln7q39WGxW03eKYAk9xV7qDYQ5I9I07Olq3qBYZsAv3kh0cyi6vifbhkVL8zR9eg==
X-Received: by 2002:a62:18c9:: with SMTP id 192mr2490337pfy.23.1597292960896;
        Wed, 12 Aug 2020 21:29:20 -0700 (PDT)
Received: from localhost ([171.79.32.211])
        by smtp.gmail.com with ESMTPSA id a17sm3792120pgi.26.2020.08.12.21.29.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Aug 2020 21:29:20 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, mka@chromium.org,
        sibis@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] opp: Reused enabled flag and remove regulator_enabled
Date:   Thu, 13 Aug 2020 09:59:00 +0530
Message-Id: <359b588928b7e58b009f786b17ddc088c6a7d18b.1597292833.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org>
References: <1597043179-17903-1-git-send-email-rnayak@codeaurora.org>
 <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org>
In-Reply-To: <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org>
References: <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The common "enabled" flag can be used here instead of
"regulator_enabled" now.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 13 +++----------
 drivers/opp/opp.h  |  2 --
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e8882e7fd8a5..5f5da257f58a 100644
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
@@ -905,10 +903,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		if (ret)
 			goto put_opp_table;
 
-		if (opp_table->regulator_enabled) {
-			regulator_disable(opp_table->regulators[0]);
-			opp_table->regulator_enabled = false;
-		}
+		regulator_disable(opp_table->regulators[0]);
 
 		ret = _set_required_opps(dev, opp_table, NULL);
 		if (!ret)
@@ -1795,11 +1790,9 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
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
index bd35802acc6e..0c3de3f6db5c 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -147,7 +147,6 @@ enum opp_table_access {
  * @clk: Device's clock handle
  * @regulators: Supply regulators
  * @regulator_count: Number of power supply regulators. Its value can be -1
- * @regulator_enabled: Set to true if regulators were previously enabled.
  * (uninitialized), 0 (no opp-microvolt property) or > 0 (has opp-microvolt
  * property).
  * @paths: Interconnect path handles
@@ -196,7 +195,6 @@ struct opp_table {
 	struct clk *clk;
 	struct regulator **regulators;
 	int regulator_count;
-	bool regulator_enabled;
 	struct icc_path **paths;
 	unsigned int path_count;
 	bool enabled;
-- 
2.14.1

