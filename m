Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E18378943F
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 23:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfHKVZI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 17:25:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37594 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfHKVYv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 17:24:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id z28so42402170ljn.4;
        Sun, 11 Aug 2019 14:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rl6+31atTzQWuYNYtIscWWP4waaXRqkRH1JYAHXA7qo=;
        b=E7Wa4n4NPUKQwZdlNhZKtzrj+RvWL4+5uEcIovqr+2z5rXp9LeGnD9qs5O5qtOSU2Y
         N9WZ2u2lb/GuI0dKaOoeVoJjzBov8IpIUCGNORkXz8npEDh20/VAgVgL7S+ftMcUXCIK
         Logo5HDU2Z9oj4WoG75eidjaP6KSh9h3uVRzGuE9wsm5c5BzMH1ycnoqhQ27urHm5lN/
         QuoBL76Mf7RSDjaZYGtcYJjKmJ6EohWR8xctr3WTT/DAhsuWgna6u5aB6RgjcgbNJ7nc
         3ZAHEuju6tBCpj7j+xqkhb/VR879J/voe8XAYQRGwhB4bjv1u6m6zcR1Zk5ZVSW89bLN
         wCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rl6+31atTzQWuYNYtIscWWP4waaXRqkRH1JYAHXA7qo=;
        b=nmNMaHUZRBB8xTbngaLZhoR1qnYBFgzgnQVvwrOVXjd8+aqgZVwmVuBFomOXZSf+gb
         nBp2WqUmvwr0pgpDUxissMD87QshYoLUpDQriovxXi8zO+m44rm1K1lTho4GtUTZ+xyL
         1nJup7NPqNFSsQ+rhjgMBZGDMJraHECoNMwV8gFFzy/NISbLH2GB0PjSeEuzI4KQK+Do
         azhnQPVs950vA6Q3SQ9U15/liWM1nN2L9pX3aTEwqSbj6BAFgsCf3shhzEKuigp9bFho
         +G2azMhf0+US/P6JNB+cer8r97PYU7gNmpi4g4cw17dcgtClNZLQfc7bZslEtjXPAHc3
         udJA==
X-Gm-Message-State: APjAAAXtlyfqLrtHU+JxjIHsVBTSV0YmVs0/3irwiw+Gqu5IbM3+Av4/
        Yn/3d5QV+hSyDCtJU8EemvI=
X-Google-Smtp-Source: APXvYqzHtU9rlVXZhSkiDGaXlN5i553leooIWDeLx8jkbmJh4GnQ3MtB/Lkil+RIHWX04JDijslb/A==
X-Received: by 2002:a2e:7013:: with SMTP id l19mr17256049ljc.141.1565558688909;
        Sun, 11 Aug 2019 14:24:48 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id f1sm20470806ljk.86.2019.08.11.14.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:24:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 16/19] PM / devfreq: tegra30: Include appropriate header
Date:   Mon, 12 Aug 2019 00:23:12 +0300
Message-Id: <20190811212315.12689-17-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811212315.12689-1-digetx@gmail.com>
References: <20190811212315.12689-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's not very correct to include mod_devicetable.h for the OF device
drivers and of_device.h should be included instead.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 6446bf705b97..9753985c9131 100644
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
2.22.0

