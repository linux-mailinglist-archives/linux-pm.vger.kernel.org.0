Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFC024ED87
	for <lists+linux-pm@lfdr.de>; Sun, 23 Aug 2020 16:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgHWOKZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Aug 2020 10:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgHWOKI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Aug 2020 10:10:08 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89BCC0613ED;
        Sun, 23 Aug 2020 07:10:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f26so6725602ljc.8;
        Sun, 23 Aug 2020 07:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35wLUHHiL0jcYl7dr+ydbL6W/M+IENF1DgF9AQYM8t8=;
        b=ViEZr59xlFFxHAnvxlgRZc5ssiXQT0tzUGBTDv4KYhMnBX4cL3HYXEhKeV4X6q53mZ
         Gsa/A5B34Coz+f9z5jB8hRMsbh4soP1UUqGjvUzx5WX4pYY38a2jEqINeekxEGxNq737
         ssRpEZ+FRFKBIbZ+lG7mUfRcSB+fFprInOdoEa+iUzJC1+WxIrnKAYPYLi93IZM9Bgsa
         n7TEZLWkHPo0eLDn4nv5HqsPKHh207111jOcsknhv2FJ/+MutqkNnR1I7GHpVXtTozHS
         2k2u5b9QlNVmBvtMMVzbXmWDlpolC4Omgsu+gPNiv7uQ1CoK04RG7d1TMg/gOeQneZ7Y
         kJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35wLUHHiL0jcYl7dr+ydbL6W/M+IENF1DgF9AQYM8t8=;
        b=TTxZehyuqs65e1M+axUL//z7yukLfnQkzsJ7DrQQrasBUC/fFCbbsu2NSrKsJ4b8nZ
         2qmd1rkGpekQN/QYkgjMw3949T7VnbpMWznhBjCnVCLGHWtKUJ++HywlT4H2AZJnHOLa
         vaJpNXKbWHqYPvFEUqAmJRCVGZ5tNhhBAUv3eQ7vja0Mw0Dl4vnTQcQejBkEw2OJv2cq
         uNZ2UKS1pPE6f34xhXcmA46e1YsmABJjJXRFOTKIudwLsNp4ofLRL63WUvFXcX0mEMOT
         QXxLscGder8cCHhTMKCvzusrAyvXFy0qHDhevo3jXMgbEFm4j7kwsyR87i22+PRmz3Rm
         hn/A==
X-Gm-Message-State: AOAM531BfQkNz1DfAiwfdamGYeM9+VwLVTLmLo86ik7hQUak+r09Lz6V
        rkg3F8PCNttHq3oWq9eTYEQ=
X-Google-Smtp-Source: ABdhPJzU2EqrkTFmH1289oQBf1AS7N5fRURLGWkSQCB7ihkYlFD87c3JcUWU8O9Fzhze9kCZLws/Lg==
X-Received: by 2002:a2e:9557:: with SMTP id t23mr676484ljh.85.1598191806202;
        Sun, 23 Aug 2020 07:10:06 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id b17sm1641342ljp.9.2020.08.23.07.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 07:10:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/6] ARM: tegra: acer-a500: Add Embedded Controller
Date:   Sun, 23 Aug 2020 17:08:46 +0300
Message-Id: <20200823140846.19299-7-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200823140846.19299-1-digetx@gmail.com>
References: <20200823140846.19299-1-digetx@gmail.com>
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

