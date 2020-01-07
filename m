Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C623132E29
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 19:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgAGSQW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 13:16:22 -0500
Received: from mout.gmx.net ([212.227.15.18]:33463 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbgAGSQW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Jan 2020 13:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578420966;
        bh=aWglA2PfdwtIHtm2mDExM6LOMnFuWnZiRAiujdoAMW8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dq7Bd9O5pRIoP35pWiEbr3vIwPVUIZdztKslWibSe4sYkKnlLAbn2Tly+3mecxMX4
         plidbchinnJHsr1byo3468d32bXORW9ghvyBGxOn50Zs4URcLnZ6Mj9sUeBhkRs9yz
         afE9G4bQQvpFS9Aa/ELtd1yj+QyiHuLkxDC5oxSA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.154]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MoO2E-1jUaw13WDg-00onqT; Tue, 07 Jan 2020 19:16:05 +0100
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
Subject: [PATCH V3 3/4] ARM: dts: bcm2711: Enable thermal
Date:   Tue,  7 Jan 2020 19:15:56 +0100
Message-Id: <1578420957-32229-4-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578420957-32229-1-git-send-email-wahrenst@gmx.net>
References: <1578420957-32229-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:nnCaGh26y5WZ7Y+Du8wo80ycqs5dd0zUOiU8IyxmRBut3vh+kbS
 hWpSdRT6jUdGy0zdQC4p0GWbndKZlE8PcisuGyj1O6JS+PZF0lvHyqMgg93jy1GqVcINVAT
 m9kwkGNF9DR+OKHvvajSgRYV5gRp3BIZpN7jBioSwAr2xEZCwI3aFYzZL0/nM1tdwZi08do
 f9kojNp6jUr4vT/oaeL8g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eypfnYKWbbQ=:3vD1OpSV55xSk4yzLYUc8F
 ss17pikWe3sKTkGoI3BFvSL2dMCJntwyDYvcMBefgSpGcgd2z3eK3CjpAhx5Z35UkdK7cr6ep
 lsMn51ut2iKyCZ1FGpPY5mDJroBPqJFUDxNCh0BAQJn/Vyd5aWvtIStBX8vhSZeSLwOpkgYtq
 INAm+O2AD+nw7gqpqya1+fc2pMPvW9S2I6sYSLCuOP1gqJraZSDDgUp8hn2DbLlhVPgD5MSet
 VUMc8Crizcnnhu+3dx1SJtxS/Vykaw4X0YVr5/sV3mNPI9sqSWpndRywGkJfhs6ruCBSTZPqD
 lR/PwjRR58iwZ2J2O3oBfahA9dQYEQNQqxsQxIcJ296R7AyEpq8PePDjT6Z0qKPaIP1KiR9/8
 bq+HA6Be/peO7fvhwDxJNy0yQSnXJDjLqu8Gop7ybALxiK+c+alVEtyBJwd7wL+FCdL3hNnHi
 gGsohKQNAHfMWgJXcnYBqr/mcSjQf07IYNuidrfs7biH4SIVMneDFBM+bDyXpPKaHrAf3f8AJ
 6RwAQAuSBoGRrR6lOKFx63o3tmAI4R/vfyosXbLXm8nheUTCB3tmW+/J++QiCrafqCA8rzZCF
 eZgIaNncjMxPxyUmV608AjOWEnE6xf0cXC57Cw6mOq19oVtp3qesCkDvbyaAskyCX2IXZJ7hp
 R4RpokH33Uhu6IaIyGV2LuP3GZK9YmAOG1CZc6l5u7se8WRN7N1n2HkLLe2u6DM/WjZmdT7HR
 uOAbQn7NWoke1DXdnj57eY3h0Y+OJlYvhkdh7pWVUiWRLRqOOnD+ME2CRRRqD6RlKuSilEpeu
 qvPT2/eJFvIL4pejhNNrPB2C3RiHhHmyeUbQo+2Na5X/sLn3vwhfDac57ev5NKIeD7FPGPgzr
 4YF/E/rSQhXylqhqwomJMyE77jIsa09OD73gY0UYIW38Z3bfj1MlNpM3Dzq68Uy7ILcunYJgS
 JYdohNePZWLE8JBRj3z04HdTs4ogtDQLrJZEoPqWJwyYXpIblHXV3hcEm99M6ZiBCVeJQz2st
 narTYNER7iY19YC1Bc/z0ahz5Y/DiKEZI1KwPjmqzwl9DtgiFpahgvJ/htv/UFTl6UZHKBM9g
 k/uJbVQbreofaRz730uheNJu0ruz6QvWSAMa21Ge+vl84CGbcDOtC2ydUXhbjpVYa12n5Eg5A
 pQS244oqQTS3hWqK8xrFNm4jmBcCDAPGv3xVBW1Jg6pRqybLzta5jN+FfPaMbWh0yVV5VO6qu
 tKLGAzCzdsJVRK3ly7+y1msAZ7D0THx91qoghfQ==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This enables thermal for the BCM2711 (used on Raspberry Pi 4) by adding
the AVS monitor and a subnode for the thermal part.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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

