Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64261256FE5
	for <lists+linux-pm@lfdr.de>; Sun, 30 Aug 2020 20:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgH3Szp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Aug 2020 14:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgH3SzL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Aug 2020 14:55:11 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D187C06123A;
        Sun, 30 Aug 2020 11:55:10 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r13so4297888ljm.0;
        Sun, 30 Aug 2020 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35wLUHHiL0jcYl7dr+ydbL6W/M+IENF1DgF9AQYM8t8=;
        b=uhimOhHNcVOop7DdL+0642zRtqUW3EjZYZ87OCM4VJnKnP2te6EhR+DxcP+EcdN34A
         Lcz++9haTnvEtJqJzHCsDt3XFecw2X6iOen/xKTWsHySnYpSNJ0a9Km44cg9zb2S7oyo
         QZcgxgYF4bEpZYp6xNwe+RjEq2p5iRN6eFxptoYVp4TEqXy/8BJx3Qr0RYp2YrJBNIgY
         AqqsVwyk78Zhynvb3hsUsg0UpmHWdXHgp6Rjp+WGKAXK9YkYnkmYnkirGvTa15l3uYXO
         bHswcbkZzCMoTIWDCE4PzeXv/Jfwt19sFvMB1tkoOSjyrEzxNkwtfUBb6P1fZFExaVjp
         Gcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35wLUHHiL0jcYl7dr+ydbL6W/M+IENF1DgF9AQYM8t8=;
        b=ddRhFAchFJxqSpkfAo+OaXoQopqQGKDQ2zXavacgz0kpAeZlarcPoxKvt6EeDvpDM7
         DfjGs8Ai05AI/QnjCkaZi0RBKydd1VfTs2fxPF17XjLk5FqBgvbrJmX7WL6T4YGANBo2
         OpjslSSu7mCJj1/HLgVRgfWi2eKee2ARFHSFW7+MGe63CQSCZo4OmQJpHNUvSUFM7jah
         rGo7UAlzzGIpG58Ha2mUGU6YPMsdSaEuZh7Ou/qkC+UIuphFMgGNOF1zxW7rke0wIJQG
         DUUqNqxNUOR8a6PIApEVmOV/IDfyiiMp6/b3IxctuIi/VELi1m4w1k5NOwrdvIpKSbrk
         M6cQ==
X-Gm-Message-State: AOAM533tWsOQSgpxFpQ0szujf5AiXaHsqH2LALdGRZwm0as58cE15lW5
        CvZdNM3LOD6lsiwapVXGF0o=
X-Google-Smtp-Source: ABdhPJw+xY56U8MvvQE71DOroKATcepLQ64qhNh+AUcrFIbij52qmH2rMpKZ3ooqNrrNB0swam8nRQ==
X-Received: by 2002:a2e:8046:: with SMTP id p6mr2514730ljg.372.1598813708857;
        Sun, 30 Aug 2020 11:55:08 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id n21sm21630ljc.89.2020.08.30.11.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 11:55:08 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] ARM: tegra: acer-a500: Add Embedded Controller
Date:   Sun, 30 Aug 2020 21:53:56 +0300
Message-Id: <20200830185356.5365-7-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200830185356.5365-1-digetx@gmail.com>
References: <20200830185356.5365-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
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
index 2d683c9a1a5d..f92712e4bd34 100644
--- a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
+++ b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
@@ -502,6 +502,16 @@ panel_ddc: i2c@1 {
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
 
@@ -780,6 +790,13 @@ backlight: backlight {
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

