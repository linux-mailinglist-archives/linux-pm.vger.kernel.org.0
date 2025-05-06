Return-Path: <linux-pm+bounces-26737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7286AAC50A
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 15:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442DB4C7E50
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 13:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC1A28001A;
	Tue,  6 May 2025 13:01:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC3820A5F2
	for <linux-pm@vger.kernel.org>; Tue,  6 May 2025 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536494; cv=none; b=CcABT3TfwxiJWSNR9DrecLBnPyL7lx7TmuGmcz+61+ZK9UdeVICJqUsCyUCFiuTEMi4UnJeSBIbHBFmoigtm5XeLXYcYW1SXSvDAOIQtWmaPjV9SV925wttvU747HRqHQ0UhhXrtzxKAzRur9wbtp140IR/yfOz8iyzAG9naCJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536494; c=relaxed/simple;
	bh=gI82l2lyS97cu92CLGX7rCCyZCYRyH0fZELOEUQnMVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4rNeK3ACcg7wCipnCS1ImgzsHTKL6iaKTCadLXIecgUlLZss2nUKOL+pOmSpZtFlG4N+eDwrSLwec0AVlCgeZ9D85ZMIarvaRntKjEDrL8IwvDE3Gb/YLoQ3v8nkZK/9RboOBT4iw/CRySt/aktKF37LY9xRs2yMOM0zPS1DFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:ed69:3ad8:f2dc:ba56])
	by albert.telenet-ops.be with cmsmtp
	id lp1V2E00D2coBU206p1VoF; Tue, 06 May 2025 15:01:29 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uCHvH-00000000qoa-0jW9;
	Tue, 06 May 2025 15:01:29 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uCHvN-00000001daA-0iP8;
	Tue, 06 May 2025 15:01:29 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Sebastian Reichel <sre@kernel.org>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] power: reset: POWER_RESET_TORADEX_EC should depend on ARCH_MXC
Date: Tue,  6 May 2025 15:01:27 +0200
Message-ID: <1ef0beb1e09bf914650f9f9885a33af06772540d.1746536287.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Toradex Embedded Controller is currently only present on Toradex
SMARC iMX8MP and iMX95 SoMs.  Hence add a dependency on ARCH_MXC, to
prevent asking the user about this driver when configuring a kernel
without NXP i.MX SoC family support.

Fixes: 18672fe12367ed44 ("power: reset: add Toradex Embedded Controller")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/power/reset/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 5ce402ff71964f59..1a17c5192818de1e 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -218,6 +218,7 @@ config POWER_RESET_ST
 
 config POWER_RESET_TORADEX_EC
 	tristate "Toradex Embedded Controller power-off and reset driver"
+	depends on ARCH_MXC || COMPILE_TEST
 	depends on I2C
 	select REGMAP_I2C
 	help
-- 
2.43.0


