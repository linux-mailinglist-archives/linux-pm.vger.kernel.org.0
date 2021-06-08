Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14E339F197
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 11:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhFHJFD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 05:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhFHJFB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 05:05:01 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302BBC061789
        for <linux-pm@vger.kernel.org>; Tue,  8 Jun 2021 02:03:09 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id r14so6854760ljd.10
        for <linux-pm@vger.kernel.org>; Tue, 08 Jun 2021 02:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehN5ksOKPDeXaQtxFuYUYGE2SbISLeBDzZHvbFwjLMU=;
        b=YXZJiLTXuA3ySx4PD3wFxfxV+h5X01WFA/yCzSnXtG/SROViS31q2Xpf7c6R6T2uXn
         /QeDgMD14hOG36l9z4wdggSIniQ0PWuRpuOs6HNWGlfvUy4BZp4+z1wm8G8818dfoF13
         Rwyen/We5cQJntTe4/vHwQG9ZrKl+eEwgrYwNso5O/dSf6iTkIHUIlEEyRGc4SY8BiWo
         1VMRoJIHaYmSJ/ocMiVmEPvfFc2Af7tNKsRLJ3+gH8OzIxbVgXOIRGjNxDDmO2duNy4t
         A+b4Fv/FLcq+ITMNhQrGRmPh6NVEUQdJ3BupS+5llrFBcnvUG+7cIrsTXp4ZFQw/Exmh
         WNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehN5ksOKPDeXaQtxFuYUYGE2SbISLeBDzZHvbFwjLMU=;
        b=nDwGX8e5frff5FxEA/sahKKn+Kl3vO1iEgSZLe+3yLSDWjJ4+ykyJTltmyaIMSxUy6
         nRGjGhNuX0q7/At6BWSKlpUGGqqsLgdF6cDO/qFBtFp98N6pLIqMFONC+SAm4Zl0OpDO
         HyoZbvEpFU0NnAZOq3P3TQJa3V7Lyw8v43hRBvqZ5yJXFK2Ctk479CjyrpZhk66cOSPr
         boQC9TS0NEYfYTYnRaywqOsty/X4STnEpdx1mGB7HAGDwNOwK/Fk6mt1VSsvqptyUHAJ
         lc9zD1kAmBmPD8hZFJervS4WQO+/R5M3+xd5AnsVmTJRzMXB4SFSfMMvyhoDc63EdZw2
         wbJg==
X-Gm-Message-State: AOAM532Gjf5uYv6D8z3jOAa4B8oMBcYY9RQcvL05q3zngHV0raBRQ6L2
        g3hgf89Dgr0twDYOZl9YXUlwTA==
X-Google-Smtp-Source: ABdhPJz3SwQ9T24mG2HslSdPG6wDOlx6diMgH43qf1V0qfrzdC4lFXrnIIfuLG0XzfSUioSrputIGQ==
X-Received: by 2002:a2e:a603:: with SMTP id v3mr18072187ljp.175.1623142987476;
        Tue, 08 Jun 2021 02:03:07 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id n17sm1295197lfq.118.2021.06.08.02.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 02:03:06 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] PM: runtime: Clarify documentation when callbacks are unassigned
Date:   Tue,  8 Jun 2021 11:02:50 +0200
Message-Id: <20210608090250.85256-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608090250.85256-1-ulf.hansson@linaro.org>
References: <20210608090250.85256-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Recent changes to the PM core allows ->runtime_suspend|resume callbacks to
be unassigned.

In the earlier behaviour the PM core would return -ENOSYS, when trying to
runtime resume a device, for example. Let's update the documentation to
clarify this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Added a new patch for the updating the docs, as pointed out by Alan.

---
 Documentation/power/runtime_pm.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 18ae21bf7f92..3d09c9fd450d 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -827,6 +827,14 @@ or driver about runtime power changes.  Instead, the driver for the device's
 parent must take responsibility for telling the device's driver when the
 parent's power state changes.
 
+Note that, in some cases it may not be desirable for subsystems/drivers to call
+pm_runtime_no_callbacks() for their devices. This could be because a subset of
+the runtime PM callbacks needs to be implemented, a platform dependent PM
+domain could get attached to the device or that the device is power manged
+through a supplier device link. For these reasons and to avoid boilerplate code
+in subsystems/drivers, the PM core allows runtime PM callbacks to be
+unassigned.
+
 9. Autosuspend, or automatically-delayed suspends
 =================================================
 
-- 
2.25.1

