Return-Path: <linux-pm+bounces-35006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C604AB87189
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 23:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FDB0582EFF
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 21:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1C92ED848;
	Thu, 18 Sep 2025 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEpdzMxg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4736D2E0905;
	Thu, 18 Sep 2025 21:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230364; cv=none; b=IvZGwLkvqlJ+PS5BpvVDYdHUOrS0Op2EnGPHW3nSxsU0kTJAmxvRR9NUtBMzdMUVBmtD+pDD/2X+Dv2ubO1kEeW7+RSqjR8rFVzDZsG6chIEbELQ3ciBUfkgYcN9/ZiyfyHZy7Ik8GyXTnUsg4qfh1ZbqlGB4jGlQ9yQnF3dlt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230364; c=relaxed/simple;
	bh=iTkv4/jd5yTn1fHHuhHFJZgChsiArWlObzMiZKolph8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ufmv7w+qmE6/vAsVCNdOgN1283gmzsgpi5aSerGaXgsJdRroppU5jdV7XdQ8vQ/UmgV6kRIbOjdq3AB9dGKAopfJeMtVXgUz9YGSmRl0nE6E7PLCDOoRwbvWFzILaTUDa+BPq1turd+tmg08wnWGaITSGHYD2DkPDWLWY8A+b3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEpdzMxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFECC4CEE7;
	Thu, 18 Sep 2025 21:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758230363;
	bh=iTkv4/jd5yTn1fHHuhHFJZgChsiArWlObzMiZKolph8=;
	h=From:To:Cc:Subject:Date:From;
	b=jEpdzMxgjcpf2Ds7XVlFkbFyRu83CKD+Bo5MdQiQIh1FE84EgJ3+JjpFGmxoLb3BJ
	 QFkqqSVVZbimerKNTXQd6bo30FtYUyLFRuHoNyuO5NyIluhkBu/3ZAoPpttkFOMrTw
	 S5IuVK86nhPezZc0km0xQKfK3tR6pH/DeYnlBi2Q61b9NhTixG2OcXhnx218x8qKrc
	 pokmC9WDjhOWcaR0beBmtyQPznLn6maPaGLtAQPxAINkvPXo8V/v5+6Lxwj52AWKLL
	 8+fy1JtousTenOntUmx0jublh0Utljoit+46p1aemZ7KQKyTfFF5LIFI3Ud3QNLUpe
	 iHSrMyLEWqhrA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1] cpuidle: Fail cpuidle device registration if there is one already
Date: Thu, 18 Sep 2025 23:19:20 +0200
Message-ID: <3374815.aeNJFYEL58@rafael.j.wysocki>
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

Refuse to register a cpuidle device if the given CPU has a cpuidle
device already and print a message regarding it.

Without this, an attempt to register a new cpuidle device without
unregistering the existing one leads to the removal of the existing
cpuidle device without removing its sysfs interface.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/cpuidle.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -635,11 +635,17 @@ static void __cpuidle_device_init(struct
 static int __cpuidle_register_device(struct cpuidle_device *dev)
 {
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+	unsigned int cpu = dev->cpu;
 	int i, ret;
 
 	if (!try_module_get(drv->owner))
 		return -EINVAL;
 
+	if (per_cpu(cpuidle_devices, cpu)) {
+		pr_info("CPU%d: cpuidle device already registered\n", cpu);
+		return -EEXIST;
+	}
+
 	for (i = 0; i < drv->state_count; i++) {
 		if (drv->states[i].flags & CPUIDLE_FLAG_UNUSABLE)
 			dev->states_usage[i].disable |= CPUIDLE_STATE_DISABLED_BY_DRIVER;
@@ -648,7 +654,7 @@ static int __cpuidle_register_device(str
 			dev->states_usage[i].disable |= CPUIDLE_STATE_DISABLED_BY_USER;
 	}
 
-	per_cpu(cpuidle_devices, dev->cpu) = dev;
+	per_cpu(cpuidle_devices, cpu) = dev;
 	list_add(&dev->device_list, &cpuidle_detected_devices);
 
 	ret = cpuidle_coupled_register_device(dev);




