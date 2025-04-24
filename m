Return-Path: <linux-pm+bounces-26115-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8E6A9AAA4
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 12:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E9B3A577B
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 10:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEF623D29D;
	Thu, 24 Apr 2025 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hwZy63hQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F7723D283
	for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491043; cv=none; b=iLIcqdJN+AwBp6waUVx5yB+hYZ79lll4nPyPTisQK5EX6whjCsKixmcoEpuIucSHnmZXvpMIucH8pvf7+zKAoJh7Q7ML25h7llP3LVwYUsyj9g+Bgk6voEAZUjtasokHFNoKI+EaQSe7Kd14Lh6fyPMlhYL1VsRX9aKlVvevlM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491043; c=relaxed/simple;
	bh=UIhihO+KSlk84fI+BFSWcB1XVu68h01gI8MX+i/A85Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gHJsVvnrYPKzgFZzXFZqQHFzyXDDdy7SetcdmPe2Tyz+ti5u++AzEoTdJubbfR9VJGCLSSVFc7cVaaKnFZsG0CyYVPIsMr4qQLBgcIc54D3kyNxQkHObFeLtrqoNtRfPN7NqH/3N9tWUb3ieHICD3vm8YY2kKnp+AmJtM8zC0GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hwZy63hQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22409077c06so12565065ad.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 03:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745491040; x=1746095840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWVroK7uqi5IEJnUfPHoEkoDsKi7RyYwEa+CnjAgxus=;
        b=hwZy63hQZwUT9lz37EC6GjOLUpya01qRTYkk46zXD06Q3Q50kZ8WGvO6BqmWOPM1Qx
         UA7kTXW2Rc/T0Isny2VbZFVh3mob2oR5jdLgoNkd2PyxtFCYV4ReSImVFpeM5nEOR7YK
         qOjw2+5N86grqWJvjeNUlPvrTbVnslZmqagy4EFp7N1HE8wDwBAQs6SeJRcqQn6LItSj
         X0WGcLs511d/8dKtgX4NmbWbRHcC4wlpIVx63iyKyBYBPCPxOLCxgH/RRgT8ubD0jm9f
         RmohfKPbv67N33IsuREynPz5JxYFQi77snXJgsr3d1XXum7vCNJ1MkTsj5Bv9HAqE4Uf
         gqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745491040; x=1746095840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWVroK7uqi5IEJnUfPHoEkoDsKi7RyYwEa+CnjAgxus=;
        b=pnQ/HldkyPCTfHEbyXKADsfsIs7AfY8RHU3VMN0k3ZJg6ebMvwBApp8wcMUQsgbCwu
         RPzMvWttWdsUxtaguYf1TymBY0Uf3Cj/a5qEuF5xI7D9H6Ccg/HHtHHWCdXqq9XZAW+L
         kQIoPaxS0z/ilDJddN/IgNSavHy5LuKxyQPazQQGOROV5ewDW+t3zbG61rBF0T0D4/KJ
         g5t6+j/a5uM7+PkXzWykLxnsRh3j+DG/Wmti72h/O/2FR1xKjMv6jYEe2ITSOeNe4ff+
         q1LPYYVUaljmJW3wOPOcSXTVUv5ktYbKuvxQFY9PanX0YeUD0FeUrbX5mTqkT/uu3NNp
         4H1A==
X-Forwarded-Encrypted: i=1; AJvYcCWXXQPFIKDzAMsuLNBITPVTF4BnAfxzMPguHLtD0PXnFO5IPVbdU5eiBTV3eJNO45Mmq5ovY77Y/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDrHLlrH144Xlv/oxBYQqG+dzG9IT7NnQcD+Iog4rhY1Zv7b2W
	/Pry2Iz8pRWojLH77iwERoAI6WedsOHd94ifWpPEl5b82dhnLJnSCQ7/Cq56w9A=
