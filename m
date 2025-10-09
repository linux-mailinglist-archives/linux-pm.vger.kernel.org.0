Return-Path: <linux-pm+bounces-35859-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A3DBC9FB4
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 18:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FFB84FD1AA
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 16:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5022E2F99AD;
	Thu,  9 Oct 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEhZuFFE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DCF2264AD;
	Thu,  9 Oct 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025533; cv=none; b=MhMolcotAZg94x+ItZ2yEDlfNG/ZPRW5ZuZ7EuHkUXcCFS0Gqq9SxPLuIs0G0HSooXrzw3tmuCQWkNf5aX4UktYPmVkHBMwxNTWfAPO88/jh6St9+DL6HXVQmREeCRz7h7JL13eoCbK4yLe0WeH4XxT662E5TOBeM2DwXVlvq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025533; c=relaxed/simple;
	bh=BBv3zfKH3TzdKDHUiZ1Ut8tcytgcXAoCLB3EFatxfr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ieGJP2GbQwWfboUo0ofOc/UCXRlBpe6F2RrYOaoTdUnKCB2I+x4eusal0359A9pMTijKTnsMfIbu/LgaDUUXmu3nhugVh5Sw77NsLd1CV1IDAU36wbi9I5e3oDWim5bidxaCVcmfDtC3NTOawgaJ46UQISLkk2hxPihlN6qZUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEhZuFFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4B0C4CEF8;
	Thu,  9 Oct 2025 15:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025533;
	bh=BBv3zfKH3TzdKDHUiZ1Ut8tcytgcXAoCLB3EFatxfr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SEhZuFFEOQ24fDPrsMX8YRw/QXs/yo9dJ17QTUejj7D3HmGWXZ8J5e8dBRTS6HNHN
	 eVd3/2llaWGaNb2TZEItK+WasojKQv5roWaQcViJ+MDzI9wskjH3w/q7naFVZibVV6
	 9ipLhn14WhvJc7yPBM0rXIdvrdTpOuqPfOLvnIw9J6N6jZqzUGP2euYocQTdYNkfvH
	 eZIqFPIcP+W0YvvYLn1gn3u1v0PYAzC88k2dlqVpZ3WC2domGZoPH6XToEoays8j5m
	 SrJb0vRjxuNYhEnTejETOqr1MaVHFKQ0wYA7qVwk5bFum/Vc8FSgMtcfmpSXvEahlc
	 GyerX6a+yHjZA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	sre@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.6] power: supply: qcom_battmgr: handle charging state change notifications
Date: Thu,  9 Oct 2025 11:54:59 -0400
Message-ID: <20251009155752.773732-33-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

[ Upstream commit 41307ec7df057239aae3d0f089cc35a0d735cdf8 ]

The X1E80100 battery management firmware sends a notification with
code 0x83 when the battery charging state changes, such as switching
between fast charge, taper charge, end of charge, or any other error
charging states.

The same notification code is used with bit[8] set when charging stops
because the charge control end threshold is reached. Additionally,
a 2-bit value is included in bit[10:9] with the same code to indicate
the charging source capability, which is determined by the calculated
power from voltage and current readings from PDOs: 2 means a strong
charger over 60W, 1 indicates a weak charger, and 0 means there is no
charging source.

These 3-MSB [10:8] in the notification code is not much useful for now,
hence just ignore them and trigger a power supply change event whenever
0x83 notification code is received. This helps to eliminate the unknown
notification error messages.

Reported-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Closes: https://lore.kernel.org/all/r65idyc4of5obo6untebw4iqfj2zteiggnnzabrqtlcinvtddx@xc4aig5abesu/
Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What it fixes
  - Unhandled firmware notifications: On X1E80100 the PMIC GLINK
    firmware emits notification code 0x83 for charging state changes
    (fast/taper/EOC/error). Today, the driver does not recognize 0x83
    and logs “unknown notification” without notifying userspace. See
    default case logging in the current tree:
    `drivers/power/supply/qcom_battmgr.c:965`.
  - Bit-extended notifications misparsed: Firmware also sets the 3 MSBs
    [10:8] on this code for EOC (bit 8) and charging source capability
    (bits [10:9]), which causes values like 0x183/0x283 to miss all
    known cases and be treated as unknown. The change masks these bits
    before the switch.

