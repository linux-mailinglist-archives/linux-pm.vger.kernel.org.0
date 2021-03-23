Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7687345A31
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 09:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCWI54 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 04:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhCWI5v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 04:57:51 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504EFC061574
        for <linux-pm@vger.kernel.org>; Tue, 23 Mar 2021 01:57:51 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w3so25774326ejc.4
        for <linux-pm@vger.kernel.org>; Tue, 23 Mar 2021 01:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8rXlIPqOV8iGGjO9YOh8D4hUbu29vilYO3G17kh48+U=;
        b=BJhHpCIbJoKTOiYPS0Be87+vcsNMw75fzAoI70nBSxscSLZEyi/VJWzsfA8s1YXvwS
         mtzkU797W6opyoI8eRW8nmJb7uQSy6WHshVPdH6nxSQPqtZv3tZ3vJCpXA4l0KHD8V6P
         9fui+DS4q78RFGtVzGQL6kGrf3rz0m4E5QEZwe9NV6WYqIjUzTwNcpsVskmgl3xrdiai
         sLKW0hwT5arVpG6P19KC/3Fq6PaTd8pK/qGVpGT/DsAljbN+fGf5zo6CfWzVpxWZ8Lho
         UBlLBqzdSqImGr7SAc/QSnlcp26xFt8I9j92Loi9Z6NKbr3s2r2t2ReR3mF81dp7ajlj
         ZUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8rXlIPqOV8iGGjO9YOh8D4hUbu29vilYO3G17kh48+U=;
        b=CVo9UuxPPSLU0F2W6HlboYfLoLiFFEq5mFdWlhslfM335NICEHRsduhKNJa1cjkaZH
         1ZOqveAze0W0Z2amFsPDaskHpxwOpHtYsQ0ClwDh25xZU0oLd3js2OuFi4xW6uRs7rm4
         YLwu+VdnxAFpPIY0qU9UKZfkFVFaHcI3aGLvKcwQ1kvdMNTvwouaWSnJO5yQ3fqIagzt
         zU+4OrjS/3QVY8pcKWwNEXtdUpivtQ8pVHj8tAAs/RMIVALm0KFXwEo2rZZHvB4INItv
         Wykrk0qh8y2BnbglleUuRm1rfLdMxvGjCK5FMZPvix8vPUgR0zILqXgsr2UYyTjPSBx8
         ogeA==
X-Gm-Message-State: AOAM531iy5H2SN5rttIY/w9i5QKtRrn4GFxgmyWyMFCECmsM1KItFYMh
        HVvjSbhZe00DAQcARKkdJSTC/w==
X-Google-Smtp-Source: ABdhPJzBdJLj5bnx3tAMeaXP3B4Cs74sq7EyKebE4Xj6mJIbg9e+lE9D73YGH0OvDAY676MATpcTvg==
X-Received: by 2002:a17:906:cf90:: with SMTP id um16mr3919292ejb.389.1616489870087;
        Tue, 23 Mar 2021 01:57:50 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id kj3sm10959398ejc.117.2021.03.23.01.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 01:57:49 -0700 (PDT)
Date:   Tue, 23 Mar 2021 08:57:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD and Power due for the v5.13
 merge window
Message-ID: <20210323085748.GH2916463@dell>
References: <20210312083604.3708890-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210312083604.3708890-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enjoy!

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-power-v5.13

for you to fetch changes up to ee0975c3089e1c3357ccc3ada7a94a95b61e708c:

  mfd/power: ab8500: Push data to power supply code (2021-03-22 14:56:02 +0000)

----------------------------------------------------------------
Immutable branch between MFD and Power due for the v5.13 merge window

----------------------------------------------------------------
Linus Walleij (4):
      power: ab8500: Require device tree
      mfd/power: ab8500: Push data to power supply code
      mfd/power: ab8500: Push algorithm to power supply code
      mfd/power: ab8500: Push data to power supply code

 drivers/mfd/ab8500-core.c                          |  17 +-
 drivers/power/supply/Kconfig                       |   2 +-
 .../abx500 => drivers/power/supply}/ab8500-bm.h    | 297 +++++++++++++++++++--
 .../power/supply/ab8500-chargalg.h                 |   6 +-
 drivers/power/supply/ab8500_bmdata.c               |   3 +-
 drivers/power/supply/ab8500_btemp.c                |  45 +---
 drivers/power/supply/ab8500_charger.c              |  27 +-
 drivers/power/supply/ab8500_fg.c                   |  20 +-
 drivers/power/supply/abx500_chargalg.c             |  22 +-
 drivers/power/supply/pm2301_charger.c              |   4 +-
 include/linux/mfd/abx500.h                         | 276 -------------------
 11 files changed, 326 insertions(+), 393 deletions(-)
 rename {include/linux/mfd/abx500 => drivers/power/supply}/ab8500-bm.h (58%)
 rename include/linux/mfd/abx500/ux500_chargalg.h => drivers/power/supply/ab8500-chargalg.h (93%)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
