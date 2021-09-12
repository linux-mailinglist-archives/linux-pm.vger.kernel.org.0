Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EBC408173
	for <lists+linux-pm@lfdr.de>; Sun, 12 Sep 2021 22:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbhILUaf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Sep 2021 16:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbhILUad (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Sep 2021 16:30:33 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3F2C06175F;
        Sun, 12 Sep 2021 13:29:18 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t18so11411327wrb.0;
        Sun, 12 Sep 2021 13:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OloBSLKiPPVBBxaWCX+yQgzFVba/9OcJTIhGRQSsgPI=;
        b=Rvm0/DI3FIv9bkQCQOu/xGVU6Gu+WIhotIlEQtWCeY/yT/z633wFL3W5ZSxBHr2pvt
         wlDjIolypnPpgAmvH6yB9BuuXTnnhQLjmilqhWjpkop3hdqm/Ylqwp2loD86/vVjYoJ1
         LRKLhxolnoK6Qi0V1B65a1EFoxJcpqCNswvm6ayqkQlT4bMT4qWe/eTRJ5AomTxFQlKd
         0oKMv92zN3to5WhI0WSI+vLZjJgsKZ2gIUFQVSxKb6AFl59yTgB1T6GcNCpJi8VyE6gv
         r6Wh98s3f8CkIhFlnrJvKm+bm8DsR1ij4w+k/Pbj/W0sLqZiuBV98zBKO5fq1kZ4TM5k
         4plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OloBSLKiPPVBBxaWCX+yQgzFVba/9OcJTIhGRQSsgPI=;
        b=AfGnU6vMrDO1i8oLtuOEAsvAXQvEOa4zH+Kp6TToSUK5uFQ0FoQ/QQ0EJ/+fM+m5kI
         af5C+vqtLUgptnwRjyaVrX+gOh/trwc1PBKflZ8Vrxpm4AeqZTsfTSKv85+WTekoHDOI
         nZ1FasaEBzkjMUeMo3AuLAS5PwDlFcGGKZv4ilBbExarPmM7U88MQbSIYYImm+Aksj3z
         8HUsnWa9xvHva1tLDqRViSSqNNbnEkA0yNGnRoqYTTeO4YACTp2279BGAgEMtHzVRdrR
         ZyKIIhxenic0KUatvAuNcqfnRtORJSXWFDPfJHaa4VqltuOHLYl8ufuiDEgUTKxa9Zho
         xLFw==
X-Gm-Message-State: AOAM531yLSvjOK4R6EjWfsqLc6mCTO0wfzBA7beVlVRryU+RmfjxFEz1
        HE21BRcrFAYrRh9tGwNPYKM=
X-Google-Smtp-Source: ABdhPJwIZ+xg0z95IiZtTTZi6ktU1TYrJL3slT4Y/bxwOFOYNaHJZhdbNL8AkCYOIfwpG7Z3nKbfog==
X-Received: by 2002:adf:f185:: with SMTP id h5mr9036231wro.302.1631478557405;
        Sun, 12 Sep 2021 13:29:17 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id k29sm4847466wms.24.2021.09.12.13.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:29:17 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/6] Tegra cpuidle driver fixes and improvements for 5.16
Date:   Sun, 12 Sep 2021 23:29:01 +0300
Message-Id: <20210912202907.28471-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds compile-testing support to Tegra cpuidle driver and fixes
a non-critical problem that should pop up only when power management patches
[1] will be merged. Previously I sent out these patches separately[2][3],
but they partially missed recent kernel release. I combined the remaining
patches into this series and added ack from Daniel Lezcano that he gave
to the "Check whether PMC is ready" patch [3].

[1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=261973
[2] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=252996
[3] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=254040

Dmitry Osipenko (6):
  soc/tegra: fuse: Add stubs needed for compile testing
  soc/tegra: irq: Add stubs needed for compile testing
  soc/tegra: pm: Make stubs usable for compile testing
  clk: tegra: Add stubs needed for compile testing
  cpuidle: tegra: Enable compile testing
  cpuidle: tegra: Check whether PMC is ready

 drivers/cpuidle/Kconfig.arm     |  2 +-
 drivers/cpuidle/cpuidle-tegra.c |  3 +++
 include/linux/clk/tegra.h       |  4 ++++
 include/soc/tegra/fuse.h        | 31 ++++++++++++++++++++++++++-----
 include/soc/tegra/irq.h         |  9 ++++++++-
 include/soc/tegra/pm.h          |  2 +-
 6 files changed, 43 insertions(+), 8 deletions(-)

-- 
2.32.0