- Code changes and why they are correct
  - New code constant: Adds `#define NOTIF_BAT_CHARGING_STATE 0x83` so
    charging-state change notifications are recognized as first-class
    events (`drivers/power/supply/qcom_battmgr.c:39` in upstream).
  - Mask unusable MSBs: In `qcom_battmgr_notification()`, masks the
    notification to the low 8 bits: `notification &= 0xff;` so
    0x183/0x283 collapse to 0x83 and match the new case
    (`drivers/power/supply/qcom_battmgr.c:1212` in upstream). This
    matches the commit message rationale that bits [10:8] carry
    auxiliary info not used by the driver today.
  - Trigger userspace update: Adds a switch case for
    `NOTIF_BAT_CHARGING_STATE` to call
    `power_supply_changed(battmgr->bat_psy)`, same as other battery-
    related notifications (`drivers/power/supply/qcom_battmgr.c:1218`).
    This ensures userspace observes charging state transitions.
  - Eliminates spurious errors: With masking + case, the default branch
    which logs “unknown notification: %#x” (seen in current code at
    `drivers/power/supply/qcom_battmgr.c:965`) is no longer hit for 0x83
    variants, addressing the reported log spam.

- Scope and dependencies
  - Single-file, minimal delta: Only
    `drivers/power/supply/qcom_battmgr.c` is touched with 1 new define,
    1 mask line, and 1 new switch case arm. No ABI or architectural
    changes.
  - Self-contained: No new APIs, headers, or cross-driver dependencies.
    The driver already processes other notifications and calls
    `power_supply_changed()` in the same function, so behavior is
    consistent.
  - Platform relevance: The tree already contains X1E80100 support
    (e.g., compatible present in this driver), so affected systems exist
    in stable lines and will benefit immediately.

- Risk assessment
  - Low regression risk: Masking to 8 bits only affects notification
    decoding and only for codes using upper bits as flags. All existing
    known codes in this driver are within 1 byte; masking does not
    collide with other codes. If a different notification someday uses
    MSBs meaningfully, it will still be decoded to its base 8-bit code,
    which is how the driver already categorizes notifications.
  - Correct functional behavior: Treating charging state changes like
    other battery property/status notifications by calling
    `power_supply_changed()` is aligned with existing patterns and will
    simply refresh properties from firmware.
  - No behavioral change on platforms that do not emit 0x83 or do not
    set the MSBs; the new case just won’t be hit.

- User impact
  - Fixes stale charging state in user space that otherwise would not
    update on state transitions without some other event.
  - Removes persistent “unknown notification” error messages that
    confuse users and integrate logs.

- Stable backport criteria
  - Fixes a real user-visible bug (missing updates + log spam) on
    hardware supported by stable trees.
  - Change is small, contained, and non-invasive; no features or
    architecture changes.
  - Touches a driver in the power supply subsystem (not a core/critical
    kernel subsystem), further reducing risk.
  - Upstream rationale is clear; commit includes a report and a public
    discussion link (“Closes:” tag), consistent with a corrective change
    rather than a feature.

Conclusion: This is a textbook, low-risk bug fix that improves
correctness and logging. It should be backported to stable trees that
include `qcom_battmgr` and X1E80100/SC8280XP variants.

 drivers/power/supply/qcom_battmgr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index fdb2d1b883fc5..c9dc8b378aa1e 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -30,8 +30,9 @@ enum qcom_battmgr_variant {
 #define NOTIF_BAT_PROPERTY		0x30
 #define NOTIF_USB_PROPERTY		0x32
 #define NOTIF_WLS_PROPERTY		0x34
-#define NOTIF_BAT_INFO			0x81
 #define NOTIF_BAT_STATUS		0x80
+#define NOTIF_BAT_INFO			0x81
+#define NOTIF_BAT_CHARGING_STATE	0x83
 
 #define BATTMGR_BAT_INFO		0x9
 
@@ -947,12 +948,14 @@ static void qcom_battmgr_notification(struct qcom_battmgr *battmgr,
 	}
 
 	notification = le32_to_cpu(msg->notification);
+	notification &= 0xff;
 	switch (notification) {
 	case NOTIF_BAT_INFO:
 		battmgr->info.valid = false;
 		fallthrough;
 	case NOTIF_BAT_STATUS:
 	case NOTIF_BAT_PROPERTY:
+	case NOTIF_BAT_CHARGING_STATE:
 		power_supply_changed(battmgr->bat_psy);
 		break;
 	case NOTIF_USB_PROPERTY:
-- 
2.51.0


