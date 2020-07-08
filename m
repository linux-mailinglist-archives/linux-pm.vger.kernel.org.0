Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F09C218B5E
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 17:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgGHPeu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 11:34:50 -0400
Received: from foss.arm.com ([217.140.110.172]:47186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730028AbgGHPeu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Jul 2020 11:34:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDC281FB;
        Wed,  8 Jul 2020 08:34:49 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9C1083F237;
        Wed,  8 Jul 2020 08:34:45 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     lukasz.luba@arm.com, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        s.nawrocki@samsung.com, kgene@kernel.org
Subject: [PATCH 2/2] ARM: dts: exynos: Remove interrupts from DMC controller in Exynos5422
Date:   Wed,  8 Jul 2020 16:34:20 +0100
Message-Id: <20200708153420.29484-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708153420.29484-1-lukasz.luba@arm.com>
References: <20200708153420.29484-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The interrupts in Dynamic Memory Controller in Exynos5422 and Odroid
XU3-family boards are no longer needed. They have been used in order
to workaround some issues in scheduled work in devfreq. Now when the
devfreq framework design is improved, remove the interrupt driven
approach and rely on devfreq monitoring mechanism with fixed intervals.

Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index c76460b70532..967868cc8211 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -240,9 +240,6 @@
 		dmc: memory-controller@10c20000 {
 			compatible = "samsung,exynos5422-dmc";
 			reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>;
-			interrupt-parent = <&combiner>;
-			interrupts = <16 0>, <16 1>;
-			interrupt-names = "drex_0", "drex_1";
 			clocks = <&clock CLK_FOUT_SPLL>,
 				 <&clock CLK_MOUT_SCLK_SPLL>,
 				 <&clock CLK_FF_DOUT_SPLL2>,
-- 
2.17.1

