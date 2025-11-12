Return-Path: <linux-pm+bounces-37852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40F3C537AD
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 17:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B38502FCD
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 16:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28B133F372;
	Wed, 12 Nov 2025 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLt97/X3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4EC33F36D;
	Wed, 12 Nov 2025 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964773; cv=none; b=a8fL4zMZQUZMYk+IP/y6+cMGrurLEYo+oFjNKj+pL8wQgIcgs64TXy/vhXDfCFKyXsijQcOMDtKo/4wGm6rSMtgKgk7tOp/mRJKBZgW3jsUgXx34QLan9lw0IBO8eGaxwOgyMknmCrISqObWZ8zvATyVZRmBzWL2E3r1AuMYjJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964773; c=relaxed/simple;
	bh=FvQTca1f1kUbxhOefqJtNOjPp0/EO7kKIOVQ3Sbp5R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IT2MiN/dNTioPtKofLFVZzUxUf303ALIDvCBSbCC0E04dCkH0qmCWb9CVh0tM0kXneYs5sgpHxXXnS4yGjyloCPOfg+6itB4SWPt+Pu/3Rh6nNfki0UBw0CPWhpeSei/BCsOSPekP2426AkPDxB6msiYV9ILLzdc9wuZvxMxMa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLt97/X3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED684C19422;
	Wed, 12 Nov 2025 16:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762964773;
	bh=FvQTca1f1kUbxhOefqJtNOjPp0/EO7kKIOVQ3Sbp5R8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iLt97/X3KHt3ivYex1Cd2R88LSeKbUd8Qm9dnqqQgYzTY4QJ+NS727tr72kTcuWs8
	 3nBxq3OnsdNVD8FD1M3dbb93RbfIk3gVr2aNwu8GEx/4ALZsWm8UWBGs6SWrr+QBq2
	 110SKrdr9lr4l5I7pA5NtPBLWMhgbMTlbdpx02HNpZFrgpH/l6TDORb3llNk2K/AUs
	 whKFh4OH77Mh9wrRPR+ufiNQ4hXPyCIT6QxFfolcXaf1ge09baRCxSf1tq8Xasnz3h
	 T4cXuqBN6CeCg1/uG5Sy1nUkaAx0wNETUWDZ5NLGe5HJNFZBgcmz0iwm2bdxEx9ntB
	 UbuPjOIleny/A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Reka Norman <rekanorman@chromium.org>
Subject:
 [PATCH v1 3/4] cpuidle: governors: teo: Use s64 consistently in teo_update()
Date: Wed, 12 Nov 2025 17:24:40 +0100
Message-ID: <3026616.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4701737.LvFx2qVVIh@rafael.j.wysocki>
References: <4701737.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Two local variables in teo_update() are defined as u64, but their
values are then compared with s64 values, so it is more consistent
to use s64 as their data type.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -157,8 +157,7 @@ static void teo_update(struct cpuidle_dr
 {
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
 	int i, idx_timer = 0, idx_duration = 0;
-	s64 target_residency_ns;
-	u64 measured_ns;
+	s64 target_residency_ns, measured_ns;
 
 	cpu_data->short_idles -= cpu_data->short_idles >> DECAY_SHIFT;
 
@@ -167,9 +166,9 @@ static void teo_update(struct cpuidle_dr
 		 * If one of the safety nets has triggered, assume that this
 		 * might have been a long sleep.
 		 */
-		measured_ns = U64_MAX;
+		measured_ns = S64_MAX;
 	} else {
-		u64 lat_ns = drv->states[dev->last_state_idx].exit_latency_ns;
+		s64 lat_ns = drv->states[dev->last_state_idx].exit_latency_ns;
 
 		measured_ns = dev->last_residency_ns;
 		/*




