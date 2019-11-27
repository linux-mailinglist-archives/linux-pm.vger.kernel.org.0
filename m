Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4697410AA1B
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 06:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfK0FaC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 00:30:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33393 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfK0FaC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 00:30:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id y206so1762821pfb.0;
        Tue, 26 Nov 2019 21:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NVGiAl8Dh/YJ44QiDFm1FDcXCaNLT2bn+snjxKuoTiA=;
        b=dmYX4ABNhxkr2PDMHvkxaLU7lLez5GCZu36zShR+3opCKFN9xeiZHjRdw0yvUmECpd
         9IJ78wFOqlX2x45ribrm3k863gfoujqH4thQ5z/gfGfNgKH+Yc3L0ghF5xgdjEwmsj1a
         dHsU5oWZN5iBk6fOJFjRr3yYzApMJ29a4ikM/5m7Px0UR3APBSCJTfRa/hAC+awCfghQ
         SvrCWbqxtzW7RkHF6yqmv0O50JohkCD9yMeJIdbGaWZmLsxsKxMjQjSOit6kup4wX9lG
         rl+Ui/SnK5/M4l49KpS+dBDqs6GucaBe250umeJegqjkJ3Mn/vaw7pMWsLNNfKS9dvFR
         Y/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NVGiAl8Dh/YJ44QiDFm1FDcXCaNLT2bn+snjxKuoTiA=;
        b=Hynz0tSj/6tobwhogFgVtrf8Hj2zsBKu/JG9gtfLc8zHKpf5fcCFUKQDiD1AQCnFYN
         24ieMhO9MS57T9vXyKustZnLQHQCdajVLk/Gwg+zY3ZTlHwBT9s0pXGNRbdq56CDK0g2
         elZFbfLDltJGibdH8x/2PRyIR2E9vzI1zR+eyFSLODS5TvlOHYja0XIjkDzR2SRgnYG7
         RMq6S6aOH+K5QxK/ohUNQC2rEVDyN/QPr7N2qv/HBvuRtrVvhpFK1s6o94eSojzVrefS
         9ZWFi1Nh/TXcOted/63zyMn3jl2mQUb2lwufuIj9806POAuOQvYj2OihLQLk08cUrXki
         WY7g==
X-Gm-Message-State: APjAAAXoJE9KIt++4gm4iooN86BQSW5hSzwIHtAjcUhjAH1csVy4mwF0
        nh1k9hjAnCRryRnNd3gxRRc=
X-Google-Smtp-Source: APXvYqxxWXVOcqEI6A8tpVbbrr0/wVcFJgHw1+FRuXU1s33USdwQLQ4LqEiCt9x5VHRbZA5i2b76xA==
X-Received: by 2002:a63:f702:: with SMTP id x2mr2611989pgh.300.1574832601637;
        Tue, 26 Nov 2019 21:30:01 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id p38sm4360825pjp.27.2019.11.26.21.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 21:30:00 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
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
Subject: [PATCH v6 0/7] add thermal sensor driver for A64, A83T, H3, H5, H6, R40
Date:   Tue, 26 Nov 2019 21:29:28 -0800
Message-Id: <20191127052935.1719897-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset adds driver for thermal sensor in A64, A83T, H3, H5,
H6 and R40 SoCs.

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
  arm64: dts: allwinner: sun50i-h5: Add thermal sensor and thermal zones
  arm64: dts: allwinner: sun50i-h6: Add thermal sensor and thermal zones

Vasily Khoruzhick (1):
  arm64: dts: allwinner: a64: Add thermal sensors and thermal zones

Yangtao Li (2):
  thermal: sun8i: add thermal driver for H6/H5/H3/A64/R40
  dt-bindings: thermal: add YAML schema for sun8i-thermal driver
    bindings

 .../thermal/allwinner,sun8i-a83t-ths.yaml     | 103 +++
 MAINTAINERS                                   |   7 +
 arch/arm/boot/dts/sun8i-a83t.dtsi             |  36 +
 arch/arm/boot/dts/sun8i-h3.dtsi               |  26 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  42 ++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  |  32 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  33 +
 drivers/thermal/Kconfig                       |  14 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/sun8i_thermal.c               | 643 ++++++++++++++++++
 10 files changed, 937 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
 create mode 100644 drivers/thermal/sun8i_thermal.c

-- 
2.24.0

