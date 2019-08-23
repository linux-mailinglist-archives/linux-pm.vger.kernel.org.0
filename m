Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1419AAFF
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 11:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393514AbfHWJE1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 05:04:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53133 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393477AbfHWJE0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2019 05:04:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id o4so8207856wmh.2
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2019 02:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7lS6otfNfKn2A4Z6EJ+EWGqquL/jDHyWtp6eWoI2sQ=;
        b=b0KqI2bKabxX/CLyMZVp4C9olw9IuKvdW4s2hW59kzepQ9tpvF7cIj3t7rlg5bdUoi
         SjrpZuX4aNecZpzG5WoarF2JwNbhgnTmhw6tOCTLPyj6a0MlCUri0PrZZbpzevTGI+2u
         jCP/dyGPZLHcwTzex2b+yWNzs+SYVzxIbYmN+1/gCEV4dWN/KFAkr/GkRmYPFEBq72qa
         +vptHtmHo11a57W5NNTxKHo7S3yWTEcABRlm9XfLO8ZpzjIQ3XrTcW9admytv+PYB37p
         wMOPBj4PfQGnFhzI+wRMlAt/VscakAVYsPEWyoClsGMbQUQG+zDSOFYHufNIYK/zcXeF
         adEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7lS6otfNfKn2A4Z6EJ+EWGqquL/jDHyWtp6eWoI2sQ=;
        b=jrGYWyBtKp42BYPPsLp2S3K4sA0aT1cJuM4Lg7MVCiDLt4ZCCwI/UHqnz2aYshx0SR
         7Sv620jtZGuDWGp76e0GEchYJ0PvBktHn3rL8wQNvUAeRkPug7omWMWJNcmIN+HONuDe
         v/Dqg2sJrGJvezUZLTJfNyR7QedITfIxghVUsSLuGn1m9YDad8m3T75UZ2l5OmhZAdCE
         kP1OBE8qF7Of8cLHAtQl8zv85AtlvOFhlh6/uCuCyxHjr37+7LTd3mjI0o21aRj3PS5/
         1Ma8xxy2v9A4JICKp4MnyygzECqFz0bB4WTWARnx0VRNmcAjqYlJ65Ib60S1vUbEblBG
         D3Ww==
X-Gm-Message-State: APjAAAX9fHNHdzSwY0c8ksCTsemvzZ/eInT0Ibe3bQQZtTAcMjCBFA2t
        g2iOKKKZaLRie+NIYiZmBRsv9g==
X-Google-Smtp-Source: APXvYqzv+3OEYdyAmsOvtHfKnTXCIdOXKgggpEvAEYxC41wrsIacwiO8beWA5cQ7p8t4M1JJqXh2tw==
X-Received: by 2002:a1c:c1cd:: with SMTP id r196mr4049459wmf.127.1566551064134;
        Fri, 23 Aug 2019 02:04:24 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x26sm1625544wmj.42.2019.08.23.02.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 02:04:23 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, ulf.hansson@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] arm64: dts: meson-sm1-sei610: add HDMI display support
Date:   Fri, 23 Aug 2019 11:04:17 +0200
Message-Id: <20190823090418.17148-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190823090418.17148-1-narmstrong@baylibre.com>
References: <20190823090418.17148-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the HDMI support nodes for the Amlogic SM1 Based SEI610 Board.

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

