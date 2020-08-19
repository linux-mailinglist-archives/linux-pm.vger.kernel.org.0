Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447AE249A98
	for <lists+linux-pm@lfdr.de>; Wed, 19 Aug 2020 12:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgHSKla (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Aug 2020 06:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgHSKlZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2020 06:41:25 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D116C061757
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 03:41:24 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 185so24778993ljj.7
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 03:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8j9EGJFaSYFS5klbcZOeULgDjTEPoTVPGEbkdeSYqgo=;
        b=dIjzW/35yhnRnkFxvUPgMbWqfhAzruk/AqhRBDa2WxPDWwQYDGxGYfUp2HwEpekPS1
         AWp6OT3mGiEZP3SLGhcpZOn+gwIUn/+8mk6dvxeY0+8kgMiReWklihQ24BZ52YeU3VI2
         /jCyxxG4I/hzppae2+GHiGmr2UOufLHObk28gPDj/9K1PDpoDcIqzV4IvQNEZ34YAAmD
         ENyVMVvQcsyDxMyjbag4fRSqtylR5Mtr6Db4A8KHpI5lXo5QUcWMf2AyX8cV7wLvAhoi
         ro0wlCUEntEQgslF8gruZw3+mCQHccuTouSq7ivN9mFwWQhzVDuhLg8Rf1UggKLqrRz8
         Cy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8j9EGJFaSYFS5klbcZOeULgDjTEPoTVPGEbkdeSYqgo=;
        b=RtCvq1gz80m+Afu3JnZs/kV7yRnkxn2yKIJL1dN57rJi0bC1klXxKcxgO4TBPkbO3A
         QhN/V6jX4UxuTaQtxAMT1MMz8CU+l17fE9EpCx7PAI8YdAJeCzWh2ddK564SCf9u/xI5
         v+zd+DIund335pJw9leZstL44IPRtMuNfznp3fu8kDjAwaam+wvI0ombYZfT4vobjHNE
         s5PFoc4x7GWb1ZozE43f25nEo56Pm1sWztD8RBhdR5HWpjCgkKS4OPYStR0qtomsiKNF
         pkZOGMzE48fOLCwOAis9EMq+12ReBwub49/yB1EAUeCs9T/SEibWI7UOKtW4YRFe07pu
         w6Pg==
X-Gm-Message-State: AOAM531mVrxdtHW0UOrATxOUxxB81W7dMzD65vMERedmXNbVrq9XFktu
        SjsF1GtAb70U6UKww+28Fk4sgg==
X-Google-Smtp-Source: ABdhPJz2zqhf1rESCZqK5+UPE9Oyn+XjrrpI/jbRrqtY1rurHAv9YpsIlk7mPhkhznOPTWag/G+Fag==
X-Received: by 2002:a2e:898d:: with SMTP id c13mr10887217lji.236.1597833682965;
        Wed, 19 Aug 2020 03:41:22 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-79.NA.cust.bahnhof.se. [98.128.180.79])
        by smtp.gmail.com with ESMTPSA id y13sm6534822ljd.19.2020.08.19.03.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 03:41:21 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] PM / Domains: Add power on/off notifiers for genpd
Date:   Wed, 19 Aug 2020 12:40:54 +0200
Message-Id: <20200819104057.318230-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A device may have specific HW constraints that must be obeyed to, before its
corresponding PM domain (genpd) can be powered off - and vice verse at power
on. These constraints can't be managed through the regular runtime PM based
deployment for a device, because the access pattern for it, isn't always
request based. In other words, using the runtime PM callbacks to deal with the
constraints doesn't work for these cases.

For these reasons, this series introduces a power on/off notification mechanism
to genpd. To add/remove a notifier for a device, the device must already have
been attached to the genpd, which also means that it needs to be a part of the
PM domain topology.

The intent is to allow these genpd power on/off notifiers to replace the need
for the existing CPU_CLUSTER_PM_ENTER|EXIT notifiers. For example, those would
otherwise be needed in psci_pd_power_off() in cpuidle-psci-domain.c, when
powering off the CPU cluster.

Another series that enables drivers/soc/qcom/rpmh-rsc.c to make use of the new
genpd on/off notifiers, are soon to be posted. However, I would appreciate any
feedback on the approach taken, even before that series hits LKML.

Kind regards
Ulf Hansson


Ulf Hansson (3):
  PM / Domains: Rename power state enums for genpd
  PM / Domains: Allow to abort power off when no ->power_off() callback
  PM / Domains: Add support for PM domain on/off notifiers for genpd

 drivers/base/power/domain.c | 178 +++++++++++++++++++++++++++++-------
 include/linux/pm_domain.h   |  19 +++-
 2 files changed, 162 insertions(+), 35 deletions(-)

-- 
2.25.1

