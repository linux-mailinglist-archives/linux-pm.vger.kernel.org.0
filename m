Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFAB7D2ECD
	for <lists+linux-pm@lfdr.de>; Mon, 23 Oct 2023 11:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjJWJrF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Oct 2023 05:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJWJrD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Oct 2023 05:47:03 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7093FB7
        for <linux-pm@vger.kernel.org>; Mon, 23 Oct 2023 02:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1698054421; x=1729590421;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pDN7cjyuhC4KbEWzZs3ty6YdAnoADR3pLZ0LPxNT6ME=;
  b=ArRCgfoanOfjrBv7TwpsxIPYSSQVu7kge9sh9mLbrWKInOTy0HK6Tl2q
   bPGu5GXmaEqkLZAUyZnBTMhuo5qVKu8YLHFoaJocbTI9y/cX26gJYtnnz
   0yqaTfA1vCbo2tYGkLZA2a/UXKDXOdJc98+ijLfND1lpGJ5IF5OmG70Ek
   svk2PjrtS7e64ZYPkiFHF5SkgHVl2XTEp7FT9Y1p/k/LiQt7Tk6rdsLU6
   9EzoPymYH7gG6A3pm+tRrH5fdY/x4jhp9slmOzE3yZjytFhFjjus1QQNN
   X2lIQvtqlyOFakYGfX3+pqpHcuu0V0K1Fep3evUPHgIVyVhyRgW5Ezfjt
   g==;
X-IronPort-AV: E=Sophos;i="6.03,244,1694728800"; 
   d="scan'208";a="33597613"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Oct 2023 11:46:59 +0200
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 6B3D528007F;
        Mon, 23 Oct 2023 11:46:59 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/1] cpufreq: arm: Kconfig: Add i.MX7 to supported SoC for ARM_IMX_CPUFREQ_DT
Date:   Mon, 23 Oct 2023 11:47:01 +0200
Message-Id: <20231023094701.374791-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since commit a5a9dffcc903 ("ARM: imx: Switch imx7d to imx-cpufreq-dt
for speed-grading") i.MX7 uses this driver as well. Add it to the
description text.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/cpufreq/Kconfig.arm | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 207618043ee0..f911606897b8 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -124,8 +124,8 @@ config ARM_IMX_CPUFREQ_DT
 	tristate "Freescale i.MX8M cpufreq support"
 	depends on ARCH_MXC && CPUFREQ_DT
 	help
-	  This adds cpufreq driver support for Freescale i.MX8M series SoCs,
-	  based on cpufreq-dt.
+	  This adds cpufreq driver support for Freescale i.MX7/i.MX8M
+	  series SoCs, based on cpufreq-dt.
 
 	  If in doubt, say N.
 
-- 
2.34.1

