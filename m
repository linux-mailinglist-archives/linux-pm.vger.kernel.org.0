Return-Path: <linux-pm+bounces-36385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DF2BECF97
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 14:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E970C19A74BC
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 12:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4DF25A2C6;
	Sat, 18 Oct 2025 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNMBAWaC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D29288D0;
	Sat, 18 Oct 2025 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760790440; cv=none; b=WSNBhq8uuCiEymNg99dctCFl0ZrztHz4kmlf5zwC6immTx/1VwttrghqDBY+F1hPbsCr+djHZ1bHSaQCnt9jZKwgnD2opbRTqdWYxzvqlaRlimhH+328SpolpQuJP8icfr9woaVIkINxbqa9pIBjAVxNmftkf8JPMBqoUD+D6a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760790440; c=relaxed/simple;
	bh=SCFTaGoirpvT04lMBP/4zr76JrsMh88Ob3cOymf2Urw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TscWb91f3wSfjRqfmhHFi4aQbjohBbb3x4kkpOiFN8/Ypbl2UFlOzr9hgB1RklLyq+tJ7tdDVDD/S09qF9F/G3F/DxSspw0hi8lpp8lagUaNKiDAhF3iBwJ7kWt182LQe/hcuF5IdTf37KdnORHHIHJcudc/l5dzF6sVnCCnXgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNMBAWaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8199AC4CEF8;
	Sat, 18 Oct 2025 12:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760790439;
	bh=SCFTaGoirpvT04lMBP/4zr76JrsMh88Ob3cOymf2Urw=;
	h=From:To:Cc:Subject:Date:From;
	b=BNMBAWaCXB+hJ4peztQItmWaHxlnJgbzWzLot0VrxFLxqHVTmo+jz7bMyHadABNdi
	 JwNDQauzoq216DP002oAMQb2F9jz3Y0QW5L0nwfabggJk7grHb10ZPE1BvhIrUuhZG
	 F5rR7t1JhMdV3XkED4NwztZ4ftJwMkaWLiRh9Sszfo+t4ZKJ9eBUbry+V/AbBYuYId
	 obmwoF0JMejE0Fpkf1CCBAbe9V7XnB4HFEycWqpi1KGHdYUHQYoacgdAESgEeGB1JZ
	 nLLhJGM/zj/Rjbi9vA2+RDaRWJUXbvKNKpUCQx9PwOqeMzDAV+mbnziwaJV2RF2I7c
	 sUMrApIj3JHMw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Tomasz Figa <tfiga@chromium.org>, Doug Smythies <dsmythies@telus.net>
Subject:
 [PATCH v1] Revert "cpuidle: menu: Avoid discarding useful information"
Date: Sat, 18 Oct 2025 14:27:15 +0200
Message-ID: <3663603.iIbC2pHGDl@rafael.j.wysocki>
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

It is reported that commit 85975daeaa4d ("cpuidle: menu: Avoid discarding
useful information") led to a performance regression on Intel Jasper Lake
systems because it reduced the time spent by CPUs in idle state C7 which
is correlated to the maximum frequency the CPUs can get to because of an
average running power limit [1].

Before that commit, get_typical_interval() would have returned UINT_MAX
whenever it had been unable to make a high-confidence prediction which
had led to selecting the deepest available idle state too often and
both power and performance had been inadequate as a result of that on
some systems.  However, this had not been a problem on systems with
relatively aggressive average running power limits, like the Jasper Lake
systems in question, because on those systems it was compensated by the
ability to run CPUs faster.

It was addressed by causing get_typical_interval() to return a number
based on the recent idle duration information available to it even if it
could not make a high-confidence prediction, but that clearly did not
take the possible correlation between idle power and available CPU
capacity into account.

For this reason, revert most of the changes made by commit 85975daeaa4d,
except for one cosmetic cleanup, and add a comment explaining the
rationale for returning UINT_MAX from get_typical_interval() when it
is unable to make a high-confidence prediction.

Fixes: 85975daeaa4d ("cpuidle: menu: Avoid discarding useful information")
Closes: https://lore.kernel.org/linux-pm/36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7/ [1]
Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -188,20 +188,17 @@ again:
 	 *
 	 * This can deal with workloads that have long pauses interspersed
 	 * with sporadic activity with a bunch of short pauses.
+	 *
+	 * However, if the number of remaining samples is too small to exclude
+	 * any more outliers, allow the deepest available idle state to be
+	 * selected because there are systems where the time spent by CPUs in
+	 * deep idle states is correlated to the maximum frequency the CPUs
+	 * can get to.  On those systems, shallow idle states should be avoided
+	 * unless there is a clear indication that the given CPU is most likley
+	 * going to be woken up shortly.
 	 */
-	if (divisor * 4 <= INTERVALS * 3) {
-		/*
-		 * If there are sufficiently many data points still under
-		 * consideration after the outliers have been eliminated,
-		 * returning without a prediction would be a mistake because it
-		 * is likely that the next interval will not exceed the current
-		 * maximum, so return the latter in that case.
-		 */
-		if (divisor >= INTERVALS / 2)
-			return max;
-
+	if (divisor * 4 <= INTERVALS * 3)
 		return UINT_MAX;
-	}
 
 	/* Update the thresholds for the next round. */
 	if (avg - min > max - avg)




