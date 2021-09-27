Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927E44191D8
	for <lists+linux-pm@lfdr.de>; Mon, 27 Sep 2021 11:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbhI0Jxc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Sep 2021 05:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233685AbhI0Jxc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Sep 2021 05:53:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA975600EF;
        Mon, 27 Sep 2021 09:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632736314;
        bh=euDAn8QrdLy6aBu3eAQGzTKso/i73eEHDM14y55fAE0=;
        h=From:To:Cc:Subject:Date:From;
        b=W8PXnhQrvX224HksE/K58bchshcna7UHoYaosUrKvh/wqqGxGTQpVOs6BMX9slA8d
         R28g9mygpMuq7SJAnuEPBjNNKvLdHbEYtAkLBz3sFA0mVtdVZHGQXZw2sXKeu5ltTN
         laJiEqUlvoFEYihvfvGmV9bYlwC9/8ctMlI4FQDs72aKJLEeXDgGS0bqMQ5S0ezK7B
         p9t3OCc2doBvkYHHpRiPzw+3dkwGXKDk4/+1AeZsU+UjHzXz5RRrOJS/dgQ8LGqEhs
         zC+PpzQMpAmDD6r8VOy5u3Nav2nXXkLtM4GNoeDP2LmMIe9lnEg1JG3rbanF1SRj8Z
         4q8e9ToGYLbIQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: s3c244x: add fallthrough comments for switch
Date:   Mon, 27 Sep 2021 11:51:44 +0200
Message-Id: <20210927095150.944127-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Apparently nobody has so far caught this warning, I hit it in randconfig
build testing:

drivers/cpufreq/s3c2440-cpufreq.c: In function 's3c2440_cpufreq_setdivs':
drivers/cpufreq/s3c2440-cpufreq.c:175:10: error: this statement may fall through [-Werror=implicit-fallthrough=]
   camdiv |= S3C2440_CAMDIVN_HCLK3_HALF;
          ^
drivers/cpufreq/s3c2440-cpufreq.c:176:2: note: here
  case 3:
  ^~~~
drivers/cpufreq/s3c2440-cpufreq.c:181:10: error: this statement may fall through [-Werror=implicit-fallthrough=]
   camdiv |= S3C2440_CAMDIVN_HCLK4_HALF;
          ^
drivers/cpufreq/s3c2440-cpufreq.c:182:2: note: here
  case 4:
  ^~~~

Both look like the fallthrough is intentional, so add the new
"fallthrough;" keyword.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/s3c2440-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/s3c2440-cpufreq.c b/drivers/cpufreq/s3c2440-cpufreq.c
index 148e8aedefa9..2011fb9c03a4 100644
--- a/drivers/cpufreq/s3c2440-cpufreq.c
+++ b/drivers/cpufreq/s3c2440-cpufreq.c
@@ -173,12 +173,14 @@ static void s3c2440_cpufreq_setdivs(struct s3c_cpufreq_config *cfg)
 
 	case 6:
 		camdiv |= S3C2440_CAMDIVN_HCLK3_HALF;
+		fallthrough;
 	case 3:
 		clkdiv |= S3C2440_CLKDIVN_HDIVN_3_6;
 		break;
 
 	case 8:
 		camdiv |= S3C2440_CAMDIVN_HCLK4_HALF;
+		fallthrough;
 	case 4:
 		clkdiv |= S3C2440_CLKDIVN_HDIVN_4_8;
 		break;
-- 
2.29.2

