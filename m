Return-Path: <linux-pm+bounces-35015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E75B87C93
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 05:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4416C5811EC
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 03:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF2D26AA98;
	Fri, 19 Sep 2025 03:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILDIsli4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D6526529A;
	Fri, 19 Sep 2025 03:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758251940; cv=none; b=Kq/YCjC8tOsMcjGz46g1I7xPnAhiyhDBnkhAKft83LCJmprnua487CnrhRz/42dsxNP4jroX3fT/+IXw5/wtFqc6u+aVra08Oxb+bZVsGrW4iuq2Zg6uNAyCiIrPKdsWu7Zd6wvsTlfAZYekfF/NT/HJQRjwLz61fWuD6FAIaB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758251940; c=relaxed/simple;
	bh=ggPk5dpFrY5d2ktYSzXrZSvVa0LXccEQketSd+fFRQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IeIxCYg5jj0gbzqcozyAnrIClo5+1JM9DCEMb8RnJmOnv56saNAb7dg01UfdbROLKsLYUrQmPmzes/skeB4d8fN3/3YvA9XYK6+PYBJK1KdiosHrL6u9dMsgjacOZE3EAc5GMGrrppFK3J9S3WrWB8rjNyb6EYMOMlzbKL37OHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILDIsli4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3418C4CEEB;
	Fri, 19 Sep 2025 03:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758251940;
	bh=ggPk5dpFrY5d2ktYSzXrZSvVa0LXccEQketSd+fFRQo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ILDIsli4+KUscphy54iXEx04Nis5Q+lxBqWeu2hdMUXHej/8A0GN3QLyAke8fWvlb
	 go6kMXMqsfGg0AvsdwHswXcDmuduGdWmOyjlUKcpPMK6qqv8MdH2SScrt50sNw3s0W
	 /oo69yD8SwRb3usaorm+ur+zDKhvEX+2VitztkxT7BjHAYTUdArvP/Wwwlm/Tf0pwn
	 hYW4GpRN5SDakfnBSXyVU5xJEUiAbm1YezaWaR3XMIH31H84A4eFZPSwueLC8VDKDk
	 MlNGWMxjjvo6krgEfs4Mp4KRfWVU6BGdzxdSTNQr/VfqyMLRVgvGEzaVpA0JrXVAQ7
	 8JmYFMCpgxa7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEE5CAC5A8;
	Fri, 19 Sep 2025 03:18:59 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Fri, 19 Sep 2025 11:18:51 +0800
Subject: [PATCH v6 2/2] power: supply: qcom_battmgr: handle charging state
 change notifications
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-qcom_battmgr_update_new-v6-2-ed5c38867614@oss.qualcomm.com>
References: <20250919-qcom_battmgr_update_new-v6-0-ed5c38867614@oss.qualcomm.com>
In-Reply-To: <20250919-qcom_battmgr_update_new-v6-0-ed5c38867614@oss.qualcomm.com>
To: kernel@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Fenglin Wu <fenglin.wu@oss.qualcomm.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758251938; l=2311;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=qjtOHMPRwa1lClP72psxdJHsxXcpoXRVZvAtkWmKRnw=;
 b=uSCs45ufv9KjscLuuIBQVIsz9B6oD0bnb8skr2MyeHUxpvyB+mjw6PZYJ+JJWPdSprJZdl09D
 L04pPpex0mCCrwVOWPbHq3B/2uNiPafD2rlsa9m2V1LjFpVdasPGKdn
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
---
 drivers/power/supply/qcom_battmgr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 0fe14a109b70fcc15575730573a7a16d1d843613..3c2837ef3461730369b52a4edb096795a531926a 100644
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
 
@@ -1209,12 +1210,14 @@ static void qcom_battmgr_notification(struct qcom_battmgr *battmgr,
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



