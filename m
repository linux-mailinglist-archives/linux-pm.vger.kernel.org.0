Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A523AAC4F4
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2019 08:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406497AbfIGG4k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Sep 2019 02:56:40 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:36650 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbfIGG4k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 Sep 2019 02:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567839395;
        s=strato-dkim-0002; d=goldelico.com;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=H2SIQXvx8PjyvicidlZPlLPHdfve4slDgeqzzBpA4xM=;
        b=FaHld9l/u1RCj+CS1wYct8cpNw2yju+I+mIPvPRfvfnFaBNPYOfVj0lI8tX3anBWaO
        hKdrkpuZUxpbLwIFGsY/08ml5YLdO9BYxZM7GjoT0FU8TdDDZ7i1bLkVaPPZJ0S9YTrF
        42O/TuBhU5rcs12zn4bLb1kSh71Khn2de2E5VHBS/Oc3BfPzMn/8abynBTdVwVdufCdo
        xJEHkNiSNPTUoimqeMb6wh1+oIKWi6qF9IAXCKOB3WuWHwALfB9buZPU/Z2QDO0pVQc8
        j0TVcZnYhcKkp3Dmvk9nbkWcXBDEdE07byYFwpI0AFZEMgo6E1KJBHWiucofbMv0Ohb0
        V8/w==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXL8GTntuxg="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v876uGqXD
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 7 Sep 2019 08:56:16 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Roger Quadros <rogerq@ti.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] OMAP3: convert opp-v1 to opp-v2 and read speed binned / 720MHz grade bits
Date:   Sat,  7 Sep 2019 08:56:11 +0200
Message-Id: <cover.1567839375.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes PATCH V1:
* fix typo in omap3-ldp.dts
  (reported by Tony Lindgren <tony@atomide.com>)
* extend commit message to describe the bit patterns needed
  for opp-supported-hw
* add error check to ioremap()
  (suggested by Christ van Willegen <cvwillegen@gmail.com>)
* update Documentation/devicetree/bindings/arm/omap/omap.txt
* change bulk update to use "ti,omap3430" and "ti,omap3630"
* update OPP4 of omap3430 to 1275 mV since it was not a valid
  voltage for the twl4030 driver (reported by Tony Lindgren
  <tony@atomide.com>)

RFC V2 2019-09-04 10:53:43:
* merge separate patch to remove opp-v1 table from n950-n9 into
  the general omap3xxx.dtsi patch
  (suggested by Viresh Kumar <viresh.kumar@linaro.org>)
* add legacy compatibility to ti,omap3430 and ti,omap3630 for
  the ti-cpufreq driver
* make driver and omap3xxx.dtsi patches pass checkpatch
* add bulk patch to explicitly define compatibility to ti,omap3430
  and ti,omap36xx in addition to ti,omap3 of all in-tree boards
  where it was missing

RFC V1 2019-09-02 12:55:55:

This patch set converts the omap3 opp tables to opp-v2 format
and extends the ti-cpufreq to support omap3.

It adds 720 MHz (omap34xx) and 1 GHz (omap36xx) OPPs but
tells the ti-cpufreq driver to disable them if the speed
binned / 720MHz grade eFuse bits indicate that the chip
is not rated for that speed. 

It has been tested (for chip variant detection, not reliability
of the high speed OPPs) on:

* BeagleBoard C2 (omap3530 600MHz)
* BeagleBoard XM B (dm3730 800MHz)
* GTA04A4 (dm3730 800MHz)
* GTA04A5 (dm3730 1GHz)


H. Nikolaus Schaller (4):
  cpufreq: ti-cpufreq: add support for omap34xx and omap36xx
  ARM: dts: replace opp-v1 tables by opp-v2 for omap34xx and omap36xx
  ARM: dts: omap3: bulk convert compatible to be explicitly ti,omap3430
    or ti,omap3630 or ti,am3517
  DTS: bindings: omap: update bindings documentation

 .../devicetree/bindings/arm/omap/omap.txt     | 30 +++---
 arch/arm/boot/dts/am3517_mt_ventoux.dts       |  2 +-
 .../boot/dts/logicpd-som-lv-35xx-devkit.dts   |  2 +-
 .../boot/dts/logicpd-torpedo-35xx-devkit.dts  |  2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts         |  2 +-
 arch/arm/boot/dts/omap3-beagle.dts            |  2 +-
 arch/arm/boot/dts/omap3-cm-t3530.dts          |  2 +-
 arch/arm/boot/dts/omap3-cm-t3730.dts          |  2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd43.dts  |  2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd70.dts  |  2 +-
 arch/arm/boot/dts/omap3-devkit8000.dts        |  2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi            |  2 +-
 arch/arm/boot/dts/omap3-ha-lcd.dts            |  2 +-
 arch/arm/boot/dts/omap3-ha.dts                |  2 +-
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts    |  2 +-
 arch/arm/boot/dts/omap3-igep0020.dts          |  2 +-
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts    |  2 +-
 arch/arm/boot/dts/omap3-igep0030.dts          |  2 +-
 arch/arm/boot/dts/omap3-ldp.dts               |  2 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi       |  2 +-
 arch/arm/boot/dts/omap3-lilly-dbb056.dts      |  2 +-
 arch/arm/boot/dts/omap3-n9.dts                |  2 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi          |  7 --
 arch/arm/boot/dts/omap3-n950.dts              |  2 +-
 .../arm/boot/dts/omap3-overo-storm-alto35.dts |  2 +-
 .../boot/dts/omap3-overo-storm-chestnut43.dts |  2 +-
 .../boot/dts/omap3-overo-storm-gallop43.dts   |  2 +-
 .../arm/boot/dts/omap3-overo-storm-palo35.dts |  2 +-
 .../arm/boot/dts/omap3-overo-storm-palo43.dts |  2 +-
 .../arm/boot/dts/omap3-overo-storm-summit.dts |  2 +-
 arch/arm/boot/dts/omap3-overo-storm-tobi.dts  |  2 +-
 .../boot/dts/omap3-overo-storm-tobiduo.dts    |  2 +-
 arch/arm/boot/dts/omap3-pandora-1ghz.dts      |  2 +-
 arch/arm/boot/dts/omap3-sbc-t3530.dts         |  2 +-
 arch/arm/boot/dts/omap3-sbc-t3730.dts         |  2 +-
 arch/arm/boot/dts/omap3-sniper.dts            |  2 +-
 arch/arm/boot/dts/omap3-thunder.dts           |  2 +-
 arch/arm/boot/dts/omap3-zoom3.dts             |  2 +-
 arch/arm/boot/dts/omap3430-sdp.dts            |  2 +-
 arch/arm/boot/dts/omap34xx.dtsi               | 65 +++++++++++--
 arch/arm/boot/dts/omap36xx.dtsi               | 53 +++++++++--
 drivers/cpufreq/cpufreq-dt-platdev.c          |  2 +-
 drivers/cpufreq/ti-cpufreq.c                  | 91 ++++++++++++++++++-
 43 files changed, 245 insertions(+), 77 deletions(-)

-- 
2.19.1

