Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B464EC3E8
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 14:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfKANnb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 09:43:31 -0400
Received: from mout.gmx.net ([212.227.17.20]:49577 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbfKANnb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 Nov 2019 09:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572615789;
        bh=kcBKcJVOa9O9gt/1gGKhUY/mTXUJsEdNU9cT780Y7Og=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=XoByljlPxUx2ORHxVRylkGzQHBRaOhdOBUSliRz9zmfeGNoM6nKTrj4yRwcWVeLAv
         60abCnG42zVXdU3+WUCWyOMBVt2bLg51VXdoa1xt0/9vexbu7LvFXlCkS1NGACj5op
         njiP9I1SdecTozWYl7AOiTJOe1kBT835OnFxAUG4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.112]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MVNB1-1iZ5Ug1luZ-00SLQ7; Fri, 01 Nov 2019 14:43:09 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 0/4] ARM: Enable thermal support for Raspberry Pi 4
Date:   Fri,  1 Nov 2019 14:42:25 +0100
Message-Id: <1572615749-9524-1-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:LYhrgAqYuJOSKZBHS4xtwA6qw+Fd7NI7pnQJ1JEonsrCmfvtrIH
 Lyq+cNclMYkZADaN6b92h1cQbUBuJfONajbE6qeK1AFP7U/h2xJQ8P+r6vNODLZwZhZ2ktO
 InieNmIR8xR/yHy3Q51s8ZZx+IG1AHDs4AvYognOK0TIYxglAVQ4arD9pW9QuppgrqwRRGj
 CERsa8Vesen2yT7oA5lPw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7sBRXt/lcKo=:iyAG+/n+l2vq9c1Lv6rdmK
 oZOzFVFYUoeBQXkrBSSZro4Xi9DwaC/cZyG9NXwLaw+Oob+aNnPe8TB1kG0+hC/9WMGEjvrKi
 ht99cgtuWDjfH17nU5MXUsPhtv70Af1Rg5XLlgQX4ChkSpwxYeCem3b2umMdN1pfuvyFq4hUc
 vVM2MgLN5WKRqLUzNS5gGSdomiFeliBF915Gfb2c8GzWkY2NxDMtppRP0BpME2HpMGfyoO0+D
 iYMoALpyHcNPEsSsYAC36MD8AV3eeXxPcf+q66ApkMJuI5Metvdt7UqBAO4LNteg+sdKo+8id
 T2Uo14Uw8VjQC+X6dlMO3LSbYGtL1KIZp6D9PHS9YGC1dZv+UO08UxFlD3OAWz3KsLyDksxYy
 7Kp6U+kiyp//FnTEsW+jPWTEFQXTi2+wxCWniMo6GkVVZkNe/nYZukVA1n6EQLPX1+W/zewYP
 kfp/TtI0dstoZJ0hxXA5+mQE8u1jD/CIX+fbuBiXLjqsn5567kbqt2CSB8bM+MxCVH4kc3NMf
 0zvMbkq9rondCg4XtKutQcPa21/BcaKd4ig5gIPY5s7MiUX6VdGGr21BTDG1tmraXJSdaYuaq
 RFefkC53yFd7BmtIO53K8DKpNQyNqVT4D3peO/hBsEjXVjC5lODvrPXj94uGia0prycDtuP7+
 S8A+TAMEBDfKQ9Bvvx9oqpA8lUHK1beVqz2NLdpABWNPFGDU9mEt7IMWanWwwMq3zD0JNSx4c
 gokYLzVj6HvyOe/gR3AQp6jz41mX8+VCklXgQAYJYOoWnPF+ZjXFgPFhjulYn+U178kydwB1g
 3KEz+K3bRmcZbxfHHUPMipHkowE9/GOmdm9I4NKx4yhq4QY4G17UY4T0D+fKKdIGKarJ2aQeR
 MWKkE8F1Oqwh8ilH7bIyFDb01fpjp9WMJdzH4zMoGCzuOssfnwaO6c81yB0ZYiJn6PuwEfojx
 6wdBOrQ50UBOJ+8Ala1O6nF8ELXwodyRpzCqH/CNgxafsLCjITtUPHLPgJmWPgp3iB/sxPs45
 8hKBuiJQwX1olIO/rRnREf256C61AtjOiAk/2d/4YKoWLOtjxLCas77YTgyGxHsW5t16Y8WSS
 He6b0WX4JSi7/JRFpz3SnAXu9d9KP/j8s0+anO5FY4REYqIU2Lz0HoaNlb//MnZ2p25sXu0ts
 5Hldo73ASMxmhg4EfplLu8R5s9dSlHyl9Fc8gZCKitzbGYHhmYOQj/VRIE6qdRecTBU1skvsB
 CHl/KE4xvW/OvQuS+iKyaQrmebJwb9QRuF/34Cw==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series enables thermal support for the Raspberry Pi 4. Neither the
bcm2835_thermal nor the brcmstb_thermal are suitable for the BCM2711.
So add a new thermal driver to read out the SoC temperature from the
AVS RO block of the BCM2711.

Stefan Wahren (4):
  dt-bindings: Add BCM2711 thermal
  thermal: Add BCM2711 thermal driver
  ARM: dts: bcm2711: Enable thermal
  ARM: configs: Build BCM2711 thermal as module

 .../bindings/thermal/brcm,bcm2711-thermal.txt      |  39 ++++++
 arch/arm/boot/dts/bcm2711.dtsi                     |   9 ++
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/thermal/broadcom/Kconfig                   |   8 ++
 drivers/thermal/broadcom/Makefile                  |   1 +
 drivers/thermal/broadcom/bcm2711_thermal.c         | 146 ++++++++++++++++=
+++++
 7 files changed, 205 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,bcm2711=
-thermal.txt
 create mode 100644 drivers/thermal/broadcom/bcm2711_thermal.c

=2D-
2.7.4

