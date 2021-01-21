Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1BC2FE92C
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 12:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbhAULrH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 06:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730223AbhAULVe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 06:21:34 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C42C0617A1
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:19:07 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id w18so1302910pfu.9
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QsvG3t6xFRgx0s76cOQVzbYkqHL9lM3bJ086HXut2lo=;
        b=W8sAOHZXGjGsUHf8lA5IP8zqppO9iNNGBAO/qkfocVkFGmZSsW/naH1YNTl0xP/gTa
         gY50hBXssIxtuU2G59zExSMtcwVt7utDVVzmh6u9fjrD+gxfwmaw+ao5wN7cr/pBoIw3
         oRUkfsAVRcuJw664wy7zI0ZnVC2itA4TtpRfrtC0Gl5gtFhl4IOvROR/LH20rudx7rlv
         gWtqNMLBkoXlXYJmuXSwOzf/XejjXh9qiAA0ZlrkJH/afNscVDAJM3rbqNgElgUCPqRm
         UBPCokJYgpbAq0qwbubfijtQgJxq9EDuL0R+iegFbZcUTi60rDsqp0znC1i8ZppPwSnH
         /QqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QsvG3t6xFRgx0s76cOQVzbYkqHL9lM3bJ086HXut2lo=;
        b=cKqX6LzbRNUn2S3TGyJ5kjauaIydodz+Pi0HjjqPn+hXlwZYeSGnOT5Nt8GPFyXBm3
         pNqgUXXUnh1zuecZCRZanakqelXcGsH+w26LoGab3iiPeJowU4BUiJ3cBHL+3IVA7hzr
         xzdujxLV5NYKLjpIMtr9UAaMYma/MIn95u8i5dTtbk4cFtAUNQsQbJ3DA7nAcXnJGJUb
         CKerYwDcD2HOUC99tjre/uTSGV7z0iWozm5Sd0EhcyRYt4+21ADIbdxIA6ZASlXhYDS+
         TqKH6Ey1/AecleD4Lw0jhfbGdrSGkyrJed2AmKC/Yqerc+ixZICSDS3PxzF3I3Y9h0Bx
         jH/g==
X-Gm-Message-State: AOAM530xOKwH4DeOIbL5BLWmFHF6pdnK/yZ7BTU6Q5xEgr0IfL+acNOp
        CYQoxiqCJkgw92mIaFZZtKWqfw==
X-Google-Smtp-Source: ABdhPJy5sX9QMNxrrbhz8F+SIc0A20khl+IXc6z8UY/zsrD3/92c9hrmIh3MhaQyDhyT3bApnJ9r9g==
X-Received: by 2002:a65:6542:: with SMTP id a2mr13920489pgw.148.1611227946652;
        Thu, 21 Jan 2021 03:19:06 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id gk2sm5826702pjb.6.2021.01.21.03.19.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 03:19:06 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/13] opp: Update parameters of  _set_opp_custom()
Date:   Thu, 21 Jan 2021 16:47:48 +0530
Message-Id: <296a3a64a673ed3eb261a6fc06f4dfd90dbca479.1611227342.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611227342.git.viresh.kumar@linaro.org>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Drop the unnecessary parameters and follow the pattern from
_generic_set_opp_regulator().

While at it, also remove the local variable old_freq.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 6b09d468d37a..3500cc9de66b 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -826,11 +826,10 @@ static int _set_opp_bw(const struct opp_table *opp_table,
 }
 
 static int _set_opp_custom(const struct opp_table *opp_table,
-			   struct device *dev, unsigned long old_freq,
-			   unsigned long freq,
-			   struct dev_pm_opp_supply *old_supply,
-			   struct dev_pm_opp_supply *new_supply)
+			   struct device *dev, struct dev_pm_opp *opp,
+			   unsigned long freq)
 {
+	struct dev_pm_opp *old_opp = opp_table->current_opp;
 	struct dev_pm_set_opp_data *data;
 	int size;
 
@@ -840,12 +839,12 @@ static int _set_opp_custom(const struct opp_table *opp_table,
 	data->clk = opp_table->clk;
 	data->dev = dev;
 
-	data->old_opp.rate = old_freq;
-	size = sizeof(*old_supply) * opp_table->regulator_count;
-	memcpy(data->old_opp.supplies, old_supply, size);
+	data->old_opp.rate = old_opp->rate;
+	size = sizeof(*old_opp->supplies) * opp_table->regulator_count;
+	memcpy(data->old_opp.supplies, old_opp->supplies, size);
 
 	data->new_opp.rate = freq;
-	memcpy(data->new_opp.supplies, new_supply, size);
+	memcpy(data->new_opp.supplies, opp->supplies, size);
 
 	return opp_table->set_opp(data);
 }
@@ -1000,7 +999,6 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 		    struct dev_pm_opp *opp, unsigned long freq)
 {
 	struct dev_pm_opp *old_opp;
-	unsigned long old_freq;
 	int scaling_down, ret;
 
 	if (unlikely(!opp))
@@ -1011,7 +1009,6 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 		_find_current_opp(dev, opp_table);
 
 	old_opp = opp_table->current_opp;
-	old_freq = old_opp->rate;
 
 	/* Return early if nothing to do */
 	if (opp_table->enabled && old_opp == opp) {
@@ -1020,7 +1017,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 	}
 
 	dev_dbg(dev, "%s: switching OPP: Freq %lu -> %lu Hz, Level %u -> %u, Bw %u -> %u\n",
-		__func__, old_freq, freq, old_opp->level, opp->level,
+		__func__, old_opp->rate, freq, old_opp->level, opp->level,
 		old_opp->bandwidth ? old_opp->bandwidth[0].peak : 0,
 		opp->bandwidth ? opp->bandwidth[0].peak : 0);
 
@@ -1036,8 +1033,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 	}
 
 	if (opp_table->set_opp) {
-		ret = _set_opp_custom(opp_table, dev, old_freq, freq,
-				      old_opp->supplies, opp->supplies);
+		ret = _set_opp_custom(opp_table, dev, opp, freq);
 	} else if (opp_table->regulators) {
 		ret = _generic_set_opp_regulator(opp_table, dev, opp, freq,
 						 scaling_down);
-- 
2.25.0.rc1.19.g042ed3e048af

