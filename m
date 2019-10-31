Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39EF6EB6B1
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 19:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfJaSOI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 14:14:08 -0400
Received: from vps.xff.cz ([195.181.215.36]:45420 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfJaSOI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 31 Oct 2019 14:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1572545646; bh=+8+aVOF3iSqGvzL1N7hB/tIOgnCmWN7n8SmI/voLyuw=;
        h=From:To:Cc:Subject:Date:From;
        b=QbLwWY74HjtrueocUL8/R6dmMGmMTLGX3Dtb/snOuodi4/KJ9dq9X1jj4qf9QgnL7
         Ob52iOVQ/R+gj88YDgepIN76L1UZZbucbHXnbTQD/flG9XuTD2lC5Hr/uFx5h9P/Vm
         jaXcikK1Gat9slDGatNmvF4/K6ATPO5tww36z3PY=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com
Cc:     Ondrej Jirman <megous@megous.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org (open list:ALLWINNER CPUFREQ DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] cpufreq: sun50i: Fix CPU speed bin detection
Date:   Thu, 31 Oct 2019 19:13:58 +0100
Message-Id: <20191031181359.282617-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I have failures to boot on Orange Pi 3, because this driver determined
that my SoC is from the normal bin, but my SoC only works reliably with
the OPP values for the slowest bin.

Looking at BSP code, I found that efuse values have following meanings
on H6:

- 0b000 invalid (interpreted in vendor's BSP as normal bin)
- 0b001 slowest bin
- 0b011 normal bin
- 0b111 fastest bin

Let's play it safe and interpret 0 as the slowest bin, but fix detection
of other bins to match vendor code.

Fixes: f328584f7bff ("cpufreq: Add sun50i nvmem based CPU scaling driver")
Signed-off-by: Ondrej Jirman <megous@megous.com>
---

See https://megous.com/git/linux/tree/drivers/soc/sunxi/sunxi-sid.c?h=h6-4.9-bsp#n484
and https://megous.com/git/linux/tree/drivers/cpufreq/sunxi-cpufreq.c?h=h6-4.9-bsp#n428
(1 is substracted from soc_bin number here!)

 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index df35ef3ef567..41dad03e245c 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -71,9 +71,12 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
 	efuse_value = (*speedbin >> NVMEM_SHIFT) & NVMEM_MASK;
 	switch (efuse_value) {
 	case 0b0001:
-		*versions = 1;
+		*versions = 0;
 		break;
 	case 0b0011:
+		*versions = 1;
+		break;
+	case 0b0111:
 		*versions = 2;
 		break;
 	default:
-- 
2.23.0

