Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8497C39397F
	for <lists+linux-pm@lfdr.de>; Fri, 28 May 2021 01:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbhE0Xzz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 19:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbhE0Xzy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 19:55:54 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778B1C061574;
        Thu, 27 May 2021 16:54:20 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f30so2682873lfj.1;
        Thu, 27 May 2021 16:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zKZDR8p/L3oeefldCNHrdGkondf8D1T4dxfFGeyIb9I=;
        b=VcMqfw+T19CgZsHttHltiV9Xpqy8Zf3kM1f/DjCqg1MomYo6yBQFIB+S05S97tuUkd
         pKbkf/O32AEXnZ9UQfn/+du2gpF8KOv+xeuJmTXUAnyKUR72QtzBuCIJQ5lxVFvlcvi2
         xWwccfMYtOTgVKrnKzG0KxPjkK3XWajLsbEKdyuHuFDScXHqRKRGEWZH0jiTUhUr1cd5
         CP+3xOb4rkREgoXBE0LHr+NGVc0eHlTv61rdhKAnTYaMrp38sjE5pELQIg73vD+NwAQ9
         jFrSlF0KMDh9X6p167RHW2HOiFyjuJXVPyeHhE9WqXfVA9W+pPv7viBX8eswFc6YRgqb
         LosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zKZDR8p/L3oeefldCNHrdGkondf8D1T4dxfFGeyIb9I=;
        b=hsl0sm5PqmY7wJbw/MKAc1SzELU2crOHfgvKIodBm3S7ywGUiqdDdzLZY+pYO3zkXl
         L9Czzb1c6JDySkMSV/aFqUujiIc0jQYHS6gS3CjQuhjRW7lhUQKo4BZvlw0deBu6j9A+
         KaUL5DAwZSrU6bHB0q3M+tkdFUf67RUZv20S6wvEsbjgrrDog+q3K9Ffn1OBfQf1mgNG
         yVkwQ0L3zWJJ9XCLNnao2bG+q5Do+JXJaQ9OsZeGKy12WP6UzfjxxC9mxCIBvR9Kp/y/
         aMbLxxOvfR43jD0pPOQR+BGFcE1JH+k7jNXs3SxVkocD0Z+wUllk6w4KbqDdbSaNLde+
         byrQ==
X-Gm-Message-State: AOAM530gSIbKE2vXkFoWzXkZN44j8Yuw5PoG0/wQ3pFmIYZr1q50bcWI
        80GUkXlNnUOaL1dX2E5Cl79iKj/bSfs=
X-Google-Smtp-Source: ABdhPJxTCPafvyPNfGryVXfFJH3d5uhUnkGqm2oLJLb46x9FrpDPY2Aok7HCVpFVm5USXFpIngOZQw==
X-Received: by 2002:ac2:5cc4:: with SMTP id f4mr3819067lfq.83.1622159658886;
        Thu, 27 May 2021 16:54:18 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id t129sm319000lff.109.2021.05.27.16.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 16:54:18 -0700 (PDT)
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
Subject: [PATCH v5 01/14] regulator: core: Add regulator_sync_voltage_rdev()
Date:   Fri, 28 May 2021 02:54:00 +0300
Message-Id: <20210527235413.23120-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527235413.23120-1-digetx@gmail.com>
References: <20210527235413.23120-1-digetx@gmail.com>
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

