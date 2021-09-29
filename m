Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A7E41C713
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 16:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344565AbhI2Oqk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 10:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244878AbhI2Oqj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 10:46:39 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43717C06161C
        for <linux-pm@vger.kernel.org>; Wed, 29 Sep 2021 07:44:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j5so6934782lfg.8
        for <linux-pm@vger.kernel.org>; Wed, 29 Sep 2021 07:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jI512TbeQgh2FYrW2/MewJZ0e3lJuCvLMPJwgkXNatc=;
        b=uJy2BNUqQw+BJyvO/Zh9fJeegstwdqNEGh1Ckjo/E3TaoDaiOXk7emJ0v4f2cq+KdJ
         1hyllL8m7Na7397VPTNeTYOUN0JKOnBSQqT8PXNvL6fvPM4etcvF3talSs1L4MuEOYIj
         ORbd+bs0RKplK3xfdWSlb2bNOVOOhgZlrmF3MBoh6zbhvqaDRNoirQ0dVCw478a/gPTD
         KhW6uj0uMsO19BubBS9i5MCUcjN5XHuFbSpOq8pmIR/xbQklgT2g0XgE6YslcomcAmF8
         SbfkwV8g5cZcKPss9NjFJKsGNXUvNfYCRCd6i4kNP2AOIoRfLTgQ8MhZFmR4KoGMb274
         b/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jI512TbeQgh2FYrW2/MewJZ0e3lJuCvLMPJwgkXNatc=;
        b=O+tu/IwpYKyJS4Dkx0YVM+MCxHhg17UiKWq2ZA/7aSKc5dImYKqpT/t6Cr7ZzL2emu
         miDrAJ/JVdAv3yeUnzwTzYgcQolKeMoFfTUlahvP3q04cztppAeNURYOqWp8A4JyrGwg
         KpV0ahOz2VnagWATq4LI5zPet3d/y3UbMD7C8xbObVoXQyReQUV3PoCKjBcVPKhNBAGP
         zdlrvPUbR6BcHdGizVEoAcO/EkjAp67zFK+m+pU3XaojVZcPB/LPA71JO+NSUrR2rCAT
         dziIi+47EKC3C6t9AIFLfTXLOMWPIejWl5SZ1ZmiivDm0WHxKnSQKy/cf7T4ySlwk/mL
         WbQg==
X-Gm-Message-State: AOAM531d2vUakOkD4MB6qOsoTOYjNiLB4aWO5EoXQ7ibRSElKG7skVay
        zjdnxpKrkCsG+FxxHKhoIpyhEQ==
X-Google-Smtp-Source: ABdhPJz81MaqezsB00jcBTdcVIWyNKeqSu5DcUQ8vyT5t7reV63l4XQLO+5zErmsmpzlDbBEZrvCpw==
X-Received: by 2002:a2e:9a07:: with SMTP id o7mr302931lji.125.1632926696590;
        Wed, 29 Sep 2021 07:44:56 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id g4sm9863ljk.64.2021.09.29.07.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 07:44:55 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Maulik Shah <mkshah@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Len Brown <len.brown@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PM: sleep: Fix runtime PM based cpuidle support
Date:   Wed, 29 Sep 2021 16:44:51 +0200
Message-Id: <20210929144451.113334-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210929144451.113334-1-ulf.hansson@linaro.org>
References: <20210929144451.113334-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the cpuidle-psci case, runtime PM in combination with the generic PM
domain (genpd), may be used when entering/exiting an idlestate. More
precisely, genpd relies on runtime PM to be enabled for the attached device
(in this case it belongs to a CPU), to properly manage the reference
counting of its PM domain.

This works fine most of the time, but during system suspend in the
dpm_suspend_late() phase, the PM core disables runtime PM for all devices.
Beyond this point and until runtime PM becomes re-enabled in the
dpm_resume_early() phase, calls to pm_runtime_get|put*() will fail.

To make sure the reference counting in genpd becomes correct, we need to
prevent cpuidle-psci from using runtime PM when it has been disabled for
the device. Therefore, let's move the call to cpuidle_pause() from
dpm_suspend_noirq() to dpm_suspend_late() - and cpuidle_resume() from
dpm_resume_noirq() into dpm_resume_early().

Diagnosed-by: Maulik Shah <mkshah@codeaurora.org>
Suggested-by: Maulik Shah <mkshah@codeaurora.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index cbea78e79f3d..1c753b651272 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -747,8 +747,6 @@ void dpm_resume_noirq(pm_message_t state)
 
 	resume_device_irqs();
 	device_wakeup_disarm_wake_irqs();
-
-	cpuidle_resume();
 }
 
 /**
@@ -870,6 +868,7 @@ void dpm_resume_early(pm_message_t state)
 	}
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();
+	cpuidle_resume();
 	dpm_show_time(starttime, state, 0, "early");
 	trace_suspend_resume(TPS("dpm_resume_early"), state.event, false);
 }
@@ -1336,8 +1335,6 @@ int dpm_suspend_noirq(pm_message_t state)
 {
 	int ret;
 
-	cpuidle_pause();
-
 	device_wakeup_arm_wake_irqs();
 	suspend_device_irqs();
 
@@ -1467,6 +1464,7 @@ int dpm_suspend_late(pm_message_t state)
 	int error = 0;
 
 	trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
+	cpuidle_pause();
 	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
 	async_error = 0;
-- 
2.25.1

