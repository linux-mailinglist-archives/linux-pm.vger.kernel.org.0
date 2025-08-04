Return-Path: <linux-pm+bounces-31809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA922B1983E
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 02:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C6D3A95B7
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 00:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CF41DF247;
	Mon,  4 Aug 2025 00:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6RhfvLH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9D01C5D7B;
	Mon,  4 Aug 2025 00:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267568; cv=none; b=CAmW1UGaVlPbnV3uM67FsCwvkaiCzZTKefQssx3ZHJ2PgksifCfuyjedE4dBKCEb+m0YPii2J9rbm2nDZAfMUe3iOOhk/+kc267EvTZ5TJm+Gvii0uEhkNVEEdSjDDR7TYN7KqlJokg1voN8oYlZqs1y8ROD7jHMX/WUCAZ58uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267568; c=relaxed/simple;
	bh=OxKNcqewlJuWFNCRUA6yktG1W19uNKAs95onhupDJlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hY5YxuvwDL82Ii7Jmxv6YsrXr1ccNFwQ7UcXXzBvG4NBLJyfXDCRY3Pf7Tc0QTjS9XgH/zS5wAl12lAgANDoPjfMd7qqnOUSI7k6rm9VsYD6dLZNgV+eZKsJ4HzyODVKhAsmkaNPdbJ5uGIlYoksVPgtP9GMlpLQXejreWwheMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6RhfvLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AB3C4CEEB;
	Mon,  4 Aug 2025 00:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267568;
	bh=OxKNcqewlJuWFNCRUA6yktG1W19uNKAs95onhupDJlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6RhfvLHXFys7A8B5JWImtgJ5ny1C1C4orObSFT3VyFgVPNIFWh0FTGulGIk/LVow
	 P/2baLjISlUFGUpfRROp7dbNAAsZhPw9MqotymGYiF2/LATR6iUVHTZfKrg3DTCDoi
	 iXTXs6xdEJj5agQ6T8ZbaImU7WFQ7mmD1ad9kvPDMUxVfPEJvWoLtplCb+5+hVCaSE
	 L3Nxr+TC9EZM/iBcwLIjJdxQcKJBtLKiP6fZ1zjWMr0O9xHqQNpiPrynlr5ZuPqfC3
	 Vt4oeBgutX5f8DJr6ARsil4cVpGizjke6GOaXA4N8a4dUzGWoP6xLmv0N+PfmZQgrP
	 PPqqUyk0lb0Ww==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: tuhaowen <tuhaowen@uniontech.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 37/69] PM: sleep: console: Fix the black screen issue
Date: Sun,  3 Aug 2025 20:30:47 -0400
Message-Id: <20250804003119.3620476-37-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804003119.3620476-1-sashal@kernel.org>
References: <20250804003119.3620476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.41
Content-Transfer-Encoding: 8bit

From: tuhaowen <tuhaowen@uniontech.com>

[ Upstream commit 4266e8fa56d3d982bf451d382a410b9db432015c ]

When the computer enters sleep status without a monitor
connected, the system switches the console to the virtual
terminal tty63(SUSPEND_CONSOLE).

If a monitor is subsequently connected before waking up,
the system skips the required VT restoration process
during wake-up, leaving the console on tty63 instead of
switching back to tty1.

To fix this issue, a global flag vt_switch_done is introduced
to record whether the system has successfully switched to
the suspend console via vt_move_to_console() during suspend.

If the switch was completed, vt_switch_done is set to 1.
Later during resume, this flag is checked to ensure that
the original console is restored properly by calling
vt_move_to_console(orig_fgconsole, 0).

This prevents scenarios where the resume logic skips console
restoration due to incorrect detection of the console state,
especially when a monitor is reconnected before waking up.

Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
Link: https://patch.msgid.link/20250611032345.29962-1-tuhaowen@uniontech.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

**1. Bug Fix Nature:**
The commit fixes a clear user-visible bug - a black screen issue that
occurs when:
- A computer enters sleep without a monitor connected
- A monitor is connected while the system is asleep
- Upon wake, the console remains on tty63 (SUSPEND_CONSOLE) instead of
  returning to tty1

This is a functional regression that impacts user experience, making the
system appear unresponsive or broken after resume.

**2. Small and Contained Fix:**
The fix is minimal and well-contained:
- Adds a single `static bool vt_switch_done` flag
- Modifies only two functions: `pm_prepare_console()` and
  `pm_restore_console()`
- Total change is just 6 lines of code (excluding whitespace)
- The logic is straightforward: track whether VT switch happened during
  suspend, and ensure restoration happens during resume

**3. Low Risk of Side Effects:**
The change has minimal risk:
- The new flag (`vt_switch_done`) is only set when
  `vt_move_to_console()` succeeds
- The restoration logic preserves existing behavior when
  `pm_vt_switch()` returns true
- The fix only adds an additional condition `!vt_switch_done` to ensure
  restoration happens even when `pm_vt_switch()` returns false during
  resume
- No architectural changes or new features are introduced

**4. Critical Subsystem but Safe Change:**
While this touches the PM/console subsystem (critical for
suspend/resume), the change is safe:
- It doesn't modify the core VT switching mechanism
- It only ensures the existing restoration path is executed when needed
- The file has been stable since 2013 (last major change was
  f43f627d2f17e)

**5. Clear Problem Description:**
The commit message clearly describes:
- The specific scenario that triggers the bug
- The root cause (skipped VT restoration)
- The solution (tracking VT switch state)

**6. Follows Stable Rules:**
This aligns perfectly with stable tree criteria:
- Fixes a real bug affecting users
- Minimal change (6 lines)
- No new features
- Clear fix for a specific problem
- Low regression risk

The commit addresses a real-world scenario where users connecting
monitors to sleeping systems experience black screens upon wake - a
frustrating issue that makes systems appear broken. The fix is surgical,
adding only the minimum tracking needed to ensure proper console
restoration.

 kernel/power/console.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/power/console.c b/kernel/power/console.c
index fcdf0e14a47d..19c48aa5355d 100644
--- a/kernel/power/console.c
+++ b/kernel/power/console.c
@@ -16,6 +16,7 @@
 #define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
 
 static int orig_fgconsole, orig_kmsg;
+static bool vt_switch_done;
 
 static DEFINE_MUTEX(vt_switch_mutex);
 
@@ -136,17 +137,21 @@ void pm_prepare_console(void)
 	if (orig_fgconsole < 0)
 		return;
 
+	vt_switch_done = true;
+
 	orig_kmsg = vt_kmsg_redirect(SUSPEND_CONSOLE);
 	return;
 }
 
 void pm_restore_console(void)
 {
-	if (!pm_vt_switch())
+	if (!pm_vt_switch() && !vt_switch_done)
 		return;
 
 	if (orig_fgconsole >= 0) {
 		vt_move_to_console(orig_fgconsole, 0);
 		vt_kmsg_redirect(orig_kmsg);
 	}
+
+	vt_switch_done = false;
 }
-- 
2.39.5


