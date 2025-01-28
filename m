Return-Path: <linux-pm+bounces-21001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1167EA2065C
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 09:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571583A8DB5
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 08:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0945A1DF27F;
	Tue, 28 Jan 2025 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGuRR//H"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBF31DF250;
	Tue, 28 Jan 2025 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053779; cv=none; b=fz7eN5sSOpJGN6gh7ht8i/p3ymBvAIfHIdHUeNiZomeL9HMnGjLLlGUnyAmk/kflK1NnGFXs9PHAIauz83H7ukR6cs13Z/5GT0YyJHtMUQFAelS4LC8r4LPTTOVKeERsR/A966VHOV9+rSBNM1X7l1oTvD3Tq3dLxELfdmu48g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053779; c=relaxed/simple;
	bh=odlb6+92LTfYeJcLKPY87bv0xB6K2iBjaAxL4Nwu4rY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EvuFmcTi+bXpH3Jh00y/4ZzUYgZ3yCnZGo+wK9+ioDTVCqkDqjCEzolhYRSYrQRT49Mbl4ig7Qp7L0bc9zci8xqEMkd59kWgphyd7VfIgLsBELz9FuHE8IlKzAYmQb0Yg96YafX7bqsd8+7cK+N+L8QRtpHeD/lILA8m3nyUJ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGuRR//H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E16EC4CED3;
	Tue, 28 Jan 2025 08:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738053779;
	bh=odlb6+92LTfYeJcLKPY87bv0xB6K2iBjaAxL4Nwu4rY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=IGuRR//HZGY/MQPUFtzyCd3Qc/cdimBlBPAJKPI4j1nI0AhFNMPVqII/5hYJDGpcQ
	 qwk5VtEx6lI9aGDNXpQ/+Kxq0+Y2SUNlqOnXBbebGd75P+Fi4c93KfySTbflTv26mC
	 DOjOppRNj4MLyHJdembXxl491A5PNipuey89oElTBe0lVIcBxdukM+Pwbmg55IvFlM
	 y2P0fNYsPHMY0lk/dSiEhlf9DDl8PxjM38770YcYD8IFZL93sufU269HOB6eIVBxN/
	 YDUIPRBscE2LqqLD/5u6i3e+z4InDEnncVeKAN9JqsIYZhsDJrYKdhmYArQMMoJeTo
	 EkXyiKVrcOl5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1B9C0218D;
	Tue, 28 Jan 2025 08:42:59 +0000 (UTC)
From: Anthony Ruhier via B4 Relay <devnull+aruhier.mailbox.org@kernel.org>
Date: Tue, 28 Jan 2025 09:42:56 +0100
Subject: [PATCH] power: supply: qcom_battmgr: abs() on POWER_NOW property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-patch-qcomm-bat-uint-power-v1-1-54a63d8ada92@mailbox.org>
X-B4-Tracking: v=1; b=H4sIAJCYmGcC/x3MQQ6DIBAAwK+YPXcThUC1X2l6QFzqHgQKVE2Mf
 5d4nMsckCkxZXg1ByRaOXPwFd2jATsb/yXkqRpEK1TbiR6jKXbGnw3LgqMp+GdfMIaNEqrnIJ3
 UsrdKQw1iIsf7nb8/53kBJDqtGWwAAAA=
X-Change-ID: 20250128-patch-qcomm-bat-uint-power-5793f3638c56
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Anthony Ruhier <aruhier@mailbox.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2103;
 i=aruhier@mailbox.org; h=from:subject:message-id;
 bh=lSOxkdOf6gRdpUszCsRF5pZ7uZYHKUdsGgP+kJrQraU=;
 b=owGbwMvMwCVW2Nrw47jsO3/G02pJDOkzZkziyNm+UOVmxY1KtjcWd2cap2/oK358t8bUme1Wd
 vHZis6vHaUsDGJcDLJiiiwl+6OEb6t03HdYu5wFZg4rE8gQBi5OAZhIiCPDfzfPczHv5gZtuKa1
 ZfrHysAy+S1t/B5R0dMYvqQoKCZ1XmBkePOcddadw00mrxO8m19N33rN9bLsYoayC5xL3TW+/DX
 LZQcA
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



