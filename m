Return-Path: <linux-pm+bounces-27425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB26ABE1A5
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 19:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1116D7A4F62
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5A427A927;
	Tue, 20 May 2025 17:10:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202512417F0
	for <linux-pm@vger.kernel.org>; Tue, 20 May 2025 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747761033; cv=none; b=C+RrfOvoXoIHxubrX1c+6FNCJjUt3NdUhdXB34vNnkU0RadU2zFE216Uggarl94vQUOZf+uGvT2gZNG2/wLIWf7kVC90ikIwbCOtaGkO2ZWoM6PDv3LCgyO2EK849Uh4v5Lsa6w6Tf0zJYKKCDRfKSuJfAgHBo4pS+w9iambn0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747761033; c=relaxed/simple;
	bh=YIqzOoRUGGfuk9Lt9bqcd9kcgdUuipK8Mknt89f53OY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gv4L1P0mIgpc7o5UGPpb/laCo8vEsIIi4o8yF8Fvz592Gk9qfifmK0IzzFSVwBJ4A4LHD42MXPOeICsZbL7EjlPezjZVi9gp5zR1iyRoWheF4dV+RLQ7Tlzfig7kJRMvPtoNpS9OJ/DKb+chdPH5K12EOxATZ2QTfsNAkaltAs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE58B152B;
	Tue, 20 May 2025 10:10:17 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 017173F5A1;
	Tue, 20 May 2025 10:10:29 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: ulf.hansson@linaro.org,
	heiko@sntech.de,
	mark.rutland@arm.com,
	lpieralisi@kernel.org,
	sudeep.holla@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] pmdomain: rockchip: Relax SMCCC dependency
Date: Tue, 20 May 2025 18:10:17 +0100
Message-Id: <6f0a38e596c0727d0de13a29c9224f71bc7d30f1.1747760015.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <ab0476382e3342161beda94a45ddadb49b026dcd.1747760015.git.robin.murphy@arm.com>
References: <ab0476382e3342161beda94a45ddadb49b026dcd.1747760015.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most 32-bit Rockchip platforms do not use PSCI, so having to select
ARM_PSCI to satisfy a dependency chain to retain working power domain
support is a bit weird and non-obvious. Now that the offending SMCCC API
is properly stubbed out for optional usage, we can relax this again.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/pmdomain/rockchip/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/Kconfig b/drivers/pmdomain/rockchip/Kconfig
index 218d43186e5b..ffe5e7b78494 100644
--- a/drivers/pmdomain/rockchip/Kconfig
+++ b/drivers/pmdomain/rockchip/Kconfig
@@ -4,7 +4,6 @@ if ARCH_ROCKCHIP || COMPILE_TEST
 config ROCKCHIP_PM_DOMAINS
 	bool "Rockchip generic power domain"
 	depends on PM
-	depends on HAVE_ARM_SMCCC_DISCOVERY
 	depends on REGULATOR
 	select PM_GENERIC_DOMAINS
 	help
-- 
2.39.2.101.g768bb238c484.dirty


