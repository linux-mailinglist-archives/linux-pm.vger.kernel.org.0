Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0547925D
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 19:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbfG2RnL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 13:43:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:50601 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387822AbfG2RnK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 13:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564422129;
        bh=RdzV7ibrX+DwP2/BCdjL01crPjcknaV01tD0aoWIdDg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=R9ZrFy29vedWnJJeYzRWI5kBNGitmtGhHhCP3B9ig27ts59fWQFKCzV97vz/8OzDY
         n6mCgzrWb1jtHN57Y6ItnOZCHxkP8tDgVFPdEL5iLjcvrd5ZsiqKmSnZEHKTLgK4Ir
         DeeCkmABc5HnZPTN1+C1vbQYuY0J+H1KK2m2mVGU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([185.76.97.79]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LzskF-1iV7102Ez5-014xXw; Mon, 29 Jul 2019 19:42:09 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allison Randal <allison@lohutok.net>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tianping . Fang" <tianping.fang@mediatek.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH v3 00/10] implement poweroff for mt6323 / bpi-r2
Date:   Mon, 29 Jul 2019 19:41:44 +0200
Message-Id: <20190729174154.4335-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eaB03qW1RdZHhSSwGKsKQ5ipDCg+qmUpRIGapr9mOzrFy6CA0gx
 pz2or5Jz0m/M9Qv2WF+ghf9EH2MsOqsPCwN08N5B7E1g7UGFfTI3HJ+h15PC4DVZUlZl3ms
 Ho9F5fTbpA8NIggLdlvetC6qOgK+0GU9Baeq4OYqZUrc0peTECs3o5j/2V8HKESuUQIOeLd
 mIQqBZ2JLaJTffUIw8qQw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/HfsKFt0IkQ=:O6NiHfNSSWLslNZ2emBoSG
 3VE4lb75JDVpkh0pU4mnlj4DCCz8wrM46AxzVryqq/4jrwBGdE8zf5nHHd8FCHwVeiwF2dQOe
 c4hw7A3ZPyKQSTp+VjcSoY7ViYIocfgEQe1Rmtv1QKyKHYVB8RypT97Hl4xh9rsCNQKov31ZR
 Kh09x91Fe6+V+QVYs1ldQ6ue/UPuf5x7Z5ttCRO4b/C/HupnIX8TELpRf4SJbs/fHjDUowMvS
 s0WsYVHXi3Mf0kbI6w322RGXHO5ouSwsFPfuHMnYJcN6e9hMqg359/xdavduRXNfbjr9+66ag
 b73SyLlBC+VvqVLr7LdZ1ulevSzFTtViC0lqqqQoKxC/YpxF+y2oAegEGos3xSR0NcOJ14tGO
 Ix4oH90ojljyY5lMBZRPEnDIA1ciHvjd8aF1kN+07WPNpF8RfIabSMfgFx0kxDnPEM79DzWYW
 9CmniUHxAVkrLE73XiwRLpmiVxhICUdHtJtykDGiIFRYX1bsNbGRB3+lRVdcTcg1jjJ61Bkzc
 XanCObGqjjwGQBV0lxtpsPoRdhI87GFqURmW+BQsYwKdOSBDqz1UdvzJYJNg5SnrZZcG0+bzW
 v78/pNEbdvPI+PCoOSlFr48xxDQnIPo6FGGZhEX2kFRjDRTnKfl1fIS4nj7ytLwrkkLGZmR9g
 joq8YSOAPXfUBhlR843i8iLLlgpptHakCm1DKZfV3g2nOb68J0iYHCfZYrinZUhhf3GkgJbBQ
 NNfqYzbluzq7X/DH9sBz1gVSviWE+idaU7vg8uwUO1OCDB4ztzqK9ZtnI9mjbloc2zZ0hn8ux
 pyZOmpSHSHtgN4X6EyF0uIwRBRQySv1FoA7QHuIF8WKf9d0sGJDK2xjc9D5mAXdy0e/DS6sG0
 h5SI0fPzvoHtN/Ug6kttZOyAYptN2u5XGvb2fWfoNGaaTnkoSdychfXritF3eC5CsJJqsH2Ss
 rKpjNiKlLZtK8NX+Cxk2dx41HbodyTigWZESf8vxyhdT2aYguOQYmYGWm+QXmEZv44qehYR9p
 Y7riK9MFJTWkINuhFSe9O3LuLnzWJ0CWLgxNCjNKKBlq0EvaFiKjh3aa53x2vHO31WrK0AAcp
 +5qSgXM+s/WGDPtW51uZ1Hg/NqmNalg2b8A
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

mainline-driver does not support mt6323

this series makes some cleanup to mt6397-rtc-driver, adds mt6323 and
implement power-controller on it.

tested on bananapi-r2

Original Patch from Josef Friedl

changes since v2:
	- Splitted some parts and rebased on 5.3-rc2:

	v2.1 dt-bindings: add powercontroller =E2=80=93 try to make better subjec=
t
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

changes since v1:
	- splitted into functional parts
	- more infos about changes

Josef Friedl (10):
  dt-bindings: add powercontroller
  dt-bindings: add missing mt6397 rtc
  rtc: mt6397: move some common definitions into rtc.h
  rtc: mt6397: improvements of rtc driver
  rtc: mt6397: add compatible for mt6323
  mfd: mt6323: some improvements of mt6397-core
  mfd: mt6323: add mt6323 rtc+pwrc
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
 drivers/power/reset/mt6323-poweroff.c         |  97 ++++++++++++++++
 drivers/rtc/rtc-mt6397.c                      | 107 ++++--------------
 include/linux/mfd/mt6397/core.h               |   2 +
 include/linux/mfd/mt6397/rtc.h                |  71 ++++++++++++
 12 files changed, 323 insertions(+), 98 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-p=
oweroff.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
 create mode 100644 drivers/power/reset/mt6323-poweroff.c
 create mode 100644 include/linux/mfd/mt6397/rtc.h

=2D-
2.17.1

