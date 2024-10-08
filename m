Return-Path: <linux-pm+bounces-15313-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF561994464
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 11:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FDBB215C1
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 09:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C950A184551;
	Tue,  8 Oct 2024 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nNWnDXlL"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AC717C21E;
	Tue,  8 Oct 2024 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380100; cv=none; b=FsihaOx9/jCH/BgypJQpfyjdqmeOV9xIWwBaRrb3/TRd1gR0B1FO7u5TJtuwIgQAPUCJjmEi+y+Ynk3ZU8SSbhkxwzA0EBbBpik0Xh7twwijUB3rNCG8PA/FK2dNcP4I87YToO8VrJyhLnFrdqkq4YqFs6xJaJizjhDLSrtbZYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380100; c=relaxed/simple;
	bh=Qou6sIyPLnFlHqBu1Z+x5bbFWBPj7OXjLiREoZFncRk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BUWJmoIXkFnGTzpamn3ggt459Pfd65wl4qO9+YQhrc+BpLUfjCoeph1TMDouqc8I/knGNQbY5nmWa1h1krojMfQSphCphywe53URfTPXkKQOE+R3eFd7RlnuwjHMV3A7DISmzvMqKqtYPfDGUCjvCX/fLKuiqSIrmkY0mWrMCLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nNWnDXlL; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 86BBCFF807;
	Tue,  8 Oct 2024 09:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728380096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=azrDAqPDegI1ED+UegA1GMYxEZg817Bjad4Z4j+1f7E=;
	b=nNWnDXlLVhOKWeQOG9c13C/2zDuuVq3RiKfut+L/CIhj+wcgediLJsPNT2S8rO+PaMGsud
	cK1zemuzwyjs6pfooGDJLM3CFT4F0j9h/9IgVfOhvNuycCekycaV05d2ex3qkH9cabzgaV
	Dr80AIK4Sy0nXRh+3jA8fh02nhl+7GPTdU9ybDeM1xa7d8iNyJ5kWCuGdRg9GitQrJGlN3
	i/rlyYv/STrMVbsrOlOusXehRnohmpfXe6Xm5F2ihpX1kGeaQCgJxIVsDtAJMM0q7qTG5o
	g9DtApqQR8lWIOmDxj9y5UxXGDaV+N0q3luucJhHTlgU2nZcjL5LJyE32hJa7A==
From: Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH 0/2] Fix no_console_suspend in the 8250_omap driver
Date: Tue, 08 Oct 2024 11:34:15 +0200
Message-Id: <20241008-8250-omap-no-console-suspend-v1-0-e7f0365c02f0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJf8BGcC/x3MwQrCMAwA0F8ZORtI241Vf0U8jDXTgCalQRHG/
 t3i8V3eDs5N2OEy7ND4Iy6mHeE0wPpY9M4opRsixZFyOGOOE6G9lopquJq6PRn97ZW1YKA5Jco
 lzWGEXtTGm3z//fV2HD8GasSjbgAAAA==
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

This series fixes the no_console_suspend in the 8250_omap driver.
A first implementation was introducted [1].
But it was recently reverted [2] because it causes a crash during suspend on
the platforms that don't use PM domains.
This series implements the proposal sent by Théo Lebrun and discussed with
Kevin Hilman and Tony Lindgren in the thread [3].

This series was tested on a J7200 EVM board.

Regards,

Thomas

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=68e6939ea9ec3d6579eadeab16060339cdeaf940
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0863bffda1131fd2fa9c05b653ad9ee3d8db127e
[3] https://lore.kernel.org/all/20231017130540.1149721-1-thomas.richard@bootlin.com/

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
Thomas Richard (2):
      pmdomain: ti-sci: set the GENPD_FLAG_ACTIVE_WAKEUP flag for all PM domains
      serial: 8250_omap: mark the serial as on the wakeup path if no_console_suspend

 drivers/pmdomain/ti/ti_sci_pm_domains.c | 1 +
 drivers/tty/serial/8250/8250_omap.c     | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)
---
base-commit: 6bf6745da1d37bc132690d96ef1455a62b0177cf
change-id: 20240819-8250-omap-no-console-suspend-1073308d3714

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>


