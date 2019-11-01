Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E98E5EC3E5
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 14:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfKANna (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 09:43:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:55497 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbfKANn3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 Nov 2019 09:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572615790;
        bh=G2JQYHldnl50zbZW3JMKhp0c1cNsuaONpIMkrJ/KY1A=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=As2ICfrZ6dP9svRVq3VYkJZapZIuGCT4dfGp5jepvxoPepDqUZ7/GdEBLYOLczpsD
         YLwzcIZprxLKFy/Nhj09ng2eCZ4lIzOZ+l3eilNnBHSDdG++8nSUZ36bZh0lmjtGq+
         Gd23zG9lwzpFh5cZkQtrvgLf+X0N0VGPAuQyWiOQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.112]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N8GMq-1hvtKY0FqS-0148Tw; Fri, 01 Nov 2019 14:43:10 +0100
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
Subject: [PATCH 1/4] dt-bindings: Add BCM2711 thermal
Date:   Fri,  1 Nov 2019 14:42:26 +0100
Message-Id: <1572615749-9524-2-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572615749-9524-1-git-send-email-wahrenst@gmx.net>
References: <1572615749-9524-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:XnyeRi2jiPspsf4cwaVjO7Sm9iumAfDgEuhhWAzWuUTyzpkYTrn
 BZ4zqBog/lv978dQiAbhvrQjw18T1QuN0sYetKc4U8LKMDUfOQy8viOFMaPkuyQrzg2eoM9
 AFlppBpsz+22+a2Xt0WGqS+MpsOQXB9B9kJrBbw6ou+lIoIn19T7tcZVYbzk8FpdRc9xp4G
 ICQ+A5ANyQLuqvaacA29A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eb27wEqko/8=:dZYolVj9YmOQf1lyukuXK+
 wbcZ6wQJnr8dEEwvs2blpP12a8QH1sc9E+o6QUjCEsLP0/+OhWW0OsHaammYuVbloP7QwkNJc
 dboo9BfdAPBZXckhXFdBK5U/DA5v35KL+2Ax4lj50NzOOd5GD5GqPslbMgyLfp92Qpt9wW49t
 utMfXvQFK0HqT5Lkljnlmzbt/869k2GU1AcedKK8kPvJDhgLry5EkDtSGY8uCtZk9Tzj8k2vm
 XiTIn0ZBkR10CcS9r+rovHe9JxiWm2X91v4d4D9L9Lx4ed/pbh1eAIaW1P1gmlavpIND/gHVA
 1q9tw+c0HBOhR5BoXT/ZRMoUCQN2JvgkiEUmC+DkFgP8uJUdZha4qLmEtrpv+FzYNAPI4l6Ed
 R943ngFB90lWQIkr+98iv6YO1uDvcCbrXRmywEBX478vpJlfqDvmo6CiPxKGI1ZL960CbKevO
 YgJXxhCPjVcdbLkVJ6TVT2mxT7fJkmDNCv7/ClL7YGjdyOBEikXORb6qx5PTXi4xBZ8VKqKj0
 zy5JFc4WfKrBgT/m6DnI5EY6KvzYV6QyH7C87WaON1ujpuPuK8P3v395S7kJBLAJtBltpEqUg
 W1CmvJwx9M+C8j9h+RGyc/4vC3xm5gBQFZCDqOtaeln5n7BuQxKQ/nf570AqhuG+Z+RCKESrb
 p6FJmB0YyIawSi8JDmjZV0cEaKl9XfNCuzZufjr8izFLxn+qE6rKINp+BRIp8rvhwejNabMWf
 MySojlAt7i37Jd4vFvz8LEhXVzOuTH99ovxQv6+mQgIxeqJnU4BG8umOPwDzlhd06+TT/3Fd3
 xLCq+L0F/4Lj3SwtoM36OWQR6dMFBaffsTOzAsfmpLUon748NF5x4r2v3wkM33ME3pLmNa20m
 CKEq+5lyOJALTjZY1DATbsp1UdHhRF7GFZsxgnvIyptEKGFAkoB1ftCzo3OKJ+MpW+huCc3+F
 xGM05bpv9RYy8pcKOZDq1lYndf/tmNFSMnSGWCBoIF48NsgjJImwfrB1eWEldlWtWbpxaQEiH
 uqmbyEZ5cBFiPwqR/zW2GdShItd22ARYL1HPYJWq0sgv8BOCGZWYepVDuCctnlA3u++xQlkF9
 Ex2fjYWes3671H9njr/6zGKkblMzxsEe74SSasSavXt94OvdnGjhwZjUMyJ/2J6Q+apEQfHby
 na0b7n11ecULFE6C+saJKfYggBtullLsEemT53BJx3h1Df1yCbM8wGETtoMilj79pu7p28nG1
 8UICQTetG56wX0DWfQu8EmdKuIt3ardik89PYRA==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since the BCM2711 doesn't have a AVS TMON block, the thermal information
must be retrieved from the AVS ring oscillator block. So add a new
suitable binding.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 .../bindings/thermal/brcm,bcm2711-thermal.txt      | 39 +++++++++++++++++=
+++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,bcm2711=
-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/brcm,bcm2711-therma=
l.txt b/Documentation/devicetree/bindings/thermal/brcm,bcm2711-thermal.txt
new file mode 100644
index 0000000..5531d3f
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,bcm2711-thermal.txt
@@ -0,0 +1,39 @@
+Binding for Thermal Sensor driver for BCM2711 SoCs.
+
+Required properties:
+- compatible:		must be: "brcm,bcm2711-thermal"
+- reg:			Address range of the thermal registers.
+- clocks:		Phandle of the clock used by the thermal sensor.
+- #thermal-sensor-cells:	should be 0 (see thermal.txt)
+
+Example:
+
+thermal-zones {
+	cpu_thermal: cpu-thermal {
+		polling-delay-passive =3D <0>;
+		polling-delay =3D <1000>;
+
+		thermal-sensors =3D <&thermal>;
+
+		trips {
+			cpu-crit {
+				temperature	=3D <80000>;
+				hysteresis	=3D <0>;
+				type		=3D "critical";
+			};
+		};
+
+		coefficients =3D <(-487)  410040>;
+
+		cooling-maps {
+		};
+	};
+};
+
+thermal@7d5d2200 {
+	compatible =3D "brcm,bcm2711-thermal";
+	reg =3D <0x7d5d2200 0x4>;
+	clocks =3D <&clocks BCM2835_CLOCK_TSENS>;
+	#thermal-sensor-cells =3D <0>;
+};
+
=2D-
2.7.4

