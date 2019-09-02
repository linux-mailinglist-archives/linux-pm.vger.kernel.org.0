Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D58A549D
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 13:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbfIBLCC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 07:02:02 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:35040 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731329AbfIBLCB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2019 07:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567422119;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=066Rqa4dJD1flQL69Q2YCPKoI7wVEYGXrGAi/IMoM5o=;
        b=VgUj7rtVtiDphB2L8ElVhLc59WU7l8lpSvsAWq5sS5MzmuuMQLlVQ7rPMw8ZTRWLhu
        1pAKdXMA3tjl7U2oAC4JU0JqiAA/8NV60sUgLtERyVDTK995xIDVL771VU29Dx6M4/rV
        KsjeHy1XRbYIjuyaTIOfLlFfTwKu/2q586Q2SqvIuQ//Nf8W+nn2t2zp7RKqHerMiNcl
        VZpaMVfB/gy7rwI6voKpJg05ncq3cNAvn94xRQj+ouJzs0HxZtw/+v/A4wQRXappTh6K
        I8sKZmaZNjBXoZw2d0Y2rkA3KrbhzGgO3XgI+mZ5f97mmDLT0rRNECosYa/ZX0Cmmc68
        JSYg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXL8GTnvuHRT"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v82AtsPvk
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 2 Sep 2019 12:55:54 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC 3/5] ARM: dts: omap3-evm-37xx: fix compatible from omap3630 to omap36xx
Date:   Mon,  2 Sep 2019 12:55:49 +0200
Message-Id: <ed0a59b81da33ec0989cffb94b07091f95c4927e.1567421751.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1567421750.git.hns@goldelico.com>
References: <cover.1567421750.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All other boards use compatible = "omap36xx".

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-evm-37xx.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-evm-37xx.dts b/arch/arm/boot/dts/omap3-evm-37xx.dts
index e0c0382388f0..311550ee4eae 100644
--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "TI OMAP37XX EVM (TMDSEVM3730)";
-	compatible = "ti,omap3-evm-37xx", "ti,omap3630", "ti,omap3";
+	compatible = "ti,omap3-evm-37xx", "ti,omap36xx", "ti,omap3";
 };
 
 &omap3_pmx_core2 {
-- 
2.19.1

