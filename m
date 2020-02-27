Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B217F1717BF
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 13:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgB0MqN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 07:46:13 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42421 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbgB0MqN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 07:46:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id d10so3227152ljl.9
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2020 04:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hEHNqtZr84prvnGzPTSQM0fiaw+Go9OgL/MTasulZ2Y=;
        b=WDhilDJ/typ2BlzCcai6/yKM8rKBFjmzv/89fuWAqwLgzVG9CyfSB5jCS4iKBnhXPA
         UYx2q22HanCoBiu6uQWZHkTgy8H0eCi4Y+eHb0oR5CjhltvlIKiTUNt9fcq6WeIFEsv/
         iF9pOXg/hoSWdO8gse0z5/Gw24hawWMMFbz54QpiD7ZtG22k9swkMQEsZePf2vF8lGir
         1TQ0mMpzXOvu6mQPTwmx9TF6vzegax6N57+2HSsLEcSetlxuje5rpcRFS6szZ6OWQl7m
         vu2OqprK3KMDJZwfJv0jjt9HoGVpLk0FfWG+hY46k3woVXg2u6cUEcN6zDU8JDLZKXhK
         n8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hEHNqtZr84prvnGzPTSQM0fiaw+Go9OgL/MTasulZ2Y=;
        b=T+gl4XY/d5Hzda2es2HLn1Broix6Ucd3VS8XdhG2n5LpIAm315SUOqMcLJEsDcwFnl
         RbYrhLJKbkpXtgKtIVUAtYPBeig9HyrbFWxIwSEgWuzwhujCk3dTuZAD9A3foTydPVBC
         OwDdTvc51A85OkC+vXDU9MYtwRfggKwxHjUIg3vLL3iNUj3ZslpdJjirNhu+j2O3v5Oe
         feGryvajhnxqH+s+rpZRg01ppN7XR6FflEQtuEuux4jN8r8JaRTKNWcaal4bfP+jua6v
         0RKA+KWPLlkyk6I+LQsk3vMApOPydILlRGpey+CWwMnJhcvWE6XCMXuRtflKlP1WbwKQ
         Ia+w==
X-Gm-Message-State: ANhLgQ0jxb/jy3vJe32CLe0kyrMBqAF17uiI7V07MRtvVjJDGnkM1Ahk
        /Kopbco5J5zZN6A8m7vTb3CniQ==
X-Google-Smtp-Source: ADFU+vu7Ql4hYXMx5DHndFRCmO9xHiwjSi9zx0MKy0UsYpX2RBb22uIL9lTDVCtDCFwFTFuBxw4Eqg==
X-Received: by 2002:a2e:6815:: with SMTP id c21mr2538037lja.10.1582807571400;
        Thu, 27 Feb 2020 04:46:11 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id l16sm2669334lfh.74.2020.02.27.04.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:46:08 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
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
Subject: [PATCH 0/4] cpuidle: psci: Some fixes when using the hierarchical layout
Date:   Thu, 27 Feb 2020 13:45:47 +0100
Message-Id: <20200227124551.31860-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While collaborating with Benjamin Gaignard to deploy the hierarchical layout
for an ST SoC, it has turned that I have clearly missed to test a couple of
corner cases in recently added support to the cpuidle-psci driver.

This series are fixing the issues we have found.

Ulf Hansson (4):
  PM / Domains: Allow no domain-idle-states DT property in genpd when
    parsing
  cpuidle: psci: Fixup support for domain idle states being zero
  cpuidle: psci: Split psci_dt_cpu_init_idle()
  cpuidle: psci: Allow WFI to be the only state for the hierarchical
    topology

 drivers/base/power/domain.c           |  2 +-
 drivers/cpuidle/cpuidle-psci-domain.c |  6 ++
 drivers/cpuidle/cpuidle-psci.c        | 96 +++++++++++++++++----------
 3 files changed, 67 insertions(+), 37 deletions(-)

-- 
2.20.1

