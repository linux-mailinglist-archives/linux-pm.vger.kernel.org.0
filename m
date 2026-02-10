Return-Path: <linux-pm+bounces-42445-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMkrHv0ci2nSPwAAu9opvQ
	(envelope-from <linux-pm+bounces-42445-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 12:56:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D731F11A76B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 12:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2209A303EFA4
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 11:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A24A327C0D;
	Tue, 10 Feb 2026 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DUaTAaQm"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67543271FD;
	Tue, 10 Feb 2026 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724590; cv=none; b=DC08vga28n6n6WeSViaPy+YgLTtmHJhNUl0qtK52iEJRvEQVYy7OXQ1EzzAqouuUVAhoxoMiIn96Yd0r8+OIlfJ9NGvg5pQUR/XIZD3HK3EElxoSrbcSkynhbbzLRSNGIBHX8ndo1ta0m5rJx2hc/RSjAkX0QEYxmAMQWz7T1lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724590; c=relaxed/simple;
	bh=2cDa0jQh4BLNwvHRHhy5tWEKBg2vJbZED/67EOm3xVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDPZ5hx9YiRXJZTszwSenCCOr05WFBhk4vf+acFyRwp47OnFDSs3fcLdlD/AAOxJK7NwBbLydGujh5w/mkhmLcVff7zfqEs9xsi7E6uZUIbiRDJQ4Lkx+gQ05vii6HcfWfcD40JQwtlJe5upMD0RD4/4foO3IwxyqBGAvRVWAJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DUaTAaQm; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Zp2BHvySpCxWBmHqdxSZ5PZi/J2OrljwE43C5Nhh+xg=;
	b=DUaTAaQmB7GvKabIgfEj7ll2nd9t8ISbTCHhTh2kcCFqMfN3uR1zeinGsBGlh4dUVMy0flwGL
	TLTC84VzElJCn7Tcd5+K8OL8Ij3tv8Xoa3RpoNM1GT9WRXn2NqG1DYvM8JB/G86FG704md7IH5a
	scnaUvagzSRykJKB03R8n4o=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4f9KfQ0DXGzLlSM;
	Tue, 10 Feb 2026 19:51:42 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id A6B2940565;
	Tue, 10 Feb 2026 19:56:19 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200001.china.huawei.com (7.202.181.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Feb 2026 19:56:18 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>, <linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH 1/2] cpufreq: governor: Move requested_freq to policy_dbs_info
Date: Tue, 10 Feb 2026 19:54:57 +0800
Message-ID: <20260210115458.3493646-2-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260210115458.3493646-1-zhenglifeng1@huawei.com>
References: <20260210115458.3493646-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200001.china.huawei.com (7.202.181.227)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42445-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenglifeng1@huawei.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D731F11A76B
X-Rspamd-Action: no action

Conservative governor uses requested_freq to store the last target freq
requested by the governor. This member variable can also be useful for the
ondemand governor. So move it to struct policy_dbs_info and update it each
time request a frequency.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cpufreq_conservative.c | 14 ++++----------
 drivers/cpufreq/cpufreq_governor.c     |  1 +
 drivers/cpufreq/cpufreq_governor.h     | 12 ++++++++++++
 drivers/cpufreq/cpufreq_ondemand.c     | 10 +++++-----
 4 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index cce6a8d113e1..2980ca19c580 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -14,7 +14,6 @@
 struct cs_policy_dbs_info {
 	struct policy_dbs_info policy_dbs;
 	unsigned int down_skip;
-	unsigned int requested_freq;
 };
 
 static inline struct cs_policy_dbs_info *to_dbs_info(struct policy_dbs_info *policy_dbs)
@@ -59,7 +58,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 {
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy_dbs);
-	unsigned int requested_freq = dbs_info->requested_freq;
+	unsigned int requested_freq = policy_dbs->requested_freq;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 	unsigned int load = dbs_update(policy);
@@ -79,7 +78,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 	 */
 	if (requested_freq > policy->max || requested_freq < policy->min) {
 		requested_freq = policy->cur;
-		dbs_info->requested_freq = requested_freq;
+		policy_dbs->requested_freq = requested_freq;
 	}
 
 	freq_step = get_freq_step(cs_tuners, policy);
@@ -111,9 +110,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 		if (requested_freq > policy->max)
 			requested_freq = policy->max;
 
-		__cpufreq_driver_target(policy, requested_freq,
-					CPUFREQ_RELATION_HE);
-		dbs_info->requested_freq = requested_freq;
+		gov_freq_request(policy, requested_freq, CPUFREQ_RELATION_HE);
 		goto out;
 	}
 
