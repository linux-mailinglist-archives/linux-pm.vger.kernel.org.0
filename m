Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030D72B5188
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 20:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbgKPTsk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 14:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730270AbgKPTsj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 14:48:39 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC88EC0613CF;
        Mon, 16 Nov 2020 11:48:38 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id r17so21500883ljg.5;
        Mon, 16 Nov 2020 11:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vPNjoYNRStRNwZP0NAyFtfDW7IEy6fPv1BNAKkfHQ8M=;
        b=PWRkUGRPFi5Tbx+qKEh9/3wx25dNdFlpMiI9uvWyXTfrA6mRGvyt5y7zRpv6V9VACh
         OGMxWi0wgitEifNzuoovwar78dOWUowL827NPMH4PWMe+JKyqrV6L5ojdFTYQ9XfB0Ph
         ggWI3yJ59PsXwifg/WJOrAABfe+1/YW9+IGbxLoxDy142wpBZd00wH9TfR7sRg1QUTXY
         a6q7QBwWExb3ec/Dv6ICs/YqURlR2rG5EhAFOS5/+SzKervuimUvro1qnGp9zmQA7brD
         jWJmg2Da/NwHhIBi4/mkJaZOnhF6F/f7DY9zB/EJBRUYcEBtBqaFL//TcnHUfyAHaKnL
         ftmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vPNjoYNRStRNwZP0NAyFtfDW7IEy6fPv1BNAKkfHQ8M=;
        b=SaJ6UVebr7Ku6AxxFohYUwk2T/6Yqh5dqxqvT2vW8kZbryFDG2dul78PxhPrFJN8ms
         mQDK6d+uM+qI6sKW0lIYuCN1IhemXJgO1IMJt0zNDd0PDpWH2YCGcTQTWEcFl4Vridz9
         PL7CxOwSMkWMpROrkKWtLp/7B3nGz+xYJgsE7SE7Bk/xZX3LsNDdPLRIXy05Rpbb4gnJ
         63p4nU+L+ZcSPlL90p7S6eGGs5lrPE9sAy/MVqp2qzZb67jG8g/Qx+5GzNuhmdiiGzsp
         YPJw4NPhUdqCrnggmDO6S5jLN65Pfqc68gCrP9R132oBpqC3+Xl9o+tfIAZNZO9as7pa
         qPmw==
X-Gm-Message-State: AOAM53051kETy185HxvslFIH/V4xHu2Y73oqcMsdvl5tPZ5WJ9i6YTR2
        oXxJOFjdemkNtQ9B/+deKKQ=
X-Google-Smtp-Source: ABdhPJwuOfvzBZ8yauT6UvhVmlPOY1t9vDAgwLceAF2NQgh7qqxo8hzr/SlGRLFK+MsJGyD+VqiNEQ==
X-Received: by 2002:a05:651c:2c1:: with SMTP id f1mr348925ljo.192.1605556117444;
        Mon, 16 Nov 2020 11:48:37 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id n5sm2864286lfb.306.2020.11.16.11.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 11:48:36 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/4] ARM: tegra: acer-a500: Add Embedded Controller
Date:   Mon, 16 Nov 2020 22:48:27 +0300
Message-Id: <20201116194827.28947-5-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116194827.28947-1-digetx@gmail.com>
References: <20201116194827.28947-1-digetx@gmail.com>
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
index d9ef3857ba03..1da3bcc8003e 100644
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

