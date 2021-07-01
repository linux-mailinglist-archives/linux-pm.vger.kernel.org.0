Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644413B9945
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbhGAXbh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbhGAXbZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:25 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56785C061764;
        Thu,  1 Jul 2021 16:28:53 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id r16so10775619ljk.9;
        Thu, 01 Jul 2021 16:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7DlDGeRQN/MpODoteOvA0zQ5PJl1CPsSr6wfFsEQXQI=;
        b=fHvOG+ZDiSFiPbL5tTNx/jL7B1hz+Va3DehzVnK1Nus6WzgC9GTr0xedGjgSjRf5wk
         yzoOdQcOY8qDHw/RfN3o14rVa6iFAGAN6lWEOVvaqwb8pZoL6P6kM7TZP/mNmK+af6V6
         9q+CLH2UMSV7C6EKa959WjR25a6kPkfTEWRZX67wiS0qoLNrv1OJe3n61nkt6qs42ilh
         fieQobb4DAw0XsE2qHBNlfY6qKXD7E0py/9l/XgSk8XGIIswMKEj409Rvv895ltcZ2fK
         pozwsUDC5VBjKtvt3V8ozRYC1129ifF+tvFdctsawflq4PuRy5t4sX9BkKneygD0tF+K
         gbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7DlDGeRQN/MpODoteOvA0zQ5PJl1CPsSr6wfFsEQXQI=;
        b=A8EA5MZeJSpemoTJAVG3rMb7KS194o1ZQwDA2J/PdBQc12N6lwhEqkCiQks4UIj4Pf
         7YtfyVxEabm2e4LdeJkXnEFcUKh3P/+VAafl1rz0aNwYWu+Gu643KL9ud+bRdiSp++K0
         gp+GHS9lbt/i/JyFeKgwjv/AVAXjrJXzG/vTd5JoYYrUld2T3pOqaxGlU+1B7DC5xOOf
         Pf7Moxqqwji+VWcBY22WRLCDSa5TXoJEEq4CsTHa1MACPS/qlYxteN1xFLaG1OnkKnLR
         oghQpyxFWj4zRDdRCDsR/DMXR7NfH2Cynn7ziHU0UrkD7i/Uqa4RfE3gJzARZdWyaZ2F
         /3sg==
X-Gm-Message-State: AOAM530nJVpeN83vga7WXsUBW55r/r5LV1lM0LqdmvwuLRGY1HPjg/M9
        rWKWbt2s50wqQRqKS2BLndU=
X-Google-Smtp-Source: ABdhPJxwGVy+Ts9x1soJKaWZkNX/IC3YXoILTbuNvT5pOX36Aj2zB7vePlbAPnf4+cR1f38o0HpFkQ==
X-Received: by 2002:a2e:5811:: with SMTP id m17mr1506999ljb.59.1625182131742;
        Thu, 01 Jul 2021 16:28:51 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:51 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 36/37] ARM: tegra: Add Memory Client resets to Tegra30 GR2D, GR3D and Host1x
Date:   Fri,  2 Jul 2021 02:27:27 +0300
Message-Id: <20210701232728.23591-37-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Memory access must be blocked before hardware reset is asserted and before
power is gated, otherwise a serious hardware fault is inevitable. Add
reset for memory clients to the GR2D, GR3D and Host1x nodes.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 6e760faaff29..9a9292e31e9f 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -122,8 +122,8 @@ host1x@50000000 {
 		interrupt-names = "syncpt", "host1x";
 		clocks = <&tegra_car TEGRA30_CLK_HOST1X>;
 		clock-names = "host1x";
-		resets = <&tegra_car 28>;
-		reset-names = "host1x";
+		resets = <&tegra_car 28>, <&mc TEGRA30_MC_RESET_HC>;
+		reset-names = "host1x", "mc";
 		iommus = <&mc TEGRA_SWGROUP_HC>;
 		operating-points-v2 = <&host1x_dvfs_opp_table>;
 		power-domains = <&pd_heg>;
@@ -186,8 +186,8 @@ gr2d@54140000 {
 			reg = <0x54140000 0x00040000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_GR2D>;
-			resets = <&tegra_car 21>;
-			reset-names = "2d";
+			resets = <&tegra_car 21>, <&mc TEGRA30_MC_RESET_2D>;
+			reset-names = "2d", "mc";
 			operating-points-v2 = <&gr2d_dvfs_opp_table>;
 			power-domains = <&pd_heg>;
 
@@ -201,8 +201,10 @@ gr3d@54180000 {
 				 <&tegra_car TEGRA30_CLK_GR3D2>;
 			clock-names = "3d", "3d2";
 			resets = <&tegra_car 24>,
-				 <&tegra_car 98>;
-			reset-names = "3d", "3d2";
+				 <&tegra_car 98>,
+				 <&mc TEGRA30_MC_RESET_3D>,
+				 <&mc TEGRA30_MC_RESET_3D2>;
+			reset-names = "3d", "3d2", "mc", "mc2";
 			operating-points-v2 = <&gr3d_dvfs_opp_table>;
 			power-domains = <&pd_3d0>, <&pd_3d1>;
 			power-domain-names = "3d0", "3d1";
-- 
2.30.2

