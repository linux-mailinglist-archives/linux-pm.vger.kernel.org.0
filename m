Return-Path: <linux-pm+bounces-27830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1266CAC88F8
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 09:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437783A76F8
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 07:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BC020E32F;
	Fri, 30 May 2025 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rt6ilV55"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9ED10FD;
	Fri, 30 May 2025 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748590540; cv=none; b=bzN33qY3sdWbr/qs9zc4/M4e9q5t3QACsi7PS5nayHFd23exNeOwTpOFlMwf0JGd/ZK98Ud9aM2gqAivOv5gaS72DbKx6ZZ7TjV230ulfrE7m8PQ4sk3TmGG6sdZ38wC3TKwB8CpmrkkdYgp6VrwziA56h2BQiXtOOGslInZd+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748590540; c=relaxed/simple;
	bh=HpRU3ck2iDgNbdzeI8oBQWZLheKpAIeZpo9xfMldP2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=az/5YMuPYgPYTPWdHa79BVP1PqGrgbPGLx0ybZmdGEaojopu+BhbOCuzk/Wj7HUFV7K9/XyIw+cOJQ1BxBSZ3XqtKdtGKjiY/jpShWJiUCPUvAJxfCHpE7cjbIVzIzLo8/0cm/0nXD6ZlSozqTlx0r/BIfEGbRBFqvfMj2ZwVlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rt6ilV55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E8E9C4CEF3;
	Fri, 30 May 2025 07:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748590540;
	bh=HpRU3ck2iDgNbdzeI8oBQWZLheKpAIeZpo9xfMldP2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rt6ilV55CVdzl+vZAHWoQmGghXXWQJXsyePqgDcsd1Aj9rJop3t0+hmGnk/ILNYgt
	 r7skrw969lxpjGar8p4KGNVQ+fyw1Y0ybQB8knkZ4V2+x9hTYxRm7uZrqbVf0GLp4C
	 fjVKb/bx7mRyvMem4mZQs9iaF0lH7+XLnXgXwygYpCMQvnLzLFYvB7YIq2rW9hTKzZ
	 rD9vwnhAvwQyamWQBID1TnG3T1fYtSM7EOnhaa11+MNT7jebaDJZygxejPZvmWgwRY
	 AbNoTOpaomZiGc/Utla7iqh0notb00cbL4YxThMtf+CBosPSwrfEOqTYP5SucHY4VY
	 CMVK7gJwK37lg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F5BC3ABB2;
	Fri, 30 May 2025 07:35:40 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Fri, 30 May 2025 15:35:08 +0800
Subject: [PATCH v2 3/8] power: supply: qcom_battmgr: Add resistance power
 supply property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-qcom_battmgr_update-v2-3-9e377193a656@oss.qualcomm.com>
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
In-Reply-To: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 kernel@oss.qualcomm.com, devicetree@vger.kernel.org, 
 linux-usb@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748590538; l=2437;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=0cVLEmmNpliBpNUD0QR9vZL+uf2t1nTBnEIcltQ8698=;
 b=m14YG3sHE+PlJwy7oQPcaZxsDuP262u4Wnd1rJoWhr8DbjVnW1Iki+ZXW05QWmQKpuOqCiwqk
 rphts1kUjp1BcEW5iZaZsHI0syCJ+NgHqVBHtGgfctYY9sr04+4F59f
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Add power supply property to get battery resistance from the battery
management firmware.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/power/supply/qcom_battmgr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index fe27676fbc7cd12292caa6fb3b5b46a18c426e6d..bc521f60f67fa427cc03b51c44adaeb46ae746f5 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
  * Copyright (c) 2022, Linaro Ltd
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/auxiliary_bus.h>
 #include <linux/module.h>
@@ -254,6 +255,7 @@ struct qcom_battmgr_status {
 	unsigned int voltage_now;
 	unsigned int voltage_ocv;
 	unsigned int temperature;
+	unsigned int resistance;
 
 	unsigned int discharge_time;
 	unsigned int charge_time;
@@ -418,6 +420,7 @@ static const u8 sm8350_bat_prop_map[] = {
 	[POWER_SUPPLY_PROP_MODEL_NAME] = BATT_MODEL_NAME,
 	[POWER_SUPPLY_PROP_TIME_TO_FULL_AVG] = BATT_TTF_AVG,
 	[POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG] = BATT_TTE_AVG,
+	[POWER_SUPPLY_PROP_RESISTANCE] = BATT_RESISTANCE,
 	[POWER_SUPPLY_PROP_POWER_NOW] = BATT_POWER_NOW,
 };
 
@@ -582,6 +585,9 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_TEMP:
 		val->intval = battmgr->status.temperature;
 		break;
+	case POWER_SUPPLY_PROP_RESISTANCE:
+		val->intval = battmgr->status.resistance;
+		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
 		val->intval = battmgr->status.discharge_time;
 		break;
@@ -665,6 +671,7 @@ static const enum power_supply_property sm8350_bat_props[] = {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
 	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
+	POWER_SUPPLY_PROP_RESISTANCE,
 	POWER_SUPPLY_PROP_POWER_NOW,
 };
 
@@ -1174,6 +1181,9 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 		case BATT_TTE_AVG:
 			battmgr->status.discharge_time = le32_to_cpu(resp->intval.value);
 			break;
+		case BATT_RESISTANCE:
+			battmgr->status.resistance = le32_to_cpu(resp->intval.value);
+			break;
 		case BATT_POWER_NOW:
 			battmgr->status.power_now = le32_to_cpu(resp->intval.value);
 			break;

-- 
2.34.1



