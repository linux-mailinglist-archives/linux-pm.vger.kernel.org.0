Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B733D2FE935
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 12:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbhAULsK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 06:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729851AbhAULVM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 06:21:12 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1549EC0617BA
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:19:22 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id g15so1461707pjd.2
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tpbd5REqcbcRMd0xcpf9T6/Cw9coNwWGEmGNqj2MIho=;
        b=cQ5rRy39r5+ufO+3BswxSSkFJ7+Jpm6N1g2Hni+fnN4oxrLV9pPReJ1frk5GKLuUml
         f+U1YMG533Xe2z8g69+kCFjMwktlTruBmh0C3cLNfwpeEOXXKu5j6AvKTUX4JExQxbtp
         IycMCPFvd8AB6R3DAEhE4y+LNhWYguX9xhl/bhiDNtGU+hPTm95rvzqFxoYTUl7ZArFg
         xQqneH2veT3wjgjuoC5folDhjA+5nktphXldfMpVgci8UVrjbj0twVuNKYpnkOxc6p2n
         ZODeYkUs9DjKiBV3Z+V9zOrDpDgz4n3CnatGQIqOezN3qBCn3geZ7pFlKDH83G2zIuov
         Gdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tpbd5REqcbcRMd0xcpf9T6/Cw9coNwWGEmGNqj2MIho=;
        b=h8n2E/YzKlgpKigSS47hNDjdjUGgDFCQEx7b6EF5c96u4V7ELdmnXSDvJc3HruJSUx
         Ls68BPm4GZASjUrlAO7/2qxYiR8kiYx7udOdvQlB8ccrg5lIV61FZjh2oafde7EnLVqL
         YhJywppGWIgsjjaJeoou1kC1xxmQnl0Pf9rgUfzvDzfqYXv8xHiQRXqlyqi4nv4eC0Ku
         PAdXJiKyA5hs9krGHQbCKOmwJOQCTI0yJghRiarmmPQSAWpYYYwdQUUKIMevqE82Z32y
         PMM2Ngg3ToIE+kG6gT2Wj/B2lnK9rlmfNDAgzyiKxd0cEhxzLi9l6VJwkON4jiPppeYa
         OlJA==
X-Gm-Message-State: AOAM532f0tAI53mKe7r8XgzH0FcFd83gOQ9PrpvZzTscXDK/7ih23F4Y
        1m4krdyz33eHvhqvRKyg25tOEQ==
X-Google-Smtp-Source: ABdhPJwFngayl7Kb87/6CN0WzGWc0iYnvTw6xgMXD3fCZ+Ox7Ja9cmNj8T9QjiUNNOF7BbJad6fLcA==
X-Received: by 2002:a17:902:a412:b029:db:cf5a:8427 with SMTP id p18-20020a170902a412b02900dbcf5a8427mr14517166plq.48.1611227961615;
        Thu, 21 Jan 2021 03:19:21 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id fs21sm5401300pjb.30.2021.01.21.03.19.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 03:19:21 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 13/13] opp: Remove dev_pm_opp_set_bw()
Date:   Thu, 21 Jan 2021 16:47:53 +0530
Message-Id: <45684bf5b7b9004808d412f8d749c536970fe165.1611227342.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611227342.git.viresh.kumar@linaro.org>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All the users have migrated to dev_pm_opp_set_opp() now, get rid of the
duplicate API, dev_pm_opp_set_bw(), which only performs a part of the new API.

While at it, remove the unnecessary parameter to _set_opp_bw().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 41 +++++------------------------------------
 include/linux/pm_opp.h |  6 ------
 2 files changed, 5 insertions(+), 42 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 5a367ef02b92..d8ca15d96ce9 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -798,7 +798,7 @@ static int _generic_set_opp_regulator(struct opp_table *opp_table,
 }
 
 static int _set_opp_bw(const struct opp_table *opp_table,
-		       struct dev_pm_opp *opp, struct device *dev, bool remove)
+		       struct dev_pm_opp *opp, struct device *dev)
 {
 	u32 avg, peak;
 	int i, ret;
@@ -807,7 +807,7 @@ static int _set_opp_bw(const struct opp_table *opp_table,
 		return 0;
 
 	for (i = 0; i < opp_table->path_count; i++) {
-		if (remove) {
+		if (!opp) {
 			avg = 0;
 			peak = 0;
 		} else {
@@ -817,7 +817,7 @@ static int _set_opp_bw(const struct opp_table *opp_table,
 		ret = icc_set_bw(opp_table->paths[i], avg, peak);
 		if (ret) {
 			dev_err(dev, "Failed to %s bandwidth[%d]: %d\n",
-				remove ? "remove" : "set", i, ret);
+				opp ? "set" : "remove", i, ret);
 			return ret;
 		}
 	}
@@ -911,37 +911,6 @@ static int _set_required_opps(struct device *dev,
 	return ret;
 }
 
-/**
- * dev_pm_opp_set_bw() - sets bandwidth levels corresponding to an opp
- * @dev:	device for which we do this operation
- * @opp:	opp based on which the bandwidth levels are to be configured
- *
- * This configures the bandwidth to the levels specified by the OPP. However
- * if the OPP specified is NULL the bandwidth levels are cleared out.
- *
- * Return: 0 on success or a negative error value.
- */
-int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp)
-{
-	struct opp_table *opp_table;
-	int ret;
-
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table)) {
-		dev_err(dev, "%s: device opp table doesn't exist\n", __func__);
-		return PTR_ERR(opp_table);
-	}
-
-	if (opp)
-		ret = _set_opp_bw(opp_table, opp, dev, false);
-	else
-		ret = _set_opp_bw(opp_table, NULL, dev, true);
-
-	dev_pm_opp_put_opp_table(opp_table);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_set_bw);
-
 static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
@@ -982,7 +951,7 @@ static int _disable_opp_table(struct device *dev, struct opp_table *opp_table)
 	if (!_get_opp_count(opp_table))
 		return 0;
 
-	ret = _set_opp_bw(opp_table, NULL, dev, true);
+	ret = _set_opp_bw(opp_table, NULL, dev);
 	if (ret)
 		return ret;
 
@@ -1050,7 +1019,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 	}
 
 	if (!ret) {
-		ret = _set_opp_bw(opp_table, opp, dev, false);
+		ret = _set_opp_bw(opp_table, opp, dev);
 		if (!ret) {
 			opp_table->enabled = true;
 			dev_pm_opp_put(old_opp);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 2d8a706f8d00..891276b46e97 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -159,7 +159,6 @@ struct opp_table *devm_pm_opp_attach_genpd(struct device *dev, const char **name
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp);
-int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 void dev_pm_opp_remove_table(struct device *dev);
@@ -382,11 +381,6 @@ static inline int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp)
 	return -ENOTSUPP;
 }
 
-static inline int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask)
 {
 	return -ENOTSUPP;
-- 
2.25.0.rc1.19.g042ed3e048af

