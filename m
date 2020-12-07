Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1313A2D13DB
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 15:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgLGOhN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 09:37:13 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:34404 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgLGOhN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 09:37:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607351661;
        s=strato-dkim-0002; d=fossekall.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=3BsUH/fQnBe7pD71RIvs7F5DD1I9z0fShCsbyNynJq0=;
        b=PB6dpzkAi1Efzg8/cIY4BGahytqfkHH7KmbLXGasVYgIQuWslia8mInyt+6cK17XPY
        iwe7EIEd/TzzOUM8zyCzLAkcBxCROCbb63hGOTGEHyIdBpLw0CfNXEmzajYEAlgjMAGe
        YQeCrvsjYauZAxwR16tW09F/+QoOyPY7LtySEBQBiDVCeCrMtBwGZs3a0M+xIMRiQSCl
        FQPSb+LdACzxnmh6cJV1VOtQerxFzuSexxtiRmibXWIulALnkZo3DoXaSxTJYjMQEeUc
        m1bMeJRem7lQNqppnIhTffoO1o+GDDPVp1uPvT0NtGSh2i6w8kepDmYRno++JbZ5Ytgl
        w3wg==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id g02087wB7ESDOVd
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 7 Dec 2020 15:28:13 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1kmHUh-0001TR-PB; Mon, 07 Dec 2020 15:28:04 +0100
Received: (nullmailer pid 17921 invoked by uid 502);
        Mon, 07 Dec 2020 14:28:03 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Klein <michael@fossekall.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/3] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add poweroff node
Date:   Mon,  7 Dec 2020 15:27:56 +0100
Message-Id: <20201207142756.17819-4-michael@fossekall.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201207142756.17819-1-michael@fossekall.de>
References: <20201128103958.q6glewhhch7vtczr@gilmour>
 <20201207142756.17819-1-michael@fossekall.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add add devicetree information for the regulator-poweroff driver.

Signed-off-by: Michael Klein <michael@fossekall.de>
---
This patch depends on the regulator names added in
https://lore.kernel.org/linux-arm-kernel/20201130183841.136708-1-michael@fossekall.de/

 arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
index b43028f9e6df..408c6e581700 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
@@ -86,6 +86,13 @@ reg_vcc1v2: vcc1v2 {
 		vin-supply = <&reg_vcc5v0>;
 	};
 
+	poweroff {
+		compatible = "regulator-poweroff";
+		regulator-names = "vcc1v2", "vcc-dram";
+		vcc1v2-supply = <&reg_vcc1v2>;
+		vcc-dram-supply = <&reg_vcc_dram>;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
-- 
2.29.2

