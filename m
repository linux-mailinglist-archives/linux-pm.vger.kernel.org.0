Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE6C3FC904
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 15:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhHaN57 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 09:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhHaN55 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 09:57:57 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAA7C0613D9;
        Tue, 31 Aug 2021 06:57:01 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g13so38678241lfj.12;
        Tue, 31 Aug 2021 06:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hgtc73wlzCPnDSrqZMFKdeSGLWZ/vHH3cfFR111Xa/s=;
        b=irnCEBugj9h5KB1fYkP9OvMOkrJp63BMzspkE3SIn6OkBb9KaSEzQAbQ0BAYE73ciH
         pHUAfquaR4slUFDj6gB0OqxIxsm9XSqPy49d+bdol3VK8435+ffiV+GM5ZL+fkYjPrmW
         mBb53w4VxpN9zV31qYYnzILN3oTaIAA1FqO6IaRD10aYLkVRevjGL6uxrt6hw+f012bL
         xwyYx1l9j7OkKoA1Or4G6TJTuli+FEtW7GO9PfOEernLjVayZO26JxQcjTXTABGSJA4H
         oJPlWFzvsnasQu7cUKNSxA70jV7o+MaVY0uzOBTrT7UUQm4a1xG1m2/VHDwfjBFQXa6z
         XJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hgtc73wlzCPnDSrqZMFKdeSGLWZ/vHH3cfFR111Xa/s=;
        b=VJLmzNYgjb3WeHvjTizw39vN3fRM6BETs1ZRhYZS3P+zAY1C3Rz+9+tjwWBGq5r2JF
         XafjpR8rGHpR36QoZu50lrkOi6q1aWRPhp4oJ9rOMh/Kvmhw0CMQhv0M+8KcaSUKkpki
         qBpP1ebZeQB2hweXTgmijrWBZuzxsH6EU0z6M9qtXiDB5WzvRiKBnJZu8xDV4332ncA+
         LMi0KW8QGioFq53mIPBR9r0HV+lTnj0TBVxrjlUrxMN8MeIpRkn1vKN2fvOervn4Bl65
         GticKGMEM8VgVFFgfUbgxgTbFHXyFkSnHfuHte/vF9RFNCEw1fflSwcEou7tA377b5/C
         TogQ==
X-Gm-Message-State: AOAM533S4Ki8Qtq4CvQ0PdkGE97VdLwdBB+o2hi9iUEk31h1Sf51Jz4e
        TC6GbKjtjSMyjoG8IWlYajQ=
X-Google-Smtp-Source: ABdhPJwBxEAKZykniE6gECVoOUXIP0Uxwd71uV46hgknj7vXpR/Ih5V3Mns3w7BORSlEuE5R8NVqrw==
X-Received: by 2002:a19:4955:: with SMTP id l21mr22326210lfj.5.1630418220155;
        Tue, 31 Aug 2021 06:57:00 -0700 (PDT)
Received: from localhost.localdomain (46-138-26-37.dynamic.spd-mgts.ru. [46.138.26.37])
        by smtp.gmail.com with ESMTPSA id x4sm2203622ljm.98.2021.08.31.06.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:56:59 -0700 (PDT)
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
Subject: [PATCH v10 3/8] opp: Change type of dev_pm_opp_attach_genpd(names) argument
Date:   Tue, 31 Aug 2021 16:54:45 +0300
Message-Id: <20210831135450.26070-4-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210831135450.26070-1-digetx@gmail.com>
References: <20210831135450.26070-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Elements of the 'names' array are not changed by the code, constify them
for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c     | 6 +++---
 include/linux/pm_opp.h | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 602e502d092e..d4e706a8b70d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2359,12 +2359,12 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
  * "required-opps" are added in DT.
  */
 struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
-		const char **names, struct device ***virt_devs)
+		const char * const *names, struct device ***virt_devs)
 {
 	struct opp_table *opp_table;
 	struct device *virt_dev;
 	int index = 0, ret = -EINVAL;
-	const char **name = names;
+	const char * const *name = names;
 
 	opp_table = _add_opp_table(dev, false);
 	if (IS_ERR(opp_table))
@@ -2468,7 +2468,7 @@ static void devm_pm_opp_detach_genpd(void *data)
  *
  * Return: 0 on success and errorno otherwise.
  */
-int devm_pm_opp_attach_genpd(struct device *dev, const char **names,
+int devm_pm_opp_attach_genpd(struct device *dev, const char * const *names,
 			     struct device ***virt_devs)
 {
 	struct opp_table *opp_table;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index c8091977efb8..37d5d71e0835 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -156,9 +156,9 @@ int devm_pm_opp_set_clkname(struct device *dev, const char *name);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
 int devm_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
-struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
+struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs);
 void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
-int devm_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
+int devm_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs);
 struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table, struct opp_table *dst_table, struct dev_pm_opp *src_opp);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
@@ -377,7 +377,7 @@ static inline int devm_pm_opp_set_clkname(struct device *dev, const char *name)
 	return -EOPNOTSUPP;
 }
 
-static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs)
+static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
@@ -385,7 +385,7 @@ static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, cons
 static inline void dev_pm_opp_detach_genpd(struct opp_table *opp_table) {}
 
 static inline int devm_pm_opp_attach_genpd(struct device *dev,
-					   const char **names,
+					   const char * const *names,
 					   struct device ***virt_devs)
 {
 	return -EOPNOTSUPP;
-- 
2.32.0

