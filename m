Return-Path: <linux-pm+bounces-27834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 019E8AC8904
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 09:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2451BA4D32
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 07:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32323213245;
	Fri, 30 May 2025 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2EYN9QT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6D91EF363;
	Fri, 30 May 2025 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748590541; cv=none; b=OTWmLfVNUJl9GNZ2+UlutN2NKL3mjmb10QbpI/KzmEMXededNErr2VnuaClBHt8ZhdBDCyHoDaYJF3ZU5nDS/PohM8gK9ChsbPtyX9glLzWIT8X2ngVjuaYq36YJzS+zyCvDICJIwSFmITEPhXDwvtag0mWeR49+WWBa9JTIY9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748590541; c=relaxed/simple;
	bh=fSH8VcUWn4IadvvlHLpin4WeIfYmHHLC9in+AqR65Tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ogHmT67kABc43W2bZJg4S5KMPgUFTAItHmUn7txb7n1V6FAFDB3UBEY04vLFnzsXky2O97v0qnAIbW69sZJpjtzaMa0CxHx2/xLmWEsA8bQ4pLkCdJooeCzPGAN6yQy/fqw/t/5F7+erTMFBVcq8kyAfpOB0/nirJybkVCcY9Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2EYN9QT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72FBCC4CEFD;
	Fri, 30 May 2025 07:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748590540;
	bh=fSH8VcUWn4IadvvlHLpin4WeIfYmHHLC9in+AqR65Tg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=I2EYN9QTXDqyQH1xu7hYd0Drwt2hrkxe19tW0BbmSwi/TKxNaK9OEB5rTnD2jiIWq
	 7ZPUBlskZd4ZxkLuskTjPhLJrvAVE6JpdJg+Vcm7SmVzf3OyUCizDnaNGrE/zZNq3I
	 bvefzMI6KRfcCQj8JMgVcG6gQ7OLDa0ooUf32PzPsFozLBbYicxI1lGtjj2rJyUNCx
	 Dd0Alnwus645TAqCMeinkQ37yl8D4PECOOgfExRN9SeWhV2HA2XaqElgyWabS6NmFx
	 eX/fuD0lv/EgKNSyp7N9t8yRQE2FPYaIseQz+CfPfnsID9Q7UUUJGZC2MOjgBlgej6
	 ECwdp9j3pPuDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BDBC3ABB2;
	Fri, 30 May 2025 07:35:40 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Fri, 30 May 2025 15:35:09 +0800
Subject: [PATCH v2 4/8] power: supply: qcom_battmgr: Add state_of_health
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-qcom_battmgr_update-v2-4-9e377193a656@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748590538; l=2172;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=JvAD0WnJwITmbmbJY6i45xNmJBhhzbm9/zJiJwWXo38=;
 b=9rkh5BKfzPngMIJ7u7RRP2bA7O0eJt+4RHcBRq4v21hAXG0ZxWZ3hgxupfw0Smd5t9HMNOC7r
 TN0SOicvlABBzXLDkSgGXxFJ5ysniHzZOz2iWKVRJ4gFGiu/+/NhLZB
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Add state_of_health property to read battery health percentage from
battery management firmware.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/power/supply/qcom_battmgr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index bc521f60f67fa427cc03b51c44adaeb46ae746f5..d5d0200b92bdc3d9a22f44159ad45b152efe8be0 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -256,6 +256,7 @@ struct qcom_battmgr_status {
 	unsigned int voltage_ocv;
 	unsigned int temperature;
 	unsigned int resistance;
+	unsigned int soh_percent;
 
 	unsigned int discharge_time;
 	unsigned int charge_time;
@@ -421,6 +422,7 @@ static const u8 sm8350_bat_prop_map[] = {
 	[POWER_SUPPLY_PROP_TIME_TO_FULL_AVG] = BATT_TTF_AVG,
 	[POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG] = BATT_TTE_AVG,
 	[POWER_SUPPLY_PROP_RESISTANCE] = BATT_RESISTANCE,
+	[POWER_SUPPLY_PROP_STATE_OF_HEALTH] = BATT_SOH,
 	[POWER_SUPPLY_PROP_POWER_NOW] = BATT_POWER_NOW,
 };
 
@@ -588,6 +590,9 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_RESISTANCE:
 		val->intval = battmgr->status.resistance;
 		break;
+	case POWER_SUPPLY_PROP_STATE_OF_HEALTH:
+		val->intval = battmgr->status.soh_percent;
+		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
 		val->intval = battmgr->status.discharge_time;
 		break;
@@ -672,6 +677,7 @@ static const enum power_supply_property sm8350_bat_props[] = {
 	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
 	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
 	POWER_SUPPLY_PROP_RESISTANCE,
+	POWER_SUPPLY_PROP_STATE_OF_HEALTH,
 	POWER_SUPPLY_PROP_POWER_NOW,
 };
 
@@ -1141,6 +1147,9 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 		case BATT_CAPACITY:
 			battmgr->status.percent = le32_to_cpu(resp->intval.value) / 100;
 			break;
+		case BATT_SOH:
+			battmgr->status.soh_percent = le32_to_cpu(resp->intval.value);
+			break;
 		case BATT_VOLT_OCV:
 			battmgr->status.voltage_ocv = le32_to_cpu(resp->intval.value);
 			break;

-- 
2.34.1



