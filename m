Return-Path: <linux-pm+bounces-32255-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9ACB24739
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 12:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C535665E9
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 10:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3592D63E4;
	Wed, 13 Aug 2025 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZWM9EUA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2401D212571;
	Wed, 13 Aug 2025 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081032; cv=none; b=CxYcYUoCcgqTFqzYGssHIpAFvHdG5DHYm3EGhfwCFZ3aFMt4DZSknEHibWDzOEGkbpQtYe08qmCCNplFOBIaOJ4o8wS1CS5tPY4/Z+cRFUg3I8wuBGuH3xaUYHJXUr0QES1J75Q0qaRlyKEgHqwsKTZC1eAtNoKmgjretLz3lX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081032; c=relaxed/simple;
	bh=V6sdFzKvrJKraeJ9IEPdOHZgCdgzOGqx1ymqb6IrMg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2tPsYSCijrXAys6uB87/zdl2cxAiZm65UeqeSxFVcoIHz4ZWaAYIRXgON3HC+rSKG7oHA+DVBWw6JBZ/4DZ0f1rDp7Xc+efTgkW53guuBxxBzdAY2vdvdw1WyrIUhVRSl3zLn5WBiPw/cCabHN3W4uz1ajjo8g2vNyFJmopdbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZWM9EUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4D7C4CEEB;
	Wed, 13 Aug 2025 10:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755081031;
	bh=V6sdFzKvrJKraeJ9IEPdOHZgCdgzOGqx1ymqb6IrMg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZWM9EUAIN03F8InYrZ/c8Yey+pp8uMrCyi4sVnzrtFrOA5ZyBD/I1hKzysTFbQyo
	 iI3poOPgKStK4msU/SgZTNobQ5f+6tW1gq5FvL+SEXli0va2x5ZMHXH0NIstkyCkdg
	 sEOgaggtstHBMxsiZM64yuT1HmYuEEYIFGyP1bFHD7FHrHYfUHHzAfnr88wCxKtLL0
	 KXgInkeC3oouyJT/rraWDp6FY3Fx7nmN6qHlSZyVg2SLfI8VJ6fBRvHzN8khTlpeUI
	 DWctk6VtepRdTsE55cd39KvDaBBKAu9HeFNQZqygcYsgj36FEBSZU9GzGeNdoXdLej
	 C9sDXj4K0tMxg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Christian Loehle <christian.loehle@arm.com>
Subject:
 [PATCH v1 2/3] cpuidle: governors: menu: Rearrange main loop in menu_select()
Date: Wed, 13 Aug 2025 12:26:35 +0200
Message-ID: <2389215.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2804546.mvXUDI8C0e@rafael.j.wysocki>
References: <2804546.mvXUDI8C0e@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reduce the indentation level in the main loop of menu_select() by
rearranging some checks and assignments in it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |   72 ++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -314,45 +314,47 @@
 		if (s->exit_latency_ns > latency_req)
 			break;
 
-		if (s->target_residency_ns > predicted_ns) {
-			/*
-			 * Use a physical idle state, not busy polling, unless
-			 * a timer is going to trigger soon enough.
-			 */
-			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
-			    s->target_residency_ns <= data->next_timer_ns) {
-				predicted_ns = s->target_residency_ns;
-				idx = i;
-				break;
-			}
-			if (predicted_ns < TICK_NSEC)
-				break;
-
-			if (!tick_nohz_tick_stopped()) {
-				/*
-				 * If the state selected so far is shallow,
-				 * waking up early won't hurt, so retain the
-				 * tick in that case and let the governor run
-				 * again in the next iteration of the loop.
-				 */
-				predicted_ns = drv->states[idx].target_residency_ns;
-				break;
-			}
+		if (s->target_residency_ns <= predicted_ns) {
+			idx = i;
+			continue;
+		}
+
+		/*
+		 * Use a physical idle state, not busy polling, unless a timer
+		 * is going to trigger soon enough.
+		 */
+		if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
+		    s->target_residency_ns <= data->next_timer_ns) {
+			predicted_ns = s->target_residency_ns;
+			idx = i;
+			break;
+		}
 
+		if (predicted_ns < TICK_NSEC)
+			break;
+
+		if (!tick_nohz_tick_stopped()) {
 			/*
-			 * If the state selected so far is shallow and this
-			 * state's target residency matches the time till the
-			 * closest timer event, select this one to avoid getting
-			 * stuck in the shallow one for too long.
+			 * If the state selected so far is shallow, waking up
+			 * early won't hurt, so retain the tick in that case and
+			 * let the governor run again in the next iteration of
+			 * the idle loop.
 			 */
-			if (drv->states[idx].target_residency_ns < TICK_NSEC &&
-			    s->target_residency_ns <= delta_tick)
-				idx = i;
-
-			return idx;
+			predicted_ns = drv->states[idx].target_residency_ns;
+			break;
 		}
 
-		idx = i;
+		/*
+		 * If the state selected so far is shallow and this state's
+		 * target residency matches the time till the closest timer
+		 * event, select this one to avoid getting stuck in the shallow
+		 * one for too long.
+		 */
+		if (drv->states[idx].target_residency_ns < TICK_NSEC &&
+		    s->target_residency_ns <= delta_tick)
+			idx = i;
+
+		return idx;
 	}
 
 	if (idx == -1)




