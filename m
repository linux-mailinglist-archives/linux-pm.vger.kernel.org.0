Return-Path: <linux-pm+bounces-201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C767F862F
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 23:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C310BB212B0
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 22:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D34A22069;
	Fri, 24 Nov 2023 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHOgFJue"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A13DB80
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 22:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287BFC433C8;
	Fri, 24 Nov 2023 22:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700865169;
	bh=sUhE/qFaIDHh5RCqYIo7aaxz5Ifr+Yh3RMfcwpeT7hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rHOgFJueqacJh3oSGholAxY008YeuYv2dLD8Hx1i+J42ckaCsPEue+U26TfZlARwm
	 JZW9by+SVFIhonSoEAeY96DUR5A6LRpOk6l+X5lW7jWz8WuKOZORla5W+Tk1XuALgj
	 MYwIK3qgK9tew6YwvquWXqWd54fnBITkSQXVnS19hVQgzWyRlYjXhPvU4Rg1N4BvgV
	 AjpcEKOFBoBsU0hsUGCECscZ6jxHwYsEELkWxGucl5t5JB8X3Y+QjKZW/MajGaie0o
	 MfNTU2ss+3GBqu3nevft7gW6YovD70zEZAYatkvvZs8AwuxvfnjJpAPewKS2KYK1MV
	 H6HsE5Vo/TsRA==
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
Subject: [PATCH 3/7] cpuidle: Remove unnecessary current_clr_polling_and_test() from haltpoll
Date: Fri, 24 Nov 2023 23:32:22 +0100
Message-ID: <20231124223226.24249-4-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231124223226.24249-1-frederic@kernel.org>
References: <20231124223226.24249-1-frederic@kernel.org>
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
 drivers/cpuidle/cpuidle-haltpoll.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
index e66df22f9695..b641bc535102 100644
--- a/drivers/cpuidle/cpuidle-haltpoll.c
+++ b/drivers/cpuidle/cpuidle-haltpoll.c
@@ -28,11 +28,8 @@ static enum cpuhp_state haltpoll_hp_state;
 static int default_enter_idle(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv, int index)
 {
-	if (current_clr_polling_and_test()) {
-		local_irq_enable();
-		return index;
-	}
 	arch_cpu_idle();
+
 	return index;
 }
 
-- 
2.42.1


