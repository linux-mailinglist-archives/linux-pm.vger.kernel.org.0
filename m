Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1E93F5207
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 22:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhHWU0L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 16:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhHWU0L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Aug 2021 16:26:11 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA33CC061575;
        Mon, 23 Aug 2021 13:25:27 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q21so33609913ljj.6;
        Mon, 23 Aug 2021 13:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TS6xlglVLGeDbAGeYFqIJEG7imj091QkptCAvdSg7xQ=;
        b=dAvZ/CN92uZ8xeZ1GLlT9gNaX466/UBvXIY2XO7OginCHKsgjtBSQIpxgSzO2OdlqM
         L2WAHyVJHhPUIuzCbTSiaG3YoWx+ZSDjKtcA4WNAhqiMbQI9WXi+IYcegQsZ3Cw4DqQV
         Xex5dwdD0svHyZPkK7P/NfhEQHlPZtuKryf4H9umvFTQlVTIEG3QtC774aN+AXyl8HbC
         DQi2sGbP7Wq99kFuHmPYYkkmqfkKJWFsdXLtC7dFiLrbvg8NKY2psEY3NNY4TpfqTN+h
         vVcvjK0SkZvDpqtEfq1jVJGZ4F1xjW1Qs4fKQ6ib37YqJFN81B8NKa8EfKgrZ986FQll
         S9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TS6xlglVLGeDbAGeYFqIJEG7imj091QkptCAvdSg7xQ=;
        b=jcFWiFsb8ejQ6//i/trzzaB332q+J0NHKpgU397Ym8GQVSrdDnqRUH3ArqnVaL2GDn
         mk4kxajWANfLKv3eQkN1eiSA0asBiCS1H6FEjMja7mOBbsVNnlVdAxRw6ES5nGsAYHD2
         2V2q4+f6KNJvWPSScHNP/nmH9Ai0fHuFc+nwFBasSmotn04MKLfjHvk6vKNcj4rzBkly
         ZrEdOxeT7DN5j93CGi5pMTNmeDTVP+m+iwAogOVknUWET264cmt2WnwlBKTuSngLHnxL
         GrPuqNvRbGhNG2EfKA6PK9hQ419QjC0XmEq0tapQEbEgQCmB5DB5OWQBTHXIJ+5oQ2Ui
         XmRQ==
X-Gm-Message-State: AOAM532te9ig3rUpFwPTGPwTHbDgTr34QTcYEv20MJ+MlMCFghC/OuY2
        26ZuHvWHHBKoeR25spjo07k=
X-Google-Smtp-Source: ABdhPJwHJn5Md+n7t8CBGRdqpzKgIhKI5zMB3Js+h+J6VWNt2ClxwJm2bz1AIwFvJajfTU2dDZ9VGg==
X-Received: by 2002:a2e:86d1:: with SMTP id n17mr22927187ljj.237.1629750326405;
        Mon, 23 Aug 2021 13:25:26 -0700 (PDT)
Received: from localhost.localdomain (46-138-120-72.dynamic.spd-mgts.ru. [46.138.120.72])
        by smtp.gmail.com with ESMTPSA id q25sm1542626lfr.235.2021.08.23.13.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 13:25:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1] PM: domains: Improve runtime PM performance state handling
Date:   Mon, 23 Aug 2021 23:24:12 +0300
Message-Id: <20210823202412.25716-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

GENPD core doesn't support handling performance state changes while
consumer device is runtime-suspended or when runtime PM is disabled.
GENPD core may override performance state that was configured by device
driver while RPM of the device was disabled or device was RPM-suspended.
Let's close that gap by allowing drivers to control performance state
while RPM of a consumer device is disabled and to set up performance
state of RPM-suspended device that will be applied by GENPD core on
RPM-resume of the device.

Fixes: 5937c3ce2122 ("PM: domains: Drop/restore performance state votes for devices at runtime PM")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/base/power/domain.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e1c8994ae225..3a13a942d012 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -435,7 +435,7 @@ static void genpd_restore_performance_state(struct device *dev,
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 {
 	struct generic_pm_domain *genpd;
-	int ret;
+	int ret = 0;
 
 	genpd = dev_to_genpd_safe(dev);
 	if (!genpd)
@@ -446,7 +446,13 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 		return -EINVAL;
 
 	genpd_lock(genpd);
-	ret = genpd_set_performance_state(dev, state);
+	if (pm_runtime_suspended(dev)) {
+		dev_gpd_data(dev)->rpm_pstate = state;
+	} else {
+		ret = genpd_set_performance_state(dev, state);
+		if (!ret)
+			dev_gpd_data(dev)->rpm_pstate = 0;
+	}
 	genpd_unlock(genpd);
 
 	return ret;
-- 
2.32.0

