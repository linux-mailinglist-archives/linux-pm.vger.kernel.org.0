Return-Path: <linux-pm+bounces-37868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73124C53DC9
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 19:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 422E64E8DA6
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 18:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F27343214;
	Wed, 12 Nov 2025 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBiwJs1i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8CD340287;
	Wed, 12 Nov 2025 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970594; cv=none; b=IoXCju7d1iNP4h8klmrJQc+xoe5JFWhbIvnePPgxxO33bbxQqfan6LlUQVQTFR/ZembKt8U5un318QqwknMNLqD4lPVLE10sFql8akBZsCzXFK8az6NyZDFFthLahn+lMhYk5VQ1OFPGM8USthtPZcibbfBL5D+MmC0yuWzeg5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970594; c=relaxed/simple;
	bh=/VZT0uDclXjBF/6z0j3Sk67+QQJ/9MKcEX33vXe4+SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnVe40tNU9xYmuCFie1OeiWy9neypxGNyOR2DMFjBrlkbKms5VMNeL0b8Sl650udxEshMUeixGkipyREm8kPF+HedHAAYF1UjBJ8ndsqneTx99FDKhdcWmpIIKLaGeS1/D/TMCg1qD6LY2d2K9yAV4KLbYd05oSht2OOGdfj2uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBiwJs1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068D8C4CEF1;
	Wed, 12 Nov 2025 18:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762970593;
	bh=/VZT0uDclXjBF/6z0j3Sk67+QQJ/9MKcEX33vXe4+SQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RBiwJs1ijHcql7+RdsHdmllbbadepViIAAglfsiDE74++MkM22Bzfkk6KBc9rOBKn
	 J/KdLgch/+nLxwGsr01betPN40BIllAjcXkfleD2duxvNFoPhoDTRTmAnWNjHS9BQ9
	 9OWuTi/J9GcA/UDr0F3Edtzt97O/8fR8sQlpVXQemkqkysLxf/jCDpsbT7Y4mqFkgd
	 bNNrKiD1Wh/NGYTSoLajSM4di9lKlevMourSz47md17BDZqjLuJAyRig30zudabUP/
	 4YL4qFEm4RmZBUvXL9VIwtCuNqrroCSzjhSdPojQJlbURrzVtIyTbUl/6kgd/4DR9R
	 1WOTDzn3cmpsw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Reka Norman <rekanorman@chromium.org>
Subject:
 [PATCH v2 4/4] cpuidle: governors: teo: Decay metrics below DECAY_SHIFT
 threshold
Date: Wed, 12 Nov 2025 19:03:08 +0100
Message-ID: <2819353.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <3396811.44csPzL39Z@rafael.j.wysocki>
References:
 <4701737.LvFx2qVVIh@rafael.j.wysocki> <3396811.44csPzL39Z@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If a given governor metric falls below a certain value (8 for
DECAY_SHIFT equal to 3), it will not decay any more due to the
simplistic decay implementation.  This may in some cases lead to
subtle inconsistencies in the governor behavior, so change the
decay implementation to take it into account and set the metric
at hand to 0 in that case.

Suggested-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Ensure that cpu_data->total is always the sum of the intercepts and hits
     metrics for all of the idle states (Christian).

---
 drivers/cpuidle/governors/teo.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -148,6 +148,16 @@ struct teo_cpu {
 
 static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
 
+static void teo_decay(unsigned int *metric)
+{
+	unsigned int delta = *metric >> DECAY_SHIFT;
+
+	if (delta)
+		*metric -= delta;
+	else
+		*metric = 0;
+}
+
 /**
  * teo_update - Update CPU metrics after wakeup.
  * @drv: cpuidle driver containing state data.
@@ -158,8 +168,9 @@ static void teo_update(struct cpuidle_dr
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
 	int i, idx_timer = 0, idx_duration = 0;
 	s64 target_residency_ns, measured_ns;
+	unsigned int total = 0;
 
-	cpu_data->short_idles -= cpu_data->short_idles >> DECAY_SHIFT;
+	teo_decay(&cpu_data->short_idles);
 
 	if (cpu_data->artificial_wakeup) {
 		/*
@@ -195,8 +206,10 @@ static void teo_update(struct cpuidle_dr
 	for (i = 0; i < drv->state_count; i++) {
 		struct teo_bin *bin = &cpu_data->state_bins[i];
 
-		bin->hits -= bin->hits >> DECAY_SHIFT;
-		bin->intercepts -= bin->intercepts >> DECAY_SHIFT;
+		teo_decay(&bin->hits);
+		total += bin->hits;
+		teo_decay(&bin->intercepts);
+		total += bin->intercepts;
 
 		target_residency_ns = drv->states[i].target_residency_ns;
 
@@ -207,7 +220,9 @@ static void teo_update(struct cpuidle_dr
 		}
 	}
 
-	cpu_data->tick_intercepts -= cpu_data->tick_intercepts >> DECAY_SHIFT;
+	cpu_data->total = total + PULSE;
+
+	teo_decay(&cpu_data->tick_intercepts);
 	/*
 	 * If the measured idle duration falls into the same bin as the sleep
 	 * length, this is a "hit", so update the "hits" metric for that bin.
@@ -221,9 +236,6 @@ static void teo_update(struct cpuidle_dr
 		if (TICK_NSEC <= measured_ns)
 			cpu_data->tick_intercepts += PULSE;
 	}
-
-	cpu_data->total -= cpu_data->total >> DECAY_SHIFT;
-	cpu_data->total += PULSE;
 }
 
 static bool teo_state_ok(int i, struct cpuidle_driver *drv)




