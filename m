Return-Path: <linux-pm+bounces-1023-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B9080F9AD
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 22:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7074F1F2140D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 21:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7095064157;
	Tue, 12 Dec 2023 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raybKYX8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E95D63BE5;
	Tue, 12 Dec 2023 21:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C01C433C7;
	Tue, 12 Dec 2023 21:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702417624;
	bh=GEbphLNtH08LYd0Afzr3nGiRgbiKfgbz66e9KqMpUhU=;
	h=From:To:Cc:Subject:Date:From;
	b=raybKYX8pD28eWvS9kJTUl17VqcRAmZWstq0aEf1C5YsyMLoc/U6BK4UMr4to8xgu
	 Py/EVmYq86jMuQpfTSQrmFfU0X10fGjEVGaklTTf4buECe/CUdzkkYlAJAjNdoyNrt
	 amBFsljgtiA0eQQQKmFzf/W+n+ILhvvBUUBTNazhzkjSnnxCHnGTXqnuUXaf+M+znV
	 y0Z39pyNU1P+BdG9XIzmUUjYufwwvnAaT8yYxL5Vtps3Omv25TLyRfLvuEr2OE9gNS
	 R+eOyk6olNvcyMhMsioZHrRdYAhvLmPEeGTMhc2vGQ3HSjPkaVbWeztI2suV8rejIY
	 ITWUOrZ8Vc+aA==
From: Arnd Bergmann <arnd@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Yangtao Li <frank.li@vivo.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] power: reset: at91: mark at91_wakeup_status non-__init
Date: Tue, 12 Dec 2023 22:46:49 +0100
Message-Id: <20231212214658.213510-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Two copies of the at91_wakeup_status() function are called by the
respective probe() callbacks and are marked __init, but the probe
functions are no longer annotated that way. This works with gcc because
the functions always get inlined, but clang keeps them separate, which
can lead to executing freed memory:

WARNING: modpost: vmlinux: section mismatch in reference: at91_poweroff_probe+0x80 (section: .text) -> at91_wakeup_status (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: at91_shdwc_probe+0xcc (section: .text) -> at91_wakeup_status (section: .init.text)

Drop the incorrect annotation on these.

Fixes: 099806de68b7 ("power: reset: at91-poweroff: Stop using module_platform_driver_probe()")
Fixes: dde74a5de817 ("power: reset: at91-sama5d2_shdwc: Stop using module_platform_driver_probe()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/reset/at91-poweroff.c      | 2 +-
 drivers/power/reset/at91-sama5d2_shdwc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
index 126e774e210c..93eece027865 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -57,7 +57,7 @@ static struct shdwc {
 	void __iomem *mpddrc_base;
 } at91_shdwc;
 
-static void __init at91_wakeup_status(struct platform_device *pdev)
+static void at91_wakeup_status(struct platform_device *pdev)
 {
 	const char *reason;
 	u32 reg = readl(at91_shdwc.shdwc_base + AT91_SHDW_SR);
diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index af95c7b39cb3..959ce0dbe91d 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -107,7 +107,7 @@ static const unsigned long long sdwc_dbc_period[] = {
 	0, 3, 32, 512, 4096, 32768,
 };
 
-static void __init at91_wakeup_status(struct platform_device *pdev)
+static void at91_wakeup_status(struct platform_device *pdev)
 {
 	struct shdwc *shdw = platform_get_drvdata(pdev);
 	const struct reg_config *rcfg = shdw->rcfg;
-- 
2.39.2


