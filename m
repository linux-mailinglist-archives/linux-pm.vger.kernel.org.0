Return-Path: <linux-pm+bounces-36295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01A9BE4911
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 18:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250EC3A49F3
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 16:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB91329C49;
	Thu, 16 Oct 2025 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDb8Huj+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC06A23EABA;
	Thu, 16 Oct 2025 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631939; cv=none; b=twqaNaIZ8c3Rq2lngbsFWNiOYG3GBGYI8YYP0ijYurHrEQtA4XkPyen+fvj040VdPcbJNfbIx35EPsKErOU6TE8OVMdAdBPM+upmD91bOM4p2i7UjuUk1LkFZrDwkftlM1EoXSE7FzHRP4CCNAllq6KGowPVBNCM+HpUAmax9uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631939; c=relaxed/simple;
	bh=XY16fYS6OOP9xjM5VB6SenXMoSMfGpwGBh+ou4x3omo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DMZAvCBlCKdkvSU6kD8HgrQ7eKFqZI56A2uX3mDUMbTHz3lrzEpPeer29gIfbNioQBPly2vhk8/8FITZDy4HNKIkQFEkw8P2DK5V8MMmV41cddz0v5GSeQ+fvMM0+Ahypx5Z2riz4J2tx+XpQtBBnOySXjcD7vJgEAangnTWREo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDb8Huj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8154DC4CEF1;
	Thu, 16 Oct 2025 16:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760631939;
	bh=XY16fYS6OOP9xjM5VB6SenXMoSMfGpwGBh+ou4x3omo=;
	h=From:To:Cc:Subject:Date:From;
	b=cDb8Huj+Nb1b74dUMKRfDINKIB0wlM5mMXrFYZP2igHn5sUTdKiC5/pE1ACZRpMRH
	 z5V92wh/zu4WKGzjMW3UUnWi+5vf/GhgPhpml5tnX947zVb29UCoLwlmtVtB4NW03I
	 QBktHZKavXf66oJOqsgTSqDmWjAH6XexGOirVAvqMvX+aVUL72B0mzcULIxnOH8q54
	 3NnISlgr6J6u8WLe2peZxDlTz+ERw8R4DQcW1Tw41Bc/kqGb9X0liYKaDjm7mN4TNk
	 ySJFh2NlrOX6N/10NkidA+chc8A0zjBvRpWR3kgwO5ZkHLgbfibmL2ZIb3CMLhkD8m
	 cCnf2UqfeLb8g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Tomasz Figa <tfiga@chromium.org>, Doug Smythies <dsmythies@telus.net>
Subject:
 [PATCH v1] cpuidle: governors: menu: Predict longer idle time when in doubt
Date: Thu, 16 Oct 2025 18:25:35 +0200
Message-ID: <4687373.LvFx2qVVIh@rafael.j.wysocki>
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
both power and performance had been inadequate as a result of that in
some cases.  This was not a problem on systems with relatively
aggressive average running power limits, like the Jasper Lake systems
in question, because on those systems it was compensated by the ability
to run CPUs at relatively higher frequencies.

Commit 85975daeaa4d addressed that by causing get_typical_interval() to
return a number based on the recent idle duration information available
to it in those cases, but that number is usually smaller than the
maximum idle duration observed recently which may be regarded as an
overly optimistic choice.

Namely, it may be argued that when the samples considered by
get_typical_interval() are spread too much for a high-confidence
prediction to be made, the function should fall back to returning a
number that is likely to be an upper bound for the duration of the
upcoming idle interval and that number needs to be at least equal to
the maximum recently observed idle time.  Otherwise, the governor may
miss an oportunity to reduce power without hurting performance in a
noticeable way.  Of course, it may also be argued the other way around,
but the available data indicate that get_typical_interval() should
rather tend to return larger numbers as that causes the governor to
behave more closely to its past behavior from before the problematic
commit.

Accordingly, modify get_typical_interval() to return the maximum
recently observed idle time when it is unable to make a high-
confidence prediction.

Fixes: 85975daeaa4d ("cpuidle: menu: Avoid discarding useful information")
Closes: https://lore.kernel.org/linux-pm/36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7/ [1]
Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -116,6 +116,7 @@ static void menu_update(struct cpuidle_d
 static unsigned int get_typical_interval(struct menu_device *data)
 {
 	s64 value, min_thresh = -1, max_thresh = UINT_MAX;
+	unsigned int max_overall = 0;
 	unsigned int max, min, divisor;
 	u64 avg, variance, avg_sq;
 	int i;
@@ -151,6 +152,9 @@ again:
 	if (!max)
 		return UINT_MAX;
 
+	if (max_overall < max)
+		max_overall = max;
+
 	if (divisor == INTERVALS) {
 		avg >>= INTERVAL_SHIFT;
 		variance >>= INTERVAL_SHIFT;
@@ -198,7 +202,7 @@ again:
 		 * maximum, so return the latter in that case.
 		 */
 		if (divisor >= INTERVALS / 2)
-			return max;
+			return max_overall;
 
 		return UINT_MAX;
 	}




