Return-Path: <linux-pm+bounces-41460-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MH0DDRAd2mMdQEAu9opvQ
	(envelope-from <linux-pm+bounces-41460-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 11:21:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5060886BF4
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 11:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E5DE3007A57
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 10:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF5F33121B;
	Mon, 26 Jan 2026 10:19:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD99330D47;
	Mon, 26 Jan 2026 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422761; cv=none; b=PzvMnEN9lAkrUPbJsGoHTxzRnPiqXviZ5zQJLS589cDbcv7SFIFvoZOpe45Tcd+ktDKwo/+P4YHsLkb5R+MIOp/dChp995R7XSyyM8g+XzptSxN4PSzTf2JlzcvKB0hdsUJ4xhuq4cRhIMWHd9CzdtUyuTMdxi8dGYx709tlN5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422761; c=relaxed/simple;
	bh=dsB++htWglnJo1qJa8OcgIx7Ri+H3o9ijvfmCEjgPvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJo6gJZtfl5boxgDoee4DoZIhu7svQrhp59CuXbxscxpLKnqOCuonsNwym5uoyOQPV7LRoMIJIDoImg7Br2GXTxPLmI62tbI6DqpMjgLehPYPa/j9IiaJ3aGcuTBFYhaIbQ2w+MLqTqFXJqL8UXz8vtms9YvoxiF8COheYD9qNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 975BE339;
	Mon, 26 Jan 2026 02:19:12 -0800 (PST)
Received: from e135073.nice.arm.com (e135073.arm.com [10.34.125.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8DE993F632;
	Mon, 26 Jan 2026 02:19:15 -0800 (PST)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
	zhenglifeng1@huawei.com,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	sumitg@nvidia.com,
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
Subject: [RFC PATCH 6/6] cpufreq/freq_table: Allow decreasing cpuinfo.max_freq
Date: Mon, 26 Jan 2026 11:18:15 +0100
Message-ID: <20260126101826.94030-7-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126101826.94030-1-pierre.gondois@arm.com>
References: <20260126101826.94030-1-pierre.gondois@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-41460-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arm.com:mid,arm.com:email]
X-Rspamd-Queue-Id: 5060886BF4
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

