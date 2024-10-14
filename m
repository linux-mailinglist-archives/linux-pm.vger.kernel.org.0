Return-Path: <linux-pm+bounces-15591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6F699BEB4
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 06:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4531C24DF3
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 04:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C537219CC09;
	Mon, 14 Oct 2024 03:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+hmAnaC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB8119C554;
	Mon, 14 Oct 2024 03:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878318; cv=none; b=tZbyER4GRoWPlnmonsDwTRuEJ2VmFce/xd8EKbfyAPoR6uRaF4zPAGuLzLT6pS+hXByXq27nYWE35OTmkGmvFUQEwR4zfdbGrBH8H2l8M9c8WZvBof6AcQiE1fiiLkRGonCCe3S9hb5puCG/r5mjvB9hE2As5t0PHv7QjiAKIkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878318; c=relaxed/simple;
	bh=f6rkpD041JJonq8wxFnPnvnEcwtd7NFQuWlDYLhj6B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNKCeGymkCBUBodZUcW2mU6t1raX+5ZvTe5YcdlBQ0stmAgClPttRuObD2MUc0QKKQEqr5GsUwAf/MHVKtJaOyonmjEB9XGPFUXeI/rutXb0NBWptg9/8xaHxLUDDCmBRkgPFN3+rS7IyrWGmSTLugWRiaXyZDB2mlwtg5avt8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+hmAnaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F040C4CEC3;
	Mon, 14 Oct 2024 03:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878318;
	bh=f6rkpD041JJonq8wxFnPnvnEcwtd7NFQuWlDYLhj6B8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l+hmAnaCTRtw0IFufdrX46q6pdMKRQGc7hQo1+oLLaEzpO6BwFxpD/Lg+ZrXrHP0I
	 PjyVIkNfVljM/889+BosjvgUp9G2TIMywnPhpBYRuDX1oyj5K9MCVOIPqEOTDJmuJo
	 zk0erD54PfE5d0pr4PTLJAwHsgVnDH5WDWi2vGh9bprBGLdsDu5px0wH9MQgt9hJth
	 3U+kjMyvoKlcRQz4xDGVN1DQl5OFP2YT1RaCQpBKGai+QRIAnQvwQRz7C1ktMB38ol
	 gDCJhY3vraYYxdnr3sbqkCgRsnmscpsEW1adR5Qt9cHotDMZ9qpwIvKC+xwUCTegsZ
	 Uf0ZNv+1xNkQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	andriy.shevchenko@linux.intel.com,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 14/17] thermal: intel: int340x: processor: Add MMIO RAPL PL4 support
Date: Sun, 13 Oct 2024 23:58:04 -0400
Message-ID: <20241014035815.2247153-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035815.2247153-1-sashal@kernel.org>
References: <20241014035815.2247153-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit 3fb0eea8a1c4be5884e0731ea76cbd3ce126e1f3 ]

Similar to the MSR RAPL interface, MMIO RAPL supports PL4 too, so add
MMIO RAPL PL4d support to the processor_thermal driver.

As a result, the powercap sysfs for MMIO RAPL will show a new "peak
power" constraint.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20240930081801.28502-7-rui.zhang@intel.com
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../thermal/intel/int340x_thermal/processor_thermal_rapl.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
index f7ab1f47ca7a6..f504781f4b7c5 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
@@ -13,9 +13,9 @@ static struct rapl_if_priv rapl_mmio_priv;
 
 static const struct rapl_mmio_regs rapl_mmio_default = {
 	.reg_unit = 0x5938,
-	.regs[RAPL_DOMAIN_PACKAGE] = { 0x59a0, 0x593c, 0x58f0, 0, 0x5930},
+	.regs[RAPL_DOMAIN_PACKAGE] = { 0x59a0, 0x593c, 0x58f0, 0, 0x5930, 0x59b0},
 	.regs[RAPL_DOMAIN_DRAM] = { 0x58e0, 0x58e8, 0x58ec, 0, 0},
-	.limits[RAPL_DOMAIN_PACKAGE] = BIT(POWER_LIMIT2),
+	.limits[RAPL_DOMAIN_PACKAGE] = BIT(POWER_LIMIT2) | BIT(POWER_LIMIT4),
 	.limits[RAPL_DOMAIN_DRAM] = BIT(POWER_LIMIT2),
 };
 
-- 
2.43.0


