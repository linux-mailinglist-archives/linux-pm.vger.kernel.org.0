Return-Path: <linux-pm+bounces-34841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51356B7E518
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C019522629
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 10:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0C635A2A3;
	Wed, 17 Sep 2025 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIGFoxor"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F1234AAEA;
	Wed, 17 Sep 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104131; cv=none; b=hjd0fk04N9vkmU0nnX5WKwT6wXkrdlMYVV2ZEGj0aSxSo4EAF5ApCpk10GRRM4kas3motZw5BXB0mApuLqXe1k+Mgk+zh5z0cNjL4KATh0wjAtcRU0TH6ksTebUM4EsL8B7qa+ix5xaeUeTe4inPz2g1Sy0Z7Tb3SR+a/D1nC7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104131; c=relaxed/simple;
	bh=jFN0rM4WOdVF6LWQb08Md1pxuOJ6ixjcBhDhHV+V3Xw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GX5oezxrXZdTYiw6/rm8xm0dYTC0YzxqrflJpQmphFXw4DG6wu6iXOb0DGyUexaskUQvvW3FjVeObq6kkj7p0cF2Vy8k+3PtOZ0h2NVJn/ZxE7wtSXqZRjL272pL5cOGhr1/DKzsQDpLSMUNXd6hHW5cvXVIZPd2s+FCV/pTNyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIGFoxor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A475EC113CF;
	Wed, 17 Sep 2025 10:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104130;
	bh=jFN0rM4WOdVF6LWQb08Md1pxuOJ6ixjcBhDhHV+V3Xw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EIGFoxorRKqKKFJaurlSQO4Hwurdm3HLsk1NZItkPjwLRfydEXGE3LZQd9KTb8CSe
	 ofwyQDkBXVgwzuBEhQc843kOgHWtF1F95L7pUtnmuqViwCTyQY1ZQYBsiigBRXW69L
	 Ef4X1nqKtQ1p1zhkmKr+Ez23MJLrQuxXtNMXvpcSj2vLPatUxedR8Lf6RACR6mRcef
	 WT7vTUCt5V6eIGqZDcrXfJKV2WzYCXz+dHvBfDasYpMNnwB1FrtG7YE/WO6fmxViJk
	 10DNcObfLObN1TNO2+CvtXBrpqhJAcblBptzQKAjjKKc06QEH8mB4inGgnBIZDaJ4g
	 43LPTkM2NL1iQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A423CAC59F;
	Wed, 17 Sep 2025 10:15:30 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Wed, 17 Sep 2025 18:15:22 +0800
Subject: [PATCH v5 9/9] power: supply: qcom_battmgr: handle charging state
 change notifications
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-qcom_battmgr_update-v5-9-270ade9ffe13@oss.qualcomm.com>
References: <20250917-qcom_battmgr_update-v5-0-270ade9ffe13@oss.qualcomm.com>
In-Reply-To: <20250917-qcom_battmgr_update-v5-0-270ade9ffe13@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, 
 =?utf-8?q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 kernel@oss.qualcomm.com, devicetree@vger.kernel.org, 
 linux-usb@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758104128; l=2037;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=u/UsvrdOaH8FPPbaWz45xYUdDcRqs2rzsPnEOVbRCYQ=;
 b=fajsAkYwMy2+oxB6R/muS3GvMix4qIVRZwPtunicG8Ju8jmojarqCRdEnoWvFtAkses3lSYhR
 NMBwF3eGbozDIjQDpJmCsaKSmxJxlrkqkISyZsTJ/XOLE4FpRiTrRDL
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

The X1E80100 battery management firmware sends a notification with
code 0x83 when the battery charging state changes, such as switching
between fast charge, taper charge, end of charge, or any other error
charging states. The same notification code is used with bit[16] set
if charging stops due to reaching the charge control end threshold.
Additionally, a 2-bit value is added in bit[18:17] with the same code
and used to indicate the charging source capability: a value of 2
represents a strong charger, 1 is a weak charger, and 0 is no charging
source. The 3-MSB [18:16] in the notification code is not much useful
for now, hence just ignore them and trigger a power supply change event
whenever 0x83 notification code is received. This helps to eliminate the
unknown notification error messages.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/power/supply/qcom_battmgr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 151cd5618ca5c70f941245e4df5a18d4778f1349..4056290b5d737f762d9adb2783d26bb50ec5a664 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -34,8 +34,9 @@ enum qcom_battmgr_variant {
 #define NOTIF_BAT_PROPERTY		0x30
 #define NOTIF_USB_PROPERTY		0x32
 #define NOTIF_WLS_PROPERTY		0x34
-#define NOTIF_BAT_INFO			0x81
 #define NOTIF_BAT_STATUS		0x80
+#define NOTIF_BAT_INFO			0x81
+#define NOTIF_BAT_CHARGING_STATE	0x83
 
 #define BATTMGR_BAT_INFO		0x9
 
@@ -1206,12 +1207,14 @@ static void qcom_battmgr_notification(struct qcom_battmgr *battmgr,
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
2.34.1



