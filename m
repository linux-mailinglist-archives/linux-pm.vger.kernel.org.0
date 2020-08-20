Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE7C24B70B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 12:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgHTKq3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 06:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731889AbgHTKoh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 06:44:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B397C061346
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 03:44:22 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u128so825239pfb.6
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 03:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x+bz+8kGVuMiMceaXT9LU2+tICSPMZ8W5Wbu/NfWx68=;
        b=VzvCfdlyX26OvPS41xgFNpLtuTf6bOsmYXDqUDx9yH9XJzJYFihRnNb+KnOPfI/CpD
         HsS2D8Z1KcpukEvEzHvPa6ZlcadJdK0VqPvJGPk7k5LiPLnzLHj/s84K670FPUWTA4QT
         8kz47EWrsP+qpsHgxuEg4qJpHBzyPKNUq/FQkZ80CzWc/UYpmMSUha+OVCbxZiDGQEFR
         OTLzfys4GCB+RzViJCKWQG+DhfRvuvI5bz/opYcl/sNOwqrGa4j+1F0IrE41gbUdQjB7
         sbBhIKkBOq5NyflTtNBSgFE92CPEdwfI02ZZ+wt068yTKeDDEuj67TxT0QXC+b3pvrPy
         n/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+bz+8kGVuMiMceaXT9LU2+tICSPMZ8W5Wbu/NfWx68=;
        b=n5vGRRlAdGNnIddpEO8hvAColkmXehR3a1OMabZvh10KXKOwyMb/NzYWnPAaSi8n4T
         SJammLCibEWjRaU1VdQBqP8X7C4bOA75K/RQe2mPE1zR5owvCXrRJk79qIszwUJ8lqCZ
         U37zbo1BTgZgPadpEW6eXhZCEcKbApLg6gufiT3XmzvTcWj3cFamRkqptwqGErQB57i8
         lTLRq0C7xDS7HnAADoWgro8x36FSUtBQPvfcCszzcApZP5bZrSJa1MFoJKkl1dICGCfd
         BvJ/GQfMkUkLl1OGRhZx+hRXpL8FFPyZFCLcjqb1LJqSSzeBuMAU5BQfvpbC5ChlgBaF
         1cuw==
X-Gm-Message-State: AOAM533v/VvajUNxvI7CPe/rpRBflPjAu/xVt46uyk63MzEYDO2mOGJR
        ApYGGm44W+LODlPTRr47Uv1IQA==
X-Google-Smtp-Source: ABdhPJx204lll0F+uxJX2f3BtowduppAEc5fLKvYgPqeD1qYvO0Eqim+FaNlx2JCiLuDDd1kqUd5hA==
X-Received: by 2002:a63:b10a:: with SMTP id r10mr2053661pgf.431.1597920261940;
        Thu, 20 Aug 2020 03:44:21 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id 144sm2333708pfu.114.2020.08.20.03.44.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 03:44:21 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Qiang Yu <yuq825@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] drm/lima: Unconditionally call dev_pm_opp_of_remove_table()
Date:   Thu, 20 Aug 2020 16:13:51 +0530
Message-Id: <56f1c76a0061dc3ed2d6ea115a3ba8b2e2dee9fd.1597919647.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1597919647.git.viresh.kumar@linaro.org>
References: <cover.1597919647.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
find the OPP table with error -ENODEV (i.e. OPP table not present for
the device). And we can call dev_pm_opp_of_remove_table()
unconditionally here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/gpu/drm/lima/lima_devfreq.c | 6 +-----
 drivers/gpu/drm/lima/lima_devfreq.h | 1 -
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
index bbe02817721b..cd290d866a04 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.c
+++ b/drivers/gpu/drm/lima/lima_devfreq.c
@@ -105,10 +105,7 @@ void lima_devfreq_fini(struct lima_device *ldev)
 		devfreq->devfreq = NULL;
 	}
 
-	if (devfreq->opp_of_table_added) {
-		dev_pm_opp_of_remove_table(ldev->dev);
-		devfreq->opp_of_table_added = false;
-	}
+	dev_pm_opp_of_remove_table(ldev->dev);
 
 	if (devfreq->regulators_opp_table) {
 		dev_pm_opp_put_regulators(devfreq->regulators_opp_table);
@@ -162,7 +159,6 @@ int lima_devfreq_init(struct lima_device *ldev)
 	ret = dev_pm_opp_of_add_table(dev);
 	if (ret)
 		goto err_fini;
-	ldevfreq->opp_of_table_added = true;
 
 	lima_devfreq_reset(ldevfreq);
 
diff --git a/drivers/gpu/drm/lima/lima_devfreq.h b/drivers/gpu/drm/lima/lima_devfreq.h
index 5eed2975a375..2d9b3008ce77 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.h
+++ b/drivers/gpu/drm/lima/lima_devfreq.h
@@ -18,7 +18,6 @@ struct lima_devfreq {
 	struct opp_table *clkname_opp_table;
 	struct opp_table *regulators_opp_table;
 	struct thermal_cooling_device *cooling;
-	bool opp_of_table_added;
 
 	ktime_t busy_time;
 	ktime_t idle_time;
-- 
2.25.0.rc1.19.g042ed3e048af

