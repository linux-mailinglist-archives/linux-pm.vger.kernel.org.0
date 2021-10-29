Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE5643FC69
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 14:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhJ2Ml5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 08:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhJ2Ml5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Oct 2021 08:41:57 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AD8C061714
        for <linux-pm@vger.kernel.org>; Fri, 29 Oct 2021 05:39:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i13so11250526lfe.4
        for <linux-pm@vger.kernel.org>; Fri, 29 Oct 2021 05:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2T3v4jXO25JT49qo2reiE0rneUAVuElVzG5JppoEM8=;
        b=jxD6biwTfe3xu6SqBzLET7VGwK1z+O5kXXr9D9ld+3oXexNknMqaFCW9F2LVUIXD+G
         ucuVD7vOA4sZwbtUVVm7VzO3veKFGjRJHKI0vsCgqedXMckkcCuS5RX2luse2sdk1Twa
         WBDj6uMCqZkJ/KYciN73SIqRqEBtCSDSF63zmsvalZsfnmh4tgcEAgjPi9ilrgDdWMVb
         ZEJT/Qe6glvFD7+mxzhPkUnG56DeqPTqZIJn0EwzCL6fb0mJg+J37Y3J8rVtha2bb88g
         FhnpS+0RzDdrfPrw09Zk0fIpd8IvICd3VoueJ91jfIvaJiW7UN68emvVY/bbOQyolIXI
         WutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2T3v4jXO25JT49qo2reiE0rneUAVuElVzG5JppoEM8=;
        b=q/OczHfHpt0yXVVHs0E2ffZM7rg9NxyFWouW0tUodB+NHSXFg26v06bURdpgRl3mcJ
         0+j19tLo01WNUS55aFKiZJ3TXrtBfLTXqjfHbTXz2iU71cYGgVFirK9eUnwyV+7YANCz
         t7ZAYlO4bL5EtQDimgIcy35e5Uz4/8xgvZj58h1dhoWJKupVGuWzjFPhNyB47nzxrOXQ
         TSw0vCTH8xjnZ4I5QPISDCJ5QjAHt0W1LjJhPLpIGIuxFfTUOC2oLGtR2KwuuucFVhEm
         YgNUpV+7Mdg62WG8M6EhJqti0reZ1nMKy8DsKEmKOMoC+fnWeiS162ZV2VLT2eASyq2S
         aNbA==
X-Gm-Message-State: AOAM531fead4xA9RSXp/DXyrpe3uS+QwVUJU8vu4dNnk8dQ9nByML138
        PJ2KRUanRjEDr/pU0NOrmIAvaQ==
X-Google-Smtp-Source: ABdhPJyTjynt3OjUbfPQGjnjOlAGOKmxPdHzyoRf35p2/vo3MySu4coNCsQpIc9on1MRDnXuPapytw==
X-Received: by 2002:a05:6512:2309:: with SMTP id o9mr10050460lfu.124.1635511166794;
        Fri, 29 Oct 2021 05:39:26 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id y35sm602528lfa.16.2021.10.29.05.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 05:39:25 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Maulik Shah <mkshah@codeaurora.org>,
        Anup Patel <anup.patel@wdc.com>,
        Len Brown <len.brown@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PM: sleep: Fix runtime PM based cpuidle support
Date:   Fri, 29 Oct 2021 14:38:55 +0200
Message-Id: <20211029123855.80344-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the cpuidle-psci case, runtime PM in combination with the generic PM
domain (genpd), may be used when entering/exiting a shared idlestate. More
precisely, genpd relies on runtime PM to be enabled for the attached device
(in this case it belongs to a CPU), to properly manage the reference
counting of its PM domain.

This works fine most of the time, but during system suspend in
dpm_suspend_late(), the PM core disables runtime PM for all devices. Beyond
this point, calls to pm_runtime_get_sync() to runtime resume a device may
fail and therefore it could also mess up the reference counting in genpd.

To fix this problem, let's call wake_up_all_idle_cpus() in
dpm_suspend_late(), prior to disabling runtime PM. In this way a device
that belongs to a CPU, becomes runtime resumed through cpuidle-psci and
stays like that, because the runtime PM usage count has been bumped in
device_prepare().

Diagnosed-by: Maulik Shah <mkshah@codeaurora.org>
Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Moved away from using cpuidle_pause|resume() to solve the problem, but
	instead just waking up idle CPUs is suffient, due to other recent merged
	changes.

---
 drivers/base/power/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index ac4dde8fdb8b..2fb08d4f1aca 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1463,6 +1463,7 @@ int dpm_suspend_late(pm_message_t state)
 	int error = 0;
 
 	trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
+	wake_up_all_idle_cpus();
 	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
 	async_error = 0;
-- 
2.25.1

