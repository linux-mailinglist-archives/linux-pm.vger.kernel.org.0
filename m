Return-Path: <linux-pm+bounces-27883-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819D5AC8F51
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 15:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35D5164019
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 13:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4C0280A57;
	Fri, 30 May 2025 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uP7Ic1Fd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10768280A39;
	Fri, 30 May 2025 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608931; cv=none; b=fSfmgn7AXucuy/53XY8ZjRhPEwqec+f1FgFHbWsxpNetoCIfyNaiNZ34sMSGYaL4PNkX+cj56oASMCFYK4cuk3Kiy/kVbRsVx4l5KDTSGFwIqTi8m9mEJl5iDNJkQXWEbzOT8N2ynEX5Od0oZD3PN1mgdTfyeJkJc18zARPSQBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608931; c=relaxed/simple;
	bh=mgsylCNypqzTCIVJj1R4VEgOduZnE90YK7JxXM13pLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Onq5NjBSeQtluJTURd/QH7HWjc2tuBLUlYCWE9P9cTSr2apgoybBTQkUw4MRcwWCWInIGDuqeXOc1BOVWyQPHAciP7KHGMFiRHGlIzAeJuXdvV70KKQPuwXGCcd0QFSub02FC3Vx2deGyUNeEpiFvxMqviY3qxw3LKr3rngkubg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uP7Ic1Fd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C788CC4CEEF;
	Fri, 30 May 2025 12:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608930;
	bh=mgsylCNypqzTCIVJj1R4VEgOduZnE90YK7JxXM13pLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uP7Ic1Fdzo88HjjvWCuMTPaMV+qW9laHgiDwFDcALkb+94QAQCjgHzGXjZrAXi5Rz
	 TsEs8puhhZlhs5FwvqYzAUnQptmzPB9GWJHMRUCwTbBesY732adupDOAhSpXCNkv1k
	 roD5Nf0Yd4qQ9ezNGwRfJV5eMSNWAoDcNRr96P4gsjnW9GLvJo92gyMk7s3VR8FI2m
	 7PcUs7zRTaW85yHAI5MzPjZiHC8fyumns5msUC8zvwxlBEweP0Ur7cdHtPWXM5DhiK
	 TcTDfUEUbalnOy+LOMvqrWF6nH5/aM9mKx2NU9IC03Il0yyqKL/116cQY2ub8HuoxO
	 Lz0eb/Av5OYEg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Charan Teja Kalla <quic_charante@quicinc.com>,
	Patrick Daly <quic_pdaly@quicinc.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rjw@rjwysocki.net,
	len.brown@intel.com,
	pavel@ucw.cz,
	gregkh@linuxfoundation.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 5/6] PM: runtime: fix denying of auto suspend in pm_suspend_timer_fn()
Date: Fri, 30 May 2025 08:42:02 -0400
Message-Id: <20250530124203.2577122-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530124203.2577122-1-sashal@kernel.org>
References: <20250530124203.2577122-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Charan Teja Kalla <quic_charante@quicinc.com>

[ Upstream commit 40d3b40dce375d6f1c1dbf08d79eed3aed6c691d ]

pm_runtime_put_autosuspend() schedules a hrtimer to expire
at "dev->power.timer_expires". If the hrtimer's callback,
pm_suspend_timer_fn(), observes that the current time equals
"dev->power.timer_expires", it unexpectedly bails out instead of
proceeding with runtime suspend.

pm_suspend_timer_fn():

 if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
 	dev->power.timer_expires = 0;
 	rpm_suspend(..)
 }

Additionally, as ->timer_expires is not cleared, all the future auto
suspend requests will not schedule hrtimer to perform auto suspend.

rpm_suspend():

 if ((rpmflags & RPM_AUTO) &&...) {
 	if (!(dev->power.timer_expires && ...) { <-- this will fail.
 		hrtimer_start_range_ns(&dev->power.suspend_timer,...);
 	}
 }

Fix this by as well checking if current time reaches the set expiration.

Co-developed-by: Patrick Daly <quic_pdaly@quicinc.com>
Signed-off-by: Patrick Daly <quic_pdaly@quicinc.com>
Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
Link: https://patch.msgid.link/20250515064125.1211561-1-quic_charante@quicinc.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Now, based on my analysis, let me provide the decision: **YES** This
commit should be backported to stable kernel trees. Here's my extensive
analysis: ## Bug Analysis This is a clear **logical bug fix** in the PM
runtime autosuspend mechanism that affects device power management. The
issue is in the `pm_suspend_timer_fn()` function at
`drivers/base/power/runtime.c:1006`. ## The Problem The current code
uses a strict less-than comparison: ```c if (expires > 0 && expires <
ktime_get_mono_fast_ns()) { ``` However, this creates a race condition
where: 1. When `pm_runtime_put_autosuspend()` schedules an hrtimer to
expire at exactly `dev->power.timer_expires` 2. If the timer callback
`pm_suspend_timer_fn()` observes that the current time **equals**
`dev->power.timer_expires` (not less than), it incorrectly bails out 3.
The timer expires but the device is not suspended 4. Since
`timer_expires` is not cleared, all future auto-suspend requests fail
because the condition `if (!(dev->power.timer_expires && ...))` in
`rpm_suspend()` (line 596-597) will always be false ## The Fix The fix
correctly changes the comparison to `<=` (less than or equal): ```c if
(expires > 0 && expires <= ktime_get_mono_fast_ns()) { ``` This ensures
that the suspend is triggered when the current time equals or exceeds
the expiration time. ## Why This Should Be Backported 1. **Fixes a Real
User-Affecting Bug**: Devices may fail to auto-suspend, leading to
increased power consumption and potential battery drain on mobile
devices. 2. **Minimal Risk**: This is a one-character change (`<` to
`<=`) that fixes a clear logical error. The change is extremely
contained and low-risk. 3. **Critical Subsystem**: PM runtime is a
critical kernel subsystem affecting all device power management. A
failure here can impact system-wide power efficiency. 4. **No
Architectural Changes**: This doesn't introduce new features or change
architecture - it simply fixes incorrect logic. 5. **Small and
Contained**: The fix is confined to a single comparison operator in one
function. 6. **Clear Co-authors**: The commit shows collaboration
between Patrick Daly and Charan Teja Kalla from Qualcomm, indicating
this was found in real-world usage. ## Comparison with Similar Commits
Looking at the historical examples: - **Similar Commit #5 (Status:
YES)**: Also a PM runtime timer fix with data type correction - this had
similar characteristics and was backported - The current commit follows
the same pattern: critical PM runtime bug fix with minimal, contained
changes ## Stable Tree Criteria Met - ✅ Fixes important bug affecting
users - ✅ Relatively small and contained fix - ✅ No clear side effects
beyond fixing the issue - ✅ No major architectural changes - ✅ Touches
critical kernel subsystem (appropriately) - ✅ Follows stable tree rules
(important bugfix, minimal risk) - ✅ Has clear explanation of the
problem and solution This commit perfectly fits the stable backport
criteria and should be included in stable kernel trees to ensure proper
device power management functionality across all kernel versions.

 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index d301a6de762df..7fa231076ad5f 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -982,7 +982,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
 	 * If 'expires' is after the current time, we've been called
 	 * too early.
 	 */
-	if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
+	if (expires > 0 && expires <= ktime_get_mono_fast_ns()) {
 		dev->power.timer_expires = 0;
 		rpm_suspend(dev, dev->power.timer_autosuspends ?
 		    (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
-- 
2.39.5


