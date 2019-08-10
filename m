Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C5E8885F
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 07:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfHJF3D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Aug 2019 01:29:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43756 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHJF3D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Aug 2019 01:29:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so38766794pld.10;
        Fri, 09 Aug 2019 22:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wwnkha2cPalip0BRfrHsmWB3+skZcqk2g4L3dadW7dk=;
        b=H9+DbqeRAbiVFOVv27yxPfHJ4OI4UyI/Oo/c7lNEytzV7UFucZSdGLxmxtx9pPR7ny
         9YpDzxGgR8zy/2BL7xHfkr6066cTNPsSoeOv93JqxYfrpiDnFK/Zj3OIn+GQUykM5jtQ
         XdduqCV93DQF4uWog0v3M5FWj/bU8osBz28QjwUoQo/lnt6RLzIWa0ElT+ZuCfyk5/jF
         0knjq5eWJoix988ngCDNNOlJmbwYY/ndIl7KPvHCB9kVdTcfQKlr7JvrI960ivEY3nqB
         xogVwXvTx7sN2tVE+wZnPsJn5GvNDTfESVV2m0PV5rLhH4oVIows53TAst0y3hq74fgv
         kvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wwnkha2cPalip0BRfrHsmWB3+skZcqk2g4L3dadW7dk=;
        b=eFSpYiewhVSA+ezWc6lPeaKNaMHeyOQAFLqrIHxzdWLhhmA7JnhulzBP4w4EqVW6Ma
         0YbSlauV02138uJ4D6IVZI34ZaPNxfY6hPE7wxIZd61nDwq9VLcR59Eq4aGo05sd/hOE
         q7xSkYcgE2WfMxSOan60tOy9uD5dWgsDwqvK41NRdntMGjAkcLgif5jLdUypxf+eCT8b
         jyHGJgcvPr27bwLexZJiyyokhSFd6+V1kiVlKh8yL8QRmtf7CVy5EpP+PPy8kkhpVI8Z
         pZQkh1S8BTXaBCJqNrpz1tRlLK+uLrEkcz1VNqVzIbHs7/7XrfvNx1dSqvpyvudkMiaz
         CY0g==
X-Gm-Message-State: APjAAAW8OZvapbUzQH1QOIMWPvtWF4UUj/nNPvShfKVAVnKZWlML7R6u
        T6luLPh5kIxOEtW7iTXEfUs=
X-Google-Smtp-Source: APXvYqzMo7nOByZJMmjM7GKUOTMF/RVyxY8jSVwew10yohKpvdkmRmd12vIA5OSvtsjRXEUGHIttwQ==
X-Received: by 2002:a17:902:1125:: with SMTP id d34mr22696273pla.40.1565414942290;
        Fri, 09 Aug 2019 22:29:02 -0700 (PDT)
Received: from localhost ([202.182.106.211])
        by smtp.gmail.com with ESMTPSA id a12sm25517729pgv.48.2019.08.09.22.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 22:29:01 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v5 00/18] add thermal driver for h6
Date:   Sat, 10 Aug 2019 05:28:11 +0000
Message-Id: <20190810052829.6032-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset add support for A64, H3, H5, H6 and R40 thermal sensor.

Thx to Icenowy and Vasily.

BTY, do a cleanup in thermal makfile.

Icenowy Zheng (3):
  thermal: sun8i: allow to use custom temperature calculation function
  thermal: sun8i: add support for Allwinner H5 thermal sensor
  thermal: sun8i: add support for Allwinner R40 thermal sensor

Vasily Khoruzhick (1):
  thermal: sun8i: add thermal driver for A64

Yangtao Li (14):
  thermal: sun8i: add thermal driver for h6
  dt-bindings: thermal: add binding document for h6 thermal controller
  thermal: fix indentation in makefile
  thermal: sun8i: get ths sensor number from device compatible
  thermal: sun8i: rework for sun8i_ths_get_temp()
  thermal: sun8i: get ths init func from device compatible
  thermal: sun8i: rework for ths irq handler func
  thermal: sun8i: support mod clocks
  thermal: sun8i: rework for ths calibrate func
  dt-bindings: thermal: add binding document for h3 thermal controller
  thermal: sun8i: add thermal driver for h3
  dt-bindings: thermal: add binding document for a64 thermal controller
  dt-bindings: thermal: add binding document for h5 thermal controller
  dt-bindings: thermal: add binding document for r40 thermal controller

 .../bindings/thermal/sun8i-thermal.yaml       | 157 +++++
 MAINTAINERS                                   |   7 +
 drivers/thermal/Kconfig                       |  14 +
 drivers/thermal/Makefile                      |   9 +-
 drivers/thermal/sun8i_thermal.c               | 596 ++++++++++++++++++
 5 files changed, 779 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
 create mode 100644 drivers/thermal/sun8i_thermal.c

---
v5:
-add more support
-some trival fix
---
2.17.1

