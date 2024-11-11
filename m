Return-Path: <linux-pm+bounces-17314-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD379C3C59
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 11:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 509BBB23242
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 10:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0721418FC7F;
	Mon, 11 Nov 2024 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZO3qRIPs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D261E18E02D;
	Mon, 11 Nov 2024 10:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321862; cv=none; b=QG0RkX2chy5BsGbdTplf9hH5HM0v5NgZWeNPeqJa8vLCBkJtJgdHpkib2l7ljv7y8WA0Typyp/7dwrqEkXrrbNLlmXgKwWw4hGbfJ+4iRC2dj4Xrr/lTil5dHuZMujHhe67d0SM7OYOzHmreocoF7DLyDrXlyjW+/FcX7johFVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321862; c=relaxed/simple;
	bh=UNAkQsusNu10Vwo0OUbVt++lg6CHME8v43MrIwnZlTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TFtgSrrfU1WEKJhEl6K6gkLBnI0Y8GdVvtRSQgqApBVTFNJPYoEvwKQzVLsCbh9eksXVrzgEV9ETXqWJvroqjgrD1LLAGZJpsPZNIDFSF5pqObxkf5xCe8rIBK6sD8mVSDzqtXj9G81cQgfc79jSEQi0frgOhjQLABN2py4kGQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZO3qRIPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9885C4CECF;
	Mon, 11 Nov 2024 10:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731321862;
	bh=UNAkQsusNu10Vwo0OUbVt++lg6CHME8v43MrIwnZlTo=;
	h=From:To:Cc:Subject:Date:From;
	b=ZO3qRIPs76kBRNqHwzE+p0UBqAs88aEDaOSLnaWYfs6hPlS4G820126Uu/lebMKAr
	 slR1u669pk8qKzBesrTcrQ2dodRThhcH/4N+/ybsL2z5P6dbUnIwZEGlEm4kSoeLIh
	 IF8CkuLn/WmL/qOu9LprBBI32ZQdkf5cd3PA7K8U7xiIFMF1b9OQ5U90cPIxLqde6R
	 vFClelw8rDRIinQOZCBMbagmh7KaryuM0vjfAeCCQaIxtJOEURGFERDCG+BqSmr2i9
	 pZh7uktuFXIRAwpGFZRIyVnaTIF+xt7nCQfeGbIz6qUlEr9oAbjYJampY6ux7X+epo
	 0b62YbTiOxOFg==
From: Arnd Bergmann <arnd@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Vinod Koul <vkoul@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: soc@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] reset: ep93xx: add AUXILIARY_BUS dependency
Date: Mon, 11 Nov 2024 11:44:12 +0100
Message-Id: <20241111104418.3891756-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This fails to link when compile-testing and the auxiliary bus is not built-in:

x86_64-linux-ld: drivers/power/reset/ep93xx-restart.o: in function `ep93xx_reboot_driver_init':
ep93xx-restart.c:(.init.text+0x11): undefined reference to `__auxiliary_driver_register'
x86_64-linux-ld: drivers/power/reset/ep93xx-restart.o: in function `ep93xx_reboot_driver_exit':
ep93xx-restart.c:(.exit.text+0x8): undefined reference to `auxiliary_driver_unregister'

Add the appropriate dependency.

Fixes: 9fa7cdb4368f ("power: reset: Add a driver for the ep93xx reset")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/reset/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 389d5a193e5d..f5fc33a8bf44 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -79,6 +79,7 @@ config POWER_RESET_EP93XX
 	bool "Cirrus EP93XX reset driver" if COMPILE_TEST
 	depends on MFD_SYSCON
 	default ARCH_EP93XX
+	select AUXILIARY_BUS
 	help
 	  This driver provides restart support for Cirrus EP93XX SoC.
 
-- 
2.39.5


