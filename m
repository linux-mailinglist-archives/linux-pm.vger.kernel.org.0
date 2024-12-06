Return-Path: <linux-pm+bounces-18691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B72489E6EE5
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 14:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77671884B0E
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 13:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2E9207E0D;
	Fri,  6 Dec 2024 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/6cjzG5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2118C20767C;
	Fri,  6 Dec 2024 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490261; cv=none; b=uALo27/GlZb5CLcM/si4MikclglRRAdgCZ9ZLBDYHVdFGaj9Y2EfUNbYuLvtU0ZiElcZw2boaREU8aXANiX2ELPEq8Pg1Eb4r9rl4Dyi4kinZhJCwZxl69wspOQs5rQC0H7LyRcqHuw09WKhWwhwKMERoJBbdoXCt1P+q+VVM24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490261; c=relaxed/simple;
	bh=6M3MwJVPQVJfwZCyUXnKFfzUiBOjUgHdAX5hBQtJ7Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqEUD1XaenY9sjyQQlH3x2OR9SFDK4whqtxVoaR/o8gO5H22QsmEgTwhWzYqNbIOGrbPFeh/0O0LR1A0pcDsw4HuIPS+lZ2oTPPbjN0FMqKhWyplNvYGn3/6DhjfN5l/XcuEeMkVO2fq2ndXNZQZh78u9kwQwbYWf8DyWIVviSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/6cjzG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5ADC4CEDE;
	Fri,  6 Dec 2024 13:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733490259;
	bh=6M3MwJVPQVJfwZCyUXnKFfzUiBOjUgHdAX5hBQtJ7Q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/6cjzG5zZIDgkBwgqZvGzdSl48pBze2jgEk6hRe4Ym9GdrA0ri1eVBRb4x5S/9zV
	 3LdX69qDJVqw59SRrKNeGfePaleEcdssZ+l65kNq5n+bwK/rc7+nFc3QSrLIgztFoJ
	 ozZAf0/eX6Z6JMm6f2Xf37Lb3AlEvC2J6Ja18TRZVtMObd8ER6mLL9nHpUODhEll4V
	 3f+dHtR2xkFOa3yzmNE2i6wyXXc/8XSKgJJCgo14GWV3nsXHlegr73844rmdf5ec+E
	 ZO3jSA/SxJ8VpBL3ljgpqGqDrtrPiSRc79cIn74Il/+gltSygcQn+UUjnnzCwTweQb
	 aiWkGR+nB9DYg==
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
Subject: [PATCH 1/5] cpuidle: Remove unnecessary current_clr_polling_and_test() from haltpoll
Date: Fri,  6 Dec 2024 14:04:04 +0100
Message-ID: <20241206130408.18690-2-frederic@kernel.org>
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


