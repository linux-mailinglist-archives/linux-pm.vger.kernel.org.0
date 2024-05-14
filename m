Return-Path: <linux-pm+bounces-7817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFAD8C4F67
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31A1281005
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4871272AE;
	Tue, 14 May 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m+BpUlJ3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L+VyWyAW"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4685C77
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681942; cv=none; b=dy2R1elGy/HZq1D1+cNQvWVyNi3ouICkH4Qrg/ztmUbwmeNItoKRWsuVtFbEEbRpbq78OtnN29NFPSWEQfeErkxuiC/mWJhOHq25Bj33cEimJJoVMtRkuCCqDHAz5iKBPP0JmELK2zkEligdjmUjQS1MGlXF/l/lpKslL+ambqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681942; c=relaxed/simple;
	bh=1ahXcSlgVCZO1Ai9jXBdY88SXSngg6BSeD4RGCvR40U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KiryuMeO6+cpsmTVD9Zc0cJ/JcXw+93hajVezJ/AFpw7tUZRCR1f2zpbtJLrecTF9z7ABiuXTrCjJijwH7boihz1sKNRae2LDVFhKGTHoOk8h4CzjhUn0nBHodM3sTaDZSkgITP6ee16vxoA5tartbQBAtHabQxircu9thOQibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m+BpUlJ3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L+VyWyAW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zGVcOxxHMOdPoi8nR9OMBC6W5lo90h8d46cP+ngVjDA=;
	b=m+BpUlJ3kPvTXKYoijc+HCZfxNhVTbjY6vrPRBC3XTmtXBfiXQi/vzb1a35erhBfgDYcaX
	QuY/0gYfsUarHkTL6p7F/fFS2Dbpvjn0a5p6B+um/16nCc0hV8QoYpfxryXxMhfY2D9VgL
	KY4Ymc/1jSLGtKdwCYOLkDsG7BWzeFDuv59Z7qf0swlZKEMOo3xta1pawJXK7xL4TrRJxJ
	W3ES/Y5eS3cMSJLPZBqstFlshLajTHJZaNwkA14Bm3Kxpfs8bHJrhW7EbYNk7+Bu3mfloB
	tSjh/kXNuEUlR+pVL87RFYND1j6+Xz09raNi21jjKCBMG5HAGyjHH+fTJWXrKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zGVcOxxHMOdPoi8nR9OMBC6W5lo90h8d46cP+ngVjDA=;
	b=L+VyWyAWWCWx4f1Shi+3WFENwG+eA/xmJnfXEwiqgqFiwKO1aorUu9iLHWc1Aa8qb9qFZB
	3euf7d8wI7ESo4AA==
From: "thermal-bot for Nicolas Pitre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/mediatek/lvts_thermal:
 Retrieve all calibration bytes
Cc: Nicolas Pitre <npitre@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240402032729.2736685-2-nico@fluxnic.net>
References: <20240402032729.2736685-2-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193444.10875.12286325720227071971.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     8c25958f71d8c173b81cb422a44c5743beb76af7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//8c25958f71d8c173b81cb422a44c5743beb76af7
Author:        Nicolas Pitre <npitre@baylibre.com>
AuthorDate:    Mon, 01 Apr 2024 23:25:35 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:29 +02:00

thermal/drivers/mediatek/lvts_thermal: Retrieve all calibration bytes

Calibration values are 24-bit wide. Those values so far appear to span
only 16 bits but let's not push our luck.

Found while looking at the original Mediatek driver code.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240402032729.2736685-2-nico@fluxnic.net
---
 drivers/thermal/mediatek/lvts_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 4e5c213..d266626 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -679,7 +679,7 @@ static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl
 
 	for (i = 0; i < lvts_ctrl_data->num_lvts_sensor; i++)
 		memcpy(&lvts_ctrl->calibration[i],
-		       efuse_calibration + lvts_ctrl_data->cal_offset[i], 2);
+		       efuse_calibration + lvts_ctrl_data->cal_offset[i], 3);
 
 	return 0;
 }

