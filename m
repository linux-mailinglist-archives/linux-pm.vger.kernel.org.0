Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370DE358247
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 13:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhDHLny (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 07:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231337AbhDHLnw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Apr 2021 07:43:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB6E461154;
        Thu,  8 Apr 2021 11:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617882221;
        bh=VztKX42wnG26u1toPL5fMsj5cTTzN2Qip/AFn/wQabU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iF7MmUWSHNkw9tsVX5zWYU/Q8vYLPOEozXsV9yGiDAXEPGf2cWoLdwrqcoMGFMBSw
         fayKDvC9OeBBNQX3fQUuJEvJjFXwd0Kd/wZHd/ZTXjqaKnyF+N8xoxT8NJRkU+57WP
         qExm/lEYVvs54mrmX95mykXvhjuXeH9u5VFFfKmb+2ccSFlQ5fbQxyuWasGnLOAV45
         fQrtleS8DOyzk+yb7v70/7FUKNVjNnDbJxfiuBKwbmXB61YVYJbfMTS/FT6g3/6XXd
         vN1DRLKktqcjFxWK+KvGxnvFmCWN6cmvypTNeROGR1ammESf9u3FJcE7+G4ZXDhS3U
         8mmsl5cA5SIow==
Received: by pali.im (Postfix)
        id DE545EBC; Thu,  8 Apr 2021 13:43:38 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RESEND PATCH mvebu v3 08/10] cpufreq: armada-37xx: Fix determining base CPU frequency
Date:   Thu,  8 Apr 2021 13:42:21 +0200
Message-Id: <20210408114223.8471-8-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408114223.8471-1-pali@kernel.org>
References: <20210408114223.8471-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When current CPU load is not L0 then loading armada-37xx-cpufreq.ko driver
fails with following error:

    # modprobe armada-37xx-cpufreq
    [  502.702097] Unsupported CPU frequency 250 MHz

This issue was partially fixed by commit 8db82563451f ("cpufreq:
armada-37xx: fix frequency calculation for opp"), but only for calculating
CPU frequency for opp.

Fix this also for determination of base CPU frequency.

Signed-off-by: Pali Rohár <pali@kernel.org>
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
Tested-by: Anders Trier Olesen <anders.trier.olesen@gmail.com>
Tested-by: Philip Soares <philips@netisense.com>
Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
Cc: stable@vger.kernel.org # 8db82563451f ("cpufreq: armada-37xx: fix frequency calculation for opp")
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index 1ab2113daef5..e4782f562e7a 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -469,7 +469,7 @@ static int __init armada37xx_cpufreq_driver_init(void)
 		return -EINVAL;
 	}
 
-	dvfs = armada_37xx_cpu_freq_info_get(cur_frequency);
+	dvfs = armada_37xx_cpu_freq_info_get(base_frequency);
 	if (!dvfs) {
 		clk_put(clk);
 		return -EINVAL;
-- 
2.20.1

