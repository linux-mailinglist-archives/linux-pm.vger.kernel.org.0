Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF6F39D1E2
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 00:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhFFWcC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Jun 2021 18:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhFFWcB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Jun 2021 18:32:01 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7078EC061767;
        Sun,  6 Jun 2021 15:30:03 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 131so19468255ljj.3;
        Sun, 06 Jun 2021 15:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tDrYU7w/5M/Foxc71oEtmOp5oUGC4maoR2CPQp+qTkU=;
        b=e9Yl8stNoSl5shMZX9pzemPlVkIEdByFceV/u+2PhXtDSgNP6M3lA9TrHS9jH+S4js
         uZoI2U33xszu4L4ltoJoHCaXgzzKdk8iWQXwZNvZfmCeFty+35uasCe8lj+/stnWLVWj
         2H3ncDtKHeA0E6Jn3AIXelb3h+hikPJst3qwC+o+uRX9nWoJvzuDzVJ2iL8W20YIYDjx
         6a/PulmhEDVxUsYGJGJIXsGrE1WvOeZwJB3ILH/QLyoQdpXwAn4nqQbtR68NT+Yu/Lnk
         wFEzCr7UNS8fns6EQrDSFDgSrAjop9/1zHnawvz5rvgyo2voYu4ML95ntVQy4cP4V/PW
         v+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tDrYU7w/5M/Foxc71oEtmOp5oUGC4maoR2CPQp+qTkU=;
        b=Yt2ThztU/8/BiOKSlkoReRjiM/HoJzMWeRR+5HzI8PxOeycqytPQCG8bZz66Fs6Uw/
         pwfqRiraePwgqo1bj4/7k7g/2rN3C+h3EHPqPgAh4OcLFL82GctlB5vl4mI2SSGQTlgx
         rUIZ2Y6bW6yx70v8PLrmK2IZd/n24Rgciz9zb7TUDDSQtKK+zVuxg0FmhqVlTx0Xa/Va
         LbVtTo+zmfHGiyOtkjbGV8MiNf2Y52TEQYFrBAjWvhThS8zUS+kFLfYlBAA3j4mWYIzZ
         n8oCqTPqwXgumGRky16TQHxaJeobgAnVlsXZ2++VHy8E2uCo3ccfmttCC9fQVyM8HsBG
         Ptwg==
X-Gm-Message-State: AOAM533VuRB8YqXTum+SPJ79WmmQauRfvNHna50gKEtTJ/+IHs562Prn
        +VN9bACyC4xpwAtyeSqALwA=
X-Google-Smtp-Source: ABdhPJyo5xfPOyjYU5DFBRMnDWLX4sffYab0LeAsjjQwmCej4akRweKR5Z+bSCyrpxp2ni5Z9RyhEA==
X-Received: by 2002:a2e:509:: with SMTP id 9mr12846090ljf.6.1623018601874;
        Sun, 06 Jun 2021 15:30:01 -0700 (PDT)
Received: from localhost.localdomain (94-29-51-134.dynamic.spd-mgts.ru. [94.29.51.134])
        by smtp.gmail.com with ESMTPSA id i23sm1017778ljg.38.2021.06.06.15.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 15:30:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 0/5] Compile-test NVIDIA Tegra CPUIDLE driver
Date:   Mon,  7 Jun 2021 01:28:12 +0300
Message-Id: <20210606222817.12388-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add couple missing stubs needed for compile-testing of tegra-cpuidle
driver and enable the compile-testing.

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
2.30.2

