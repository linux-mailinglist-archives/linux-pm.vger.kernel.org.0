Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CB52B121B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 23:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgKLWt5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 17:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgKLWt4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 17:49:56 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC81C0613D1;
        Thu, 12 Nov 2020 14:49:40 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u18so10928669lfd.9;
        Thu, 12 Nov 2020 14:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aK7+Uow12DffvZAo4NEAmVyVnXleO87WAIYyYASIccY=;
        b=s+hrBoYajZcpg8vW5jbID66ikh/sLL9MufWJVWB1oRSIegQ0uvry+CVKlN2TJL61r4
         v9JZ1MdFoaOiCPsbDEGqRfflAyiGw6wyY2C4gGbhWiGch7gx6sR7fwQGkDvdPa2Es/v3
         pfPSnF/zwzIQQbcBeI5GjXIC8B50uNykm1YUjdbCmcuvBGVaePs2lMbw4YBH7cDcbe3L
         ZeJx/QYqVlYfopHDPpTqtrG3O+/Kys45/VLZYO1jhz8Ri2H2WhUsNC6jmt/YfMqRvp2M
         KdZ89n/Am97bIRJlFDGmZkDNU/hGwmi3s5Voky2CU3R3leg9aFUi4tkqa6bWb5bOHLn7
         uing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aK7+Uow12DffvZAo4NEAmVyVnXleO87WAIYyYASIccY=;
        b=jfArDet+r2hT/Cm/NflEzwynNJ6isTHsoy3hJPfB0+Ky6ETlgRky3bZjINWXeWb0Qw
         d94FdTtLGnBgwdTWXnSlnbCSAxeMOt3uL0GkS8WZVNGlGub0VdTflDKirNfuNueJwR9Y
         pxFaRwUN5SiVujDf9F6pQebT4lPaTtpMP6W4wb2gfEX4QRZ02oQ7x/EkNupdV+KYqDbu
         /vbyLuKSDpzu6LRyQkqA4U2B1ZXW+u9jQ8ZeLmdlHQMdc53C3BBz9s+ZjJz26d+Me9qe
         a3Fa770bafKyTFEjEmhqtTMrhBW4nL4AETkIHRIDHxxlEnhfYtRbU/xG/BdoA275aE/m
         cdjw==
X-Gm-Message-State: AOAM530dNCqSyEEHcxvUKkajfQwfuy0B3U8mb79hbGY1humAhq8j3a8c
        n5qA6lvWpWN6F4K7BgDA418=
X-Google-Smtp-Source: ABdhPJw+wIotxRLnXRScqM6tMbUv9ylmiyYmTE1XRiROX6r/EknFOxcy7uxwXO6q+p5DB8COzDkFbg==
X-Received: by 2002:a19:915:: with SMTP id 21mr683584lfj.528.1605221379469;
        Thu, 12 Nov 2020 14:49:39 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id z187sm1006536lfc.126.2020.11.12.14.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:49:38 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/4] ARM: tegra: acer-a500: Add Embedded Controller
Date:   Fri, 13 Nov 2020 01:49:23 +0300
Message-Id: <20201112224923.4028-5-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201112224923.4028-1-digetx@gmail.com>
References: <20201112224923.4028-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds device-tree node for the Embedded Controller which is
found on the Picasso board. The Embedded Controller itself is ENE KB930,
it provides functions like battery-gauge/LED/GPIO/etc and it uses firmware
that is specifically customized for the Acer A500 device.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
index 5ab6872cd84c..3b9ac3324fd5 100644
--- a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
+++ b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
@@ -533,6 +533,16 @@ panel_ddc: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			embedded-controller@58 {
+				compatible = "acer,a500-iconia-ec", "ene,kb930";
+				reg = <0x58>;
+
+				system-power-controller;
+
+				monitored-battery = <&bat1010>;
+				power-supplies = <&mains>;
+			};
 		};
 	};
 
@@ -820,6 +830,13 @@ backlight: backlight {
 		default-brightness-level = <20>;
 	};
 
+	bat1010: battery-2s1p {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <3260000>;
+		energy-full-design-microwatt-hours = <24000000>;
+		operating-range-celsius = <0 40>;
+	};
+
 	/* PMIC has a built-in 32KHz oscillator which is used by PMC */
 	clk32k_in: clock@0 {
 		compatible = "fixed-clock";
-- 
2.29.2

