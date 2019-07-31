Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0A07C0E1
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 14:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387510AbfGaMOd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 08:14:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41400 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbfGaMOS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 08:14:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so66204687wrm.8
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 05:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3CCOCjh2x1iQPGlZN3jIo89XnZKXDURAKwx788VT6WA=;
        b=konqN/tSWn5MnRNaHXWCAuACoPQk79+SeUDGVfuNUSYGAy6R13WPzZcwC/9viSy9ZC
         uiBR0TN5rc3akffhBkgRd7o78J2XiETILJxUH1Ctr4biflUhUKSphigwbyX08uSaQAKN
         SpV+/OeKHwEm119YhMP4Wrlmn6ueB2rRj0/JZ04ZBuuu7X92DNKTlFqO/o4/Y2F8MKJ/
         u5u1P/QG/2a8RNDnEBPFP9wLkR+hhRpLdM2IRvrQ1JhifwRh7xz4wt+ByVgkKH+VwDFL
         O6SdN9yX46kRY0aZ3UCVxKwh1pe+TDeIVmJ2/qQfDPfT35db9g4qTrHr4OKmx+4Owqn7
         wi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3CCOCjh2x1iQPGlZN3jIo89XnZKXDURAKwx788VT6WA=;
        b=J2YAjQWOFHRi8n3YBLMw1ftGranR6pT2wiZrBMvMdl8RHlQOCg049xwQf4Vu4TWfPc
         Kk/gzA0LxmSap9DqoORje2XvAJbjSxJFuYQcCsTaMOsDODNZvmaV5OlbtmQcpXyJK7wk
         c4qzUVGnX5zfX3ULgNf7jSJxzQVeyoYV965SXMfQV4DW+U1kYTq17lm9OaarXfMtCPvJ
         l6umnRid2t8Bxny03TkqP6JW+MYdPE/JriN3IHGqP3E9D4hAMnhGkpK55FhMYW+0pn4P
         u3IPP9BcTfjINiu7NwCwQibGnjc7lZa8joLFSBrUL81R3P011c4qY/FZrzxo2rLjCKJb
         /inA==
X-Gm-Message-State: APjAAAXyAX+zXqd3y9tl3XgEr1rz51CkKE+9XSrQqWyb0QBXMAGp05s3
        Ju9qcWi6UaS2rRynok31AFmSYQ==
X-Google-Smtp-Source: APXvYqwrOzBQ/vplwh9sXRThCJ+igArUJU9XiT1VUFIdwNGAU5J1RHqwjHxq4gdna2QH4jynKhdhPw==
X-Received: by 2002:adf:f812:: with SMTP id s18mr5128298wrp.32.1564575256188;
        Wed, 31 Jul 2019 05:14:16 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a64sm3613713wmf.1.2019.07.31.05.14.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:14:15 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/6] arm64: dts: amlogic: g12: add temperature sensor
Date:   Wed, 31 Jul 2019 14:14:06 +0200
Message-Id: <20190731121409.17285-4-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731121409.17285-1-glaroque@baylibre.com>
References: <20190731121409.17285-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add cpu and ddr temperature sensors for G12 Socs

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 06e186ca41e3..e10aba5c9270 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1353,6 +1353,28 @@
 				};
 			};
 
+			cpu_temp: temperature-sensor@34800 {
+				compatible = "amlogic,g12-cpu-thermal",
+					     "amlogic,g12-thermal";
+				reg = <0x0 0x34800 0x0 0x50>;
+				interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_TS>;
+				status = "okay";
+				#thermal-sensor-cells = <1>;
+				amlogic,ao-secure = <&sec_AO>;
+			};
+
+			ddr_temp: temperature-sensor@34c00 {
+				compatible = "amlogic,g12-ddr-thermal",
+					     "amlogic,g12-thermal";
+				reg = <0x0 0x34c00 0x0 0x50>;
+				interrupts = <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_TS>;
+				status = "okay";
+				#thermal-sensor-cells = <1>;
+				amlogic,ao-secure = <&sec_AO>;
+			};
+
 			usb2_phy0: phy@36000 {
 				compatible = "amlogic,g12a-usb2-phy";
 				reg = <0x0 0x36000 0x0 0x2000>;
-- 
2.17.1