X-Gm-Gg: ASbGncsOrRG+e4TKOrMzncDDw7i2fDDqu5SUlR2lXJWFE7POAzTmWTcVMVkQOq7M1VW
	ycuVbxukVO7d69+Zb2pnqtwS5rxJNdrpRxkehOAscNaJ0D0Knx9cvw11ewVW4G3NhVFvPXaYMII
	KoZi4sKVdmintGeT+EjaZjERxQj91fiq0u3CP1lhqXt7Qyctngxl1TBUW1j9OJufNo5HW15kzAk
	8nPk5TebQOLJocQTl0pEW7WpsPwVwtW0pF8AL/VZAiBS2K4lCcGMCmRL+3RFgKjgwfi9ANorf76
	8spTM6Kr4AKBZwGXBoM/UU2P0mTRM8eOC9/wYCs2Sg==
X-Google-Smtp-Source: AGHT+IFtkyIv19VH4ZqdUc9coJM/UdcvKr/acvdXxMY9KrQZhZFnapOrBvqfiYotRgy3+oauDgRFTA==
X-Received: by 2002:a17:903:24a:b0:223:668d:eba9 with SMTP id d9443c01a7336-22db3bb6f7dmr33678345ad.10.1745491040511;
        Thu, 24 Apr 2025 03:37:20 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f76f582csm908421a12.4.2025.04.24.03.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:37:20 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] OPP: Define and use scope-based cleanup helpers
Date: Thu, 24 Apr 2025 16:06:48 +0530
Message-Id: <5330d0dab7367f7e17911dfa82a6712de27aa968.1745490980.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1745490980.git.viresh.kumar@linaro.org>
References: <cover.1745490980.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define and use scope-based cleanup helpers for `struct opp` and `struct
opp_table`.

No intentional functional impact.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 236 ++++++++++++++---------------------------
 drivers/opp/cpu.c      |  27 ++---
 drivers/opp/of.c       |  24 ++---
 include/linux/pm_opp.h |   7 ++
 4 files changed, 102 insertions(+), 192 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 14fb0f43cc77..87d27132cd87 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -317,18 +317,13 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_is_turbo);
  */
 unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
 {
-	struct opp_table *opp_table;
-	unsigned long clock_latency_ns;
+	struct opp_table *opp_table __free(put_opp_table);
 
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return 0;
 
-	clock_latency_ns = opp_table->clock_latency_ns_max;
-
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return clock_latency_ns;
+	return opp_table->clock_latency_ns_max;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_clock_latency);
 
@@ -340,7 +335,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_clock_latency);
  */
 unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 {
-	struct opp_table *opp_table;
+	struct opp_table *opp_table __free(put_opp_table);
 	struct dev_pm_opp *opp;
 	struct regulator *reg;
 	unsigned long latency_ns = 0;
@@ -356,13 +351,13 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 
 	/* Regulator may not be required for the device */
 	if (!opp_table->regulators)
-		goto put_opp_table;
+		return 0;
 
 	count = opp_table->regulator_count;
 
 	uV = kmalloc_array(count, sizeof(*uV), GFP_KERNEL);
 	if (!uV)
-		goto put_opp_table;
+		return 0;
 
 	mutex_lock(&opp_table->lock);
 
@@ -395,8 +390,6 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 	}
 
 	kfree(uV);
-put_opp_table:
-	dev_pm_opp_put_opp_table(opp_table);
 
 	return latency_ns;
 }
@@ -426,7 +419,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_transition_latency);
  */
 unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
 {
-	struct opp_table *opp_table;
+	struct opp_table *opp_table __free(put_opp_table);
 	unsigned long freq = 0;
 
 	opp_table = _find_opp_table(dev);
@@ -436,8 +429,6 @@ unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
 	if (opp_table->suspend_opp && opp_table->suspend_opp->available)
 		freq = dev_pm_opp_get_freq(opp_table->suspend_opp);
 
-	dev_pm_opp_put_opp_table(opp_table);
-
 	return freq;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_freq);
