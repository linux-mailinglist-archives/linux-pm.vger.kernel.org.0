Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0352984D8
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 00:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420366AbgJYXCI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 19:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420347AbgJYXCF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 19:02:05 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51C0C0613D0;
        Sun, 25 Oct 2020 16:02:04 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a7so9461161lfk.9;
        Sun, 25 Oct 2020 16:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A4jvJLNRl5Rus88Pe6yoUdqX7U2UtFHR9HWnEH2FGao=;
        b=bWrAJRoIe/SdHvtJParQapNN61WM14ZwkxmpzYOvQ7MalOvTC+zvfOrTEv8WSeNwYR
         VgXbvPWi0s0pgdb4HucRveayHco8KLJy7mnsprPZIpz+c0jSVjVAE1XVwQ4fs2iYlVW3
         qfrqYozy46t+mtqBHdTE7a6KesxD7d1oa6Y63IpKsZ5detb7nm64cufHRMEqIXdW3Qpk
         iFmZtCO5+2o2j1Q7dUUGZzxN+byOyzpdePKInBdkHyLnK6IhzFY3JT6SlwDi3juYIock
         yVheL8zYPL6dfz7+9jvCRKqYB4jqJB+FlGPLLo62QSb94y/6sahEkKqONnPjueuhUJOd
         wO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A4jvJLNRl5Rus88Pe6yoUdqX7U2UtFHR9HWnEH2FGao=;
        b=BvQ3JBiclmTDxGKR7pzhGRSVS2usPlVcr6MzJdHB3MSKUNQXA/UEdhQdsHhIMI0odt
         BQqvbCEkApJCBQSNTXz+h9hSmVPUrVsRQkq5tWoIaPfvLqWlvHZZRUO6rXMK30tZyw1O
         7fr2h5oxcd/Ri/OKLUYtOYVTCdhm5QZe7hvocnp5fARHTL0kaDPNtV2mPXk1MZldyod5
         TF6uNlfTSCuJWuoDdfTJPRuDH2YuRY+WmO/5I99ZtHY4B2SJxTQKzCkAGuejKRKmL1LY
         2WIlSV78b93Y2GGqwxskzkBFSYeGjffMSu8zx81bYpXQXxsuev6tlu7m+GyWHPVlMATx
         3Zlw==
X-Gm-Message-State: AOAM533AAbD++Uan4njKcccd9F8n5hXZ7QFoU8Jtb3XzNmeyTnf4AjuS
        7NZNGAAICQyuQtqZsn9RKys=
X-Google-Smtp-Source: ABdhPJzFShGHnktOW5DkqTmDfBkPbAip5YSz6AMw9q3iufpT4y7RXw7iavuJlF/CT9O9q2/zxq48EA==
X-Received: by 2002:a05:6512:313c:: with SMTP id p28mr3742790lfd.310.1603666923476;
        Sun, 25 Oct 2020 16:02:03 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id j16sm949619ljh.48.2020.10.25.16.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 16:02:03 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 4/4] ARM: tegra: acer-a500: Add Embedded Controller
Date:   Mon, 26 Oct 2020 02:01:53 +0300
Message-Id: <20201025230153.11729-5-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025230153.11729-1-digetx@gmail.com>
References: <20201025230153.11729-1-digetx@gmail.com>
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
index f5c1591c8ea8..480a2221bf58 100644
--- a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
+++ b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
@@ -512,6 +512,16 @@ panel_ddc: i2c@1 {
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
 
@@ -794,6 +804,13 @@ backlight: backlight {
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

