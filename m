Return-Path: <linux-pm+bounces-12922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A5395FFDD
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 05:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231DA1C2218D
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 03:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF651803D;
	Tue, 27 Aug 2024 03:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mhejfn4D"
X-Original-To: linux-pm@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C648617D2;
	Tue, 27 Aug 2024 03:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724729747; cv=none; b=ixUl0ugiGh3ATUBmCNj3IvcTHLHNZNEV+fgFlGoJ+Ts121X5Aw+UJT3m4Hp2760sqcSuAb58+jD0Im3gkgjUG/9iqlT+REYRcRVBHJ0m5arqIFBj0qyLmzl9yICnXZoshM1wkbp/zqJiUENW951kxfZzhErPQAJOy80XnTa7bgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724729747; c=relaxed/simple;
	bh=JxOOw3I8hM8McboYblBC9AuhxVq0E8rfFp3biyQnsSg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=de/yF5J/wHxmxFjxMiwZwsJHLyWpnUGqm+m6p0sg5RaJMIbiaLy+edksvq1MidKHvtWtNjCyUMcWdnI7/36ZKYU5tLXT6LFTwkjKQ5pnWkGCbJg9HHyhwkckYS13ybp6a6aeUtImOaelP0R9khcHlsfhYQXnlwMzqP8R7oBNfWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mhejfn4D; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724729739; bh=6mdDp6P8g3MUmwup0fCL42gvss1KTTQoo2H9D0IBPFo=;
	h=From:To:Cc:Subject:Date;
	b=mhejfn4DL6LjoxNVeGzOPDL06kxY86StNKmPq6Pm9wjIbcN7opSVCC18eKRI3ToAD
	 +ayiSS0Y7jAEROX7YV3CSLC0P6SBfOoLgankxQ2aNAZQ3t7v9QBVkNv0YIRs+4gfi8
	 Ypscy2tUG6HOGtQoLjeM/GHuoStWtb+JmqbssQxY=
Received: from iZ2ze0ccts00nkjy9wuyo6Z.localdomain ([101.201.76.96])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 68AAC261; Tue, 27 Aug 2024 11:26:10 +0800
X-QQ-mid: xmsmtpt1724729170tmbqb2psx
Message-ID: <tencent_65D10BAC9579867D29B79F44D999AED1E506@qq.com>
X-QQ-XMAILINFO: Nd//4bIXhHdblwXXSM2RepgMK+NRSGkdF6VKULRYDdCpUJg0sJ+v7FlfJp5fdS
	 /WFPHfVibXsNVcyuGPgke193vtFmA49du/P5MjPDQbPa5wO8ccAfszDhCDHtJhjfX3iGNZ2eNlRD
	 ntNXAY3gmdPYPYfpGH0jdVEmW1hRsgCVXGQ7xnagSJbVqFmU2sJ25J25tPvqTQDzpm3QNlEYhm5y
	 wCqllSCLA/QiM2NnYINQUUJZ84gfIIMiQJaRXHb+KTNGL5b/DrpDsNgNTtVsDNUcFoK7wIwkLPLz
	 3RJgQujvnViRRvD67E3hT+SF7ZzmGONQ1nCWNqmIKXdi5TqcOaWSf5wNDlvpCPyHB1TCLsgNOMDs
	 LhsS8DVd/moN6vuv3TjZzy0S3FFboQTtZiQKyU9fZeNJsoetSPvVpACCMO4xencOvbHe2bqwuX/P
	 8jBRdqkXhV5f/7LTeNnkCl0NqV3/MUj7NE5Ltl2ZPTJ7wYDKrdIqhPmaEaiz2KvhFFwB2H9brFSD
	 /lFHoBcSzB3H1M2d7LKUn74tvXR35jQpzZf4IyPB+KdrvMvlbg9e80Qu7RDUP73+Jb0ukxLddwN1
	 t8v1P5wCOTjRT+P24tUGgjqScc3c3CN+PBOOEi7oPmaS2woLf7GGZ34wV/yIK0vlFErsNkrLOyia
	 Qby9AXfnLGOEfU+tXxlIZF006TmGaPgkNB5EagG2NiEXeF9qFOYeExaRBW27yuYi8eV94VaIpdM5
	 Eq0l/I8iKbMpgrCXVUWZtOPZFoddglYr188GMir+d+lkBmd9y/tvLf6Ud6pmfX23xgz16+eBVUT5
	 c8NtLm66AC0sL8LMJOlsCMRsvQCIuDyUbpNr9O0pQ/Ls/XweCjIQbZm60gt+2Xpyp/Dg/ewh6TQA
	 /Xq2FlUL69ddOldzcrcDb9kxdNzF30vf2uZm0CzeHdOzv5yRxpCMw=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Yanhao Dong <570260087@qq.com>
