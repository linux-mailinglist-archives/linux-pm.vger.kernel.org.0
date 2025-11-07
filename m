Return-Path: <linux-pm+bounces-37646-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B196C41622
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 20:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E6A189BDC8
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 19:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0B4299ABF;
	Fri,  7 Nov 2025 19:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBhrDtkL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51981DB125;
	Fri,  7 Nov 2025 19:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762542453; cv=none; b=pHLml3CALBirXZTsXQC/mNH3BvVByNK2m01QVkMIfwoycGLAr3qAhysLJ+zQGnwnKLTLPZR0YiTj5wxdgxdYZ1VkIXa6ur6nlbjlrfQNNblMYtScneyc63P78T0/pGpasWL6D1fGO9bvTNzRnm2coWQbkMmu/9HpxqPV/vvB63E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762542453; c=relaxed/simple;
	bh=sryXcWbfbtKjRhof6o+o8YX3yFfe5opZuYDtIKsbm60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m3ED+qEl0OGkOPNNhA3YOIC8HJet7f9aJI3zAM5aq6NB5A5/6+KX0ZpSbAQf+lcOTKTQYJ2AJ+1MK/oFAAGUJ1HvSrSUlkRc+7gokyM4/ptr9nUUi2XW2nj4MdHGhDpIgFgEjIqah9YyhPfnv1+i9TDYQXaJ/+bnJRpHRa+PruQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBhrDtkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD42C4CEF8;
	Fri,  7 Nov 2025 19:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762542453;
	bh=sryXcWbfbtKjRhof6o+o8YX3yFfe5opZuYDtIKsbm60=;
	h=From:To:Cc:Subject:Date:From;
	b=vBhrDtkLzYRm/MJdhjPL6tLdpXslkDBcJKP5fty38Lu4v2z470PKURpRjuueEt2C4
	 Os6l8FPmzZmGVLVjxv0FXFOHMjifKxrFYYEHZO0YucLG52WFkZ38df/0/8WIrtX/1U
	 nCx3ZDUCk3T9POoXZuNLwgxCgWZKuGK7/a+XD5sCUwXKXy2a0uByEMT0RX2cir7ZUF
	 agMFrtbZ3cTiRp5JMhygrmjYTv9tu2O/G4VySOf+T+cdWhbk5ulRz9qPTmtmYIb5LR
	 uYfO5+NPFsmFprcLL3AgZ2xhJh6dWW9NJRvIMqwIw3CLgv0jVhoB58jy299x6M6L70
	 hg2UyftlSczvQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v2] cpuidle: Add sanity check for exit latency and target residency
Date: Fri, 07 Nov 2025 20:07:28 +0100
Message-ID: <12779486.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make __cpuidle_driver_init() fail if the exit latency of one of the
driver's idle states is less than its exit latency which would break
cpuidle assumptions.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Make __cpuidle_driver_init() fail if the check is not passed (Artem).

---
 drivers/cpuidle/driver.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -152,7 +152,7 @@ static void cpuidle_setup_broadcast_time
  * __cpuidle_driver_init - initialize the driver's internal data
  * @drv: a valid pointer to a struct cpuidle_driver
  */
-static void __cpuidle_driver_init(struct cpuidle_driver *drv)
+static int __cpuidle_driver_init(struct cpuidle_driver *drv)
 {
 	int i;
 
@@ -193,7 +193,17 @@ static void __cpuidle_driver_init(struct
 			s->exit_latency_ns =  0;
 		else
 			s->exit_latency = div_u64(s->exit_latency_ns, NSEC_PER_USEC);
+
+		/*
+		 * Ensure that the exit latency of a CPU idle state does not
+		 * exceed its target residency which is assumed in cpuidle in
+		 * multiple places.
+		 */
+		if (s->exit_latency_ns > s->target_residency_ns)
+			return -EINVAL;
 	}
+
+	return 0;
 }
 
 /**
@@ -223,7 +233,9 @@ static int __cpuidle_register_driver(str
 	if (cpuidle_disabled())
 		return -ENODEV;
 
-	__cpuidle_driver_init(drv);
+	ret = __cpuidle_driver_init(drv);
+	if (ret)
+		return ret;
 
 	ret = __cpuidle_set_driver(drv);
 	if (ret)




