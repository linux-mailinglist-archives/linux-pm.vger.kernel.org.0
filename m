Return-Path: <linux-pm+bounces-36436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E664BEEBAA
	for <lists+linux-pm@lfdr.de>; Sun, 19 Oct 2025 21:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 50445348C78
	for <lists+linux-pm@lfdr.de>; Sun, 19 Oct 2025 19:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED432EC0BB;
	Sun, 19 Oct 2025 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="RhsehRKl"
X-Original-To: linux-pm@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307401B425C;
	Sun, 19 Oct 2025 19:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760901361; cv=none; b=cB12UseRl/ik4MC9w538s8ybWKbAqe0w+mMn6xK/4XlhMozVQddEVkSRqEu/8qY4AsegRK/OZ2KiONSr10QPhNw7ooDJXQjBomsLFM3CbiAuC6eHmaYzUboMp4rDaJYEc388Qg+c0TVx+FnTz16CZ0chIz87ymMAxYD8qsi/t2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760901361; c=relaxed/simple;
	bh=TqDxpYUV3qWZXi+1mZpJv6NxjhlvhAHz5cY7zHP7bZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jVNEcSwX5qY8WpLCzNF/6TbCfUP+SU1hCEWWm6EJCoYKlhWdroM4pNB6DtYzdrHVAEmOk7gFslNlBKx4BHniyFghXiRbufUELPbQskGsBg3GVaY+adEAVB+SqLTbREaLXzzWpLTfNwEwti/qxxpZl0uJhd7eZLql3XEs8tv4ZuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=RhsehRKl; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
	Content-Description:In-Reply-To:References:X-Debbugs-Cc;
	bh=Rxhmdd8gp8A7Gb+pYCJhHhx5Sl0gdKNrP/+9/ZJldls=; b=RhsehRKliNXkvmY+pzSXAAZhNr
	Uhgu9UnxFr7auNNbebHxtH62y8F7pT5BN18VWJRxN1lZF/GceWfQKE1AjzpabNtYN4plYlgEXjDj/
	O1h1MUkf6ehL68nKoEK5ZpF+10Zqxee6lE32EUE+IzTGK5U01O8gPNQ2XyYCtVoZHDOO2/TpiZ1AU
	bwAW66gFrQJM441Fulwv7m3DBKMUqOpTopEMgRNjF7HWODu5/XLCLnhJ6z+s1IW2Bf3cBW5wgohhP
	Eqp+ZF5D1ql3mS7YIUwmd9D2XdOT30zMiW2JYyd8DAB4xN04s07xNwxTj16KMBGsd0IkXIwcTafNE
	kwXpKPWg==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1vAYsK-00DYBe-1U;
	Sun, 19 Oct 2025 21:15:28 +0200
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
Subject: [PATCH v2 0/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
Date: Sun, 19 Oct 2025 21:14:11 +0200
Message-ID: <20251019191519.3898095-1-aurelien@aurel32.net>
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


