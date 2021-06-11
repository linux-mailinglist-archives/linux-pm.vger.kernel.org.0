Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6D23A4003
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jun 2021 12:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFKKS5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Jun 2021 06:18:57 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:41861 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFKKS4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jun 2021 06:18:56 -0400
Received: by mail-lf1-f44.google.com with SMTP id j20so7768289lfe.8
        for <linux-pm@vger.kernel.org>; Fri, 11 Jun 2021 03:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=owVBd+kk8OH4euR2fhxhcSgveMTyj+KZJwe7IC4lO7I=;
        b=LsusMh1SljDQI8GI8DYg7ac4EfTZdUIXPLcf96kpa4JdTmWIkXkyLmLJHdCMRjHue7
         V7Rr5qndc2XqiXnCC3akBZo8PBvjLn/PI2lfw8eWo9jUEebf5/VIAKl5ZH/k+MNAS8SB
         Tt8jGglS10EFTABYzzzQvCrkMU0hIJBBJXG5hxF32OjoH8COoyvtMsOYAvDKryKxh7JF
         0YXQI7Lj+wuLbfUGV5HCVH63290XG9br26uUXbtD4iTQm4E3I1jhy9+xWStP8gZoQ0le
         ttTUd6fRvoUz4dlLRLl5MmnaNz+JtsASAbXvMK0xUzei9ty9C7jsmMY7g6Vv+B1iPBdB
         dmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=owVBd+kk8OH4euR2fhxhcSgveMTyj+KZJwe7IC4lO7I=;
        b=WVTzfGnVG2gVW8brbTRsequTADqwoTLQcEqQdMambnncalZ2HAomOXEn2RugIkPiJO
         C5qw+aNWsQPVbS7hWWgcTpJS9PPs1ur2fu/LlKmISJbLn1HaIhBCy+lNod/rGgqdzXpC
         IYPiS6J8jhL0103nPAsWwTnYapWClCpIthTwF6EY7FYE+9MMKBo079l1OC3VOcCEiVNY
         oC1tdmzRTo9v3JNE5GVvodBZcFCZsperOzfeeYBTIlOtG2Xm0d4Tp4crK03L53tVl08L
         PLGd1lB54jZLs9Mp6aE26r/SXE5dkmaNO5HadhHYyZOhc4//6wbHBSZ0v382EZJCTOuE
         qbLg==
X-Gm-Message-State: AOAM5329bPIl++vG0Js4heAQ/tW2zM2o7AHtMm9/h16cGMh1fg1B0duL
        oe7oziweMg35YDhBwl1U6uaxlg==
X-Google-Smtp-Source: ABdhPJw3pfwvgEEE96B6feNuZ7GAENuHfDDSWzmy68FLvJo3B37fPb+EVYT6LUdBZpauL47JJ0Te+Q==
X-Received: by 2002:a05:6512:38a4:: with SMTP id o4mr2167409lft.288.1623406545129;
        Fri, 11 Jun 2021 03:15:45 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b28sm552097lfp.197.2021.06.11.03.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 03:15:44 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PM: domains: call mutex_destroy when removing the genpd
Date:   Fri, 11 Jun 2021 13:15:39 +0300
Message-Id: <20210611101540.3379937-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210611101540.3379937-1-dmitry.baryshkov@linaro.org>
References: <20210611101540.3379937-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It is a good practice to destroy mutexes with mutex_destroy, so call
this function for releasing genpd->mlock.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/base/power/domain.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index b6a782c31613..74219d032910 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1910,6 +1910,11 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
 	}
 }
 
+static void genpd_lock_destroy(struct generic_pm_domain *genpd) {
+	if (!(genpd->flags & GENPD_FLAG_IRQ_SAFE))
+		mutex_destroy(&genpd->mlock);
+}
+
 /**
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
@@ -1960,12 +1965,16 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 
 	/* Always-on domains must be powered on at initialization. */
 	if ((genpd_is_always_on(genpd) || genpd_is_rpm_always_on(genpd)) &&
-			!genpd_status_on(genpd))
-		return -EINVAL;
+			!genpd_status_on(genpd)) {
+		ret = -EINVAL;
+		goto fail;
+	}
 
 	if (genpd_is_cpu_domain(genpd) &&
-	    !zalloc_cpumask_var(&genpd->cpus, GFP_KERNEL))
-		return -ENOMEM;
+	    !zalloc_cpumask_var(&genpd->cpus, GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto fail;
+	}
 
 	/* Use only one "off" state if there were no states declared */
 	if (genpd->state_count == 0) {
@@ -1973,7 +1982,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		if (ret) {
 			if (genpd_is_cpu_domain(genpd))
 				free_cpumask_var(genpd->cpus);
-			return ret;
+			goto fail;
 		}
 	} else if (!gov && genpd->state_count > 1) {
 		pr_warn("%s: no governor for states\n", genpd->name);
@@ -1988,6 +1997,11 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	mutex_unlock(&gpd_list_lock);
 
 	return 0;
+
+fail:
+	genpd_lock_destroy(genpd);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pm_genpd_init);
 
@@ -2026,6 +2040,7 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 		free_cpumask_var(genpd->cpus);
 	if (genpd->free_states)
 		genpd->free_states(genpd->states, genpd->state_count);
+	genpd_lock_destroy(genpd);
 
 	pr_debug("%s: removed %s\n", __func__, genpd->name);
 
-- 
2.30.2

