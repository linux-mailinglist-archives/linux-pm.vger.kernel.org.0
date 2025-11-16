Return-Path: <linux-pm+bounces-38092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFF0C614B8
	for <lists+linux-pm@lfdr.de>; Sun, 16 Nov 2025 13:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140A23B5FC1
	for <lists+linux-pm@lfdr.de>; Sun, 16 Nov 2025 12:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6412D7812;
	Sun, 16 Nov 2025 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZSkegyX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BA8265606;
	Sun, 16 Nov 2025 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763296555; cv=none; b=qVjTwmFPmc5CKdkFmZ62hPEYr5Kwl30rKdrLwlH9bCorfYJ/XxQnWyxvmcxcR6rv/qpSYBKQhqluKd/cQhSU8851eLctAIun2IC5d4MWqqU2qr2f1wpSUobi1pCbfV0m+Sb4HPkbxoqDdbQmx0txdIFso55ShMInus3P6JSWHfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763296555; c=relaxed/simple;
	bh=YyiMFd/9BjGusOuDIEo62BFQYDSP7yJdh0I1kOwp4Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrSUU8OGRSQYS0K1KonhWF93m3dFpNB+W+Wd/E5WJvHD+LusiR/a1sd4P5Tdz2+4oXjuZrFsjB5rWSOG1sZdMXd7ms6qpNExORGqk3KUmV/Clgw9EYnXuQ1Eu+xMcgF7z6FDVkg7X5IaVpmFVb8l42+EVM+1klDRjvPQXev10C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZSkegyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512C4C4CEFB;
	Sun, 16 Nov 2025 12:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763296555;
	bh=YyiMFd/9BjGusOuDIEo62BFQYDSP7yJdh0I1kOwp4Qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZZSkegyXCeikHDNAJbTizunYm3lQBPcK2Mv0D1tddADgi+ucqnOFF9QKED61QTy3X
	 TQsUzX8KmjFsNnjKZntArR7DwgZ3w89/YEDyBQ+id6pTer7YB7UV1X+cmVlJ6MwTyK
	 CuVmWZabnEdFEFvG7qYNAAERmQAyU/iAS+meghlXRCeBVN8izeZwx1wPg1eFhqN0af
	 pzccBv6lG2owTVsfQNtaCugfdRKuzsc9zdnJWRN6zFwN4mVpu3JP67XWJxE7hre4Rx
	 tHKgrXUMHgCqKqJH+LWZTALeRNFYKVYPZh57Am6fhlM7SJkoB/99v6KCtE4oXYS+PT
	 PL7Iqkbil817g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1 2/2] cpuidle: governors: teo: Simplify intercepts-based state
 lookup
Date: Sun, 16 Nov 2025 13:35:14 +0100
Message-ID: <2418792.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12810244.O9o76ZdvQC@rafael.j.wysocki>
References: <12810244.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Simplify the loop looking up a candidate idle state in the case when an
intercept is likely to occur by adding a search for the state index limit
if the tick is stopped before it.

First, call tick_nohz_tick_stopped() just once and if it returns true,
look for the shallowest state index below the current candidate one with
target residency at least equal to the tick period length.

Next, simply look for a state that is not shallower than the one found
in the previous step and, ideally, satisfies the intercepts majority
condition.

Since teo_state_ok() has no callers any more after the above changes,
drop it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   62 ++++++++++------------------------------
 1 file changed, 16 insertions(+), 46 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -256,12 +256,6 @@ static void teo_update(struct cpuidle_dr
 	}
 }
 
-static bool teo_state_ok(int i, struct cpuidle_driver *drv)
-{
-	return !tick_nohz_tick_stopped() ||
-		drv->states[i].target_residency_ns >= TICK_NSEC;
-}
-
 /**
  * teo_find_shallower_state - Find shallower idle state matching given duration.
  * @drv: cpuidle driver containing state data.
@@ -383,7 +377,18 @@ static int teo_select(struct cpuidle_dri
 	 * better choice.
 	 */
 	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
-		int first_suitable_idx = idx;
+		int min_idx = idx0;
+
+		if (tick_nohz_tick_stopped()) {
+			/*
+			 * Look for the shallowest idle state below the current
+			 * candidate one whose target residency is not below the
+			 * tick period length.
+			 */
+			while (min_idx < idx &&
+			       drv->states[min_idx].target_residency_ns < TICK_NSEC)
+				min_idx++;
+		}
 
 		/*
 		 * Look for the deepest idle state whose target residency had
@@ -393,49 +398,14 @@ static int teo_select(struct cpuidle_dri
 		 * Take the possible duration limitation present if the tick
 		 * has been stopped already into account.
 		 */
-		intercept_sum = 0;
-
-		for (i = idx - 1; i >= 0; i--) {
-			struct teo_bin *bin = &cpu_data->state_bins[i];
-
-			intercept_sum += bin->intercepts;
-
-			if (2 * intercept_sum > idx_intercept_sum) {
-				/*
-				 * Use the current state unless it is too
-				 * shallow or disabled, in which case take the
-				 * first enabled state that is deep enough.
-				 */
-				if (teo_state_ok(i, drv) &&
-				    !dev->states_usage[i].disable) {
-					idx = i;
-					break;
-				}
-				idx = first_suitable_idx;
-				break;
-			}
+		for (i = idx - 1, intercept_sum = 0; i >= min_idx; i--) {
+			intercept_sum += cpu_data->state_bins[i].intercepts;
 
 			if (dev->states_usage[i].disable)
 				continue;
 
-			if (teo_state_ok(i, drv)) {
-				/*
-				 * The current state is deep enough, but still
-				 * there may be a better one.
-				 */
-				first_suitable_idx = i;
-				continue;
-			}
-
-			/*
-			 * The current state is too shallow, so if no suitable
-			 * states other than the initial candidate have been
-			 * found, give up (the remaining states to check are
-			 * shallower still), but otherwise the first suitable
-			 * state other than the initial candidate may turn out
-			 * to be preferable.
-			 */
-			if (first_suitable_idx == idx)
+			idx = i;
+			if (2 * intercept_sum > idx_intercept_sum)
 				break;
 		}
 	}