@@ -468,21 +459,16 @@ int _get_opp_count(struct opp_table *opp_table)
  */
 int dev_pm_opp_get_opp_count(struct device *dev)
 {
-	struct opp_table *opp_table;
-	int count;
+	struct opp_table *opp_table __free(put_opp_table);
 
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
-		count = PTR_ERR(opp_table);
-		dev_dbg(dev, "%s: OPP table not found (%d)\n",
-			__func__, count);
-		return count;
+		dev_dbg(dev, "%s: OPP table not found (%ld)\n",
+			__func__, PTR_ERR(opp_table));
+		return PTR_ERR(opp_table);
 	}
 
-	count = _get_opp_count(opp_table);
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return count;
+	return _get_opp_count(opp_table);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
 
@@ -576,8 +562,7 @@ _find_key(struct device *dev, unsigned long *key, int index, bool available,
 			  unsigned long opp_key, unsigned long key),
 	  bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
-	struct opp_table *opp_table;
-	struct dev_pm_opp *opp;
+	struct opp_table *opp_table __free(put_opp_table);
 
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
@@ -586,12 +571,8 @@ _find_key(struct device *dev, unsigned long *key, int index, bool available,
 		return ERR_CAST(opp_table);
 	}
 
-	opp = _opp_table_find_key(opp_table, key, index, available, read,
-				  compare, assert);
-
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return opp;
+	return _opp_table_find_key(opp_table, key, index, available, read,
+				   compare, assert);
 }
 
 static struct dev_pm_opp *_find_key_exact(struct device *dev,
@@ -1345,11 +1326,10 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
  */
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
-	struct opp_table *opp_table;
+	struct opp_table *opp_table __free(put_opp_table);
+	struct dev_pm_opp *opp __free(put_opp) = NULL;
 	unsigned long freq = 0, temp_freq;
-	struct dev_pm_opp *opp = NULL;
 	bool forced = false;
-	int ret;
 
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
@@ -1366,9 +1346,8 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		 * equivalent to a clk_set_rate()
 		 */
 		if (!_get_opp_count(opp_table)) {
-			ret = opp_table->config_clks(dev, opp_table, NULL,
-						     &target_freq, false);
-			goto put_opp_table;
+			return opp_table->config_clks(dev, opp_table, NULL,
+						      &target_freq, false);
 		}
 
 		freq = clk_round_rate(opp_table->clk, target_freq);
@@ -1383,10 +1362,9 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		temp_freq = freq;
 		opp = _find_freq_ceil(opp_table, &temp_freq);
 		if (IS_ERR(opp)) {
-			ret = PTR_ERR(opp);
-			dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",
-				__func__, freq, ret);
-			goto put_opp_table;
+			dev_err(dev, "%s: failed to find OPP for freq %lu (%ld)\n",
+				__func__, freq, PTR_ERR(opp));
+			return PTR_ERR(opp);
 		}
 
 		/*
@@ -1399,14 +1377,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		forced = opp_table->current_rate_single_clk != freq;
 	}
 
-	ret = _set_opp(dev, opp_table, opp, &freq, forced);
-
-	if (freq)
-		dev_pm_opp_put(opp);
-
-put_opp_table:
-	dev_pm_opp_put_opp_table(opp_table);
-	return ret;
+	return _set_opp(dev, opp_table, opp, &freq, forced);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_rate);
 
@@ -1422,8 +1393,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_rate);
  */
 int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp)
 {
-	struct opp_table *opp_table;
-	int ret;
+	struct opp_table *opp_table __free(put_opp_table);
 
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
@@ -1431,10 +1401,7 @@ int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp)
 		return PTR_ERR(opp_table);
 	}
 
-	ret = _set_opp(dev, opp_table, opp, NULL, false);
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return ret;
+	return _set_opp(dev, opp_table, opp, NULL, false);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_opp);
 
