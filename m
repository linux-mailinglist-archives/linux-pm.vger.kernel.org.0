Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1D41DC852
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 10:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgEUIQV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 04:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgEUIQS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2020 04:16:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62911C05BD43
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2020 01:16:17 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l18so5764996wrn.6
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2020 01:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KPDqb+DCYxxpSLeq6U5D/jKybkhAzjGZ8QLA5YedgMg=;
        b=fGuo2D4qqxs0LddmHxyYtVQK3DJjuNDPbTrhoeOfUGD4FH/OI2BX/z8FrTVVetWfeL
         yxSdMCpaMuE0CT59NPSdKGWvlF/wEwwbQIo/ENQXqs6MPPqzlC/hfUJ3ybypKqgN2S5M
         o/mvlR8mPiBPU+NJuQj2pwYDEzhalaTyOIGNdYlQJhhErXNjxuG9Jr41mL5qO2wLTlAk
         8jKD8MUO2AnEnULwDQ+r5sELmzj3LIdAlcvGtV/Ye4p5M8rstCcL499Gc/SDCczcfnCn
         U27GrGfii48SZIS+mbiHKcAl19InSZu9c9q8PSO1K6Rmk6MnZfOSiC2DrSOTeJm/M082
         QFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KPDqb+DCYxxpSLeq6U5D/jKybkhAzjGZ8QLA5YedgMg=;
        b=PJgu2ysLnL+x74ImgyH4pYnSlldh8Gzfdj/slbNit/nH9YYkm/RwseSbtufx7oJAgx
         brEisy6LL4Z9+71PCGt3ePLrRvZZSfPeX+pVjFcEA4qGoR34znO1yyjQvXAYO9JkNt1G
         +IhEaJervWznIBFrru2wXFd7on+ZpX1VJ596wMWIOFfR2FWF9jZZKUI3xJvxdznkkrZS
         PTZddDfuCZsWcNEODKGink9YVK6SVBZY8leB8iMqlxvE7NfY9OzkLtyJpGe+7hmcYR2f
         1KqkTFsOArV7B7JgAzhQaF6gnpGrXR8dBfzVcyEP6uKTHq9QpqW0T7fflhYAZFLlpLc1
         1T2g==
X-Gm-Message-State: AOAM5316fK2pJ7V3wTOhzkTzSmmKTPiKKmxFXCTFM72kWsEW7clESuhJ
        k8IVfj60jUS3DGjR4rsidTGcXQ==
X-Google-Smtp-Source: ABdhPJxUykPWBMpDxCLK97UyXMlHnRBvfRJh1k/pbvLfDpfppBXa1QMSqiirA7kcWucM6FnWvj4LJA==
X-Received: by 2002:adf:dcc8:: with SMTP id x8mr7439168wrm.404.1590048975850;
        Thu, 21 May 2020 01:16:15 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id j190sm5848242wmb.33.2020.05.21.01.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 01:16:15 -0700 (PDT)
Date:   Thu, 21 May 2020 09:16:12 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        drinkcat@chromium.org, Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Frank Wunderlich <frank-w@public-files.de>,
        Josef Friedl <josef.friedl@speed.at>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ran Bi <ran.bi@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: [GIT PULL] Immutable branch between MFD, Power and RTC due for the
 v5.8 merge window
Message-ID: <20200521081612.GO271301@dell>
References: <1587438012-24832-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1587438012-24832-1-git-send-email-hsin-hsiung.wang@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enjoy!

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-power-rtc-v5.8

for you to fetch changes up to 29ee40091e27615530c0ba7773a2879d8266381e:

  rtc: mt6397: Add support for the MediaTek MT6358 RTC (2020-05-21 08:55:48 +0100)

----------------------------------------------------------------
Immutable branch between MFD, Power and RTC due for the v5.8 merge window

----------------------------------------------------------------
Hsin-Hsiung Wang (4):
      mfd: mt6397: Modify suspend/resume behavior
      mfd: mt6397: Trim probe function to support different chips more cleanly
      dt-bindings: mfd: Add compatible for the MediaTek MT6358 PMIC
      mfd: Add support for the MediaTek MT6358 PMIC

Ran Bi (1):
      rtc: mt6397: Add support for the MediaTek MT6358 RTC

 Documentation/devicetree/bindings/mfd/mt6397.txt |  14 +-
 drivers/mfd/Makefile                             |   2 +-
 drivers/mfd/mt6358-irq.c                         | 235 +++++++++++++++++++
 drivers/mfd/mt6397-core.c                        | 101 ++++----
 drivers/mfd/mt6397-irq.c                         |  35 ++-
 drivers/power/reset/mt6323-poweroff.c            |   2 +-
 drivers/rtc/rtc-mt6397.c                         |  18 +-
 include/linux/mfd/mt6358/core.h                  | 158 +++++++++++++
 include/linux/mfd/mt6358/registers.h             | 282 +++++++++++++++++++++++
 include/linux/mfd/mt6397/core.h                  |   5 +
 include/linux/mfd/mt6397/rtc.h                   |   9 +-
 11 files changed, 799 insertions(+), 62 deletions(-)
 create mode 100644 drivers/mfd/mt6358-irq.c
 create mode 100644 include/linux/mfd/mt6358/core.h
 create mode 100644 include/linux/mfd/mt6358/registers.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
