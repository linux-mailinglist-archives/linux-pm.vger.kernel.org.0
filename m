Return-Path: <linux-pm+bounces-22025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D13A34B52
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 18:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D5D3B9667
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 16:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F7528A2B5;
	Thu, 13 Feb 2025 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qX6ZSR6R"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A83128A2B0;
	Thu, 13 Feb 2025 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465518; cv=none; b=Pxn3wKFghMqWwaMwjQvCpPQWyb3FaZY+GsvJswEOX3tICwwMEz9fZ/jdubNSvCtaAB7PHKJDQy8YvsxYsJV/QezRSxCvtDpDQtRCsTExtcZGaKSnPP5jsnhZNQcgP/k0FhglsfSo3bb3Q1mF17w5WifETxj4QVqAhYotGqY1ZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465518; c=relaxed/simple;
	bh=odlb6+92LTfYeJcLKPY87bv0xB6K2iBjaAxL4Nwu4rY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bY+6D8XBZ19SlwDqtVUnTiVb+eW8W+RVofGhTo8lsdK7IxHmxIOEOzvTbjGoqCrjSBxSM6OIvlY/5lclu+Zh5QfpUcgPB4pPohvUsNS6JAN8WQXN66py+41tCgd/EwmVf4bA94tWWh81wGWxE7lwhKIUSHLC1EzqXx0+YnL/sWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qX6ZSR6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9804BC4CED1;
	Thu, 13 Feb 2025 16:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739465517;
	bh=odlb6+92LTfYeJcLKPY87bv0xB6K2iBjaAxL4Nwu4rY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=qX6ZSR6Rr9O72Ad1jBqyNdHPNGsqTTbuIDJJ4ycXhR3iHQsEzfg5+RBLX305I+SQ9
	 UtV0WEB5oksCSVYcck6RcEtVJ02TTN7aKPudS1KnlUTugIqfOZCdnKR4EQhPRePa4Y
	 2SV27aFq6KQRUpdiSYOA+cyipwTc99uMGsd3+GYO6hH/fl8czaP5iuUvyqa1TDuCk2
	 l4NpaQa2+0DZFH1GwvCtN4JonmbWaluMbglx3NI3nDn8Zbv36MtP3fcbBIp/0bM4iQ
	 EcNdtLAffmaDJK1AgWzyWKH1Idqvzx8PkgfVXYQFnDxGqHeYU8NIsHPPhLNW2U/17O
	 v2RYYpHG5ODBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82107C021A0;
	Thu, 13 Feb 2025 16:51:57 +0000 (UTC)
From: Anthony Ruhier via B4 Relay <devnull+aruhier.mailbox.org@kernel.org>
Date: Thu, 13 Feb 2025 17:51:38 +0100
Subject: [PATCH RESEND] power: supply: qcom_battmgr: abs() on POWER_NOW
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-patch-qcomm-bat-uint-power-v1-1-16e7e2a77a02@mailbox.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Anthony Ruhier <aruhier@mailbox.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2103;
 i=aruhier@mailbox.org; h=from:subject:message-id;
 bh=lSOxkdOf6gRdpUszCsRF5pZ7uZYHKUdsGgP+kJrQraU=;
 b=owGbwMvMwCVW2Nrw47jsO3/G02pJDOnrlLUlpUtWJmwo37z5H7fgTxWLRTtP/zPi65D4fydhx
 9Te0vlmHaUsDGJcDLJiiiwl+6OEb6t03HdYu5wFZg4rE8gQBi5OAZhIzgqGfwq3Mw1zP1pMVFH7
 X3J796T3nvfVzJimaOUbqQVOsknYzMLIsPPMo7TopmVuYQ0bZtTt2a3VZcVRcyjm86W1T3z1JTW
 ZWAA=
X-Developer-Key: i=aruhier@mailbox.org; a=openpgp;
 fpr=F4A378DD8D494AE48EBA554CB00FBC7D08D231D9
X-Endpoint-Received: by B4 Relay for aruhier@mailbox.org/default with
 auth_id=302
X-Original-From: Anthony Ruhier <aruhier@mailbox.org>
Reply-To: aruhier@mailbox.org

From: Anthony Ruhier <aruhier@mailbox.org>

The value for the POWER_NOW property is by default negative when the
battery is discharging, positive when charging.

However on x1e laptops it breaks several userland tools that give a
prediction of the battery run time (such as the acpi command, powertop
or the waybar battery module), as these tools do not expect a negative
value for /sys/class/power_supply/qcom-battmgr-bat/power_now. They
estimate the battery run time by dividing the value of energy_full by
power_now. The battery percentage is calculated by dividing energy_full
by energy_now, therefore it is not impacted.

While having a negative number during discharge makes sense, it is not
standard with how other battery drivers expose it. Instead, it seems
standard to have a positive value for power_now, and rely on the status
file instead to know if the battery is charging or discharging. It is
what other x86 laptops do.

Without the patch:
    $ acpi
    Battery 0: Discharging, 98%, discharging at zero rate - will never fully discharge.

With the patch:
    $ acpi
    Battery 0: Discharging, 97%, 10:18:27 remaining

---
Signed-off-by: Anthony Ruhier <aruhier@mailbox.org>
---
 drivers/power/supply/qcom_battmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 47d29271ddf400b76dd5b0a1b8d1ba86c017afc0..3e2e0c5af2814df0eb0bfc408d4b3d26399ab4e4 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -530,7 +530,7 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
 		val->intval = battmgr->status.current_now;
 		break;
 	case POWER_SUPPLY_PROP_POWER_NOW:
-		val->intval = battmgr->status.power_now;
+		val->intval = abs(battmgr->status.power_now);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 		if (unit != QCOM_BATTMGR_UNIT_mAh)

---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250128-patch-qcomm-bat-uint-power-5793f3638c56

Best regards,
-- 
Anthony Ruhier <aruhier@mailbox.org>



