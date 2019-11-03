Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 964A8ED4E1
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2019 21:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfKCUmN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 15:42:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32962 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbfKCUmK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Nov 2019 15:42:10 -0500
Received: by mail-lj1-f195.google.com with SMTP id t5so15413726ljk.0;
        Sun, 03 Nov 2019 12:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4GPUilwynfX5AA3QRvL7JTfGxSIPwXWj2mMjnwonars=;
        b=KrGTh6/gtRVTUbbrEXGx4wgcWZUbPGxZniOY/WX+FAFKSS2WgnlT/0Ip7mJE54hak9
         5x/CFLc4s/pFax3AhU8UBPMC6pR8UgcBhcwVicn002xNHDSdcNx56HQ2rSbsgoCEa6Im
         M2kkWw139V5XW6NddO7D/QBsDmSxROYh9XjXyxh+Fa8v4AO2mTb0dgTwhqhz43z1tKCW
         Gn5N/Yyl1XCmqT7I0V0+EBalMvYCuFpR0f2MhGnxj60IYzX/ouGCD3N2t2MC+mE5YHxD
         gDuEJp+sBB8QWJge3fv9i2YaqCslWPEI7uXe242FpT7VeXZyMrQQZZXYYab4bQGgVK3m
         ztkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4GPUilwynfX5AA3QRvL7JTfGxSIPwXWj2mMjnwonars=;
        b=Q2F6L0is+qUf4YjME6YIGp5IQKmyu1bMv1V0FPFxbczPlZukXdvK3DDuDUK/mZyc2F
         vkF+i+e5scnrqJ1o8oZZIvj+8gxV5TO+auaP+nFSueRZLSkd9nmMdCazptNgmYvRCSwD
         ScvX6y5Qn3bFBklxr+Sc8jz6h6IQ6t6K4h4GMpGWcQLA46fcwAotRU/Ko3J5Jf4W2BaD
         LYEUpTEhfoWi4gwGnRxnhCrP+y4EQxeqDPctlRTfZzT6q2oIPazsbjjP+tfPNXbAnpDf
         NsOzTOj7rbuPqaU8DskTj75kT5rs2/3sKpsN8l7gKn9OSEx/+bZP0OKZgaPrMNbuDuc+
         SLhQ==
X-Gm-Message-State: APjAAAVbIIvU57In9bgrViPuyWcQ5lZq7nNIepe8VU7BNrklb7335xDe
        WPwphTXzk+RRc+lpa952B/w=
X-Google-Smtp-Source: APXvYqzxuTd/J9gHEsZg9uzrfONxIJALHRuhetMKrpBzyK7NlYPh9ld5nmUqKbBl2rqxaoMGY/ab2Q==
X-Received: by 2002:a2e:9a41:: with SMTP id k1mr2158401ljj.11.1572813727107;
        Sun, 03 Nov 2019 12:42:07 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id e22sm7099853ljg.73.2019.11.03.12.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:42:06 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 05/18] PM / devfreq: tegra30: Fix integer overflow on CPU's freq max out
Date:   Sun,  3 Nov 2019 23:41:17 +0300
Message-Id: <20191103204130.2172-6-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191103204130.2172-1-digetx@gmail.com>
References: <20191103204130.2172-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is another kHz-conversion bug in the code, resulting in integer
overflow. Although, this time the resulting value is 4294966296 and it's
close to ULONG_MAX, which is okay in this case.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index b50bd1615010..7d7b7eecc19c 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -69,6 +69,8 @@
 
 #define KHZ							1000
 
+#define KHZ_MAX						(ULONG_MAX / KHZ)
+
 /* Assume that the bus is saturated if the utilization is 25% */
 #define BUS_SATURATION_RATIO					25
 
@@ -170,7 +172,7 @@ struct tegra_actmon_emc_ratio {
 };
 
 static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
-	{ 1400000, ULONG_MAX },
+	{ 1400000,    KHZ_MAX },
 	{ 1200000,    750000 },
 	{ 1100000,    600000 },
 	{ 1000000,    500000 },
-- 
2.23.0

