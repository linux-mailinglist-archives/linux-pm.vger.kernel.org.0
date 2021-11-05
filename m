Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E1544659D
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 16:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhKEPZm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 11:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233330AbhKEPZl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Nov 2021 11:25:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A21161037;
        Fri,  5 Nov 2021 15:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636125782;
        bh=SqXbChSnDaXFGPgVQdxjFDEugSBYCURJsa2sAqkFNNg=;
        h=From:To:Cc:Subject:Date:From;
        b=jxtxGOL2YoxoT2/yKMVeR/jc+bUWPN9bDY/yhZPCw3fokccuzCgByw15Nzx2ZlxJo
         wjGopXljGijo9X9oF2ir5yVpZpboc3d9uwnIT3nt6n+3g8ZfVU5YbkWkd+obhlo3lf
         JKqyePC61iydtXBx9ZzcapqcaduQdRO6mFeoDM9JzMT9RJTvVu3fTn01f2HpovBlpn
         rZdYu3DBY3SlVkCpL/2DIbgjAVs3RSbYfh/qL+DQiDu1WH4nh2r8eD3vO7VkywnmpH
         OIUCLWPepMNoEdIRM4yFUvnTMM+3r8Zf7za9EosQrNmzqRXZCwxGbXNJQYuv5NVgeI
         lknJBerkJl5yA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2] power: reset: ltc2952: Fix use of floating point literals
Date:   Fri,  5 Nov 2021 08:20:50 -0700
Message-Id: <20211105152049.2522250-1-nathan@kernel.org>
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
the values are only assigned to integer types. Use NSEC_PER_MSEC, which
is the same integer value as '1E6L', to avoid changing functionality but
fix the error.

Fixes: 6647156c00cc ("power: reset: add LTC2952 poweroff driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/1497
Link: https://github.com/llvm/llvm-project/commit/a8083d42b1c346e21623a1d36d1f0cadd7801d83
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

v1 -> v2: https://lore.kernel.org/r/20211104215047.663411-1-nathan@kernel.org/

* A separate review pointed out that NSEC_PER_MSEC is a better choice
  than USEC_PER_SEC because ktime_t is nanoseconds and the few functions
  that take these values work in nanoseconds. The value is the same but
  the documentation is better.

* Pick up Nick's review tag.

 drivers/power/reset/ltc2952-poweroff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index fbb344353fe4..65d9528cc989 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -159,8 +159,8 @@ static void ltc2952_poweroff_kill(void)
 
 static void ltc2952_poweroff_default(struct ltc2952_poweroff *data)
 {
-	data->wde_interval = 300L * 1E6L;
-	data->trigger_delay = ktime_set(2, 500L*1E6L);
+	data->wde_interval = 300L * NSEC_PER_MSEC;
+	data->trigger_delay = ktime_set(2, 500L * NSEC_PER_MSEC);
 
 	hrtimer_init(&data->timer_trigger, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	data->timer_trigger.function = ltc2952_poweroff_timer_trigger;

base-commit: d4439a1189f93d0ac1eaf0197db8e6b3e197d5c7
-- 
2.34.0.rc0

