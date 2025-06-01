Return-Path: <linux-pm+bounces-27913-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EC6ACA391
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 01:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A25B1893004
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jun 2025 23:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D5D283FF0;
	Sun,  1 Jun 2025 23:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwPY1mZt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2709C283FE5;
	Sun,  1 Jun 2025 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820563; cv=none; b=B8RaQir20oFXStfiU7PGa6rrNS4pkWtxBF1/AkmBRmNVcHoDCOgWozcvPiVobvzyuJjp1rtrrYDPBUaRCnpEYsMn7lBkqE7QzDQ6EVtoJvosFPFlIe2sOZQimjV/3YylYu7RXQkX+r2tZVyHjf6iUo0SqPkmmfNiM2LwA5+q69U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820563; c=relaxed/simple;
	bh=VdGC+C9KEnEXynfJFVCNZfdOiXWNxRiwUcSLNgzoOhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncQqpB1NfIlLSx6T4enRPrMd7vdpIDCCDmLcsp3abxbTmNH3JkxkPTaVZ4BMveIXa1NuFiTCu779macTBNVILFE6XZq5HYtfADN67zfgyLoZ2o0Kg+cgux2foJcdNXjQVzZ8X0mrS5gf2c9VVkMPc8Et6lDkHN7yU+IxZOwQWTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwPY1mZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AAAC4CEEE;
	Sun,  1 Jun 2025 23:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820562;
	bh=VdGC+C9KEnEXynfJFVCNZfdOiXWNxRiwUcSLNgzoOhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwPY1mZtmw0alOBFz6Y+KqrHyZ/VqhWxpyFyM6CLKcKV0apRGctY4+jBp0+JqIygZ
	 gQ0ID93YP3Ro8L59+HnrH38jvu02ekkV47guMo0iO1Hyo+9z1QmfCMH4BYXOowRL9X
	 sUVHdopBImeI/I/lqwZYZxgsXAOvoCWTBPEIymWaLKTJfJe0UFkxqhfTOZurj6YZar
	 PmrL7UX9wDPUkaOQ6R0f+yPqX70Y+r9c5WQq7aqj/9t0M5g9lruVpgL1f2oFBK2aeg
	 6r8w6q/vTPDE2wYfDnaVyqTWG/gguZKvFP0/BYOR0T5NXYP47nakm68S2dxWfgM1tv
	 1FMn4iD/WwRDw==
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
Subject: [PATCH AUTOSEL 6.15 104/110] power: supply: bq27xxx: Retrieve again when busy
Date: Sun,  1 Jun 2025 19:24:26 -0400
Message-Id: <20250601232435.3507697-104-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232435.3507697-1-sashal@kernel.org>
References: <20250601232435.3507697-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
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

Based on my thorough analysis of the commit and examination of the
kernel source code, here is my assessment: **YES** This commit should be
backported to stable kernel trees for the following extensive reasons:
## Primary Analysis ### 1. **Significant User-Facing Bug Fix** The
commit fixes a substantial functional issue where the bq27xxx battery
driver incorrectly returns `-ENODEV` (device not found) when the battery
gauge is merely temporarily busy with `-EBUSY`. This causes: -
**Application Confusion**: Battery monitoring applications and power
management daemons interpret `-ENODEV` as "battery removed/missing"
rather than "device temporarily busy" - **Persistent Wrong State**: The
incorrect ENODEV state persists until the next periodic update
(potentially 5+ seconds), during which all battery properties appear
unavailable - **User Experience Impact**: Users may see incorrect "no
battery detected" warnings or lose power management functionality ### 2.
**Technical Correctness Improvement** The changes fix semantically
incorrect error handling: **In bq27xxx_battery.c (line 2066):** -
**Before**: `return -ENODEV;` when `di->cache.flags < 0` - **After**:
`return di->cache.flags;` (returns actual error code like `-EBUSY`,
`-EIO`) This change ensures applications receive the correct error code
and can make informed decisions about retry logic or user notifications.
**In bq27xxx_battery_i2c.c:** - Adds bounded retry mechanism (max 3
attempts) for `-EBUSY` conditions - Uses appropriate 10ms delay between
retries - Falls back to returning the actual error if retries fail ###
3. **Low Risk Assessment** The changes are well-contained and follow
established kernel patterns: - **Bounded Retries**: Maximum 3 retries
with 10ms delays prevent infinite loops - **Existing Patterns**: Similar
retry mechanisms exist in other I2C drivers throughout the kernel -
**Fallback Safety**: If retries fail, the real error code is properly
propagated - **No ABI Changes**: The power supply interface remains the
same; only error semantics improve ### 4. **Alignment with Stable Tree
Criteria** This commit meets all stable tree requirements: - **Important
Bug Fix**: Resolves user-impacting functional issue - **Small and
Contained**: Changes are minimal and localized to one driver - **No
Architectural Changes**: Uses existing error handling patterns - **Clear
Side Effects**: Improved error reporting with bounded retry behavior -
**Subsystem Confined**: Limited to power supply bq27xxx driver ### 5.
**Comparison with Historical Precedents** Looking at the provided
similar commits, this change aligns with accepted backport patterns: -
Similar to "Fix bq27xxx_battery_update() race condition" (Status: YES) -
fixes driver robustness - Similar to "make status more robust" (Status:
YES) - improves reliability - Unlike "fix reporting critical level"
(Status: NO) which was a flag precedence fix ### 6. **Real-World
Impact** This fix addresses a common scenario in embedded systems and
laptops where: - Multiple applications access battery information
simultaneously - I2C bus contention can cause temporary EBUSY conditions
- Battery monitoring is critical for power management decisions - Users
expect consistent battery status reporting ## Conclusion This commit
represents exactly the type of important bug fix that stable trees are
designed to include: it resolves a significant user-facing issue with
minimal risk, follows established patterns, and improves the robustness
of a critical hardware interface. The semantic correction from ENODEV to
proper error codes, combined with sensible retry logic, makes this a
clear candidate for backporting.

 drivers/power/supply/bq27xxx_battery.c     |  2 +-
 drivers/power/supply/bq27xxx_battery_i2c.c | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 2f31d750a4c1e..93dcebbe11417 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2131,7 +2131,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	mutex_unlock(&di->lock);
 
 	if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
-		return -ENODEV;
+		return di->cache.flags;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index ba0d22d904295..868e95f0887e1 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -6,6 +6,7 @@
  *	Andrew F. Davis <afd@ti.com>
  */
 
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -31,6 +32,7 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
 	struct i2c_msg msg[2];
 	u8 data[2];
 	int ret;
+	int retry = 0;
 
 	if (!client->adapter)
 		return -ENODEV;
@@ -47,7 +49,16 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
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


