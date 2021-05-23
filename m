Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F347A38DDB9
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 01:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhEWXPS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 May 2021 19:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbhEWXPR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 May 2021 19:15:17 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A6EC061756;
        Sun, 23 May 2021 16:13:49 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id t17so14421390ljd.9;
        Sun, 23 May 2021 16:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zKZDR8p/L3oeefldCNHrdGkondf8D1T4dxfFGeyIb9I=;
        b=AYz1xpraxuHlBHwB1fwAmN0IJ7D9lIrClee1X+wrO59ED4FhsJy8kcrLm+903R2Luv
         9d+nOIDE2UvsTwREjNxVsGHw9WmsICYRIQ96ZnkduncB/ggI5aYe3S1Igiwpnpe1TWy8
         08AaegW4pTyaKs5P2kYds/XLrwPX79BYarNcR+ESoQHIaGhAeC3UoezFZ0OYxJv8Oa8w
         uhwom68wfFVnjGTcFPYWQ7iUDtxa7iq0I/j95ux/unrbA0V3UECWIGqh7cUWwHWCqAgb
         99qxTO4V0BbyWO6wyx4OpiLvbgIKw5u+mjMQYyIprUU9Zk1A4VHtBIlG7qxlBnorkEZK
         NRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zKZDR8p/L3oeefldCNHrdGkondf8D1T4dxfFGeyIb9I=;
        b=czCqRBho+2cUBjK4Z6yLuJOlr4cpyhZlDw9c+/M0x380wpv3GDueYkOMGozDy4lXHX
         +ipENuZEwD0vGJ+v/El9O6wrJKg6nDTcGcgECEP0eZYn2FGSTrmJaNIkHdyZtLtiYpMW
         EIgqO9glhqtnB69TML2XLdtLw8bisHCfSGXBjGzbJ2UwaqVrYYbniM0ki///KV5/kQmP
         l/eZc0LfnbFVVUKA192HgvB85t9C95/dLpm7xtrnOSrpyOQjE6wLXnDq95dUIwyKlMyQ
         XhP5HncSRDLNqu7najIkBuZiVZngNyp5dklrkT8paRSvpBatT1qJKksMf119j0ZhLUsK
         iSjA==
X-Gm-Message-State: AOAM5317AwnDPV/ah4N5PsW9RzrZP4RtxiyrCes3gBdKH9ebxqNMBHga
        fYxRGYUoO1AAkfSjb41/bdM=
X-Google-Smtp-Source: ABdhPJw2cbS8t/c8qHkJXlNWQjtHj+XqeXDpW6K4Nl90eeBk+5BT+lF27wjByqQEbDdkyGrMdcTz/w==
X-Received: by 2002:a2e:9116:: with SMTP id m22mr14329538ljg.176.1621811627667;
        Sun, 23 May 2021 16:13:47 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-110.dynamic.spd-mgts.ru. [109.252.193.110])
        by smtp.gmail.com with ESMTPSA id p7sm1268619lfr.184.2021.05.23.16.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 16:13:47 -0700 (PDT)
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
Subject: [PATCH v2 01/14] regulator: core: Add regulator_sync_voltage_rdev()
Date:   Mon, 24 May 2021 02:13:22 +0300
Message-Id: <20210523231335.8238-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210523231335.8238-1-digetx@gmail.com>
References: <20210523231335.8238-1-digetx@gmail.com>
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

