Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CB52A6ED6
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 21:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbgKDUeY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 15:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732126AbgKDUeX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 15:34:23 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB4BC061A4A;
        Wed,  4 Nov 2020 12:34:23 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id 184so28913432lfd.6;
        Wed, 04 Nov 2020 12:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WKT9yCY9G74xRdzuzOYreE2TSI0A3c590q95kWmR0gE=;
        b=lqP2jOnXcgZ6lV2k7SBWomSKz8TeVPz1pFaKDBUJm5I/18KOvwsyxHwpjbZ8evWEH8
         ON/9H9C/B6D6NyubgDCOKi97Bw+fzHN3rqHvbhYgmZ6+eFW5d/A+3N3xc3ciOif9Jc27
         ENGVDjCemHkSLOZK2SPQymavs6t0eJDA6hQK4cEYyhGy0pNesU2i0YNKtib6JFlkC9vH
         I0uu67iQv+8e4GwX4emfW3InNs/kXiTquqBmH2qO0yICRnJm+wqbF83s6FS2WNcTFCHb
         EM42NcwvZSbYEWWqeMhOQSI0l5pFGZe1UU2jIAMecogW0tEZyMdm3OQTkXCleH6h8UEU
         5/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WKT9yCY9G74xRdzuzOYreE2TSI0A3c590q95kWmR0gE=;
        b=FOXjS5EM4SHQCbzbvuCbYzJTYhXtgIfdDhdIHbsfLc6phqUFmZIHBnQtDP2+z0eS2Y
         Wj+Fr+wgycursTIrx8r/V01nuhTq4/rAy1S8SEBxwAmW1EAqPBkOF1UOWxWiiNbv6JMS
         k8F+nFeYWCERiapxggAGPHAgRd3qIaDpp48JvqqeF6P9yWq2383P8ZNfNkIAVixtFTKA
         8vnsiOiFSHTRTTkw+DbAPX9MNyPAMtLJsUtENFSGV4JyGYDiG5d37YIeDzB4BG4fADGY
         N3LiefQjIQTp5wK2LDPcOnSzXa+pvGlCE76nkTSmVVPIIUs3yH6Ydy9FR84jvxvjcDN5
         oYkA==
X-Gm-Message-State: AOAM530XseWZ6TDY/AlkReXI2HXAA4B4xygZikmgacn4LDAjyPK73BLG
        wGL2EIYlhwI0bo9Rb0X1mkg=
X-Google-Smtp-Source: ABdhPJzfD7jLtgKzs4Af7JCwmX7xio1vG47w4LofjydiYDgTi8aU+pacgbFhucTbGOw6yRfrID0l2w==
X-Received: by 2002:a19:f605:: with SMTP id x5mr10315928lfe.39.1604522061646;
        Wed, 04 Nov 2020 12:34:21 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id u22sm615084ljk.45.2020.11.04.12.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:34:21 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] ARM: tegra: acer-a500: Add Embedded Controller
Date:   Wed,  4 Nov 2020 23:34:03 +0300
Message-Id: <20201104203403.24937-5-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104203403.24937-1-digetx@gmail.com>
References: <20201104203403.24937-1-digetx@gmail.com>
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
2.27.0

