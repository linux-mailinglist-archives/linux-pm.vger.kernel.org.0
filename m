Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BBA4EEEF4
	for <lists+linux-pm@lfdr.de>; Fri,  1 Apr 2022 16:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346734AbiDAONh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Apr 2022 10:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346718AbiDAON3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2022 10:13:29 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED2C214072
        for <linux-pm@vger.kernel.org>; Fri,  1 Apr 2022 07:11:39 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id d5so5127704lfj.9
        for <linux-pm@vger.kernel.org>; Fri, 01 Apr 2022 07:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dc7bcPLHSzDeVD5ow88/lepa6mD08+FL5qt0hCCvM24=;
        b=Gs++QERUQ6VZTav+T8iX4NX+HP4paalYcpGZTaqYgcvKWD3gcJnCjsvRq74CalCDQD
         ZOZ3jfl0z6fqX3p2JCZN5YBH7DjJDvfmf7DYHZIAZfaENweW5oy/yBOAjRde0PJm+BiK
         +BNTFmNl9QnskE96uabMgEt8GQ4rq/UdCp1KFldhsjEBrjipJC3aBK/XcfUJ2+38jd9E
         vQdNrorAoW97tRvVl4/wKRr9TNlHynMSIUHXgaelkssAMco89uegyP468+KlYXFz2wgQ
         VK/ZjUasEbG6bqEm1sgTD7iDNsDhiFPjPO674O0E3k7da6H+a/VJhJaweshHL0bkC9Wc
         s+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dc7bcPLHSzDeVD5ow88/lepa6mD08+FL5qt0hCCvM24=;
        b=mFmYalyyy3TNZ5YgEJJ93xrScOYcWLP24uHOzIkYFLrz33SnR42mDrS3LaN1bqmD/r
         XaxBqlrKIJCgp4FLLmXpf2EXxoyo/QKn5pKqTqPVAzSir887FPtI8tLtper+y334rJ8n
         nu/nNM3TVgG1IWBHAWEpaH3qJ/kDrlao5QgPLLbmWgK18jAvGNHiATVvSdFvxxpkmpDf
         CN3BMGrfBIwey7MjuXLBIP3AxgPNMIq0c91YnQ1P1ztUzXPsZ0xAbF/xglothWnfOG/7
         JbQDAJNxg1tucy4/7yB6cKQmjsUihhySbHTZS6lcUE3ArjyT0wWcxj4vqrzhQnAUvVTE
         3T5g==
X-Gm-Message-State: AOAM531Szv1ooCWfV6CIa9QPmy36XeIsWh6pCAVMrecTt4/jSY1gCbte
        9ks5yb4zWzITdLqvLpeX5WgJ9A==
X-Google-Smtp-Source: ABdhPJxRtRhtqUT7n7uSs6oA1DmMyYSR5uMWLnIib8aSgqAuEV/CUQy3xIotPv+wra+vfJMp5vzoRw==
X-Received: by 2002:a05:6512:c01:b0:448:6aec:65c5 with SMTP id z1-20020a0565120c0100b004486aec65c5mr14350038lfu.193.1648822297707;
        Fri, 01 Apr 2022 07:11:37 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id 16-20020ac24d50000000b0044a255c8d3bsm251926lfp.116.2022.04.01.07.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 07:11:36 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     Maulik Shah <quic_mkshah@quicinc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] PM: runtime: Allow to call __pm_runtime_set_status() from atomic context
Date:   Fri,  1 Apr 2022 16:11:23 +0200
Message-Id: <20220401141124.27272-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401141124.27272-1-ulf.hansson@linaro.org>
References: <20220401141124.27272-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The only two users of __pm_runtime_set_status() are pm_runtime_set_active()
and pm_runtime_set_suspended(). These are widely used and should be called
from non-atomic context to work as expected. However, it would be
convenient to allow them be called from atomic context too, as shown from a
subsequent change, so let's add support for this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/runtime.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index d4059e6ffeae..91d757914686 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1210,12 +1210,13 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
 {
 	struct device *parent = dev->parent;
 	bool notify_parent = false;
+	unsigned long flags;
 	int error = 0;
 
 	if (status != RPM_ACTIVE && status != RPM_SUSPENDED)
 		return -EINVAL;
 
-	spin_lock_irq(&dev->power.lock);
+	spin_lock_irqsave(&dev->power.lock, flags);
 
 	/*
 	 * Prevent PM-runtime from being enabled for the device or return an
@@ -1226,7 +1227,7 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
 	else
 		error = -EAGAIN;
 
-	spin_unlock_irq(&dev->power.lock);
+	spin_unlock_irqrestore(&dev->power.lock, flags);
 
 	if (error)
 		return error;
@@ -1247,7 +1248,7 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
 		device_links_read_unlock(idx);
 	}
 
-	spin_lock_irq(&dev->power.lock);
+	spin_lock_irqsave(&dev->power.lock, flags);
 
 	if (dev->power.runtime_status == status || !parent)
 		goto out_set;
@@ -1288,7 +1289,7 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
 		dev->power.runtime_error = 0;
 
  out:
-	spin_unlock_irq(&dev->power.lock);
+	spin_unlock_irqrestore(&dev->power.lock, flags);
 
 	if (notify_parent)
 		pm_request_idle(parent);
-- 
2.25.1

