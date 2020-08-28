Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C323255455
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 08:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgH1GJF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 02:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbgH1GIU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 02:08:20 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC943C061232
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 23:08:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s2so49412pjr.4
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 23:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lRIVhEzHo1XPH6PloaXFLB5fbBAOJPEuMdhJUY10d78=;
        b=CTIi/VNBl7/pdFpj0PPc6Jc62F2DnJ6XScciqE9kRJen8nE772rxBpz923MEJxfdk9
         MgbVtiS+jpYfoJ+ZvIeA+dkNX2AIrrcyE93BwpLh2cwNAhXMkfr2YtxK0cNfi303+biB
         nCDNaoQjVIhU3+lAZAblQTmTRxnBZeXLabfuNwl4LMiuyXF2oUfhIbLZV+IYfAjOYUZV
         zdpaDr50LgZrzNxnSRodke3E0bfjjg4ujW5xGJVdRmm+8j4kmKus1AUsfp4BrR2vFBsA
         iDShADtfHP6F+y3GLtISaN/M/+Le6wxAS02wkU5Wa3duDsLZs0yMglkVA1XO8S6SCxIp
         0IhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lRIVhEzHo1XPH6PloaXFLB5fbBAOJPEuMdhJUY10d78=;
        b=l+685ahw06nj9eDuQIWZZ3tgFcn1Hy6/sZ6EWtk4JBQsQCJWgMS8Mgxln2R9vtxNU9
         zMJmIyWS/P44ycOUTyKi9xRVxXfZAi+qRgVqD606WtUggmiukoy+AmfdIkWIjxBANNkv
         LJ3l2zfDRhP+9fcInaFfdThi+lHh+QVplslkJGrvl2YKYlju2Yqls9Gg2W70o2Vcqvwg
         fZyc1ELpLjuXZXoDRqKnc2ys3LAhHEYabamXgMcO4YpC8gSYiO01JkqlWI7RCmYAZdt6
         wQ12BaC2Ix/ssDw1zGNfzOetKE2h3DUEQVLpm7Eor1ShRx3+DnWObysuTLGMmI3G1YsR
         pnlQ==
X-Gm-Message-State: AOAM533oQ2kLFwECUMa1UJx3i7iAUXPnmmtTJ7hTSqkJf0bBbld/cDnW
        55ugBplBIUZbLJbGo9HzXjENUg==
X-Google-Smtp-Source: ABdhPJxlrtIILPxQDoseqNvZPoHazbwPj8/mADx8Oc5ubEbeC4fFUVVOU5nNH/o5DwxLGPvdU7xhrw==
X-Received: by 2002:a17:90a:550e:: with SMTP id b14mr305609pji.64.1598594900324;
        Thu, 27 Aug 2020 23:08:20 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id a10sm109294pfn.219.2020.08.27.23.08.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 23:08:19 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Qiang Yu <yuq825@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/8] drm/lima: Unconditionally call dev_pm_opp_of_remove_table()
Date:   Fri, 28 Aug 2020 11:37:47 +0530
Message-Id: <62d944bdac75ec696828daad49fc1ddb6c637bcf.1598594714.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1598594714.git.viresh.kumar@linaro.org>
References: <cover.1598594714.git.viresh.kumar@linaro.org>
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

Reviewed-by: Qiang Yu <yuq825@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
V2: Applied Reviewed by tag.
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

