Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8FF30A179
	for <lists+linux-pm@lfdr.de>; Mon,  1 Feb 2021 06:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhBAFft (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 00:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhBAF0n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 00:26:43 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504CBC061788
        for <linux-pm@vger.kernel.org>; Sun, 31 Jan 2021 21:26:03 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b17so9311965plz.6
        for <linux-pm@vger.kernel.org>; Sun, 31 Jan 2021 21:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hyCbJ5C1U0jhyHzgth+W27DNhqxYiX9hLv7SxsUG93M=;
        b=FIU/K7ovjvq10voKnofpgZgU18RA3s5adxgBfci9bHGfKY9NkenLMGLG1+WvmSre0X
         et5AWA1YYxCudlNEdZBlB7Jipu5yFWb6Idz2IQW6vTIioG8yp5rvfrP9QEl2BMo9yg52
         DcqBMD0p/rrbefE2pYXmC+ucsG96yIJ21iFNk8fGN+/azVdnGMrtE4pOJSllwvVDTt3/
         NxyQMLJ3NlCGYwjV6wt2/5FRezT1vIEQMKcByepVnpUZNEXfUoUqVUcAXdzdZU0nknsh
         ocXvSVGsuomFDdOOEdkVJgEYUGsLFrUbOHSLg7TKdOD6B9l7Nx5dV6QbbxLIH0m2GJH3
         n3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hyCbJ5C1U0jhyHzgth+W27DNhqxYiX9hLv7SxsUG93M=;
        b=Nxh9QPjnP/NVNyiFFDRqOmO/IOE3WNuiSHtP3ZF168v/mRYFB5scngvKVXZ6UJ96CQ
         fg15GfQev3LsIlZUjDOU3mepVltQqO0dMpd5MaOmRqPSGpJFSc21jqGGHCKB0ahuDCRG
         Wjh3QmZqrjc9gauU5HHEGubUlzkc+6SxwF2TfEOvLd/yUijXwHPQ53QModTasutrVe6W
         iPcnRhPTvcdISis4xXAA85Y8mzq6wIf5hbnyqZpAzUcCI6KuKq3QoSoPBrOZs2yXh/cU
         GIv0nsn8XlCTcVCOmpRcVZ88OWy9GYF5a2ERfgRDxTJlPij1awBGNSQJkd8xFSImG1Ck
         0/NQ==
X-Gm-Message-State: AOAM532Wq3j6e+ZAaa5mF1uqh4v84cMl9qudXHpzB5YO1lDYZv5SUllE
        GvgxWNrL//aoPWqgAkPKpwxRfdbCIIeTJA==
X-Google-Smtp-Source: ABdhPJwc201JNCMQKddW8BMqYuHkI+eMFbq/BEWg3d4dPI3BiM5+exCSqHLG9ANupKcSgwfQNos6pg==
X-Received: by 2002:a17:90a:c003:: with SMTP id p3mr15597323pjt.176.1612157162786;
        Sun, 31 Jan 2021 21:26:02 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id g17sm16770198pgg.78.2021.01.31.21.26.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jan 2021 21:26:02 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] opp: Replace ENOTSUPP with EOPNOTSUPP
Date:   Mon,  1 Feb 2021 10:55:54 +0530
Message-Id: <76b98d6560cea9cb0710a05632ebfeabd777d03a.1612157127.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <2f66b83d10ed4a1c4523b7263f8a29097622858c.1612157127.git.viresh.kumar@linaro.org>
References: <2f66b83d10ed4a1c4523b7263f8a29097622858c.1612157127.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Checkpatch gives following warning for new patches, and the new patches
normally follow the existing standards for such stuff. Lets fix it
properly.

WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/pm_opp.h | 64 +++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index c6c7d73eb015..ab1d15ce559d 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -167,12 +167,12 @@ int dev_pm_opp_sync_regulators(struct device *dev);
 #else
 static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *dev, int index)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline void dev_pm_opp_put_opp_table(struct opp_table *opp_table) {}
@@ -232,37 +232,37 @@ static inline unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					unsigned long freq, bool available)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
 					unsigned int level)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
 					unsigned int *level)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					unsigned long *freq)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil_by_volt(struct device *dev,
 					unsigned long u_volt)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					unsigned long *freq)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline void dev_pm_opp_put(struct dev_pm_opp *opp) {}
@@ -270,7 +270,7 @@ static inline void dev_pm_opp_put(struct dev_pm_opp *opp) {}
 static inline int dev_pm_opp_add(struct device *dev, unsigned long freq,
 					unsigned long u_volt)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline void dev_pm_opp_remove(struct device *dev, unsigned long freq)
@@ -301,19 +301,19 @@ static inline int dev_pm_opp_disable(struct device *dev, unsigned long freq)
 
 static inline int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int dev_pm_opp_unregister_notifier(struct device *dev, struct notifier_block *nb)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev,
 							    const u32 *versions,
 							    unsigned int count)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline void dev_pm_opp_put_supported_hw(struct opp_table *opp_table) {}
@@ -321,7 +321,7 @@ static inline void dev_pm_opp_put_supported_hw(struct opp_table *opp_table) {}
 static inline struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 			int (*set_opp)(struct dev_pm_set_opp_data *data))
 {
-	return ERR_PTR(-ENOTSUPP);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table) {}
@@ -330,33 +330,33 @@ static inline struct opp_table *
 devm_pm_opp_register_set_opp_helper(struct device *dev,
 				    int (*set_opp)(struct dev_pm_set_opp_data *data))
 {
-	return ERR_PTR(-ENOTSUPP);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline void dev_pm_opp_put_prop_name(struct opp_table *opp_table) {}
 
 static inline struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline void dev_pm_opp_put_regulators(struct opp_table *opp_table) {}
 
 static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline void dev_pm_opp_put_clkname(struct opp_table *opp_table) {}
 
 static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline void dev_pm_opp_detach_genpd(struct opp_table *opp_table) {}
@@ -364,27 +364,27 @@ static inline void dev_pm_opp_detach_genpd(struct opp_table *opp_table) {}
 static inline struct opp_table *devm_pm_opp_attach_genpd(struct device *dev,
 				const char **names, struct device ***virt_devs)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
@@ -402,7 +402,7 @@ static inline void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask
 
 static inline int dev_pm_opp_sync_regulators(struct device *dev)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 #endif		/* CONFIG_PM_OPP */
@@ -427,17 +427,17 @@ static inline void dev_pm_opp_of_unregister_em(struct device *dev)
 #else
 static inline int dev_pm_opp_of_add_table(struct device *dev)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int dev_pm_opp_of_add_table_noclk(struct device *dev, int index)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline void dev_pm_opp_of_remove_table(struct device *dev)
@@ -446,7 +446,7 @@ static inline void dev_pm_opp_of_remove_table(struct device *dev)
 
 static inline int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask)
@@ -455,7 +455,7 @@ static inline void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpum
 
 static inline int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
@@ -471,7 +471,7 @@ static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
 static inline int dev_pm_opp_of_register_em(struct device *dev,
 					    struct cpumask *cpus)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline void dev_pm_opp_of_unregister_em(struct device *dev)
@@ -480,12 +480,12 @@ static inline void dev_pm_opp_of_unregister_em(struct device *dev)
 
 static inline int of_get_required_opp_performance_state(struct device_node *np, int index)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int dev_pm_opp_of_find_icc_paths(struct device *dev, struct opp_table *opp_table)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 #endif
 
-- 
2.25.0.rc1.19.g042ed3e048af

