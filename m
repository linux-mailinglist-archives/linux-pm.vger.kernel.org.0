Return-Path: <linux-pm+bounces-27874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9211AC8F13
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 15:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922C3A4676B
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 12:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861E4267B01;
	Fri, 30 May 2025 12:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsIpUQxE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEC3266F0D;
	Fri, 30 May 2025 12:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608865; cv=none; b=lvoW1Bp3ZF/B91kZYy5FyCb6vc90K1PDbzXjrysmVw3Ec8bfRBpb932DnnomMfPpdYCS0YKMCFlDczhMu1aHGk0C4knWpFyF3zwa8clQtRsR/4ImyKH7HuIT4J3MP58YKYZC6QZ/3GuY62s/QLHjIUj5rxR5BPN9DR36G1QDM6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608865; c=relaxed/simple;
	bh=Xj1OjedXfVQ0PmAdnb3etoieZC3+OPgn7A8dAMBbGuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeMStURoxff0KGNYnXCZxVyiiJ3IKQpxDPW5P+uegHzm8Ga+ftBQFzPYwr6bYtG6NkxIpHIYIKxUykd7ecXLQWCniYGMWq8c9muiK111NUbl3RCQHOzY3xbV/yhTNdN84jLpyv5rcCZBwWpYigfrUCHJK85Sm/tlBENReDxn66s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsIpUQxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E089C4CEEB;
	Fri, 30 May 2025 12:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608865;
	bh=Xj1OjedXfVQ0PmAdnb3etoieZC3+OPgn7A8dAMBbGuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QsIpUQxEA2bNvxfXkj/W0Tif9Dl4rQmQZ6z2D7ZfNmMuhOBou3BA/aWnafIALYWvC
	 +jxcjgL5W89W4oamPWP+t9RkvXynYoyPk+b5x+eOIm0Ex1sOC5sOm/nfLyjC8z4uCA
	 7F3/KzeY46oYU8i3u12BV0C1yPJrLm6K6PspqVpwdMOoDMt1lmLT8aUSa1YAV9w9y7
	 Es1kYndVFCYq9rDmVDjWWrzrRK3nzoGmRCFJjx89lWhUyro3je77+4B5ZsF+THJIPE
	 Xs4tWvkVakvf4ix5R89fv3f+MDx4gawAy7CQgkp/7LN5KIiSoke2k4GYiKYdH3MeT5
	 rfIExfib+pTMA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jerry Lv <Jerry.Lv@axis.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	sre@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 13/18] power: supply: bq27xxx: Retrieve again when busy
Date: Fri, 30 May 2025 08:40:42 -0400
Message-Id: <20250530124047.2575954-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530124047.2575954-1-sashal@kernel.org>
References: <20250530124047.2575954-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.92
Content-Transfer-Encoding: 8bit

From: Jerry Lv <Jerry.Lv@axis.com>

[ Upstream commit f16d9fb6cf03fdbdefa41a8b32ba1e57afb7ae3d ]

Multiple applications may access the battery gauge at the same time, so
the gauge may be busy and EBUSY will be returned. The driver will set a
flag to record the EBUSY state, and this flag will be kept until the next
periodic update. When this flag is set, bq27xxx_battery_get_property()
will just return ENODEV until the flag is updated.

Even if the gauge was busy during the last accessing attempt, returning
ENODEV is not ideal, and can cause confusion in the applications layer.

Instead, retry accessing the I2C to update the flag is as expected, for
the gauge typically recovers from busy state within a few milliseconds.
If still failed to access the gauge, the real error code would be returned
instead of ENODEV (as suggested by Pali Rohár).

Reviewed-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Jerry Lv <Jerry.Lv@axis.com>
Link: https://lore.kernel.org/r/20250415-foo-fix-v2-1-5b45a395e4cc@axis.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. ##
Detailed Analysis: ### 1. **User-Visible Bug Fix** ✅ The commit fixes a
clear user-visible issue where multiple applications accessing the
battery gauge simultaneously receive confusing `-ENODEV` errors instead
of actual battery data or proper error codes. This directly impacts
battery monitoring applications and system power management tools. ###
2. **Code Changes Analysis** **bq27xxx_battery.c change:** ```c -return
-ENODEV; +return di->cache.flags; ``` This single-line change stops
masking real error codes with generic `-ENODEV`, allowing applications
to see the actual error (like `-EBUSY`) and handle it appropriately.
**bq27xxx_battery_i2c.c changes:** - Adds retry logic with up to 3
attempts when encountering `-EBUSY` - Uses standard `usleep_range(10000,
11000)` for 10ms delays - Implements proper loop structure with explicit
break conditions ### 3. **Small and Contained** ✅ The changes are
minimal and focused: - No architectural modifications - No changes to
driver interfaces or APIs - Limited to error handling improvement within
the same subsystem ### 4. **Low Regression Risk** ✅ - Uses established
kernel patterns (`usleep_range`, retry counters) - No timing changes to
critical paths - Battery gauges typically recover from busy state within
milliseconds - Maintains backward compatibility ### 5. **Historical
Precedent** ✅ Analysis of similar bq27xxx commits shows consistent
backporting: - "Fix race condition" (Similar Commit #4): **YES** -
Similar I2C access improvement - "After charger plug in/out wait 0.5s"
(Similar Commit #5): **YES** - Similar stability fix - "make status more
robust" (Similar Commit #2): **YES** - Similar robustness improvement
### 6. **Follows Kernel Conventions** ✅ - Standard I2C retry mechanisms
are common in the kernel - Proper error code propagation instead of
masking - Code reviewed by subsystem maintainer (Pali Rohár) - Uses
kernel-standard delay functions ### 7. **System Impact** **Improves
stability** by: - Preventing userspace confusion from misleading error
codes - Gracefully handling concurrent access scenarios - Better error
reporting for debugging - No negative side effects identified ### 8.
**Risk Assessment** **Very Low Risk:** - No memory management changes -
No locking mechanism modifications - Standard retry pattern with bounded
attempts - Preserves all existing functionality This commit represents
an ideal stable backport candidate: it fixes a real user-visible bug
with minimal, well-understood code changes that follow established
kernel patterns and have strong historical precedent for backporting in
this driver subsystem.

 drivers/power/supply/bq27xxx_battery.c     |  2 +-
 drivers/power/supply/bq27xxx_battery_i2c.c | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 23c8736567574..e51fa2c694bc6 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2044,7 +2044,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	mutex_unlock(&di->lock);
 
 	if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
-		return -ENODEV;
+		return di->cache.flags;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 886e0a8e2abd1..8877fa333cd02 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -6,6 +6,7 @@
  *	Andrew F. Davis <afd@ti.com>
  */
 
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -32,6 +33,7 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
 	struct i2c_msg msg[2];
 	u8 data[2];
 	int ret;
+	int retry = 0;
 
 	if (!client->adapter)
 		return -ENODEV;
@@ -48,7 +50,16 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
 	else
 		msg[1].len = 2;
 
-	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+	do {
+		ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+		if (ret == -EBUSY && ++retry < 3) {
+			/* sleep 10 milliseconds when busy */
+			usleep_range(10000, 11000);
+			continue;
+		}
+		break;
+	} while (1);
+
 	if (ret < 0)
 		return ret;
 
-- 
2.39.5


