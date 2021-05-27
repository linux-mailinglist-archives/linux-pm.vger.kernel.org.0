Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4023F393755
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 22:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhE0Utd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 16:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbhE0Utb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 16:49:31 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9D8C061574;
        Thu, 27 May 2021 13:47:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q1so2064699lfo.3;
        Thu, 27 May 2021 13:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zKZDR8p/L3oeefldCNHrdGkondf8D1T4dxfFGeyIb9I=;
        b=lOrHxsMBCXvtAApqy+a2EsgUPsb8nIhuq4mVt4TY1wxkvZsiwg71//YZVhUKC1EtbF
         voh8HmMDlmVeCi/lttDteIN14Es2VuhFqk53KIiyvBHWyLNhKDuS4deiEUyZwjaK3dv5
         Tda9h4CX0O18RnjD+202C6myy6m1AhGE1Gwat92l7eYZiwRCbnACV+OpsMeK80zEJsYR
         LEc1XvmPenMUkrtYcK+lA/G/LJHCB9lJDblGZkYTVoanWHR+586PrvFOrgpshaVm8nSD
         vQUiv886DngYHk58dm3hayhTPK0wOJanYgAQgmi72U5Ov4Hm1sMMrGNIaNhwv949tlSE
         4LRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zKZDR8p/L3oeefldCNHrdGkondf8D1T4dxfFGeyIb9I=;
        b=e4dsJ8HRQaHjiI7S8COMZKeMnkz2f72Jt8U6S6uKgGo7LhTGnif6l7n/ifXj7mV7Ne
         Gy9W8CvzMkJbmaI1XgR2TNsnnx0M2oPAcoFzRMspTurxcsABx/klyNOmYTYDt4BVH0ce
         zdn0UqXmp4QNjbeFRkyJwTpkC+uflOP9IsSMV8Uol4OwKv0xgpcDJRQIraWm9JLER2p3
         706uMNkjBeu4XKjvzUWlA+CNbh2PASJh58PhaUTewD2e3/Czyc8c4M7gbOwMyZbkWFUQ
         e5Ulug2PJ8g4Rfv2TiOyaZ82wPqolaWXJi7IEieyHl40SmmlBedhRvNflBK3By1wZfjW
         Vk0A==
X-Gm-Message-State: AOAM53249nA5bAdwWnp/VM9+zzlxxAq655UaNMbt3sRIPKZoUmnpwHIj
        tAc2fyyOjV86kEadt3UlLBg=
X-Google-Smtp-Source: ABdhPJwCXmOj2kjtKVeyRWvf5R+DM9y7dbzhevgKqcpNUmWjgDj/6z/q7XvxR+MQCwAG+3plWs1dqA==
X-Received: by 2002:ac2:5a45:: with SMTP id r5mr3747975lfn.342.1622148475251;
        Thu, 27 May 2021 13:47:55 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id 10sm347297ljq.39.2021.05.27.13.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:47:54 -0700 (PDT)
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
Subject: [PATCH v3 01/14] regulator: core: Add regulator_sync_voltage_rdev()
Date:   Thu, 27 May 2021 23:47:29 +0300
Message-Id: <20210527204742.10379-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527204742.10379-1-digetx@gmail.com>
References: <20210527204742.10379-1-digetx@gmail.com>
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

