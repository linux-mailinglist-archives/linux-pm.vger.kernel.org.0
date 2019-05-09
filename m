Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4BA81947F
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 23:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfEIVTl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 17:19:41 -0400
Received: from shell.v3.sk ([90.176.6.54]:45833 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbfEIVTl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 May 2019 17:19:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3FDCE104024;
        Thu,  9 May 2019 23:19:39 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lHpsRXzgKgYX; Thu,  9 May 2019 23:19:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0E1AC104025;
        Thu,  9 May 2019 23:19:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DaRgWoyjJULq; Thu,  9 May 2019 23:19:19 +0200 (CEST)
Received: from furthur.local (g-server-2.ign.cz [91.219.240.2])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C1D0310402C;
        Thu,  9 May 2019 23:19:18 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        James Cameron <quozl@laptop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH RFC 6/7] ARM: dts: mmp2: Add #power-domain-cells to /clocks
Date:   Thu,  9 May 2019 23:19:10 +0200
Message-Id: <20190509211911.17998-7-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509211911.17998-1-lkundrak@v3.sk>
References: <20190509211911.17998-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The power management unit, described by the soc_clocks node, controls the
power to the peripherals by the means of power domains with a single
cell -- the domain number.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index f02fb97f515c..8ad3e6673e1f 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -390,6 +390,7 @@
 			reg-names =3D "mpmu", "apmu", "apbc";
 			#clock-cells =3D <1>;
 			#reset-cells =3D <1>;
+			#power-domain-cells =3D <1>;
 		};
 	};
 };
--=20
2.21.0

