Return-Path: <linux-pm+bounces-15589-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C1D99BE8C
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 06:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9315EB23E86
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 04:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE6F155C82;
	Mon, 14 Oct 2024 03:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udrVIOnu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2913B287;
	Mon, 14 Oct 2024 03:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878280; cv=none; b=kgF7Vwga6ZHErUGdYvUdjfRwa/MAhK56Uu0FKQgRPsPOIdmBR59ZnHERyS9kNvSiK/T6lLv3BdSL9zjYlE1gU3vMI0bWVgHFCgXL1b+M35NyUoTSUh4HefUj/HxqN90NGnS58NWzCNOLyNBv2TV5JlXl6l602uR74YNhgvIwhwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878280; c=relaxed/simple;
	bh=75eMdPfFBZse2z7wYOUlPmrguTaItmzpVR+YPuGwHMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b07YTCDdH6GYlwCctZsAglLu66ee5l/YhFodvj/8SMxOMAwqH5bhJuyyAmx1hbJa2qmeaRyTGujzrAHt0pch6dFHOOjJ/moBpEHr/hDY8UBKHPqAM4oYrojzczF+iHtbj4Y7JUOQyLoBqWUHzyAUyjIjcLNly2ch3lmQHoXvESs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udrVIOnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E5DC4CECE;
	Mon, 14 Oct 2024 03:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878280;
	bh=75eMdPfFBZse2z7wYOUlPmrguTaItmzpVR+YPuGwHMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=udrVIOnurw9V2+B67EXBJ5JwUgwNA2kBhnqZ4qJZTclCECCTplk27v4sbo+mNUyj3
	 xRh171ZHxzsmYGCKB1drZTD2EYeSAi4bcNs979uU038t7I7cvwd4to4tnsP62Vj1DK
	 ylv1jI6W95acm9189yN0YEgJ6MrQks+uPxme22usHzQv+Z9Z8exZAM+9eEK4BeJqrf
	 czvxgPYjhsO32Uk3vZGOis5MxUhzlPO/v1S4H5dZ6rVw6/fUBDvk53gXUtckmsFUS0
	 iA5sZYzAaAFDYzCPN4RDzEQvb3RigaVNvtm7C+ngFuRw8c1IUepGcofcbJvQoFjQ5m
	 lC61vyH+Z+nFw==
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
Subject: [PATCH AUTOSEL 6.11 17/20] thermal: intel: int340x: processor: Add MMIO RAPL PL4 support
Date: Sun, 13 Oct 2024 23:57:19 -0400
Message-ID: <20241014035731.2246632-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035731.2246632-1-sashal@kernel.org>
References: <20241014035731.2246632-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
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
index 769510e748c0b..bde2cc386afdd 100644
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


