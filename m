Return-Path: <linux-pm+bounces-42446-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEKsMiwdi2nSPwAAu9opvQ
	(envelope-from <linux-pm+bounces-42446-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 12:57:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B75E11A7A7
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 12:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 615493038D19
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 11:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4338F329369;
	Tue, 10 Feb 2026 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JsnRuv4l"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500A4327C12;
	Tue, 10 Feb 2026 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724592; cv=none; b=hoYjN3rxu9q6cneADiuCGEX5KZce52ajxLdOB5NOVMstOgNs2NyXJtquB/gfXGKPPlP9O4DVRl9bhaYPvea2yPqaKLd3tsMdqTB2lqC4w0sq2NnMPV6/8wb30E7emgNhbT8F3ryHRxvxJQwt67vqrSten5loGtCgs05vK/SXu/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724592; c=relaxed/simple;
	bh=gKMRH/aLkRG1X8AMTxqq4G1qvUizMsrR814hGf7zKW4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iegxG3ypq78reDUt2nNkSpiup1xUoI9VLdhBtpPMyf558LMj2QPYo5mLZTG2gvf+QPG8mMhYQpoDgSKRsssoa6mZGlXGBOdtX8W+gp+CHJ/Y348Pcho7cyUd/Qs5uuVGrXC6ON6InuQ614zNLSIANReI5z8ffRlTFEus9LnUHDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JsnRuv4l; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pX2drFtYIUoNQzQZWGgYsvjHHfDRllFOEjGok0tW7FU=;
	b=JsnRuv4l/cL59vJVvX3+1zr9MhWRZEBba8jV2ve7Qdd9sncyRUowqygfdHfaOQbQF+mouBJFM
	dekYVUhcj2334v+/mwNvRShP9rmdQKYMZqlwCu54DTTLlapLG0Ej/c2EHifX+RzTPcCLvFy2fO1
	xsvfl/mfGMMtKKIK9NoeZXk=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f9KfP6vV6zKm4R;
	Tue, 10 Feb 2026 19:51:41 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D84940565;
	Tue, 10 Feb 2026 19:56:20 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200001.china.huawei.com (7.202.181.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Feb 2026 19:56:19 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>, <linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH 2/2] cpufreq: governor: Apply limits with requested_freq or next_freq
Date: Tue, 10 Feb 2026 19:54:58 +0800
Message-ID: <20260210115458.3493646-3-zhenglifeng1@huawei.com>
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
	TAGGED_FROM(0.00)[bounces-42446-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: 5B75E11A7A7
X-Rspamd-Action: no action

For conservative, ondemand and schedutil governor,
cpufreq_policy_apply_limits() is called in .limits(). This function updates
the target because the limits (policy->max and policy->min) may be changed.
However, it uses policy->cur as the reference for the target frequency.
This may cause some problems because the value of policy->cur is influenced
by a variety of factors.

For example, for some reason, the platform determines a final
frequency divided from the frequency distributed by the OS, and this is
reflected in policy->cur. After that, cpufreq_policy_apply_limits() is
called and because policy->cur is out of limmit, policy->min will be used
as the new target. This caused the real frequency lower but it's
unnecessary. Consertative and ondemand governor use requested_freq and
schedutil governor uses next_freq to represent the target frequency. It's
more reasonable to use them in cpufreq_policy_apply_limits().

At the same time, use policy->cur as the initial value of next_freq in
schedutil governor's start() callback.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cpufreq_governor.c | 2 +-
 include/linux/cpufreq.h            | 7 ++++---
 kernel/sched/cpufreq_schedutil.c   | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 7ec38407230f..dade45f7e57c 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -573,7 +573,7 @@ void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
 		goto out;
 
 	mutex_lock(&policy_dbs->update_mutex);
-	cpufreq_policy_apply_limits(policy);
+	cpufreq_policy_apply_limits(policy, policy_dbs->requested_freq);
 	gov_update_sample_delay(policy_dbs, 0);
 	mutex_unlock(&policy_dbs->update_mutex);
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 0465d1e6f72a..4d7341ef3645 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -657,12 +657,13 @@ static inline bool sugov_is_governor(struct cpufreq_policy *policy)
 }
 #endif
 
-static inline void cpufreq_policy_apply_limits(struct cpufreq_policy *policy)
+static inline void cpufreq_policy_apply_limits(struct cpufreq_policy *policy,
+					       unsigned int target_freq)
 {
-	if (policy->max < policy->cur)
+	if (policy->max < target_freq)
 		__cpufreq_driver_target(policy, policy->max,
 					CPUFREQ_RELATION_HE);
-	else if (policy->min > policy->cur)
+	else if (policy->min > target_freq)
 		__cpufreq_driver_target(policy, policy->min,
 					CPUFREQ_RELATION_LE);
 }
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 0ab5f9d4bc59..8d239fe3afa8 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -848,7 +848,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 
 	sg_policy->freq_update_delay_ns	= sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
 	sg_policy->last_freq_update_time	= 0;
-	sg_policy->next_freq			= 0;
+	sg_policy->next_freq			= policy->cur;
 	sg_policy->work_in_progress		= false;
 	sg_policy->limits_changed		= false;
 	sg_policy->cached_raw_freq		= 0;
@@ -895,7 +895,7 @@ static void sugov_limits(struct cpufreq_policy *policy)
 
 	if (!policy->fast_switch_enabled) {
 		mutex_lock(&sg_policy->work_lock);
-		cpufreq_policy_apply_limits(policy);
+		cpufreq_policy_apply_limits(policy, sg_policy->next_freq);
 		mutex_unlock(&sg_policy->work_lock);
 	}
 
-- 
2.33.0


