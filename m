Return-Path: <linux-pm+bounces-35937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA26FBD0D97
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 01:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1D23AC932
	for <lists+linux-pm@lfdr.de>; Sun, 12 Oct 2025 23:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C06A2F0C48;
	Sun, 12 Oct 2025 23:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="b/q4eQxk"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118C2EFDA2;
	Sun, 12 Oct 2025 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760312130; cv=none; b=VRlKiqXzxuoRbTTWAeh9X7Lm4r992HAYCR8ktaGZ0D4MV67yzHe4kZIlA4TwHIrlln/sk27uHXVFAWldn7AAiXl7CAfkpe7cZ4PBM6IPyTxesY2mIgLHPx7DYWdkOHQ0nBftMpdQ6sSD+h/iLApavcmboBDdAMkv2lkU1rVt1S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760312130; c=relaxed/simple;
	bh=HcgvRsl6W0SNKxZG8xv51myRgFtAdDrV+t95LVLew9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uR+sHmdXVMs42/dZBRl56NOVmEVrO5fpJKElbpnBoE0JQ41Uxqhq7ENN1DsXw0aHNYZ9fBLEmuapvTQr0t6oxtkgHLjcu2HrnCqANXQ9QeRy8KYsKx9zq6kSKIfSMrzuC8NymoryhPgdoKwSvFks2NwASCj9+WTDLHzQjcrIb0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=b/q4eQxk; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1760312126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AqflzUk4CL99JJ1fV54jyel3/p1XOOUdQirvgksUsSo=;
	b=b/q4eQxk/ANOiFw2WPA0ueuB18mLKM4tT6KpP1YKLLmJu02BUe5P1xL7zcggCDf1Jc5hWp
	XI5JhZaWLzc3nhR/UeINo22TzmEnpFTnzsUO1k/nYFtRXpNX3Sogd16adwque1ZzUo6jK9
	yvHmC58EIPRXi86h9CYouE51suEXVJTcoqYJTo8dqa5emMFGtrV08qMQ0gmI6LV2aKcfxD
	kTvUq7BSHrkjnbM+kVMnlG8gATGyClKrIlXCdoSzbwFDg06pcaRyWdl7CDIeEhKUSDf5MV
	vDqxXZhM+jLR+uR+mSY8BJQ2Xk6sWKQLZ6VpArBsV8Qt53Q8Mo+si/nc0J2wLw==
From: Val Packett <val@packett.cool>
To: Sebastian Reichel <sre@kernel.org>,
	Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Val Packett <val@packett.cool>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] power: supply: qcom_battmgr: support disabling charge control
Date: Sun, 12 Oct 2025 20:32:19 -0300
Message-ID: <20251012233333.19144-4-val@packett.cool>
In-Reply-To: <20251012233333.19144-2-val@packett.cool>
References: <20251012233333.19144-2-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Existing userspace (in particular, upower) disables charge control by
setting the start threshold to 0 and the stop threshold to 100.

Handle that by actually setting the enable bit to 0 when a start
threshold of 0 was requested.

Fixes: cc3e883a0625 ("power: supply: qcom_battmgr: Add charge control support")
Signed-off-by: Val Packett <val@packett.cool>
---
 drivers/power/supply/qcom_battmgr.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index c8028606bba0..e6f01e0122e1 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -257,6 +257,7 @@ struct qcom_battmgr_info {
 	unsigned int capacity_warning;
 	unsigned int cycle_count;
 	unsigned int charge_count;
+	bool charge_ctrl_enable;
 	unsigned int charge_ctrl_start;
 	unsigned int charge_ctrl_end;
 	char model_number[BATTMGR_STRING_LEN];
@@ -659,13 +660,13 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
 }
 
 static int qcom_battmgr_set_charge_control(struct qcom_battmgr *battmgr,
-					   u32 target_soc, u32 delta_soc)
+					   bool enable, u32 target_soc, u32 delta_soc)
 {
 	struct qcom_battmgr_charge_ctrl_request request = {
 		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
 		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
 		.hdr.opcode = cpu_to_le32(BATTMGR_CHG_CTRL_LIMIT_EN),
-		.enable = cpu_to_le32(1),
+		.enable = cpu_to_le32(enable),
 		.target_soc = cpu_to_le32(target_soc),
 		.delta_soc = cpu_to_le32(delta_soc),
 	};
@@ -677,6 +678,7 @@ static int qcom_battmgr_set_charge_start_threshold(struct qcom_battmgr *battmgr,
 {
 	u32 target_soc, delta_soc;
 	int ret;
+	bool enable = start_soc != 0;
 
 	start_soc = clamp(start_soc, CHARGE_CTRL_START_THR_MIN, CHARGE_CTRL_START_THR_MAX);
 
@@ -696,9 +698,10 @@ static int qcom_battmgr_set_charge_start_threshold(struct qcom_battmgr *battmgr,
 	}
 
 	mutex_lock(&battmgr->lock);
-	ret = qcom_battmgr_set_charge_control(battmgr, target_soc, delta_soc);
+	ret = qcom_battmgr_set_charge_control(battmgr, enable, target_soc, delta_soc);
 	mutex_unlock(&battmgr->lock);
 	if (!ret) {
+		battmgr->info.charge_ctrl_enable = enable;
 		battmgr->info.charge_ctrl_start = start_soc;
 		battmgr->info.charge_ctrl_end = target_soc;
 	}
@@ -710,6 +713,7 @@ static int qcom_battmgr_set_charge_end_threshold(struct qcom_battmgr *battmgr, i
 {
 	u32 delta_soc = CHARGE_CTRL_DELTA_SOC;
 	int ret;
+	bool enable = battmgr->info.charge_ctrl_enable;
 
 	end_soc = clamp(end_soc, CHARGE_CTRL_END_THR_MIN, CHARGE_CTRL_END_THR_MAX);
 
@@ -717,7 +721,7 @@ static int qcom_battmgr_set_charge_end_threshold(struct qcom_battmgr *battmgr, i
 		delta_soc = end_soc - battmgr->info.charge_ctrl_start;
 
 	mutex_lock(&battmgr->lock);
-	ret = qcom_battmgr_set_charge_control(battmgr, end_soc, delta_soc);
+	ret = qcom_battmgr_set_charge_control(battmgr, enable, end_soc, delta_soc);
 	mutex_unlock(&battmgr->lock);
 	if (!ret) {
 		battmgr->info.charge_ctrl_start = end_soc - delta_soc;
-- 
2.51.0


