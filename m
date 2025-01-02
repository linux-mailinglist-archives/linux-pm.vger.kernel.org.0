Return-Path: <linux-pm+bounces-19909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F689FFABB
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 16:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE461881A18
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9AB1B4141;
	Thu,  2 Jan 2025 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mv6syPWb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1FF1B4137;
	Thu,  2 Jan 2025 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735830144; cv=none; b=VaHvH9dzQUYYIahqv62MJR38uA8fPcYc9sJqZQu0uasSJVDdZOmCNyyZ4jkNIki5V9kDsCfmMSgxL2DY6NFSEKOmF3ZhvS75ZgY8d05A8FnMAiUxvCLg8uAYxbGFxRIB3yNd3iJoJ/1pOhGCyJ68IKmvcLO/vdh5FUO+3u95mYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735830144; c=relaxed/simple;
	bh=3JoSvgVSyWPdcDhFxJbqeFmv3Z/rfrPtZzh7qZxBCX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1SS52VgUroEt4Vuom4jsH1g/Vl3lOitetHgQdqdQqb3iqcW5/cpgGKtojj/ecSUAoY3iMHKO0qIPV1g7xl+bOQosjoWHnlW8WWJvdk58u0Dp6/OSy/alb+g4xByt0/K1aukoKw09Tm/EEE9MXAzEWqkifmooI9SEyWrlGENlPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mv6syPWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762CBC4CEDC;
	Thu,  2 Jan 2025 15:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735830143;
	bh=3JoSvgVSyWPdcDhFxJbqeFmv3Z/rfrPtZzh7qZxBCX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mv6syPWbiN7Tx5+Yoc4UulxCwUKy4O0bmvLn47nwBqpuOJV3bDPky3UCqfVa00XlZ
	 kuEZMFBO8Q3xLU7yp4lhywRa3sluwbmEfxQeEX37PBU2xkbfewGM/OMC3/JG2NvFAw
	 T0FydsonY8VHD59oNfaO2Gpn68BnxMlTdpvnacSBZa18MYX7fpgEDvyELBkrtOHOaK
	 hEtKr4uI3fyfgOyMrSO2NyU3A125yipjINU232/G4cIE+PkBNgsTTnMcasPxw4uXrq
	 wtHo0PacbNXJtsbqC24dgvA0kzat8tn3sSnrAJnEs2i8i3nZENuoBunLP0SMRTsZ/X
	 QmTtadfXX2y0A==
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
Subject: [PATCH 5/6] cpuidle: Remove call_cpuidle_s2idle()
Date: Thu,  2 Jan 2025 16:01:59 +0100
Message-ID: <20250102150201.21639-6-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250102150201.21639-1-frederic@kernel.org>
References: <20250102150201.21639-1-frederic@kernel.org>
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


