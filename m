Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3204AED4E7
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2019 21:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfKCUmy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 15:42:54 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37114 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfKCUmR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Nov 2019 15:42:17 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so10705389lfp.4;
        Sun, 03 Nov 2019 12:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=poTJBSF/GUDkNTSs4u0rRqSIrUnXV6hdBnQ1YS7E5D8=;
        b=CrYesmnMQhvk0umjmtCTG82uNk3Dix1/K+lmPams9YJXe54JTBVu1ABd/8k7217EnC
         Tepw95yzds93p8tG1RBo8OPPfq+rzqyiW3HSnRBq1adT3+YnFz7snvaVxk00NYivraZD
         CmL3nfDgtIofEyzhxzFbIRv/ebLIAKCVGqpyW3pqBJd+jJOUvrDurswwjlWTLlGEHXK2
         GHIjh3UhJJS2q9hS78y1WKWBUQCi28DHGbbkbxxurEXII3/VxLG9SQj6PpJhG/i0F6ed
         3RKX1sK34tCVxM5KolpgEh8ZHP36BS2EM5axGOGDKZQ0SGREPJjvtgpnumUqxp/QVKCG
         ZG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=poTJBSF/GUDkNTSs4u0rRqSIrUnXV6hdBnQ1YS7E5D8=;
        b=VsI9L8bueCk1Mpe+jB+yQ3QzGuLQY4qpOA0tlh+JHkmDRDxIhYkg7s4L5G+DX0HiHG
         0DQb1YQ5X0mU2baIflYYRul39bHVPmTCp6gGfwqJ93BHjsKgv2chFYY3dBI9XsagnEBV
         1WP6jGn12cn2MqWdu3LH/SrVD5UXXcCtxVZbm46Zuo9EZ/kSZlETOz+A1dMIXZ+p5KER
         Ks1fWwueRD0yJrjq4BXcSWEeOwMWV7YFK9tUTqZ2CUBy094iba7WIZit/+YjhPyAxFZG
         J5XhITjCqqpAcRwNEhcSmClcn7xItR4kALtd9EYol9CjWk+nGsuOct41Sfs1g+d1/iH/
         shtw==
X-Gm-Message-State: APjAAAVa+rFfdkmf/KJy24UzLcjeBXaxPgK1CIyxTTRA2s5AYVISyt5m
        rOeG0FcdeN9nQT/oZQ5qXX8=
X-Google-Smtp-Source: APXvYqzpni6/vRVYtW3lz4rQ1qW3auNWX1/SA7pJv0EyZlWnssY/fM1Qw2mt35Mc+CsFrKFC4dJLXg==
X-Received: by 2002:a19:41d7:: with SMTP id o206mr13382036lfa.188.1572813734104;
        Sun, 03 Nov 2019 12:42:14 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id e22sm7099853ljg.73.2019.11.03.12.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:42:13 -0800 (PST)
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
Subject: [PATCH v8 12/18] PM / devfreq: tegra30: Include appropriate header
Date:   Sun,  3 Nov 2019 23:41:24 +0300
Message-Id: <20191103204130.2172-13-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191103204130.2172-1-digetx@gmail.com>
References: <20191103204130.2172-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's not very correct to include mod_devicetable.h for the OF device
drivers and of_device.h should be included instead.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 9bd4dd982927..7c8126e74750 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -13,7 +13,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/module.h>
-#include <linux/mod_devicetable.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/reset.h>
-- 
2.23.0

