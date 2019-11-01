Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76CD0EC3E6
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 14:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfKANna (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 09:43:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:51057 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbfKANna (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 Nov 2019 09:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572615791;
        bh=mEh+x+3L1b8hpI6ZWmfCju/bOUL39/Dd9BRJ+2nObT4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PtVBxoI/SK+6xEvg1ZZo/HuF/tuOPnLqu+thDi7KHYnTfE9x/4eInk6cMQd4lEZ7V
         m+V75PmzVlo9uufNrv5J58RhefcWg/iH0h59JzkDg01rWu78kGrGlTo5i02717NE2p
         UHHY3NQdytJWTHahI+5F1E9c8yVBNmQHmA0xeBIE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.112]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M8hZJ-1iMOTe1cET-004mP3; Fri, 01 Nov 2019 14:43:11 +0100
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
Subject: [PATCH 3/4] ARM: dts: bcm2711: Enable thermal
Date:   Fri,  1 Nov 2019 14:42:28 +0100
Message-Id: <1572615749-9524-4-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572615749-9524-1-git-send-email-wahrenst@gmx.net>
References: <1572615749-9524-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:ViqU/VzUpFCBeYdz3DMy0XjDhbi83+YFTtFiwdUEVCrb12y0xJG
 JHSeurEL6x2c0xITdynQuAUktcS2actjWiIcNA9LKW6tSgbU4IhAqr/yb80wmiiZXDdkkxU
 RtaDv6oRxWUJAIbdWQfDHlrNwKOTXsQFLGnYK7ocTLyLfIIfqYH0GRhzLYCHKV4Go2SCjyw
 iKXWGy7Va5HhUkYZWj9vg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MjkymLFkrhU=:1Ws8atzNbDZdaq1V4d/LKk
 v2eazIzDsKJlqd4spVvQ/fNN8dFUjNONZGSxKKSajuNU+hi6m1/Z0ZMTXsHhktDhj1vYKHdr1
 8AvacTavjC2bmm74rP292jyJc0sEpUwSII4vRfMtr0xSjftUBuF2A1g1hp4gT2Fg/EaCBviA1
 0dVn5FRaQkRHilVQ71NtftEPpZtX7wKhxfYUI0BGmVTuXPjL+nV28FLte84HJZcMwvjtcV701
 jq0ZmBZVt1uISeZNouLQRKpy3D1JR9iGbRegmrbfiVCFRDQHpBVg+HBjrN6O8gAH/jztdBUVc
 vMDoM6/F2Y8gb1gyTpJVleVsfeJaWYgLs53duUvmADHitN/mlU8WqmDBEV6DBf+lWP7Qe4xqc
 KvaClEpno6dNx7SO7gDwrxuVZWUd2wMmoun+hu44juAusckaDREliL3tlxeXDObtJF/XTdFlV
 Dke/fzIrAl5LkM7utm9FZHGfQ50hjTo5dS/rrOgJDGyYpxhUwvXt9Cm/g6hw69KOdAx+giiTg
 LBuTuDBRTCQG+rB9TOT3fac5pSdvubD+OCSc+Jvaaz+lgMH9teTg/WcEe3OgYteiEEDPDYcib
 I9C6zN4KL7/2mtHvjuXfT2IKDp9WQcCbPkL9nzpNLmEdQLHxlCRJjg+36y0nlIMmhayuTbbmf
 4yTVOJAUumLulA1ZvR5MLYJ15TIVFQXQZEvP0kF/5xKe3tW5GUJDYnTwoiQ3EscYCGOQP3GCB
 DIJlVjZX9luHL2/SdwBqCvrxm1GZ83sidrinQAdc3z8ldM1hIQOvId0b9EHZ0HCgq2OQvXw3j
 h8odivHAkN9wLj1eW//NTO14VC0mQt4FsXt0Boi7oGecLLnd3c8vWPHCsWE4zfqVyXHlD10Qe
 4ee/D/Cno3QBz4We1PKvlfMsj5ezI/uSLxe7vLfQAJEXlVcvAgl4tajfDQcaSyhuYVFQuLuit
 eq+MbaCn41hcG7a2D/ZdCiu0qYw7zPJf2G+fbSzdIuROxfjCaMmiDGbzYQmGuwX+7d4PfyHMx
 9CngQ3dspgHJGQwxxdHJ5CWjkDYSBajueTHBrvWNgV1pUScO+USCwW4NAi/5jla0R5ppV1FhQ
 J02uoOPYATV1xXlblla1F8YueZWT5CYkwdcyCg6zkjm5DbHXztkNCkJ3erEpju/qRxUbmRl/A
 qw2f6wijiiNORLjJDsekKtUegmWjWrgQUzVoihKPe6qfwXiZ/CdZ8kJ+qdPlsnceZxRKiqM+t
 zivh29+ZZwvMkagY80nc5iVJzCURgwZfAVwHe6A==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This enables thermal for the BCM2711 and the Raspberry Pi 4.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 arch/arm/boot/dts/bcm2711.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dt=
si
index ac83dac..950e43f 100644
=2D-- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -46,6 +46,14 @@
 						 IRQ_TYPE_LEVEL_HIGH)>;
 		};

+		thermal: thermal@7d5d2200 {
+			compatible =3D "brcm,bcm2711-thermal";
+			reg =3D <0x7d5d2200 0x4>;
+			clocks =3D <&clocks BCM2835_CLOCK_TSENS>;
+			#thermal-sensor-cells =3D <0>;
+			status =3D "okay";
+		};
+
 		dma: dma@7e007000 {
 			compatible =3D "brcm,bcm2835-dma";
 			reg =3D <0x7e007000 0xb00>;
@@ -317,6 +325,7 @@

 &cpu_thermal {
 	coefficients =3D <(-487) 410040>;
+	thermal-sensors =3D <&thermal>;
 };

 &dsi0 {
=2D-
2.7.4

