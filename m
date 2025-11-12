Return-Path: <linux-pm+bounces-37851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8CFC537FB
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 17:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49CD50190D
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 16:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4128B33AD8A;
	Wed, 12 Nov 2025 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dw946iKs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1663332D7DD;
	Wed, 12 Nov 2025 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964769; cv=none; b=sszNH0zVlaJlaspq8jbXDGhKiUxckdhtmlvSHb1p26hKsyANGcn9J7jMPKBED2iRy49/sLAVoftElL6UJCOdRxUZhM+uZF7CxHmWqHwl6Da4bsV6LwfFhAkR3q8b30Mdly31AUKLPvVPix76BQL4Bip+cgXiCWIHbxdJELTDoWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964769; c=relaxed/simple;
	bh=PhOpg8daI+pn+v5iRCHrewm5SXnZkOlAgbebDrQtMXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+Uj2HJxAeydZPngaQMOfJfZevuJNeU73E6AkQeTSxWU5udMPyCQ5nZyyXhMoHCexbFLHUAalHevMW3BYj/SJv2jKNVWlPWG+njV/zbrJ0yC+WJ+5TLhNDnmcuh8Tt+gCNeqjEuZSQaIzZBPpd8X/yv454fsoE/q1OHOGmscaao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dw946iKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCB1C4CEF5;
	Wed, 12 Nov 2025 16:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762964768;
	bh=PhOpg8daI+pn+v5iRCHrewm5SXnZkOlAgbebDrQtMXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dw946iKshpxcD8rShBTNe8wyJhDV8yw4yt1sVVMehScyAvRjv/fUMkCYLJfitv3J1
	 Pg3qWfEcLbsw9Q22tCqTA8U9Xe9wD2o65bZLnJeDTZJ1YuQTVbGNksd3GMsTI2rPRa
	 C4VQfczxkIyzSuPQSYCvvZqSm1a9Mdam9KJ2SOzVEEguOYQnUGnTsznDaDa1yBzwYh
	 FrRd1xOLKgioA3bdt2LOwBHElqKWbNYBK6QR0Ke60mo/wDIPAN0XmfU1HLNlBZTeC2
	 D+IAL+v2sr8fHD9yc59gO29salcLmiE0adAGy0xC9V9kaUy77zSNEj8UltYWJzU3H2
	 /LvubpEglCuMg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Reka Norman <rekanorman@chromium.org>
Subject:
 [PATCH v1 4/4] cpuidle: governors: teo: Decay metrics below DECAY_SHIFT
 threshold
Date: Wed, 12 Nov 2025 17:25:48 +0100
Message-ID: <3396811.44csPzL39Z@rafael.j.wysocki>
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

If a given governor metric falls below a certain value (8 for
DECAY_SHIFT equal to 3), it will not decay any more due to the
simplistic decay implementation.  This may in some cases lead to
subtle inconsistencies in the governor behavior, so change the
decay implementation to take it into account and set the metric
at hand to 0 in that case.

Suggested-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

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
@@ -159,7 +169,7 @@ static void teo_update(struct cpuidle_dr
 	int i, idx_timer = 0, idx_duration = 0;
 	s64 target_residency_ns, measured_ns;
 
-	cpu_data->short_idles -= cpu_data->short_idles >> DECAY_SHIFT;
+	teo_decay(&cpu_data->short_idles);
 
 	if (cpu_data->artificial_wakeup) {
 		/*
@@ -195,8 +205,8 @@ static void teo_update(struct cpuidle_dr
 	for (i = 0; i < drv->state_count; i++) {
 		struct teo_bin *bin = &cpu_data->state_bins[i];
 
-		bin->hits -= bin->hits >> DECAY_SHIFT;
-		bin->intercepts -= bin->intercepts >> DECAY_SHIFT;
+		teo_decay(&bin->hits);
+		teo_decay(&bin->intercepts);
 
 		target_residency_ns = drv->states[i].target_residency_ns;
 
@@ -207,7 +217,7 @@ static void teo_update(struct cpuidle_dr
 		}
 	}
 
-	cpu_data->tick_intercepts -= cpu_data->tick_intercepts >> DECAY_SHIFT;
+	teo_decay(&cpu_data->tick_intercepts);
 	/*
 	 * If the measured idle duration falls into the same bin as the sleep
 	 * length, this is a "hit", so update the "hits" metric for that bin.
@@ -222,7 +232,7 @@ static void teo_update(struct cpuidle_dr
 			cpu_data->tick_intercepts += PULSE;
 	}
 
-	cpu_data->total -= cpu_data->total >> DECAY_SHIFT;
+	teo_decay(&cpu_data->total);
 	cpu_data->total += PULSE;
 }
 




