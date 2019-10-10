Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92196D330D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 23:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfJJUyA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 16:54:00 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:56517 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfJJUyA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 16:54:00 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MHmuE-1iLR8L2rMU-00EtUy; Thu, 10 Oct 2019 22:53:51 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 31/36] ARM: s3c: cpufreq: use global s3c2412_cpufreq_setrefresh
Date:   Thu, 10 Oct 2019 22:30:15 +0200
Message-Id: <20191010203043.1241612-31-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191010203043.1241612-1-arnd@arndb.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Fqr+3CFSJ3z4nTjJP8VvOYDnXO9EX8g1sytJseiBmwVd5rPpq97
 9sruTvvZ87o0fdD7Cb5YJZoyiUwUQ2d20fjsnrZ2/ti0eYbj94X/VXq060K27XIYEuUjcn6
 evrUWDq66oQbd8FaGR7d/8oiFeD55KCF/Nb9Hvd7zZcx9COJsqf+8pLR+bTu3F/RE4wig8M
 bL1N+gwAQac2r4xR8sQsw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:I4aXG3I2BlQ=:WzAJmAR6TpeAp6EuftPE/X
 G3vu9wKCdQh+X+DtHXLsSX9uM+cjh88bct9q5yhn5vuuMLMgdE3sLrpUc/JVj/kRZdRCP8SO0
 ZKXiJ7MO0FqsYjgjjlsh1L+JaI+qp/FLi53fjDEWQBGWcI75qofK/YGNBjIqUMj57RMNGRnqN
 7+rn+u6/IOwjeqta8QTy2XB12OibL1hQ0MzblW5y19TTqC6vR/w7yGbDVFmDFUEE264k7yMlH
 Dm11HWnMYWAL92rFyR3nPFm/mK7mpFGRq2qHeLBvlLUOmC+KS3SQgfhU17mmDtXWvr1X0Ea3L
 IuHcsi9nNRVRC9Bg65Ry9nPskAhZi+id0hJNMsVAjYgPICbS1OZgDbH3viSZYTrEy4G5OY1L+
 kqNU7mMyDuNyC45HX3xIvfpNr3dM/87I/bRDa5cBnc10UwXI0wTMP2tOG8xcFVNptjWqsc/ps
 IdlQAV8J37riuHqYb4ZrqyE5uNyfazEn/z0CPNZnDc6drOWgTdw2bbXaSlhm4b70tQKBYfFkx
 4KmdS2rSSE7w8a7mVNf6SiCDQNLHA9GPf9aqPCsIJdB5PsDOddoIRC6cc96yITIBuMKLfwqO4
 3+WhQudP1iFmGo/CA3TgHH2YzP2hpmpYXy1QMX/RNVBvKgdmNyEiR/yGX1Nal/tMrpLfYMa3Q
 EDHGD9KLQ/akRINDWbJga9ZSoU4ksWC1BPTk7i7Y2uTvWEmJYMJJAbEMFFucUm6VVV92+bJoj
 /0fntlkd9YT6tdXyEcBZrbBzOI+sg7spN+zTq8+Kf24a/8k5J0Gzke7kPc+ASlnwsWwnYBM7Z
 zDcq+Bu2brWvxhzIOAxKtUI1GD47uapI1T0wZxEldPhUU2yWT00FBQMklj84IehO5EzwKQ7BY
 wi5YZxTT79iCz0e2t4sw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are two identical copies of the s3c2412_cpufreq_setrefresh
function: a static one in the cpufreq driver and a global
version in iotiming-s3c2412.c.

As the function requires the use of a hardcoded register address
from a header that we want to not be visible to drivers, just
move the existing global function and add a declaration in
one of the cpufreq header files.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/s3c2412-cpufreq.c            | 23 --------------------
 include/linux/soc/samsung/s3c-cpufreq-core.h |  1 +
 2 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/cpufreq/s3c2412-cpufreq.c b/drivers/cpufreq/s3c2412-cpufreq.c
index 38dc9e6db633..a77c63e92e1a 100644
--- a/drivers/cpufreq/s3c2412-cpufreq.c
+++ b/drivers/cpufreq/s3c2412-cpufreq.c
@@ -25,8 +25,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/s3c2412.h>
-
 #include <mach/map.h>
 
 #define S3C2410_CLKREG(x) ((x) + S3C24XX_VA_CLKPWR)
@@ -156,27 +154,6 @@ static void s3c2412_cpufreq_setdivs(struct s3c_cpufreq_config *cfg)
 	clk_set_parent(armclk, cfg->divs.dvs ? hclk : fclk);
 }
 
-static void s3c2412_cpufreq_setrefresh(struct s3c_cpufreq_config *cfg)
-{
-	struct s3c_cpufreq_board *board = cfg->board;
-	unsigned long refresh;
-
-	s3c_freq_dbg("%s: refresh %u ns, hclk %lu\n", __func__,
-		     board->refresh, cfg->freq.hclk);
-
-	/* Reduce both the refresh time (in ns) and the frequency (in MHz)
-	 * by 10 each to ensure that we do not overflow 32 bit numbers. This
-	 * should work for HCLK up to 133MHz and refresh period up to 30usec.
-	 */
-
-	refresh = (board->refresh / 10);
-	refresh *= (cfg->freq.hclk / 100);
-	refresh /= (1 * 1000 * 1000);	/* 10^6 */
-
-	s3c_freq_dbg("%s: setting refresh 0x%08lx\n", __func__, refresh);
-	__raw_writel(refresh, S3C2412_REFRESH);
-}
-
 /* set the default cpu frequency information, based on an 200MHz part
  * as we have no other way of detecting the speed rating in software.
  */
diff --git a/include/linux/soc/samsung/s3c-cpufreq-core.h b/include/linux/soc/samsung/s3c-cpufreq-core.h
index 4d22be1031b9..eca942559014 100644
--- a/include/linux/soc/samsung/s3c-cpufreq-core.h
+++ b/include/linux/soc/samsung/s3c-cpufreq-core.h
@@ -246,6 +246,7 @@ extern int s3c2412_iotiming_calc(struct s3c_cpufreq_config *cfg,
 
 extern void s3c2412_iotiming_set(struct s3c_cpufreq_config *cfg,
 				 struct s3c_iotimings *iot);
+extern void s3c2412_cpufreq_setrefresh(struct s3c_cpufreq_config *cfg);
 #else
 #define s3c2412_iotiming_debugfs NULL
 #define s3c2412_iotiming_calc NULL
-- 
2.20.0

