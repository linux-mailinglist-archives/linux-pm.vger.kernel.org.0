Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBE5DAA12
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 12:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408888AbfJQKbM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 06:31:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38212 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408874AbfJQKbL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 06:31:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id h195so1375480pfe.5
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 03:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Dxo5X+E9Ol1EaiMF1ZycTVksoTfNCn6yYqPoCwK1ut0=;
        b=KW3BHAnA3ZG/qmHR83tqDTQoBB/pASsfBUD3L7y/uxYm+ylMPd0OKaWIpb4n0HzS/E
         EYaeSCe6isd90Rcp58Y07VJDgZuK3eHJKMz7kN0aPgb1CVtG2PUQRnIBtgn9h0C+VMHl
         y6luwu9znrRZkMmbDCVZ4LiOF3bn2MYxrDzO/eTQomXyZUOXguHHFeG6RQFxPgekfZ45
         TGnUosAC0nM0oAlfv7cac1ilKsI3ruMycGhZdpGypWfVrt59uIWbTn+9nQSt4VeMQfvx
         zQy1fJJSGruXYt9u6NOfcFgvkIzkFOHEA2j9rjYMv+gWdaHHOSDufQC2DJfYe4+Cc+va
         WhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Dxo5X+E9Ol1EaiMF1ZycTVksoTfNCn6yYqPoCwK1ut0=;
        b=kK2bukskdLIXBbgIhBL2NlvWLd32zXz0URU4XF3Q959+5LZhxaHdaPWWfco2b+fji9
         U7J3LlCr1Om4aZcnlcfdFYPfktFBIb9o2ewP9uwVQlXWkTZRiOuu+/cmHYI5+bICYmCR
         f3wZuE9KrsFtJJOUcJhUbqgH0tvrjoNL3A0TRhoAk9G5pxNhqLD81qQ7BmlA2VhxyI6N
         rGgIl0t0Auk/tf2Dm0ftPszAybtS8KQZJPMowYywCqkrFJ+PtPDUhTmjQQq+tBnmPxrc
         TrjjWYPsjg5kHidW50icqiq8HfHQwC7AQsJz2xUEx8aABOi9Eql4uxLqkxia96FHIFcT
         nZ2A==
X-Gm-Message-State: APjAAAXJymw9sVNaUIdVrhOnP5cjVmIPTiwdWGNchjZdTqU/H46DKCO8
        WE4FOYA8s0c1lZFGTKJWHRPFKg==
X-Google-Smtp-Source: APXvYqytDxsj5uZXimsuRfWTtmIjj/DZcWCzXQPGXBiYqeQJAKKVZ3aGERc7nPIMqHVILSjuTwRtZQ==
X-Received: by 2002:a63:5b07:: with SMTP id p7mr3416921pgb.416.1571308270667;
        Thu, 17 Oct 2019 03:31:10 -0700 (PDT)
Received: from localhost ([49.248.54.231])
        by smtp.gmail.com with ESMTPSA id b18sm2153445pfi.157.2019.10.17.03.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 03:31:09 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, tdas@codeaurora.org,
        swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 3/5] cpufreq: Initialize cpufreq-dt driver earlier
Date:   Thu, 17 Oct 2019 16:00:52 +0530
Message-Id: <9e2bce44ed6bf3aac2354650fc3bf5c43e2155b0.1571307382.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571307382.git.amit.kucheria@linaro.org>
References: <cover.1571307382.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571307382.git.amit.kucheria@linaro.org>
References: <cover.1571307382.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This allows HW drivers that depend on cpufreq-dt to initialise earlier.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index bca8d1f47fd2..3282defe14d4 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -180,4 +180,4 @@ static int __init cpufreq_dt_platdev_init(void)
 			       -1, data,
 			       sizeof(struct cpufreq_dt_platform_data)));
 }
-device_initcall(cpufreq_dt_platdev_init);
+core_initcall(cpufreq_dt_platdev_init);
-- 
2.17.1

