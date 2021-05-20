Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF3B38BA08
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 01:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhETXKE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 May 2021 19:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbhETXKD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 May 2021 19:10:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8156EC061761;
        Thu, 20 May 2021 16:08:40 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a2so26881190lfc.9;
        Thu, 20 May 2021 16:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4wjkerGjnODWZW9w3YSKmK8x5ot3hbK6hwMuTDmldcE=;
        b=eY+JcN50EErXfJJBHxuOt6AxKLX5cM00mV5NGLoPgAIKNZxqPRMaG0FnienMoaG5SV
         /+kB14sss/j2hn7khi3mnGNY+hu8x0EtJv3xy56MOyqGQBVl2tLnuGTrwjIAX/O01ecn
         q0ytzsaDaJ73gmOfBgsWjCdaF/jzKEioVYEpaYVDdNyorgAjLfGcBBC/nx+d6kD8FseV
         mmfdHzk2NwbKtQXNEzJ3kSg97304srhrirFdZyi23nkpgHPtfaL4xf/TdlIKx2hGM3SK
         jPjG8EwnRTuzzNMW0Tu6Rfk+XIku5nIqPNTUdVLlPHtJ8twLHFphwhR4AcZpQXbGWfYW
         PlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4wjkerGjnODWZW9w3YSKmK8x5ot3hbK6hwMuTDmldcE=;
        b=D5W54YktIo5eeZ3J+PzEF3NZr9ynK52JxEUfNkJCnhfVw5flmhN8s0BoLsrIk5zEuF
         /utlOP97IoHFoF5JCOR33lC2VXU8hoZ54qR2Su22+8hBpB7cK465nSFFCvOjPQ7k7zzF
         LhAJa53V2o+JVGC+qJMC4rA6oz+Trf15Wes2cQKclfd+Bo+T5PqoKq9+f+FHQxEnhoRY
         YUff0LOqQxUGqbvUTxlw1bBzvX0Qra7SoFvaxtEzySVlinEQyDcCWs19F2gc5LK5Ur2J
         bbbma8MKEHj90WwnJvtgfvGEp7GWYCvGlnh6TiFVwyyINXm2wAwFwUhfTE1fH1B/ccyz
         9dUw==
X-Gm-Message-State: AOAM5304SDb4lXgblePiTc0M3BcyQx8P/3dLlnFz4Ga0gXfcL+0UAszL
        xvJthSrXaVzeoUcWPKnVyxk=
X-Google-Smtp-Source: ABdhPJyIlz9t4Ds3YgggFlv9Ncz2YTCg7pWLILTlZ7oCF4wxyxUhe0yQiOCr2vbdtbuhCU1robe2hw==
X-Received: by 2002:ac2:5289:: with SMTP id q9mr4613760lfm.141.1621552118935;
        Thu, 20 May 2021 16:08:38 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-76.dynamic.spd-mgts.ru. [109.252.193.76])
        by smtp.gmail.com with ESMTPSA id 4sm427821lfr.175.2021.05.20.16.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 16:08:38 -0700 (PDT)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v1 01/13] regulator: core: Add regulator_sync_voltage_rdev()
Date:   Fri, 21 May 2021 02:07:39 +0300
Message-Id: <20210520230751.26848-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520230751.26848-1-digetx@gmail.com>
References: <20210520230751.26848-1-digetx@gmail.com>
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
index f192bf19492e..ead0b6d2af45 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4105,6 +4105,29 @@ int regulator_set_voltage_time_sel(struct regulator_dev *rdev,
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

