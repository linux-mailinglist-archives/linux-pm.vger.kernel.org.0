Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E984E81D1
	for <lists+linux-pm@lfdr.de>; Sat, 26 Mar 2022 16:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbiCZPxg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Mar 2022 11:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiCZPxf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Mar 2022 11:53:35 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9EDDEDD
        for <linux-pm@vger.kernel.org>; Sat, 26 Mar 2022 08:51:57 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h7so18026317lfl.2
        for <linux-pm@vger.kernel.org>; Sat, 26 Mar 2022 08:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PlDvWRoCj+ArlJrMoBlk51sIHiTX55gBU9keu3DzJMY=;
        b=dGejKyQEns9HFI3MBZ3gFfYLe0ttAoQPtYK+4tOAylvZ9z3AKk+Iy3Jf4w+Exf0oM7
         mc3JwMsGX5NLSCj2I/YuxRLGlqDNi98dUQ9SQx5wnVm74R+GsvqeTO4JX/Z4KqJX2cg3
         T3j/5l6GKY4asCndtM/a51s3bmg+bE7PJT1spCf0kbAzUKovKW5CZHozbPsW10YbfUgk
         LLjODXo+nzk1oNeTuPSRUxer4+42wx8uBSclsBmhI9+OMN4+sAYeJRZTVQzeohu/EYeS
         b2lbCASlaivEcPWu2s4A1SjGzuJgyjwtAoLMiLIN/+sXC8CFBz0Ynu6uPNFjcXADg5I9
         4ZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PlDvWRoCj+ArlJrMoBlk51sIHiTX55gBU9keu3DzJMY=;
        b=eYEkiXSJonZUtNrf4TIoeJEl68inDMf29WpcHsEOALhfDmg1OaENOYo5WYRKTmIiM/
         c9JP1HkCcgZ7ajKBI9q3dfThSZxiTbIqyy52ieRQ9mX6uKPWg6d34XTZHb1VeOknNPk1
         n388J5PQnArBvCU+zfrMzFuEQmx7uHbk/B1kF4CaL+okDQRL4kJLO8KMtkq63lvb59rl
         iBPODwdq1ugWPIIoekbTS9hj60aTNxUuMtmIWOgjTfxxe92Z1zrKTdxX5/lsoOT8q7cO
         ckG1qPQ7zlehlfCMk89LLB9Blou1pSSW+Cu0AsPkGNHkCFOfYUablunxcI2QEf0NtPk/
         F6xA==
X-Gm-Message-State: AOAM5328Bg2AwIIvcMufIXD7SWwVuKvTcA/oEw406ayvG1s54ca9QyD+
        zyGZZLN0eFpv3b8QUnYD00GtQw==
X-Google-Smtp-Source: ABdhPJzR/845rjNc5q6ikAGYm/pAOIS9N58+i7qHnCKYeyXJZS6c2HvxjtXpn2edHWfrNPIIL0EiDQ==
X-Received: by 2002:a05:6512:3d13:b0:449:fd85:f61d with SMTP id d19-20020a0565123d1300b00449fd85f61dmr12772775lfv.368.1648309915000;
        Sat, 26 Mar 2022 08:51:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([185.24.52.156])
        by smtp.gmail.com with ESMTPSA id o17-20020a05651238b100b00443c898b598sm1097992lft.112.2022.03.26.08.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 08:51:54 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v4 0/4] cpufreq: qcom-hw: Fixes for cpu hotplug support
Date:   Sat, 26 Mar 2022 18:51:49 +0300
Message-Id: <20220326155153.7377-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
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

This patchseries aims at fixing and improving CPU hotplug support on
Qualcomm platforms. First three patches are the fixes for the LMH
support in the cpufreq driver. The last patch adds support for
lightweight offline() and online() callbacks which are used instead of
exit() and init() each time the CPU is put offline or back online.

Patches 1-3 being pure simple fixes can be applied during the -rc
stage, while patch 4 is targeting next development cycle

Changes since v3:
- Readd throttled_freq calculation disappearing from the third patch.

Changes since v2:
- Point Fixes tag from the first patch to the correct commit
- Replace huge patch 2 with one-liner thanks to being able to use
  policy->related_cpus instead of policy->cpus

Changes since v1:
- Update commit message for the first patch to describe why dropping
  affinity hint is required (before calling free_irq()),
- Fixed commit message for the second patch to include messages
  generated using the mainline kernel w/o additional patches,
- Changed third patch to use dev_warn_ratelimited(),
- Reworked last patch to move request_irq/free_irq to online()/offline()
  to make sure that the IRQ isn't left enabled after the CPU has been
  put offline.


Dmitry Baryshkov (4):
  cpufreq: qcom-hw: drop affinity hint before freeing the IRQ
  cpufreq: qcom-hw: fix the race between LMH worker and cpuhp
  cpufreq: qcom-hw: fix the opp entries refcounting
  cpufreq: qcom-hw: provide online/offline operations

 drivers/cpufreq/qcom-cpufreq-hw.c | 45 ++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 7 deletions(-)

-- 
2.35.1

