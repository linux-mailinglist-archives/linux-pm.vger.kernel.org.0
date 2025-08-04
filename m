Return-Path: <linux-pm+bounces-31816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0714B1987D
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 02:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC961894B83
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 00:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C39E1DE3C8;
	Mon,  4 Aug 2025 00:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxwEij1A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED6E2BD11;
	Mon,  4 Aug 2025 00:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267728; cv=none; b=olClwYXfUtJaUxWDUBFs3SazIDFoVt18v8PwyEeCI1+RyckkKQhriJpDYGZxaNEaghm1lSoa2pwfab/migClhVZiXwnxBatqzzaUsFMaQoDAL9tqaLMWfMcKGQSLHTFkmuXJGZVXDtcDvnfn6J/X7eztsTfcMu9NTQbnbqEQstE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267728; c=relaxed/simple;
	bh=OxKNcqewlJuWFNCRUA6yktG1W19uNKAs95onhupDJlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fmjA26JdtlPRuublK1E+WpLA2jVezd91jaUXZR2Kzedy0Jd8/YtskHA8Rtf3HnSJnuRcVV6mzRjeyNloKZwxevEC8Y+0z8YgGl6Xsvu/f/HpCqEvF2SUcAIwyhSxoOnaspMq+I2hEUOyg+UIC4zOn3bj81aCYzrBW9oknwGncYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxwEij1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5F9C4AF09;
	Mon,  4 Aug 2025 00:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267728;
	bh=OxKNcqewlJuWFNCRUA6yktG1W19uNKAs95onhupDJlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hxwEij1ALobdhkCZCm+Vt2J3kDCb3URdb+9ILPLO848vtHsDEiY7L5D9rkUyiB8pU
	 +AqXVjK7bPo88aZqDKIZ8pFeZrHxANQWQtoMvVP40ljKwQm0SNV5jmyVZIycMwW3t9
	 f1T+47i9Qfw2Oj3i3hlabBHN//uROQfYq4ZxiM6BmorqvzCKln2+6SRveuhNp2/7qE
	 l18G1vnjLjEv+TJLsbzdJnigBeFJ0PrGjZD89BZRpn9pU/OfRWnLWyQ3tNBnp0GvWt
	 i9VOxvhnjwoiUvnw2srV4WOFiCwwZcEJKSb10tZds7rKjO+OYPsFCgdxmzKMqIpOmj
	 3QaB2pWGK+0Vg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: tuhaowen <tuhaowen@uniontech.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 31/59] PM: sleep: console: Fix the black screen issue
Date: Sun,  3 Aug 2025 20:33:45 -0400
Message-Id: <20250804003413.3622950-31-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804003413.3622950-1-sashal@kernel.org>
References: <20250804003413.3622950-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.101
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


