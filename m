Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA676E92AB
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfJ2WGY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:06:24 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32809 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbfJ2WGX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 18:06:23 -0400
Received: by mail-lf1-f67.google.com with SMTP id y127so11746213lfc.0;
        Tue, 29 Oct 2019 15:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5LONhI03rb2fwfUY6X7OU7Y25sYxMdC9HcXKn9+BCyQ=;
        b=uDuxkMJEKoGGClHLxpgL5yA4z60Lv5lPzaeYSs3xAcGhttJWal3QJqTG8rkQys5I1R
         xLLoE0quWFbJIhm/SovHBSpfo8ahIXJ991BD4bbc3VQMtrtYJ/IVWdnf8gHwUnUVkdYV
         OfJU/dCHLm12SiHCjZPem5v7StHvRLcVi/9RWRApfqYJVuPKvHSgDQdgdlYAVZ4qLrBS
         rT4w5sGQLqKkiPCD5N26pqzIo6kJwZyQbfn6ZTX1WDgPSlsIA39ufbzkGkME1x46nite
         GIB8uDQIDKtvSl2mcBp8hh731XIoIV+Wed+eOr/UqUJa6eZP9Wnp2BWUqHQj4M6bM8pe
         mZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5LONhI03rb2fwfUY6X7OU7Y25sYxMdC9HcXKn9+BCyQ=;
        b=sV2xIZfc8WX1Q8ZESfL9WUpkfvIMRIrHFn9nvNgrHSPrQQerhGdGrllsM9k5ICp6f8
         JQPDbE8Jq5S/kWX0m8Lyy/YBf1fRZEzy8Wc80ANiefdtVc677YzlEI91WAeAudvU96Z+
         rehv/1NNzHWk16ADemA3iULtyoT7AcnCemeaM92tAXYuvgmAuO6o3Ef0deAQGwwwj+20
         01ftPWUjRAQbp6YQR5OhFHFEZe/djjtnFHHovK7q/pAXjzk5uHKfyAEphoYb7PRombrQ
         ocd+Wq/PFBA2nc9Ursq85PdLuOxAHQxOuRE3ek/Ky9OgJ/Z8aa8B8YEaZrw+RRPuuXQG
         QF3w==
X-Gm-Message-State: APjAAAWf0lh4MClAcCNd9+PFbZ8h8k2MHufQWf9lfUsprOSNnmxXqEQM
        OAy3lbst9DmO2Y7PPw7l+mA=
X-Google-Smtp-Source: APXvYqzapl51XY9ifplkQr/u2ykDrE0Hk/PIVVJwSSXLaMk8Ts/yv0GJXscMYBrU2W6tGh/O4PLOFQ==
X-Received: by 2002:ac2:4d17:: with SMTP id r23mr4035546lfi.56.1572386781628;
        Tue, 29 Oct 2019 15:06:21 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 12sm51536lje.92.2019.10.29.15.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:06:21 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 12/19] PM / devfreq: tegra30: Include appropriate header
Date:   Wed, 30 Oct 2019 01:00:12 +0300
Message-Id: <20191029220019.26773-13-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029220019.26773-1-digetx@gmail.com>
References: <20191029220019.26773-1-digetx@gmail.com>
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
index f658b0b4a845..9da62f695859 100644
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

