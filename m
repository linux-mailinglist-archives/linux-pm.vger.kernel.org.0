Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3F5399DE9
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 11:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhFCJho (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 05:37:44 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:34558 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhFCJhn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 05:37:43 -0400
Received: by mail-lf1-f52.google.com with SMTP id f30so7877635lfj.1
        for <linux-pm@vger.kernel.org>; Thu, 03 Jun 2021 02:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W2qohUx5zvhRLc6tyEmW8SgJ1vqoJNLaHxoGTkcoMlw=;
        b=nk8B/VdWmx3KAqA42yHHA3SMsqWeaAApkaBxCr8d7U/DoYUBhJk2eMiGbLG2xY3KSn
         8yfkDnfYsyyB+JRo+vWsEoV3urS7U355PL27lVoLO4lo0N6ulYRZOeJOB/K4C1L3IJcJ
         qHgHTUEVUWH4EqPFK4iYVeDx0T5WA6VNFSGqTBilmHVAGUwShzf7rzqoewS5bm5T+YZD
         OTB4FxcnNFGJvSA3FIZxZEYEYJWGv6xZGTPrTcfr5amf61fOLQ7jp+1FYDAZR2lh8ETA
         y6/3fGJPh+DpX579pnaw9pO77k42Fyz6/xFcBupTzmOrccUjwFa49RazJ+ayor3O4Kbs
         02Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W2qohUx5zvhRLc6tyEmW8SgJ1vqoJNLaHxoGTkcoMlw=;
        b=XrRSNgHCgAWBYo+qnfSosshK/O644t4Fva+qm8ff9RSPPA7tMLEGJX2jJocOPpetiP
         WjS+8Xe5FkcNCAbfjEei55Wg32sp2Kef26E/hQbrD2lzrPVI0yYwLI2lWkklSGrLeEoJ
         pEiQX1/zmpWfembCsjiQVr7JpXdwBHj8YykOmldW9QezvMudxV2OzgOk1fxX6Zu1paLo
         gQ4lTMCekMsjzj8P8dAPsUxSMnGogLvN9h201gSbmreNSI5HjzTLqZzSMlDDdKrVutyJ
         tzhoAf5oKzrWSWXQY8pLTBh95GVGspS83VPUO7nWviqsXWzwhRU9slMhaYZH5EiLIYWn
         ec0A==
X-Gm-Message-State: AOAM530VjNTm3v2yHDg4+EZBPEs+r03MBA5WYB4ZyvmUZ8D1xsHUqin3
        rTMKY5NDfAt69b6holJPciXMOcHAzGxcbzgt
X-Google-Smtp-Source: ABdhPJxKARwFPjRnFkZHuPnu3FusqFdLnePffuVIc/oEngA5mhIyEyAAbQBPSM/kS6I3xgVoFP6VWQ==
X-Received: by 2002:ac2:443b:: with SMTP id w27mr6921374lfl.295.1622712885178;
        Thu, 03 Jun 2021 02:34:45 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id q4sm263373lfc.172.2021.06.03.02.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 02:34:44 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] PM: domains: Avoid boilerplate code for DVFS in subsystem/drivers
Date:   Thu,  3 Jun 2021 11:34:34 +0200
Message-Id: <20210603093438.138705-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Various discussions on LKML have pointed out that many subsystem/drivers for
devices that may be attached to a genpd and which manages DVFS/OPP though the
genpd performance states, would need very similar updates.

More precisely, they would likely have to call dev_pm_opp_set_rate|opp() to
drop and restore OPPs (which propagates upwards into performance states votes
in genpd), every time their devices should enter/exit a low power state, via
their device PM callbacks.

Rather than having to add the boilerplate code for these things into the
subsystems/drivers, this series implements the logic internally into genpd.

Concerns have been raised about this approach, mostly by myself, around that it
limits flexibility. On the other hand, it starts to look like more and more
people are requesting this to be manged internally in genpd, for good reasons.
So, I think it's worth to give this a try.

In the long run, if it turns out that the flexibility was indeed needed, we can
always deal with that as special cases on top.

Test and reviews are of course greatly appreciated!

Kind regards
Ulf Hansson

Ulf Hansson (4):
  PM: domains: Split code in dev_pm_genpd_set_performance_state()
  PM: domains: Return early if perf state is already set for the device
  PM: domains: Drop/restore performance state votes for devices at
    runtime PM
  PM: domains: Drop/restore performance state votes for devices at
    system PM

 drivers/base/power/domain.c | 70 +++++++++++++++++++++++++++++--------
 include/linux/pm_domain.h   |  2 ++
 2 files changed, 58 insertions(+), 14 deletions(-)

-- 
2.25.1

