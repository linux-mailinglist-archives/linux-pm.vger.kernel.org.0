Return-Path: <linux-pm+bounces-26116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 798F0A9AAA6
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 12:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA731941DC9
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 10:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C64723D2B6;
	Thu, 24 Apr 2025 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vp2ggoii"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DDE23D283
	for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491047; cv=none; b=b9iiHjCIv9jblLndLfh6QpEA2kqPcMJqiWduAZoSyhemwplejVi+YA3PCMqBSrx1wabZ9PMVbLcb1gEhLRqarULrrezmmgMB69gVcTRovhe7lyd6SoXkoVTDqHCi0v9IpCsviPygr1xZWWKKujHBbezWTZ0BzOQWPMgaaNOFT+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491047; c=relaxed/simple;
	bh=TmOGFV0w7v62MJ6x8MwidOrdpKY+8DJsmTGwPxqGrNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DYJv7VnB2RSP2FMB3+c61EX0fgViCLEUFWa/Hmqzl6iE5ium0ZYYbJOdiewuZwIKwl7aSOIX60kKy01NDAaYEXtFrES1ReqXdf5CkQtwMBsQTvrI24tpwlCIh6vEbvheFSQsExRYLtZbbUQC04YvfEGOLQkwH8W3YJEtj975csg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vp2ggoii; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2243803b776so13840355ad.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 03:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745491044; x=1746095844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBwTEXhNABTCQyq0u1UG76AK2UVABOzq6NwLkHUAp5g=;
        b=Vp2ggoiivVf0XCFeNd31Q4L7yILXFVinhCqydSUDyl5zachVO/GIusHto53YTjd8bE
         5qLMnP40afg9Fe3jABFM+j9xJgZV1LUi/voiyBxJgPA2D0uvAOLhUYnAZ4xJIGAMIaJw
         gN45pvxF1Sfx7Ub0ZpwQ5j09C/X+B01oQzk7R0ozVtzKIUU3M/TQOcSyG026mZyRp7cX
         ZRScYjMafxaoUHP3R8HPdqY+51RjTlL1zaQDhdOYMe3aQoRvsMbAKawh6hPO721DJGzZ
         qwlXiAjmffr8P/M3E1/Bk6S2q6vCsRWsfVBB0vXSefWLyw4fc6r1qw8bMTETeLqyqXau
         zvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745491044; x=1746095844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBwTEXhNABTCQyq0u1UG76AK2UVABOzq6NwLkHUAp5g=;
        b=M/vRlN+ZxPJ3dZf+ISAhOVpSV/dDbWE3M/Yjf33sJSY+knxGwmEwCOmdE3D73x66E4
         TZpFk82TZbE5mBzLG6vOMXe5aaRX1IZBQB4+0rakW5TsCcoDQZJSCnxRpKkerUWTf+Rq
         1Rd5grvIPYaEERsFzUWbZSHU/ypzzpQCbSm+Bse8tV3/m9MQiq25Q8xUbNBw95K+HcUX
         6C7CTguMvaJtUhFF2JxVONgqniUk9XMhbsaUei3jrEDtgqXTo2vo93JpC9p4uPMig84W
         9J6CbN8hC/uZfiCflfXOWZN3o8/IQL2J4omyy0XEM1v4FM+L0Ld9uKB1z6up6awpxOGy
         9vtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlc5WUZQNjQhyjSl9AAoDWqgkObSWCaAsE8HsutGXds4aQv5swGD5sfchjiZ2rB/0xiLDD+KPq+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq+pQoLQ338Abps+8M3+2gZJqhj+72MrTSzzPuMW6A7kGZsDFt
	GwZ3h63LogJ7Q2SBuY6yRbr1A76/o8W4gyPa/xq+1I9LAHL6t94ou4rqd+9TV3I=
