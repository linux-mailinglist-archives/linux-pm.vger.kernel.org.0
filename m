Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7B9DEBE8
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 14:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfJUMP3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 08:15:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44381 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbfJUMP3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 08:15:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id e10so7705451pgd.11
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 05:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=OV9GCJs4s7auzZpPSYG5QvReU/tq3thTyE+8LoeVN7Y=;
        b=NS7ZKy/CJRKKWW9c979mMVqT188CSGr/jWJ+67EpTmxEJt+UAyi1cRDiv1812fo/pS
         u3kaC56+efRbFQ80M9Ze3QN6VK4AEJ71gDz1wks2LVQ5aeBAEZhtqQybfLA0rfejtnbO
         gbegVPOHbbj8LkvtYQKiZsyIT1jQdUs508eV9I+O/wCi+/Y1F79VBbJ3Kk5q+QPsm5S9
         yYr4rExC53BA5VhyEJ8J8zwxQlS+B54pnEQWaMHdrE6mR0TXgqOpo+wcs+bONBYSo5gz
         kzoWjNtfmJnAmCD6kSw736Gvvjv6RjVD9mmRHy8gmg0H20Gn54q66uExxKiFnaYTa1d1
         5OnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=OV9GCJs4s7auzZpPSYG5QvReU/tq3thTyE+8LoeVN7Y=;
        b=Cnr5DqeHV5xVi/eXW0YtzHGpOfXS7ZEsiQ90YpIbQwb89FUJvEzCxA22yJAlwRM5xd
         qT6NPUj0XiosQDPblSlpscXDQBNBg7TxU55Xsn/Pbj7rHVyLvIJFiiclZQdgybL1SZCu
         Fgnj7BrbQ0vZIwAkpBPj1Yy+eCELo1ZPE39X+fzzg7v9mpiZsIE+WRn6FWaTET9LBRmV
         NK+IrK4DVtnIYO6kMzfHmss+rzIw05TVohMHLbnhnc2VtpyrMVbc3VCcf9ly0axTzXu8
         bZUynTTfZuNELX8Txkvk4LDnot36wG4WL6kBayO5NAPUZOV+zyWc5W6T2sDriuFYX1OV
         SIGw==
X-Gm-Message-State: APjAAAXCaiKi7WbEwOB7wjdE1hh1KK82cCFsQ5gROmVUGWcRaJsSrhgS
        6BuYAep9T1Q+OvpCYs2ouI5zFA==
X-Google-Smtp-Source: APXvYqzNjdZjeH7TQCvvsCQr2viFo8Wmk1yaKRPtWsE+Sq3U4TjGWSFMCUSBrZ07XjV/Nnpi5dCUNA==
X-Received: by 2002:a17:90b:144:: with SMTP id em4mr29096753pjb.8.1571660128323;
        Mon, 21 Oct 2019 05:15:28 -0700 (PDT)
Received: from localhost ([49.248.62.222])
        by smtp.gmail.com with ESMTPSA id u3sm14514404pfn.134.2019.10.21.05.15.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 05:15:27 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, tdas@codeaurora.org,
        swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v5 2/6] thermal: Initialize thermal subsystem earlier
Date:   Mon, 21 Oct 2019 17:45:11 +0530
Message-Id: <f8ff0ab4a8e9c2eca5a26fb2256365b26cb326ce.1571656015.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571656014.git.amit.kucheria@linaro.org>
References: <cover.1571656014.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571656014.git.amit.kucheria@linaro.org>
References: <cover.1571656014.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that the thermal framework is built-in, in order to facilitate
thermal mitigation as early as possible in the boot cycle, move the
thermal framework initialization to core_initcall.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cced0638b686f..69fcd54f8a83e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1537,4 +1537,4 @@ static int __init thermal_init(void)
 	mutex_destroy(&poweroff_lock);
 	return result;
 }
-fs_initcall(thermal_init);
+core_initcall(thermal_init);
-- 
2.17.1

