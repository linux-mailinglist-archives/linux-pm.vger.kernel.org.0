Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1C371267FA
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 18:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfLSR2e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 12:28:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36473 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLSR2e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 12:28:34 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so3482110pgc.3;
        Thu, 19 Dec 2019 09:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FC3/QPaa5PZhaNcHhuFDAdfq0OHIUK1TdSdCzAHajCc=;
        b=dy9R8z7vc/XXAEH3Rhv/7Zz2UzI+4YT7FYRMRYG4QOIcJ85CI0668ysW86zR7kZEwp
         ryjCWDY/mOdSghg39/lNRhMPhF6u8IoZhXyvn5ahot+dLntHgepthUNUhRhty3H1FN1d
         PEsSKcw8HruBh2pyfrfxxPgInCOU0e55yG3nARfoUOeTZGSUdHRBoOgSKkHs+1a5UkKr
         Xs415JZcJ9xGShIbk4spwpHIOR93+/gIGju4C2xG/sQcxD0Ew9Ruudwr0dCJq5b5Kllp
         NhI914BZRknzkfc+PSNBTN9GqkTfw8me85QmidXJQtJBx5stTy4O5krcjCjikPWHkvsg
         WUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FC3/QPaa5PZhaNcHhuFDAdfq0OHIUK1TdSdCzAHajCc=;
        b=MoY/dTFAin7PESF/hwVlMnXQguQzUV9cVtbYu1arpu1g7HFcw7dXJuGEHrIKRhZbao
         Fp5J+2nnsljEt4qdDeAlnKkDKjzW5EmNmCTsFaf58j/cTSnrdDNBe1jqsiBL/acEsmql
         2ccTynJiGmGV8pqyek/yQHtDIhBVo9X+2jPepv/YmH0N/hlFovIogWlHFKcaYM+Q22SI
         UoqEH749PgpUIvoWjquTMT0VjBN2V5kGWoFNwsbSmQwAAqnIPq2skXRGv1+rEkgwQZnG
         RJsKEBy9lJAAfuKpKHAMuJHNnozEw2mE3NDvzQx/E4rxFSjUqRSnxCap9EW64p6k32ct
         MCbQ==
X-Gm-Message-State: APjAAAXJMDyNJHR5JAaULlg+YvdMoDGg7QOK72OT1x5nXAw/v/hJ1SrY
        WL+hIDqOd47VI1IZdBraNKA=
X-Google-Smtp-Source: APXvYqwsCwPHwOMp7hPK2BsRkPhtgmogTJE3yEjGSSPfL3FD3QcZJks5+w9l7rUtELd8fzk8Qz74UQ==
X-Received: by 2002:a62:5547:: with SMTP id j68mr11289653pfb.6.1576776513100;
        Thu, 19 Dec 2019 09:28:33 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id v143sm536209pfc.71.2019.12.19.09.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 09:28:32 -0800 (PST)
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
Subject: [PATCH v8 0/7] add thermal sensor driver for A64, A83T, H3, H5, H6, R40
Date:   Thu, 19 Dec 2019 09:28:16 -0800
Message-Id: <20191219172823.1652600-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset adds driver for thermal sensor in A64, A83T, H3, H5,
H6 and R40 SoCs.

v8:
	- [vasily] Address more Maxime's comments for dt-schema
	- [vasily] Add myself to MAINTAINERS for the driver and schema
	- [vasily] Round calibration data size to word boundary for H6 and A64
	- [vasily] Change offset for A64 since it reports too low temp otherwise.
	           Likely conversion formula in user manual is not correct.

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

 .../thermal/allwinner,sun8i-a83t-ths.yaml     | 160 +++++
 MAINTAINERS                                   |   8 +
 arch/arm/boot/dts/sun8i-a83t.dtsi             |  36 +
 arch/arm/boot/dts/sun8i-h3.dtsi               |  20 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |   6 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  42 ++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  |  26 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  33 +
 drivers/thermal/Kconfig                       |  14 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/sun8i_thermal.c               | 639 ++++++++++++++++++
 11 files changed, 985 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
 create mode 100644 drivers/thermal/sun8i_thermal.c

-- 
2.24.1

