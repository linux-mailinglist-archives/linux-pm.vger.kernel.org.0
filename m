Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E9F35823E
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 13:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhDHLnT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 07:43:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230412AbhDHLnS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Apr 2021 07:43:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7059A61154;
        Thu,  8 Apr 2021 11:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617882187;
        bh=UbGXmoXHD1iCUNpX0pqSPxyqGd46kDsL5oYWgRsgpI8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FOkhcSsYqiSFcIN/pHMuHKNgqyBsaadv0iCWKY+b0C2ZomShhnMRAYYCS8r3dSzia
         mqeSuT2j7RvBjUpZ//4P/+D5gdzx9C+3EAx/UTWgriBmZMkGuybpIjYxfOgL2DbLUY
         5F6lVQPg5bob4YsB2ZyV81hOS/rieEhlYKZ9AL0AAsdPOzHKENFlRBeN5rrVgZKryD
         12e3DsL8kONgBRfLh6dBK4GQEdwRrJjiiIEGxx8AU3DKo/rGXFnEkGcRXzOv3uuVlZ
         20CbYK7v8j3OnOSCYYUsz1Y+BzkyyeYBiNqT4UNW+9Eis9y7UjOH2EdhKlmfoRADBR
         jm1atsfksVsvg==
Received: by pali.im (Postfix)
        id BC657EDE; Thu,  8 Apr 2021 13:43:05 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RESEND PATCH mvebu v3 07/10] cpufreq: armada-37xx: Fix driver cleanup when registration failed
Date:   Thu,  8 Apr 2021 13:42:20 +0200
Message-Id: <20210408114223.8471-7-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408114223.8471-1-pali@kernel.org>
References: <20210408114223.8471-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 8db82563451f ("cpufreq: armada-37xx: fix frequency calculation for
opp") changed calculation of frequency passed to the dev_pm_opp_add()
function call. But the code for dev_pm_opp_remove() function call was not
updated, so the driver cleanup phase does not work when registration fails.

This fixes the issue by using the same frequency in both calls.

Signed-off-by: Pali Rohár <pali@kernel.org>
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
Tested-by: Anders Trier Olesen <anders.trier.olesen@gmail.com>
Tested-by: Philip Soares <philips@netisense.com>
Fixes: 8db82563451f ("cpufreq: armada-37xx: fix frequency calculation for opp")
Cc: stable@vger.kernel.org
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index c7683d447b11..1ab2113daef5 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -521,7 +521,7 @@ static int __init armada37xx_cpufreq_driver_init(void)
 remove_opp:
 	/* clean-up the already added opp before leaving */
 	while (load_lvl-- > ARMADA_37XX_DVFS_LOAD_0) {
-		freq = cur_frequency / dvfs->divider[load_lvl];
+		freq = base_frequency / dvfs->divider[load_lvl];
 		dev_pm_opp_remove(cpu_dev, freq);
 	}
 
-- 
2.20.1

