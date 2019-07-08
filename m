Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DADFA61A7A
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 08:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfGHGAU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 02:00:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33417 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfGHGAU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2019 02:00:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id c14so7660696plo.0
        for <linux-pm@vger.kernel.org>; Sun, 07 Jul 2019 23:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6q22eQDDCUZWlcpujovTPxDLV/PDTFZTJgjMkPGNMDU=;
        b=qCFcjFeCt5a05VcS5Cjwgn22CsE/7DQLunpoWaYJxF06aSHKpcocF0SZYql/0vvOYP
         gPHsR+rNQ8P0MLJcpgJMZv56u/hBqdpZ+4ywoAGXcYG7ooS3XQGOlYkBql1rIr38HYqu
         zXO/ZmzprkLvQ+rKetYp4s1jyIcpCCyb5Yum+pq78zZQC78pLqdUN+WUEssnXexeUcl2
         6r7akeSW1kIBwVhljmpM32CmF2uqDXRZRx1l3pUy2HmHEpgzOjQvbhy6q8r+XK8pAmUJ
         0nOeDi2SQsTmFSpK+2c+gl8zE08CvsvEj+Ys1POjFUK/eul15t4sQnwNGka0hZ+Hicpr
         VmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6q22eQDDCUZWlcpujovTPxDLV/PDTFZTJgjMkPGNMDU=;
        b=RcO0wO306MndHxB7nlIfbFD9Q6i8F9WAU9ezeOQe5Tq/FWwARG/350FgS2GKzJfd7S
         3lkaFVm205ICgLevbZMKCCYYHckTO4BypP19guwljyAdTWJXhKJqihqnliBcpzmE7XTY
         sF89E96+GzAvcT2Fp+KWeEwcrP+OK8rP1CTsTjpR0XkndN46+j5Aa5grjOUKoJ8TMWx1
         SWpOL2MwgkyJXRzMT4tps+d/7te0BUePCXd+bDq+3r8Mu6JtylnbNp7haT68OA0v58zp
         xl5mpMEg3KmPWdhM1t6FPjCqzAzCM6kckHYNKAon7S1gInpezatNwjI6KV7F4Y9aN+Nh
         cKzw==
X-Gm-Message-State: APjAAAV/3WnNgnYRo0MjlpqGaPVfYXFlrb/WAjOGGdGykmQWJTqDdVJe
        wzly+dGA1eAcWpWkJpzDhMTnFA==
X-Google-Smtp-Source: APXvYqzCH6JkIGIMDnIOEIFv7dTqbgSevQnLuknmocRwHgxJb1MtM345JVgkwrUtGfT2CEe7k8z8kg==
X-Received: by 2002:a17:902:1e7:: with SMTP id b94mr22716751plb.333.1562565619188;
        Sun, 07 Jul 2019 23:00:19 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id f15sm21479445pje.17.2019.07.07.23.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 23:00:18 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Return genpd virtual devices from dev_pm_opp_attach_genpd()
Date:   Mon,  8 Jul 2019 11:30:11 +0530
Message-Id: <027985ce35873cd218298302a1408da06d48458b.1562565567.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
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
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
@Rajendra: Can you please test this one ? I have only compile tested it.

 drivers/opp/core.c     | 5 ++++-
 include/linux/pm_opp.h | 4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2958cc7bbb58..07b6f1187b3b 100644
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
@@ -1789,7 +1790,8 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
  * This helper needs to be called once with a list of all genpd to attach.
  * Otherwise the original device structure will be used instead by the OPP core.
  */
-struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names)
+struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
+		const char **names, struct device ***virt_devs)
 {
 	struct opp_table *opp_table;
 	struct device *virt_dev;
@@ -1850,6 +1852,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names
 		name++;
 	}
 
+	*virt_devs = opp_table->genpd_virt_devs;
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

