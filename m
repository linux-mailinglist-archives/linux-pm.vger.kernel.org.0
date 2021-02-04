Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566E330EE25
	for <lists+linux-pm@lfdr.de>; Thu,  4 Feb 2021 09:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbhBDIPT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 03:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbhBDIPS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 03:15:18 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE61C06178A
        for <linux-pm@vger.kernel.org>; Thu,  4 Feb 2021 00:14:34 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id s24so1259722pjp.5
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2021 00:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BUo70dpbWZG2th1HyMSGNG98xfWBgw6XoNhP4iRnwRU=;
        b=FlecxtCo1Sa+T60LAKIz04wg5u7FUSFpjvYDenVMCaVVTpYbFIQ1j7HOvvpOdOiL/K
         QyN3GuJ1tBXy2TswFsx8eyUT+AeSg4puA72D1LFhXYI9VR9mEbytlcrSmxSjOIJzzLPd
         YUikBNf0rUIs+Vd+NxiNHuKck5lXplDsXvzBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BUo70dpbWZG2th1HyMSGNG98xfWBgw6XoNhP4iRnwRU=;
        b=lGBO/9cydRkCToKD8UcOiorRDOn3sjBNU1b+Zz+t1/fTakgNe6co3zHIrElOcZxgyd
         3/J+O3R9cz+AoyUU4k8XfO8vkyrxyGLpGuXhSXBXkc0swuqTYDkpKflromkpvy8t36d6
         YfHE+My/a15dTTw2wiVq66wpkf3LWLlbMqgV8s+VsHnW3vgNXKrBgBCB99HPrTcCPddR
         nIfI2X03Je83Gnf7W58e2BXCSxfIZNwiHqq9SpAqMp7OHVCXPzPeUJRZ7FGUCrToOoQN
         2NsuJJ5G3LIahKhmw02g7Flub5EqMwzrzGBF5ydUKoTUYUnk5j1h69CvoyAwJaaIa0Gh
         S80A==
X-Gm-Message-State: AOAM533awXE3N4WA1ESASz06psb79IeuoqPxo5NBKDZ0meRmsrEfpLFo
        xdtdmvcbKO5/31DOk9FM/ofwJY1i4PmDxQ==
X-Google-Smtp-Source: ABdhPJyLVYwTNg/1U1PuYTKS194UmkYqIiYCE7tXra2V9O4uvRFIUJrdzMjGLzfJLUnJ8pgOSeYavA==
X-Received: by 2002:a17:902:ff0a:b029:e1:93ab:1e7b with SMTP id f10-20020a170902ff0ab02900e193ab1e7bmr7053319plj.61.1612426473736;
        Thu, 04 Feb 2021 00:14:33 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ed70:6d43:9c6a:2e22])
        by smtp.gmail.com with ESMTPSA id e3sm5091258pgs.60.2021.02.04.00.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 00:14:33 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v6 2/3] PM / devfreq: Cache OPP table reference in devfreq
Date:   Thu,  4 Feb 2021 16:14:23 +0800
Message-Id: <20210204081424.2219311-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210204081424.2219311-1-hsinyi@chromium.org>
References: <20210204081424.2219311-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

The OPP table can be used often in devfreq. Trying to get it each time can
be expensive, so cache it in the devfreq struct.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/devfreq/devfreq.c | 6 ++++++
 include/linux/devfreq.h   | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 6aa10de792b33..a5899c9ae16fc 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -757,6 +757,8 @@ static void devfreq_dev_release(struct device *dev)
 	if (devfreq->profile->exit)
 		devfreq->profile->exit(devfreq->dev.parent);
 
+	if (devfreq->opp_table)
+		dev_pm_opp_put_opp_table(devfreq->opp_table);
 	mutex_destroy(&devfreq->lock);
 	kfree(devfreq);
 }
@@ -844,6 +846,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 
 	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
+	devfreq->opp_table = dev_pm_opp_get_opp_table(dev);
+	if (IS_ERR(devfreq->opp_table))
+		devfreq->opp_table = NULL;
+
 	atomic_set(&devfreq->suspend_count, 0);
 
 	dev_set_name(&devfreq->dev, "%s", dev_name(dev));
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index b6d3bae1c74d8..26ea0850be9bb 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -137,6 +137,7 @@ struct devfreq_stats {
  *		using devfreq.
  * @profile:	device-specific devfreq profile
  * @governor:	method how to choose frequency based on the usage.
+ * @opp_table:	Reference to OPP table of dev.parent, if one exists.
  * @nb:		notifier block used to notify devfreq object that it should
  *		reevaluate operable frequencies. Devfreq users may use
  *		devfreq.nb to the corresponding register notifier call chain.
@@ -173,6 +174,7 @@ struct devfreq {
 	struct device dev;
 	struct devfreq_dev_profile *profile;
 	const struct devfreq_governor *governor;
+	struct opp_table *opp_table;
 	struct notifier_block nb;
 	struct delayed_work work;
 
-- 
2.30.0.365.g02bc693789-goog