@@ -135,9 +132,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 		else
 			requested_freq = policy->min;
 
-		__cpufreq_driver_target(policy, requested_freq,
-					CPUFREQ_RELATION_LE);
-		dbs_info->requested_freq = requested_freq;
+		gov_freq_request(policy, requested_freq, CPUFREQ_RELATION_LE);
 	}
 
  out:
@@ -310,7 +305,6 @@ static void cs_start(struct cpufreq_policy *policy)
 	struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
 
 	dbs_info->down_skip = 0;
-	dbs_info->requested_freq = policy->cur;
 }
 
 static struct dbs_governor cs_governor = {
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 1a7fcaf39cc9..7ec38407230f 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -524,6 +524,7 @@ int cpufreq_dbs_governor_start(struct cpufreq_policy *policy)
 
 	policy_dbs->is_shared = policy_is_shared(policy);
 	policy_dbs->rate_mult = 1;
+	policy_dbs->requested_freq = policy->cur;
 
 	sampling_rate = dbs_data->sampling_rate;
 	ignore_nice = dbs_data->ignore_nice_load;
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 168c23fd7fca..51db1abced93 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -97,6 +97,8 @@ struct policy_dbs_info {
 	/* Status indicators */
 	bool is_shared;		/* This object is used by multiple CPUs */
 	bool work_in_progress;	/* Work is being queued up or in progress */
+
+	unsigned int requested_freq;	/* Last frequency requested by the governor */
 };
 
 static inline void gov_update_sample_delay(struct policy_dbs_info *policy_dbs,
@@ -105,6 +107,16 @@ static inline void gov_update_sample_delay(struct policy_dbs_info *policy_dbs,
 	policy_dbs->sample_delay_ns = delay_us * NSEC_PER_USEC;
 }
 
+static inline void gov_freq_request(struct cpufreq_policy *policy,
+				    unsigned int requested_freq,
+				    unsigned int relation)
+{
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
+
+	__cpufreq_driver_target(policy, requested_freq, relation);
+	policy_dbs->requested_freq = requested_freq;
+}
+
 /* Per cpu structures */
 struct cpu_dbs_info {
 	u64 prev_cpu_idle;
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index a6ecc203f7b7..fb6d4183d589 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -101,8 +101,8 @@ static void dbs_freq_increase(struct cpufreq_policy *policy, unsigned int freq)
 	else if (policy->cur == policy->max)
 		return;
 
-	__cpufreq_driver_target(policy, freq, od_tuners->powersave_bias ?
-			CPUFREQ_RELATION_LE : CPUFREQ_RELATION_HE);
+	gov_freq_request(policy, freq, od_tuners->powersave_bias ?
+			 CPUFREQ_RELATION_LE : CPUFREQ_RELATION_HE);
 }
 
 /*
@@ -142,7 +142,7 @@ static void od_update(struct cpufreq_policy *policy)
 								 freq_next,
 								 CPUFREQ_RELATION_LE);
 
-		__cpufreq_driver_target(policy, freq_next, CPUFREQ_RELATION_CE);
+		gov_freq_request(policy, freq_next, CPUFREQ_RELATION_CE);
 	}
 }
 
@@ -160,8 +160,8 @@ static unsigned int od_dbs_update(struct cpufreq_policy *policy)
 	 * it then.
 	 */
 	if (sample_type == OD_SUB_SAMPLE && policy_dbs->sample_delay_ns > 0) {
-		__cpufreq_driver_target(policy, dbs_info->freq_lo,
-					CPUFREQ_RELATION_HE);
+		gov_freq_request(policy, dbs_info->freq_lo,
+				 CPUFREQ_RELATION_HE);
 		return dbs_info->freq_lo_delay_us;
 	}
 
-- 
2.33.0


