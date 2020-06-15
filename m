Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9861F9BCD
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 17:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgFOPVA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 11:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbgFOPVA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 11:21:00 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6943C061A0E
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 08:20:59 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so19703242ljc.8
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5YUAhbASJon5GxhmWno0UoRd7BXd3jntWstkJEM2o8s=;
        b=yNn2ctI1SfK1LU9sjVUCAZM9mhj4YDZuAWmfynbvq85hPMfnCOhaC6oCQBS3Q4um9u
         mv1svS6NviJsqTxaZEffHLdtwWaeLQ3xfQnJgPM2jFVQ93fQ06n1B35N/Vnq4XVvNL+i
         pQSTGwfgG+Ewgxvnps2493sU126aJvkx55UYYaObKtYFBs2Pbm36wyapZiko4NGGs40c
         hJi46M5jehm/uTcc5wQOa2uaYjxg9upPkg5I4HWroA8iBTW/7i+oBk7HRNw7Mep0BYoL
         lPvEOj7HJlpEgxeuVQ2Lc936Wo65dMpvixTd60yjBJE97GplYXkCEebiQ7DLpbn4wu9S
         L0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5YUAhbASJon5GxhmWno0UoRd7BXd3jntWstkJEM2o8s=;
        b=JzX7YpNojo90Xv1JMneodzNSEo0Uv3TSfZFuXTaG2qdbX6BCEuxhlgwnGdT3LFvYuw
         BVqufxlaOdGeEAUA/Zuw0y6qVoslEF0p5dmOUQ+8jdjkXLPVBKD3UgIQobFC5/YhjVkj
         e3B/6jC/K+ISpDKy3Mv7lt/5GswYrhhycHyUbuWc6/wVvKcGhxbe7Aw6y4kswtSfYCYs
         d1XVXrNkjjcjVpX1a8K4Xwx8oTdlrilPsXzrHLscJLFb42QBZSsP4tyh1yX8g4XPHn8z
         /cP8DLRImxw++96Dgfa3E9JAq/m6AdrxH/gNtwRDxNe/RngxD+SEiH1XeDFxgBuvOjvA
         kWeQ==
X-Gm-Message-State: AOAM532SeSqSDfrbhyMxJdxItHtpUCjET6HGulSWEn4m4/EGGuBPNRTK
        S9K4iyuip0Fzbox4qTyTXVGYyA==
X-Google-Smtp-Source: ABdhPJzFxU2e2MXPewL8AqJPAT1Mbo56PQXpiOZD7US0acJ+F2SxlwrrnbD5r4HvBYB8XfHD2pIMHw==
X-Received: by 2002:a2e:8809:: with SMTP id x9mr11781735ljh.442.1592234457863;
        Mon, 15 Jun 2020 08:20:57 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id r13sm507045lfp.80.2020.06.15.08.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 08:20:56 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] cpuidle: psci: Various improvements for PSCI PM domains
Date:   Mon, 15 Jun 2020 17:20:49 +0200
Message-Id: <20200615152054.6819-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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
  cpuidle: psci: Fail cpuidle registration if set OSI mode failed
  cpuidle: psci: Fix error path via converting to a platform driver
  cpuidle: psci: Split into two separate build objects
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

