Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A48A258E74
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 14:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgIAMpe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 08:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgIAMMh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 08:12:37 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B489C061244
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 05:12:37 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w14so1210697ljj.4
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 05:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eu1KXqfMY0kVWnLuJx6qu5Cov1wboqm87rUBKcm7yAM=;
        b=OljWryjSPBpayWSYslBEad6cU+WlRNYtk/vNsNlzxDrrtWebylG14YuIZAXQMpNG7s
         764t+n/1SE0az3qFcbzO7Pdss9btWXsgtJHmIA6QFlkVxIjzrmFI1JTqWay7cTMnIcu7
         8uHIqGEFmI3dT8EnPR81rj2D1J75fFJutjQasT/LkNPDeZ+iPuGLc1LK//WRxu11oSNy
         X+4AXyozZuMek0Js//+Zo5qnfg+nEBqsyDp6U2iF9xkMiz0fquTW40QRrXSaHgbcW6Ai
         OvPGUE75SOVtXz0S69MKRWghqZjWUqgsXhldWlxVjUybbbsDPH3fo0vYKIZAvM4KVhdY
         1nRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eu1KXqfMY0kVWnLuJx6qu5Cov1wboqm87rUBKcm7yAM=;
        b=aFBqMZuRjugczPDZu7U2w8upMl0lUXeM+nnEJ5YL4Ui/f5NANiXvPBPDkaK9Ylxdie
         1ZBeUcyU+rem5tM82jv1gPgUtKYdx4ozbf/KKMK4/LYXpR3qOJtnk7qnoC7mk6qsKbXv
         s8fGbv/npJQNDqbZgy99JTTV6ZzM+tGuKxabdMsfGJYBtLEoyhbttb02JRmXDM/GOqWY
         QUkBksh38WJK4hgwPI14UH1v7NcxXuqzK03a7m1jjGDtKJOitwWSFJg4FJE1ReVKMt3W
         59flzY5iB6Dynuq2D5yaej84tCBZav3pdj86GJtirmfeG22vO/8vPJW3G7DFhNOHge3l
         htww==
X-Gm-Message-State: AOAM533zFptbXZgTdOhDt/PK/FM3tDF/WZosXmmM1Mm2Z7kEwIGhcKjv
        es+EPOM+2JWq/97ketfwCJIGXA==
X-Google-Smtp-Source: ABdhPJz7seY5100OHmxs8/EpqKSk1Bq7NPeAsIxjsz5vu6AxXqgjUAFCnJ8sYfx6Mk93VTfEMswqRQ==
X-Received: by 2002:a2e:5857:: with SMTP id x23mr467020ljd.360.1598962355547;
        Tue, 01 Sep 2020 05:12:35 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-79.NA.cust.bahnhof.se. [98.128.180.79])
        by smtp.gmail.com with ESMTPSA id u6sm241193ljg.105.2020.09.01.05.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 05:12:34 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] cpuidle: psci: Always create the PM domains
Date:   Tue,  1 Sep 2020 14:12:24 +0200
Message-Id: <20200901121226.217568-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This coverletter is mainly to help keeping track of the patches part in the
series. Please have a look at each patch for more details.

Kind regards
Ulf Hansson

Ulf Hansson (2):
  firmware: psci: Extend psci_set_osi_mode() to allow reset to PC mode
  cpuidle: psci: Allow PM domain to be initialized even if no OSI mode

 drivers/cpuidle/cpuidle-psci-domain.c | 57 ++++++++++++++-------------
 drivers/firmware/psci/psci.c          | 12 +++---
 include/linux/psci.h                  |  2 +-
 3 files changed, 37 insertions(+), 34 deletions(-)

-- 
2.25.1

