Return-Path: <linux-pm+bounces-43154-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IERTKiTbnWmuSQQAu9opvQ
	(envelope-from <linux-pm+bounces-43154-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 18:08:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 678BB18A526
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 18:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0291B3012D2F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 17:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB283A9624;
	Tue, 24 Feb 2026 17:08:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EFE3A9D89;
	Tue, 24 Feb 2026 17:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952924; cv=none; b=ER/QYBL1YvcLdcRMsrpwmDXhddSIeyX1ZF+3v0azhrVt0nFA7/dQxslm6OFcXdmV3nRZwpG/n22hT7KkZXLq/Xqy6OYK8EX+d9Es02H+zUwYI65gl/PHlmEhdEJ6l5pVG77e3HzAy0OSjIc1ms68qqKr26TjdX7w6XUCb8FTp4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952924; c=relaxed/simple;
	bh=0XuRh2d/myguiCEUP5T6yX1ZmrbAbjyTCrGGdy3n8YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGo8x/DUDDr3A7Izqnnynz5FruXEyF5fFpTCXWxSw9sFnAO9JlcLrBVebjkBG1vNBlk/ToF4txN6lyiVXVgMcPs+UfpSuAo/+vMZzhlpzs/PixcR1PClRl/F4Qk3puz9/ieWcWhNQ9KDmbX7qlQCOr5B/kb/zF+feHQ7LHf3wgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 149D5497;
	Tue, 24 Feb 2026 09:08:36 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.71.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B1BB53F59E;
	Tue, 24 Feb 2026 09:08:38 -0800 (PST)
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
Subject: [PATCH v4 1/6] cpufreq: Remove per-CPU QoS constraint
Date: Tue, 24 Feb 2026 18:08:16 +0100
Message-ID: <20260224170828.1635135-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224170828.1635135-1-pierre.gondois@arm.com>
References: <20260224170828.1635135-1-pierre.gondois@arm.com>
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
	TAGGED_FROM(0.00)[bounces-43154-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:mid,arm.com:email,huawei.com:email]
X-Rspamd-Queue-Id: 678BB18A526
X-Rspamd-Action: no action

policy->max_freq_req represents the maximum allowed frequency as
requested by the policyX/scaling_max_freq sysfs file. This request
applies to all CPUs of the policy. It is not possible to request
a per-CPU maximum frequency.

Thus, the interaction between the policy boost and scaling_max_freq
settings should be handled by adding a boost specific QoS constraint.
This will be handled in the following patches.

This patch reverts of:
commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging
a CPU")

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/cpufreq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4472bb1ec83c7..db414c052658b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1481,10 +1481,6 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 				CPUFREQ_CREATE_POLICY, policy);
-	} else {
-		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
-		if (ret < 0)
-			goto out_destroy_policy;
 	}
 
 	if (cpufreq_driver->get && has_target()) {
-- 
2.43.0


