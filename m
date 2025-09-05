Return-Path: <linux-pm+bounces-33993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B119B459AE
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 15:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 291407B7398
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 13:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB8735E4D7;
	Fri,  5 Sep 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orSAr+VF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4100235E4D3;
	Fri,  5 Sep 2025 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080457; cv=none; b=DxCUOffGCzkWdFwtQMunBYqWZx2PTHB7DE8wYN81PQPGhZP1yesZIOE5j4xCwQi9ZeRVoy/eWPoI5KtqvpE8iVUTGuYae/UcGUN0/KlUGdfXWhVSeC9qt2iX2Dzf6cnkGIRTXIAQAbKNXSDNV2IcI7+W0WLuaZDVZn7intEAqAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080457; c=relaxed/simple;
	bh=RJ+j94DaXb8OxhldXX6ve0r5pnX/7/TjVN81rxWNQgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/cK1JPsTqPpegZp4Y9z2YlyGlt9YSXSPO+Fb6s8b/ZVLGVkHHHy2EInkDzpFiAg8BqXS04b5B/tUxa6OBlRmoYdgrcbdlmdWOuvpL/ITHDZCV9frwjpJplfeVg7rqkztIUkMA7D5gBTPwKtCTgEsRUulu4ksyTgcO+i2rEReSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orSAr+VF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B66C4CEF5;
	Fri,  5 Sep 2025 13:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757080455;
	bh=RJ+j94DaXb8OxhldXX6ve0r5pnX/7/TjVN81rxWNQgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=orSAr+VFnHMv6CEPlVHki4kzzlI32VkC1PWu+WEHV5NlynT9S/GeF0qYHHNhNm5fZ
	 I5zNSNCk5EIiVfUvoGsBvIWcTb9E2dr931cSCNn9xdJ8Rcd6i+YHvhNahYhUkYGf+z
	 wMd9RPkSp2BUpncEVYCDtICQnB2pkcbzRK83IGLvKvmnq82gvoiZVglWiijgyZLmAv
	 jyW84r3gd1W12x8LLQt84ahXpwBl4vwPlNRnh1b8x8++BJ2VIYer0h6VQF33lVA0L5
	 pzIqLp3VbVZkJ4fjtCIQKaVL2tl91LUsh+7phC/euJG4uFojrWRodDtVLkO6Khqa5K
	 MMGT6Nka9gkfg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Zihuan Zhang <zhangzihuan@kylinos.cn>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject:
 [PATCH v1 2/3] cpufreq: intel_pstate: Rearrange freq QoS updates using
 __free()
Date: Fri, 05 Sep 2025 15:52:54 +0200
Message-ID: <3026597.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5028967.GXAFRqVoOG@rafael.j.wysocki>
References: <5028967.GXAFRqVoOG@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the code from the for_each_possible_cpu() loop in update_qos_request()
to a separate function and use __free() for cpufreq policy reference
counting in it to avoid having to call cpufreq_cpu_put() repeatedly (or
using goto).

While at it, rename update_qos_request() to update_qos_requests()
because it updates multiple requests in one go.

No intentional functional impact.

Link: https://lore.kernel.org/linux-pm/CAJZ5v0gN1T5woSF0tO=TbAh+2-sWzxFjWyDbB7wG2TFCOU01iQ@mail.gmail.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   65 ++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1693,43 +1693,42 @@ unlock_driver:
 	return count;
 }
 
-static void update_qos_request(enum freq_qos_req_type type)
+static void update_cpu_qos_request(int cpunum, enum freq_qos_req_type type)
 {
+	struct cpudata *cpu = all_cpu_data[cpunum];
 	struct freq_qos_request *req;
-	struct cpufreq_policy *policy;
-	int i;
+	unsigned int freq, perf_pct;
 
-	for_each_possible_cpu(i) {
-		struct cpudata *cpu = all_cpu_data[i];
-		unsigned int freq, perf_pct;
-
-		policy = cpufreq_cpu_get(i);
-		if (!policy)
-			continue;
-
-		req = policy->driver_data;
-		if (!req) {
-			cpufreq_cpu_put(policy);
-			continue;
-		}
-
-		if (hwp_active)
-			intel_pstate_get_hwp_cap(cpu);
-
-		if (type == FREQ_QOS_MIN) {
-			perf_pct = global.min_perf_pct;
-		} else {
-			req++;
-			perf_pct = global.max_perf_pct;
-		}
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpunum);
+	if (!policy)
+		return;
+
+	req = policy->driver_data;
+	if (!req)
+		return;
+
+	if (hwp_active)
+		intel_pstate_get_hwp_cap(cpu);
+
+	if (type == FREQ_QOS_MIN) {
+		perf_pct = global.min_perf_pct;
+	} else {
+		req++;
+		perf_pct = global.max_perf_pct;
+	}
 
-		freq = DIV_ROUND_UP(cpu->pstate.turbo_freq * perf_pct, 100);
+	freq = DIV_ROUND_UP(cpu->pstate.turbo_freq * perf_pct, 100);
 
-		if (freq_qos_update_request(req, freq) < 0)
-			pr_warn("Failed to update freq constraint: CPU%d\n", i);
+	if (freq_qos_update_request(req, freq) < 0)
+		pr_warn("Failed to update freq constraint: CPU%d\n", cpunum);
+}
 
-		cpufreq_cpu_put(policy);
-	}
+static void update_qos_requests(enum freq_qos_req_type type)
+{
+	int i;
+
+	for_each_possible_cpu(i)
+		update_cpu_qos_request(i, type);
 }
 
 static ssize_t store_max_perf_pct(struct kobject *a, struct kobj_attribute *b,
@@ -1758,7 +1757,7 @@ static ssize_t store_max_perf_pct(struct
 	if (intel_pstate_driver == &intel_pstate)
 		intel_pstate_update_policies();
 	else
-		update_qos_request(FREQ_QOS_MAX);
+		update_qos_requests(FREQ_QOS_MAX);
 
 	mutex_unlock(&intel_pstate_driver_lock);
 
@@ -1792,7 +1791,7 @@ static ssize_t store_min_perf_pct(struct
 	if (intel_pstate_driver == &intel_pstate)
 		intel_pstate_update_policies();
 	else
-		update_qos_request(FREQ_QOS_MIN);
+		update_qos_requests(FREQ_QOS_MIN);
 
 	mutex_unlock(&intel_pstate_driver_lock);
 




