Return-Path: <linux-pm+bounces-37726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C53C46774
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 13:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96F734E3EA4
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 12:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9EA30C609;
	Mon, 10 Nov 2025 12:08:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BEC1D5141;
	Mon, 10 Nov 2025 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776523; cv=none; b=nGXzR/EhahHWIUcMkh15R2DDBwhZseHCppH0ma/GyIQx7IYJU0h3s1zRv2gwN12dP9aq4ep8Xt7wz+lgqWE+OSHicmk4ZZo9wcU5NOg9CL0aQf3IGFdF9HXIzg6sn2+6DLLXcMObHIzEFDLMMba0AxNm9G/LdLOsbm+rcMVd/2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776523; c=relaxed/simple;
	bh=FrQJuTs0dwGDa0mAmPEbVv5Qqur4l3oUNm/h5HXR86s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pL4Xtgej+mgWvrZ5lsgivKN0rl9197dCmvIg0qfxMNj7Lthwt4Wue71WgUQZL6sL+15ftIIUXUmPAq52WsQKtWxIeXAGV3HxGQkgfasLrEheje4rJsKPuqyrVDmwWdPOFoEaC4TrsjigHg07K/qP+OxFkTMl61aVppKkL92GszA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D55D497;
	Mon, 10 Nov 2025 04:08:33 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.34.30])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3936D3F66E;
	Mon, 10 Nov 2025 04:08:40 -0800 (PST)
From: Christian Loehle <christian.loehle@arm.com>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] cpuidle: teo: Use this_cpu_ptr where possible
Date: Mon, 10 Nov 2025 12:08:19 +0000
Message-Id: <20251110120819.714560-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpuidle governor callbacks for update, select and reflect
are always running on the actual idle entering/exiting CPU, so
use the more optimized this_cpu_ptr() to access the internal teo
data.

This brings down the latency-critical teo_reflect() from
static void teo_reflect(struct cpuidle_device *dev, int state)
{
ffffffc080ffcff0:	hint	#0x19
ffffffc080ffcff4:	stp	x29, x30, [sp, #-48]!
	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
ffffffc080ffcff8:	adrp	x2, ffffffc0848c0000 <gicv5_global_data+0x28>
{
ffffffc080ffcffc:	add	x29, sp, #0x0
ffffffc080ffd000:	stp	x19, x20, [sp, #16]
ffffffc080ffd004:	orr	x20, xzr, x0
	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
ffffffc080ffd008:	add	x0, x2, #0xc20
{
ffffffc080ffd00c:	stp	x21, x22, [sp, #32]
	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
ffffffc080ffd010:	adrp	x19, ffffffc083eb5000 <cpu_devices+0x78>
ffffffc080ffd014:	add	x19, x19, #0xbb0
ffffffc080ffd018:	ldr	w3, [x20, #4]

	dev->last_state_idx = state;

to

static void teo_reflect(struct cpuidle_device *dev, int state)
{
ffffffc080ffd034:	hint	#0x19
ffffffc080ffd038:	stp	x29, x30, [sp, #-48]!
ffffffc080ffd03c:	add	x29, sp, #0x0
ffffffc080ffd040:	stp	x19, x20, [sp, #16]
ffffffc080ffd044:	orr	x20, xzr, x0
	struct teo_cpu *cpu_data = this_cpu_ptr(&teo_cpus);
ffffffc080ffd048:	adrp	x19, ffffffc083eb5000 <cpu_devices+0x78>
{
ffffffc080ffd04c:	stp	x21, x22, [sp, #32]
	struct teo_cpu *cpu_data = this_cpu_ptr(&teo_cpus);
ffffffc080ffd050:	add	x19, x19, #0xbb0

	dev->last_state_idx = state;

This saves us:
	adrp    x2, ffffffc0848c0000 <gicv5_global_data+0x28>
	add     x0, x2, #0xc20
	ldr     w3, [x20, #4]

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpuidle/governors/teo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index bfa55c1eab5b..a3ebc2cda093 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -155,7 +155,7 @@ static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
  */
 static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
-	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
+	struct teo_cpu *cpu_data = this_cpu_ptr(&teo_cpus);
 	int i, idx_timer = 0, idx_duration = 0;
 	s64 target_residency_ns;
 	u64 measured_ns;
@@ -268,7 +268,7 @@ static int teo_find_shallower_state(struct cpuidle_driver *drv,
 static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		      bool *stop_tick)
 {
-	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
+	struct teo_cpu *cpu_data = this_cpu_ptr(&teo_cpus);
 	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
 	ktime_t delta_tick = TICK_NSEC / 2;
 	unsigned int idx_intercept_sum = 0;
@@ -504,7 +504,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
  */
 static void teo_reflect(struct cpuidle_device *dev, int state)
 {
-	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
+	struct teo_cpu *cpu_data = this_cpu_ptr(&teo_cpus);
 
 	dev->last_state_idx = state;
 	if (dev->poll_time_limit ||
-- 
2.34.1


