Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EE83FEBEC
	for <lists+linux-pm@lfdr.de>; Thu,  2 Sep 2021 12:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbhIBKRh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Sep 2021 06:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhIBKRh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Sep 2021 06:17:37 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3777DC061757
        for <linux-pm@vger.kernel.org>; Thu,  2 Sep 2021 03:16:39 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id y6so2571601lje.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Sep 2021 03:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z5j+z2knFswIqtccUbslQnxBqrHmJjvXWyROy1vaNLY=;
        b=cA+CBG3rurJRoW2S1KmfZTf65dlOyf8SsSNkCCO6BQdGCDmdLJPksR/VAUxfUnJ23y
         ++6fJoIM7ayNUzKvGXwaLW038dNT/co454H1IzpnT+gUq7o+gjbQIstb+IN5r9Cf92Af
         14ygAfmtHrLlxJm4LssqXPSwRyM7nGYH4kfk9g6eYp+O/SNyCHvEdvJNn+Z9gikf3CAD
         KixYaSbFzbYQkEsLP/cg1T/fPArKYwzbvIP0Yl03zlnOxVg3h8wDNfUrlYvb6V69C1I4
         NEqyCr0/YrG6uTtKEKy/CLYfIA1ryjLGABq4m93uPWVU+L5MraOqQm0EkV6QfPxfEP1R
         lUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z5j+z2knFswIqtccUbslQnxBqrHmJjvXWyROy1vaNLY=;
        b=Hh6WI8VkCoasY85xEgi/7B5TZoQV94VFmG2wdE0duazlj7poh98nQUsHqpP7oSkkUx
         7QMimD2gfm/pBGuVADvZtljGpNfzBrArT5APoaXb2XSjTXk58OpLfnoZ7PqB8AMyvq6I
         SQF/YmMZpLfCQpATfXx4Or5rAHYa62kmuyVV9m5o449Jc95XZXwq7v9B/YrTyWEGyutf
         duC10zJWasWRxM5IfgEZLtYXdjmz15I/2Emh5RZ9GR7N1ezt/0RZv3nLy5Uk+ZhSRCsL
         khwGgkm0fO2DbY7gFPG4jbgmN+aO7Yidv2q0MMjLyN9E99S0QArhjND8JGkP4qi5AjaI
         303w==
X-Gm-Message-State: AOAM533DVJjh2/1BgucMT71X+XbMB6ABpRp+v4Ku626OLYJ0+IVwMaQU
        ketjeO1K9015s57XuxhmkqZtpw==
X-Google-Smtp-Source: ABdhPJwheBZMFrP5A7mLjFTz3IjQwGKnLn0NLB5gWuxOzhoTx3dlXdGpSKZ+qEOUyAwHWWdJODGkCw==
X-Received: by 2002:a2e:7603:: with SMTP id r3mr1878065ljc.98.1630577797471;
        Thu, 02 Sep 2021 03:16:37 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id s4sm155897lfd.53.2021.09.02.03.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 03:16:36 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/3] PM: domains: Improvements for performance states in genpd
Date:   Thu,  2 Sep 2021 12:16:31 +0200
Message-Id: <20210902101634.827187-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series intends to improve how genpd manages performance states votes while
device are becoming attached/detached to it. More details are available in the
commit messages for each patch.

Ulf Hansson (3):
  PM: domains: Drop the performance state vote for a device at detach
  PM: domains: Restructure some code in __genpd_dev_pm_attach()
  PM: domains: Add a ->dev_get_performance_state() callback to genpd

 drivers/base/power/domain.c | 26 +++++++++++++++++---------
 include/linux/pm_domain.h   |  3 ++-
 2 files changed, 19 insertions(+), 10 deletions(-)

-- 
2.25.1

