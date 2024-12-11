Return-Path: <linux-pm+bounces-19015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A5E9ECC0D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 13:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D798188489F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 12:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12799225A57;
	Wed, 11 Dec 2024 12:26:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7611F229139;
	Wed, 11 Dec 2024 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733919994; cv=none; b=KgVQVDqfddmoGh8/IdbLRJFPXeca0wRH5MY7IdulZvweu5XXNjwfpqf8gRWFjWY/Q1xKEVhc2Cp4fYv9pkHzOzAppw+9H5IZKjstVq0ip9R8AE3kAl/22ONS8wTvFnxpLCmnYWiFGt8NmtrpOSnWk8YeoaCdsD9RS0n01/a+K8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733919994; c=relaxed/simple;
	bh=1VG2yaHEbYqPxvj/8YriPFWgs/zn/sApY4f9nQmhDNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gnJk6vPG8sveptOY3vJq4yVo2TUOrbAd73+jNx7logSwvxD5XSLL7CZElMolMJB4RsMhr2N+IFNjYuAEtxZq1+S2CJmafhDOtaoCJcaDdn9+CqrphzHrW0SV0qJjxiq4S3Y4V74h8mQ3+2I429Wc7nnioa/j0KLacYcox38ECUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3025C1692;
	Wed, 11 Dec 2024 04:27:00 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.37.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 68C373F5A1;
	Wed, 11 Dec 2024 04:26:30 -0800 (PST)
From: Christian Loehle <christian.loehle@arm.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH 2/2] cpufreq: intel_pstate: Use CPUFREQ_POLICY_UNKNOWN
Date: Wed, 11 Dec 2024 12:26:05 +0000
Message-Id: <20241211122605.3048503-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211122605.3048503-1-christian.loehle@arm.com>
References: <20241211122605.3048503-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

epp_policy uses the same values as cpufreq_policy.policy and resets
to CPUFREQ_POLICY_UNKNOWN during offlining. Be consistent about
it and initialize to CPUFREQ_POLICY_UNKNOWN instead of 0, too.

No functional change intended.

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index b8e2396a708a..5dacd9d26879 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2709,7 +2709,7 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 	}
 
 	cpu->epp_powersave = -EINVAL;
-	cpu->epp_policy = 0;
+	cpu->epp_policy = CPUFREQ_POLICY_UNKNOWN;
 
 	intel_pstate_get_cpu_pstates(cpu);
 
-- 
2.34.1


