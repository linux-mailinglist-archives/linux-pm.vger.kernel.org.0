Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 626F35E99F
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 18:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfGCQuD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 12:50:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:44177 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbfGCQtn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jul 2019 12:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562172510;
        bh=Me1SvsLDyMMGaUAM+H2U6QR3rP8Y3XVwEjAtU6m8VUA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=MV6Va6oTlm89ruMxAxb87nEE2pPoh3n4vLdyHMS/pwe0XAqsgXSoh6piSJ85L+fZ+
         sgvmA53g2n+XMMAAp0AJk0bPzDzrj4b4WNENRhxpuD3EyGTX/635+Twttk5ALFoVPE
         XNxzEw/MJF8MVJWtuWJW4wXKFLb44ksoCMESeWpA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([217.61.158.204]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mv2xO-1iZJ3G21eS-00r1tZ; Wed, 03 Jul 2019 18:48:30 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Eddie Huang <eddie.huang@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH v2 0/7] implement poweroff for mt6323/6397
Date:   Wed,  3 Jul 2019 18:48:15 +0200
Message-Id: <20190703164822.17924-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:Q7bwDdrEsaphQYrmHhp90HE//kekmdWGTaievfmTLBQ650JdlG0
 ZFc89t3IpqF6r+6VIT+crsEBq/Xze1pedGbOYkWYQfBHJcBZWJae3I7ecQ1H/v2yoJF8OpX
 Pf8SwioVIe5yR86V2HhD2iyrRPnU9EZxKaK/fDp6sj/cNdKzfwD7IhaXPNReS4u11f3x2QB
 D7KWSsmavk+XqjXkrbOpA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:80cN8sB+jW0=:MrqNVi7o1rXFaCcRKYMpMr
 w42OIhPPamz4BFUxxD4WMAHwfFtF5Af/vkftOIq7mwDnmmLVjvzpDCY9WCe+26/fmhm9ILqrW
 FlaWUzNwCyTbmexafmmy0f91BemYMTQny1Fh37Gy7/GX3Xw+J5/nUfZOCJ2exG/XYIluMDmy1
 0q4mBFg7UmyUtQO+ytaMzkxVjE2oF/JKKZ5drh/6iOFGqbGHl6EbrcaI0NGLIiQXE3xynUQaY
 WW1Yre6qDx+HjMJ9Lk5dJMbEI57lMR5YuwgjOebQDEBq6Xe1uYXOrzQR1wkevI09OhmGYYLlT
 AimTIiXaIOSqccv46iS0RLais/yHBL82Mz0q6lDrlsJNUJsxltDWWK8DBL2OcuT4ruWkeM1ea
 BRuglTOqIvDTmPPygFhbdvUPT6iPFC7afxNXsGefI4bbjeNhYX6nS0F6cwLQ2LIWga4XZkEZd
 z6sIuSnVYTe+hqvFwc+wKCzx53SS1hI7i5L0KpagtNitCMJqykKo0ImhRAKAg080rNWownjRu
 IPF/cHMBG0dPqoq4tjWbz8fm1ABB8geWNY2G5YJw+XustSCnZIeRDuYUn3vntf3hSxyCvx/h6
 MUbKc6EOnU3cwHaV2hAPdxdQaQVe0v5g5AqlyYzLoEe7LdHwl/8Ck/aMLs/1/dJgRKxLbPsgC
 UyZqBeY7unxw19J2xnG0Rh0BmWuPeaNKNP+zSqXTSQtW0xKi6IF4r3mcK8qS4aF+fx1jPOjPU
 FJ/4FPuvumLOfqR2xMCUtQ6ttO9gm7EQrFRiOoerJYoin92K1LI3mvoWpSnTnqjVhQycnPTH1
 MeV3DKDczqlWEV/1LfDYSeSftVblK3KgGgG4cTpn710t5TFBO5gsiAHq88wJmaWek/LpO45iM
 lfH96Cnhp+nsfsx6Zf44h1aGTG813Gh62z+M9mCsiiKkDVkBwA8dthC2A5gYrTY8a+bpgDYYq
 a/PprCwYWXTxAJDQUXN9vx6seI1oJ1RF8Dn4qKzj8/2YFP3OpbfqnIVlrgV52vYoI/gQq8HBW
 EDEaEam7lcXmITZU6/tZX/iLapG/9XXkG0MhyT4QusnNpUDoDd0WocRAYIjyBDgPfyREQFliV
 HSgBUVFAVXoG6U=
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

mainline-driver does not support mt6323

this series adds mt6323 to mt6397-rtc-driver and implement
power-controller on it.

with this poweroff is working on bananapi-r2

Original Patch from Josef Friedl

changes since v1:
	- splitted into functional parts
	- more infos about changes

Josef Friedl (7):
  docs: dt-bindings: add poweroff
  rtc: mt6397: move some common definitions into rtc.h
  rtc: mt6397: improvements of rtc driver
  mfd: mt6323: some improvements of mt6397-core
  power: reset: add driver for mt6323 poweroff
  MAINTAINERS: add Mediatek shutdown drivers
  arm: dts: mt6323: add keys, power-controller, rtc and codec

 .../devicetree/bindings/mfd/mt6397.txt        |  10 +-
 .../bindings/power/reset/mt6323-poweroff.txt  |  20 ++++
 .../devicetree/bindings/rtc/rtc-mt6397.txt    |  29 +++++
 MAINTAINERS                                   |   7 ++
 arch/arm/boot/dts/mt6323.dtsi                 |  27 +++++
 drivers/mfd/mt6397-core.c                     |  40 +++++--
 drivers/power/reset/Kconfig                   |  10 ++
 drivers/power/reset/Makefile                  |   1 +
 drivers/power/reset/mt6323-poweroff.c         |  97 +++++++++++++++
 drivers/rtc/rtc-mt6397.c                      | 110 ++++--------------
 include/linux/mfd/mt6397/core.h               |   2 +
 include/linux/mfd/mt6397/rtc.h                |  71 +++++++++++
 12 files changed, 325 insertions(+), 99 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-p=
oweroff.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
 create mode 100644 drivers/power/reset/mt6323-poweroff.c
 create mode 100644 include/linux/mfd/mt6397/rtc.h

=2D-
2.17.1

