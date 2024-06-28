Return-Path: <linux-pm+bounces-10173-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 481C391BAA4
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 11:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43941F24746
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 09:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE035147C71;
	Fri, 28 Jun 2024 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hgJdHlnT"
X-Original-To: linux-pm@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774A27347B;
	Fri, 28 Jun 2024 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565285; cv=none; b=KXiIyEWTmKXePTxk48rLTNDxtnZ5ow5vh6dDsmiQ9miy7bWxYfbYj8cmJNOdUx+fivUdxhfswJiro2UB3J2UZGu2VOq8UGvI4HIm5LpNb+mAx5+IMK2O63dqObzhqClISD5A86EFOXWoKvKv6ewi6cU6gggaBs6lru8CwVarhkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565285; c=relaxed/simple;
	bh=t6E3YyEOBf2I57/ODAt4w7a2zijQZIz76U604qLgUMY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=fygSisCJYkRCbMpMI8cuFJjW47NvbxAfXUQ3JzIYdEGyBiZIWjcFXN+lzAIWOgfdVoRCB+P5VJzcgW94TyZpgrjm4qxei2zQu/qbZzHmyMulbOp+4zv4PWngmzo0ooVG7dz3uzCgYJwYVSOPY02lfOdo5ouw3dDc7ZCCo3kWBt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hgJdHlnT; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1719564976; bh=k3xkOZZAZTnOpfeg6oi7bd7/Sd8fmJuPwEsMntl666A=;
	h=From:To:Cc:Subject:Date;
	b=hgJdHlnT7zwpiIxcijQAykz1IWaJw7jZxfStkymoKUaXmlYcdHJ4JXMpZMELFoh3x
	 e7rd0ce4MO6pLtmtI/mQMXFaJodCGYKwU4c2h/F7VjjH4eCbtYujcrIS2WOEIrIuMR
	 8Cy3szulA7JLnsVm8bpFMtnFiXqaunqTDncrsH2w=
Received: from iZ2ze0ccts00nkjy9wuyo6Z.localdomain ([101.201.76.96])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id C4495684; Fri, 28 Jun 2024 16:49:04 +0800
X-QQ-mid: xmsmtpt1719564544tww7kpsch
Message-ID: <tencent_2ACBECB5B8EF2442CE608CE48F8E6131CC09@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieE0DHHvt6z9zbR8n+svGXHWYIZDrXyjTPPjKJvuBEkArYgBmCZT
	 OhN9FXtqOCpWMOocaSmZnGpvuNw65hRWtW0CEuAdKmbI+BzLuYn1DYy7dlAt8Zyf4bMDZTKyCX4Q
	 2ChFqHsuCtmcgzAH8y7RY9vTYOCnIVavry+10A3OwxNJMORo6CMYqCOhL5J0dOTGgTKlCyHCizNT
	 AvrJwezbawCFM1jDNPiRk51mDjZnCVjvZZMiwA2Zi3d/5DO6zMIhX/Q7SwEzPiUH1VwZPZFUKohT
	 2gghTjuYZLQzG5GMJG0veffmuUgA7DIk84ZzQbS5vsC1Rqwl5Vubs8qozfOxAfXBeQF8MMnf5cno
	 vl6PVGtkfeF04dH6vHR14ablfERIcRpgd7d/oBCd/XgEbh0j123ePDHXdjXKBxnLUntkJZxARsOo
	 QCpdsgY+gd4vFw4b0wvS+InGgS/vPAK2H0AYAyitsByVul1vfjiGejBUIOvyzY8Fc6y5+McHYB8g
	 iMDQMXAiXPZjRWRjPBBX3/N97eTu8+/jiKvvkKrZ5AKuChMl1/PFB/sI0r5EmlcbrwfL5G/XZcHv
	 0yVZ5eoniPiKzLZ1gdEpUp8q9Xr4IwWw5l7MKaThSMy0SxHPpw9dEf/ZexvhlL/18R5s15s9EzrD
	 H4N5UOM0buNS87K45lB0am74PXrPBWsNBq8qViOLwMuJS0+ykLCbP0OjWHERbtCCkeAp9nxtsSd2
	 +CEgIGdtLle2Qs6rCbiL+4QUujDfOyApkmMFm2dkFlaQT+8dQD5krIw7IrnGiA7ev0AsmHjcmX73
	 ij6eJ1veqh16Ng7oNwGwXsHxlVANw0ksxPR6n5awO3VDz06imGtj8Yxh5hPbjDTWTkf4HFCvVmvx
	 5TYbmT2/PUNDEERaptlTgfdots5zJ6p72BSXrufPgjccoIm5eo4qNpAnMUxjraUZRIEfIpwVm9ra
	 7rS60i+lWA0aIneaibFP7dujULExUp
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: ysay <570260087@qq.com>
To: rafael@kernel.org
Cc: daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ysay <ysaydong@gmail.com>
Subject: [PATCH] drivers/cpuidle: Fix guest_halt_poll_ns failed to take effect
Date: Fri, 28 Jun 2024 16:49:02 +0800
X-OQ-MSGID: <20240628084902.57897-1-570260087@qq.com>
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


