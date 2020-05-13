Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDB61D08CF
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 08:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgEMGlo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 02:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbgEMGln (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 02:41:43 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFFFC061A0C
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 23:41:43 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b12so4529299plz.13
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 23:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TEOOM5pOLFuCD0JNuG+xQHOyUpCjh1jvRN2yDj9HYr0=;
        b=EH/x+7C1HU7YxLs7m98yahVwIJPnz8bxLR2i6LAqgFXxc8rwzlEAY/xf9Dh8/p/7iI
         sqAjzbuzA9ZELOOxe8qQ1Qg4KaXF/LAv8Ozldpi25gg5qZ6uJMPk5eyBWlQt9cQd8r8j
         3OrASK4tYsAmkX+tNPDKYPJBfjHBVsHNdp7SjvXsfp2xDihh4VlI104Umg7ogMA21eLI
         wthunohJNL1Y+VkmEjNE8CZr/L4Ou+7pT0bVHqgM3iYLjk6t8T9V0MCEVK1jF3Sz0Mfu
         WzYtuKxG+NQQeeNgJHwQ5QYFpUlY6J7PjIsLeLclo7vtV6CYgzZl3ataQINy/zEQC57s
         Ddqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TEOOM5pOLFuCD0JNuG+xQHOyUpCjh1jvRN2yDj9HYr0=;
        b=mXNGflNt/EF6SJFtULoZ253/zAKEjNt14KeDPpB1w0ADYkTm6XmRi1obwGuAnDPT4u
         A/Lkv7SE+WRuHwhNCvKgErJAI2PUiouL/9alA6YbHt/KWbDnP5j3uOKZEsAYlOOjdeUj
         eieNrPgCeBBkyS5QHI7fUK4UuuujGQ0uo/3lI13ufbhCZVaWqcpceHpheDD+TDaCH5gU
         FZWVGtSze0qxQ1J/KzQJgClajqwla8k7VyWP12pdCrbZ1OibtzPwrRCPj9Ln/64l3Sxx
         1Y6+5UQnChwlVgRXF7MFa68kLq0Eq0hHnYFCRQfgP+gUOFHdLs36x/dbZvgqiq2VcbIM
         1PYg==
X-Gm-Message-State: AOAM530jjrFs2xIxMf5deHgj5Gp5Pb26w14uByuJga6H32o2KzDpe0dM
        X3jw3yd7AATWnoY9dBc/3nYw6Q==
X-Google-Smtp-Source: ABdhPJxsasRtKgMGmifMB6ARKkzFRs15NkOKQ9hC/Cq0i7VetsjNOJuBOne18nCwbu0LkEPx+sI3+A==
X-Received: by 2002:a17:902:a714:: with SMTP id w20mr13716550plq.336.1589352102800;
        Tue, 12 May 2020 23:41:42 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id 9sm12174992pgr.17.2020.05.12.23.41.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 23:41:41 -0700 (PDT)
Date:   Wed, 13 May 2020 12:11:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org,
        robh+dt@kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 04/10] OPP: Add support for parsing interconnect
 bandwidth
Message-ID: <20200513064139.5kxjjddcooqcvny3@vireshk-i7>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
 <20200512125327.1868-5-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512125327.1868-5-georgi.djakov@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-05-20, 15:53, Georgi Djakov wrote:
> The OPP bindings now support bandwidth values, so add support to parse it
> from device tree and store it into the new dev_pm_opp_icc_bw struct, which
> is part of the dev_pm_opp.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> v8:
> * Drop bandwidth requests and free memory in _opp_table_kref_release.
> * Take into account the supply_count in struct size calculations.
> * Free the temporary arrays for peak and average bandwidth.
> * Fix the check for opp-level.
> * Use dev_warn insted of dev_dbg.
> * Rename _of_find_icc_paths to _of_find_icc_paths.
> * Rename the variable count to supply_count.

Added this delta to this patch:

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index a3dd0bc9b9f6..8b640eac86d5 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1000,7 +1000,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	}
 
 	/* Find interconnect path(s) for the device */
