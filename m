Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F031396B1C
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 04:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhFACfH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 22:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhFACfG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 22:35:06 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A7CC06174A;
        Mon, 31 May 2021 19:33:26 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id f30so19427302lfj.1;
        Mon, 31 May 2021 19:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zKZDR8p/L3oeefldCNHrdGkondf8D1T4dxfFGeyIb9I=;
        b=EDbSPZgN874700gJpT+4dz+/VYX0Av7nGyzOQzOJ+tAEay2tuk8bnBaczhOc1QuuYo
         LxkoI+e4wC8XzsMODLQJVoZmn/YpeoO/TrJVyjFhBBc2uB1CeqzVDjnrPOXL+lwvMbkb
         XFqEmdX6jQQH0yZYc0oZoC92XyGIMXxMXU6iwYELviApo6B4CXR+iNWGKpaB1lVf+/XS
         KvFekkgQv96O9vask4ay+ZAyscs9zfh1IRnQVew8gArrTHI3H0UvIo0vV579tQsy6MBg
         Ar0YlEmLffc51akmtx56AT8JjR8ecjPoMmrsbc2yI2YPJ1XzfZGURjX3rp0mzcleFLvx
         PqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zKZDR8p/L3oeefldCNHrdGkondf8D1T4dxfFGeyIb9I=;
        b=LG4KAVqn5c9HzqjfQXi0/gDVHGOGiypnltO6CHEetBnAV/EsS2i23Zdz4DU6yWplRP
         nNivAm1xqYynLlYC8jKhsrQg1aQArO0vV1F0kz/vEjiQP1SGvgm/+nAazZj9Yw1gEgBm
         CCDn6DpK+4frSwyZa94v4ZQkGM7xFACROK87cCLndbO8o1/sz3Nyx8xHo8r1yftUP+kh
         +bKmQ6z2afUN3cthI2k+hvY8fItGjsFI4alxK56gOB/1gAMNbNY7CMTaSZ7Xh2dE0Hnd
         m2HOG/dty0yqjlgqX7uV3Qg16CwseowTe7NqeOgTY5zNh9qc2+8DDroia0fYe3smyQ77
         lpyQ==
X-Gm-Message-State: AOAM530tuQ6spktV0UE7sq8yrA3bsIGDFx5vey0ejXEiYKZnMZ64lbil
        7OyRP+y7kNVnwyWuW0kMW+A=
X-Google-Smtp-Source: ABdhPJwJkLFu+/LOfRUP0ItGpxKYb2L4n+engi+nXAeAz5+k8jGWK6tVKtkEbCOrerNG7UULP8yw7w==
X-Received: by 2002:ac2:52b3:: with SMTP id r19mr8615926lfm.525.1622514804614;
        Mon, 31 May 2021 19:33:24 -0700 (PDT)
Received: from localhost.localdomain (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.gmail.com with ESMTPSA id l21sm107848lfc.28.2021.05.31.19.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:33:24 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?q?Nikola=20Milosavljevi=C4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v6 01/14] regulator: core: Add regulator_sync_voltage_rdev()
Date:   Tue,  1 Jun 2021 05:31:06 +0300
Message-Id: <20210601023119.22044-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210601023119.22044-1-digetx@gmail.com>
References: <20210601023119.22044-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some NVIDIA Tegra devices use a CPU soft-reset method for the reboot and
in this case we need to restore the coupled voltages to the state that is
suitable for hardware during boot. Add new regulator_sync_voltage_rdev()
helper which is needed by regulator drivers in order to sync voltage of
a coupled regulators.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c         | 23 +++++++++++++++++++++++
 include/linux/regulator/driver.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e20e77e4c159..aae978c0c148 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4111,6 +4111,29 @@ int regulator_set_voltage_time_sel(struct regulator_dev *rdev,
 }
 EXPORT_SYMBOL_GPL(regulator_set_voltage_time_sel);
 
+int regulator_sync_voltage_rdev(struct regulator_dev *rdev)
+{
+	int ret;
+
+	regulator_lock(rdev);
+
+	if (!rdev->desc->ops->set_voltage &&
+	    !rdev->desc->ops->set_voltage_sel) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* balance only, if regulator is coupled */
+	if (rdev->coupling_desc.n_coupled > 1)
+		ret = regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+	else
+		ret = -EOPNOTSUPP;
+
+out:
+	regulator_unlock(rdev);
+	return ret;
+}
+
 /**
  * regulator_sync_voltage - re-apply last regulator output voltage
  * @regulator: regulator source
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 4ea520c248e9..35e5a611db81 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -540,6 +540,7 @@ int regulator_set_current_limit_regmap(struct regulator_dev *rdev,
 int regulator_get_current_limit_regmap(struct regulator_dev *rdev);
 void *regulator_get_init_drvdata(struct regulator_init_data *reg_init_data);
 int regulator_set_ramp_delay_regmap(struct regulator_dev *rdev, int ramp_delay);
+int regulator_sync_voltage_rdev(struct regulator_dev *rdev);
 
 /*
  * Helper functions intended to be used by regulator drivers prior registering
-- 
2.30.2

