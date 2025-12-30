Return-Path: <linux-pm+bounces-40033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F42DCE9383
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 10:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 027CA3011424
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 09:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977B32264C0;
	Tue, 30 Dec 2025 09:31:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC8C2BE7D1;
	Tue, 30 Dec 2025 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767087067; cv=none; b=bFit2oayjXBQZ1gcmluW9PZbwfq/8DRq3jYuNO4UzQqw9RTnK4w9Tpc5uW3m+W7ueFKq1jSHv5uuLE0yaBve+YJyil3eQFn/HI6192QF0pUni9ZEv0miw/AjlmDxaagxexoDu2hbvUhGEN1PR1T6MAuFy1R0gJsl97SgaUA+EE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767087067; c=relaxed/simple;
	bh=C/ELA4IIhciFbPXCMLd1GHQYpHfIvH2iwglrRgkcH1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ux/yIeFfB3L5g4TFGRRoQqEiIjTsBvBorNiO2XLQADUm1xRAWx5S5ZUF92Oy0OHRydwbkVURnWOF1aypoxKmSAL45w1C9aysK7wvDKy10Xs7AF7TR/yf5HX3IUm9czVv0JvGd2dMJsXPnsW6aqkcVd8zo5L7N/yPUMDnhoYurfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 302C21424;
	Tue, 30 Dec 2025 01:30:51 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.11.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6C2DF3F63F;
	Tue, 30 Dec 2025 01:30:56 -0800 (PST)
From: Christian Loehle <christian.loehle@arm.com>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com
Cc: rafael@kernel.org,
	qyousef@layalina.io,
	peterz@infradead.org,
	pierre.gondois@arm.com,
	qperret@google.com,
	sven@svenpeter.dev,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 1/1] sched/fair: Ignore OU for lone task on max-cap CPU
Date: Tue, 30 Dec 2025 09:30:37 +0000
Message-Id: <20251230093037.427141-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251230093037.427141-1-christian.loehle@arm.com>
References: <20251230093037.427141-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tasks that have an utilization high enough to trigger misfit or
overutilized on a max-cap CPU don't have any better CPU to be placed
on, as long as this CPU isn't under significant thermal or system
pressure. There's no reason to let it trigger the global
overutilized state then.
Treat maximum capacity CPUs with just a single task as !overutilized
to let EAS decide placements on the remaining tasks and CPUs, it will
already avoid placing additional tasks on these CPUs as they don't have
any spare capacity.

Overutilized state is global to 1) ensure maximum throughput and 2)
prevent running find_energy_efficient_cpu() with unreliable PELT values
when compute capacity isn't provided to tasks.
1) remains trivially true as for CAS the same 1024-capacity CPU would
have been a correct choice for a lone task, too.
2) is guaranteed by limiting it to nr_running <= 1, the task itself
then has accurate PELT values as maximum compute capacity can be provided
(also ensured by subtracting system and thermal pressure from the CPU).
EAS will naturally not place additional tasks on the CPU as
find_energy_efficient_cpu() requires the task's utilization to fit onto
the spare-cap (util_fits_cpu()), of which there is none in the scenario
we are concerned with.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/fair.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index da46c3164537..d885b2a0fcd3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6790,6 +6790,12 @@ static inline bool cpu_overutilized(int cpu)
 	if (!sched_energy_enabled())
 		return false;
 
+	/* Single task on max-cap CPU isn't misfit so no reason to trigger OU */
+	if (arch_scale_cpu_capacity(cpu) == SCHED_CAPACITY_SCALE &&
+	    cpu_rq(cpu)->nr_running <= 1 &&
+	    !capacity_greater(SCHED_CAPACITY_SCALE, capacity_of(cpu)))
+		return false;
+
 	rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
 	rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
 
-- 
2.34.1


