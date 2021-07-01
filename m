Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635923B9916
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbhGAXbT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbhGAXbK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:10 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE11C061765;
        Thu,  1 Jul 2021 16:28:37 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id q16so14835776lfr.4;
        Thu, 01 Jul 2021 16:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pOA9v6Nwo6u7ZeMw6NfhfA7U2vrjYfx8EufX9ro0JGI=;
        b=unIHNAPlnRsjsjKI9SJqkoQBnXsTXTGvXUCaVbFlAr0/QYqG1b5vlmAuQn35ximg4v
         aFJgrBdsZF/4SIhoEyIL6JeOBG5BcZmSOMbA6zPljN8BqGz/XbD9EvNNl0lJugUKbSN9
         hnY9ecPPtdKXqiZukjnv49aIG0pklQBtD9mgE2i2EWjRFUqzvnknVZ4Pjg34XVxGKL63
         rIYH2KbysajcdglAHcC2bzvb21jXyvTJBbUetR9f0kDQg5z8bxMtuKFyusmvznvVC9nV
         9FCEkhm57FBhhZz2xE8uS1PTTAPmjYnwQRpX+4TQE5zOEv07PQVHUj8aWR1n9HtDoT3B
         cTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pOA9v6Nwo6u7ZeMw6NfhfA7U2vrjYfx8EufX9ro0JGI=;
        b=X+GcXfx/IBl9P32A/qzuhoKZmuE7ecKj2bEZX7sOMIY2LvTXRoNTmn/+NeBk77A/w6
         stH9HZAeI/PAoc3IKahxKbmgiKfc1AnRAWWYgbTTPIGCfsZKGkO1EJ2c3qMkR0fY1ReQ
         BO4DZTVqC/z+AsZWqEBqhZcHxUHL+obj3v7z9YhPtP00Oe7Ii1iDfNGYg0vI6F5ZfZKx
         PDENObgXSHOcCH32Z3vBasGHDoC3c8DWV6vdk6OhsjAiMAOtqlBZIQERbs1bx+RcVGTK
         Bb/FO5EroSOJnRUw6RkCLCfrAAqEk4IK5hHuPLb6AWbADOs9Yv/8LFkxlp+LSHTH2XDu
         NxeQ==
X-Gm-Message-State: AOAM5305DsjQOyGiY3HDRifxGA5KdEncVxGTe5gWTuwupf86k/CfYhup
        2TLsGxTaaltuSK8llQyVBek=
X-Google-Smtp-Source: ABdhPJxbgXr6OgZA3EGAwbaen1JguBYTl9NxRHNiUKITt5VG5EiEHIUn+TKen3Pl/E7xIac+O7GO4w==
X-Received: by 2002:ac2:4906:: with SMTP id n6mr1615427lfi.592.1625182116354;
        Thu, 01 Jul 2021 16:28:36 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:36 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 11/37] gpu: host1x: Add stub driver for MPE, VI, EPP and ISP
Date:   Fri,  2 Jul 2021 02:27:02 +0300
Message-Id: <20210701232728.23591-12-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We never had drivers for MPE, VI, EPP and ISP hardware units on Tegra20
and Tegra30 and they are specified in the device-trees. Thus, a device is
getting created for them by host1x bus, but driver is never getting bound.
After adding support for generic power domains, we now have a situation
where the state of PMC driver is never synced because consumer device
never becomes ready due to the missing drivers and it needs to be synced
in order to allow scaling of SoC core voltage. Add a stub driver in order
to resolve the problem.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/host1x/dev.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 0945df6039af..400a3b9d8857 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -616,7 +616,46 @@ static struct platform_driver tegra_host1x_driver = {
 	.remove = host1x_remove,
 };
 
+/*
+ * We never had drivers for MPE, VI, EPP and ISP hardware units on Tegra20
+ * and Tegra30, but they are specified in the device-trees, and thus,
+ * device entity is getting created for them by host1x bus a, but driver
+ * is never getting bound.  After adding support for generic power domains
+ * on Tegra20/30, we now have a situation where the state of PMC driver is
+ * never synced because consumer device never becomes ready due to the
+ * missing drivers.  The PMC state needs to be synced in order to allow
+ * scaling of the SoC core voltage.  In order to solve this problem,
+ * we will create and bind a dummy driver to the offending devices until
+ * we will have a real driver for them.
+ */
+static const struct of_device_id host1x_stub_of_matches[] = {
+	{ .compatible = "nvidia,tegra20-mpe", },
+	{ .compatible = "nvidia,tegra30-mpe", },
+	{ .compatible = "nvidia,tegra20-epp", },
+	{ .compatible = "nvidia,tegra30-epp", },
+	{ .compatible = "nvidia,tegra20-vi", },
+	{ .compatible = "nvidia,tegra30-vi", },
+	{ .compatible = "nvidia,tegra20-isp", },
+	{ .compatible = "nvidia,tegra30-isp", },
+	{ /* sentinel */ }
+};
+
+static int host1x_stub_probe(struct platform_device *pdev)
+{
+	pm_runtime_enable(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver tegra_host1x_stub_driver = {
+	.driver = {
+		.name = "tegra-host1x-stub",
+		.of_match_table = host1x_stub_of_matches,
+	},
+	.probe = host1x_stub_probe,
+};
+
 static struct platform_driver * const drivers[] = {
+	&tegra_host1x_stub_driver,
 	&tegra_host1x_driver,
 	&tegra_mipi_driver,
 };
-- 
2.30.2

