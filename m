Return-Path: <linux-pm+bounces-37263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB271C29958
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 00:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8A53A3FF8
	for <lists+linux-pm@lfdr.de>; Sun,  2 Nov 2025 23:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC733241664;
	Sun,  2 Nov 2025 23:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="th/uZL9g"
X-Original-To: linux-pm@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC5A2F5E;
	Sun,  2 Nov 2025 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762124657; cv=none; b=HTrpYxTcETDvRC6njBiT8OMQDapEVz1SmYpmTUJBU0h/TqIIDDHvBGxaaf15roq+7+dL+hvuVCiFdimnfejZu8Av+Yh8fn7uCGbsmjDM4w93Uc0vJp2PPPMmg23VDdQsZrsk4qg7XNSc1ZQlu4E/ThMpqnpVZ5a1YOUsvDb3CX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762124657; c=relaxed/simple;
	bh=5290Ho6vbge4q/aqDYKoOIh6MSojfK8wUvfYaL8M2yE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cXltgDtbHhFGOoDHpd4ZAY4whlbc7BpqhBQKmWdHKo9GxOkgkzVTg0JnJG0KiMGLs9TTfeJ2ZRDCnCOQCvC2PFcc1t05uZ+iv7dR/URx/oQTQBTM48wawLbiGvvNx6FFmFSuNG0jIjVYqP+Dqklvs3zoC6fvMRBl1ltuKmHr3Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=th/uZL9g; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
	Content-Description:In-Reply-To:References:X-Debbugs-Cc;
	bh=0rN/IbAVtI1MLMhGfl/KVAMt/bd2mDCGlXcVuloPPUE=; b=th/uZL9g4MyQj/WGDr2kXpBCFj
	gVPV+kDCjHo5toWCTtppAGC3rB6NfBewBlFy0In4OzgfDtEbk85tdeqHiWp4IrTmKYB/dfIRWWyId
	hHnv5E2sVeCRGvlulFKegtBjAd5OMz0HFeaUx3U0f/Iy3ee3+nEoSUCGMK5JwjtbRi03TGZD3KjKD
	2nSsHGgQw1L2UN8kGy4j/4O6OkrXK9rbxLW0QV1uZ9MsXr1PhhZM7CHqvlAGPXZzE75+zbSMzwyI0
	rvyakE4e4b+yGuukmjVO1u4Sqny7Gn7Dmu6tERHQ5MYUPX8ySEtP9nhFoHY00tu6pHsZzdhWghF4J
	XCYWaRYA==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1vFh7A-00000006eMG-0JNf;
	Mon, 03 Nov 2025 00:04:00 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE:Keyword:riscv),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit)
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	linux-pm@vger.kernel.org (open list:SYSTEM RESET/SHUTDOWN DRIVERS),
	linux-riscv@lists.infradead.org (open list:RISC-V SPACEMIT SoC Support),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support)
Subject: [PATCH v5 0/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
Date: Mon,  3 Nov 2025 00:01:58 +0100
Message-ID: <20251102230352.914421-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds poweroff/reboot support for the SpacemiT P1 PMIC chip, which is
commonly paired with the SpacemiT K1 SoC.

Note: For reliable operation, this driver depends on a this patch that adds
atomic transfer support to the SpacemiT I2C controller driver:
  https://lore.kernel.org/spacemit/20251009-k1-i2c-atomic-v4-1-a89367870286@linux.spacemit.com/

Changes between version 4 and version 5:
- Change default to "MFD_SPACEMIT_P1"

Here is version 4 of this series:
  https://lore.kernel.org/spacemit/20251026224424.1891541-1-aurelien@aurel32.net/

Changes between version 3 and version 4:
- Replace the "select" by a "depends on"
- Remove outdated Reviewed-by

Here is version 3 of this series:
  https://lore.kernel.org/spacemit/20251021201451.1013640-1-aurelien@aurel32.net/

Changes between version 2 and version 3:
- Allow building as a module
- Remove outdated Acked-by and Tested-by
- Collect Reviewed-by

Here is version 2 of this series:
  https://lore.kernel.org/spacemit/20251019191519.3898095-1-aurelien@aurel32.net/

Changes between version 1 and version 2:
- Rebase onto v6.18-rc1
- Use dev_err_probe() to simplify the code
- Fix indentation of patch 1
- Collect Acked-by and Tested-by                                                                                                                                                                                                                                                                                                     
Here is version 1 of this series:
  https://lore.kernel.org/spacemit/20250927220824.1267318-1-aurelien@aurel32.net/ 


Aurelien Jarno (2):
  driver: reset: spacemit-p1: add driver for poweroff/reboot
  mfd: simple-mfd-i2c: add a reboot cell for the SpacemiT P1 chip

 drivers/mfd/simple-mfd-i2c.c             |  1 +
 drivers/power/reset/Kconfig              |  9 +++
 drivers/power/reset/Makefile             |  1 +
 drivers/power/reset/spacemit-p1-reboot.c | 88 ++++++++++++++++++++++++
 4 files changed, 99 insertions(+)
 create mode 100644 drivers/power/reset/spacemit-p1-reboot.c

-- 
2.47.2


