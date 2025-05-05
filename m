Return-Path: <linux-pm+bounces-26703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AF6AAB461
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 07:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CE93B5ACC
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 04:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271BD475A58;
	Tue,  6 May 2025 00:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K64F21+g"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BD32EC2A8;
	Mon,  5 May 2025 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486634; cv=none; b=tvHncJVzEgHp+rufRFASw6PZrZolQEILUFEONSdYTDbJ7+oLL2uJz2n8MC/RwLS6n5JSvhgD7Tx69KcGPvL8iqjct7vZv1e1QBnGIYxr8P0pqj5NjytLoMUWNrkQYpMk8XLFyE/AfxZUM2AWCuExE6HAKAT75VhlAmEPbJTiM4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486634; c=relaxed/simple;
	bh=84ob2P0SJpV/KFUDPucA4Ms5s6RGmV+qyDCLnlPHY1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=elx6BpIxzWg9gLETbnly5T+nIgktGLbY7JfjjWUUkDsMU7LC/Dmeot1fV6GQLTWNz/bANmJZep1+m0vLlpR8sadMsYES2R9mRz+mvlCo9WHo1xBQDyWrBxCHMLPkuUCWghCiR6l7pyS95PS6mDtjrwDnu7kCCRS0asgFlUYX03k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K64F21+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42909C4CEE4;
	Mon,  5 May 2025 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486633;
	bh=84ob2P0SJpV/KFUDPucA4Ms5s6RGmV+qyDCLnlPHY1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K64F21+g9EH4JW5T4mngj/bON68qDVegDai5G5JH1deU+1RThN2KGu0ukWywZqlpu
	 uaTST8ugN3ZO7DExjz1Gmede9xkPwSbXYKn5PLu7eLnejaILonN1cf29NuJuB/3LdZ
	 VsMwCrNLWjY/Iy32HzGkDMNmiubtBVIDBYbEpiVAj9vWIcomAiYMQYdwv59XWkAvZr
	 HMBSB1TMaPPd0/Xb/Y2MH9DedDAxJqCivyJ5d22VZY8l/i4VKsSkxOZh3ZFBg1ZKGg
	 FX95wA8dyYsU8qLeIVbJkjCrLxXk2EMPenx0K03n2UgbnYG9kWpXkozFaUz/A8soxZ
	 GGYjWySlH6vJg==
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
Subject: [PATCH AUTOSEL 6.1 126/212] cpuidle: menu: Avoid discarding useful information
Date: Mon,  5 May 2025 19:04:58 -0400
Message-Id: <20250505230624.2692522-126-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index c4922684f3058..4edac724983a4 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -249,8 +249,19 @@ static unsigned int get_typical_interval(struct menu_device *data,
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


