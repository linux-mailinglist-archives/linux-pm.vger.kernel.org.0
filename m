Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAD9A79250
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 19:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbfG2RnI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 13:43:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:42851 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387679AbfG2RnH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 13:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564422136;
        bh=2upA4Eee2eLxGKQpMOKxUWbTwNeRMbtSYCSugmC0GWc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VzxBOSkQ57/fGvyduo8JBaFAJ+4VaF5CN4fW7TY2VDUPAkXvgMAcV3EEXSU8TTIV4
         QzknCcyJLENarfrzz7nLk58UoDs17jWocp4aEaE09F9wttAq+No0HgtpWRw8pv0uQt
         aFj27TlQ8tjwfDcuAN2ZNYmIDJd47SlpJ2oN66tY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([185.76.97.79]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LwaQZ-1iRnd926zn-018Gvw; Mon, 29 Jul 2019 19:42:16 +0200
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
Cc:     Josef Friedl <josef.friedl@speed.at>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH v3 02/10] dt-bindings: add missing mt6397 rtc
Date:   Mon, 29 Jul 2019 19:41:46 +0200
Message-Id: <20190729174154.4335-3-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190729174154.4335-1-frank-w@public-files.de>
References: <20190729174154.4335-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:n2zUh/vBMrR/T/FmmAN+wn7QKL0aiwb8lCVGDcRqmLkY60+LbYp
 75Yof9evGGAzVYq9T7To3kmtms+cHY1cVVgtyBTBTTcA6ILiDSHdco6fnRBkBVOFZWOgYB/
 +mflzaL6iXpplrBY8RqzW8mD3pso3luf6hoAVRWBqYJr9F133IWFvdnHnVi760Wayt29vUB
 DFXx+EoY/2zJUHu9L0pKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3BCmzlM7TJA=:/nJkZvBc4do4lI0pWVrXDu
 fHAfzfWinW0B6mPgALHOmP3HwFCiJOmcN54Gq7X+9cPdGCfSx9tCoLpStWPNB+CBR9qwkqho4
 r4ut0m4JUYbg+ZzLd+VkDyvISw4LKj/msNspivDKgUC3Qg9H9Zt716kgHwfrzNQXmLKBdoWlX
 Tylf/ZNz+hT5FqzbZ5TJRX1xoI3ORKdhrHZy4y3BNGB09kuyrwkwrlWM+PC13R0iGFeOP70K+
 SINkemcm/T0vK096Yei+cIZyrlt9ZZtet1+664WrbtvC2OwfB35ToHWqT07KVN0L17cruOGi5
 8UrpLVZkf8bjOXVwc5gec5BN+e1Jjn8M0PAkIQ1H4yDYAq1AJpTn1Fq0Ip45+BXcffemK9jF2
 F/LN+SSGl1bN9GUv+REV1ZX/tEBNKrrEDG6S856a6W2zfOOU5yvi/r5VLiUhsZv/CWi1g8c6J
 rejZOQcWdZcxc5Y96oCmTRNFdV6o1u+E4uYa402iMDW4WXgvs7LsNnx1oDNx9AvmlKeaA9+h1
 OGfD4q0UobAfVJ2/I015fi9efjAUXoK3S0njDCypDdQloHPYjUx0rNW7ND0flKSl5hWSuRR+H
 dIZrQQkm02s1bI8HQSqivuxxbFdAZo8bpbF2nlevAWDoxKfgarBuihytBUyB62ZSaz6Bg3vMR
 ZjRofVttHU6kJDhwabkvEb7PU8hzRRTY1p2bjOnogGEhLeYNR8rgCJVzwJZSKNS6nLe3zuwgc
 dzOSmlYWvMKQdvIE2l4vKPsWqzdJYom0wcVl8/L9gzUYb09p7pu9rWKKOkkkfMIX/4+MBSYHZ
 mdCMYjMkYyJM1SPPRCgi9QvJDniXokzLN4nqqwnlX904L11+RlPckML8qM6xjEH4EuAex6Cng
 b0ow36LqBD5lfuzSm5Rjqv9prApeZpbSTjfSKm7IXSRdZJq8rUxtdDmKTHRYDbD4j6zF838sz
 XYsSb59qYHtTqMrJjn0FPtukG+/Kc5PGenkzXVGBxAvMDpg7YGJLE1GiXxZD46c2yGg5GHYtq
 oDV0pdXxsrg1/X4PdtqRqhZRpNaTydxnTvfZPrpsiFz7NxGywxIcQSn5mvSKVuzUesbv/Rjk4
 V7HMJZgp3cOoec=
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

add missing devicetree-binding document for mt6397 rtc
in later patch driver is extended with mt6323 chip

changes since v2: splitted rtc-mt6397.txt from first patch

Suggested-By: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Josef Friedl <josef.friedl@speed.at>
=2D--
 .../devicetree/bindings/rtc/rtc-mt6397.txt    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt b/Docume=
ntation/devicetree/bindings/rtc/rtc-mt6397.txt
new file mode 100644
index 000000000000..ebd1cf80dcc8
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
@@ -0,0 +1,29 @@
+Device-Tree bindings for MediaTek PMIC based RTC
+
+MediaTek PMIC based RTC is an independent function of MediaTek PMIC that =
works
+as a type of multi-function device (MFD). The RTC can be configured and s=
et up
+with PMIC wrapper bus which is a common resource shared with the other
+functions found on the same PMIC.
+
+For MediaTek PMIC MFD bindings, see:
+Documentation/devicetree/bindings/mfd/mt6397.txt
+
+For MediaTek PMIC wrapper bus bindings, see:
+Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
+
+Required properties:
+- compatible: Should be one of follows
+       "mediatek,mt6323-rtc": for MT6323 PMIC
+       "mediatek,mt6397-rtc": for MT6397 PMIC
+
+Example:
+
+       pmic {
+               compatible =3D "mediatek,mt6323";
+
+               ...
+
+               rtc {
+                       compatible =3D "mediatek,mt6323-rtc";
+               };
+       };
=2D-
2.17.1

