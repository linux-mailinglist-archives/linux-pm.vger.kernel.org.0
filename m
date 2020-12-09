Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590BA2D4C7E
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 22:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgLIVHb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 16:07:31 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:30980 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgLIVHJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2020 16:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607547841;
        s=strato-dkim-0002; d=fossekall.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:
        Subject:Sender;
        bh=NqSRvZmXP9PQBEFmL813QTyuyX+x4I8VQ7BF3N0lRnc=;
        b=FlSl3ciK9k9TFj6Ok0hq2QspNA3KG+LLRBcosBjARemTsukPmL73Sk7Ddn0+uNCgWV
        SjM3mfQfdHSOFayx7o97YWyTD/zY/oczaHsLUrmCCNobY+8Dj8mCiPX58R0MGYoerE5q
        GRQ7tBemnJIUffiOwxRacZ4YC1k5tFXt41mbwL3BU1POmB1teks5ltKrH3dME7xkUzej
        Pla1PnSOpv3O/wg+zyzOcBE/jdk/Pmm3gtmVeagTst1fKA1XvVxd6ku60sQw/2v8yuBX
        61Ml9TwL0b38W3iceipES+cYum2JPBsBdBWxtJrD+r2KaoYWlt/eQLtSTpJoxS1juNJS
        7yDQ==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.6.2 AUTH)
        with ESMTPSA id e07b38wB9L3tB2j
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Wed, 9 Dec 2020 22:03:55 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1kn6ck-0008Cn-Nb; Wed, 09 Dec 2020 22:03:46 +0100
Received: (nullmailer pid 385371 invoked by uid 502);
        Wed, 09 Dec 2020 21:03:46 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Klein <michael@fossekall.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/3] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add poweroff node
Date:   Wed,  9 Dec 2020 22:02:21 +0100
Message-Id: <20201209210221.385188-4-michael@fossekall.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209210221.385188-1-michael@fossekall.de>
References: <20201209210221.385188-1-michael@fossekall.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add add devicetree information for the regulator-poweroff driver.

Signed-off-by: Michael Klein <michael@fossekall.de>
---
This patch depends on the regulator names added in

 arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
index b43028f9e6df..e7370a049ce2 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
@@ -86,6 +86,11 @@ reg_vcc1v2: vcc1v2 {
 		vin-supply = <&reg_vcc5v0>;
 	};
 
+	poweroff {
+		compatible = "regulator-poweroff";
+		power-supply = <&reg_vcc1v2>;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
-- 
2.29.2

