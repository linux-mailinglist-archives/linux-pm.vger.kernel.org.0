Return-Path: <linux-pm+bounces-23368-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7630BA4E0FA
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7591A17BB60
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 14:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EB420C48B;
	Tue,  4 Mar 2025 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkIFqbWy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBFC2063F8;
	Tue,  4 Mar 2025 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098489; cv=none; b=lUO59l53MNLNKR4CQTSkPPelns/CbApuA0f0PoIt1c1QWYJg6ckZKlB8BnIcWq6pE1MZxqVjQkPlmQTCeE/KEAXR9StPZgqEv55250h11B2bFgYtxDoxtsv60RA0PUnmFTTNtyI484sRk4uOgcRAgn65YcDkwE/aXA3jCvD3HMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098489; c=relaxed/simple;
	bh=ZP9crCiLqCC27DzizkJ4ARDSaafzhltXkaVGhTSqjQo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gOsUWluXiJ5I95uGHM3LsuvtMKKFybKWGMOmptfPrzWPGD2GUU/apzG50eM8zZFy49VBkfsW26vEzRSthZSD9g3YbPqALRPNpVJRqybAYRYk80Gn5MHrC8q7B08fqYtiYqpZ5nZbEl+XY/DN26wLZ2mo+LZOiG+RBNHjqv+8Ias=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkIFqbWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5963FC4CEE5;
	Tue,  4 Mar 2025 14:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741098489;
	bh=ZP9crCiLqCC27DzizkJ4ARDSaafzhltXkaVGhTSqjQo=;
	h=From:To:Cc:Subject:Date:From;
	b=DkIFqbWyusoB3FRblukNCbV0zy+rX7iyW6CGrDHjAiXe26bjUf9x3qJEp65/jMEr2
	 lRljmarzXCrwNqcu+7+QIXQ9Gb/7LaB0Bi0PzW9ouEW7JPcLPZHwYU1XoY+rlc9BBD
	 ImJemoPKOPp0yacfnA0KGQ5VQEmzGzl2b+s9VlLyhbq5sQLjLUd9SWkIcmFaLt6ERq
	 MCekeJKnJK3TCA8z/pbK89ykMrUdjyVx2xtFi5d+gDTXSy1cAVCuiI4pT6V2WWco4M
	 QRG/z/YOSYUtmc/7WE1acWpfEPX6KRU2lLRQjvQ41OTgkDa4tPagvxR340Yb+Ao5Xh
	 LCitY7hmsr+uQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pmdomain: rockchip: add regulator dependency
Date: Tue,  4 Mar 2025 15:27:59 +0100
Message-Id: <20250304142803.689201-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_REGULATOR is disabled, this pmdomain driver fails to build:

drivers/pmdomain/rockchip/pm-domains.c:653:30: error: implicit declaration of function 'devm_of_regulator_get'; did you mean 'devm_regulator_get'? [-Wimplicit-function-declaration]
  653 |                 pd->supply = devm_of_regulator_get(pmu->dev, pd->node, "domain");
      |                              ^~~~~~~~~~~~~~~~~~~~~
      |                              devm_regulator_get
drivers/pmdomain/rockchip/pm-domains.c:653:28: error: assignment to 'struct regulator *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
  653 |                 pd->supply = devm_of_regulator_get(pmu->dev, pd->node, "domain");
      |                            ^

Add a Kconfig dependency.

Fixes: db6df2e3fc16 ("pmdomain: rockchip: add regulator support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pmdomain/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/rockchip/Kconfig b/drivers/pmdomain/rockchip/Kconfig
index 7e4f9b628f0b..218d43186e5b 100644
--- a/drivers/pmdomain/rockchip/Kconfig
+++ b/drivers/pmdomain/rockchip/Kconfig
@@ -5,6 +5,7 @@ config ROCKCHIP_PM_DOMAINS
 	bool "Rockchip generic power domain"
 	depends on PM
 	depends on HAVE_ARM_SMCCC_DISCOVERY
+	depends on REGULATOR
 	select PM_GENERIC_DOMAINS
 	help
 	  Say y here to enable power domain support.
-- 
2.39.5


