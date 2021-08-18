Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3848B3EF7BB
	for <lists+linux-pm@lfdr.de>; Wed, 18 Aug 2021 03:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbhHRB6L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 21:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbhHRB6K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 21:58:10 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA52C0613C1
        for <linux-pm@vger.kernel.org>; Tue, 17 Aug 2021 18:57:36 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y6so2136453lje.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Aug 2021 18:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nGsS4Q3dWPwjD1TiZ4e2piGx5s38ai23zpLeK5x/JGI=;
        b=neuK4DzYVj8H/M6gvXEjHPDyUm8wE0RYx1yXSQd+xUk/y/EIlxCI1yTK5DyuSUMINY
         TBYh6WhIBaL/Ma21SUk9NrbIKASuuZzybb5WzpU0jFEfXMlPDo7+5yDJtovM86aEL/Ix
         3G7FK+kFVDUr3NsstnHWGN1YEBIDarIvhO4iyWT4nITWl0EvggGZibz1qbV5Nvy3bFcm
         Yuy+0t7FagbgcD0TXvxaM0/Noc7ZrBvkdxBlTehAr+bz68MA3/QEzP88/xVdlhk70Ya4
         +JvRLMab39L7DU5/3K8riEkhqDvmvIZdw2zI1wGKIR61doYHU4iUjR9K4h0D2RozNB7u
         XorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nGsS4Q3dWPwjD1TiZ4e2piGx5s38ai23zpLeK5x/JGI=;
        b=UZ7tMvZL6jumHkRIWYuPP3LfbRkkSbaZgrF86yB+aEvF0CO/uMzvsi/09TpFqGlIjL
         tgoeJGu0asseizHHWoMR37KSFFKJixKloRyWaDKbvcvJYWBS0N5lFq6YfJ9meMO+NIU+
         ZGeWMNibmAH884effbvG5qPFqYU3/F2D4nwS9XQa2Eezd0gqoDwLn4Si2tER9vlcHTMF
         LVMizbb2VPU1FhYrUsGYAcso2WOrsQ8oy+64zQCRT9CBznEAf/Qfv/CxyPXtRD4X8SSl
         c5YkfsDq0u7wmK30uJv1PT/zBaQx8URHmrfvXCfhEKq1ti54vsAHU1TC5fLW3nJbNBe+
         Q5EQ==
X-Gm-Message-State: AOAM530qHYP2hfql6I3KUR2kVjkzy1xIpmvOttcv384edQMGNyiM6wEF
        +reKofO//2M6+LiWWxmPUlFlAg==
X-Google-Smtp-Source: ABdhPJzyLzP1Jmjmxn385DssvQvMRT9k5qzxXTsbO5cT0+dLBrIPISIH0JUg2jvzk3f7gKLCdaFi/Q==
X-Received: by 2002:a2e:5c9:: with SMTP id 192mr5605135ljf.337.1629251854720;
        Tue, 17 Aug 2021 18:57:34 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y8sm349500lfh.249.2021.08.17.18.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 18:57:34 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 0/5] interconnect: merge AP-owned support into icc-rpm
Date:   Wed, 18 Aug 2021 04:57:27 +0300
Message-Id: <20210818015732.1717810-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch series merges support for AP-owned and bus QoS from SDM660
into common code (icc-rpm.c). MSM8916 and MSM8939 support code is
extended to support these features.

The following changes since commit 7c60610d476766e128cc4284bb6349732cbd6606:

  Linux 5.14-rc6 (2021-08-15 13:40:53 -1000)

are available in the Git repository at:

  https://git.linaro.org/people/dmitry.baryshkov/kernel.git icc-msm8916-sdm660

for you to fetch changes up to 13c58bed52008460d0f0ce60ae1097d6f8fa7c0a:

  interconnect: msm8939: add support for AP-owned nodes (2021-08-18 03:23:32 +0300)

----------------------------------------------------------------
Dmitry Baryshkov (5):
      interconnect: icc-rpm: move bus clocks handling into qnoc_probe
      interconnect: sdm660: merge common code into icc-rpm
      interconnect: icc-rpm: add support for QoS reg offset
      interconnect: msm8916: add support for AP-owned nodes
      interconnect: msm8939: add support for AP-owned nodes

 drivers/interconnect/qcom/icc-rpm.c | 270 +++++++++++++--
 drivers/interconnect/qcom/icc-rpm.h |  63 +++-
 drivers/interconnect/qcom/msm8916.c |  83 +++--
 drivers/interconnect/qcom/msm8939.c |  95 ++++--
 drivers/interconnect/qcom/qcs404.c  |  13 +-
 drivers/interconnect/qcom/sdm660.c  | 662 ++++++------------------------------
 6 files changed, 517 insertions(+), 669 deletions(-)


