Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1FB5E9A6
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 18:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfGCQtm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 12:49:42 -0400
Received: from mout.gmx.net ([212.227.15.18]:60141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbfGCQtl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jul 2019 12:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562172512;
        bh=0w7nyu9wSyUNFugecpftxoveFd04MwndiFhERzCcH4U=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PYCf/wvNcQPJqzK+6TrPDe4U1s3nWPkcTSLDXO7gGiKpTIDfc7nv5PJV3SbxXc7Xw
         LeRsR1//wn5WyWNxELldcMXnjAt1fNkanjNfcJEqmb3szfmhO4k6naSQFo58U5pvew
         8jpdomMfHcgQrEMVZu4sW6iJ4sPXLyv8kVwZWCXM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([217.61.158.204]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M1Ygz-1hhKrD2Xhj-0032k6; Wed, 03 Jul 2019 18:48:32 +0200
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
Cc:     Josef Friedl <josef.friedl@speed.at>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH v2 1/7] docs: dt-bindings: add poweroff
Date:   Wed,  3 Jul 2019 18:48:16 +0200
Message-Id: <20190703164822.17924-2-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190703164822.17924-1-frank-w@public-files.de>
References: <20190703164822.17924-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:RaJfCMIYAXb0FRWR7atb1Wt8tqSDqFVstf8i87J53HmZBA/WEAg
 8LprSsryrnuZeOepH5JTe1QAJSgeVotvVYsGLs6vhRAbo862eWgtojUHsuKT0EBbNS2dWBO
 R2U9uzKnD1fziJD6yy+RdFdfe+Y+MnXjt3uOOKFlS3d3DJT8Pxz92w9+sjvWeX5O/0dxnWB
 hHc3AvQQ7ORjbRBCJsiZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oBlJwgH7f+s=:2iLFypLybMqQHCt22s/EyG
 x/20PnTJLrdGQlkGUdh9j0riLTLu2nMd5NUZz9uOPQM1Eo2HgEXn4iRzawBB48Fpq98G3hZ29
 FcXFiawcFAzKY627wuPidJIFlb6Ns+E5HAA2QRD8Xre7CZxccu+vN5tjRFfGhgctJ+UyAnW/4
 iDL49WQVQJqLBYW4P9OZo+WMsAMR0ndfCGOz+kqlvwI1e5FNRwPaqdA1fcpPVL5p7AEnAJWlu
 8nmqjEc1Mq2zvcZfcCiWJMY+uTSP4cukJRSAePUfEzcvLCNOYBn+JlSFUj9w9UcpTcjZgdV+t
 hRS+k6NeinQsPm+m6aARwt8SXs2FvEiOo+AfvGmbNtEsIYsgoJyRRbAaoaWI4u3wgFcvr432y
 mffmWynHBa+y5Ut23hnLVk/8ejGBnQTUnxX0oxyhWXs/dydC0bUmYweEJv3bmE2lX+BgynxL/
 pAwKC/jafmUTzWRiny3J07UE2iCQrMYZnrSzRLxZCjK2ghGZkEgYo91qXy4/+8zOklM5aGbyN
 cqLsZEx8g0yk1Q3YJIlBiWLb1+xUHThlAUio8ojQnKyo3rL9pkyzICsIY7by6wmF6PBgjVcER
 2rUlWEzvQ0UxAgWgq0VtZWkKj/Pt79S28sLeF2dQAvTDseqF0Llfj/N8+9JqrR12Q1q7n2PvD
 zCUp2DGTQGfSUkwJs3bud9nbQQCN6SgUu2J860SHdWfyyKFzYYRk65u64b7/dgYgYvd1v5ejd
 XPlWw1Mmuzt5tQgLSjHIlIHaKE4oIUP1+PA+G+CLS1SkPMuOpjGkmZ2Jc7+bZ8TRY6pA9wK0/
 PfwxgcTGS6pw7I6XxwAYfCpilHHLSCgoQN3zSuyF0V93vtwZ+i1gflaL7x1RS/jT3JiY+47f3
 8S9Aac+8+j3eZADuylaS1We8B0u4Jrd5J3fAzThPBnf4iz6FezyGv0QSW/wQBKGiIfLbmFEF4
 O/9DqpcoSuWHudGVKJ04WTA/RmLb6a9jxNR/LEhS7cEtjjnapyg4D3zXy+aBN/DoLH8x9k/Y8
 dr6wRWdiqKoEp7nV0v+UBliPBigRdTjSwnipfxpSr0CpBGuV1IPOG/Z/9jISlQP4O6PpxdqyU
 sxej10Kq0vp0m0=
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

add documentation for pmic, rtc and power/reset devicetree bindings

Suggested-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Josef Friedl <josef.friedl@speed.at>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
 .../devicetree/bindings/mfd/mt6397.txt        | 10 ++++++-
 .../bindings/power/reset/mt6323-poweroff.txt  | 20 +++++++++++++
 .../devicetree/bindings/rtc/rtc-mt6397.txt    | 29 +++++++++++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-p=
oweroff.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentat=
ion/devicetree/bindings/mfd/mt6397.txt
index 0ebd08af777d..44acb9827716 100644
=2D-- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -8,6 +8,7 @@ MT6397/MT6323 is a multifunction device with the following=
 sub modules:
 - Clock
 - LED
 - Keys
+- Power controller

 It is interfaced to host controller using SPI interface by a proprietary =
hardware
 called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwra=
p.
@@ -22,8 +23,10 @@ compatible: "mediatek,mt6397" or "mediatek,mt6323"
 Optional subnodes:

 - rtc
-	Required properties:
+	Required properties: Should be one of follows
+		- compatible: "mediatek,mt6323-rtc"
 		- compatible: "mediatek,mt6397-rtc"
+	For details, see Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
 - regulators
 	Required properties:
 		- compatible: "mediatek,mt6397-regulator"
@@ -46,6 +49,11 @@ Optional subnodes:
 		- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
 	see Documentation/devicetree/bindings/input/mtk-pmic-keys.txt

+- power-controller
+	Required properties:
+		- compatible: "mediatek,mt6323-pwrc"
+	For details, see Documentation/devicetree/bindings/power/reset/mt6323-po=
weroff.txt
+
 Example:
 	pwrap: pwrap@1000f000 {
 		compatible =3D "mediatek,mt8135-pwrap";
diff --git a/Documentation/devicetree/bindings/power/reset/mt6323-poweroff=
.txt b/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
new file mode 100644
index 000000000000..933f0c48e887
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
@@ -0,0 +1,20 @@
+Device Tree Bindings for Power Controller on MediaTek PMIC
+
+The power controller which could be found on PMIC is responsible for exte=
rnally
+powering off or on the remote MediaTek SoC through the circuit BBPU.
+
+Required properties:
+- compatible: Should be one of follows
+       "mediatek,mt6323-pwrc": for MT6323 PMIC
+
+Example:
+
+       pmic {
+               compatible =3D "mediatek,mt6323";
+
+               ...
+
+               power-controller {
+                       compatible =3D "mediatek,mt6323-pwrc";
+               };
+       }
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

