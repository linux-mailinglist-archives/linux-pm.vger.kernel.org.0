Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4343E5461
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 09:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhHJHh1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 03:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbhHJHh0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Aug 2021 03:37:26 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACF8C0613D3
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 00:37:04 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so4033977pjl.4
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 00:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gp9yqcscf7/Q8S71rNb+DklCmCjBfuOZWtoJrdKgq14=;
        b=IAglVf6Pn8I8I9dsDbHjIfeAkSA/yD6E0MfLksr0I3bbp7rSOQLo46sTKTKHyl9KbR
         1/Ax/Ap4XrXSvqSfj4UKWMsMiK2Qlt+w+AwybJt6Afct7yPg8QghYKttCJvCY/xqXvkm
         SkVBZJ83g65LBxLJZxqL82lCxNFSOhBzmTWP+VjWSx6JwYTMIlwFMEqzKCpRoO2ZHeMy
         iLi9J2g4OA/gouk7AIivwb3wNG0F55BWN3FaLUULACXKVzJzbp8T6EZqU2AN3WsvBWuT
         6xKHRzNBm8HKbeykYID8qlR3XXsS6uZSkgeIJMMAyf3R73Ni3U2SsNf7QyhEebDAbH1k
         0nNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gp9yqcscf7/Q8S71rNb+DklCmCjBfuOZWtoJrdKgq14=;
        b=CfQZrXpCYpvUgFWCT5H5A/72gkFdSC9oK2QxRJbA2jXCjWt0WmhAnWHLDbhxkelbiR
         +qJXVqy3WbuHjjUWC5dL2DR7cpiuGIvm0+z2/YqARxpLSV/61IzP3xfOV9/mmoqtzlxG
         nCTrnCiH5Hj3hyGjmrGqCfYML0mMpVPt+bFGvMr1PO+iznX3tEseVrtGvVBh+23I2YX4
         ZqwCdxmU6juQYZkxZQrJMuuKAbZz3U85Eo/YfIruXkdPKlNUkQnJrTz6ixtf8yEpoKui
         4UQ8owAKlk7D0htRC64tKhy39yB2hNdhxziPahRz35oy11uL1Ayu5SHLX8g4WSoVvqWR
         A5cA==
X-Gm-Message-State: AOAM5310p5FN1qN/Gl8Z22MlTdPKY3ZwPZ+/vdNwQEdwqHMrNZK238Lp
        OOpN7n2HK3GevYMGgHJwlswe2g==
X-Google-Smtp-Source: ABdhPJxILYrr525KX9FnT9P3v0D4xd0mT7Xu47cl+ZsvaVSJ3lXE+EgGIYbCSv1kqvc+zewvjPYhrA==
X-Received: by 2002:a17:902:b601:b029:12b:d9a:894f with SMTP id b1-20020a170902b601b029012b0d9a894fmr350019pls.63.1628581023914;
        Tue, 10 Aug 2021 00:37:03 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id v14sm1734591pjd.35.2021.08.10.00.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 00:37:03 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org
Subject: [PATCH 0/8] cpufreq: Auto-register with energy model
Date:   Tue, 10 Aug 2021 13:06:47 +0530
Message-Id: <cover.1628579170.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Provide a cpufreq driver flag so drivers can ask the cpufreq core to register
with the EM core on their behalf. This allows us to get rid of duplicated code
in the drivers and fix the unregistration part as well, which none of the
drivers have done until now.

This would also make the registration with EM core to happen only after policy
is fully initialized, and the EM core can do other stuff from in there, like
marking frequencies as inefficient (WIP). Though this patchset is useful without
that work being done and should be merged nevertheless.

This doesn't update scmi cpufreq driver for now as it is a special case and need
to be handled differently. Though we can make it work with this if required.

This is build/boot tested by the bot for a couple of boards.

https://gitlab.com/vireshk/pmko/-/pipelines/350674298

--
Viresh

Viresh Kumar (8):
  cpufreq: Auto-register with energy model if asked
  cpufreq: dt: Use auto-registration for energy model
  cpufreq: imx6q: Use auto-registration for energy model
  cpufreq: mediatek: Use auto-registration for energy model
  cpufreq: omap: Use auto-registration for energy model
  cpufreq: qcom-cpufreq-hw: Use auto-registration for energy model
  cpufreq: scpi: Use auto-registration for energy model
  cpufreq: vexpress: Use auto-registration for energy model

 drivers/cpufreq/cpufreq-dt.c           | 5 ++---
 drivers/cpufreq/cpufreq.c              | 9 +++++++++
 drivers/cpufreq/imx6q-cpufreq.c        | 4 ++--
 drivers/cpufreq/mediatek-cpufreq.c     | 5 ++---
 drivers/cpufreq/omap-cpufreq.c         | 4 ++--
 drivers/cpufreq/qcom-cpufreq-hw.c      | 5 ++---
 drivers/cpufreq/scpi-cpufreq.c         | 5 ++---
 drivers/cpufreq/vexpress-spc-cpufreq.c | 5 ++---
 include/linux/cpufreq.h                | 6 ++++++
 9 files changed, 29 insertions(+), 19 deletions(-)

-- 
2.31.1.272.g89b43f80a514