@@ -1744,15 +1711,15 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put);
  */
 void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 {
+	struct opp_table *opp_table __free(put_opp_table);
 	struct dev_pm_opp *opp = NULL, *iter;
-	struct opp_table *opp_table;
 
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return;
 
 	if (!assert_single_clk(opp_table, 0))
-		goto put_table;
+		return;
 
 	mutex_lock(&opp_table->lock);
 
@@ -1774,10 +1741,6 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 		dev_warn(dev, "%s: Couldn't find OPP with freq: %lu\n",
 			 __func__, freq);
 	}
-
-put_table:
-	/* Drop the reference taken by _find_opp_table() */
-	dev_pm_opp_put_opp_table(opp_table);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
 
@@ -1849,16 +1812,13 @@ bool _opp_remove_all_static(struct opp_table *opp_table)
  */
 void dev_pm_opp_remove_all_dynamic(struct device *dev)
 {
-	struct opp_table *opp_table;
+	struct opp_table *opp_table __free(put_opp_table);
 
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return;
 
 	_opp_remove_all(opp_table, true);
-
-	/* Drop the reference taken by _find_opp_table() */
-	dev_pm_opp_put_opp_table(opp_table);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove_all_dynamic);
 
@@ -2846,47 +2806,43 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_add_dynamic);
 static int _opp_set_availability(struct device *dev, unsigned long freq,
 				 bool availability_req)
 {
-	struct opp_table *opp_table;
-	struct dev_pm_opp *tmp_opp, *opp = ERR_PTR(-ENODEV);
-	int r = 0;
+	struct dev_pm_opp *opp __free(put_opp) = ERR_PTR(-ENODEV), *tmp_opp;
+	struct opp_table *opp_table __free(put_opp_table);
 
 	/* Find the opp_table */
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
-		r = PTR_ERR(opp_table);
-		dev_warn(dev, "%s: Device OPP not found (%d)\n", __func__, r);
-		return r;
+		dev_warn(dev, "%s: Device OPP not found (%ld)\n", __func__,
+			 PTR_ERR(opp_table));
+		return PTR_ERR(opp_table);
 	}
 
-	if (!assert_single_clk(opp_table, 0)) {
-		r = -EINVAL;
-		goto put_table;
-	}
+	if (!assert_single_clk(opp_table, 0))
+		return -EINVAL;
 
 	mutex_lock(&opp_table->lock);
 
 	/* Do we have the frequency? */
 	list_for_each_entry(tmp_opp, &opp_table->opp_list, node) {
 		if (tmp_opp->rates[0] == freq) {
-			opp = tmp_opp;
+			opp = dev_pm_opp_get(tmp_opp);
+
+			/* Is update really needed? */
+			if (opp->available == availability_req) {
+				mutex_unlock(&opp_table->lock);
+				return 0;
+			}
+
+			opp->available = availability_req;
 			break;
 		}
 	}
 
-	if (IS_ERR(opp)) {
-		r = PTR_ERR(opp);
-		goto unlock;
-	}
-
-	/* Is update really needed? */
-	if (opp->available == availability_req)
-		goto unlock;
-
-	opp->available = availability_req;
-
-	dev_pm_opp_get(opp);
 	mutex_unlock(&opp_table->lock);
 
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
 	/* Notify the change of the OPP availability */
 	if (availability_req)
 		blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_ENABLE,
@@ -2895,14 +2851,7 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 		blocking_notifier_call_chain(&opp_table->head,
 					     OPP_EVENT_DISABLE, opp);
 
-	dev_pm_opp_put(opp);
-	goto put_table;
-
-unlock:
-	mutex_unlock(&opp_table->lock);
-put_table:
-	dev_pm_opp_put_opp_table(opp_table);
-	return r;
+	return 0;
 }
 
 /**
@@ -2922,9 +2871,9 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 			      unsigned long u_volt_max)
 
 {
-	struct opp_table *opp_table;
-	struct dev_pm_opp *tmp_opp, *opp = ERR_PTR(-ENODEV);
-	int r = 0;
+	struct dev_pm_opp *opp __free(put_opp) = ERR_PTR(-ENODEV), *tmp_opp;
+	struct opp_table *opp_table __free(put_opp_table);
+	int r;
 
 	/* Find the opp_table */
 	opp_table = _find_opp_table(dev);
