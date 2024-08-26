Return-Path: <linux-pm+bounces-12868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD1295ECAE
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 11:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D504A1F20FB3
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 09:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC6313AD3F;
	Mon, 26 Aug 2024 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="IBu13QF7"
X-Original-To: linux-pm@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5269A84047;
	Mon, 26 Aug 2024 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724663226; cv=none; b=CfzNfPPxcwypP0UTsoaZBthKvVBeBON61hCMNyv7YbA9NMqH2K/RWXZrO9CQXVx6XZ2T6wnejP0vksFOBhzzfIF/tWwRTcpfGauZRb31BKfzLaI6f5K6BYhTPmLifdT4KsxuZugeInvLAT6a5nB09DFE7fsnw+s8mOYm9HH2CZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724663226; c=relaxed/simple;
	bh=t6E3YyEOBf2I57/ODAt4w7a2zijQZIz76U604qLgUMY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=JhNcoSYxYrLSQUGmE86EiNwSp32Gmmog9x+y96kUBd+c2LIwOe3gQoT3K64akiodngQu7WhfU4G8X4v1Is2wOuv32r5CfgwkX5eNSiLeCeAhgiwn4xIwCkGfLintSk9soZUAOL85FTlgRY90CcAOlHaFMD62cUtsNLRaOeIK5D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=IBu13QF7; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724663212; bh=k3xkOZZAZTnOpfeg6oi7bd7/Sd8fmJuPwEsMntl666A=;
	h=From:To:Cc:Subject:Date;
	b=IBu13QF7AOChkMKbr8vaEpYcQbvEyVozEVzH2duHz+GjFyEOnX32/N435991eIBeU
	 RyWicEkoIKje+Eia2AqHsxMU7HZHwObW/tE5QmcBOX+6ifo/Hkth83VLbppCUUW48Q
	 oG/N8IotCGwBRsCuB8mtfM6mRPePwFN/47/11mk0=
Received: from iZ2ze0ccts00nkjy9wuyo6Z.localdomain ([101.201.76.96])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id EA538643; Mon, 26 Aug 2024 16:58:37 +0800
X-QQ-mid: xmsmtpt1724662717tlpv04lxd
Message-ID: <tencent_13F0C81B16C09CC67E961B5E22F78CC72805@qq.com>
X-QQ-XMAILINFO: MGJQUKeBeYZp2roOmIFYtI+BoU9OKKs64nMbZsBJuzJeeiPBtb738Cfrm+A6/N
	 rcmEVG8H/6X+E9+8NYyPrTZ78Fd5mvCfAZvJ57jV0YlFtXtjwvs04y1XPFHFVc2YmDspKHll1hTL
	 cxSf71xejKyDhn23SxIkk4eTBxfaN26CrbVf8pW66B/vNAJDrqw+7dQHXDw2G/4Vn9fQq39z58CF
	 H0wlPTJA5NyPiAC6XhtJ4hfXcMuA5bcnCejQ58vrxaVzWWAJeJTmmfWQ54H8KzqvJlX6vhV2wTb8
	 SRR8wsaIV8rURgxKuqqfSUih53MIOukBgSwhEfGmaugMqBGg3hIqyf4F9qNpOF0cbmlY/d4GJGhD
	 cbq4s5W8ueqmVxonhqlKfMh1Bax1x8OBoSbx7ThRVV0edxCd4KgGsbXdkPoQs40Uy2UD6455WzWY
	 S/6ylP02h90TEm4K5F6unHVs7CyF0SBlCcSGS5wAIdXSiY8jqtg59MNi1b7VNzkQHHwJQdqEkMjQ
	 jrjfnSmOzM6J3/kX3vWlBraCztKeVNXN4dImiVxFu1+KmF/2NQUQOfnPjertnQQJp23BYdhx3Yla
	 j5z4BQdiJIWre+ZhgfpD64AFa+qUTCR8khdHJOWo4lb4TKqJtmo7sG6koEXbfZUj+iyHRxrIUUlF
	 MN77HX+DsEaY8Tyy/0idfF/UQZ56katFHzH82GNCxZP6Jst/TvLVy7igFLLZwNZB3ErmLZZlnUwD
	 wlhJNAmrGdC/7hOiSqqaai5Zja4P2Azq3urm/j2yyxpIsWV6GjhcmZc/b1AZcIpDn566FoMyjgg6
	 KtN8DyiI9cmGi2WGumt4C5dQOXI5McbbimphRFnpE2E+JCEHsLyFbk902yLCT31fAqM9cbFrv7xM
	 FsO4yBNRrXxkJiOd8uk9jpS2pbwqIRxatWsKHveHKra2ivAPq2MGpFvTo9dTGgtvaICWy4++5iNB
	 OFvu8jLTg+iMwKHCOaK5A65KIXaJbsY8VHiZzxGtI=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Yanhao Dong <570260087@qq.com>
To: rafael@kernel.org
Cc: daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ysaydong@gmail.com
Subject: [PATCH] Fixes: 496d0a648509 ("cpuidle: Fix guest_halt_poll_ns failed to take effect when setting guest_halt_poll_allow_shrink=N")
Date: Mon, 26 Aug 2024 16:58:36 +0800
X-OQ-MSGID: <20240826085836.530152-1-570260087@qq.com>
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


