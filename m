Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9467DE2BF0
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2019 10:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438082AbfJXITa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 04:19:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36951 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfJXIT1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 04:19:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id e11so16277019wrv.4
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2019 01:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bwpDjxlqC/mR626oiSg3Rt01CrIhV7qqzUguEfa254s=;
        b=rctbzubuNGhdxVH1cHUWtH6wBzi8gxCG7yptBsEwlS4gWYi5kvsNmT5BF4Sx07qp03
         58+QCW2JdBBoM9MZBOrilx3qjwt1pb3RAsdbjhrSXDYYFb4wml6EVX3Bs/aywQ4UNhG8
         g19cVHb9HkAZ9rUULh4jSiUc2yNbtPugmpoip64TkSO4UIAAG18+IJE9hjxcq2qm8KJL
         e2ayVuB/OBKuH/SKnTWW1287Id3pdrM8Kq8mS6QRWQ+9KMQAWQLgo0JsGf2XDVB07rnm
         ovkLyNEZQ+K3iQzF/ep2WCT0oIDVsJbkvCmePPccdB22nf8flh0RBaX0s5BG6ckHuscZ
         9Gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bwpDjxlqC/mR626oiSg3Rt01CrIhV7qqzUguEfa254s=;
        b=TqbWRm6B5H6uAYzUo2Mx+sJQoTlBsiF2niVXIjaJqexSEXDv1WDuOkmdhtu2g0ppar
         ZRcyhapJlHIrxXza1XBNuuGFPISywe6s90e1jnO1Ac4WT5M6xuUwXlQsSm/876YkeKQk
         6/x4/PWI3LTj085rOeG07viS3laUVia31mPA0smVDJ0VbSCuCYLSVaa0n5pRu7xVxm2k
         Fke+ZNsYK6dSv7N1aqTJToowVbgF5Jx0pronax8YaMh8/jqKgiZSZ5ptwTknApHOyyHq
         vEG2jfLGNv21VPK9olSQfEzymxROnofZE+8eee1UWIGIPxYnemhn7aVn9SRDeXnW+mKz
         Xe/w==
X-Gm-Message-State: APjAAAXxtSoT2nrmoRjc1Na32UyMkyoMza2eo2IWXx77ZG0mC+Wk6BYs
        MkNOgbFNPysTmud+JM0Es/lPIw==
X-Google-Smtp-Source: APXvYqzeWDHSLcoAOmOaHrCuIDnceXDiEw2PFxiRUtr8YD5A9NrQvgKoaJB8J6nksskgcWcq450hBA==
X-Received: by 2002:adf:c448:: with SMTP id a8mr2657636wrg.233.1571905165370;
        Thu, 24 Oct 2019 01:19:25 -0700 (PDT)
Received: from dell ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id u1sm35262518wru.90.2019.10.24.01.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 01:19:24 -0700 (PDT)
Date:   Thu, 24 Oct 2019 09:19:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>
Subject: [GIT PULL] Immutable branch between MFD, Power and RTC due for the
 v5.5 merge window
Message-ID: <20191024081923.GJ15843@dell>
References: <20190910070446.639-1-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190910070446.639-1-frank-w@public-files.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enjoy!

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-power-rtc-v5.5

for you to fetch changes up to 9d0863baff497880c1427d3ea7b89b303ace9675:

  MAINTAINERS: add Mediatek shutdown drivers (2019-10-24 09:04:00 +0100)

----------------------------------------------------------------
Immutable branch between MFD, Power and RTC due for the v5.5 merge window

----------------------------------------------------------------
Josef Friedl (6):
      dt-bindings: rtc: mediatek: add missing mt6397 rtc
      rtc: mt6397: move some common definitions into rtc.h
      rtc: mt6397: improvements of rtc driver
      rtc: mt6397: add compatible for mt6323
      power: reset: add driver for mt6323 poweroff
      MAINTAINERS: add Mediatek shutdown drivers

 .../devicetree/bindings/rtc/rtc-mt6397.txt         |  29 ++++++
 MAINTAINERS                                        |   7 ++
 drivers/power/reset/Kconfig                        |  10 ++
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/mt6323-poweroff.c              |  97 +++++++++++++++++++
 drivers/rtc/rtc-mt6397.c                           | 107 ++++-----------------
 include/linux/mfd/mt6397/rtc.h                     |  71 ++++++++++++++
 7 files changed, 236 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
 create mode 100644 drivers/power/reset/mt6323-poweroff.c
 create mode 100644 include/linux/mfd/mt6397/rtc.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