@@ -2934,49 +2883,40 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 		return r;
 	}
 
-	if (!assert_single_clk(opp_table, 0)) {
-		r = -EINVAL;
-		goto put_table;
-	}
+	if (!assert_single_clk(opp_table, 0))
+		return -EINVAL;
 
 	mutex_lock(&opp_table->lock);
 
 	/* Do we have the frequency? */
 	list_for_each_entry(tmp_opp, &opp_table->opp_list, node) {
 		if (tmp_opp->rates[0] == freq) {
-			opp = tmp_opp;
-			break;
-		}
-	}
+			opp = dev_pm_opp_get(tmp_opp);
 
-	if (IS_ERR(opp)) {
-		r = PTR_ERR(opp);
-		goto adjust_unlock;
-	}
+			/* Is update really needed? */
+			if (opp->supplies->u_volt == u_volt) {
+				mutex_unlock(&opp_table->lock);
+				return 0;
+			}
 
-	/* Is update really needed? */
-	if (opp->supplies->u_volt == u_volt)
-		goto adjust_unlock;
+			opp->supplies->u_volt = u_volt;
+			opp->supplies->u_volt_min = u_volt_min;
+			opp->supplies->u_volt_max = u_volt_max;
 
-	opp->supplies->u_volt = u_volt;
-	opp->supplies->u_volt_min = u_volt_min;
-	opp->supplies->u_volt_max = u_volt_max;
+			break;
+		}
+	}
 
-	dev_pm_opp_get(opp);
 	mutex_unlock(&opp_table->lock);
 
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
 	/* Notify the voltage change of the OPP */
 	blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_ADJUST_VOLTAGE,
 				     opp);
 
-	dev_pm_opp_put(opp);
-	goto put_table;
-
-adjust_unlock:
-	mutex_unlock(&opp_table->lock);
-put_table:
-	dev_pm_opp_put_opp_table(opp_table);
-	return r;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_adjust_voltage);
 
@@ -2990,9 +2930,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_adjust_voltage);
  */
 int dev_pm_opp_sync_regulators(struct device *dev)
 {
-	struct opp_table *opp_table;
+	struct opp_table *opp_table __free(put_opp_table);
 	struct regulator *reg;
-	int i, ret = 0;
+	int i;
 
 	/* Device may not have OPP table */
 	opp_table = _find_opp_table(dev);
@@ -3001,23 +2941,18 @@ int dev_pm_opp_sync_regulators(struct device *dev)
 
 	/* Regulator may not be required for the device */
 	if (unlikely(!opp_table->regulators))
-		goto put_table;
+		return 0;
 
 	/* Nothing to sync if voltage wasn't changed */
 	if (!opp_table->enabled)
-		goto put_table;
+		return 0;
 
 	for (i = 0; i < opp_table->regulator_count; i++) {
 		reg = opp_table->regulators[i];
-		ret = regulator_sync_voltage(reg);
-		if (ret)
-			break;
+		return regulator_sync_voltage(reg);
 	}
-put_table:
-	/* Drop reference taken by _find_opp_table() */
-	dev_pm_opp_put_opp_table(opp_table);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_sync_regulators);
 
@@ -3069,18 +3004,13 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_disable);
  */
 int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb)
 {
-	struct opp_table *opp_table;
-	int ret;
+	struct opp_table *opp_table __free(put_opp_table);
 
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
-	ret = blocking_notifier_chain_register(&opp_table->head, nb);
-
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return ret;
+	return blocking_notifier_chain_register(&opp_table->head, nb);
 }
 EXPORT_SYMBOL(dev_pm_opp_register_notifier);
 
