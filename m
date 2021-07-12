Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CE83C403F
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 02:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhGLAGc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Jul 2021 20:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGLAGc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Jul 2021 20:06:32 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C394CC0613DD;
        Sun, 11 Jul 2021 17:03:43 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id i125so16231805qke.12;
        Sun, 11 Jul 2021 17:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wZP7JEhi6SGVJY+/ue8nXOLMpeTVusSKIcLQyU16JXg=;
        b=cXOe5r67GJcATNgZtt3AAQo92z++Hnldw7a3MVxubMRUnK0nm0NRQJt3S/8Duzqy66
         yw1VySxqgDaxxae9BOoGL7AhTd0mMoFSo6QYfq03n6sW5n8dkchiz4SgL9V1cnLHs8nD
         AlrwHUefla14s4ZR3HUmkIXuT9DOvi2xLE1yAnq4h2tL3lcE7D6EQo0xAeH1KU9xUX4m
         pdCVyPQmnd1ehf7fUPXhO2yDZEAoZ+MhnUxDF1MDsFeQtAm5e0XeUz39K+H7whP0FmJF
         v7S50CSvNtNV151bdy1LT++4IYDRrdXV4E8yoMQ3eMU46cj1y3J1Mc5gSczu8duXtFHB
         lsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wZP7JEhi6SGVJY+/ue8nXOLMpeTVusSKIcLQyU16JXg=;
        b=O8NAgqc7/eFCTcrsI2nKsr3r0HYUAb2H9xqVLwErX5RHYqssuAtHGfcqq5AyhC8BUS
         khv0FVp97de95U2NQX2j7naobHEZ+njw1NZPyjnfxVGfWmkrk+YBfyP56/1Gg4a1UFM1
         ZJKEsg/sOR/Q9zT1djttSYgxOHBRMII8lqNe3iihYikkHVMvBFQVU0xv8TZLQfjo82NE
         7bjKf2BYvVf3c2JNV0wc3FQZ/JWLC4p/zoXVFCkVSRFN8qe4gKJLhWE7lSTiiDh6dJJU
         Nl47RhnSrJM0jjQwJeBrtGXrOWp1H2HCF4m46kKyh9l5y01IFOvpVB37STc/xWL9wRec
         YAag==
X-Gm-Message-State: AOAM533Tk8NEVQSYoKlejLEPAjwscoqL1JLVkMnE5oSPYPpSrbNozWzS
        16b5Tf3YWqJwDvUsTrnHumQ=
X-Google-Smtp-Source: ABdhPJzRkH06iLaIiKFMkzFGuHIi6nykQXm3IQnIiV6AVKrJT7H7156G1ji8QNyaow/5rbxPiwBF+w==
X-Received: by 2002:a37:8d85:: with SMTP id p127mr49463454qkd.84.1626048223042;
        Sun, 11 Jul 2021 17:03:43 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id h10sm4970290qta.74.2021.07.11.17.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 17:03:42 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 0/5] Compile-test NVIDIA Tegra CPUIDLE driver
Date:   Mon, 12 Jul 2021 03:03:17 +0300
Message-Id: <20210712000322.4224-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series enables compile-testing of the tegra-cpuidle driver.

Changelog:

v2: - Improved ARM_TEGRA_CPUIDLE Kconfig to fix/exclude compile-testing of
      ARM platforms that don't have MMU. This problem was reported by the
      Intel's build bot for v1.

Dmitry Osipenko (5):
  soc/tegra: fuse: Add stubs needed for compile testing
  soc/tegra: irq: Add stubs needed for compile testing
  soc/tegra: pm: Make stubs usable for compile testing
  clk: tegra: Add stubs needed for compile testing
  cpuidle: tegra: Enable compile testing

 drivers/cpuidle/Kconfig.arm |  2 +-
 include/linux/clk/tegra.h   |  4 ++++
 include/soc/tegra/fuse.h    | 31 ++++++++++++++++++++++++++-----
 include/soc/tegra/irq.h     |  9 ++++++++-
 include/soc/tegra/pm.h      |  2 +-
 5 files changed, 40 insertions(+), 8 deletions(-)

-- 
2.32.0

