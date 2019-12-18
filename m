Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B75F125429
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 22:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfLRVG6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 16:06:58 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33445 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfLRVG5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 16:06:57 -0500
Received: by mail-lj1-f196.google.com with SMTP id p8so3757212ljg.0;
        Wed, 18 Dec 2019 13:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SwBRJQR42/kEWjB6ykPsoUtj/cCrRyEP3WrYnBo2JoU=;
        b=VwAzIP+gxrmQm3GnN8mZlOs4r3O0dwj2nAIf7Tw7bsKGxkZ46h3JnDMyJuKdJAeXdc
         iy2Bp5/I47Ep0ia+NBqIX00oVpU91s5OqoNbeRcUaB6h4y4DbmRaL00jWQPkDeqYPJpy
         DH2EaBjtgYlU72ul5UPt+++1oYafFAnudYzZqdBZOv1zkGNGOvKWvlSl+p+HtD1tJdtm
         N0tHpX/8jvdFAEHRLdH7fw+TASdSbcWj1nYEVhyELS00stz+9stNxpFuMF7SmUqsHzZ0
         T671NtQEu057BazQd98o/yz7rDuLfxi8WooJmADXfEUHbnwIpoDpvneyXRKyP5Iff1xX
         Tetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SwBRJQR42/kEWjB6ykPsoUtj/cCrRyEP3WrYnBo2JoU=;
        b=rg8/wSFjRA7v7N5Q3pj77GrG9p2YaE/NlN0KBTjd4AiUf5AY4ttRgwf4xzc4cf80+b
         01HBeElTt3FxLbMUlaRzr27KN7J4eqPzLYcndlx99Cn9ErabyaLf/XLXvn6b51FuiyZ4
         ZEzCp9krLDKTQ71stQJRq1iZK3pePaL0SRXyUCPpVrvkTQKRiqNM6bKg0+bJBu1GxSh7
         0IDIgSyW/DS+ag+rwyq9qVZee6rYh7YJR21iaQoXkiXIhyoK/gbm7UORLoAdsQXm2MnY
         pq2rb1rGKSDxOWIQX3lkmRTyCTL7dTBlvpBp40XTfwBQtXPEVHP5SFK4tYx+thK3YyxM
         DH0g==
X-Gm-Message-State: APjAAAUIO6LvkzNLh8ddOxHeE+VL5xGTWhHj4/x+Vk1TciOvwJ+Tr1fg
        UUJSaANWnWl2IroXi84G6dA=
X-Google-Smtp-Source: APXvYqyZrB7jKpCDPpU77WLvsfTVwoYnrD2UdkKyK8XZm3s5ozs0RYQSmMyhbQUT09p2NBWGPWPIZg==
X-Received: by 2002:a2e:85c9:: with SMTP id h9mr3326449ljj.155.1576703215314;
        Wed, 18 Dec 2019 13:06:55 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id r15sm1754648ljk.3.2019.12.18.13.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:06:54 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 15/17] cpuidle: tegra: Disable CC6 state if LP2 unavailable
Date:   Thu, 19 Dec 2019 00:05:01 +0300
Message-Id: <20191218210503.6689-16-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218210503.6689-1-digetx@gmail.com>
References: <20191218210503.6689-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

LP2 suspending could be unavailable, for example if it is disabled in a
device-tree. CC6 cpuidle state won't work in that case.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpuidle/cpuidle-tegra.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index b6cdad8437af..675b8a4464ba 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -31,6 +31,7 @@
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/irq.h>
 #include <soc/tegra/pm.h>
+#include <soc/tegra/pmc.h>
 
 #include <asm/cpuidle.h>
 #include <asm/firmware.h>
@@ -334,6 +335,10 @@ static void tegra_cpuidle_setup_tegra114_c7_state(void)
 
 static int tegra_cpuidle_probe(struct platform_device *pdev)
 {
+	/* LP2 could be disabled in device-tree */
+	if (tegra_pmc_get_suspend_mode() < TEGRA_SUSPEND_LP2)
+		tegra_cpuidle_disable_state(TEGRA_CC6);
+
 	/*
 	 * Required suspend-resume functionality, which is provided by the
 	 * Tegra-arch core and PMC driver, is unavailable if PM-sleep option
-- 
2.24.0

