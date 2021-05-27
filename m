Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FDE393819
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 23:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbhE0Vp2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 17:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbhE0Vp1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 17:45:27 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4BEC061760;
        Thu, 27 May 2021 14:43:52 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id f30so2281282lfj.1;
        Thu, 27 May 2021 14:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zKZDR8p/L3oeefldCNHrdGkondf8D1T4dxfFGeyIb9I=;
        b=u6OL1Ff0LXWgtiyBjffPVwjho3f8AMZUy+BulZSek4Te3FnnESR58Rte83b31wcIVM
         2DhVn1TvDyXu/Wj6HYaaaWGyjCHfHzCgX/T+H3bIhtxVaCq7zBFZo3BQVc9xrekUqfin
         oREH3wrvfL0wG/L0OfOkJQT0fgo0UN+MAGSIcac4t1bMQEkNgkRCVmJgsgxoGBjVhktb
         G/dbzT80NEKLVenGSgN9YL6LBukjy4dYBS1ydHb0uBUhAyOiErQMnib4eymdK/skbNMI
         P+22K3ebIJ++PWWCXTAmr66eJB9PI2xxYOuXNVpfoIk8b6Ckk5sC/Vca3BQwNNb2OQwe
         B07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zKZDR8p/L3oeefldCNHrdGkondf8D1T4dxfFGeyIb9I=;
        b=dNhzmQIOWXCulz/jcXXbpO8wnXzknn7ph5X3mCUGy/YpK9orBEqxR56vBLjrnwEo9q
         xN7x1UyPHIXYfPxN1VAHcgxkeiSpaPViFLDHVdGYIUhi+dQQC8ElYrgOxJHd7UtRqrxh
         5VDi5p1D6Cq6t6s87O10R5iil5A+qXW2M9FZUQINcIVkikp0vlehbCfDjGYWHKJflpHs
         OGoWli04btbRaN0OCCZ+SuzFsvD1VBBRG7x1Ettnaq6dFsNnuVX01seBUQF/vlaOdHez
         gnTw3pKO7V/U1Ux7DeTYwwjcFNlo3VprtTenJTN8UWvNNoQDuFL2L4yi38+SHiXjHRVa
         /T7w==
X-Gm-Message-State: AOAM530rmD7JvFKY037rZ9yoIXmg5UBlU6BgaAZAbPnTfVpKulVNvCH3
        ZAIyzCzCiWqFmtqsOC/tzJBrWhagUvA=
X-Google-Smtp-Source: ABdhPJw+cGDlr8DI/VTgW1R/9+NZQuJEDpg++/Q73Mo9Fq0BberyjfZkqRZJl8MTX0wGgvYoxc/oPg==
X-Received: by 2002:a05:6512:220b:: with SMTP id h11mr3621511lfu.17.1622151831012;
        Thu, 27 May 2021 14:43:51 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id v11sm298153lfr.44.2021.05.27.14.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 14:43:50 -0700 (PDT)
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
Subject: [PATCH v4 01/14] regulator: core: Add regulator_sync_voltage_rdev()
Date:   Fri, 28 May 2021 00:43:04 +0300
Message-Id: <20210527214317.31014-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527214317.31014-1-digetx@gmail.com>
References: <20210527214317.31014-1-digetx@gmail.com>
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

