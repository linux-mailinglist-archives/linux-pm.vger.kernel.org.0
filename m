Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6151C243353
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 06:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgHME3R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 00:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgHME3R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 00:29:17 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9093C061383
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 21:29:16 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h12so2180233pgm.7
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 21:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=EmYcMBFXduhCjGSSeOrt+gv2BnfjO/m6pxI+pucShxg=;
        b=iPOv0PAOwGrizFxzdFf9t/4kn5i+QSHq+MB1/7/E3KmAWZydvSEm9crZyK1GDeKqn7
         /INLfrfZNWy6yZvtzwawmgA8kajj/4viTNR9HS8kR9wKHePKh97qIZqVJAFTyK9GQp7+
         jDg5Fvzwb3NMb41ZAcoMd7zN3BOffp3hN0qPbQ1SjX9H0x/HAWeYpbA+O84xCJ9spPIF
         tlt+8cVEnDJ0DDpskXmrRjAOGmUp5669+QmD7fLAr0Xh9R3XwRmVOc2TrPjoiufiSiqv
         BZnFfrjRDHm/c6Lo0dl4RdIEYzFHizFjUOBxvEjDvvn2jG5oW/NB6XtnhVx+K/HOZR1e
         roKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=EmYcMBFXduhCjGSSeOrt+gv2BnfjO/m6pxI+pucShxg=;
        b=P0AOk+XdywBL4WZ6E+LrO0IhOCzSsexuadxZljxzegEvnx+pS7xKf4XY6AElQo+yd4
         C13C+pQkqiwqVS5dmy0T8aI7/g7W5FFxZNq3I++N8AHrFldru3PRx2HpfBWF4sNT1ocB
         he1akWNWT4IAvuI5KRH/VMSmNHyLgqqRD5y33sRkdI4n/XahGNAzZthbmuGpoRn9NobW
         LUU2zZmHYtH52ysTwGZ8Tk4A3Yz5crs7hfDoq7DCZfYWU0AJNui6f+UBducLfxVnsRy+
         MCLZAv2e3Udyt7/cD9rIB5crWe25tUbGaQrJ5te4Xo/VgkJfSQs/WdJWmZTYK7hU3Fug
         gpgg==
X-Gm-Message-State: AOAM530yubTNJrBaSq5YWjO8LV3hUUGDUOu0UYOw7AOjr2dcdAYK6GV4
        mJdH8XDrI58inDdyBv0dQ/EJFw==
X-Google-Smtp-Source: ABdhPJzODPFHAqWtboOMEMett8hu9BBsAIi3bVplg9YbNaau3YXbRuJT8Xz5EMlvOj5mGIEVF2KpBQ==
X-Received: by 2002:aa7:9468:: with SMTP id t8mr2530895pfq.182.1597292955865;
        Wed, 12 Aug 2020 21:29:15 -0700 (PDT)
Received: from localhost ([171.79.32.211])
        by smtp.gmail.com with ESMTPSA id f195sm3837538pfa.96.2020.08.12.21.29.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Aug 2020 21:29:15 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, mka@chromium.org,
        sibis@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] opp: Track device's resources configuration status
Date:   Thu, 13 Aug 2020 09:58:59 +0530
Message-Id: <453b3897507838e95359d891ef967165bd167a4e.1597292833.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org>
References: <1597043179-17903-1-git-send-email-rnayak@codeaurora.org>
 <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org>
In-Reply-To: <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org>
References: <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The OPP core needs to track if the resources of devices are enabled or
configured or not, as it disables the resources when target_freq is set
to 0.

Handle that with a separate variable to make it easy to maintain.

Also note that we will unconditionally call clk_set_rate() in the case
where the resources are getting enabled again. This shouldn't have any
side effects anyway.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 37 ++++++++++++++++++-------------------
 drivers/opp/opp.h  |  2 ++
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 9668ea04cc80..e8882e7fd8a5 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -888,22 +888,18 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	}
 
 	if (unlikely(!target_freq)) {
+		ret = 0;
+
+		if (!opp_table->enabled)
+			goto put_opp_table;
+
 		/*
 		 * Some drivers need to support cases where some platforms may
 		 * have OPP table for the device, while others don't and
 		 * opp_set_rate() just needs to behave like clk_set_rate().
 		 */
-		if (!_get_opp_count(opp_table)) {
-			ret = 0;
-			goto put_opp_table;
-		}
-
-		if (!opp_table->required_opp_tables && !opp_table->regulators &&
-		    !opp_table->paths) {
-			dev_err(dev, "target frequency can't be 0\n");
-			ret = -EINVAL;
+		if (!_get_opp_count(opp_table))
 			goto put_opp_table;
-		}
 
 		ret = _set_opp_bw(opp_table, NULL, dev, true);
 		if (ret)
@@ -915,6 +911,9 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		}
 
 		ret = _set_required_opps(dev, opp_table, NULL);
+		if (!ret)
+			opp_table->enabled = false;
+
 		goto put_opp_table;
 	}
 
@@ -933,14 +932,11 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	old_freq = clk_get_rate(clk);
 
 	/* Return early if nothing to do */
-	if (old_freq == freq) {
-		if (!opp_table->required_opp_tables && !opp_table->regulators &&
-		    !opp_table->paths) {
-			dev_dbg(dev, "%s: old/new frequencies (%lu Hz) are same, nothing to do\n",
-				__func__, freq);
-			ret = 0;
-			goto put_opp_table;
-		}
+	if (opp_table->enabled && old_freq == freq) {
+		dev_dbg(dev, "%s: old/new frequencies (%lu Hz) are same, nothing to do\n",
+			__func__, freq);
+		ret = 0;
+		goto put_opp_table;
 	}
 
 	/*
@@ -1001,8 +997,11 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 			dev_err(dev, "Failed to set required opps: %d\n", ret);
 	}
 
-	if (!ret)
+	if (!ret) {
 		ret = _set_opp_bw(opp_table, opp, dev, false);
+		if (!ret)
+			opp_table->enabled = true;
+	}
 
 put_opp:
 	dev_pm_opp_put(opp);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index e51646ff279e..bd35802acc6e 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -152,6 +152,7 @@ enum opp_table_access {
  * property).
  * @paths: Interconnect path handles
  * @path_count: Number of interconnect paths
+ * @enabled: Set to true if the device's resources are enabled/configured.
  * @genpd_performance_state: Device's power domain support performance state.
  * @is_genpd: Marks if the OPP table belongs to a genpd.
  * @set_opp: Platform specific set_opp callback
@@ -198,6 +199,7 @@ struct opp_table {
 	bool regulator_enabled;
 	struct icc_path **paths;
 	unsigned int path_count;
+	bool enabled;
 	bool genpd_performance_state;
 	bool is_genpd;
 
-- 
2.14.1

