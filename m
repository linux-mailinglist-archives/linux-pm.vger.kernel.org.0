Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1A32A8FEE
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 08:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgKFHFf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 02:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgKFHFe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 02:05:34 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63246C0613D2
        for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2020 23:05:34 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id u4so221993pgr.9
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2020 23:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehPUCc4BBH4w6xwbXHXZ9YzZ1LHDSwHspwqvBRHLfG8=;
        b=o5Zr52H5GnqwIwaEUT6XGHpZ+Rk+X0IvKQ47cS0hprikNcIhQd95tQWJJ9xoEnMC6a
         qq0CgW4B20Qmt6WOLolyORfkDV888lAdzgcGn74AVqm+Knjd7N42MMbPeXXOyU1tL0J4
         7GWqIJq+ACgU+jrTV5fuw+yggsYOAd9L/MAjYtgC1nzSfvtVI2U9LNiyJN2qZeqPGwJT
         kTg9vCMFltVucT2XqAblwjqtX1+OttYzVhENqzJfjyUNCk5Q0u9WKxarQa1qqwrWbPQC
         AB8UTDeC1bGUO/Eya7Tey2URIlSqyJuMquf4COHmuHqW+TX8lkHBRXwAhDKO1VIf9w9g
         W0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehPUCc4BBH4w6xwbXHXZ9YzZ1LHDSwHspwqvBRHLfG8=;
        b=BKKtHiICIDzjgQ8N3Tyyqk8PWlcWlFweT6vuyA1YtWKu/e7ZKlNLZNlrzNlnFumSP9
         DJQOp8tzU5mnS1TW03fTEojNpWep531jhwQwx1vlR4KoccdsfPytusvRemzqsdMShB7R
         nO9Qa0kyUVmSf6ZhEMCGk4duMjiJIm1xjz9nBchHQrAkLxHvTph0fOwfErtqcKSKfOlz
         kqC5yAHO+gKXAx1MhfjQ8fveC84gg0m5JcqK/APkxskEEu0mOBmEZZ/A4P8NP4PWKS38
         ix8luWEp8Z6GWzWGfn0sukEXTdMy8UCXewCCOugZ4JzxObPWTpvZEoIyVjmVkhw/sdYp
         4wPA==
X-Gm-Message-State: AOAM530DnBLFPPclN4St9lwgPExG0X8W82PZqd+CvQbHRr0wNgjeJ4SA
        Jp2cXK/dA/JXufLHD7koYlgyKA==
X-Google-Smtp-Source: ABdhPJxV4aG+pPSqQiArJqkvpC3VHdnMlXqz893y069PmwZUjFiCvQoM0e21aZD+0OKoStOt+zy0BQ==
X-Received: by 2002:a63:1212:: with SMTP id h18mr621177pgl.196.1604646333997;
        Thu, 05 Nov 2020 23:05:33 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id m6sm793084pfa.61.2020.11.05.23.05.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 23:05:33 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        digetx@gmail.com, dri-devel@lists.freedesktop.org,
        lima@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] drm/lima: dev_pm_opp_put_*() accepts NULL argument
Date:   Fri,  6 Nov 2020 12:33:25 +0530
Message-Id: <2518c14df2f16cc3c4fee35499895a32513c174b.1604646059.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1604646059.git.viresh.kumar@linaro.org>
References: <cover.1604646059.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The dev_pm_opp_put_*() APIs now accepts a NULL opp_table pointer and so
there is no need for us to carry the extra check. Drop them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/gpu/drm/lima/lima_devfreq.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
index bbe02817721b..e7b7b8dfd792 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.c
+++ b/drivers/gpu/drm/lima/lima_devfreq.c
@@ -110,15 +110,10 @@ void lima_devfreq_fini(struct lima_device *ldev)
 		devfreq->opp_of_table_added = false;
 	}
 
-	if (devfreq->regulators_opp_table) {
-		dev_pm_opp_put_regulators(devfreq->regulators_opp_table);
-		devfreq->regulators_opp_table = NULL;
-	}
-
-	if (devfreq->clkname_opp_table) {
-		dev_pm_opp_put_clkname(devfreq->clkname_opp_table);
-		devfreq->clkname_opp_table = NULL;
-	}
+	dev_pm_opp_put_regulators(devfreq->regulators_opp_table);
+	dev_pm_opp_put_clkname(devfreq->clkname_opp_table);
+	devfreq->regulators_opp_table = NULL;
+	devfreq->clkname_opp_table = NULL;
 }
 
 int lima_devfreq_init(struct lima_device *ldev)
-- 
2.25.0.rc1.19.g042ed3e048af

