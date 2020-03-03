Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6680178417
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 21:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbgCCUgT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 15:36:19 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41813 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730081AbgCCUgT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 15:36:19 -0500
Received: by mail-lj1-f196.google.com with SMTP id u26so5040527ljd.8
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2020 12:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5+bbZY+UsNnL04aTIiRpPmDrPXRA/0XmSjw+FgKbksk=;
        b=MYdizgquonWpZBpfTQ0jzerK3kK9LeudcWxqxJ710OmJ3xPJXuGTJy9PMARessYarQ
         RJCnp9pKXBCsDDk5QJC+LDix5HGrmNOlG4159dEsvuoIMVofyHybb5PZoQ3VJHjEW2O4
         uZGu7eeWv/4kJ+f0W+umTqAHZ+s6Cst+KhrgYUN5srxUgzM53QS8yORqxHWzb24ebYBs
         86ZuCfk2d6ZQ/XeDwgvM/ax4OTWoyWyNsvF9djVefusgQEmGRXAGHPo0pjzraimis4VL
         LZDq1l6640NeHHEIsHh+0dut90Z4ONsCGjBrmOxyjgarr6dGyn8YSIW/odBez8wylQSy
         QMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5+bbZY+UsNnL04aTIiRpPmDrPXRA/0XmSjw+FgKbksk=;
        b=JC5dYFZtPJSIoW7CCiVWm6S47lVpNlz9uJuVPmTqu81eT8Dq9QQ6m3W0Uj8B7xQ4Eb
         0rIRL/27P+mCpJIqDnDx80KiC6GcvfSFRy31EeSqABiCBIlaJpo9cCLdiEn3ImWnof+N
         QS9jAzym/BmSRZ/LMBqKfxreeRRNgdAasid/Lg830CC62rznGBn0QW087SMd9yJINwhu
         uShxjStNOP+lMfAoyD0hyQLAJennsHJ228TK9ikCMJR+vWfZnqAzIvRn2HHSoA5e4Z9t
         hFQuXD8PR9WRMIaPwbYHqHfDH8Wz0iinOrTisein4rM4RIuLIRYucE7iVqeUqmcXOR3v
         g+tA==
X-Gm-Message-State: ANhLgQ3vRVdEVxL9bnyzfZ3eZWrZ3G8TLWQhRc84SFZfeK44bcj2Z/La
        OZw4xIqdSXDO9dD7D3xBdw1nfA==
X-Google-Smtp-Source: ADFU+vs3C98soMOJnxS970oeUUzODjBIS+POFjrHM2XmE9VThLMxFSqHh+D6NIBRdP/2VoBr1tq/QA==
X-Received: by 2002:a2e:80c3:: with SMTP id r3mr3439399ljg.105.1583267777636;
        Tue, 03 Mar 2020 12:36:17 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id t195sm1339532lff.0.2020.03.03.12.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 12:36:16 -0800 (PST)
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
Subject: [PATCH v2 0/4] cpuidle: psci: Some fixes when using the hierarchical layout
Date:   Tue,  3 Mar 2020 21:35:55 +0100
Message-Id: <20200303203559.23995-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes in v2:
	- Small changes to patch 3 and 4, see their changelogs.

While collaborating with Benjamin Gaignard to deploy the hierarchical layout
for an ST SoC, it has turned that I have clearly missed to test a couple of
corner cases in recently added support to the cpuidle-psci driver.

This series are fixing the issues we have found.

Kind regards
Ulf Hansson


Ulf Hansson (4):
  PM / Domains: Allow no domain-idle-states DT property in genpd when
    parsing
  cpuidle: psci: Fixup support for domain idle states being zero
  cpuidle: psci: Split psci_dt_cpu_init_idle()
  cpuidle: psci: Allow WFI to be the only state for the hierarchical
    topology

 drivers/base/power/domain.c           |  2 +-
 drivers/cpuidle/cpuidle-psci-domain.c |  6 ++
 drivers/cpuidle/cpuidle-psci.c        | 92 ++++++++++++++++-----------
 3 files changed, 63 insertions(+), 37 deletions(-)

-- 
2.20.1

