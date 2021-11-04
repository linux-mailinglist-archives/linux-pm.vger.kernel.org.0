Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C09A445BD6
	for <lists+linux-pm@lfdr.de>; Thu,  4 Nov 2021 22:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbhKDVxn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 17:53:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhKDVxn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Nov 2021 17:53:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DF326120F;
        Thu,  4 Nov 2021 21:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636062664;
        bh=6uuCq/8CRIGP5S2X4KNwjbkO0sLcSxEB9M1bRzRr0Jw=;
        h=From:To:Cc:Subject:Date:From;
        b=jKIx20F9VIZOcXYRmgZ/fRP2fOI/XUnk8COssMZ9rzEH9bfn3hpSbinHPXI4Ilhla
         7g0Ch6HurzKkOCn58RPpWYvgz4+3YEYLEIwqHYohb8reAtIYiBClFZJVkntCR2SeNe
         JNnP5jh8GOerf6sOXg4cbn0HesbvRnVIsY0MIEbX2W4O/Ko7fZY1G4acj47wZzQc+Y
         BwHy4TNb0M/79qDy4T74tWYrEzx6ZZtd0mxqMPKqUXhwe8Ur16Y+OWsjy3cGZZ1Wxd
         PqdvHQY9kwZPTdt9uibFgPpbmLa1zUjwsk+PZc8Z/ZDr6bJH2IcGrDVBQm3lWKZ6i+
         Ai7V0Z5M6rmCA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] power: reset: ltc2952: Fix use of floating point literals
Date:   Thu,  4 Nov 2021 14:50:47 -0700
Message-Id: <20211104215047.663411-1-nathan@kernel.org>
X-Mailer: git-send-email 2.34.0.rc0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A new commit in LLVM causes an error on the use of 'long double' when
'-mno-x87' is used, which the kernel does through an alias,
'-mno-80387' (see the LLVM commit below for more details around why it
does this).

drivers/power/reset/ltc2952-poweroff.c:162:28: error: expression requires  'long double' type support, but target 'x86_64-unknown-linux-gnu' does not support it
        data->wde_interval = 300L * 1E6L;
                                  ^
drivers/power/reset/ltc2952-poweroff.c:162:21: error: expression requires  'long double' type support, but target 'x86_64-unknown-linux-gnu' does not support it
        data->wde_interval = 300L * 1E6L;
                           ^
drivers/power/reset/ltc2952-poweroff.c:163:41: error: expression requires  'long double' type support, but target 'x86_64-unknown-linux-gnu' does not support it
        data->trigger_delay = ktime_set(2, 500L*1E6L);
                                               ^
3 errors generated.

This happens due to the use of a 'long double' literal. The 'E6' part of
'1E6L' causes the literal to be a 'double' then the 'L' suffix promotes
it to 'long double'.

There is no visible reason for floating point values in this driver, as
the values are only assigned to integer types. Use USEC_PER_SEC, which
is the same integer value as '1E6L', to avoid changing functionality but
fix the error.

Fixes: 6647156c00cc ("power: reset: add LTC2952 poweroff driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/1497
Link: https://github.com/llvm/llvm-project/commit/a8083d42b1c346e21623a1d36d1f0cadd7801d83
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/power/reset/ltc2952-poweroff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index fbb344353fe4..ebe3f2bed4c5 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -159,8 +159,8 @@ static void ltc2952_poweroff_kill(void)
 
 static void ltc2952_poweroff_default(struct ltc2952_poweroff *data)
 {
-	data->wde_interval = 300L * 1E6L;
-	data->trigger_delay = ktime_set(2, 500L*1E6L);
+	data->wde_interval = 300L * USEC_PER_SEC;
+	data->trigger_delay = ktime_set(2, 500L * USEC_PER_SEC);
 
 	hrtimer_init(&data->timer_trigger, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	data->timer_trigger.function = ltc2952_poweroff_timer_trigger;

base-commit: d4439a1189f93d0ac1eaf0197db8e6b3e197d5c7
-- 
2.34.0.rc0