-	ret = _of_find_icc_paths(opp_table, dev);
+	ret = dev_pm_opp_of_find_icc_paths(dev, opp_table);
 	if (ret)
 		dev_warn(dev, "%s: Error finding interconnect paths: %d\n",
 			 __func__, ret);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index a41c0dc2ac04..15f30ed70bbc 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -332,10 +332,12 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
 	return ret;
 }
 
-int _of_find_icc_paths(struct opp_table *opp_table, struct device *dev)
+int dev_pm_opp_of_find_icc_paths(struct device *dev,
+				 struct opp_table *opp_table)
 {
 	struct device_node *np;
 	int ret, i, count, num_paths;
+	struct icc_path **paths;
 
 	np = of_node_get(dev->of_node);
 	if (!np)
@@ -354,15 +356,14 @@ int _of_find_icc_paths(struct opp_table *opp_table, struct device *dev)
 	}
 
 	num_paths = count / 2;
-	opp_table->paths = kcalloc(num_paths, sizeof(*opp_table->paths),
-				   GFP_KERNEL);
-	if (!opp_table->paths)
+	paths = kcalloc(num_paths, sizeof(*paths), GFP_KERNEL);
+	if (!paths)
 		return -ENOMEM;
 
 	for (i = 0; i < num_paths; i++) {
-		opp_table->paths[i] = of_icc_get_by_index(dev, i);
-		if (IS_ERR(opp_table->paths[i])) {
-			ret = PTR_ERR(opp_table->paths[i]);
+		paths[i] = of_icc_get_by_index(dev, i);
+		if (IS_ERR(paths[i])) {
+			ret = PTR_ERR(paths[i]);
 			if (ret != -EPROBE_DEFER) {
 				dev_err(dev, "%s: Unable to get path%d: %d\n",
 					__func__, i, ret);
@@ -370,19 +371,23 @@ int _of_find_icc_paths(struct opp_table *opp_table, struct device *dev)
 			goto err;
 		}
 	}
-	opp_table->path_count = num_paths;
+
+	if (opp_table) {
+		opp_table->paths = paths;
+		opp_table->path_count = num_paths;
+	}
 
 	return 0;
 
 err:
 	while (i--)
-		icc_put(opp_table->paths[i]);
+		icc_put(paths[i]);
 
-	kfree(opp_table->paths);
-	opp_table->paths = NULL;
+	kfree(paths);
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_find_icc_paths);
 
 static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
 			      struct device_node *np)
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 17d45119d9bc..2b81ffef1ba4 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -231,14 +231,12 @@ void _of_clear_opp_table(struct opp_table *opp_table);
 struct opp_table *_managed_opp(struct device *dev, int index);
 void _of_opp_free_required_opps(struct opp_table *opp_table,
 				struct dev_pm_opp *opp);
-int _of_find_icc_paths(struct opp_table *opp_table, struct device *dev);
 #else
 static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index) {}
 static inline void _of_clear_opp_table(struct opp_table *opp_table) {}
 static inline struct opp_table *_managed_opp(struct device *dev, int index) { return NULL; }
 static inline void _of_opp_free_required_opps(struct opp_table *opp_table,
 					      struct dev_pm_opp *opp) {}
-static inline int _of_find_icc_paths(struct opp_table *opp_table, struct device *dev) { return 0; }
 #endif
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index cfceb0290401..d5c4a329321d 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -372,6 +372,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
 struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
 int of_get_required_opp_performance_state(struct device_node *np, int index);
+int dev_pm_opp_of_find_icc_paths(struct device *dev, struct opp_table *opp_table);
 void dev_pm_opp_of_register_em(struct cpumask *cpus);
 #else
 static inline int dev_pm_opp_of_add_table(struct device *dev)
@@ -420,6 +421,11 @@ static inline int of_get_required_opp_performance_state(struct device_node *np,
 {
 	return -ENOTSUPP;
 }
+
+static inline int dev_pm_opp_of_find_icc_paths(struct device *dev, struct opp_table *opp_table)
+{
+	return -ENOTSUPP;
+}
 #endif
 
 #endif		/* __LINUX_OPP_H__ */

-- 
viresh
