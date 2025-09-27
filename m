Return-Path: <linux-pm+bounces-35509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E481BA63C6
	for <lists+linux-pm@lfdr.de>; Sun, 28 Sep 2025 00:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0863BC620
	for <lists+linux-pm@lfdr.de>; Sat, 27 Sep 2025 22:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8AA231A41;
	Sat, 27 Sep 2025 22:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="FYreAEkb"
X-Original-To: linux-pm@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450171DE3DC;
	Sat, 27 Sep 2025 22:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759010932; cv=none; b=oULTvzTBZw6dLDGVo6yZzeELRSC1KJrpZ28veEh2Q6JmG2wDpVKffGEgpoHypKm2Py1Lsvzpf5zvwjPh4gnPRus22q3dwU/MMJK4E48/XoruHn0Vof9f/j1X0xzRDxIaztA3UTJRxuHNzq2+EyEP5g7MMb8RDNCdNdZqAwtTZIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759010932; c=relaxed/simple;
	bh=3VPIamEQ7+dCMLsSCg6E3HEi41Jad/I+T3BQleJVmEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lIIn3We7Bypj2kB5MDMU2wcFL+mk3fEsGtQHI6l1sNNyEMfylX7CONRl3O+7GSbrol/XdFQPOdN6HhnKTNggbYhTR2X7Q1WTcDYEwFVb9zjfAY8hFP75idtAmLv0QZTz123tIkSPI1Tv9j1Lu36Zu8FbIslb1cMTGM7Hf55D2bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=FYreAEkb; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
	Content-Description:In-Reply-To:References:X-Debbugs-Cc;
	bh=84aM7CktnZL1OAlY+LiDjqwMzwvEjNLoxkt5Qla/7JE=; b=FYreAEkbXqbsAmdNRnjvQGLSnS
	kXMXYbCntqdV3Gf8qpiTxeNL5GgE6CJkZ97Pq7ZUq4QXW8Qs3xcAJ2aVARr2qAaKNsO40S0aRGoNX
	2K1agCVcSpRo+fIzsnFBL4XtdsbRIbAJKh4MnxqBseYRh2YIn+usWK0SYddXRdmb7eEsT6RNDYEuV
	Zu8IakpicCJDVqx3qTq13MN2QKM9suP8EbRTW29tJMvIsYrXPyjpD3Zb4TD/tLtb7gJLSwACzRtta
	CgMuF79Bbsyb826QHZUQVdOyXqOB4Rvqsjoav7wUtY6IJudyo+sq1jH5PdC3TpLjRxDl+Dp0Lbsaw
	h3mSt4zg==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v2d5n-000QX4-2k;
	Sun, 28 Sep 2025 00:08:35 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	linux-pm@vger.kernel.org (open list:SYSTEM RESET/SHUTDOWN DRIVERS),
	linux-riscv@lists.infradead.org (open list:RISC-V SPACEMIT SoC Support),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support)
Subject: driver: reset: spacemit-p1: add driver for poweroff/reboot
Date: Sun, 28 Sep 2025 00:07:39 +0200
Message-ID: <20250927220824.1267318-1-aurelien@aurel32.net>
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

Note: For reliable operation, this driver depends on a separate patch series
that adds atomic transfer support to the SpacemiT I2C controller driver:
https://lore.kernel.org/spacemit/48B175EBF0F1A347+aNXwqlO1mD-7BGtE@kernel.org/T/#t
The two fixes mentioned there are also required:
https://lore.kernel.org/spacemit/aNbDkn9AC4FFx-Zc@aurel32.net/

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


