Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE703D937E
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 16:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390615AbfJPOQ6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 10:16:58 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43598 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392904AbfJPOQ6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 10:16:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id n14so24170443ljj.10
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eeLcXye21fwck1PxjwVtam0tQFv4RcmovQRy0QMBXHw=;
        b=FAaOc31rfSgjMHeG2OKLyn80vynf5gqx4YVOK6/VK0nQcCgKxq+qT6Fafo/JIwGa8D
         JGQ69S4tdCE9Q+yoaWqWOUl8Op6kDVkwxH9cQuYMmaaD+D2jQgpZYiLCYaPE9ilzW/sC
         Eu6pXuT8jSL5VhoUjJ71QxIoV4AuHJOY9uH2uG8uCjuikaGt0Ki4DVgycgH26uTQYtUo
         65r6n783evKzySrXlDH4ZT0Mh30jusykfi/DKTsKucP06B6+DBMXibKlNR89ehDtydsW
         8bg4UprqR5bdsEioIJ8Z8bNXR9fIQomPRDx6xWXMhRaUuGb/hd9DBCZc1JJfo1xrdEU2
         OLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eeLcXye21fwck1PxjwVtam0tQFv4RcmovQRy0QMBXHw=;
        b=cKPfNX190YLSEcqCh2A6qQxMgXKgJh0UU4Qw3RuI8aUrhHRnnT/pkQxqr/6UWc6i2+
         KeQteyJvRhRtyWExija/skxefv5KZmKkBDDGjlKEHsHB8UHSteS7eQU0UESAqkZYNZYW
         xEYogmxVlAeBJmy46SUkA1Qd7Op9mJ+WonQ1IdxsyLKhLTTlLvTrv8GkRDQbdn2yQWno
         ca3nTfVFyc7icZitLrcViVLFwdAs8kr7HJVHK9g2YUd2YI8KgBPGfbaKqVMc4jkv4Fuj
         xSzP953ZBCj8rLvihJHPA2AF+XNAbpolMrnzO5N5T5mgW2A6BQDFImiCAAcs1VMf/ox5
         tFzg==
X-Gm-Message-State: APjAAAW2YwZNAFHPuJoKgzp16hz0bVAFGD242qHENtdlw8mofcFre1Jg
        9Yt8bECOvMoVpqOqdjpp9zSJZQ==
X-Google-Smtp-Source: APXvYqwo++c0TSTQCzieWu4Q5IIL3hXX7xz2RgT88Hx1XnCoIdJicZx8YrPzsbOMtFsVb5oPxXFWjg==
X-Received: by 2002:a05:651c:150:: with SMTP id c16mr1204692ljd.222.1571235415146;
        Wed, 16 Oct 2019 07:16:55 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id i128sm6022504lji.49.2019.10.16.07.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 07:16:54 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>
Subject: [PATCH] PM / Domains: Convert to dev_to_genpd_safe() in genpd_syscore_switch()
Date:   Wed, 16 Oct 2019 16:16:49 +0200
Message-Id: <20191016141649.18690-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The intent with walking the gpd_list via calling genpd_present() from
genpd_syscore_switch(), is to make sure the dev->pm_domain pointer belongs
to a registered genpd. However, as a genpd can't be removed if there is a
device attached to it, let's convert to use the quicker dev_to_genpd_safe()
instead.

Due to the above change, this allows us to cleanup genpd_present() and move
it inside CONFIG_PM_GENERIC_DOMAINS_OF, so let's do that as well.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index cc85e87eaf05..600ea78d6b71 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -922,24 +922,6 @@ static int __init genpd_power_off_unused(void)
 }
 late_initcall(genpd_power_off_unused);
 
-#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_GENERIC_DOMAINS_OF)
-
-static bool genpd_present(const struct generic_pm_domain *genpd)
-{
-	const struct generic_pm_domain *gpd;
-
-	if (IS_ERR_OR_NULL(genpd))
-		return false;
-
-	list_for_each_entry(gpd, &gpd_list, gpd_list_node)
-		if (gpd == genpd)
-			return true;
-
-	return false;
-}
-
-#endif
-
 #ifdef CONFIG_PM_SLEEP
 
 /**
@@ -1354,8 +1336,8 @@ static void genpd_syscore_switch(struct device *dev, bool suspend)
 {
 	struct generic_pm_domain *genpd;
 
-	genpd = dev_to_genpd(dev);
-	if (!genpd_present(genpd))
+	genpd = dev_to_genpd_safe(dev);
+	if (!genpd)
 		return;
 
 	if (suspend) {
@@ -2020,6 +2002,16 @@ static int genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
 	return 0;
 }
 
+static bool genpd_present(const struct generic_pm_domain *genpd)
+{
+	const struct generic_pm_domain *gpd;
+
+	list_for_each_entry(gpd, &gpd_list, gpd_list_node)
+		if (gpd == genpd)
+			return true;
+	return false;
+}
+
 /**
  * of_genpd_add_provider_simple() - Register a simple PM domain provider
  * @np: Device node pointer associated with the PM domain provider.
-- 
2.17.1

