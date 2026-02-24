Return-Path: <linux-pm+bounces-43153-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N7fGQDcnWmuSQQAu9opvQ
	(envelope-from <linux-pm+bounces-43153-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 18:12:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C514218A5CA
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 18:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D6DB30480D8
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 17:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7723A9622;
	Tue, 24 Feb 2026 17:08:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0C33A7848;
	Tue, 24 Feb 2026 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952921; cv=none; b=nN54JN7AJTnETp+FIiO1j+8h29O9WcCxZSBW9PlvGqVYRRBryBqrYVpv6ktwuBpZn3ZPeEJ30NKreqg+rELrCfnm/aTlY34careSVhO0O2Q0HuR4VYXL4YWQ3oEbf1AqTSWQ46FOJjb0OmgpKnPpNLwwUoH55CrvhpJ+bqsHeAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952921; c=relaxed/simple;
	bh=NghSTe8nSiAwWTX19mZD6F0Nxq5p3llY03byaNcuQEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sv22F08C9U+2u2d3j/NAHl4NFbLwdR1v7Ki8b26hUCOZVuu+BiLlxUv7Yf0vNuIB210UB2sZHHhDCyvu0iuwNTVW8HjpPiLdu+6zctLS49LDe8kckVI+5aZm+s9CjBoYKEm5L/H9gBsHbVoiZvpMbyREndPNDxXdRi+W4USg9kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 130B2339;
	Tue, 24 Feb 2026 09:08:31 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.71.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF7D03F59E;
	Tue, 24 Feb 2026 09:08:33 -0800 (PST)
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
Subject: [PATCH v4 0/6] cpufreq: Introduce boost frequency QoS
Date: Tue, 24 Feb 2026 18:08:15 +0100
Message-ID: <20260224170828.1635135-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-43153-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:mid]
X-Rspamd-Queue-Id: C514218A5CA
X-Rspamd-Action: no action

The Power Management Quality of Service (PM QoS) allows to
aggregate constraints from multiple entities. It is currently
used to manage the min/max frequency of a given policy.

Frequency constraints can come from:
- Thermal framework: acpi_thermal_cpufreq_init()
- Firmware: _PPC objects: acpi_processor_ppc_init()
- User: by setting policyX/scaling_[min|max]_freq
The minimum of the max frequency constraints is used to compute
the resulting maximum allowed frequency.

When enabling boost frequencies, the same frequency request object
(policy->max_freq_req) as to handle requests from users is used.
As a result, when setting:
- scaling_max_freq
- boost
The last sysfs file used overwrites the request from the other
sysfs file.

To avoid this:
1. Create a per-policy boost_freq_req to save the boost
constraints instead of overwriting the last scaling_max_freq
constraint.

2. policy_set_boost() calls the cpufreq set_boost callback.
Update the newly added boost_freq_req request from there:
- whenever boost is toggled
- to cover all possible paths

3. In the existing set_boost() callbacks:
- Don't update policy->max as this is done through the qos notifier
  cpufreq_notifier_max() which calls cpufreq_set_policy().
- Remove freq_qos_update_request() calls as the qos request is now
  done in policy_set_boost() and updates the new boost_freq_req

This patch-set additionally does:
- if a driver .init() callback sets policy->min and policy->max,
  these values are used are min/max_freq_req QoS constraints
- Remove policy->min and policy->max initialization in .init()
  callback if the value is identical to cpuinfo.min/max_freq
- RFC: allow decreasing cpuinfo.max_freq when using freq_table.

------------

E.g.:
On a Juno with available frequencies: 600.000, 1.000.000
Boost frequencies: 1.200.000
Using the cppc-cpufreq driver.

---
Without the patches:
# ## Init state
scaling_max_freq:1000000
cpuinfo_max_freq:1000000

# echo 700000 > scaling_max_freq
scaling_max_freq:700000
cpuinfo_max_freq:1000000

# echo 1 > ../boost
scaling_max_freq:1200000
cpuinfo_max_freq:1200000

# echo 800000 > scaling_max_freq
scaling_max_freq:800000
cpuinfo_max_freq:1200000

# echo 0 > ../boost
scaling_max_freq:1000000
cpuinfo_max_freq:1000000

---
With the patches:
# ## Init
scaling_max_freq:1000000
cpuinfo_max_freq:1000000

# echo 700000 > scaling_max_freq
scaling_max_freq:700000
cpuinfo_max_freq:1000000

# echo 1 > ../boost
scaling_max_freq:700000
cpuinfo_max_freq:1200000

# echo 800000 > scaling_max_freq
scaling_max_freq:800000
cpuinfo_max_freq:1200000

# echo 0 > ../boost
scaling_max_freq:800000
cpuinfo_max_freq:1000000

---

With the patches, the maximum scaling frequency requested is
conserved even though boosting is enabled/disabled.

---

v1: https://lore.kernel.org/all/20251204101344.192678-1-pierre.gondois@arm.com/#t
v2: https://lore.kernel.org/all/20251208105933.1369125-1-pierre.gondois@arm.com/#t
Changes:
- Fixed error path
- Integrated [PATCH 1/4] Revert "cpufreq: Fix re-boost issue after hotplugging a CPU"
  to another patch
v3:
Changes:
- Fixed error path
- Extracted the revert of:
  "cpufreq: Fix re-boost issue after hotplugging a CPU"
  for clarity purpose
- Set cpuinfo.max_freq as a max_freq_req QoS constraint by default
New patches:
- "cpufreq: Allow decreasing cpuinfo.max_freq"
- "cpufreq: Set policy->min and max as QoS constraints"
v4:
- Correct reported issues

---

Pierre Gondois (6):
  cpufreq: Remove per-CPU QoS constraint
  cpufreq: Add boost_freq_req QoS request
  cpufreq: Centralize boost freq QoS requests
  cpufreq: Update .set_boost() callbacks to rely on boost_freq_req
  cpufreq: Set policy->min and max as real QoS constraints
  cpufreq/freq_table: Allow decreasing cpuinfo.max_freq

 drivers/cpufreq/acpi-cpufreq.c    |  1 +
 drivers/cpufreq/amd-pstate.c      | 26 +++++----
 drivers/cpufreq/cppc_cpufreq.c    | 10 +---
 drivers/cpufreq/cpufreq-nforce2.c |  4 +-
 drivers/cpufreq/cpufreq.c         | 88 +++++++++++++++++++++++--------
 drivers/cpufreq/freq_table.c      | 14 ++---
 drivers/cpufreq/gx-suspmod.c      |  9 ++--
 drivers/cpufreq/intel_pstate.c    |  3 --
 drivers/cpufreq/pcc-cpufreq.c     |  8 +--
 drivers/cpufreq/pxa3xx-cpufreq.c  |  4 +-
 drivers/cpufreq/virtual-cpufreq.c |  5 +-
 include/linux/cpufreq.h           |  1 +
 12 files changed, 100 insertions(+), 73 deletions(-)

--
2.43.0

