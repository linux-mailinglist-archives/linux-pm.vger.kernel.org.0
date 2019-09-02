Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1891A5497
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 13:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbfIBLB6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 07:01:58 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.104]:26823 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbfIBLB6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2019 07:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567422116;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=gyaJxhpKOrJkSBef5H5LmgKUYEaxN9j94o+XGsFhaN0=;
        b=U2ZNL5KIJTn3EuJZkoVEh2sN5c5ozIftt4VHxQZhRPSLdswm0ZoH/tsUy3ifljBQA/
        KEkBXDccmP+S+bG3dL4WhEWDApnUILDwM6RVFjdjp172FdyPlYELnUZTn2pmvt6GkRNZ
        +ruDzCmM9tK8B36OZQFocypQC0nxPxRmGDFmVHfwaaRgyf4zph5iSzMmegANphriHrK+
        PaN0Gsmjr05P5Spt70iUyiZdB1MQur+8aApxEX2tIrsSzv5UZExMVipSgZCasdeOVQld
        oAOt+3EQS07veue/5D6snIQtfjCnp9n2wiMvqvT/9e0/TtEuhj2Md6QbNk/aFls4u7vi
        Fxdw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXL8GTnvuHRT"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v82AtsPvm
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
Subject: [RFC 5/5] ARM: dts: omap3-beagle: make explicitly compatible to ti,omap34xx
Date:   Mon,  2 Sep 2019 12:55:51 +0200
Message-Id: <150eb34a95b2e7ead8ac81a9ab275592ea31595b.1567421751.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1567421750.git.hns@goldelico.com>
References: <cover.1567421750.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Matching the ti-cpufreq driver needs to specify explicitly if
a board uses an omap34xx or omap36xx chip.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-beagle.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index e3df3c166902..d47213c7a4d0 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "TI OMAP3 BeagleBoard";
-	compatible = "ti,omap3-beagle", "ti,omap3";
+	compatible = "ti,omap3-beagle", "ti,omap34xx", "ti,omap3";
 
 	cpus {
 		cpu@0 {
-- 
2.19.1

