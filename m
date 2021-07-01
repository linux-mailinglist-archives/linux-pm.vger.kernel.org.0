Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CCD3B992D
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhGAXb3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbhGAXbR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:17 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAA9C061764;
        Thu,  1 Jul 2021 16:28:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id q18so14797991lfc.7;
        Thu, 01 Jul 2021 16:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uA7sTyUkq0alTs4vrb0YXe1CZtnJjoECt5LclMuFlrk=;
        b=mco3V7cGIfY68+nLUeX5XJXk5XpSosxJeMty9pLFyC7ix6t+Bp0yzUsZpvqA4QPPNw
         U+5mOnWvjoaApOiT2SS/u4RZ1VgWxQSfSnb2lCAlyTbnYCEh7n17t9pbWfQ4e3Uk/Id1
         JdCQ55j7uHFAaQCuXcoVSTm+sX+nDrlfrCeUeYXduX2bPukhEZCzTXqkl2a+2MMxY9lF
         PvaLaXOMJURNj4FuI5ImybQTRy9nN2yDBZnZYEWwJ4NIY4F6/tG4+DzrrMZix2f2EKxX
         ONFwol+21/cj6GSLuJCRzH5tQtszD46Q9F+8gzkQZ0QNTbTmVwCQFLE0809rAxLiunPG
         UKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uA7sTyUkq0alTs4vrb0YXe1CZtnJjoECt5LclMuFlrk=;
        b=Dq7JMsPabkXGiCVIiG4GEIzpOij5/dmB1keZ/QmBY6VRzxcl2utHQ/6l9EzeLifASy
         /srb1xuxG4bBbwb3SXIbc/wyI6Bxibp+H/J/pXYgI2hUZDxQg6K0G2O/E0qqm7hy1AOR
         0ugTpvi4kJgEgXVksSFAqgOx3nYOus7T8gRK0tJ7uQPdwPwBYbD6wB+Ytjj4Xog6CMPe
         38+AU6mX3cySjb9lFAC+CDSXdPx4mKtCOM9g95iZzyYKu3IHJzpsVR/AWZD4zgc5GzJK
         g6NjByBbOTcncIHe4bPL2azV1AbViMetUL9h1wNCAlXk13YAFm3Oe40jkSJ7g1U84vUU
         1zJQ==
X-Gm-Message-State: AOAM531UFnxinHqVH9LArZVJwlM5OeaJsEof25vqBpN7NkRuXNb2fdXf
        ZDVxtHjIdyQZunn+6vAj74g=
X-Google-Smtp-Source: ABdhPJyMMFV6IUxCT/HnpY7zTNvnpk/NeK1tqlZkbn/ivrYHQi01QDRHJsMYicnIFIh2gm1hnxv+1Q==
X-Received: by 2002:a05:6512:304b:: with SMTP id b11mr1505701lfb.315.1625182124376;
        Thu, 01 Jul 2021 16:28:44 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 24/37] soc/tegra: fuse: Enable fuse clock on suspend
Date:   Fri,  2 Jul 2021 02:27:15 +0300
Message-Id: <20210701232728.23591-25-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The FUSE clock should be enabled during suspend on Tegra124. Currently
clk driver enables it on all SoCs, but FUSE may require a higher core
voltage on Tegra30 while enabled. Move the quirk into the FUSE driver
and make it specific to Tegra124.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c   | 31 +++++++++++++++++++++++++++
 drivers/soc/tegra/fuse/fuse-tegra30.c |  1 +
 drivers/soc/tegra/fuse/fuse.h         |  2 ++
 3 files changed, 34 insertions(+)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 747237865aff..f660a3557478 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -275,9 +275,40 @@ static int __maybe_unused tegra_fuse_runtime_suspend(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused tegra_fuse_resume(struct device *dev)
+{
+	int err;
+
+	/*
+	 * Critical for RAM re-repair operation, which must occur on resume
+	 * from LP1 system suspend and as part of CCPLEX cluster switching.
+	 */
+	if (fuse->soc->clk_suspend_on) {
+		err = pm_runtime_force_resume(dev);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused tegra_fuse_suspend(struct device *dev)
+{
+	int err;
+
+	if (fuse->soc->clk_suspend_on) {
+		err = pm_runtime_force_suspend(dev);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static const struct dev_pm_ops tegra_fuse_pm = {
 	SET_RUNTIME_PM_OPS(tegra_fuse_runtime_suspend, tegra_fuse_runtime_resume,
 			   NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(tegra_fuse_suspend, tegra_fuse_resume)
 };
 
 static struct platform_driver tegra_fuse_driver = {
diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index dd03565a39a4..e1f1db3b0526 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -208,6 +208,7 @@ const struct tegra_fuse_soc tegra124_fuse_soc = {
 	.lookups = tegra124_fuse_lookups,
 	.num_lookups = ARRAY_SIZE(tegra124_fuse_lookups),
 	.soc_attr_group = &tegra_soc_attr_group,
+	.clk_suspend_on = true,
 };
 #endif
 
diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.h
index e057a58e2060..de58feba0435 100644
--- a/drivers/soc/tegra/fuse/fuse.h
+++ b/drivers/soc/tegra/fuse/fuse.h
@@ -34,6 +34,8 @@ struct tegra_fuse_soc {
 	unsigned int num_lookups;
 
 	const struct attribute_group *soc_attr_group;
+
+	bool clk_suspend_on;
 };
 
 struct tegra_fuse {
-- 
2.30.2

