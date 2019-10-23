Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31560E0EEE
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 02:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbfJWAKD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 20:10:03 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44539 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731191AbfJWAKC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 20:10:02 -0400
Received: by mail-oi1-f195.google.com with SMTP id s71so2958580oih.11;
        Tue, 22 Oct 2019 17:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a9ez2CAEDRsC1P3a7h5jUoJezRgAM3yxFgvxTfyLf90=;
        b=T3tUit6hFzPMxQcFoOw91I2XHrgvbQxAGlDhYZb88r//APvhau+Ehsfgl3PwA4YF5I
         XKhDUIfof4etfnzaAu13fri4XmDIX6qXZjBcNGCrmS64gqkRYZ4r6rwBhCrFdhhesPXs
         EcFaIbWfY1WQ8HqOLyflznj4gEPaiZmWfhTK2ApJcZbb61DPAUJ8Yz8FkBpeD+/mIrw0
         fml0gc9uvgJlLCLAbTby1FhiT3o9tf6h2lIz7fYUqv7jfVsQsj1Nfczb9iuj7qx3J/Rc
         YMe58qxU/FYQ6+lsx0lj/SAZUTRoTbVV0loIbJIr2cH7uCsuvAB+I93f+OAHbTqWv3IP
         kRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a9ez2CAEDRsC1P3a7h5jUoJezRgAM3yxFgvxTfyLf90=;
        b=uJy00T4mraCTgzNd3TMVir3ajz8yGZAbXtqDSGX4Mz9t367ylhVGv//ONfbVOpfdj1
         FcOeKDvIVK1tTK9jQc9YBCC0Q3hOdPagIkE6jRGy5qY5vK9gFTRNsQBD7B7b12CtWKN0
         9bUMkwlhtCep7Y4LPSyyOUOi79fc78Ch+eusKdYgPoEXNWZlQhXueLXFZ9aSjYjeyBME
         id4JpXI8S4mnxS/guERn9l5Tx0zkpzINQoiPtRxRrK77AKG1BsYLarigol9FtZDCJWVF
         Yc7+CF9407uKtwZ9nV0HZM4dbDRZcPdSO8/SMtbAdHofdF1g8fxJXjeesdlDbpiCQqzb
         Z2yw==
X-Gm-Message-State: APjAAAVXvbZRFGgVe52vBX/DhB2lHkAfx/Vy53TxO7Ip4JimgzKpxL6K
        CDFdKNo86gisC8E67YN2JJE=
X-Google-Smtp-Source: APXvYqzAnJ15V0N/LujMFPCRBVS4/v+jPKDC+SHq1MB28Z0T1cc/2/2vwIysgNZqqLSZQ8K9ay+6mw==
X-Received: by 2002:aca:180e:: with SMTP id h14mr5339099oih.142.1571789399995;
        Tue, 22 Oct 2019 17:09:59 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id t18sm5637527otd.60.2019.10.22.17.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 17:09:59 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] cpufreq: s3c64xx: Remove pointless NULL check in s3c64xx_cpufreq_driver_init
Date:   Tue, 22 Oct 2019 17:09:06 -0700
Message-Id: <20191023000906.14374-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When building with Clang + -Wtautological-pointer-compare:

drivers/cpufreq/s3c64xx-cpufreq.c:152:6: warning: comparison of array
's3c64xx_freq_table' equal to a null pointer is always false
[-Wtautological-pointer-compare]
        if (s3c64xx_freq_table == NULL) {
            ^~~~~~~~~~~~~~~~~~    ~~~~
1 warning generated.

The definition of s3c64xx_freq_table is surrounded by an ifdef
directive for CONFIG_CPU_S3C6410, which is always true for this driver
because it depends on it in drivers/cpufreq/Kconfig.arm (and if it
weren't, there would be a build error because s3c64xx_freq_table would
not be a defined symbol).

Resolve this warning by removing the unnecessary NULL check because it
is always false as Clang notes. While we are at it, remove the
unnecessary ifdef conditional because it is always true.

Fixes: b3748ddd8056 ("[ARM] S3C64XX: Initial support for DVFS")
Link: https://github.com/ClangBuiltLinux/linux/issues/748
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/cpufreq/s3c64xx-cpufreq.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
index af0c00dabb22..c6bdfc308e99 100644
--- a/drivers/cpufreq/s3c64xx-cpufreq.c
+++ b/drivers/cpufreq/s3c64xx-cpufreq.c
@@ -19,7 +19,6 @@
 static struct regulator *vddarm;
 static unsigned long regulator_latency;
 
-#ifdef CONFIG_CPU_S3C6410
 struct s3c64xx_dvfs {
 	unsigned int vddarm_min;
 	unsigned int vddarm_max;
@@ -48,7 +47,6 @@ static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
 	{ 0, 4, 800000 },
 	{ 0, 0, CPUFREQ_TABLE_END },
 };
-#endif
 
 static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
 				      unsigned int index)
@@ -149,11 +147,6 @@ static int s3c64xx_cpufreq_driver_init(struct cpufreq_policy *policy)
 	if (policy->cpu != 0)
 		return -EINVAL;
 
-	if (s3c64xx_freq_table == NULL) {
-		pr_err("No frequency information for this CPU\n");
-		return -ENODEV;
-	}
-
 	policy->clk = clk_get(NULL, "armclk");
 	if (IS_ERR(policy->clk)) {
 		pr_err("Unable to obtain ARMCLK: %ld\n",
-- 
2.23.0

