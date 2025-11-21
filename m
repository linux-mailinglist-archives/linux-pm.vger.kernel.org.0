Return-Path: <linux-pm+bounces-38327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F31C76D9E
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 02:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 7103132107
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 01:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480E8276028;
	Fri, 21 Nov 2025 01:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="hr1YTfTG"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5B925C6F9
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 01:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763687334; cv=none; b=AXsMd5KuC4G04uTr5/Bc9G2jkwrVat5ozSE8P4q5ukrQBfRY90TmpTRv3g2DJmwtHnEQqaBEaQboik+6cgOIMfgjxx0pX59fC7SKpV7zmCF+xXCRS+fkFktw8Fh7rqPCLZawAkedosGa0qFUBgmb00uI2/9xE1pnmWFY/+QCz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763687334; c=relaxed/simple;
	bh=M/c2EXnK5JDRsjyRnYsqBIEMPL8YziewH0mBQGmD2pM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QdlrrD3e9eiftoMEv6k19bfsjT0yQtdDQGBP+NRwzwWjaVax38TDSAler+4EjlJeLRVwUbuYA4XkCGmGhhIq9HrRqgJsrQrVEe/MHeMvkopfFekJKFI+JXXcUvbqzLvq0DlH+AUggIeV2kiaLsI8oguwLzoIHnYqrhnm+YMx+R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=hr1YTfTG; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1763687318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z0lB3o3SwbOYKkV5Q0JuzwgjnjNnSnFiQ4AX0Mcpicc=;
	b=hr1YTfTGgd3PUDkIDH8vn+xaYQpiQITjQ3PP0CMHGeD8WcxNAvTZrwlOMVZrQhzR4Uxv90
	gGgxueXVuH+AaZpaDdFgwVyiGuC0a2Lndd0SgjdVFVkc7u2sQiXYAse8bePoDwLcusu8kf
	5OAoB0LOJOlNr6V7k2ztBBiQ15XZnMc0pJNOQBHKLXzkAtK6aTm4QI6mh12j2EmJxiSXUj
	l4OUqwpovtt1127jPykIjltcD2WfJNpTWlEue++3PxNUDRjh3+OIOS48xlHLt2ZqfND+1v
	lXNQJ/gYNQyEvlwJvVcKfgVoS/LEdfO/nnhTcCeDNFyfh4+/StvL7uttO6SI4w==
From: Val Packett <val@packett.cool>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: Val Packett <val@packett.cool>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpuidle: warn and fixup on sanity check instead of rejecting the driver
Date: Thu, 20 Nov 2025 22:06:25 -0300
Message-ID: <20251121010756.6687-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Device Tree platforms, the latency and target residency values come
directly from device trees, which are numerous and weren't all written
with cpuidle invariants in mind. For example, qcom/hamoa.dtsi currently
trips this check: exit latency 680000 > residency 600000.

Instead of harshly rejecting the entire cpuidle driver with a mysterious
error message, print a warning and set the target residency value to be
equal to the exit latency.

Fixes: 76934e495cdc ("cpuidle: Add sanity check for exit latency and target residency")
Signed-off-by: Val Packett <val@packett.cool>
---
 drivers/cpuidle/driver.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 1c295a93d582..06aeb59c1017 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -199,8 +199,11 @@ static int __cpuidle_driver_init(struct cpuidle_driver *drv)
 		 * exceed its target residency which is assumed in cpuidle in
 		 * multiple places.
 		 */
-		if (s->exit_latency_ns > s->target_residency_ns)
-			return -EINVAL;
+		if (s->exit_latency_ns > s->target_residency_ns) {
+			pr_warn("cpuidle: state %d: exit latency %lld > residency %lld (fixing)\n",
+				i, s->exit_latency_ns, s->target_residency_ns);
+			s->target_residency_ns = s->exit_latency_ns;
+		}
 	}
 
 	return 0;
-- 
2.51.0


