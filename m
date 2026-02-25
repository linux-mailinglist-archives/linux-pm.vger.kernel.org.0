Return-Path: <linux-pm+bounces-43195-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHoXBhu4nmnwWwQAu9opvQ
	(envelope-from <linux-pm+bounces-43195-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 09:51:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC5F1946A3
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 09:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 586E430913F7
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 08:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD61331D381;
	Wed, 25 Feb 2026 08:50:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15943115BD;
	Wed, 25 Feb 2026 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772009403; cv=none; b=dU0dcTCzxyy6UDsQ06/L6LNwEP0v+E965CeP+8YKkEUsGC7gUhMfCZecn8qwaGVwkX4KpF9JDVJRJDDE0zibxkPATkO54DaXxxCHQEKhap7I7JkTcqqYmY4UdKaNijMWs9wd1y8plL97PJH9xxqkzk5j6xLs5ukzyq9PmcpiLo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772009403; c=relaxed/simple;
	bh=WBZ8irYDkD+ZH3PFhsp9vgFr2ImxtrjhxlO9Fx2Li8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfRE33EN5Z7RSrLNcz8tsnajFAymsTy0aV9nV4bYpEkdyOpwibaN9v+vh6g98Msv1hFjTPmqm+pg+nJR5lsHlcvwgTS/IeP2PDRfSYVaIQr+LwcmahYqaCFg6JlaRqc1BuakZph9nJk88HV3BWcpQEO6FLFIPZ+Nk1ZLkNTqE54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 807C3165C;
	Wed, 25 Feb 2026 00:49:55 -0800 (PST)
Received: from e135073.nice.arm.com (e135073.arm.com [10.34.125.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 652333F59E;
	Wed, 25 Feb 2026 00:49:58 -0800 (PST)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 3/6] cpufreq: Centralize boost freq QoS requests
Date: Wed, 25 Feb 2026 09:49:20 +0100
Message-ID: <20260225084930.1692228-4-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225084930.1692228-1-pierre.gondois@arm.com>
References: <20260225084930.1692228-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-43195-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:mid,arm.com:email]
X-Rspamd-Queue-Id: 8FC5F1946A3
X-Rspamd-Action: no action

policy_set_boost() calls the cpufreq set_boost callback.
Update the newly added boost_freq_req request from there:
- whenever boost is toggled
- to cover all possible paths

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/cpufreq.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 50467b938668a..42de32488f422 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -603,10 +603,19 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
 	policy->boost_enabled = enable;
 
 	ret = cpufreq_driver->set_boost(policy, enable);
-	if (ret)
+	if (ret) {
 		policy->boost_enabled = !policy->boost_enabled;
+		return ret;
+	}
 
-	return ret;
+	ret = freq_qos_update_request(policy->boost_freq_req, policy->cpuinfo.max_freq);
+	if (ret < 0) {
+		policy->boost_enabled = !policy->boost_enabled;
+		cpufreq_driver->set_boost(policy, policy->boost_enabled);
+		return ret;
+	}
+
+	return 0;
 }
 
 static ssize_t store_local_boost(struct cpufreq_policy *policy,
-- 
2.43.0


