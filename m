Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E533CCADD
	for <lists+linux-pm@lfdr.de>; Sun, 18 Jul 2021 23:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhGRVbH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Jul 2021 17:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhGRVbG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Jul 2021 17:31:06 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE9DC061762;
        Sun, 18 Jul 2021 14:28:07 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id q16so26414468lfa.5;
        Sun, 18 Jul 2021 14:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=op84BjJ/v5pRydETvQx7v70LAlrmUU4TAQcmf6g0Q7s=;
        b=J1gpAKly38xuEmE/YY2/eIEkbftmQ//E+na4DmRYqvUUAv1tPraZbIfI5NlHBa7rfO
         RSaou3Z+PoTCzcKr3i0Nzm2Ky6VmAzHwH32jmdSC5W0QqlV5Xc6MwwmEF1o29zZFfuxX
         jTl+jDJLcCt5k4E043Um/C4wnuvJWzhc1r/1Bi+nTsxL1HBNOLZ/0zMgTcE+H2jxTYJU
         LZ3S7pKrWbOq4oCcKNCcXf1HG/u76uYRORgDuGw/3xzfc3MzxqnhTPyoJ/hn2rhsEbRl
         JB91uOoS9K6rJXIauYWasyHw7ZTJH7J/ug04fpjB1KPRpLvnPuQzFj3lofjmpfsCZu9w
         jr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=op84BjJ/v5pRydETvQx7v70LAlrmUU4TAQcmf6g0Q7s=;
        b=IpJr4VBmqpTa26KhRm9VQIBZVZq4VgMhhKqjh3Yth2zYiR3bA/WhOSuZ8fdLk8Zcba
         88Jt8FnlP4KMUKC3/HNk7E9ZQBC0qyDEm9keZ5ZLsOEnSdQyrJdkt77Cl8SMjD30WBti
         JKH1jmME+9+/fHcTFlPa34b53aD44jOkRUENDrrJd24QmLx6e6yugdpYNWJ7w7ZKR/JW
         n78RZHxbZLXZQ5m8hQNVh9e+50Y88jTNvYLaTAK4tiCKz+B8PdP7l7KX20V0oWJtEr3e
         4sNnU/iQtFb7Ad9//JdQpgJcGhHLX2dq8kKPucHLCprWhf+a2nkB8LOcvfwruQJYKyPY
         QZRw==
X-Gm-Message-State: AOAM531K0GveaqOS38/gmA8g9zCGHdcu4cQMQkVrkl6DojIZfe1x2MyW
        XVNCwsn84YO6VDFdL9umdtQ=
X-Google-Smtp-Source: ABdhPJzfQSjWa0UnqRARkIzceZmEcBeWE0B3Sfo61ggIx2g/+0uBCVdznsHR2OvG+xkCnFUxh1o6cg==
X-Received: by 2002:ac2:5b1e:: with SMTP id v30mr15506907lfn.226.1626643685603;
        Sun, 18 Jul 2021 14:28:05 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-53.dynamic.spd-mgts.ru. [46.138.17.53])
        by smtp.gmail.com with ESMTPSA id c10sm1229062lfv.10.2021.07.18.14.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 14:28:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Fix Tegra PMC driver racing with cpuidle driver
Date:   Mon, 19 Jul 2021 00:27:04 +0300
Message-Id: <20210718212706.21659-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I stumbled upon a problem where tegra-cpuidle driver is probed before
Power Management controller driver in a specific kernel configuration,
implicitly disabling the deepest CPU idling state. This series fixes
that trouble.

Dmitry Osipenko (2):
  soc/tegra: pmc: Prevent racing with cpuilde driver
  cpuidle: tegra: Check whether PMC is ready

 arch/arm/mach-tegra/pm.c        |  2 +-
 arch/arm/mach-tegra/pm.h        |  6 ------
 arch/arm/mach-tegra/tegra.c     |  2 --
 drivers/cpuidle/cpuidle-tegra.c |  3 +++
 drivers/soc/tegra/pmc.c         | 14 +++++++++++++-
 include/soc/tegra/pm.h          |  6 ++++++
 6 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.32.0

