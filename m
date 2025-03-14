Return-Path: <linux-pm+bounces-24067-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC5FA6153F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 16:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E35D47A9569
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 15:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7595201261;
	Fri, 14 Mar 2025 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtGXbqpY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE677201025;
	Fri, 14 Mar 2025 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967319; cv=none; b=MgUPc1dNPxjwFp2vwcFFJhEyfDjciao8oXnnXcJkM7598VU3/IuENPw9XB0uhNWvKRFlliFeyinIbYC5JaThzSKXmj6JBwRGoV3/enHAI8Cawk6oHyI3kNaDWRiWyW/BJRQvvY1gSOnV6vmkFIei0iAkuAwWSNwEC7HkZpdAD8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967319; c=relaxed/simple;
	bh=cjpKAPzkSfWP+V9JdaT/PCmkXC4+EeuFVF3S8kTC2Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sAYlKw/OdqHOxWknpYWupJ+bHgwMT/OeIVfKp89VLy1Mu+618rsNsdg4FzFziC308XgGU6ClYRN6dCF8Tv6jnAr+DeT1XYHl4zV+nYe9mN5lz8/D6CthqUmWhK3NCKfKEvafbsQPG46QuJYrZRFImeIPsq0ly8eYa2rGvQe9nTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtGXbqpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FA4C4CEE9;
	Fri, 14 Mar 2025 15:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741967319;
	bh=cjpKAPzkSfWP+V9JdaT/PCmkXC4+EeuFVF3S8kTC2Qs=;
	h=From:To:Cc:Subject:Date:From;
	b=GtGXbqpY5BeWics6m+RWZJbYCR1wFIrt7oHarMgmwvg713Q9cRdMVUZU0NF5pWnkI
	 Kd+U0SvkPHsv/sFHf2bMDjvPD68+kUwTjrvCoc12eUr0JqDvpm4OK0YVd37LmrIWUk
	 bsqak4qqKSMvf60xugBP+xeCBBCNG6KWlQ+ocBI21MbHxraq2NdZ+G9ue/Wrb76sZO
	 JJwHYkTbBeZq4Je19TNzRT2b7QoNaW1HkCbY+e0wk73hahOz6noL65/Im+TDs+zoVZ
	 P9ar+P90I4ze3irZtsX4LLKgkXQkC6exx4/bRwnvCh4Vq4OK/iEeGpmi3I6f/G7FDc
	 P8ZIGAi221GLA==
From: Arnd Bergmann <arnd@kernel.org>
To: Drew Fustini <drew@pdp7.com>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pmdomain: thead: fix TH1520_AON_PROTOCOL dependency
Date: Fri, 14 Mar 2025 16:48:31 +0100
Message-Id: <20250314154834.4053416-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Kconfig treats the dependency as optional, but the header file only provides
normal declarations and no empty API stubs:

ld: fs/btrfs/extent_io.o: in function `writepage_delalloc':
extent_io.c:(.text+0x2b42): undefined reference to `__udivdi3'
ld: drivers/pmdomain/thead/th1520-pm-domains.o: in function `th1520_pd_power_off':
th1520-pm-domains.c:(.text+0x57): undefined reference to `th1520_aon_power_update'
ld: drivers/pmdomain/thead/th1520-pm-domains.o: in function `th1520_pd_power_on':
th1520-pm-domains.c:(.text+0x8a): undefined reference to `th1520_aon_power_update'
ld: drivers/pmdomain/thead/th1520-pm-domains.o: in function `th1520_pd_probe':
th1520-pm-domains.c:(.text+0xb8): undefined reference to `th1520_aon_init'
ld: th1520-pm-domains.c:(.text+0x1c6): undefined reference to `th1520_aon_power_update'

Since the firmware code can easily be enabled for compile testing, there
is no need to add stubs either, so just make it a hard dependency.

Fixes: dc9a897dbb03 ("pmdomain: thead: Add power-domain driver for TH1520")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pmdomain/thead/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/thead/Kconfig b/drivers/pmdomain/thead/Kconfig
index c7a1ac0c61dc..7d52f8374b07 100644
--- a/drivers/pmdomain/thead/Kconfig
+++ b/drivers/pmdomain/thead/Kconfig
@@ -2,7 +2,7 @@
 
 config TH1520_PM_DOMAINS
 	tristate "Support TH1520 Power Domains"
-	depends on TH1520_AON_PROTOCOL || !TH1520_AON_PROTOCOL
+	depends on TH1520_AON_PROTOCOL
 	select REGMAP_MMIO
 	help
 	  This driver enables power domain management for the T-HEAD
-- 
2.39.5


