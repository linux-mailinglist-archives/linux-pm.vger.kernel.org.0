Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF2511041
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 01:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfEAXmU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 19:42:20 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36636 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfEAXmS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 19:42:18 -0400
Received: by mail-it1-f193.google.com with SMTP id v143so369851itc.1;
        Wed, 01 May 2019 16:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0aHfrpwQ9Q70XX4N4sl0yp3+boF4GIfc1x8NZ9l+9Hs=;
        b=DdTC4uVbQXO2s6AYmW5EJvl0nG5WVNGky0enTznS4DD7Wgj0DGrLH8grjJ1Y/9ZP5K
         /73izakAI3+PVvb4WjfaQ0PGsNZD5RcmPcCEjOiYluLjid1WmhWQ5zjx+hNqnZbJ06I6
         7iMJo/eYEBvtzWRY7/9r7vsqUVvaQiU3XSexnCyeNp5AsFc01WsxHds//VDloGa8GFZ3
         miGzticpxgryxSVoZfRl14IvbkXOpz2LaN3g4mOgH6v88aJq4ks/tQeo2fSyE2evxm5U
         hNVBz03QlFuM/5YlliyBdXTgIDTTFXsAo+agFtPXU+OsOWsA6NuJ10i5qAG1JhbE42+K
         rsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0aHfrpwQ9Q70XX4N4sl0yp3+boF4GIfc1x8NZ9l+9Hs=;
        b=IQJH/P0qbQt0YjgsDMP5wNQPq1EU7sSICaVB13AOZsRqKw9zG9UEXt6Jf4Rx921poF
         LJ7G0YfF4JdJb8AGKwtPg1qVGhlr7qLOrUp6qLqNr9S0qQMTZsTCMWEK9mcwibMyoNZd
         RMgbo2LpykrRVIBZgoybnTRt3RieKYGDS2Kah2mMK+05MVR3ARJfavI5PnfAamulHL7G
         qlgrSKVByV7tdEe5Afjy3IhrXytCxdxdIu0eCoqiBD9+iVx6FwFrSYsDCSIlp9P6EEi6
         GQKjrPFkUpKVZ0NMLJ3Kfgu31dpCvNDtqTvgxSzwxgsVxvUg6lV2rx1JbpEDDIfXkQhm
         Crpg==
X-Gm-Message-State: APjAAAUUOJyImBHAU+DQ47nQyfqkduTlrFuPB8pHjAreGlYeaVbBuSXp
        EIckpm3rtvU6uJPzvMq8nm0=
X-Google-Smtp-Source: APXvYqxebFoDrqoLrqIy98qDZfwEejY3kkdUphbBi1+QAatDuKsp/69H4kdkdkggH0J6t5e6S3Gavw==
X-Received: by 2002:a24:32cb:: with SMTP id j194mr194380ita.168.1556754137811;
        Wed, 01 May 2019 16:42:17 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id m3sm2392507ion.69.2019.05.01.16.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 16:42:17 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 15/16] PM / devfreq: tegra: Rename tegra-devfreq.c to tegra30-devfreq.c
Date:   Thu,  2 May 2019 02:38:14 +0300
Message-Id: <20190501233815.32643-16-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to reflect that driver serves NVIDIA Tegra30 and later SoC
generations, let's rename the driver's source file to "tegra30-devfreq.c".
This will make driver files to look more consistent after addition of a
driver for Tegra20.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/Makefile                               | 2 +-
 drivers/devfreq/{tegra-devfreq.c => tegra30-devfreq.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/devfreq/{tegra-devfreq.c => tegra30-devfreq.c} (100%)

diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 32b8d4d3f12c..47e5aeeebfd1 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
 # DEVFREQ Drivers
 obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
 obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
-obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
+obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
 
 # DEVFREQ Event Drivers
 obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
similarity index 100%
rename from drivers/devfreq/tegra-devfreq.c
rename to drivers/devfreq/tegra30-devfreq.c
-- 
2.21.0

