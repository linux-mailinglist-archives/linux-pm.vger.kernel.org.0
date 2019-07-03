Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEA6B5E9AC
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 18:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfGCQtj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 12:49:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:40339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfGCQti (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jul 2019 12:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562172519;
        bh=f9CkfFAhLTyBC2mK1XCTgP+oK3gUWu6kajz4IzQ916o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ccmsewjWRWHoMNLF2s7g//LMWfgSyp06z3ShFt9/me5/llbudtpyDqAZ7RnoOn4Tt
         CvC4e0v/3nmjUv0dhgQJy2sigeitMow5Sn9OcqLdqbvdjoj8dmxW0wXY/m+G+VQrOo
         i3uwlTJ4K0nJ56PsJ7LtFjxsv6hWsHCF3gnGztF4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([217.61.158.204]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MTRMs-1i5laU3QXU-00Tp6b; Wed, 03 Jul 2019 18:48:38 +0200
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
Subject: [PATCH v2 7/7] arm: dts: mt6323: add keys, power-controller, rtc and codec
Date:   Wed,  3 Jul 2019 18:48:22 +0200
Message-Id: <20190703164822.17924-8-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190703164822.17924-1-frank-w@public-files.de>
References: <20190703164822.17924-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:J5PTVldGZ2BtOOxdvMcmlO+wL7EiSfxjE9VHSxBCKJhbkcDQlEx
 Esz8v7fVJsxih/JVqdN1Xz4ToCcEotkG8nETqKCtpTZjnCWCEYhdAhXiwdENZNq5B9ALaPs
 YoBaBKrCd1vtz098oBC24Shrtkt4F4GsB4V19dGupv+0Vcm0eG0R/w64S1CugmqG8uGDnnG
 ZXLtwX8ZJAaVOUvXxwkPw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ykV+fAiJ0bE=:bYAiQp4RTDSPBbgVDfvdSU
 XzhISACTumkRFqupBxuQKLduJKimCuNWZglVJIt37DLMLw3+n8YOjkzy+31rLeZQOUYZvtRaF
 Sqjto3crgtUqjxK0YrdEGwu70YNCdvrTwsfAuTDG+PXrRXLjRM/5s2fayeOnczlpkM1w0VOV7
 eNCLq2Qy72II90gVKsvL3jvVcpdTZWQguisuYqiT0vCy3GqFzJ3pIyCa914/rvwh/L1hj16pV
 91xEZ4csMdVhHCahybIFDx6qGbs28J6i32giKzVjyGfILSk9kDfjD0Wl3fuInAA0HOP+JGv9W
 XpjUH3RuiMldhEpbL8JbDMQxP/na3Ai1+cF8t39qAH9NUd0vtExElGOt035Z05eGbA38TTlxt
 kl0hRtPLSRbNnSrakMC9oBAbwTxjZVpBRrMfwPdkmdGlK9XMF2rmUcgwBJZgI1Xu4vfP3iKnp
 qgw/fiZcX54mg3PAxHR3lPDDseNTVWNmyMN5i6dEgSKLX0ibn1v1m471NiMGejISsmhRz/rje
 4RlmsfErlTp1GwalRw+nSLlWtw0grTJl8L/6NCGkQXeb5IYECjeSJhcwrZJKFH+KaMKCUU3MO
 zlXHhbWWL4nQ8y3c2W2Va0kuimBZCOa7fNndZpjm/z1F17l9bzaxMorz9kzx7C5aaOfhGI7Fp
 9fhhaZ1wzuiLUJAYswpw+4MpTC2AlrToXrRrjfd/nKHjE3fj+1mZqIXUPhwcQatiBXz6gIYus
 eqLYR+bdFy0mMuMx48q5RYwktraBnxph4eSoAltr6xQGslFCQDQcVQ7iCppVOc5MetAZ2VVfb
 UZrNFiCmM3+YVxojnQbNfPEhmomgngQwRf7pKvZO9j9M5HDMFb24NmsUho4+9n2icrM5xipIL
 YrnY515cISAYSiRQKC6XiU61Ff7PwW38TgBB7oP/sdAw86snuoB7JNWC+DzwIf1lfvw7IpTjk
 Q8RbRz1YOaLomovB9VHabs4hdYACWf4KZ6E3r0iNHwLzJ/85jux3C2jPM6nuBqrwBqfLs9jk2
 bsBGd61Hv/hEAHxPGsvJmt2wcMpHB/x9pSBqMYJWuRx26h+7WRPhmYSw3gdWgpZbHJsHG3KmK
 91ATsTSyIjDuDg=
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

support poweroff and power-related keys on bpi-r2

Suggested-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Josef Friedl <josef.friedl@speed.at>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
 arch/arm/boot/dts/mt6323.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/mt6323.dtsi b/arch/arm/boot/dts/mt6323.dtsi
index ba397407c1dd..7fda40ab5fe8 100644
=2D-- a/arch/arm/boot/dts/mt6323.dtsi
+++ b/arch/arm/boot/dts/mt6323.dtsi
@@ -238,5 +238,32 @@
 				regulator-enable-ramp-delay =3D <216>;
 			};
 		};
+
+		mt6323keys: mt6323keys {
+			compatible =3D "mediatek,mt6323-keys";
+			mediatek,long-press-mode =3D <1>;
+			power-off-time-sec =3D <0>;
+
+			power {
+				linux,keycodes =3D <116>;
+				wakeup-source;
+			};
+
+			home {
+				linux,keycodes =3D <114>;
+			};
+		};
+
+		codec: mt6397codec {
+			compatible =3D "mediatek,mt6397-codec";
+		};
+
+		power-controller {
+			compatible =3D "mediatek,mt6323-pwrc";
+		};
+
+		rtc {
+			compatible =3D "mediatek,mt6323-rtc";
+		};
 	};
 };
=2D-
2.17.1