To: rafael@kernel.org
Cc: daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ysaydong@gmail.com
Subject: [PATCH] cpuidle: haltpoll: Fix guest_halt_poll_ns failed to take effect
Date: Tue, 27 Aug 2024 11:26:09 +0800
X-OQ-MSGID: <20240827032609.531946-1-570260087@qq.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ysay <ysaydong@gmail.com>

When guest_halt_poll_allow_shrink=N,setting guest_halt_poll_ns
from a large value to 0 does not reset the CPU polling time,
despite guest_halt_poll_ns being intended as a mandatory maximum
time limit.

The problem was situated in the adjust_poll_limit() within
drivers/cpuidle/governors/haltpoll.c:79.

Specifically, when guest_halt_poll_allow_shrink was set to N,
resetting guest_halt_poll_ns to zero did not lead to executing any
section of code that adjusts dev->poll_limit_ns.

The issue has been resolved by relocating the check and assignment for
dev->poll_limit_ns outside of the conditional block.
This ensures that every modification to guest_halt_poll_ns
properly influences the CPU polling time.

Signed-off-by: ysay <ysaydong@gmail.com>
Fixes: 2cffe9f6b96f ("cpuidle: add haltpoll governor")
---
 drivers/cpuidle/governors/haltpoll.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/governors/haltpoll.c
index 663b7f164..99c6260d7 100644
--- a/drivers/cpuidle/governors/haltpoll.c
+++ b/drivers/cpuidle/governors/haltpoll.c
@@ -78,26 +78,22 @@ static int haltpoll_select(struct cpuidle_driver *drv,
 
 static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
 {
-	unsigned int val;
+	unsigned int val = dev->poll_limit_ns;
 
 	/* Grow cpu_halt_poll_us if
 	 * cpu_halt_poll_us < block_ns < guest_halt_poll_us
 	 */
 	if (block_ns > dev->poll_limit_ns && block_ns <= guest_halt_poll_ns) {
-		val = dev->poll_limit_ns * guest_halt_poll_grow;
+		val *= guest_halt_poll_grow;
 
 		if (val < guest_halt_poll_grow_start)
 			val = guest_halt_poll_grow_start;
-		if (val > guest_halt_poll_ns)
-			val = guest_halt_poll_ns;
 
 		trace_guest_halt_poll_ns_grow(val, dev->poll_limit_ns);
-		dev->poll_limit_ns = val;
 	} else if (block_ns > guest_halt_poll_ns &&
 		   guest_halt_poll_allow_shrink) {
 		unsigned int shrink = guest_halt_poll_shrink;
 
-		val = dev->poll_limit_ns;
 		if (shrink == 0) {
 			val = 0;
 		} else {
@@ -108,8 +104,12 @@ static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
 		}
 
 		trace_guest_halt_poll_ns_shrink(val, dev->poll_limit_ns);
-		dev->poll_limit_ns = val;
 	}
+
+	if (val > guest_halt_poll_ns)
+		val = guest_halt_poll_ns;
+
+	dev->poll_limit_ns = val;
 }
 
 /**
-- 
2.43.5


