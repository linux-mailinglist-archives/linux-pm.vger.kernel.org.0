Return-Path: <linux-pm+bounces-7802-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87DF8C4F55
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155C51C21054
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EC976045;
	Tue, 14 May 2024 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e89/ZbHq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4TD78HAZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6977A763F7
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681936; cv=none; b=TuVzJArA+rKshd/RIF8Xz9e637MpV5dOmYGKEQ9V300sbQxsaiiG1GLanOwIBGWUqkUMGGWIX6neo/T8QXfJzVXZWO5bXtsiSMZZVsqc+Yj8VDtEDd7QdCzdjZw+nhFJ5hcItiP20luJip1AfDt+6RrHrOWLGDJjYsC6wXlta4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681936; c=relaxed/simple;
	bh=drr5A2lZ2vfdK+5OjxWdK6IizKaxq7s0nOAOfz1iQkg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eevxeRGzKYRpCtisEQqGGij7V7YTM4wpjLxj3ToqCe9Mfq+lt0jxFr0uVudzag/+E1RFyGFOiZha83o5hYLaS97aICsQs42Ix+1MNW4ezs8u+aRmekYx2Q1FUUQAkCPfJbEDBVyIr3+uKU57Exe+/pfJHPDmVAGO7xHSabGo7UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e89/ZbHq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4TD78HAZ; arc=none smtp.client-ip=193.142.43.55
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
	bh=/qEbwEpF71jrDM+EnYqsA2nm7Ku4OtkQK4k3q/ZQJCM=;
	b=e89/ZbHqUO0deE6x0AOWsfYZrrM+UMpS/p8drQH99U/gYPEGXFP/ukt9uCZtJUXmaXWbH4
	RUCYskZZDQep4DyXSiP1FZemsPf20IrE2wlq7+5ewFuN74VsA3QcyHL/GpxKqRh7gFAnRr
	4mma62+WOkxX0KQMV445qVF6t5PlJgc/1RPzkC3t/5/kwdAcPsK2LT6onm4W8aBeJOHhqe
	kKoYtnGxG3ltOej5WhWp6hnWbJ9C2iREOfzuEv00GB5UJs/lVffwm3+ZYuSKe2bvthXUwN
	PNqElTUEHyRGh6zok1x9hh2ZoOyMq5vaZ46Tj+3u+mjDw5UPF/Z+e9OFkJvyAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681932;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/qEbwEpF71jrDM+EnYqsA2nm7Ku4OtkQK4k3q/ZQJCM=;
	b=4TD78HAZNrBfttAVyXMaGMJMq+djeYdd2vKQuRY4aoGRf+u6GtAGAPQBN5eJqgJndu9JfQ
	qqvgTmeltlq7ghDQ==
From: "thermal-bot for Julien Panis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/mediatek/lvts_thermal: Check
 NULL ptr on lvts_data
Cc: Julien Panis <jpanis@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240502-mtk-thermal-lvts-data-v1-1-65f1b0bfad37@baylibre.com>
References: <20240502-mtk-thermal-lvts-data-v1-1-65f1b0bfad37@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193258.10875.15198718649707261237.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     a1191a77351e25ddf091bb1a231cae12ee598b5d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//a1191a77351e25ddf091bb1a231cae12ee598b5d
Author:        Julien Panis <jpanis@baylibre.com>
AuthorDate:    Thu, 02 May 2024 15:46:03 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 02 May 2024 15:56:41 +02:00

thermal/drivers/mediatek/lvts_thermal: Check NULL ptr on lvts_data

Verify that lvts_data is not NULL before using it.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240502-mtk-thermal-lvts-data-v1-1-65f1b0bfad37@baylibre.com
---
 drivers/thermal/mediatek/lvts_thermal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 86b2f44..20a64b6 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1271,6 +1271,8 @@ static int lvts_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	lvts_data = of_device_get_match_data(dev);
+	if (!lvts_data)
+		return -ENODEV;
 
 	lvts_td->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(lvts_td->clk))

