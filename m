Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3182BE776
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 23:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfIYVfa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 17:35:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727683AbfIYVfa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Sep 2019 17:35:30 -0400
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net [71.197.186.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83E3A21D82;
        Wed, 25 Sep 2019 21:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569447329;
        bh=qm/TdfonbBzBB/AEHmYGEpSlc7ICBztPIwTfuRqbwv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h/y8cEL15FyXJTSLNSZSc+k2fzrMcA62zUDP0csgm/5a/oHeq7hjHdO3+TE3RC6st
         W0uleeTy6Jz39AWP6uZQlF8WwahXXnzNjcv89jO03sDOcmtDn15/oUMF/iZWaTM+Gn
         F/uJ1kwkcR8hqxdOs6ZKMUQaCbUeagY49RY0o+Yo=
From:   Kevin Hilman <khilman@kernel.org>
To:     linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 2/2] soc: amlogic: ee-pwrc: ensure driver state maches HW state
Date:   Wed, 25 Sep 2019 14:35:28 -0700
Message-Id: <20190925213528.21515-3-khilman@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190925213528.21515-1-khilman@kernel.org>
References: <20190925213528.21515-1-khilman@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Kevin Hilman <khilman@baylibre.com>

During init, ensure that the driver on/off state as well as clock and
reset state matches the hardware state.  Do this by always calling the
drivers 'on' function, and then callling the 'off' function if the
HW state was initially detected as off.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/soc/amlogic/meson-ee-pwrc.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
index dcce8e694a07..2e8eee0dc166 100644
--- a/drivers/soc/amlogic/meson-ee-pwrc.c
+++ b/drivers/soc/amlogic/meson-ee-pwrc.c
@@ -323,6 +323,8 @@ static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
 				     struct meson_ee_pwrc *pwrc,
 				     struct meson_ee_pwrc_domain *dom)
 {
+	bool is_off;
+
 	dom->pwrc = pwrc;
 	dom->num_rstc = dom->desc.reset_names_count;
 	dom->num_clks = dom->desc.clk_names_count;
@@ -356,27 +358,12 @@ static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
 	dom->base.power_on = meson_ee_pwrc_on;
 	dom->base.power_off = meson_ee_pwrc_off;
 
-	/*
-         * TOFIX: This is a special case for the VPU power domain, which can
-	 * be enabled previously by the bootloader. In this case the VPU
-         * pipeline may be functional but no driver maybe never attach
-         * to this power domain, and if the domain is disabled it could
-         * cause system errors. This is why the pm_domain_always_on_gov
-         * is used here.
-         * For the same reason, the clocks should be enabled in case
-         * we need to power the domain off, otherwise the internal clocks
-         * prepare/enable counters won't be in sync.
-         */
-	if (dom->num_clks && dom->desc.is_off && !dom->desc.is_off(dom)) {
-		int ret = clk_bulk_prepare_enable(dom->num_clks, dom->clks);
-		if (ret)
-			return ret;
-
-		pm_genpd_init(&dom->base, &pm_domain_always_on_gov, false);
-	} else
-		pm_genpd_init(&dom->base, NULL,
-			      (dom->desc.is_off ?
-			       dom->desc.is_off(dom) : true));
+	/* Ensure that driver state matches HW state */
+	is_off = dom->desc.is_off ? dom->desc.is_off(dom) : true;
+	meson_ee_pwrc_on(&dom->base);
+	if (is_off)
+		meson_ee_pwrc_off(&dom->base);
+	pm_genpd_init(&dom->base, NULL, is_off);
 
 	return 0;
 }
-- 
2.22.0

