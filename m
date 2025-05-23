Return-Path: <linux-pm+bounces-27540-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B435AC19BB
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 03:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062FBA26387
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 01:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9EE202C3E;
	Fri, 23 May 2025 01:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giA2grjw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842382DCC0C;
	Fri, 23 May 2025 01:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747964383; cv=none; b=YI9zkNfG/mL6E0zKyYgEYYtZx/OfVV7+j0cmRdhKAeafOZdi8YUHQVqjukR5ByYEL08uPp/VlATUDxAkqS3LcYJ6ul3x9WfD3WkDdgWBgeND0D0G89cZERnCdZjj5eICkdj2pU+jDGk44XFDphFIF+YNvPZlWqAHpDc6Y+r9AvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747964383; c=relaxed/simple;
	bh=HpRU3ck2iDgNbdzeI8oBQWZLheKpAIeZpo9xfMldP2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bJqpcSrJqvG603Sz9yf3yIFswhSDoAPUqZb+2rU61C7xwOeJY007fV1HzRdFKh9snLURB/x1fAxDoaHCbYFAWXtXcRS8uKY4cP5uTitT92w424XwrPIBAwIOYvRvCZhiZmGmt5vl39S/4TpkzQxdI/x7OqQBMme4osDOkQTXhuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giA2grjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2041BC4CEEF;
	Fri, 23 May 2025 01:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747964383;
	bh=HpRU3ck2iDgNbdzeI8oBQWZLheKpAIeZpo9xfMldP2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=giA2grjwZYDZL5QAjBhKznxhCdYLf6N6uSWQwlbkt8DuXHT8bwV7+zMSZ2WUhtWGq
	 CoK6tA1Iej+gyBSwaGCK8z2atD+RzGRWNDQVpWbSDda3mSuPEJw1KitEOyt7nEArGR
	 1CzwKtlovZIDdXh3tuLSpcczy4sOnSmGFlBuzWu4vQoqxc9xIRCAoBUr/nB1YXl4La
	 dEtYgxFi4FQxDEW/rp2hzSLTPAuU9exaveq827E+GeDadP66qYAaA3hAWe+jBVhb79
	 RXs/bjieeiALOA9Saql46fyJsg8lnIdUlptu1+lwA8EI+m8YHC4WC8l0pYIt6GHIRp
	 L7gNl7+IOAv/A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E53DC54F32;
	Fri, 23 May 2025 01:39:43 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Fri, 23 May 2025 09:39:20 +0800
Subject: [PATCH 3/5] power: supply: qcom_battmgr: Add resistance power
 supply property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-qcom_battmgr_update-v1-3-2bb6d4e0a56e@oss.qualcomm.com>
References: <20250523-qcom_battmgr_update-v1-0-2bb6d4e0a56e@oss.qualcomm.com>
In-Reply-To: <20250523-qcom_battmgr_update-v1-0-2bb6d4e0a56e@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 kernel@oss.qualcomm.com, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747964381; l=2437;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=0cVLEmmNpliBpNUD0QR9vZL+uf2t1nTBnEIcltQ8698=;
 b=jpqwx5MLqkI4ZFF269xLqE2xi+JC60fDH00wkb/t5d0qBQ6/tjXby2FafeOj6V5k/CQy0Wa5v
 B6qxFMyF8RjAfJcYinA8+y5gddd4hmPsueB1y78KNKJwyjrlW7desSF
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



