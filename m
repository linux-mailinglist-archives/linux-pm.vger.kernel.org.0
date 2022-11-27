Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C473D639B4E
	for <lists+linux-pm@lfdr.de>; Sun, 27 Nov 2022 15:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiK0OSD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 09:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiK0OSB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 09:18:01 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DE8D2CE
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 06:18:00 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b12so13112144wrn.2
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 06:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mpiTMs/bm1wIhU66d2WA2juvNisiarCxmVPwVf/noJc=;
        b=CS03/7Oq3hp6rz4NPYWfXdlenemW21COELMeRig3aC2SYx3NQvXnJwgPiXa7VhXdAc
         x7AQSSpSpYKrO5mGTEVWZ3zIjl3oMYA7EbIHYDlUA7UkSMQg+QL/e+U+afbTd10fd5wa
         rlY2Wj4wDmrZzxh9gPAqGv1DzPWGF6UoF6bJhvPLCGvSkOlkPh0zBW5kp9ZomYj2R5Yw
         MLLz6Q0+C40gnrmzmgoLYiDA+/+VRP7c7bCHwyRMuCyzu5iwYhFdvqZvbael6nAJ0zp6
         H67jjZaJCEFlaDFPPbjzr+kDA0Ox0JshhQp8hIetJpxgvLwf7ENuL+GaUXReapKD83QJ
         jIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpiTMs/bm1wIhU66d2WA2juvNisiarCxmVPwVf/noJc=;
        b=dTo8+E1cc9T2rdEz8uGqvr+V94QSiKrYwGIxGPsDCB1y6xDzleQJ4nji49rqJ/uW7J
         nJSiXoWnEJB9ayrxVSy5GsLMJjQL6MOOjByYU9Wc3hJu2Zl1CFYYZKXBWMANgQl1/omr
         w/tNbuID9LG/2oM61ft7ux3d3W2Gj4YrD1uDs69mZtILqO8egm4ibs7BH/xeqeG8nUS5
         jf2KmPOnOPC4K1wZba8c9dLJipKLlvtCVrrGGGB8DZYQFabBFUPuScFAYqMJ7pJo6MhJ
         tXldvN7RvsgC0mSX/vUZdGZ2sxbp89+9EEJt24q0BzJd4lrCj8iLxjMp6mO4eJGtwfar
         dsTg==
X-Gm-Message-State: ANoB5pmp9rPPduYXFDrKAmQ2lWVPu+1RjtPBmmuW9Fa1oFntYL3I5Mr+
        x3PWzYATPxGPE6k/7c93sPgVsg==
X-Google-Smtp-Source: AA0mqf5iD8x++P3wzr1U6y34gjqkmOnkFDw8fodqu5GlTcetKXVpYtsD+Gn25KFCiMBT6Ke4UxqK4A==
X-Received: by 2002:adf:d207:0:b0:242:880:20cc with SMTP id j7-20020adfd207000000b00242088020ccmr6337851wrh.467.1669558679398;
        Sun, 27 Nov 2022 06:17:59 -0800 (PST)
Received: from localhost.localdomain (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id l1-20020a05600c4f0100b003c6f3f6675bsm17109757wmq.26.2022.11.27.06.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 06:17:58 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        "Qais Yousef (Google)" <qyousef@layalina.io>
Subject: [PATCH 0/3] Fixes for uclamp and capacity inversion detection
Date:   Sun, 27 Nov 2022 14:17:39 +0000
Message-Id: <20221127141742.1644023-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Qais Yousef (Google)" <qyousef@layalina.io>

Patch 1 addresses a smatch warning reported by Dan Carpenter.

Patch 2 fixes a couple of issues reported by Dietmar in capacity inversion
logic.

Patch 3 is an RFC patch to decouple capacity inversion detection from
performance domains which is dependent on sched_energy_enabled(). I switched to
traversing cpufreq policies instead. Rafael, Viresh please check I didn't do
something stupid here.


Thanks!

--
Qais Yousef

Qais Yousef (3):
  sched/uclamp: Fix a uninitialized variable warnings
  sched/fair: Fixes for capacity inversion detection
  sched/fair: Traverse cpufreq policies to detect capacity inversion

 drivers/cpufreq/cpufreq.c | 12 +-----------
 include/linux/cpufreq.h   | 26 ++++++++++++++++++++++++++
 kernel/sched/fair.c       | 18 +++++++++---------
 3 files changed, 36 insertions(+), 20 deletions(-)

-- 
2.25.1

