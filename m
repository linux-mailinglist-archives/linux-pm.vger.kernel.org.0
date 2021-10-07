Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D943B424D06
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 08:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240226AbhJGGGQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 02:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240212AbhJGGGP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 02:06:15 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAC0C061762;
        Wed,  6 Oct 2021 23:04:22 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 11so3480207qvd.11;
        Wed, 06 Oct 2021 23:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HNsfnJd+5kS80akoo8bxdjzrR4smQrHB5wW716HCL/U=;
        b=AwOVSu2KnBDEnKj72Rjg6LT4qZmGDufDaNvanRPXjPrzNg3mnZQ5AXJiX3aM+zooz/
         F99klJJW86reoPrtbAJqYt5LNXyccKYO0lrp4GMUCK5ebSFdnrIOD2ENAjfzss5EYWaD
         d94IG5xE7H5LQvyAwZFqavldd105j33Qk3DHXE+Knm1H0yt1/CMlxfUlVgfcNnu9FdST
         foBffZwR0/wAHaYNQQH2OOYp4ohqkrsEh6OBWb+xIO2gdkstOH75yLJWhHwGi6qVQxrR
         B4as6RSYhPFyQ4EcIGvKSuj1rgAnRAo5V2x6bhrU6ByhlKAa7r4Q3+Ov9ETtfzYXC+p5
         UR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HNsfnJd+5kS80akoo8bxdjzrR4smQrHB5wW716HCL/U=;
        b=4uRQlotWiKY06XzJs+1vBm/zHlfQSbWhdIty7a31zB33BJd7NGg/K4l8Obj/Zv4gA0
         I0R4s0q0UzwHnVBKXYSUGTym0vRCUfSM69sgOGwyIDCL+pIQNuB8yVLD33p7UjlwKD74
         MtpPTW59mYZz2jQiplYjiMVjXxEmjvAC59fSs8Nl2sXTGENba8FWxEczi0kJjlWlelfu
         0k1KtTu2AiJomlGbvMnNR4ni8GbSwilB7+6Dm9lsrtnh+m/iy1+bTv75wTOy7Bs4nxPE
         0Vc/QbSI9sA6KbYewUzYpUOarQJA7dR6p+qKcsBx5ES3VPtF97fXl1VSsFM96ZNU82DS
         46xw==
X-Gm-Message-State: AOAM530gYetroE5FnomtCki3R8y/geuPglGkfKTi4VfkpLa5j+M4BsZB
        tRr0RdHFKeW2mD8QN9K8vwk=
X-Google-Smtp-Source: ABdhPJyoERJF+dBkQiPBDLcF0qOcjYVLRaaI9m+OEpsXDIQNfiZSg2J2U3RkUrNAd+vGD7XGTXM6jQ==
X-Received: by 2002:a05:6214:1022:: with SMTP id k2mr2188082qvr.53.1633586661289;
        Wed, 06 Oct 2021 23:04:21 -0700 (PDT)
Received: from localhost.localdomain (79-139-163-57.dynamic.spd-mgts.ru. [79.139.163.57])
        by smtp.gmail.com with ESMTPSA id x79sm13235042qkb.65.2021.10.06.23.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 23:04:20 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v1 3/6] kernel: Add devm_register_restart_handler()
Date:   Thu,  7 Oct 2021 09:02:50 +0300
Message-Id: <20211007060253.17049-4-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211007060253.17049-1-digetx@gmail.com>
References: <20211007060253.17049-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add resource-managed variant of register_restart_handler().

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/reboot.h |  2 ++
 kernel/reboot.c        | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index f72fb8729608..fb17fad63e53 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -49,6 +49,8 @@ extern int register_restart_handler(struct notifier_block *);
 extern int unregister_restart_handler(struct notifier_block *);
 extern void do_kernel_restart(char *cmd);
 
+extern int devm_register_restart_handler(struct device *, struct notifier_block *);
+
 extern int register_poweroff_handler(struct notifier_block *);
 extern int unregister_poweroff_handler(struct notifier_block *);
 
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 6e90afec2bb8..b611e49a5ac6 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -200,6 +200,33 @@ int unregister_restart_handler(struct notifier_block *nb)
 }
 EXPORT_SYMBOL(unregister_restart_handler);
 
+static void devm_unregister_restart_handler(struct device *dev, void *res)
+{
+	WARN_ON(unregister_restart_handler(*(struct notifier_block **)res));
+}
+
+int devm_register_restart_handler(struct device *dev, struct notifier_block *nb)
+{
+	struct notifier_block **rcnb;
+	int ret;
+
+	rcnb = devres_alloc(devm_unregister_restart_handler,
+			    sizeof(*rcnb), GFP_KERNEL);
+	if (!rcnb)
+		return -ENOMEM;
+
+	ret = register_restart_handler(nb);
+	if (!ret) {
+		*rcnb = nb;
+		devres_add(dev, rcnb);
+	} else {
+		devres_free(rcnb);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(devm_register_restart_handler);
+
 /**
  *	do_kernel_restart - Execute kernel restart handler call chain
  *
-- 
2.32.0

