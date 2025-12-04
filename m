Return-Path: <linux-pm+bounces-39191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D0ACA32C0
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 11:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A70603026225
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 10:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FEF32C94C;
	Thu,  4 Dec 2025 10:13:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8F82BDC13;
	Thu,  4 Dec 2025 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764843239; cv=none; b=VpyYp28OF7cNqyZphhfQzrkT73O7LcZqykHAQzG9xV0dlfjQvOWXWnWk3cjpvjYb6vh17wUKUK0MX6qsNETcitkWLsp0YXlM0KA5uM5BMWwu05ab+hbvCeSv9fpCnP3n9Jirw69dDl5XYImhTllg42DpLOq4hXCMIdoF+J0KAfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764843239; c=relaxed/simple;
	bh=X2jhDNQz8Fz9amrXxn4dKoXKzyWRc4H4dE/W7kQoDVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZUwlrgcWKQP9BQOWUy9nJwtLFwWQvdU/7ScUhtg4Iv/sVN2G32v/zQEr472/o6Q3xkCyjN8kUC8pkCu3FJwYdLXJyOffm/3JTuX3JkV8AoXLM2EE7kVg/nfSIEfpOWow0ECfT8wlY7o+B8TAsf0daSdtm7OAdVkbnpV9emZ+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CFFC339;
	Thu,  4 Dec 2025 02:13:49 -0800 (PST)
Received: from e135073.nice.arm.com (e135073.arm.com [10.34.125.22])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C1C333F73B;
	Thu,  4 Dec 2025 02:13:53 -0800 (PST)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Christian Loehle <christian.loehle@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	zhenglifeng1@huawei.com,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 0/4] cpufreq: Introduce boot frequency QoS
Date: Thu,  4 Dec 2025 11:13:36 +0100
Message-ID: <20251204101344.192678-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

The patches might be eligible for a stable tag.

Pierre Gondois (4):
  Revert "cpufreq: Fix re-boost issue after hotplugging a CPU"
  cpufreq: Add boost_freq_req QoS request
  cpufreq: Centralize boost freq QoS requests
  cpufreq: Update set_boost callbacks to rely on boost_freq_req

 drivers/cpufreq/amd-pstate.c   |  2 --
 drivers/cpufreq/cppc_cpufreq.c | 20 +++---------
 drivers/cpufreq/cpufreq.c      | 59 ++++++++++++++++++++++++++--------
 include/linux/cpufreq.h        |  1 +
 4 files changed, 50 insertions(+), 32 deletions(-)

--
2.43.0

