Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC0EA15B54A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgBLXw2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:52:28 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35045 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729427AbgBLXw2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:52:28 -0500
Received: by mail-lf1-f66.google.com with SMTP id z18so2887804lfe.2;
        Wed, 12 Feb 2020 15:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SwBRJQR42/kEWjB6ykPsoUtj/cCrRyEP3WrYnBo2JoU=;
        b=q4PBCf6vV7k7eo945ALuK9Zk0xhkc2XzhBdMQazK4z4jXPUlxo70jUHgEsXPQo8FLf
         Uc9vua2xfjIXeCXsyipec1lXwsJCMJyCKVqH552E+zPFf781yJyEw9Bpc7eMZM/Qm4Kb
         8fhrAddz5CsMbMRB+9koqGb4I3ZNSQbkdREePGLTRaTmInHTF5R/+pS8WpsVEOvGEy8U
         37UvQtSAGAHmFbYnsnq9JatQRFFxXtW0HAvJqk2P3f+y+e7Pc3PXTd3XPIvukL2+z49l
         izf4l8BjA/Nz20Lh1SMebsgqiJI7qhC5Hy/IXGFxwwmuQJlUScvtRdTz6tq5VR/DaNfP
         S3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SwBRJQR42/kEWjB6ykPsoUtj/cCrRyEP3WrYnBo2JoU=;
        b=MdVehyiSkQg5k2yD4vytrhQD33OPy5OuHXMZ6gmFkiPVRCnWji/9t/Hv/NnqVD8Wyp
         IMACG7ePP05k5bydq15yE0DyB5CPsVCMJIklopc/pK2682WQiMRadOlQRAUb0u15Dmme
         FxiMkoTYM3O1jPwEn1EuwRZtUw0n4OzgPZDwAT8gqPQHe6TwCf40kbjpKe3vNgR8BHKa
         3rvXJJJJjTkpaK5ObGNtXYWFKQ4KMEIqe64sqKoTbZB+Z1bONxx8B1nzKVnb2QaI0qs5
         Ub0uEuT36pFIgUBvreKajmKehfWkSQc5/ztdJbVayzsK95kAaVi+T2VeSULJMs+XeENr
         7DZg==
X-Gm-Message-State: APjAAAU6cbF7+nnkUxwi+kWcx/RPsCnvxIY+fw3jrlOEAzBbZsIupsyc
        1H+iJii1yQxhxcuGBlsQO+8=
X-Google-Smtp-Source: APXvYqze00y9LEhDlD4AAUJJRiH7b/OaBx847RcFnwwdRi7PkZjL474COf/db2e34Avc4ak2XXv7/w==
X-Received: by 2002:ac2:5289:: with SMTP id q9mr7924989lfm.78.1581551545698;
        Wed, 12 Feb 2020 15:52:25 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d5sm251686lfb.20.2020.02.12.15.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:52:25 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 15/17] cpuidle: tegra: Disable CC6 state if LP2 unavailable
Date:   Thu, 13 Feb 2020 02:51:32 +0300
Message-Id: <20200212235134.12638-16-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212235134.12638-1-digetx@gmail.com>
References: <20200212235134.12638-1-digetx@gmail.com>
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

