Return-Path: <linux-pm+bounces-7806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700AB8C4F59
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A091C21169
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F12A7CF34;
	Tue, 14 May 2024 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pWz3RURo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ii84dcSZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698587C6C9
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681937; cv=none; b=fuji855aG/jazxgZDqxQCNLW/7491w0r1pDtMelVHOGKvDLXJCHVSQJnxd9QF6aKCOhKCPeOw2+n5d1TvG3jPqYu7slfpSzKjMHzCPhT7kPV9Y7YsTau2LPKuN1f9xbxf7eUPLZqVLYbjyZX3HW+Ah1oXx5C1qoxtpy1y8B4i4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681937; c=relaxed/simple;
	bh=g6/TmrvFNJenHjXyhO7HO4knGvoLgoFjSB9JuJA8a98=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HubRBrOBVKHNt0Dz8+qMIbMHSmX0m716U8+wAEiZVEAiWJJYcJkWA8k3YP+rq7UjONe4yCI/VlsSBcqT8Dexlywb+ST3zwbKLa53+XnBI3vTVuKPMI38rVrRN0ylMvyiRt0V83s1fIT2R3O/dF8QhS5qrOenVHu1UKl/hnvISX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pWz3RURo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ii84dcSZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681932;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L525ZeGn5RR1eyhwiWX75A2UdqE21Z7CNjh/VfMdIc0=;
	b=pWz3RURoctx+D1enere73hT5jXm7NaGNe0NaW9JbLeD/LnTCi4BoZloww50fXs1n8F1iXP
	HwKYtkAfMHJ5IEQsJYuLgK5pLY5IHHzbo1sy0qtb/ScAKbswFTMhJ7V5Z1EUSe4PfRvYH4
	C9fJBSwP7nuSe3hdIk+jgIBQvuH5mtsjxKbLqqzZlu7sY1oalJrOoqXfXfaDllz7AER7Be
	4pNNE7P+tAzpi2M1dKyA2sPaui/uxtY/P1XYisxGvkl5fcCk92G6RLFds4XpcpvwYvFLwg
	/ULsMwIpi5CbTmLUxMBMjj5Bh91cpQbxmMyNVTFzOcyQXGJ4NoMySzXGbeb6Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681932;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L525ZeGn5RR1eyhwiWX75A2UdqE21Z7CNjh/VfMdIc0=;
	b=Ii84dcSZbGZJ2bhs6MNK7IE3mUjsg73u2FNe1+yO6LT/tv/8xATaJRQLIrrDDW3zY2BKGE
	bdhN8RAsSK7hf4AA==
From: "thermal-bot for Julien Panis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/mediatek/lvts_thermal:
 Remove unused members from struct lvts_ctrl_data
Cc: Julien Panis <jpanis@baylibre.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Nicolas Pitre <npitre@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To:
 <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-1-f605c50ca117@baylibre.com>
References:
 <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-1-f605c50ca117@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193248.10875.643166711884717327.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     e2d2266a2ac1da67a74c855c24ed3acb54a1e410
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//e2d2266a2ac1da67a74c855c24ed3acb54a1e410
Author:        Julien Panis <jpanis@baylibre.com>
AuthorDate:    Fri, 03 May 2024 17:35:13 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 06 May 2024 10:33:26 +02:00

thermal/drivers/mediatek/lvts_thermal: Remove unused members from struct lvts_ctrl_data

In struct lvts_ctrl_data, num_lvts_sensor and cal_offset[] are not used.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Nicolas Pitre <npitre@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-1-f605c50ca117@baylibre.com
---
 drivers/thermal/mediatek/lvts_thermal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 20a64b6..4fa5e74 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -105,8 +105,6 @@ struct lvts_sensor_data {
 
 struct lvts_ctrl_data {
 	struct lvts_sensor_data lvts_sensor[LVTS_SENSOR_MAX];
-	int cal_offset[LVTS_SENSOR_MAX];
-	int num_lvts_sensor;
 	u8 valid_sensor_mask;
 	int offset;
 	int mode;