@@ -3094,18 +3024,13 @@ EXPORT_SYMBOL(dev_pm_opp_register_notifier);
 int dev_pm_opp_unregister_notifier(struct device *dev,
 				   struct notifier_block *nb)
 {
-	struct opp_table *opp_table;
-	int ret;
+	struct opp_table *opp_table __free(put_opp_table);
 
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
-	ret = blocking_notifier_chain_unregister(&opp_table->head, nb);
-
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return ret;
+	return blocking_notifier_chain_unregister(&opp_table->head, nb);
 }
 EXPORT_SYMBOL(dev_pm_opp_unregister_notifier);
 
@@ -3118,7 +3043,7 @@ EXPORT_SYMBOL(dev_pm_opp_unregister_notifier);
  */
 void dev_pm_opp_remove_table(struct device *dev)
 {
-	struct opp_table *opp_table;
+	struct opp_table *opp_table __free(put_opp_table);
 
 	/* Check for existing table for 'dev' */
 	opp_table = _find_opp_table(dev);
@@ -3139,8 +3064,5 @@ void dev_pm_opp_remove_table(struct device *dev)
 	 **/
 	if (_opp_remove_all_static(opp_table))
 		dev_pm_opp_put_opp_table(opp_table);
-
-	/* Drop reference taken by _find_opp_table() */
-	dev_pm_opp_put_opp_table(opp_table);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove_table);
diff --git a/drivers/opp/cpu.c b/drivers/opp/cpu.c
index 12c429b407ca..330a1753fb22 100644
--- a/drivers/opp/cpu.c
+++ b/drivers/opp/cpu.c
@@ -43,7 +43,6 @@
 int dev_pm_opp_init_cpufreq_table(struct device *dev,
 				  struct cpufreq_frequency_table **opp_table)
 {
-	struct dev_pm_opp *opp;
 	struct cpufreq_frequency_table *freq_table = NULL;
 	int i, max_opps, ret = 0;
 	unsigned long rate;
@@ -57,6 +56,8 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
 		return -ENOMEM;
 
 	for (i = 0, rate = 0; i < max_opps; i++, rate++) {
+		struct dev_pm_opp *opp __free(put_opp);
+
 		/* find next rate */
 		opp = dev_pm_opp_find_freq_ceil(dev, &rate);
 		if (IS_ERR(opp)) {
@@ -69,8 +70,6 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
 		/* Is Boost/turbo opp ? */
 		if (dev_pm_opp_is_turbo(opp))
 			freq_table[i].flags = CPUFREQ_BOOST_FREQ;
-
-		dev_pm_opp_put(opp);
 	}
 
 	freq_table[i].driver_data = i;
@@ -155,10 +154,10 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_cpumask_remove_table);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev,
 				const struct cpumask *cpumask)
 {
+	struct opp_table *opp_table __free(put_opp_table);
 	struct opp_device *opp_dev;
-	struct opp_table *opp_table;
 	struct device *dev;
-	int cpu, ret = 0;
+	int cpu;
 
 	opp_table = _find_opp_table(cpu_dev);
 	if (IS_ERR(opp_table))
@@ -186,9 +185,7 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev,
 		opp_table->shared_opp = OPP_TABLE_ACCESS_SHARED;
 	}
 
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
 
@@ -204,18 +201,15 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
  */
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 {
+	struct opp_table *opp_table __free(put_opp_table);
 	struct opp_device *opp_dev;
-	struct opp_table *opp_table;
-	int ret = 0;
 
 	opp_table = _find_opp_table(cpu_dev);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
-	if (opp_table->shared_opp == OPP_TABLE_ACCESS_UNKNOWN) {
-		ret = -EINVAL;
-		goto put_opp_table;
-	}
+	if (opp_table->shared_opp == OPP_TABLE_ACCESS_UNKNOWN)
+		return -EINVAL;
 
 	cpumask_clear(cpumask);
 
@@ -228,9 +222,6 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 		cpumask_set_cpu(cpu_dev->id, cpumask);
 	}
 
