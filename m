Return-Path: <linux-pm+bounces-34647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA541B57370
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 10:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18BA67A1FB6
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 08:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE7C2F1FD9;
	Mon, 15 Sep 2025 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLmxamwW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837F52F0C48;
	Mon, 15 Sep 2025 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926214; cv=none; b=ToS5W0+Qg+tb/AhahbPzi92V/fA15ax/mCqsWHVCoQ4Sy6C1+CqAoM6T2Qlm9H1lVHJqsJx8tG+tIWr/bGoGt3uB9/BzG/hovKKGXTglDDROc071DUCe4sPBVXoMuONHZwBzv5hI2g22OHgCttPS/xmOg9dGsn196C+/2hnqfww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926214; c=relaxed/simple;
	bh=UyVkt9kgZ1dAVjpRzQO7orB5FMJYrIW9UO+mYwY2znA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nFHTcqpQ8g5EvwUPUKMRsS2szPIqIV6dww8HSumEhI8jQfNINNLVmAL8bcOtAp78eSmccdurt8P/JAXXlUM/wKA4Qz1N8LTqQLopSXDRf0CKgJOK182fUUPmNmz1aGT1DRvq5X1CvJaZi/zr/W1475GgGQICxsTBll1jKTE+YjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLmxamwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15A85C4CEFD;
	Mon, 15 Sep 2025 08:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926214;
	bh=UyVkt9kgZ1dAVjpRzQO7orB5FMJYrIW9UO+mYwY2znA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PLmxamwWn/hDhDjiZVrgW+KiB19atIbeggA8rIvHaxwaCJdpcGCBSRoC9SEqa9vtf
	 Qym6iK1QLFfPlfqJ9kBrLC9BcEABl1zc6mi62pUfeqwRfEloEZHDVzg+XAjx3HR5dn
	 y1fLF3S91CA8MMbbqPV5oPlUybsaebhMlranXuuA99z+eaVB/1HRMv2rRiHx65f3YK
	 aK/mOwCSDzfKMxCc52hbht8/lVSZB+jDKA80fgEstkdEqchr3DFFIoE8DxTHQrJuCx
	 wTMqeFzIFL3O6z6XQLvbSnL4W1trGmrniROD5IOFpOPiddeuQmlSIk+WhKJ+OvLRkP
	 w4oHnEwM0v1LA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E4ECAC599;
	Mon, 15 Sep 2025 08:50:14 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Mon, 15 Sep 2025 16:49:54 +0800
Subject: [PATCH v4 2/8] power: supply: core: Add state_of_health power
 supply property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-qcom_battmgr_update-v4-2-6f6464a41afe@oss.qualcomm.com>
References: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
In-Reply-To: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
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
 linux-usb@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757926212; l=2731;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=yg7P5kRYu2rRp9PC3aRwe0HnoeoxRVLkEnVF92HMtnY=;
 b=Kn2a5HBOPLrP4lN/WQeRIeH+VK6UHKv9R0pKGMPuGos1SlnOzzkmCZcJ2C7PQqjZYbwGosVok
 MG6cD7/mIsxA5OiX4pCjZU+Ht1qWNISSu5DMXuOwMbM/Eu/XBxSSUvt
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Add state_of_health power supply property to represent battery
health percentage.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 Documentation/ABI/testing/sysfs-class-power | 15 +++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 17 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index cea1a38f5a8fb754d4e6323967ef6cf2e20a68ce..04f82e3e33aad6e16dc4fbace066b5d26069bf44 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -568,6 +568,21 @@ Description:
 
 		Valid values: Represented in microohms
 
+What:		/sys/class/power_supply/<supply_name>/state_of_health
+Date:		August 2025
+Contact:	linux-arm-msm@vger.kernel.org
+Description:
+		The state_of_health parameter quantifies the overall condition
+		of a battery as a percentage, reflecting its ability to deliver
+		rated performance relative to its original specifications. It is
+		dynamically computed using a combination of learned capacity
+		and impedance-based degradation indicators, both of which evolve
+		over the battery's lifecycle.
+
+		Access: Read
+
+		Valid values: 0 - 100 (percent)
+
 **USB Properties**
 
 What:		/sys/class/power_supply/<supply_name>/input_current_limit
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index cfa8f90a88ebc8fc1c7447198f138e5d2e699e5a..d96a8578308e3af60cc1a352845662aa922c29b3 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -221,6 +221,7 @@ static struct power_supply_attr power_supply_attrs[] __ro_after_init = {
 	POWER_SUPPLY_ATTR(MANUFACTURE_MONTH),
 	POWER_SUPPLY_ATTR(MANUFACTURE_DAY),
 	POWER_SUPPLY_ATTR(INTERNAL_RESISTANCE),
+	POWER_SUPPLY_ATTR(STATE_OF_HEALTH),
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_ATTR(MODEL_NAME),
 	POWER_SUPPLY_ATTR(MANUFACTURER),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 8bc3b7a67eb5693a16db9b7d123e7881711c6bf4..ccb43fe44381965069dc3bd9505d45050b9b1bd8 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -175,6 +175,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
 	POWER_SUPPLY_PROP_MANUFACTURE_DAY,
 	POWER_SUPPLY_PROP_INTERNAL_RESISTANCE,
+	POWER_SUPPLY_PROP_STATE_OF_HEALTH,
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,

-- 
2.34.1