X-Gm-Gg: ASbGncvO7jKi5dlSCkQAosIO4ERSE7RbCtmnNhf5MPuqJ3UIxXo47vKQn7VkKhu5C+B
	gqdkFyfXn2oYh9H9MfkyviFNRgKWGbAl+NAp/3U13xMubqZWDVpph0Z4KLHKbDr4m4FWMvvG4Xn
	G4zRpFqQ6Sb/UzUYBPb/91RENR2cNcBoo94IY2xWZ9Td3Yn3BvuJb+HqP3TPK2Ar97SC/zxvASk
	pt4utb6W6DPqhslbn3jkYhS2WJIg+TWxv0hAQHN2MipgxDPWXHjz11/kdsDf3XHY1olPf59vhp3
	xv8c30sju4EaInUAGUhbz4aNEpOInwILZJTudGX6u9xf/78j/gj+
X-Google-Smtp-Source: AGHT+IFsvSHzdGeWlWocErZ1QgNQTv5wJHcxn0cYwaK4A27pHPX0GIC28/2OjZnhyv7cYx3YbtgU6Q==
X-Received: by 2002:a17:902:d2ce:b0:21b:d105:26b8 with SMTP id d9443c01a7336-22db3bb1e1cmr24994525ad.7.1745491044394;
        Thu, 24 Apr 2025 03:37:24 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7681sm9868985ad.119.2025.04.24.03.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:37:23 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] OPP: Use mutex locking guards
Date: Thu, 24 Apr 2025 16:06:49 +0530
Message-Id: <cb4bdf07e512e39af4c9142679c1361ce76e9336.1745490980.git.viresh.kumar@linaro.org>
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

Use mutex locking guard in the OPP core.

No intentional functional impact.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 201 ++++++++++++++++++---------------------------
 drivers/opp/cpu.c  |   3 +-
 drivers/opp/of.c   |  65 ++++++---------
 3 files changed, 105 insertions(+), 164 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 87d27132cd87..fc9874946453 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -40,17 +40,14 @@ static DEFINE_XARRAY_ALLOC1(opp_configs);
 static bool _find_opp_dev(const struct device *dev, struct opp_table *opp_table)
 {
 	struct opp_device *opp_dev;
-	bool found = false;
 
-	mutex_lock(&opp_table->lock);
+	guard(mutex)(&opp_table->lock);
+
 	list_for_each_entry(opp_dev, &opp_table->dev_list, node)
-		if (opp_dev->dev == dev) {
-			found = true;
-			break;
-		}
+		if (opp_dev->dev == dev)
+			return true;
 
-	mutex_unlock(&opp_table->lock);
-	return found;
+	return false;
 }
 
 static struct opp_table *_find_opp_table_unlocked(struct device *dev)
