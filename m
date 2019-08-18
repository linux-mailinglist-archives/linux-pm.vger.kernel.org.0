Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 392639172F
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2019 16:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfHROES (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Aug 2019 10:04:18 -0400
Received: from mxwww.masterlogin.de ([95.129.51.220]:42936 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfHROER (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Aug 2019 10:04:17 -0400
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Aug 2019 10:04:15 EDT
Received: from mxout1.routing.net (unknown [192.168.10.81])
        by new.mxwww.masterlogin.de (Postfix) with ESMTPS id 09B50965DB;
        Sun, 18 Aug 2019 13:56:21 +0000 (UTC)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.253])
        by mxout1.routing.net (Postfix) with ESMTP id 50D3843D5A;
        Sun, 18 Aug 2019 13:56:21 +0000 (UTC)
Received: from localhost.localdomain (fttx-pool-185.53.43.183.bambit.de [185.53.43.183])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 5A90D36043A;
        Sun, 18 Aug 2019 15:56:20 +0200 (CEST)
From:   Frank Wunderlich <frank-w@public-files.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org,
        "linux-arm-kernel @ lists . infradead . org Alessandro Zummo" 
        <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        "Tianping Fang" <tianping.fang@mediatek.com>
Subject: [PATCH v6 00/13] implement poweroff for mt6323 / bpi-r2
Date:   Sun, 18 Aug 2019 15:55:58 +0200
Message-Id: <20190818135611.7776-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

mainline-driver does not support mt6323

this series makes some cleanup to mt6397-rtc-driver, adds mt6323 and
implement power-controller on it.

tested on bananapi-r2

Original Patch from Josef Friedl

changes since v5:
	- splitted part 1 to separate changes and additions not related to pwrc
	- move mfd/mt6397/core.h from v4.8 in separate patch "add mutex include"
	- changed recipients (moved from To to Cc, removed committers)
changes since v4:
	- relative path in part 1+2
	- drop change of copyright-year in part 5
changes since v3:
	- moved SOB in 2/10 and 9/10
	- moved part 5 to 6 to be near driver-change
	- changehistory of patches below ---

changes since v2:
	- Splitted some parts and rebased on 5.3-rc2:

	v2.1 dt-bindings: add powercontroller – try to make better subject
	v2.2 separate rtc-mt6397.txt (suggested by Alexandre Belloni)
	     add missing commit-message (suggested by Matthias Brugger)
	v2.3 fix alloc after IRQ (suggested by Alexandre Belloni)
	     new compatible (splitting suggested by Alexandre Belloni)
	     needed due to different rtc-base/size see #7
	v2.4 simplifications (Define-res-macros)
	     add mt6323 rtc+pwrc
	v2.5 add poweroff-driver (no change)
	v2.6 MAINTAINERS (no change)
	v2.7 DTS-Changes (no change)


Frank Wunderlich (1):
  dt-bindings: mfd: mediatek: mt6397: change to relative paths

Josef Friedl (12):
  dt-bindings: mfd: mediatek: update rtc to include mt6323
  dt-bindings: mfd: mediatek: add mt6323 power-controller
  dt-bindings: rtc: mediatek: add missing mt6397 rtc
  rtc: mt6397: move some common definitions into rtc.h
  mfd: mt6397: add mutex include
  rtc: mt6397: improvements of rtc driver
  mfd: mt6323: some improvements of mt6397-core
  rtc: mt6397: add compatible for mt6323
  mfd: mt6323: add mt6323 rtc+pwrc
  power: reset: add driver for mt6323 poweroff
  MAINTAINERS: add Mediatek shutdown drivers
  arm: dts: mt6323: add keys, power-controller, rtc and codec

 .../devicetree/bindings/mfd/mt6397.txt        |  20 +++-
 .../bindings/power/reset/mt6323-poweroff.txt  |  20 ++++
 .../devicetree/bindings/rtc/rtc-mt6397.txt    |  29 +++++
 MAINTAINERS                                   |   7 ++
 arch/arm/boot/dts/mt6323.dtsi                 |  27 +++++
 drivers/mfd/mt6397-core.c                     |  38 +++++--
 drivers/power/reset/Kconfig                   |  10 ++
 drivers/power/reset/Makefile                  |   1 +
 drivers/power/reset/mt6323-poweroff.c         |  97 ++++++++++++++++
 drivers/rtc/rtc-mt6397.c                      | 107 ++++--------------
 include/linux/mfd/mt6397/core.h               |   2 +
 include/linux/mfd/mt6397/rtc.h                |  71 ++++++++++++
 12 files changed, 327 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
 create mode 100644 drivers/power/reset/mt6323-poweroff.c
 create mode 100644 include/linux/mfd/mt6397/rtc.h

-- 
2.17.1

