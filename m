Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F6E25F04F
	for <lists+linux-pm@lfdr.de>; Sun,  6 Sep 2020 21:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgIFTv5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Sep 2020 15:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgIFTva (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Sep 2020 15:51:30 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADC5C061756;
        Sun,  6 Sep 2020 12:51:28 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d15so5546574lfq.11;
        Sun, 06 Sep 2020 12:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35wLUHHiL0jcYl7dr+ydbL6W/M+IENF1DgF9AQYM8t8=;
        b=Oobg5koT9Ox8v79M5WhWmKiVhX59pyNIUp9/wkzJHs3WGEBM3+96r9IBtOQktr1S/d
         QnHjBaLyyhA2oWdyy1KBBJULvt16SxQxcsaE/iUac+Eb1nPlamVSUD5vhGuXl5SSbe11
         TZKFDHVz7icmCrmH3fnIR4gwjbADsDpZhue2J8nRWMnKk8GLaxP9CRFnZYkgrqdS7emM
         hsUN+OmSZnxiSEnQaxJ+UBuYxlYjDMDKm9VHwRcoo8aogoVFWVLxtpwEftu4ChkP2XVe
         QejLkAIFhFCu6RS0q1Y+Qg1F1176Dk+blJNhugmazRt/Rm/1qHBqUZCSvCRB7YYCXLLq
         2B1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35wLUHHiL0jcYl7dr+ydbL6W/M+IENF1DgF9AQYM8t8=;
        b=c9xP2TlLGJoyHP4mb33u8AzR/THQCw4x4tEMJSQ/ohg4NAjWzasJ2ijBPg3sVZLEnS
         M3PrpEo0UFft78XjG2ibAVh69kUhI3eQRk9+ynYf8uBvLawASxOHm8MefOpDWzJSdeYD
         T1XkaZRU4JGwiCshBwKNjKO+03KSSh8YpA1Fz6PBn57JhSKVHyXIrPfB7XSd8OYPeitf
         3fklXST9RCehisA72W8qHUIs8zAMC0ZRQzrlHih8SvY5XMb6mhsqH6Un0zF42WoEl+ZW
         YO/XUT1PH1t9G1sufBIL8RVsoXDjrJfEw1IaHlMzLod8LWMjWli3MWmiVrABcnFl2Hyp
         vOOQ==
X-Gm-Message-State: AOAM533ciFEBd13uEkkpUafX5Y45NdVI6JqWXdIf4Xf7Y4XuL6ZIE3gE
        KrSpBSZOjX8r5qDU4hFBqyg=
X-Google-Smtp-Source: ABdhPJz1lqvoiCo/WdRrNpCNNEaDozq2pMzlNdc8l1vYlS76MU5hhy2Z1yaXF0kfHPjprP58FS8jTw==
X-Received: by 2002:a19:6411:: with SMTP id y17mr8719678lfb.199.1599421887058;
        Sun, 06 Sep 2020 12:51:27 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id b7sm4942574lfq.36.2020.09.06.12.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 12:51:26 -0700 (PDT)
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
Subject: [PATCH v3 5/5] ARM: tegra: acer-a500: Add Embedded Controller
Date:   Sun,  6 Sep 2020 22:51:03 +0300
Message-Id: <20200906195103.1347-6-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200906195103.1347-1-digetx@gmail.com>
References: <20200906195103.1347-1-digetx@gmail.com>
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

