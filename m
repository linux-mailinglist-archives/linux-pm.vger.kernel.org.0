Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 835F597821
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 13:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfHULle (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 07:41:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39387 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfHULl3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 07:41:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id i63so1799560wmg.4
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 04:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gCtDTfOP9CU7PICTDb4hgstX702LCqHDmjrUznwuL5I=;
        b=BI+2vBKkkgV9KDXhp9IlbxRKHhekFU/RKeQ1IsvQSc5sMTR+VaoP23kxdXyOLCtpsP
         A4EHbB+U3XNtGP8JocaG/u0Pj+LdZdyfiZ6VPBMzPVwG1V2Qpp/RWbRVSXVcpb/bJxeO
         r978yAddzNRgaWDbyb51OkIKRLH8vM4U8E+AyoiKn//rOlGnL3nliXdxr4OZ/v27BGhy
         qlQBTzuSwUNcVhZ8YfSeVAK+27zHDwwpyKiLKzJ0jY/8rx+N3l1x+GlV36zjoyxdL8my
         QBHIOfDidkKmDlQqih7KV5TrG8DPg0nIJgnqmTzfE2dhEt81/y852Jvkx9+p1xRZ9vKC
         y2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gCtDTfOP9CU7PICTDb4hgstX702LCqHDmjrUznwuL5I=;
        b=BqvuUIHdCnCTIgB3BuodUuszQHvKSuAg35r97oYyd/2sLs3N1w8VB/8KmotjyGlNO+
         p1bofMO3G7t50DytlREdVbkbV4W5eXal84LUKTKeNtQ/ujb2wy6y8DzhNrjmnV2/Vm8V
         PJ1+4fZIDekFL2ri4IFkChPn/tgH8h0LSBATxoWp2lURFC9REOc1SKmsod9052fsvJHD
         Dh3ynQ8uk4IrXutd9b3N6E2B4Di+U6GrIXTzDDVTsB3Iauhz5E5YpynHw9e4FwG48hoD
         82VOdEFLGe3EmcMjxH2HaqjSKdl0TAYBg4PSJGYCL5i96WhtrbP9QsdQLQhLPbpnFQfP
         Qhpg==
X-Gm-Message-State: APjAAAUePZudceaaiv9+HAqEG7xs6yuQ1zwIL3yjdCOC1XEhDAuw0oZ2
        0JD0HkmiQZ669wfOz18GM3XCOQ==
X-Google-Smtp-Source: APXvYqzMTr3oBHsKlY4CvaevSLrjnCFjzm9FQNxbTR4v3QPRCZ7DHPFKwtGhy+RKAPx70KAJwKEGuw==
X-Received: by 2002:a1c:7a10:: with SMTP id v16mr5474270wmc.2.1566387686884;
        Wed, 21 Aug 2019 04:41:26 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g12sm24049686wrv.9.2019.08.21.04.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 04:41:26 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, ulf.hansson@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: meson-sm1-sei610: add HDMI display support
Date:   Wed, 21 Aug 2019 13:41:20 +0200
Message-Id: <20190821114121.10430-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821114121.10430-1-narmstrong@baylibre.com>
References: <20190821114121.10430-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Update compatible of the pwc-vpu node and add the HDMI support nodes
for the Amlogic SM1 Based SEI610 Board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-sm1-sei610.dts     | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index 12dab0ba2f26..66bd3bfbaf91 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -51,6 +51,17 @@
 		};
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_tmds_out>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -177,6 +188,18 @@
 	phy-mode = "rmii";
 };
 
+&hdmi_tx {
+	status = "okay";
+	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
+	pinctrl-names = "default";
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
 &i2c3 {
 	status = "okay";
 	pinctrl-0 = <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
-- 
2.22.0

