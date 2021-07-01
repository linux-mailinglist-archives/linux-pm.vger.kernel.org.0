Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68833B9941
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbhGAXbg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbhGAXbZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:25 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B876DC0613DB;
        Thu,  1 Jul 2021 16:28:52 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bq39so2194653lfb.12;
        Thu, 01 Jul 2021 16:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NX5XfOJ+Q5sUTZVNUd7/PeWSVKs/mVtsxulWvZRzxd8=;
        b=E353Dp0JJ22AL0IjCR7JgDQmqW05cjbiUJCy4WOJtQS7EvfWf5k0ilXv7k+mB2giUQ
         6wDuPRD3cb61ZTIdw5cFBeULwqRLJ7Q/KyBPJezaUHuwRbShp4PZuf+84t+tjYqxu7hx
         MBrR//AynxwjzyTvHiFcInYY/vV97EayZCzkKe+X56Q8DURrIfSttU+/pAv/8QQ4INAZ
         1xCxcoW1Bc4DP2HapvlxGQtnTVxpEZxZh18H+d1O9jIW/MYMqh8hrjAoE/TRumAI5REw
         Zu5Y5by60kMqTayZWlexNCp6xSnxs74ijEelBT2BvvYYswjoMDTqf3sTMHmFSgVA06V2
         T9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NX5XfOJ+Q5sUTZVNUd7/PeWSVKs/mVtsxulWvZRzxd8=;
        b=MDIa4pgIpLzynpCmvUag3hv5WUpyp5oCNgVkjds04sM7DBOY56hdfXyHbcuS/KcQs5
         LQJceM7N62nctFd+sj48Y5UuCdQ5omixycUqYnLNBE7XXgtstS7Q9lyNeXnx3bJ7STtb
         jRei+eN51nPskQfp5MfTPQxvVIIgHpzTQCGJNhJIhLCQT85NyVgluuydQWY7eb+J+Oqd
         4sPuzewaXRlHp7MROjSNPI3mx9itmC5bYChQ0xhGD0YLffJqqfTI6MMN0++9lDNG0bWN
         QlniGE5AnRcv26Qjv6HJH9lYTgfwp8VDfTyWqoXQGqNBWzQME+AvmdLz8cttAexxBvwL
         T4gQ==
X-Gm-Message-State: AOAM533cAcEr+fh3t0K0s0l65HRpM0Pkk9LDoTO/DCmOnYZ/VfkCnmHB
        XueIBvF2QzDpnF9PiVYemFM=
X-Google-Smtp-Source: ABdhPJw880sBvIveq+PvwqG+POLL2Q8OipwRITC3zVTghfuyWBHmbotb6arU4CXDahM65Zn3PRpJNA==
X-Received: by 2002:ac2:494e:: with SMTP id o14mr1537472lfi.399.1625182131147;
        Thu, 01 Jul 2021 16:28:51 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 35/37] ARM: tegra: Add Memory Client resets to Tegra20 GR2D, GR3D and Host1x
Date:   Fri,  2 Jul 2021 02:27:26 +0300
Message-Id: <20210701232728.23591-36-digetx@gmail.com>
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

Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 5c74cc76b5e3..2cb31bdd9eea 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -40,8 +40,8 @@ host1x@50000000 {
 		interrupt-names = "syncpt", "host1x";
 		clocks = <&tegra_car TEGRA20_CLK_HOST1X>;
 		clock-names = "host1x";
-		resets = <&tegra_car 28>;
-		reset-names = "host1x";
+		resets = <&tegra_car 28>, <&mc TEGRA20_MC_RESET_HC>;
+		reset-names = "host1x", "mc";
 		operating-points-v2 = <&host1x_dvfs_opp_table>;
 		power-domains = <&pd_core>;
 
@@ -98,8 +98,8 @@ gr2d@54140000 {
 			reg = <0x54140000 0x00040000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA20_CLK_GR2D>;
-			resets = <&tegra_car 21>;
-			reset-names = "2d";
+			resets = <&tegra_car 21>, <&mc TEGRA20_MC_RESET_2D>;
+			reset-names = "2d", "mc";
 			operating-points-v2 = <&gr2d_dvfs_opp_table>;
 			power-domains = <&pd_core>;
 		};
@@ -108,8 +108,8 @@ gr3d@54180000 {
 			compatible = "nvidia,tegra20-gr3d";
 			reg = <0x54180000 0x00040000>;
 			clocks = <&tegra_car TEGRA20_CLK_GR3D>;
-			resets = <&tegra_car 24>;
-			reset-names = "3d";
+			resets = <&tegra_car 24>, <&mc TEGRA20_MC_RESET_3D>;
+			reset-names = "3d", "mc";
 			operating-points-v2 = <&gr3d_dvfs_opp_table>;
 			power-domains = <&pd_3d>;
 		};
-- 
2.30.2

