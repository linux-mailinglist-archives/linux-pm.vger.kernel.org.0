Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC653F9203
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 03:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244006AbhH0Bit (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 21:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243988AbhH0Bir (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 21:38:47 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC029C061757;
        Thu, 26 Aug 2021 18:37:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j4so10921953lfg.9;
        Thu, 26 Aug 2021 18:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CXaK/5nv+UW78r8SKxW/ix4L99XrgI4rfiEmtKQrQYc=;
        b=WC5cOLrjFcCPvHIv6Rwms6Y0kwCm01/4ksbMHYGDIaPkMsMJljZQcvP1/ebYJWmmXf
         xZDLvLrBpaHi1dAp9gkPTVoNL4CgD0wJMJRZhoZ7K82bQxmdzrHlKmCg6W5wfqVjPCZQ
         N+IxerMT0zVArwDfblk7TAVSOlJJhXx3VeQi46AkH3MfeBe8Pk+x9hJXqV6Q4IfhVqZh
         9MRIFmw/YjkSBNoouXW1SQIJabIpa6MWAVIIodj5xRsAiVY+AQwYvXJ267teR3T4sX5i
         sDFPl985HszyszqhQXHkotQbKAYuyao+UHHGiF2t+ABHZqGywQE/HevM8cMM2PoPwP38
         u/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CXaK/5nv+UW78r8SKxW/ix4L99XrgI4rfiEmtKQrQYc=;
        b=EkPp0K1cKulxI3nnGoNDdkzs0GUhdRvFzW0KlKCEG/EWX/JIZYVMekERkGUb8NI07y
         YhhqY84SREBTsK0n78m1/Fi02seARAwcIrNGE7pjZYgl0vl9TiEubjnJNOmFYqUNOXdk
         UauthTG4cIrRDiF8KYB+957cA1LSqisYwJZgjQgeezAaUZ3QUJ5kCgFb5bdxIvtEDIYQ
         XGfi49LXESMOjsLbQiYxZ1SaKfR1RWG6qnH8oIITOwlf5nDclLfj31HwpQz8XwCPGuNt
         JZ7F7YDGOK+q7C1Bg5WzbtZZuMv2VEZ8mhFQnSM0uT71MIhBiguXhUJwsJ4wcV6stE9G
         mZjg==
X-Gm-Message-State: AOAM531LVwlGyR85SkAsF2MtkIOyynnFMIe3+XD6wy+t0m48As6Mwr07
        STGptQdtZWZ5yj7msBQpoBs=
X-Google-Smtp-Source: ABdhPJzSi5yPgYUpKQNd9GxZw+0qvkRCn+wNHynWiX4ttlnKYx2sgZQXDNe8Cflg61i0ZoXRBKMB+w==
X-Received: by 2002:a19:ee15:: with SMTP id g21mr4824580lfb.182.1630028277350;
        Thu, 26 Aug 2021 18:37:57 -0700 (PDT)
Received: from localhost.localdomain (94-29-17-251.dynamic.spd-mgts.ru. [94.29.17.251])
        by smtp.gmail.com with ESMTPSA id y3sm494289lfa.240.2021.08.26.18.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 18:37:56 -0700 (PDT)
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
Subject: [PATCH v9 4/8] PM: domains: Add get_performance_state() callback
Date:   Fri, 27 Aug 2021 04:34:11 +0300
Message-Id: <20210827013415.24027-5-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210827013415.24027-1-digetx@gmail.com>
References: <20210827013415.24027-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add get_performance_state() callback that retrieves and initializes
performance state of a device attached to a power domain. This removes
inconsistency of the performance state with hardware state.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/base/power/domain.c | 32 +++++++++++++++++++++++++++++---
 include/linux/pm_domain.h   |  2 ++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3a13a942d012..8b828dcdf7f8 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2700,15 +2700,41 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 		goto err;
 	} else if (pstate > 0) {
 		ret = dev_pm_genpd_set_performance_state(dev, pstate);
-		if (ret)
+		if (ret) {
+			dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
+				pd->name, ret);
 			goto err;
+		}
 		dev_gpd_data(dev)->default_pstate = pstate;
 	}
+
+	if (pd->get_performance_state && !dev_gpd_data(dev)->default_pstate) {
+		bool dev_suspended = false;
+
+		ret = pd->get_performance_state(pd, base_dev, &dev_suspended);
+		if (ret < 0) {
+			dev_err(dev, "failed to get performance state for power-domain %s: %d\n",
+				pd->name, ret);
+			goto err;
+		}
+
+		pstate = ret;
+
+		if (dev_suspended) {
+			dev_gpd_data(dev)->rpm_pstate = pstate;
+		} else if (pstate > 0) {
+			ret = dev_pm_genpd_set_performance_state(dev, pstate);
+			if (ret) {
+				dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
+					pd->name, ret);
+				goto err;
+			}
+		}
+	}
+
 	return 1;
 
 err:
-	dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
-		pd->name, ret);
 	genpd_remove_device(pd, dev);
 	return ret;
 }
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 67017c9390c8..4f78b31791ae 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -133,6 +133,8 @@ struct generic_pm_domain {
 						 struct dev_pm_opp *opp);
 	int (*set_performance_state)(struct generic_pm_domain *genpd,
 				     unsigned int state);
+	int (*get_performance_state)(struct generic_pm_domain *genpd,
+				     struct device *dev, bool *dev_suspended);
 	struct gpd_dev_ops dev_ops;
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	ktime_t next_wakeup;	/* Maintained by the domain governor */
-- 
2.32.0

