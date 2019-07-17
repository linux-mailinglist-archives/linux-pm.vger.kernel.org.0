Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF176B9F7
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 12:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfGQKT6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 06:19:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34508 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfGQKT5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 06:19:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so4716929pgc.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2019 03:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VK4VAAKwmD6vCOcxsuweQdA7aImoD6BI1bwtOEYy7Ec=;
        b=AJQ2aUxdLzlHM27/CtHDPhhfUR2r74bNE+Fqr8namI4DMjtm0Ji7+gNHpxvvqiRDFx
         bS/TqlbQ6J90Uxwy03MVOU1uUp0BxIa1DOVdxUbaoshON5cRSy5QWQOcrDfOaIEIPcdP
         Gj2ufs3wvpr0tw0Iq50TgspWBICEBWEol53OGPNkl8cZtKwGcqeS38ztPFf5v/Wd+nLa
         kX3Mi6+0hE6FPSjCsz+vronqX1BzubKEO3WPstJw0glwlOgwWZqVOv/G7bW0m2LHVVGK
         zPjPsD7GYAXYfav8ZhSf5kMBqYM5zQNLyMN2FfN9Agg5SVevn8e/U2FH1BycN/4I9raM
         ejMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VK4VAAKwmD6vCOcxsuweQdA7aImoD6BI1bwtOEYy7Ec=;
        b=aWMNDQdLhy/p9JTWn5oDa5TwyNGyu8lSdTZXYItOck4mKPpxnZBhtCjLJLbIQVFpLU
         L9vB3Jo38sX+bImFbTnSm3dmCh3P0b9O/QrKW78ZodYpVLd9+yJL5L6XUduVKHERhVxd
         BXclfG+3ZwCgwfIxbj7CGPz1QxtULmCc2e6BDxrsbqGFXnE1k/jtu4cSNImgBpMTpEqf
         3i/KgaM4t/G/RlX+j82TtC0pyd5nSLWdCalkHNJ0UAlLOs3hEVRtdHA4XRHsISSw9JSa
         G0tMk+yPC8QGJ/2jdf7K0g4XsyzEggnmbpK3xqCU6VJPEpnjgEkPUN850ZRJ+Q6GSgWH
         RSnw==
X-Gm-Message-State: APjAAAVK+Fn1DRLEqIuTk1tT9jaUmpWvI9Ox39NEGFPTry9iqzVg4Lzh
        Yqf+T17e1LaE1d8FzbefwAc/fg==
X-Google-Smtp-Source: APXvYqyHlVMuMahTL4YiiobGoIz/ikKUUA807jg2o7LAg2+WQ8WsgPVx+k4SS6QyIEowyz5oHtjfGA==
X-Received: by 2002:a63:9318:: with SMTP id b24mr30127568pge.31.1563358796826;
        Wed, 17 Jul 2019 03:19:56 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id r1sm27721976pfq.100.2019.07.17.03.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 03:19:56 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        niklas.cassel@linaro.org, Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/2] opp: Return genpd virtual devices from dev_pm_opp_attach_genpd()
Date:   Wed, 17 Jul 2019 15:49:47 +0530
Message-Id: <aaf5648b925aed79ffdd416be44a05ab3c8d2058.1563358721.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <90ba3941b56e50ea5548dd1e90bf3bcd8c9da4fe.1563358721.git.viresh.kumar@linaro.org>
References: <90ba3941b56e50ea5548dd1e90bf3bcd8c9da4fe.1563358721.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpufreq drivers don't need to do runtime PM operations on the
virtual devices returned by dev_pm_domain_attach_by_name() and so the
virtual devices weren't shared with the callers of
dev_pm_opp_attach_genpd() earlier.

But the IO device drivers would want to do that. This patch updates the
prototype of dev_pm_opp_attach_genpd() to accept another argument to
return the pointer to the array of genpd virtual devices.

Reported-by: Rajendra Nayak <rnayak@codeaurora.org>
Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- Check virt_devs pointer before assigning.

 drivers/opp/core.c     | 6 +++++-
 include/linux/pm_opp.h | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 4e2a81698cd2..1f11f8c92337 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1775,6 +1775,7 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
  * dev_pm_opp_attach_genpd - Attach genpd(s) for the device and save virtual device pointer
  * @dev: Consumer device for which the genpd is getting attached.
  * @names: Null terminated array of pointers containing names of genpd to attach.
+ * @virt_devs: Pointer to return the array of virtual devices.
  *
  * Multiple generic power domains for a device are supported with the help of
  * virtual genpd devices, which are created for each consumer device - genpd
@@ -1792,7 +1793,8 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
  * The order of entries in the names array must match the order in which
  * "required-opps" are added in DT.
  */
-struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names)
+struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
+		const char **names, struct device ***virt_devs)
 {
 	struct opp_table *opp_table;
 	struct device *virt_dev;
@@ -1846,6 +1848,8 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names
 		name++;
 	}
 
+	if (virt_devs)
+		*virt_devs = opp_table->genpd_virt_devs;
 	mutex_unlock(&opp_table->genpd_virt_dev_lock);
 
 	return opp_table;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index be570761b77a..7c2fe2952f40 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -131,7 +131,7 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
-struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names);
+struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
 void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
@@ -295,7 +295,7 @@ static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const
 
 static inline void dev_pm_opp_put_clkname(struct opp_table *opp_table) {}
 
-static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names)
+static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs)
 {
 	return ERR_PTR(-ENOTSUPP);
 }
-- 
2.21.0.rc0.269.g1a574e7a288b

