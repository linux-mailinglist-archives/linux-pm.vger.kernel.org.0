Return-Path: <linux-pm+bounces-19905-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808859FFAB1
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 16:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C09C161CD7
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 15:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00321B4143;
	Thu,  2 Jan 2025 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L63/ynnU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58511B413B;
	Thu,  2 Jan 2025 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735830130; cv=none; b=Q+4vPgqKhcD7WW+PNswohAgvojqep6vIAmuAIhtW/LR9xr5PeyUa6RLATmBjx1kwr9GjWvGe9QBSsEq1sDgGxNEbArPLeGxuxnBxhnbz0uiholmn0Ly8/uL/7+7vPrpjfX5U2u8D6Fqf/9uzlsSB9RjjHJ6fC2rm7VMrbw0TfNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735830130; c=relaxed/simple;
	bh=6M3MwJVPQVJfwZCyUXnKFfzUiBOjUgHdAX5hBQtJ7Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nARbfYI+X2Z+hWDcq7T/ASQynDg7G0yH6u3zW70XyacVsQbh+UiqGpMVW0d37YQWjgLkkzN6ByGgZgG8CXu6jMiZ/tqRVH85a/5GLvNa0ofmCgb5yIHsfMoVM/da5fvm766geyw1rBOl1nKhQRUz5Er8AG9HhKKrQvTRa0aIS8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L63/ynnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24548C4CED7;
	Thu,  2 Jan 2025 15:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735830130;
	bh=6M3MwJVPQVJfwZCyUXnKFfzUiBOjUgHdAX5hBQtJ7Q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L63/ynnUEauCbVUAEBzIyL8lnuVzbb6Q6MQwj/R5Qj4zxbUTVGNhAR6BYL59OZa9j
	 PReQL/bPHabbBuhHMfpTFUOziL6CnDFf9bZYRPUc0J6S2PBUsSP2tiQuwkuB+zWRUg
	 t2/nV8Ts607pMLfqadssTmz/4hTUZGNTVgiEsplhGR8qiBB4kGyxo99NH4lR7TTRUc
	 amHMpddZ8QqPLCoicVfitIVrPSyg5XLgt1JMo0LPPPJ+jYA+ZwjFPQlC/Wc1XucIS2
	 LEYNUGCVJKuVo/cAPMT+Voa1g6ybXWrnoST1nWVWUNqMAfjItkqu9Jcqf0MxGcZRWK
	 5tQSVEIelL/SA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 1/6] cpuidle: Remove unnecessary current_clr_polling_and_test() from haltpoll
Date: Thu,  2 Jan 2025 16:01:55 +0100
Message-ID: <20250102150201.21639-2-frederic@kernel.org>
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

When cpuidle drivers ->enter() callback are called, the TIF_NR_POLLING
flag is cleared already and TIF_NEED_RESCHED checked by call_cpuidle().

Therefore calling current_clr_polling_and_test() is redundant here and
further setting of TIF_NEED_RESCHED will result in an IPI and thus an
idle loop exit. This call can be safely removed.

Cc: Marcelo Tosatti <mtosatti@redhat.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/cpuidle/cpuidle-haltpoll.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
index bcd03e893a0a..07dd9f000273 100644
--- a/drivers/cpuidle/cpuidle-haltpoll.c
+++ b/drivers/cpuidle/cpuidle-haltpoll.c
@@ -28,9 +28,6 @@ static enum cpuhp_state haltpoll_hp_state;
 static __cpuidle int default_enter_idle(struct cpuidle_device *dev,
 					struct cpuidle_driver *drv, int index)
 {
-	if (current_clr_polling_and_test())
-		return index;
-
 	arch_cpu_idle();
 	return index;
 }
-- 
2.46.0


