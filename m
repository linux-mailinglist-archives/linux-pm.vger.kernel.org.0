Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614A8216D44
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 14:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgGGM6V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 08:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgGGM6U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 08:58:20 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5522C061755
        for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2020 05:58:20 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c11so24630794lfh.8
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2020 05:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5QPCeXu6BWoF2sfrIOTCH52uavZZh/rGlBAHnTqsaz4=;
        b=Ys5Fb/WaS8vr4UorsC8qhs5CHXu/8HPGctmAymK7MD+Ml8caOqMDbDVxnlp8Mpc8ov
         u01apMYHmzuWiFAPnQlk4vT34z/mTv7e5XPkVrid6ozPF8pKyVP9gGsId9SNe0ktexTq
         w1H3gXqc9FWjwu0INVZpswlmTWb0mcDIv20mli68wMrF6NIFHcz/6g/b5Aj5ZYBpYeJR
         tMlPZvMff3+UWJi8PQi4P48iwCz/iCZIHKNQ7EepFWka7zh5slKAViQUs6glEY4T+n2M
         u2wOTAjx/RCN8Su7L5in76xf4MjkAHjoYSxNXCVyk8rWPk9fSpZ+09SZXBHLscvmdatx
         IWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5QPCeXu6BWoF2sfrIOTCH52uavZZh/rGlBAHnTqsaz4=;
        b=CzYWIhNtq2ELRd7O2IK6rMari7h3dJSIOi1iSlqlMImiRsgFyqNjGhy7f9dInFUdoo
         c9jZuuxnCQ/bfieVhxFNA0SKqlN/D4GoY67WU1LBEZuFw8ttbRsu7xE8VJLsfsj7HTLk
         UctATm1SP633A/QkuqQs/UsZdPbhfM49/+JFeHWC07Ek++la7F6tEFel/vSqv+jq+9cY
         WZ6fVTfKgw5avDmthdfMPTcBrLExvcHE0qXrrbE+aqWNLFlf1Jlvb22ggWEpwSqUCh0s
         KlXSGnS1RB/kgVCKDRLXEBbGPjBQsukcIFL9+dPa3NyZS9ThQqoTmQZt/R5049/Syr38
         r30w==
X-Gm-Message-State: AOAM532ZBQ9VTx/X3+MpVOkBYN41/DIdp5stZkjvu7+q3hwAhs0jpI20
        PD6VctOtMUnYtp3gIJu6X+mL1g==
X-Google-Smtp-Source: ABdhPJwvZp/vEWWuRsY3Dn6udiBMekr0CNBH1Hn4mVH3JFB2UJhhamlayZQ6suVRhfRPbR6zWbqJ8Q==
X-Received: by 2002:ac2:5296:: with SMTP id q22mr32640404lfm.106.1594126698144;
        Tue, 07 Jul 2020 05:58:18 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id 11sm9554395lfz.78.2020.07.07.05.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 05:58:16 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Saravana Kannan <saravanak@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/5] cpuidle: psci: Various improvements for PSCI PM domains
Date:   Tue,  7 Jul 2020 14:57:59 +0200
Message-Id: <20200707125804.13030-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes in v2:
	- Put patch 3 as patch 1 and rebased accordingly. No other changes have
	been made.
	- Added reviewed-by and acked-by tags.

The main change in this series is done in patch 5/5, which implements support
to prevent domain idlestates until all PSCI PM domain consumers are ready for
it. To reach that point the corresponding code for cpuidle-psci and
cpuidle-psci-domain, needed to be converted into platform drivers, which is
done by the earlier changes in the series.

Additionally, some improvements have been made to the error path, which becomes
easier when the code gets converted to platform drivers.

Deployment for a Qcom SoC, which actually takes full benefit of these changes
are also in the pipe, but deferring then a bit until $subject series have been
discussed.

Kind regards
Ulf Hansson

Ulf Hansson (5):
  cpuidle: psci: Split into two separate build objects
  cpuidle: psci: Fail cpuidle registration if set OSI mode failed
  cpuidle: psci: Fix error path via converting to a platform driver
  cpuidle: psci: Convert PM domain to platform driver
  cpuidle: psci: Prevent domain idlestates until consumers are ready

 drivers/cpuidle/Kconfig.arm           |  10 ++
 drivers/cpuidle/Makefile              |   5 +-
 drivers/cpuidle/cpuidle-psci-domain.c |  74 +++++++++-----
 drivers/cpuidle/cpuidle-psci.c        | 141 +++++++++++++++-----------
 drivers/cpuidle/cpuidle-psci.h        |  11 +-
 5 files changed, 150 insertions(+), 91 deletions(-)

-- 
2.20.1

