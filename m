Return-Path: <linux-pm+bounces-43198-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDVILfK3nmnwWwQAu9opvQ
	(envelope-from <linux-pm+bounces-43198-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 09:50:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 666A9194678
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 09:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E2F03040FDB
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 08:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDC83242D7;
	Wed, 25 Feb 2026 08:50:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2D7325711;
	Wed, 25 Feb 2026 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772009417; cv=none; b=YSOlDuxpPvTVowMHArGMtv6LdZVIfXWqZOYEhtoRPblQPY3jlS2HNjE/f7RHmxhLXM2PjZV1pd+IgPAoZMcJNyj+K95VqCO/uM2Xy2cHXdPSjFI07xgE9E9WP3RSTEBRKKcbC11+4UAY3I7MvvoccOywAITfhNdzRe9FQEjEStI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772009417; c=relaxed/simple;
	bh=dsB++htWglnJo1qJa8OcgIx7Ri+H3o9ijvfmCEjgPvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6dPRRyOvCGAVqdjVgSzGLmYAMduF+mUyAWh9zuYWTC/BwSon9RR0GDG7yE9KYjE2Aq00A331dvShfnhrSLlLHmPsQqZM4sBua3A2OavCgIAsiwDaivhmnFctcJXDAQIe5TbXplzMoFY71G72t8MekX/e4disGfTXNnRuBZMKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2926A169E;
	Wed, 25 Feb 2026 00:50:09 -0800 (PST)
Received: from e135073.nice.arm.com (e135073.arm.com [10.34.125.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E3EAC3F59E;
	Wed, 25 Feb 2026 00:50:11 -0800 (PST)
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
Subject: [RFC PATCH v5 6/6] cpufreq/freq_table: Allow decreasing cpuinfo.max_freq
Date: Wed, 25 Feb 2026 09:49:23 +0100
Message-ID: <20260225084930.1692228-7-pierre.gondois@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-43198-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:mid,arm.com:email]
X-Rspamd-Queue-Id: 666A9194678
X-Rspamd-Action: no action

Drivers not using freq. tables update cpuinfo.max_freq in their
.set_boost() callback. E.g. amd-pstate, cppc_cpufreq.
Drivers relying on freq. tables and supporting boost frequencies
rely on cpufreq_frequency_table_cpuinfo(). cpuinfo.max_freq is
only updated if the new maximal value is higher than the previous
one.

Using the scmi-cpufreq driver which relies on freq. tables, enabling
boost will permanently increases the cpuinfo.max_freq value.
This patch allows to lower cpuinfo.max_freq.

Note:
commit 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly
if max boost is known")
favored having cpuinfo.max_freq reporting the maximal boosted
frequency of a CPU instead of the maximal reachable frequency
due to regressions in the frequency reported by cpuinfo.max
and scaling_cur_freq.
As stated above, this is not what most of the other cpufreq driver
do. I assume that the following patch:
commit 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to
cover boost frequencies")
was correct, but might not have tagged the boosted frequency with
the CPUFREQ_BOOST_FREQ flag in the freq. table.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/freq_table.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 9b37f37c36389..bd08cbe9e9ba3 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -50,12 +50,7 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
 	}

 	policy->cpuinfo.min_freq = min_freq;
-	/*
-	 * If the driver has set its own cpuinfo.max_freq above max_freq, leave
-	 * it as is.
-	 */
-	if (policy->cpuinfo.max_freq < max_freq)
-		policy->cpuinfo.max_freq = max_freq;
+	policy->cpuinfo.max_freq = max_freq;

 	if (min_freq == ~0)
 		return -EINVAL;
--
2.43.0

