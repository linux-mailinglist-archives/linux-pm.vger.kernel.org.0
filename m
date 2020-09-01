Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D31258A53
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 10:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgIAI1U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 04:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgIAI1R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 04:27:17 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E92C061244
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 01:27:16 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h19so440485ljg.13
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 01:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DyiOO2gbTzhegJyR3eptVxnGlyGt5L5+5gJciUVklg0=;
        b=b8KDdpxd05PgoF9MHDaCNP0ApfE/tdGhbeERtfXhhQoMnHfrBxXx6nTCRQO3Fyfig4
         uOlPir09j6feYspZvqwHBM7ZiuiDOiOgGJ0zoNAycftk3UfTsh8WkLz32LllUt89IRKM
         eiwZSF4upyDKFYalT2uJ/ScemNnB66gculNqFBg+0PkUDvtVUJbjM0wg/0BVvxFxDjmY
         qPr77Z2vDu6fwpman6NUPF34mXSVFVR6ugshExq11iszAeYyQBvYylCQUOMp6u1SvVvT
         +np6ByUyhx5swVLhVbc3Ulb5imlGcd8dp3sMu8ki+uTbzMbR3hqO3KyldMnb7SXpUvqk
         yfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DyiOO2gbTzhegJyR3eptVxnGlyGt5L5+5gJciUVklg0=;
        b=dtN2Ggz8+T06R+NdGl7Q7Dgo9Fq7Z9eaQpRJLQdcvJl0qoJZFElbS+JqJhd0BfllOk
         MpFnvUwNml0vRPQBR/YoPhc6dUFtb8yuACPSLo7kUtggMw8cKaqFKsC3ziHcT5LhCMg7
         W/9m1EGYZ3/L2q5UtoiqHVOgwgq85ayfeZGm//uSFFuCoRuzC+sAS7ZFvkyxcMDEQnxP
         2yKPuk+0NKcA7XvbZpHvsOmZ6uLfX65JFb/srBw3s5t0SQFBG3GXHIWsXwQBP/9MI4Ay
         KdjOFPplg5TLREpkLtO7SZml4AaPWmk8XOyb3stTN0v+35v/AlSu3oCMO9vpL3eT8cSX
         Pv0Q==
X-Gm-Message-State: AOAM5324I2rD3HN+i96XL5IZ2dk9+66JlO0bOSZvm4w5h8a64IybgB0s
        typ8vVbdsL8lmdzxh8laOO1RLez2/AJhFAuA
X-Google-Smtp-Source: ABdhPJwUVxJuaHjXXhTGDUrbiL4sCIdcVh822bFUMtb8+IPh6zPjQMIRDXRRyKZvRak+dwcc5AWgHA==
X-Received: by 2002:a2e:8648:: with SMTP id i8mr5046ljj.288.1598948835288;
        Tue, 01 Sep 2020 01:27:15 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-79.NA.cust.bahnhof.se. [98.128.180.79])
        by smtp.gmail.com with ESMTPSA id c5sm111252lfb.24.2020.09.01.01.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 01:27:14 -0700 (PDT)
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
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] cpuidle: psci: Enable s2idle when using PSCI OSI
Date:   Tue,  1 Sep 2020 10:27:05 +0200
Message-Id: <20200901082707.106860-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When using PSCI OSI together with the PM domain topology, the domain idle
states becomes selected via calls to pm_runtime_put_sync_suspend(). This works
fine for the regular idle path, but not for system wide suspend-to-idle.

This problem is because runtime PM gets disabled by the PM core, during system
wide suspend. In this small series, these issues are being fixed.

Kind regards
Ulf Hansson

Ulf Hansson (2):
  PM / Domains: Enable locking for syscore devices for IRQ safe genpds
  cpuidle: psci: Enable s2idle when using OSI with the PM domain
    topology

 drivers/base/power/domain.c           | 13 ++++++++++--
 drivers/cpuidle/cpuidle-psci-domain.c |  2 ++
 drivers/cpuidle/cpuidle-psci.c        | 30 +++++++++++++++++++++++----
 3 files changed, 39 insertions(+), 6 deletions(-)

-- 
2.25.1

