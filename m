Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D3312FB8F
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2020 18:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgACRYu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jan 2020 12:24:50 -0500
Received: from mout.gmx.net ([212.227.17.20]:54849 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbgACRYt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Jan 2020 12:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578072274;
        bh=BZwbvnjIkKy51z9cUu4HZ4g7pOB2mlq9DzuAGQ9CZwA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jntuTEtf/ZSMb7V0+1xMNDsSiGiJc2+G7ijZL2vYwwKrVj9lfIlJOS77kUNGD40cL
         EqaRqeqdesM8MDLzaUHvrNunt6gcrXVZRQWk6TNPk/GUsfclMODtmHlALLe/3hZ3mw
         Da5KlbqR313+0Tvj5azlJvMD+1wfElRPBlHEphDo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.154]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MMGNC-1j3Je02aW6-00JLjG; Fri, 03 Jan 2020 18:24:34 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 3/4] ARM: dts: bcm2711: Enable thermal
Date:   Fri,  3 Jan 2020 18:23:55 +0100
Message-Id: <1578072236-31820-4-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578072236-31820-1-git-send-email-wahrenst@gmx.net>
References: <1578072236-31820-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:VHkLP3wAXoJeCqgSYpKkHHl9KWD7U8WneNkXn6EF+49joTjnbLx
 Lrzy+jtF50qY8o1EA7jxzcODuW9wZtwUmb/GemrekFYswZwtqdyMEhY3n/kwzKpAlbmpnIi
 nyylX+O+CPTru6+8MhDiJRuLo02HcYzljN/UZpjBU79q9/TpmR3aUcwQ4jqhl7d/6XJgbih
 tEEJ4RfOykTwEIAlS/nTw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GicZFVX/nNo=:lf5QKtzxZBdS9dk6SXWhBz
 a/56cP58oiRIrUBxND8vjuB0ynBFWvQoH0+wQtiCwUryGm8fyFPb5L5ffcxwgt5GqMVuYor+c
 l4f6VOssXogvuOIZo4un0BZ8oZWSu4DuOA2e1+SQiSlymgwBJvPmqF4bKOk/VgizfxnAajLd+
 NsNULw7+1GfxdwvW0b01Ycb3PkI4A6xBa3DfSivbushAfCTwdlfLfNZ24goHhNvNM+sQLFxzd
 4UTxgQtN2u7Mwa/EGZWFCYVzX0AHwqTFd2Pj5C7mEGrnpEZyiWqF116n5UGPIzPdC7oh7sJm8
 yT8+BkOE4BTugAvpwz87B5tUrb+Sw4GWRAOBMJp7ewOTb8DTNKaBdvDXXJfceQXk4Resx9EGC
 iODQ0ZuhezBul/FWOYekqYHJBzGurZ5r+VHi2uxAcJCewoFxtgzSOJWgOIN4expOnh26i9Wuk
 MViPpP6JFZaC/NAGrWmnaijeUYC2r5fepKGrQNyCN010V5ZJxj1CVW5wK0ViA2qLafx1TN1u9
 Po4li8L0viS1nBINe0Pk461tZorW5gypk0CHYl8B2YAccN8J2MSOXS0WkefDPnpwph+iubP6S
 GhYcfiZpd1vMbhJgoArDPYeP0K1amb9q++9EGfqEN2bgl3rpKPcuXQ3JGSfTcwFGPp3D/fh27
 cWQ0tX/aqedgJS3u5puS/zH+FLEi3GV7yzA+Tr9WkHKWcgd/eKHt9Ww7iADIf5N7OpKc3tTwI
 IyzyLBSmsypG07NrMVHazQykZHRwhdNcMg6AZ21/JMV6lbrPQj8Qvw+vfdiCmzBdnsNDKzk4q
 nhRu2Y8e5F0BLCsqp0ZD+3BdfZMAQ6u9FqVNMU1iE1OKrQ+No/ZVwkpPDT56q9wkrEYSwSSJ0
 oGo0cXiy/Pzr2Fdd33sEWG364LxFUAH99liutVn0doirzVFzoVHG8CQtsDrp4Zx7FPSNOIr2F
 kfyf0zpmWPf8o+xLh75A/NaFzCNMbpBwQ0A/Yg5t2UVzjQYrPSdhJpKctdWHvWchzyZkt3dBN
 e+6Brd0BzW2jrnlIl0Ydi8ys+JmKzYf4UnRXc6Q7yaVz4rB93lzbcgs5qPx+TRbTSd7uE+tTa
 Y/dGlFFG3bb45ere30CYEz1xKCaezehhCM7LqDf2NXXhBWZmKCJzbz/jHE388vMKEzt4QxOno
 kdfyb62S4CQJZL/fUwE5IRG6jDW6gex9fyfKvE+WNuSfX8pMT/JhKCQpbxIThWFCserzn1MI0
 hPjW6oXlQx1toBsxgXRkwAW67F5akJzIpgcL4lQ==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This enables thermal for the BCM2711 (used on Raspberry Pi 4) by adding
the AVS monitor and a subnode for the thermal part.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 arch/arm/boot/dts/bcm2711.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dt=
si
index 961bed8..96f341d 100644
=2D-- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -66,6 +66,17 @@
 						 IRQ_TYPE_LEVEL_HIGH)>;
 		};

+		avs_monitor: avs-monitor@7d5d2000 {
+			compatible =3D "brcm,bcm2711-avs-monitor",
+				     "syscon", "simple-mfd";
+			reg =3D <0x7d5d2000 0xf00>;
+
+			thermal: thermal {
+				compatible =3D "brcm,bcm2711-thermal";
+				#thermal-sensor-cells =3D <0>;
+			};
+		};
+
 		dma: dma@7e007000 {
 			compatible =3D "brcm,bcm2835-dma";
 			reg =3D <0x7e007000 0xb00>;
@@ -363,6 +374,7 @@

 &cpu_thermal {
 	coefficients =3D <(-487) 410040>;
+	thermal-sensors =3D <&thermal>;
 };

 &dsi0 {
=2D-
2.7.4

