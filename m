Return-Path: <linux-pm+bounces-26695-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F6AAAB068
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 05:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706DA1BA5681
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 03:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C88E30DE03;
	Mon,  5 May 2025 23:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKeCAlyP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75390383E38;
	Mon,  5 May 2025 23:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487397; cv=none; b=MxodT8mNxUYDUBN12NxTLain4kAoVGW1kVGkZExvtoDwbW+ZZCpfVAR++RNnix5me3pQioFPdUNZFJUbZsY7gYHYae5eyDsMq3WXClX1yyVPhg7fBZn6mzWVpOl7sU5TSy+CEEAuW4YT4gZ9iINd4X8VxF0gFNd5KIz53j8tiVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487397; c=relaxed/simple;
	bh=0T9d6penBI5wpo920KS4Kx5HReglCsNO+2y9/Z/95MM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lztOr9qL8QUtnn0iFX/PBwXdlZ+ZSmz9ZPVqGsIk79qd1qQjLb2+b/hXkuBheDcx5k6aluaE39bCCgKHZMcbHhIx+hQw6N6jAdeLN4oLCeMGmQMDfFmvMnumjBRb0li/TsqfPQZIh/PqmD+zBhPvt+rGF8OVyVtt4EQLcNPgZI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKeCAlyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EA2C4CEED;
	Mon,  5 May 2025 23:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487396;
	bh=0T9d6penBI5wpo920KS4Kx5HReglCsNO+2y9/Z/95MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GKeCAlyPmmjxAolADF1jXnhsD6EBPG/tQaI2OZY/DnT9zk/WjfGfE0Thu7ZcGBe/J
	 qgsGMawPUF/9Cl1pI7TKT0FfJTLvIkZL1qdcQXD3pcsqGlkrnYDwjumsijC4O5shW+
	 v82LUT2J9starHk2dTXrPtX1cCIzsICDbXnLGZvxOalLEAeg9UQXEbG5bqINRdv9Fx
	 tWsFAqo9O2fe5QIlgRbus/ki1mk3/sqznuVBneEZ7LrbvSlpNBXXo4AiEGungUR/EX
	 7QHdkE09LKUvAG5+p7bo1yKs+EX9pQtFAifJg7enPYJlvN3ape6nILwJcDuBVlsljy
	 aQ2KxTUH8cxQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 46/79] cpuidle: menu: Avoid discarding useful information
Date: Mon,  5 May 2025 19:21:18 -0400
Message-Id: <20250505232151.2698893-46-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 85975daeaa4d6ec560bfcd354fc9c08ad7f38888 ]

When giving up on making a high-confidence prediction,
get_typical_interval() always returns UINT_MAX which means that the
next idle interval prediction will be based entirely on the time till
the next timer.  However, the information represented by the most
recent intervals may not be completely useless in those cases.

Namely, the largest recent idle interval is an upper bound on the
recently observed idle duration, so it is reasonable to assume that
the next idle duration is unlikely to exceed it.  Moreover, this is
still true after eliminating the suspected outliers if the sample
set still under consideration is at least as large as 50% of the
maximum sample set size.

Accordingly, make get_typical_interval() return the current maximum
recent interval value in that case instead of UINT_MAX.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Link: https://patch.msgid.link/7770672.EvYhyI6sBW@rjwysocki.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpuidle/governors/menu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index e5a5d0c8d66b1..bb7288f6adbf6 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -259,8 +259,19 @@ static unsigned int get_typical_interval(struct menu_device *data,
 	 * This can deal with workloads that have long pauses interspersed
 	 * with sporadic activity with a bunch of short pauses.
 	 */
-	if ((divisor * 4) <= INTERVALS * 3)
+	if (divisor * 4 <= INTERVALS * 3) {
+		/*
+		 * If there are sufficiently many data points still under
+		 * consideration after the outliers have been eliminated,
+		 * returning without a prediction would be a mistake because it
+		 * is likely that the next interval will not exceed the current
+		 * maximum, so return the latter in that case.
+		 */
+		if (divisor >= INTERVALS / 2)
+			return max;
+
 		return UINT_MAX;
+	}
 
 	thresh = max - 1;
 	goto again;
-- 
2.39.5


