Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16173393F9B
	for <lists+linux-pm@lfdr.de>; Fri, 28 May 2021 11:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbhE1JNn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 May 2021 05:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbhE1JNm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 May 2021 05:13:42 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0028C06174A
        for <linux-pm@vger.kernel.org>; Fri, 28 May 2021 02:12:07 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w33so4295904lfu.7
        for <linux-pm@vger.kernel.org>; Fri, 28 May 2021 02:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZB800bOhKFCGK6d7wDa9t/A1lZSI4wYj4YKflJqW4BE=;
        b=KlhgpHI6b5tTvVjNUp85mgiuuWggqNBSOcObUyi0mrUDSuH0/J9coPaxoqyBwaw9qK
         RDGeCgR8eODiassfVCSNeLmOyRUMFeid8Yd2LyGwWto6lydEIzcSGgSgXTe4/2PRJW71
         CXBY4DZpHotaNtp7TMg/f57+OpBhzFCZDWicDleIh8Ijdey1ym7VFXViRzwojlW0gUjK
         sdcY27oD7qneN++kxIT1Atlis8+pgDdeeXS+VfZ7hQdqJO8PfLg1lx8vBtbIm1afRH0E
         QOQ+2yycLqX3/9bcWZUU5wNBncEx0hCGD9LiKoGKFadmS0jwTc39Ei8JtuQlxzhpWZOS
         dELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZB800bOhKFCGK6d7wDa9t/A1lZSI4wYj4YKflJqW4BE=;
        b=bs1MZxQDeFfTJ6s42E4h+aP8qRJdio8dnmy92Pn7K53a2AzPlz5FeN1isrbb/PyumE
         uOAAuFqiJJmDRkllC3Mnn3G8GxtXKA+s0/6pFntM2uAYYTY+IOncYZyULCa9JhTAf4SC
         eWoe5G2uba2RMMcZtCIMSzonDDYGpMV2MJ3eE+CwEernYMuSHTqL8sNNX1PSZrWNeS8K
         74xZ/YQlSBy12hYtDbVt2LRh6pBaXqrCIWNV78ov6R2FqCCf3eqnqlPHnKP/kE1FEf03
         jRr7xWFyYr4IA26WC5O+tGPKYcCvhId3zIsZ4V+7ciAqLY85oboJJLIaIEzcRduwIgxD
         Us5A==
X-Gm-Message-State: AOAM531nWJ137SbxWdCUoEF1EboO/LMeGZT6RkPNSWOQVNtYeRbdB5q3
        edEkU79qSDOxYyeLUEsU8leBaQ==
X-Google-Smtp-Source: ABdhPJw3cbp9c36WWL8oxcRJGQCUpv15fo/C/Ij+mnr+wRpiMSsA1kh7obLCs9cz7vWnAxlGRhBbrQ==
X-Received: by 2002:ac2:598e:: with SMTP id w14mr5037682lfn.558.1622193126115;
        Fri, 28 May 2021 02:12:06 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id m4sm537061ljp.9.2021.05.28.02.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:12:05 -0700 (PDT)
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
Subject: [PATCH 2/2] PM: runtime: Allow unassigned ->runtime_suspend|resume callbacks
Date:   Fri, 28 May 2021 11:12:02 +0200
Message-Id: <20210528091202.11603-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We are currently allowing ->rpm_idle() callbacks to be unassigned without
returning an error code from rpm_idle(). This has been useful to avoid
boilerplate code in drivers. Let's take this approach a step further, by
allowing unassigned ->runtime_suspend|resume() callbacks as well.

In this way, a consumer/supplier device link can be used to let a consumer
device be power managed through its supplier device, without requiring
assigned ->runtime_suspend|resume() callbacks for the consumer device, for
example.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/runtime.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 68bebbf81347..8a66eaf731e4 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -345,7 +345,7 @@ static void rpm_suspend_suppliers(struct device *dev)
 static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
 	__releases(&dev->power.lock) __acquires(&dev->power.lock)
 {
-	int retval, idx;
+	int retval = 0, idx;
 	bool use_links = dev->power.links_count > 0;
 
 	if (dev->power.irq_safe) {
@@ -373,7 +373,8 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
 		}
 	}
 
-	retval = cb(dev);
+	if (cb)
+		retval = cb(dev);
 
 	if (dev->power.irq_safe) {
 		spin_lock(&dev->power.lock);
@@ -484,9 +485,6 @@ static int rpm_callback(int (*cb)(struct device *), struct device *dev)
 {
 	int retval;
 
-	if (!cb)
-		return -ENOSYS;
-
 	if (dev->power.memalloc_noio) {
 		unsigned int noio_flag;
 
-- 
2.25.1

