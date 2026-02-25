Return-Path: <linux-pm+bounces-43192-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIDmILS3nmnwWwQAu9opvQ
	(envelope-from <linux-pm+bounces-43192-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 09:49:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BD8194646
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 09:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0CCF03016B1A
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 08:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423A531159C;
	Wed, 25 Feb 2026 08:49:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963982C11D6;
	Wed, 25 Feb 2026 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772009390; cv=none; b=HhRlONLTgZrmxrAyCvH3cSU4yJZ/4rXklycSAFnWNBiBopNqx154tBNwN5EssEw902LyozbgxLcnei4HSZECuSX8H4ZESLKSKZ8T9YG1up/eCyS8sbKf6yW0qqNpqrLzb+pLXk5U5tUgmx1zYH7gzm8oBggeNMZnaDd6ZJDQKf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772009390; c=relaxed/simple;
	bh=ZKLX9it0c7wM/VgM0KE/W+kVgR8SsagJetxAb+NMkG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ifn7optpLyECtLJKOhLTuG3euqPtrYtu9utMx9+DaPQWPNzZiyLa71ZMLVE8x3kSFtwfNzSu37gnXH4pRluFHdw22N86kHzoPxxEb1wljdV/UgwFkqp+37jlIMiemU8/JvsrV1ddu0Nsi5EeG3XIjRxYgUOXDXfhkRKKLeC2kwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BAA4165C;
	Wed, 25 Feb 2026 00:49:41 -0800 (PST)
Received: from e135073.nice.arm.com (e135073.arm.com [10.34.125.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 50A7D3F59E;
	Wed, 25 Feb 2026 00:49:44 -0800 (PST)
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
Subject: [PATCH v5 0/6] cpufreq: Introduce boost frequency QoS
Date: Wed, 25 Feb 2026 09:49:17 +0100
Message-ID: <20260225084930.1692228-1-pierre.gondois@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-43192-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid]
X-Rspamd-Queue-Id: A6BD8194646
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
v5:
- Corrections

Pierre Gondois (6):
  cpufreq: Remove per-CPU QoS constraint
  cpufreq: Add boost_freq_req QoS request
  cpufreq: Centralize boost freq QoS requests
  cpufreq: Update .set_boost() callbacks to rely on boost_freq_req
  cpufreq: Set policy->min and max as real QoS constraints
  cpufreq/freq_table: Allow decreasing cpuinfo.max_freq

 drivers/cpufreq/acpi-cpufreq.c    |  1 +
 drivers/cpufreq/amd-pstate.c      | 26 +++++-----
 drivers/cpufreq/cppc_cpufreq.c    | 10 +---
 drivers/cpufreq/cpufreq-nforce2.c |  4 +-
 drivers/cpufreq/cpufreq.c         | 84 +++++++++++++++++++++++--------
 drivers/cpufreq/freq_table.c      | 14 ++----
 drivers/cpufreq/gx-suspmod.c      |  9 ++--
 drivers/cpufreq/intel_pstate.c    |  3 --
 drivers/cpufreq/pcc-cpufreq.c     |  8 +--
 drivers/cpufreq/pxa3xx-cpufreq.c  |  4 +-
 drivers/cpufreq/virtual-cpufreq.c |  5 +-
 include/linux/cpufreq.h           |  1 +
 12 files changed, 96 insertions(+), 73 deletions(-)

--
2.43.0

