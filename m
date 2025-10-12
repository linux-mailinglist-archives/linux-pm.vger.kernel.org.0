Return-Path: <linux-pm+bounces-35936-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FD8BD0D91
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 01:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01B13A9D20
	for <lists+linux-pm@lfdr.de>; Sun, 12 Oct 2025 23:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FE42EF665;
	Sun, 12 Oct 2025 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="D9dxE88R"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB202727F3
	for <linux-pm@vger.kernel.org>; Sun, 12 Oct 2025 23:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760312128; cv=none; b=POQDhocWOFPSz+M2SeK9S0Qw/znfkGu/tEwZbvVEqtE5p+ijOkWYzPmnYhA8h9gM17eqy1nQ02OTUB0cKLC672MVnrmX3xGk9zPXKkCSy4omRGFv2tvSD8HKcyE2EQPcHekwcCsvhlwPo4oYOPS6mpA69cPZwOblb4Gr7c3t6Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760312128; c=relaxed/simple;
	bh=gkLy2Qgcq7gN47EkW82rgH1br37FBToXcsjbZlxUg0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKNc7jTgsDUmUMggoKi0gMh7ePiL+aqO1eBUf6Q7ZFoPV4y55hYC2xTqiwG5G7VZk82QKyS0LoaIjqP7dFYfXzSGkKNxWmAqlOtpRP7CBv03y5skg1kGG8iam8o9AWNa2kmEhdx+hHuRNnqrmWvflOAcQIYQ86vyqhRYJTXmzec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=D9dxE88R; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1760312123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aMQxUdZpKenu9e4nFmMim5iXKBYHWVcK5NULU+g21sU=;
	b=D9dxE88R60fxDnkI3tHA8ApGl7LoVnog7o4mCXbJ0I6yg7FmmVNauMJuXlCWIXoboQe+SI
	AFqAjTmXT5bhnGP0x96VTO5FpvHNo/vsxmB4a2y56Brdb9bhQJgOH3Wg0OEG8xfCPR1AUG
	H2wz/tlhDlW31WPEofYF2kcee7xS+e0Yc3neKItfxuBZB0L4DhOifKNpoJ3Grcioqoyrd0
	s93BbVG78dIVvjMdYUjyfBbvhWodQ8Dt43uGMwmatkckFRGoimAaeACR0082946XeCdWOc
	7jHP/pQEeF2WJdnGAVa88oX9WT9hX0hEpLMUrcd+5yYIrZrIZcRB/e8yESiQBg==
From: Val Packett <val@packett.cool>
To: Sebastian Reichel <sre@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: Val Packett <val@packett.cool>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] power: supply: qcom_battmgr: clamp charge control thresholds
Date: Sun, 12 Oct 2025 20:32:18 -0300
Message-ID: <20251012233333.19144-3-val@packett.cool>
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

The sysfs API documentation says that drivers "round written values to
the nearest supported value" for charge_control_end_threshold.

Let's do this for both thresholds, as userspace (e.g. upower) generally
does not expect these writes to fail at all.

Fixes: cc3e883a0625 ("power: supply: qcom_battmgr: Add charge control support")
Signed-off-by: Val Packett <val@packett.cool>
---
 drivers/power/supply/qcom_battmgr.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 3c2837ef3461..c8028606bba0 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -678,12 +678,7 @@ static int qcom_battmgr_set_charge_start_threshold(struct qcom_battmgr *battmgr,
 	u32 target_soc, delta_soc;
 	int ret;
 
-	if (start_soc < CHARGE_CTRL_START_THR_MIN ||
-	    start_soc > CHARGE_CTRL_START_THR_MAX) {
-		dev_err(battmgr->dev, "charge control start threshold exceed range: [%u - %u]\n",
-			CHARGE_CTRL_START_THR_MIN, CHARGE_CTRL_START_THR_MAX);
-		return -EINVAL;
-	}
+	start_soc = clamp(start_soc, CHARGE_CTRL_START_THR_MIN, CHARGE_CTRL_START_THR_MAX);
 
 	/*
 	 * If the new start threshold is larger than the old end threshold,
@@ -716,12 +711,7 @@ static int qcom_battmgr_set_charge_end_threshold(struct qcom_battmgr *battmgr, i
 	u32 delta_soc = CHARGE_CTRL_DELTA_SOC;
 	int ret;
 
-	if (end_soc < CHARGE_CTRL_END_THR_MIN ||
-	    end_soc > CHARGE_CTRL_END_THR_MAX) {
-		dev_err(battmgr->dev, "charge control end threshold exceed range: [%u - %u]\n",
-			CHARGE_CTRL_END_THR_MIN, CHARGE_CTRL_END_THR_MAX);
-		return -EINVAL;
-	}
+	end_soc = clamp(end_soc, CHARGE_CTRL_END_THR_MIN, CHARGE_CTRL_END_THR_MAX);
 
 	if (battmgr->info.charge_ctrl_start && end_soc > battmgr->info.charge_ctrl_start)
 		delta_soc = end_soc - battmgr->info.charge_ctrl_start;
-- 
2.51.0


