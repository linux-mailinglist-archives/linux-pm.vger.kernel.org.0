Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A526C1F1532
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 11:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgFHJRx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 05:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgFHJRw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2020 05:17:52 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2407C08C5C6
        for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2020 02:17:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c71so14564667wmd.5
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2020 02:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=itZ8nYpO9rVwAB+XOSiZ1Zaz+WlUMeN8KYJbRrgai8w=;
        b=l7DQzFGSrv4z2pwkGTr5wRytkcMyxSBUNwqJUmmoa0jIaizCifAiGTW4Ra+5LDMc0H
         33RoSFLpDmOXChn8CPGWvV8+jciU+jYwrR39lPv9PKGtNQZkse7loLOdUU8neJsEBcpT
         awlD/WxgfMusa4hrvPHANnYZtgyZ0WPAVPhTz4wZFegA3NykKbQ6Xx6vThwsq6WUj6xM
         lkCDzkpH6i50UF6l+l2wg+2skKTNV9JqscRxvoTin0X2W7YsRQ/Z4VnNus7GmeSI7WGs
         8xpUX4jaxBLadrlFxX61WDqowj4vC2Apoz9u25nf9kmQb2Vbj4qXQHDV8aEYxqSsNe6n
         /o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=itZ8nYpO9rVwAB+XOSiZ1Zaz+WlUMeN8KYJbRrgai8w=;
        b=deCthRUNWtuca+S5aYE/PMMHoqsAM5YbWwpcdqcxAYS+xKw5VnqN1rdtmXDVOJYmSW
         aN1FxBfKgaN6wuj1hdawqYhT7ERcA6DlxIlEd6aMD7TwMis+h+3B7lmR0Sw/GGYydXdw
         6gIWiSALYPZ1KzdfBcc1bJlTcyy/+169d4GDXzP19DtRFnfPGB4LCTpSraGxPyBwefgn
         Yn+33iHJlwAkVeoHZ8eNBPjFZT9W7czyewVFQ2nlgh1wVSfnRwzOgqtlkoF+yBAfqQOC
         mrHJmcu5/zCP+rE6gGJQZUjWczwnFxF445mdUxGGPi4Yf5LdBnEV6rYvBXji05Nd7VaP
         J+Tw==
X-Gm-Message-State: AOAM533/1DJKmolbK4E/oklnu469D+lkf8zitCFMYzMARZPqrdjtl2kL
        YjwZB0Ffbs2gCztKh5scg6XDEvTiaBMveA==
X-Google-Smtp-Source: ABdhPJzrMGTk69KE1wsSY5muCwS8Xznk2Z2jhdHWIbXZ5sbFgJPKZN2ZhlPLbzx6XFNulQJ+rLPHVQ==
X-Received: by 2002:a1c:2506:: with SMTP id l6mr7539438wml.34.1591607870432;
        Mon, 08 Jun 2020 02:17:50 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:22:5867:d2c6:75f4])
        by smtp.gmail.com with ESMTPSA id t7sm22732326wrq.41.2020.06.08.02.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 02:17:49 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] arm64: dts: meson-khadas-vim3: add Khadas MCU nodes
Date:   Mon,  8 Jun 2020 11:17:39 +0200
Message-Id: <20200608091739.2368-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200608091739.2368-1-narmstrong@baylibre.com>
References: <20200608091739.2368-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the Khadas MCU node with active FAN thermal nodes for all the
Khadas VIM3 variants.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 094ecf2222bb..3325e54ea690 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -183,6 +183,23 @@
 	hdmi-phandle = <&hdmi_tx>;
 };
 
+&cpu_thermal {
+	trips {
+		cpu_active: cpu-active {
+			temperature = <80000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map {
+			trip = <&cpu_active>;
+			cooling-device = <&khadas_mcu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &ext_mdio {
 	external_phy: ethernet-phy@0 {
 		/* Realtek RTL8211F (0x001cc916) */
@@ -222,6 +239,12 @@
 	pinctrl-0 = <&i2c_ao_sck_pins>, <&i2c_ao_sda_pins>;
 	pinctrl-names = "default";
 
+	khadas_mcu: system-controller@18 {
+		compatible = "khadas,mcu";
+		reg = <0x18>;
+		#cooling-cells = <2>;
+	};
+
 	gpio_expander: gpio-controller@20 {
 		compatible = "ti,tca6408";
 		reg = <0x20>;
-- 
2.22.0