-put_opp_table:
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_sharing_cpus);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index aa43fbfa3e50..54109e813d4f 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1344,8 +1344,8 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_sharing_cpus);
 int of_get_required_opp_performance_state(struct device_node *np, int index)
 {
 	struct device_node *required_np __free(device_node);
-	struct opp_table *opp_table;
-	struct dev_pm_opp *opp;
+	struct opp_table *opp_table __free(put_opp_table) = NULL;
+	struct dev_pm_opp *opp __free(put_opp) = NULL;
 	int pstate = -EINVAL;
 
 	required_np = of_parse_required_opp(np, index);
@@ -1373,11 +1373,8 @@ int of_get_required_opp_performance_state(struct device_node *np, int index)
 		} else {
 			pstate = opp->level;
 		}
-		dev_pm_opp_put(opp);
-
 	}
 
-	dev_pm_opp_put_opp_table(opp_table);
 	return pstate;
 }
 EXPORT_SYMBOL_GPL(of_get_required_opp_performance_state);
@@ -1443,7 +1440,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
 static int __maybe_unused
 _get_dt_power(struct device *dev, unsigned long *uW, unsigned long *kHz)
 {
-	struct dev_pm_opp *opp;
+	struct dev_pm_opp *opp __free(put_opp);
 	unsigned long opp_freq, opp_power;
 
 	/* Find the right frequency and related OPP */
@@ -1453,7 +1450,6 @@ _get_dt_power(struct device *dev, unsigned long *uW, unsigned long *kHz)
 		return -EINVAL;
 
 	opp_power = dev_pm_opp_get_power(opp);
-	dev_pm_opp_put(opp);
 	if (!opp_power)
 		return -EINVAL;
 
@@ -1484,8 +1480,8 @@ _get_dt_power(struct device *dev, unsigned long *uW, unsigned long *kHz)
 int dev_pm_opp_calc_power(struct device *dev, unsigned long *uW,
 			  unsigned long *kHz)
 {
+	struct dev_pm_opp *opp __free(put_opp) = NULL;
 	struct device_node *np __free(device_node);
-	struct dev_pm_opp *opp;
 	unsigned long mV, Hz;
 	u32 cap;
 	u64 tmp;
@@ -1505,7 +1501,6 @@ int dev_pm_opp_calc_power(struct device *dev, unsigned long *uW,
 		return -EINVAL;
 
 	mV = dev_pm_opp_get_voltage(opp) / 1000;
-	dev_pm_opp_put(opp);
 	if (!mV)
 		return -EINVAL;
 
@@ -1522,20 +1517,15 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_calc_power);
 
 static bool _of_has_opp_microwatt_property(struct device *dev)
 {
-	unsigned long power, freq = 0;
-	struct dev_pm_opp *opp;
+	struct dev_pm_opp *opp __free(put_opp);
+	unsigned long freq = 0;
 
 	/* Check if at least one OPP has needed property */
 	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
 	if (IS_ERR(opp))
 		return false;
 
-	power = dev_pm_opp_get_power(opp);
-	dev_pm_opp_put(opp);
-	if (!power)
-		return false;
-
-	return true;
+	return !!dev_pm_opp_get_power(opp);
 }
 
 /**
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 0deddfa91aca..e7b5c602c92f 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -11,6 +11,7 @@
 #ifndef __LINUX_OPP_H__
 #define __LINUX_OPP_H__
 
+#include <linux/cleanup.h>
 #include <linux/energy_model.h>
 #include <linux/err.h>
 #include <linux/notifier.h>
@@ -710,4 +711,10 @@ static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 	return dev_pm_opp_get_freq_indexed(opp, 0);
 }
 
+/* Scope based cleanup macro for OPP reference counting */
+DEFINE_FREE(put_opp, struct dev_pm_opp *, if (!IS_ERR_OR_NULL(_T)) dev_pm_opp_put(_T))
+
+/* Scope based cleanup macro for OPP table reference counting */
+DEFINE_FREE(put_opp_table, struct opp_table *, if (!IS_ERR_OR_NULL(_T)) dev_pm_opp_put_opp_table(_T))
+
 #endif		/* __LINUX_OPP_H__ */
-- 
2.31.1.272.g89b43f80a514


