Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA05191D0B
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 23:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgCXWpl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 18:45:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39394 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbgCXWpl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 18:45:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id i20so450632ljn.6;
        Tue, 24 Mar 2020 15:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1HxGR4IMpW8Yf3poFYJ0yW6+xXLZYxn2YNkddFlKXd8=;
        b=ewxanhcY0YBuUPV3qNKUCNj/4v2hzLIcwwi86EkrozrqhCpg5IJYoahWTJnGZAIXF6
         ttTSKp7gjG75aZqgGbe5LBfwrrd8fzZrwkBULjH1/ZPPRxSWTYGXhqPzeYxv2Nqvo0EX
         kRmgThP9MKUL2TcM8wO+fUQcEcpUTszXjGTgz8tBhHy0ceTxlXCafpYAqJpGpb9w4VgM
         3kB6J9mcwCRWPkCaS9abJ6jaARgTyMTpPa64bltRlAYwgd+2TPnSErWsPw9VlkWwRe7U
         j/8U/sPfbueWtv9dM6hqkTFmgCQWt+5hh90bexsrCx0iE5TfmMRogdFM6nnhdLhCrgTF
         bkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1HxGR4IMpW8Yf3poFYJ0yW6+xXLZYxn2YNkddFlKXd8=;
        b=oO/8s7aGB52Eg1VPrsK1srGv9nDM7VdGsS8RHkRRGNPBgED4HWOMzJrJYXuJqGxoKt
         /j9tu2ca8iPp5xSi1g7a+VTHZeUrsz+Z+NeLUOF4uslRnTOrGEztz33TKuPM5OjzMg53
         II9p4/0AzG1pEL8KCuwN7KoO08Ca+kZmFBreIPsfJogu809jtCJXrMYq5yPoDEPFin6g
         qxfmldaBmcJNn/gBocCL4EVYV+QAi4RlZS0B10c7Bdc26/T1XbWOw/IfuoOumrjU2bs/
         SiNKRJFUd5kbwRIphTcS+OLK1DWVC1AhL+k9yGv+8YS7odTtxRh18Iek2K8S0rsQfxWs
         sc1Q==
X-Gm-Message-State: ANhLgQ2gZPZ+Dkp9vOKfsFfmQb46REy+jhttJ9Qa6SLbdbYSWjyOJGvy
        58VGPYuOcvS6eKb/LcuCBMbWaLbs
X-Google-Smtp-Source: APiQypKK9aJ/vteGvqg2enrRQJOAVimwi3mKjNazUA694NM7Fj2SOo9y8bnfprMAWPe4Y0SRWaljDQ==
X-Received: by 2002:a05:651c:1061:: with SMTP id y1mr4506ljm.285.1585089938878;
        Tue, 24 Mar 2020 15:45:38 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id d4sm10534279lfa.75.2020.03.24.15.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 15:45:38 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] Enable LP2 CPUIDLE state on NVIDIA Tegra30
Date:   Wed, 25 Mar 2020 01:43:32 +0300
Message-Id: <20200324224335.5825-1-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This series enables LP2 CPU idling state on Tegra30. Previously,
Michał Mirosław reported that this wasn't working on ASUS Transformer
device and we found that replicating the Transformer's downstream kernel
behavior (in regards to the firmware) helps. Later on Michał told that
LP2 works without the firmware changes using a different kernel version /
config, we don't know for sure what was the cause of the original problem.

This series makes the TF firmware changes that are known to work well
in regards to LP2 idling on all devices and then the LP2 idling state
is enabled.

Please review and apply, thanks in advance.

Dmitry Osipenko (3):
  ARM: tegra: Initialize r0 register for firmware wake-up
  firmware: trusted_foundations: Different way of L2 cache enabling
    after LP2 suspend
  cpuidle: tegra: Support CPU cluster power-down state on Tegra30

 arch/arm/mach-tegra/pm.c                     |  4 ++++
 arch/arm/mach-tegra/reset-handler.S          |  7 ++++++-
 drivers/cpuidle/cpuidle-tegra.c              |  1 -
 drivers/firmware/trusted_foundations.c       | 21 ++++++++++++++++++--
 include/linux/firmware/trusted_foundations.h |  1 +
 5 files changed, 30 insertions(+), 4 deletions(-)

-- 
2.25.1

