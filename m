Return-Path: <linux-pm+bounces-36605-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B47BCBF8AEB
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 22:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3BAAB3578F7
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 20:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2422749C9;
	Tue, 21 Oct 2025 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="D//A0xT2"
X-Original-To: linux-pm@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBFB1BFE00;
	Tue, 21 Oct 2025 20:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077732; cv=none; b=MNyNqYaj81xKbdYavDMO4q26NhKMKBHXI2sQWhyhOShxjRr1e7CUe4sTIs+jxseeGfo+fRAbCrJc7ResoH50ZczdwCckmoFzCTia4PrZoRyAhrHb+GyYvunU3qoa/YFLKWkZ3S0YmcAeM/WpXdyCQ55KJEE4W18Adh4GDgLiGWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077732; c=relaxed/simple;
	bh=s9/l+huTDqZios8gGzFIwaTW/OF6BAVSqOyIE0/qmjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cufl669meXOXYDr7hlFHV2cHnGZwsy4ZwyXgUwlWM2soKb32i2QEibJicdRwlzZ5mVknkF4GuNpZe1+I4XP3RfGmdX5vHDIlzJOa2TnN+jUi9rOFkJK5Ns4uAaslWhhvKFJ060yI5nBTDcxtM+pzoparR/+wwnFP2SwQaxaQj+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=D//A0xT2; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
	Content-Description:In-Reply-To:References:X-Debbugs-Cc;
	bh=iGv5cQ4tDQC4OnHLXP1B80nBSWV3CERfpohMOjbHNOQ=; b=D//A0xT2/1UIkf7F9CG+95nRRj
	EZmHdFcDtas3rfE5DBd/mL5Lp9Jt7runiyXKLTaXZwb71MN9vPDD7Kw73QNirxu9yqUT67X5Z6UPO
	S65iJJ2HGUH1Pa/S8l9JlaMMpaQ+YRLlu1mp1Jw8ByDOzjC1kJQD3uLSdUSB3AQ21NMb3j2Cq29rB
	GQ5PRInJp3W8aqI6twuyA+wrllqMtIZziOkRUvpNXVrmXczAJDpVTldd/SscFu4l4w+J69Fh/Hcwh
	z3AxbB+hyZccIeB7k65cW0dUN3hryHWbBbDvp8NjYvXg2lZa2GALv68Kgtnlg3vh4U2Fzz+kd1E7e
	noM65mxQ==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1vBIl7-00GWo7-1b;
	Tue, 21 Oct 2025 22:15:05 +0200
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
Subject: [PATCH v3 0/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
Date: Tue, 21 Oct 2025 22:11:58 +0200
Message-ID: <20251021201451.1013640-1-aurelien@aurel32.net>
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


