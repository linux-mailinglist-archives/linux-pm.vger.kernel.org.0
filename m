Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF8A2D790B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 16:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406603AbgLKPTG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 10:19:06 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:18491 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406591AbgLKPS4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 10:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607699748;
        s=strato-dkim-0002; d=fossekall.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:
        Subject:Sender;
        bh=eA/nPOAHzqmp6YXCMxnHkxADrYvcNgG9l7Sx0rNGYJg=;
        b=Wf9kCJ3aitc064dDCZAfAl3fcpRgfkTTTeBJCj/n/oCvlcDxKYUjcFl5ewpvUWyxP/
        /h0+jFqwu0SzUuNLDlZco6J8ZhUknA05AD9dMZ/R51augEoEQ9Eb+qHLV0EU/fDWRKEV
        ZqsKc1GRGx0NatHSGq9VokkrtMpQ5iEzrj1GYnmy0aO4jYNI6nUq0q6/ujrrttadDX2Q
        +CLU1JdOvCHYYwvGSVoIMV1bvN5NzwnjoZFW0IBqH7YSY50iGSZufS+eQLfg4tAmNQxC
        xDUxx4IVaP2OG8I2MbfNfB8p7OlOTas6Li1fyQBgpZGI3UHHsKQ4zk6Q0U+FmorKMvdN
        9pVw==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.7.1 AUTH)
        with ESMTPSA id L0a6acwBBFFk1A5
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Fri, 11 Dec 2020 16:15:46 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1knk8L-0005SH-0X; Fri, 11 Dec 2020 16:15:01 +0100
Received: (nullmailer pid 116047 invoked by uid 502);
        Fri, 11 Dec 2020 15:15:00 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Klein <michael@fossekall.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 3/3] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add poweroff node
Date:   Fri, 11 Dec 2020 16:14:45 +0100
Message-Id: <20201211151445.115943-4-michael@fossekall.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211151445.115943-1-michael@fossekall.de>
References: <20201211151445.115943-1-michael@fossekall.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add add devicetree information for the regulator-poweroff driver.

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
index b43028f9e6df..f8a7b1371e97 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
@@ -86,6 +86,11 @@ reg_vcc1v2: vcc1v2 {
 		vin-supply = <&reg_vcc5v0>;
 	};
 
+	poweroff {
+		compatible = "regulator-poweroff";
+		cpu-supply = <&reg_vcc1v2>;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
-- 
2.29.2

