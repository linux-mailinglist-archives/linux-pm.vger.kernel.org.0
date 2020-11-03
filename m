Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F3C2A48FF
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 16:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgKCPHo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 10:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbgKCPGi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 10:06:38 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FEFC0613D1
        for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2020 07:06:38 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id p15so19435751ljj.8
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2020 07:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BHDCMDlrohCTOGKYaepJhi6rvYrdThrY2212XNgPaeY=;
        b=fxurON8U1PBvzdJCjnx9ILqK1/xymSmnN35yPhW0CEKttBN9cJlXfQZg4AUkni8lR2
         K2tXwEUMCsKjiKJ35eJ6DfFeCSM/iuwXx3j8AfQdRda6+1MnWFsX+b/fisUa/emw7xmb
         zZTCBdi7MVast91cJTk+LQwP0MI2vr/fYlov1xLWAWOet+eBBR+4rdteP5Z15Qu57YR7
         7Eh0xNz5/8nriJHRBy7clB3j7gTYcYVpP8Di9IfXByXl3zjensM4BsA9iy1k2UQOzaHK
         ncki+98Yw+M9pvaUSJIcRruWPRceSFlLfjO30WUsBShPtF3ePrqDtxqyGGLfqliQdcIu
         3jzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BHDCMDlrohCTOGKYaepJhi6rvYrdThrY2212XNgPaeY=;
        b=oX7I0jxXi2nE33rmKOQf3tNgoIrBi/EKeM+ynXG5wYPgTiaxbBoDo+EGk5wKZ3j/HW
         HFEiNwnWG5oM1uToL6mHesnJvNCmLgsrX5kmckcp9fgsi1ZYg61e6+HHaC7iYlt09Uuc
         4r5e6xxGpJ8Cn/9aQUiLvsCIcAhQiGYE8d7/FGfpDHWncOKq62kedDXWlRF6pKh16BlX
         zLtWO+ojtmYJcuh+M+FgxKdMPTJS9n8BfiDzxRnN+zw9iAZbKYCqKPuPUvjkHU98om8K
         6Bgt9l/QqzAymkPt+j8NACpu3YaYID+SMHJQiScO8eylB1IFzsEygdfiRHhkleKMUBUO
         m34Q==
X-Gm-Message-State: AOAM533dp1eSMAd3eHzd4Zn8xy0al6XQXWX5pa/MRpu+ZQGl/1yT3X0P
        ypDZDi3lrCXKFTcJScFtmgCW4g==
X-Google-Smtp-Source: ABdhPJyAi7WkrEXPhC//lnMhPjRF9atgaYLSoQOGdckgfwbyqw9DkLp0Jcks3aAvvPIMRjC3GSa9zg==
X-Received: by 2002:a2e:8787:: with SMTP id n7mr9228040lji.111.1604415995742;
        Tue, 03 Nov 2020 07:06:35 -0800 (PST)
Received: from localhost.localdomain (h-155-4-131-134.NA.cust.bahnhof.se. [155.4.131.134])
        by smtp.gmail.com with ESMTPSA id a25sm3522169lfo.141.2020.11.03.07.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:06:34 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/3] cpuidle: psci: Enable s2idle when using PSCI OSI
Date:   Tue,  3 Nov 2020 16:06:24 +0100
Message-Id: <20201103150627.233438-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes in v2:
	- See changelog for each patch.

When using PSCI OSI together with the PM domain topology, the domain idle
states becomes selected via calls to pm_runtime_put_sync_suspend(). This works
fine for the regular idle path, but not for system wide suspend-to-idle.

This problem is because runtime PM gets disabled by the PM core, during system
wide suspend. In this small series, these issues are being fixed.

Kind regards
Ulf Hansson

Ulf Hansson (3):
  PM: domains: Rename pm_genpd_syscore_poweroff|poweron()
  PM: domains: Enable dev_pm_genpd_suspend|resume() for suspend-to-idle
  cpuidle: psci: Enable suspend-to-idle for PSCI OSI mode

 drivers/base/power/domain.c           | 51 ++++++++++++++++++---------
 drivers/clocksource/sh_cmt.c          |  8 ++---
 drivers/clocksource/sh_mtu2.c         |  4 +--
 drivers/clocksource/sh_tmu.c          |  8 ++---
 drivers/cpuidle/cpuidle-psci-domain.c |  2 ++
 drivers/cpuidle/cpuidle-psci.c        | 34 +++++++++++++++---
 include/linux/pm_domain.h             |  8 ++---
 7 files changed, 81 insertions(+), 34 deletions(-)

-- 
2.25.1

