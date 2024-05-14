Return-Path: <linux-pm+bounces-7822-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3988C4F6A
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CED282CCA
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1A613AA4E;
	Tue, 14 May 2024 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cJuVJgqX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iAxf/4I7"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A65886248
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681943; cv=none; b=iwtjKUwzE8qD5QVWr8KMsWNfEOVTtezusSQvf8Q51Mjdp9RQfVBFm7Tz46HC/Ua5v14FP4XxRSY+KNllwiVQwPAEISBhRpn6Lsa0mWKrUytGILsf2l4LaIz7sHn0NlfQTiitJfcdRDeo+Sg87gGckG7zC+CwcbCPrhJTQtLaJM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681943; c=relaxed/simple;
	bh=OEJMi0ijNNGEt9osSPtHM8kgXrTrTYsr0Dr0cgWEPYk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Jat4NboWNrlytQYrG4HNpW3Lmzi4G6PI/rFHgE9GhzQb/UpXd7p+6Ag91iYqWuSmAUCwpBgsRor5baXjeDkDXUJEYdwPyL+flSULOuLq4sRI3T3wtfEt+vc6nmpX8lgZUpjkwAKTS6xLCrFSAuRcHdKyPXCTaFnexvRu5bPV8+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cJuVJgqX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iAxf/4I7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vbk9tCVlcw0f7f8K6FxvEomNbxyDXw1XUvJgJD9dEjg=;
	b=cJuVJgqXiN5kDFDqPePZCWu4QcCsg7ymEdm6yMubvZxyc0wN2GgtF2Phe3DUCF/7YMGCg7
	dbcjtIKxP7sDEymsbHMakq/eThwvkex0TPp4TJr9ECir5amtjfnCgatGvi1oyolKrdk41r
	S2ywNo3EpqfMvyhhmN6LlZCHEu5jNAE67QYn9vi+YvBNMchMY16kU62FKEBqoFkpv7bEwJ
	KNvDC4tPCXH7XyNiqBUBXgs+YeCIXwXOgCxt0tu8VYf6NmzTXSqZimeOsPNc3tFhzVzDR7
	XDSSCyOZKYPtTnxumaQy1P54zYYiEabwkpFcbm5kyj3EbsaZp99Wvm2X5L4IuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vbk9tCVlcw0f7f8K6FxvEomNbxyDXw1XUvJgJD9dEjg=;
	b=iAxf/4I7tbXrpFzlWPR7dmor6+e6RqBDv6fMxH29dweASN+dHPN9NWnbi0CLbJiajduWre
	exMLANHMWwuV7DAQ==
From: "thermal-bot for Hsin-Te Yuan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/mediatek/lvts_thermal: Add
 coeff for mt8192
Cc: "Hsin-Te Yuan" <yuanhsinte@chromium.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240416-lvts_thermal-v2-1-f8a36882cc53@chromium.org>
References: <20240416-lvts_thermal-v2-1-f8a36882cc53@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193489.10875.7658757792902521119.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     7954c92ede882b0dfd52a5db90291a4151b44c1a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//7954c92ede882b0dfd52a5db90291a4151b44c1a
Author:        Hsin-Te Yuan <yuanhsinte@chromium.org>
AuthorDate:    Tue, 16 Apr 2024 07:35:47 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:29 +02:00

thermal/drivers/mediatek/lvts_thermal: Add coeff for mt8192

In order for lvts_raw_to_temp to function properly on mt8192,
temperature coefficients for mt8192 need to be added.

Fixes: 288732242db4 ("thermal/drivers/mediatek/lvts_thermal: Add mt8192 support")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240416-lvts_thermal-v2-1-f8a36882cc53@chromium.org
---
 drivers/thermal/mediatek/lvts_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index fd4bd65..4e5c213 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1530,11 +1530,15 @@ static const struct lvts_data mt7988_lvts_ap_data = {
 static const struct lvts_data mt8192_lvts_mcu_data = {
 	.lvts_ctrl	= mt8192_lvts_mcu_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT8195,
+	.temp_offset	= LVTS_COEFF_B_MT8195,
 };
 
 static const struct lvts_data mt8192_lvts_ap_data = {
 	.lvts_ctrl	= mt8192_lvts_ap_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_ap_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT8195,
+	.temp_offset	= LVTS_COEFF_B_MT8195,
 };
 
 static const struct lvts_data mt8195_lvts_mcu_data = {

