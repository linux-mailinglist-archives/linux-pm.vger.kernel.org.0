Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8338441C710
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 16:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343611AbhI2Oqh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 10:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245431AbhI2Oqg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 10:46:36 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3CAC061760
        for <linux-pm@vger.kernel.org>; Wed, 29 Sep 2021 07:44:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g41so11862928lfv.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Sep 2021 07:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kTJI15TCa8PAJGREAVnlDqsgyEszgn+j2lBqSs/nVF0=;
        b=xjHGKhxmbOSwTYwP271sLTO9oAiUoZ1W9eRARmkGYniBQ9Iode2KysP8Y+R1/qrENH
         D4GcddGAx0EMpPJZS1yVFuPI9UfThPUJ+oTtadU/RVB1xTtdtFwuAV4/YrqwaRRasOyR
         cQtVpV7VHJGWTJ/3J3uq5I6jSGoPiEW2ZsV3Zi8rHtcvpt9GriIa8ru2R7VPwBub9e5B
         Xa5DKbNNtdUoKsfYJzx5mxopxO2ptvGkEx1qo4NV/8cG5RVhsEoLtaRbwavs3XoqIh6q
         8A5JSVl53OfMF8hdzjcxS62cO/mbuD/5Y+AjI04QdDEm77epsia0HhfOs6tPAjrTzE8X
         AKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kTJI15TCa8PAJGREAVnlDqsgyEszgn+j2lBqSs/nVF0=;
        b=xJrsEl9jM8pe/xZZqq6OlLI7AvXgYkiVuZgKPtlSYsTH+atcKSqUz+zi+pWKA8CiqX
         mdFqFQ3wE0e71zT5/YDQxZE6pBDBtwI9BHhjshtrPDIhF8KuMFUrGpXQ7oBHOqLQR0CE
         E2B/a2/HWiVx5YbYldI+Ose8RBmhPd+e9sK9jCmfoh9GG1eIK6NrLeUVfAAUFAqLvlG2
         5Q57WEN/InwXG1gPWRqCwWW9/NHXJM/I9GIipfb7H2ivROzHqHkwJSXguLA4AKNz5buE
         HICUWZwOYCTfloO4WhdH9GbexvWyvBte+h7sDrrUZAsQSlsC4A3J8lK9SBZzEHPQcgh/
         XHeg==
X-Gm-Message-State: AOAM533p1oebn6vox2coP2rWqXyy1YFHe8G6+pdMTDOqpy/k/nQIOX0G
        n0N83dS/PwD20pS/otv2EaMFGA==
X-Google-Smtp-Source: ABdhPJwZhrATzdfeTww9AAP3rRlwJsNaFFlYmAtnf+adqoXn44vYQElWo1YizMdPPsmTDNLUooDT0g==
X-Received: by 2002:a2e:8881:: with SMTP id k1mr262703lji.443.1632926693693;
        Wed, 29 Sep 2021 07:44:53 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id g4sm9863ljk.64.2021.09.29.07.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 07:44:53 -0700 (PDT)
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
Subject: [PATCH 0/2] cpuidle: Fix runtime PM based cpuidle for s2idle
Date:   Wed, 29 Sep 2021 16:44:49 +0200
Message-Id: <20210929144451.113334-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Maulik Shah reported problems to me around the s2idle support in the
cpuidle-psci driver. More precisely, calls to pm_runtime_get|put fails during
system wide suspend, because runtime PM gets disabled by the PM core.

This small series intends to fix the problem. More details in the commit
messages.

Kind regards
Ulf Hansson


Ulf Hansson (2):
  cpuidle: Avoid calls to cpuidle_resume|pause() for s2idle
  PM: sleep: Fix runtime PM based cpuidle support

 drivers/base/power/main.c |  6 ++----
 drivers/cpuidle/cpuidle.c |  7 ++++++-
 include/linux/cpuidle.h   |  2 ++
 kernel/power/suspend.c    |  2 --
 kernel/sched/idle.c       | 40 ++++++++++++++++++++++-----------------
 5 files changed, 33 insertions(+), 24 deletions(-)

-- 
2.25.1

