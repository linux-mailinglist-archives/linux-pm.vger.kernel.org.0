Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98E1C836C3
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 18:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387892AbfHFQ3C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 12:29:02 -0400
Received: from mout.gmx.net ([212.227.17.21]:58567 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387909AbfHFQ3C (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Aug 2019 12:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565108877;
        bh=xGvBBhBv8mIQUww1OPe1/FCAqKvtmv/lhpMvp7Optzo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=BSfD2+tA0aFUeRWZUCCocQ7jVyr4dAsFDcSNF064B7Iw+MZQxKnTCLGg5sxQ4LloC
         QjZegJ6sNrw5PcK19M7/KIcsV2i2q/Dx1tuiQ5oQKm/JmC2GFkERV5QeLMhit7Nqwm
         /DF5TEImzOdzQt0nQiTjiaFu4BEYB4qOR68brwpc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([217.61.153.94]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MgsVY-1hhvJc3Ibg-00M5Kb; Tue, 06 Aug 2019 18:27:56 +0200
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
Subject: [PATCH v4 00/10] implement poweroff for mt6323 / bpi-r2
Date:   Tue,  6 Aug 2019 18:27:35 +0200
Message-Id: <20190806162745.8414-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fDGgKZ6spNEPfINJWpjM4TL6DAKb4WwwHdcrKqACYngUW5cxd34
 UZ0Ho8Wdo+kM1XFugD0+bBIsncohO47Y/sc/RusG2Zb7ILZYqlMpyXGwEgIhoisr16zD0un
 YDZ+MewnWXpQezMt+h+8894slE/RbtsTaGLPHyMnNHkGqHrjfuww/avOiQJ2WeZ7o/KEC1I
 zQAEPiRtVQ33nCYGGyFEA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gTunm3r6LcY=:+rmQ5RPc3CYtKjH56Fxl5y
 vdyanBHcAMIOsE31w0gi6hFSfzJhhsOufq774CqVZBjjb/ijn4jYzA12RCL+zCl5P/5ysvUpH
 UJ4/PISlMpUSzkVPnaZ4ikA21TgNkQvltXlJUh5AZBvcOYbpWU/U/KIZfDVZV7x2GSCzVB6Ov
 4Z9Ds35L9fOJ4DOB8HpCllPXK9Zwn3PVS0/O5FJULdJTBYvw4zKUMFb/aAQYPzNm6O1tAASLP
 ZK5UW6wFuwisdCGk2aczDlK6PQSsVzvj+3IQsH8xtgpZKP6GGRSgyMDS0EkIJVk3wXOzTab1a
 e6lfBJZgs2royFjjJk7mtoeUMMnXkXu5VaGVDbo9rJHA6PmNSBxpeIuTHxX1+wN94R0gFxrY4
 11tq/wO1MS5Fl0HrWMhzj9T7xsP7V0m/htbEb2Ckkd6y2zAhc5zDFDJvw+jJmxJeeM/LUEKFN
 mIxjwe21KxXFdGLHvL0+Au9kqAns25TfeIZoSOALUeFtmfspB+gkSoyoZwlIIAROWs7ko5r3L
 fGISutTiyK63UI0Mzx2JJoSZQeFl+3IjxhD9BEEv0D68NgcmQ+OorS+OpA5hMeSdDXXK9YgWE
 eeiz1jCZ2L1q1WxxAQX+0ml95KUWAaOuw7a7Cu/By/qTFT/5XPvJinje9KvXs+LBSsWTmbaqn
 Li2QFfIzL1NvY4LGMM91uer4Y5Af57CdBQAwu5uQvwAnwyPsuk0xmD/C9++rMqZawP5v0HUsl
 SMNkbhrdHRNKQKAfP4EQ3UNNB/XVMaLNSehJLXUBwXYkD7jcr+udDBDjXqewNP2qlr4NxLJf1
 ed+GSlbU6HjIJDM41eet0w7Zx5ckQ2Y+5nAyq+yvnsXDBdICORm5jFxS03CTJ7SGkLIxR7EHg
 lQ27xFMC4eyzw/ssfpiYW1FKmWz8aq1/Ndr0Rka2p/ricCEaFb1EU9LAbmB8CoG47DLAq8dja
 +udTuoRvPkWg/62YQtWhTYFx8Ev8lgPQnTVWL1vYKfFsEOnd1T1px4DRZtAogiSbrfJe8XRqf
 DM+kLIMjACgDT5aiRCXGQjwckMtqCRPHkQ3l09EqUetTmAmR4yz3a/5zTWtQsKzr+UWzff34P
 zJXVD4E/SzPHxUcl1t5Xmwhn6ANLJNRYAIFE25H4bt/+U5SxFTXk7lInkfB+/NSM5fP9K38pk
 /6GDw=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

mainline-driver does not support mt6323

this series makes some cleanup to mt6397-rtc-driver, adds mt6323 and
implement power-controller on it.

tested on bananapi-r2

Original Patch from Josef Friedl

changes since v3:
	- moved SOB in 2/10 and 9/10
	- moved part 5 to 6 to be near driver-change
	- changehistory of patches below ---

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


Josef Friedl (10):
  dt-bindings: add powercontroller
  dt-bindings: add missing mt6397 rtc
  rtc: mt6397: move some common definitions into rtc.h
  rtc: mt6397: improvements of rtc driver
  mfd: mt6323: some improvements of mt6397-core
  rtc: mt6397: add compatible for mt6323
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