@@ -78,18 +75,13 @@ static struct opp_table *_find_opp_table_unlocked(struct device *dev)
  */
 struct opp_table *_find_opp_table(struct device *dev)
 {
-	struct opp_table *opp_table;
-
 	if (IS_ERR_OR_NULL(dev)) {
 		pr_err("%s: Invalid parameters\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
 
-	mutex_lock(&opp_table_lock);
-	opp_table = _find_opp_table_unlocked(dev);
-	mutex_unlock(&opp_table_lock);
-
-	return opp_table;
+	guard(mutex)(&opp_table_lock);
+	return _find_opp_table_unlocked(dev);
 }
 
 /*
@@ -359,25 +351,23 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 	if (!uV)
 		return 0;
 
-	mutex_lock(&opp_table->lock);
-
-	for (i = 0; i < count; i++) {
-		uV[i].min = ~0;
-		uV[i].max = 0;
+	scoped_guard(mutex, &opp_table->lock) {
+		for (i = 0; i < count; i++) {
+			uV[i].min = ~0;
+			uV[i].max = 0;
 
-		list_for_each_entry(opp, &opp_table->opp_list, node) {
-			if (!opp->available)
-				continue;
+			list_for_each_entry(opp, &opp_table->opp_list, node) {
+				if (!opp->available)
+					continue;
 
-			if (opp->supplies[i].u_volt_min < uV[i].min)
-				uV[i].min = opp->supplies[i].u_volt_min;
-			if (opp->supplies[i].u_volt_max > uV[i].max)
-				uV[i].max = opp->supplies[i].u_volt_max;
+				if (opp->supplies[i].u_volt_min < uV[i].min)
+					uV[i].min = opp->supplies[i].u_volt_min;
+				if (opp->supplies[i].u_volt_max > uV[i].max)
+					uV[i].max = opp->supplies[i].u_volt_max;
+			}
 		}
 	}
 
-	mutex_unlock(&opp_table->lock);
-
 	/*
 	 * The caller needs to ensure that opp_table (and hence the regulator)
 	 * isn't freed, while we are executing this routine.
@@ -438,15 +428,13 @@ int _get_opp_count(struct opp_table *opp_table)
 	struct dev_pm_opp *opp;
 	int count = 0;
 
-	mutex_lock(&opp_table->lock);
+	guard(mutex)(&opp_table->lock);
 
 	list_for_each_entry(opp, &opp_table->opp_list, node) {
 		if (opp->available)
 			count++;
 	}
 
-	mutex_unlock(&opp_table->lock);
-
 	return count;
 }
 
@@ -535,7 +523,7 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
 	if (assert && !assert(opp_table, index))
 		return ERR_PTR(-EINVAL);
 
-	mutex_lock(&opp_table->lock);
+	guard(mutex)(&opp_table->lock);
 
 	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
 		if (temp_opp->available == available) {
@@ -550,8 +538,6 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
 		dev_pm_opp_get(opp);
 	}
 
-	mutex_unlock(&opp_table->lock);
-
 	return opp;
 }
 
@@ -1166,10 +1152,9 @@ static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
 	 * make special checks to validate current_opp.
 	 */
 	if (IS_ERR(opp)) {
-		mutex_lock(&opp_table->lock);
+		guard(mutex)(&opp_table->lock);
 		opp = dev_pm_opp_get(list_first_entry(&opp_table->opp_list,
 						      struct dev_pm_opp, node));
-		mutex_unlock(&opp_table->lock);
 	}
 
 	opp_table->current_opp = opp;
@@ -1426,9 +1411,8 @@ struct opp_device *_add_opp_dev(const struct device *dev,
 	/* Initialize opp-dev */
 	opp_dev->dev = dev;
 
-	mutex_lock(&opp_table->lock);
-	list_add(&opp_dev->node, &opp_table->dev_list);
-	mutex_unlock(&opp_table->lock);
+	scoped_guard(mutex, &opp_table->lock)
+		list_add(&opp_dev->node, &opp_table->dev_list);
 
 	/* Create debugfs entries for the opp_table */
 	opp_debug_register(opp_dev, opp_table);
@@ -1721,17 +1705,15 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 	if (!assert_single_clk(opp_table, 0))
 		return;
 
-	mutex_lock(&opp_table->lock);
-
-	list_for_each_entry(iter, &opp_table->opp_list, node) {
-		if (iter->rates[0] == freq) {
-			opp = iter;
-			break;
+	scoped_guard(mutex, &opp_table->lock) {
+		list_for_each_entry(iter, &opp_table->opp_list, node) {
+			if (iter->rates[0] == freq) {
+				opp = iter;
+				break;
+			}
 		}
 	}
 
-	mutex_unlock(&opp_table->lock);
-
 	if (opp) {
 		dev_pm_opp_put(opp);
 
@@ -1747,22 +1729,20 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
 static struct dev_pm_opp *_opp_get_next(struct opp_table *opp_table,
 					bool dynamic)
 {
-	struct dev_pm_opp *opp = NULL, *temp;
+	struct dev_pm_opp *opp;
 
-	mutex_lock(&opp_table->lock);
-	list_for_each_entry(temp, &opp_table->opp_list, node) {
+	guard(mutex)(&opp_table->lock);
+
+	list_for_each_entry(opp, &opp_table->opp_list, node) {
 		/*
 		 * Refcount must be dropped only once for each OPP by OPP core,
 		 * do that with help of "removed" flag.
 		 */
-		if (!temp->removed && dynamic == temp->dynamic) {
-			opp = temp;
-			break;
-		}
+		if (!opp->removed && dynamic == opp->dynamic)
+			return opp;
 	}
 
-	mutex_unlock(&opp_table->lock);
-	return opp;
+	return NULL;
 }
 
 /*
@@ -1786,20 +1766,14 @@ static void _opp_remove_all(struct opp_table *opp_table, bool dynamic)
 
 bool _opp_remove_all_static(struct opp_table *opp_table)
 {
-	mutex_lock(&opp_table->lock);
-
-	if (!opp_table->parsed_static_opps) {
-		mutex_unlock(&opp_table->lock);
-		return false;
-	}
+	scoped_guard(mutex, &opp_table->lock) {
+		if (!opp_table->parsed_static_opps)
+			return false;
 
-	if (--opp_table->parsed_static_opps) {
-		mutex_unlock(&opp_table->lock);
-		return true;
+		if (--opp_table->parsed_static_opps)
+			return true;
 	}
 
-	mutex_unlock(&opp_table->lock);
-
 	_opp_remove_all(opp_table, false);
 	return true;
 }
@@ -2003,17 +1977,15 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 	struct list_head *head;
 	int ret;
 
-	mutex_lock(&opp_table->lock);
-	head = &opp_table->opp_list;
+	scoped_guard(mutex, &opp_table->lock) {
+		head = &opp_table->opp_list;
 
-	ret = _opp_is_duplicate(dev, new_opp, opp_table, &head);
-	if (ret) {
-		mutex_unlock(&opp_table->lock);
-		return ret;
-	}
+		ret = _opp_is_duplicate(dev, new_opp, opp_table, &head);
+		if (ret)
+			return ret;
 
-	list_add(&new_opp->node, head);
-	mutex_unlock(&opp_table->lock);
+		list_add(&new_opp->node, head);
+	}
 
 	new_opp->opp_table = opp_table;
 	kref_init(&new_opp->kref);
@@ -2660,17 +2632,16 @@ struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
 		return ERR_PTR(-EBUSY);
 
 	for (i = 0; i < src_table->required_opp_count; i++) {
-		if (src_table->required_opp_tables[i] == dst_table) {
-			mutex_lock(&src_table->lock);
+		if (src_table->required_opp_tables[i] != dst_table)
+			continue;
 
+		scoped_guard(mutex, &src_table->lock) {
 			list_for_each_entry(opp, &src_table->opp_list, node) {
 				if (opp == src_opp) {
 					dest_opp = dev_pm_opp_get(opp->required_opps[i]);
 					break;
 				}
 			}
-
-			mutex_unlock(&src_table->lock);
 			break;
 		}
 	}
@@ -2702,7 +2673,6 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
 				       unsigned int pstate)
 {
 	struct dev_pm_opp *opp;
-	int dest_pstate = -EINVAL;
 	int i;
 
 	/*
@@ -2736,22 +2706,17 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
 		return -EINVAL;
 	}
 
-	mutex_lock(&src_table->lock);
+	guard(mutex)(&src_table->lock);
 
 	list_for_each_entry(opp, &src_table->opp_list, node) {
-		if (opp->level == pstate) {
-			dest_pstate = opp->required_opps[i]->level;
-			goto unlock;
-		}
+		if (opp->level == pstate)
+			return opp->required_opps[i]->level;
 	}
 
 	pr_err("%s: Couldn't find matching OPP (%p: %p)\n", __func__, src_table,
 	       dst_table);
 
-unlock:
-	mutex_unlock(&src_table->lock);
-
-	return dest_pstate;
+	return -EINVAL;
 }
 
 /**
@@ -2820,26 +2785,22 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 	if (!assert_single_clk(opp_table, 0))
 		return -EINVAL;
 
-	mutex_lock(&opp_table->lock);
+	scoped_guard(mutex, &opp_table->lock) {
+		/* Do we have the frequency? */
+		list_for_each_entry(tmp_opp, &opp_table->opp_list, node) {
+			if (tmp_opp->rates[0] == freq) {
+				opp = dev_pm_opp_get(tmp_opp);
 
-	/* Do we have the frequency? */
-	list_for_each_entry(tmp_opp, &opp_table->opp_list, node) {
-		if (tmp_opp->rates[0] == freq) {
-			opp = dev_pm_opp_get(tmp_opp);
+				/* Is update really needed? */
+				if (opp->available == availability_req)
+					return 0;
 
-			/* Is update really needed? */
-			if (opp->available == availability_req) {
-				mutex_unlock(&opp_table->lock);
-				return 0;
+				opp->available = availability_req;
+				break;
 			}
-
-			opp->available = availability_req;
-			break;
 		}
 	}
 
-	mutex_unlock(&opp_table->lock);
-
 	if (IS_ERR(opp))
 		return PTR_ERR(opp);
 
@@ -2886,29 +2847,25 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 	if (!assert_single_clk(opp_table, 0))
 		return -EINVAL;
 
-	mutex_lock(&opp_table->lock);
-
-	/* Do we have the frequency? */
-	list_for_each_entry(tmp_opp, &opp_table->opp_list, node) {
-		if (tmp_opp->rates[0] == freq) {
-			opp = dev_pm_opp_get(tmp_opp);
+	scoped_guard(mutex, &opp_table->lock) {
+		/* Do we have the frequency? */
+		list_for_each_entry(tmp_opp, &opp_table->opp_list, node) {
+			if (tmp_opp->rates[0] == freq) {
+				opp = dev_pm_opp_get(tmp_opp);
 
-			/* Is update really needed? */
-			if (opp->supplies->u_volt == u_volt) {
-				mutex_unlock(&opp_table->lock);
-				return 0;
-			}
+				/* Is update really needed? */
+				if (opp->supplies->u_volt == u_volt)
+					return 0;
 
-			opp->supplies->u_volt = u_volt;
-			opp->supplies->u_volt_min = u_volt_min;
-			opp->supplies->u_volt_max = u_volt_max;
+				opp->supplies->u_volt = u_volt;
+				opp->supplies->u_volt_min = u_volt_min;
+				opp->supplies->u_volt_max = u_volt_max;
 
-			break;
+				break;
+			}
 		}
 	}
 
-	mutex_unlock(&opp_table->lock);
-
 	if (IS_ERR(opp))
 		return PTR_ERR(opp);
 
diff --git a/drivers/opp/cpu.c b/drivers/opp/cpu.c
index 330a1753fb22..97989d4fe336 100644
--- a/drivers/opp/cpu.c
+++ b/drivers/opp/cpu.c
@@ -214,10 +214,9 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 	cpumask_clear(cpumask);
 
 	if (opp_table->shared_opp == OPP_TABLE_ACCESS_SHARED) {
-		mutex_lock(&opp_table->lock);
+		guard(mutex)(&opp_table->lock);
 		list_for_each_entry(opp_dev, &opp_table->dev_list, node)
 			cpumask_set_cpu(opp_dev->dev->id, cpumask);
-		mutex_unlock(&opp_table->lock);
 	} else {
 		cpumask_set_cpu(cpu_dev->id, cpumask);
 	}
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 54109e813d4f..505d79821584 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -76,18 +76,13 @@ static struct dev_pm_opp *_find_opp_of_np(struct opp_table *opp_table,
 {
 	struct dev_pm_opp *opp;
 
-	mutex_lock(&opp_table->lock);
+	guard(mutex)(&opp_table->lock);
 
 	list_for_each_entry(opp, &opp_table->opp_list, node) {
-		if (opp->np == opp_np) {
-			dev_pm_opp_get(opp);
-			mutex_unlock(&opp_table->lock);
-			return opp;
-		}
+		if (opp->np == opp_np)
+			return dev_pm_opp_get(opp);
 	}
 
-	mutex_unlock(&opp_table->lock);
-
 	return NULL;
 }
 
@@ -105,19 +100,15 @@ static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
 
 	opp_table_np = of_get_parent(opp_np);
 	if (!opp_table_np)
-		goto err;
+		return ERR_PTR(-ENODEV);
+
+	guard(mutex)(&opp_table_lock);
 
-	mutex_lock(&opp_table_lock);
 	list_for_each_entry(opp_table, &opp_tables, node) {
-		if (opp_table_np == opp_table->np) {
-			dev_pm_opp_get_opp_table_ref(opp_table);
-			mutex_unlock(&opp_table_lock);
-			return opp_table;
-		}
+		if (opp_table_np == opp_table->np)
+			return dev_pm_opp_get_opp_table_ref(opp_table);
 	}
-	mutex_unlock(&opp_table_lock);
 
-err:
 	return ERR_PTR(-ENODEV);
 }
 
@@ -142,9 +133,8 @@ static void _opp_table_free_required_tables(struct opp_table *opp_table)
 	opp_table->required_opp_count = 0;
 	opp_table->required_opp_tables = NULL;
 
-	mutex_lock(&opp_table_lock);
+	guard(mutex)(&opp_table_lock);
 	list_del(&opp_table->lazy);
-	mutex_unlock(&opp_table_lock);
 }
 
 /*
@@ -201,9 +191,8 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 		 * The OPP table is not held while allocating the table, take it
 		 * now to avoid corruption to the lazy_opp_tables list.
 		 */
-		mutex_lock(&opp_table_lock);
+		guard(mutex)(&opp_table_lock);
 		list_add(&opp_table->lazy, &lazy_opp_tables);
-		mutex_unlock(&opp_table_lock);
 	}
 }
 
@@ -357,7 +346,7 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
 	struct dev_pm_opp *opp;
 	int i, ret;
 
-	mutex_lock(&opp_table_lock);
+	guard(mutex)(&opp_table_lock);
 
 	list_for_each_entry_safe(opp_table, temp, &lazy_opp_tables, lazy) {
 		struct device_node *opp_np __free(device_node);
@@ -408,8 +397,6 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
 				_required_opps_available(opp, opp_table->required_opp_count);
 		}
 	}
-
-	mutex_unlock(&opp_table_lock);
 }
 
 static int _bandwidth_supported(struct device *dev, struct opp_table *opp_table)
@@ -970,15 +957,14 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 	struct dev_pm_opp *opp;
 
 	/* OPP table is already initialized for the device */
-	mutex_lock(&opp_table->lock);
-	if (opp_table->parsed_static_opps) {
-		opp_table->parsed_static_opps++;
-		mutex_unlock(&opp_table->lock);
-		return 0;
-	}
+	scoped_guard(mutex, &opp_table->lock) {
+		if (opp_table->parsed_static_opps) {
+			opp_table->parsed_static_opps++;
+			return 0;
+		}
 
-	opp_table->parsed_static_opps = 1;
-	mutex_unlock(&opp_table->lock);
+		opp_table->parsed_static_opps = 1;
+	}
 
 	/* We have opp-table node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_table->np, np) {
@@ -1018,15 +1004,14 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 	const __be32 *val;
 	int nr, ret = 0;
 
-	mutex_lock(&opp_table->lock);
-	if (opp_table->parsed_static_opps) {
-		opp_table->parsed_static_opps++;
-		mutex_unlock(&opp_table->lock);
-		return 0;
-	}
+	scoped_guard(mutex, &opp_table->lock) {
+		if (opp_table->parsed_static_opps) {
+			opp_table->parsed_static_opps++;
+			return 0;
+		}
 
-	opp_table->parsed_static_opps = 1;
-	mutex_unlock(&opp_table->lock);
+		opp_table->parsed_static_opps = 1;
+	}
 
 	prop = of_find_property(dev->of_node, "operating-points", NULL);
 	if (!prop) {
-- 
2.31.1.272.g89b43f80a514


