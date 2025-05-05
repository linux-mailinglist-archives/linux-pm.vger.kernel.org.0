Return-Path: <linux-pm+bounces-26697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FB1AAB0D5
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 05:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC8F4E375E
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 03:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6565232AB9E;
	Tue,  6 May 2025 00:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7PEjqW8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB27A2BF3F2;
	Mon,  5 May 2025 22:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485310; cv=none; b=HZCeOh++DDVmFmSvOhHy4ESBJ31d8iyGdxwZLlgqf9ogwqrhB3U/f/b21kVo70/rXzdKzHNs8PFFGGQPUznc1mQ4eBmHNrSn/cmvIYjgpHFHT4FJvgX2qAcBqMixq3ev3bgC6dcTxoC/0eU1EwWZ4HDVxi4bWuyOY9FAHLkjHGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485310; c=relaxed/simple;
	bh=sA5+9iikc4LH5jdFJudKdSamGAlkuDYDKiR3L7gqSEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gLsIxUswSkYCyckYPoONVeJduPZ4yLDWEekE64ATFKWopMgPInyqjUzolZLfnsGdX2sguMnoo2+iaEjOQ5Stxdn/Wbe1HmKAxhEas1/yomGzOTJb5Qco2okDo3VVKdSu+KX89WVA3ohWRcgCRB5ib9/U8Z8C4TPlprVK+2PcsPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7PEjqW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC1EC4CEED;
	Mon,  5 May 2025 22:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485308;
	bh=sA5+9iikc4LH5jdFJudKdSamGAlkuDYDKiR3L7gqSEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c7PEjqW8eBVx2wyOtXYNXjA0iHAQqbSZ17WMihJ8tggzULfpJK5Fkc+PLy/PqGNF1
	 bJnxQr6qbSsVRxb7iAH3Z1h1ID1TCtAnvvefmvpW5hSI/oY+zMJ9IsHhEm+c84vajV
	 3YrElnXzLU+IyZnblVSiufoUv6z3mC2g9i8I674j1Riu+5fEvt5WScbXdiGeW5Af3o
	 Wn9y9tvguzmQliq1sKZ0I/HdDkQ8fZYgzc0+r0RddnJ0q+3Iltug859GCjFKqigQuh
	 pBPOlOxEBGhZmo4mgagZnse2zF9FjpHbwPHcNpnBEWeRi51Pgr9z0LEGunMmqh+OD7
	 pPp1btXBg7MiQ==
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
Subject: [PATCH AUTOSEL 6.12 260/486] cpuidle: menu: Avoid discarding useful information
Date: Mon,  5 May 2025 18:35:36 -0400
Message-Id: <20250505223922.2682012-260-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index f3c9d49f0f2a5..97ffadc7e57a6 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -239,8 +239,19 @@ static unsigned int get_typical_interval(struct menu_device *data)
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


