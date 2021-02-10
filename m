Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58EE316C7D
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 18:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbhBJRW7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 12:22:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232439AbhBJRWy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Feb 2021 12:22:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D92164E7E;
        Wed, 10 Feb 2021 17:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612977734;
        bh=yw2XyAm2K8/xWuBIJ2NtL5vuJXnjpYH9iI0vb12aEP4=;
        h=From:To:Subject:Date:From;
        b=hahi1dY52NsLU0n4Hwlf18PcYZpDjPLLMrrccA24xF46GL6/cG5f8D3Q7r3sBhMzG
         JiGfIYyJrd9fm5zUAWrninlaPHKGsLVBkArpKHK4bN6StulOlNEkFP+eh1hosda7Ug
         f7bJ0Ca6vLQMfCLaUK8yurDuNLkP36uFW8YGjoLlKA66wEWFGaaAmf58uRvO14qmnj
         3LKfoUHuGApByQTpUNRYz4H8A4eigI6lNI77YlD6Pz4SkgJDYgzsOy9fzKzjjUyKxS
         +LfYVzEBtletd1SlMKC3Mm/EplKZzBDFkyeKKgIHMtJDtDsAPeJuTsQ8mB+M1nIaAe
         nYhg3Uw0z6gDw==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: cpuidle: exynos: include header in file pattern
Date:   Wed, 10 Feb 2021 18:22:08 +0100
Message-Id: <20210210172208.335048-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Inclue the platform data header in Exynos cpuidle maintainer entry.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 674f42375acf..68e2b4cb4788 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4625,6 +4625,7 @@ L:	linux-samsung-soc@vger.kernel.org
 S:	Supported
 F:	arch/arm/mach-exynos/pm.c
 F:	drivers/cpuidle/cpuidle-exynos.c
+F:	include/linux/platform_data/cpuidle-exynos.h
 
 CPUIDLE DRIVER - ARM PSCI
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
-- 
2.25.1

