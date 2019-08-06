Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5CB836E5
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 18:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbfHFQ3H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 12:29:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:38137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387968AbfHFQ3G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Aug 2019 12:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565108884;
        bh=zpDHFZtFnB6jtb9Ty5VxV4oP5o3ljb0IMfQ1WZg0clY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Sm7iniuLTfio2K6K9jk23/qCkaDP0SaifhnYXC3l6DFmQe1/qob5bGW/zHV+CnEL7
         NZmponM93e49n/3Aw8tLWhhxLX2qjpNnHfwUI2iNCqrxQtBqZKPkYywtnonxdAkOBV
         4yr1wJQLYRrnURxW59FVRPs7gJwHVaLOrrVLUEX4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([217.61.153.94]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Mg3h3-1hikmv1UOL-00NSmC; Tue, 06 Aug 2019 18:28:04 +0200
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
Subject: [PATCH v4 01/10] dt-bindings: add powercontroller
Date:   Tue,  6 Aug 2019 18:27:36 +0200
Message-Id: <20190806162745.8414-2-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190806162745.8414-1-frank-w@public-files.de>
References: <20190806162745.8414-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:AIGOCby4oFv47YSJ9VFQ9scd8B6VnGGTMhIk5HuNYlF12fPSCco
 xKJUKT6QYOFGIKQ/z6NSePLt0CdsRa+wV9mqMkGua7Wffu3uHXZ5GOP+r81dHjoAOYNJDfu
 e/5lRA4Zr/gAapa68Gp9+4b7M1GCmMLNxEIvYHwHWvx9ONzS5qP8Hqyb3Nr1jYM+UxZbj2k
 paoqGOeO7rPQh33p9JYoQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XWjw5J45VAM=:2dSZxUR1GbmeEjxNlusGLw
 bS/X4iPie7hRL4oNU0IhIawv8w7+UaAWS95KxFVjElYWEJvvWqTdn6Of+Z5s3pA5a9TSAtTMj
 CNctLTB1MuM/wZXB0BiCWE0l8i5SsBGBTEMa6FYysrIVH6UcYZQHj/oXM85L+Q/rYgzFwQ7t9
 KrYKViVdYJ3Cj/HGncWtchT8zc6jf/VVEXyEgb8OzWklBRbUKLf8vXVajYu8EqaMY4HTEffiS
 ERCxOFFmDFBcBp2ziLwibJKhxV9qWOrsf3c0D0RFmsdiaINA4aO44zOnVKSg3odRwKzHFg+9y
 yvTBNPqvgqJn2UJVieb5Z5k+jE8MDkgk97ncG1an3Dp+/5LkmCmSS0agyHjVMOhoKkjB4uCH/
 4X3Ui7XOo1nSJrRZTJhyWDPVYlq+Muv3n8wnI4MxiZUQe6UMAX2oLXdHnHF/Ia8u/+WfUHoV2
 tQdK+HuRiK+2xvrxaUgyhvU0esYsoGZdM6htmr03ZbflgROiJdJgqPghUdnnCz5dABD6VQjLr
 CRV2mgHbch0EACyFGdFBkc2EDfrKVHajslHZDqg+BNtjewwzgdoTAIXCswuNAAcRG3SHLY9Cr
 F7kRexbw9K0pwF4OTHNgMf25kgvRHEkDHvi16uh+BGahESYj4HBnribGQ2OUWnA+lbGgeZ28S
 2F4GwZU08OlcbJRvneemznuruY3ibbR05hjE6AbcWWPgvyYpQXBYWnoFkRzrtSMiYstbt0kEX
 GgWQH78SAYaE5hTmH51YVSxQp/JvjCsfcWKDveoM0AtjrDNaaLFCmevOSssHo23ywjF3Jf0/e
 0fTx4cJ9IIZ0X+Qfs+hC+xdW8Bj6UHsssu7G6UluKU/7SvzBiCY00JL6I0/B7lNzbXcL+HcVQ
 fm4NgU5Z6Z6jy8dzgVeUiFvzJOZQQGvTEr1VvSHkhT0susH89L9ZYOoORcRB1mV8DwF/nA7So
 2h+msJBOwWROaNUIXy/NTGNiHq/VV352sSO1x86bfskFwlT/bLkEVE80aH9fOIKxq7TzxP1JJ
 8wZu2uOSr4wwEKqJ64LTSYdq2OOiZsm1EgvhjeCav0HTs7diGxKHv7gDj/RM5/GREsfhgyVQg
 zjAqbidpbe8q32hMi7f5Z/Qb5OTiNuYD3oKEzkaLPWDUc54ZGLJ/s/5Og==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

add mt6323-rtc and mt6323-pwrc to mt6397 mfd DT bindings
an example is shown in mt6323-poweroff.txt

Suggested-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Josef Friedl <josef.friedl@speed.at>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
changes since v3: none
changes since v2: separated rtc-mt6397.txt to part 2

 .../devicetree/bindings/mfd/mt6397.txt        | 10 +++++++++-
 .../bindings/power/reset/mt6323-poweroff.txt  | 20 +++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-p=
oweroff.txt

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
=2D-
2.17.1

