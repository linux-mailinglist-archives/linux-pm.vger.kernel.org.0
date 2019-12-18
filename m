Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26AA7123E5D
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 05:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfLREV2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Dec 2019 23:21:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37524 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLREV2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2019 23:21:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id c23so379170plz.4;
        Tue, 17 Dec 2019 20:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vc6z5DPJPT9ALawH8QND33wnUvYXhhLWLJZgfzSJFrg=;
        b=SvfIVgN9NeClfQeCI10AFnpQYUl3FnazSMMz1/rl4JjHEw1fMvsx7Et0DMnAzpNOsy
         ujn71aA22qgCZ1mfshtnAz0bjoMYajnVM+QJ3g4NiU4um38MsIIwHbTywSPbzQbbgdpw
         LS83zmnW4qqEsyBHhq+aVSPtqHMdWcne1APVgn+bIE4YOIK/GGyIHjbcVkp5M4kY7xRU
         mfklRjIH6HBmQ7FAXh956dRpj888AbABKesyOYYo0+7LQawFW+DP5frm3t90+LOCk63f
         1w+cwWJxqTmdcFDFgq1GTeXQABJuWVnGlPbWC8s+3gk0GH1ieX/t+xCfM00RNfXiWGKZ
         ZrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vc6z5DPJPT9ALawH8QND33wnUvYXhhLWLJZgfzSJFrg=;
        b=UiJLuinol98FxRsrO3vcynuqMgScg732E4hojuVueB5KWrkpt5LdhRwqcIA3BaS2na
         CYSNWpeTwY47O9+Fje3FjY/RpNsa1LRwjwzO7lBHjpEbfrzQ9Z1rxjLwP2suqIflzm+x
         6JhTVwX9JAUQVfgZINveDl5GtyIRTsj/OF8d7kHl3SeM/Pl4y3Kv2Yi279phGTNYmjqR
         fialPYMuHj1ZcEAKODZqjvBK3JTKe2RIkZ4fao3XwGVCnuRu2RAmMMJ6DoEqguqEgpzj
         9TPvArhyhQw6DU8ichBVHDB0IYpJv+ZP48T8QvTKaIUZ3IkrJlCVlhRlVlJ+ORd6+1lB
         tq7g==
X-Gm-Message-State: APjAAAXsZZFwUOkgHXEbHpTpuYHWoFvX7Y8ETADY7nIdSwnIL+gCfxh9
        2NsvMcjInP59niW04z3USRc=
X-Google-Smtp-Source: APXvYqwTR3pgu+o0enOy3at0duZYlX8shhM1VsQw1/kknsBLvwDGktqgYi8h9dEeJbUeLAYMVJCFFQ==
X-Received: by 2002:a17:90a:8001:: with SMTP id b1mr286774pjn.39.1576642887310;
        Tue, 17 Dec 2019 20:21:27 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id g17sm775380pfb.180.2019.12.17.20.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 20:21:26 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megous@megous.com>,
        linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v7 0/7] add thermal sensor driver for A64, A83T, H3, H5, H6, R40
Date:   Tue, 17 Dec 2019 20:21:14 -0800
Message-Id: <20191218042121.1471954-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset adds driver for thermal sensor in A64, A83T, H3, H5,
H6 and R40 SoCs.

v7:
	- [vasily] Address Maxime's comments for dt-schema
	- [vasily] Move common part of H3 and H5 dts into sunxi-h3-h5.dtsi
	- [vasily] Add Maxime's a-b to the driver patch 

v6:
	- [ondrej, vasily] Squash all driver related changes into a
			   single patch
	- [ondrej] Rename calib -> calibration
	- [ondrej] Fix thermal zone registration check
	- [ondrej] Lower rate of sensor data interrupts to 4/sec/sensor
	- [ondrej] Rework scale/offset values, H6 calibration
	- [ondrej] Explicitly set mod clock to 24 MHz
	- [ondrej] Set undocumented bits in CTRL0 for H6
	- [ondrej] Add support for A83T
	- [ondrej] Add dts changes for A83T, H3, H5, H6
	- [vasily] Add dts changes for A64
	- [vasily] Address Maxime's comments for YAML scheme
	- [vasily] Make .calc_temp callback mandatory
	- [vasily] Set .max_register in regmap config, so regs can be
		   inspected using debugfs


Ondrej Jirman (4):
  ARM: dts: sun8i-a83t: Add thermal sensor and thermal zones
  ARM: dts: sun8i-h3: Add thermal sensor and thermal zones
  arm64: dts: allwinner: h5: Add thermal sensor and thermal zones
  arm64: dts: allwinner: h6: Add thermal sensor and thermal zones

Vasily Khoruzhick (1):
  arm64: dts: allwinner: a64: Add thermal sensors and thermal zones

Yangtao Li (2):
  thermal: sun8i: add thermal driver for H6/H5/H3/A64/A83T/R40
  dt-bindings: thermal: add YAML schema for sun8i-thermal driver
    bindings

 .../thermal/allwinner,sun8i-a83t-ths.yaml     | 146 ++++
 MAINTAINERS                                   |   7 +
 arch/arm/boot/dts/sun8i-a83t.dtsi             |  36 +
 arch/arm/boot/dts/sun8i-h3.dtsi               |  20 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |   6 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  42 ++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  |  26 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  33 +
 drivers/thermal/Kconfig                       |  14 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/sun8i_thermal.c               | 639 ++++++++++++++++++
 11 files changed, 970 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
 create mode 100644 drivers/thermal/sun8i_thermal.c

-- 
2.24.1

