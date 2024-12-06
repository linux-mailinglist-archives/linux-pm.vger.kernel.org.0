Return-Path: <linux-pm+bounces-18694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43AF9E6EDA
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 14:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADA6284609
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 13:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B18A20C485;
	Fri,  6 Dec 2024 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaYTzm4W"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236FE20C47C;
	Fri,  6 Dec 2024 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490268; cv=none; b=OqLdFuUZbD9O2JUmEkVto3DbWm8mCx5N9rki83KaqiXvDCddsTLASE/AArciRbhBoLm5upqX0Dz0dY3tlyqWLqp9oMh1+3NCnHVKXHGxBb3dr7u5y7CDaUiBYLJD/Lu3tf/jT0GNP0V90iRA92DppeheMfyL8irYZXCF5tT9YqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490268; c=relaxed/simple;
	bh=3JoSvgVSyWPdcDhFxJbqeFmv3Z/rfrPtZzh7qZxBCX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIVTXU5OfoULJWNWAT/e9Iz64iDHlwIzx4qGsD6akpVhwp8Uc3pg3INMQxU8sxw4MAVmuGazr+8OgLZCCFtKnHeG3X1omVwmsGQoftS101FTlOH2Gr+AU8MWdM4S764/YOENpNwYEGuY0FazckxRICjrltSk0VL6HVbDIZgDQbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaYTzm4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5524C4CED2;
	Fri,  6 Dec 2024 13:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733490268;
	bh=3JoSvgVSyWPdcDhFxJbqeFmv3Z/rfrPtZzh7qZxBCX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HaYTzm4WPezL5jQKIv/vqxlxcLlqC6eIqwMGZkUG0FOSlkx3/WTK2SMhFX1qdMzIf
	 FRfCsoQfeKHWczjfmu2HXKzqy/KzYuf0EQ2buVIOiMQrEeShKQeucA/gkicmSyU3jE
	 lnqyj3ybzFgvkfmT+gQxSPkHGR2UdWXxqtsV3HSR1oMSiY/Ew9KcY0U2zWX1Nh3wSn
	 jK4PIFtwWTqA8xYaT4TYnCStsKk0d1MJ2FxhML4aUiKIGWhUTW32EJeUy9r163OJy5
	 GUEDg4U+m4et5EeyTYz01pIVfBiyCA3/kJPi60SPVPgkp74MdV6alW8meR4L+p3zdz
	 G2AUXR9VFd/Ow==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4/5] cpuidle: Remove call_cpuidle_s2idle()
Date: Fri,  6 Dec 2024 14:04:07 +0100
Message-ID: <20241206130408.18690-5-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241206130408.18690-1-frederic@kernel.org>
References: <20241206130408.18690-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This middle call is unecessary, especially now that its counterpart
call_cpuidle() has been removed.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/idle.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 9eece3df1080..86b902eb24fe 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -126,19 +126,6 @@ void __cpuidle default_idle_call(void)
 	instrumentation_end();
 }
 
-static int call_cpuidle_s2idle(struct cpuidle_driver *drv,
-			       struct cpuidle_device *dev)
-{
-	int ret;
-
-	if (current_clr_polling_and_test())
-		return -EBUSY;
-
-	ret = cpuidle_enter_s2idle(drv, dev);
-	__current_set_polling();
-	return ret;
-}
-
 /**
  * cpuidle_idle_call - the main idle function
  *
@@ -184,10 +171,12 @@ static void cpuidle_idle_call(void)
 		u64 max_latency_ns;
 
 		if (idle_should_enter_s2idle()) {
-
-			entered_state = call_cpuidle_s2idle(drv, dev);
-			if (entered_state > 0)
-				goto exit_idle;
+			if (!current_clr_polling_and_test()) {
+				entered_state = cpuidle_enter_s2idle(drv, dev);
+				__current_set_polling();
+				if (entered_state > 0)
+					goto exit_idle;
+			}
 
 			max_latency_ns = U64_MAX;
 		} else {
-- 
2.46.0


