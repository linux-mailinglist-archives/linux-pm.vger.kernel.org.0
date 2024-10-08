Return-Path: <linux-pm+bounces-15315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C38A994469
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 11:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24EA41F257FF
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 09:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F8D18C916;
	Tue,  8 Oct 2024 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PcoZnEZ7"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F98158205;
	Tue,  8 Oct 2024 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380101; cv=none; b=CfmVjboZ0ZcRMETjaZonAeSBDAszrat/Z7hS62iNktXdC6vfqcA+/Q4lpj70VR8lDpD6YVLV3pGEC8ycncQTY31oeUrSUDouNpOkX1yPwgzc8LZyFRSFNXUwWDsfgrOS4sTzY16nhSZbSVmavkPopc3nKlfGf+Gzr5kMGq+kRVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380101; c=relaxed/simple;
	bh=7g9SsjPLBNKzQvsNRBWduVdMiJPt5aqN0I2fNE1zBqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DBhKfax5WeS8dgCQ4lE2NxvZ88frir5R/iIPXpY4F//ZCN5BsOUpgnAbwQn5sXLKY64rPpMj20F2nQn7DocyIicHGjlnVxWMcJ37lzmCO5Rl+OCJCypVE4u9qNcP1dymXiGLLGqCjEbCjnuaEJwjXFDWAaJYqkaG5JDRoxAcqek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PcoZnEZ7; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 50B8CFF80A;
	Tue,  8 Oct 2024 09:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728380097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVTfe75X+UxRm0WZMZZTw+6JUiWJGgpFVKMMyLGuwIE=;
	b=PcoZnEZ7CEFWJPDMgrhG0gzXmD9FHG3JPN8jZ/HdxwKs7zi3sbOhWMd6oUZYSZpz0FQr0q
	8YJhgNwYo79P/gveCTJUsLsdK6GK17BvyD3bLKWE5gDv6i3g3KsPhS94NiiJzzP+eKgxdA
	kkXNCJV9/3q8eVkcv5udNX2Nsd4NrNH6EGi5UvueFMiBpK4UsuBPlovELlYwkRaTs8T1rV
	SqYK0BaNUEASGM+BGcbp34MdKGUVnMGFda1PuY0C2gkzXgDZl5oehdS0b/AEmVs7mCe0EV
	ItPgaac7jB8kz6fxPR9L7zBTcH8S7iS52A/njS2VGNVh+wfYV8BLKLdPel4JYQ==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Tue, 08 Oct 2024 11:34:17 +0200
Subject: [PATCH 2/2] serial: 8250_omap: mark the serial as on the wakeup
 path if no_console_suspend
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241008-8250-omap-no-console-suspend-v1-2-e7f0365c02f0@bootlin.com>
References: <20241008-8250-omap-no-console-suspend-v1-0-e7f0365c02f0@bootlin.com>
In-Reply-To: <20241008-8250-omap-no-console-suspend-v1-0-e7f0365c02f0@bootlin.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, u-kumar1@ti.com, 
 tony@atomide.com, khilman@kernel.org, gregory.clement@bootlin.com, 
 thomas.petazzoni@bootlin.com, theo.lebrun@bootlin.com, 
 richard.genoud@bootlin.com, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: thomas.richard@bootlin.com

If the console suspend is disabled, mark the serial as on the wakeup path
to keep its PM domain powered on.

Suggested-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/tty/serial/8250/8250_omap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 88b58f44e4e9..6764fe2f9cad 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1660,8 +1660,12 @@ static int omap8250_suspend(struct device *dev)
 	if (!device_may_wakeup(dev))
 		priv->wer = 0;
 	serial_out(up, UART_OMAP_WER, priv->wer);
-	if (uart_console(&up->port) && console_suspend_enabled)
-		err = pm_runtime_force_suspend(dev);
+	if (uart_console(&up->port)) {
+		if (console_suspend_enabled)
+			err = pm_runtime_force_suspend(dev);
+		else
+			device_set_wakeup_path(dev);
+	}
 	flush_work(&priv->qos_work);
 
 	return err;

-- 
2.39.5


