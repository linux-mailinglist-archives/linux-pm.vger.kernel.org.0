Return-Path: <linux-pm+bounces-7827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ECE8C4F6D
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB07E1C21147
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7760113FD61;
	Tue, 14 May 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uxjo/8Ec";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vgl9vScU"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E9484D05
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681944; cv=none; b=BbiKi4uV+8nHiuRNW/PrKaIhfGUqNoUK3Cj8SUuC/I09IJex1/eXWkMR7VwmUurkukXb0Lx0OMPuAYZKB6e/MvrCcBeONl78E3cPyeRz1x32OTUeigbjDrNyfNs0yBXoZvj32cuobiYkul+7VK8EN7Xqsk9MH2Y2XK3oL8U92QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681944; c=relaxed/simple;
	bh=xWPbV795pbGRTgS1vkOgiE61w/OAamoJn5tUUXHlgRo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IkmMyKoyIEVh5o+KCIWNK4ieZqBJRVCmP8pbOQ4n7y9wmslwbiDDWt7mI1kXbwYNz8tFNJys72mzW7Qqqy7YHuacMX4X3OffRfsEUIKpuGobLxR59jNCkWrHkL5n2J+x1N1R9w8rza6TLhElZt967iJtGeB8g99ud2mRV92HUQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uxjo/8Ec; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vgl9vScU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ulvRSNN0jpy52JJM01R1psBefrLoJWspepWC7W4FdI=;
	b=Uxjo/8EcMb8tb+k3vmG4Fa7GTktWG57Rn3oTHMfCP6Te9TqC0aW/uUweVpBGcT+MgsE5Hj
	6tm3o8p4R9v9ZUj2ZZ5Bzk3opAxzXqhbpLFTmg0mIr7SjUT9dxgot9vGM3HChlaXc3VXWn
	+ea5N7LPYGHa5bJdKDeOoV3WF/9+QCZg3ADEu2cYKxgeGMeAQcCSFtyZ1yRbrhyNGpKgaN
	R3Vpmex/0OKRJABb4TnLL3xkibCkQZNb1H6yybyYRYb5L6znAw4imWrn8vcoGMJ0xz+IBk
	Q9tVvQyYGsuPboRVTBNT50VrK1zoyATZSC3RALnbXW7EdpBcHMCdW02ohJ1OzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ulvRSNN0jpy52JJM01R1psBefrLoJWspepWC7W4FdI=;
	b=Vgl9vScU6g+cNERwvUnbPqj8um5WwWASirG9+yO2pEgMAYrUsoFJhvje/OPUgRBxl05NZH
	gMbgnTGmctsYT3AA==
From: "thermal-bot for Rasmus Villemoes" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject:
 [thermal: thermal/fixes] thermal/drivers/armada: Simplify name sanitization
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240320104940.65031-1-linux@rasmusvillemoes.dk>
References: <20240320104940.65031-1-linux@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193595.10875.5143721042252604946.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     58b1569244fea51cbf675774fad9423359d76c57
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//58b1569244fea51cbf675774fad9423359d76c57
Author:        Rasmus Villemoes <linux@rasmusvillemoes.dk>
AuthorDate:    Wed, 20 Mar 2024 11:49:39 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:29 +02:00

thermal/drivers/armada: Simplify name sanitization

Simplify the code by using the helper we have for doing exactly this.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240320104940.65031-1-linux@rasmusvillemoes.dk
---
 drivers/thermal/armada_thermal.c |  9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index f783547..fdcb077 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -763,7 +763,6 @@ static void armada_set_sane_name(struct platform_device *pdev,
 				 struct armada_thermal_priv *priv)
 {
 	const char *name = dev_name(&pdev->dev);
-	char *insane_char;
 
 	if (strlen(name) > THERMAL_NAME_LENGTH) {
 		/*
@@ -781,12 +780,8 @@ static void armada_set_sane_name(struct platform_device *pdev,
 	/* Save the name locally */
 	strscpy(priv->zone_name, name, THERMAL_NAME_LENGTH);
 
-	/* Then check there are no '-' or hwmon core will complain */
-	do {
-		insane_char = strpbrk(priv->zone_name, "-");
-		if (insane_char)
-			*insane_char = '_';
-	} while (insane_char);
+	/* Then ensure there are no '-' or hwmon core will complain */
+	strreplace(priv->zone_name, '-', '_');
 }
 
 /*

