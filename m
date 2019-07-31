Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 127A07C0D7
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 14:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfGaMOU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 08:14:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32951 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729039AbfGaMOT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 08:14:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id h19so1171268wme.0
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 05:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4dhyanCajCoQ1NdrxY9RmPZmRRskdkUd8pA1FbO4zdo=;
        b=fYS3TgnwrniuqSiM6EH8XBX5NO0WHBVCvOQ0paEeMa5/j1L16S3eMBI475LTjoV8ui
         XZMH/qiesdnDqiwtIhyM1C2/aKEjieF90KHqB6+woi/R04pCoUA/DS7g8FxIvxCnVtge
         CGwXU2VF0b6n9CWoTmUCdsFiMDjRLlu5sziIWWZIkiHdyN0Y/Wsf0v2npxS2fT0fS+lM
         erUXS9kjSafOR4vz6DeIvqCDioiICAfx5E4DG2s8qQ9IObARQnUnjfv1c+5qN9fxljuk
         dnOaSG3+0/aKtms73knvFjaJth/VFSJ1fRgV96ir5bKG0YYN6P1Pt94Qm3nVEVGmD6W2
         8e7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4dhyanCajCoQ1NdrxY9RmPZmRRskdkUd8pA1FbO4zdo=;
        b=gMKyU0x7MXeU93phdNBfnIcen5e4hKo2IGV3mPOzRINhY9+EX8PtKHL7j5UK3kQgeg
         rkliPlph7YeoE2q78Cga/mYs4zrc+4gAz31hJbkkgQi2BxfW02pqA4ih6H6hSVZSzYSA
         StaelluzhjXb03QeWZFAkZuqTCNQKiQs05VJVfzh2INl3cOEyFAekuU9gW4EbcmPRMaI
         M6CIBwt1XJkJTD8OpxckKUwkMLrcHObuqSh6eLUA4YYzisi5jV10SwCi0NhUFm1uobK9
         kPYdK0FyVkvh0j26fZ+JWm1/L1oEsBs83Nv3lPmumwhAk9oESt6cCsNIvYlj9rvHAF/K
         Tncg==
X-Gm-Message-State: APjAAAVceK7VQjGJniDkHKG0/j4BCHOVcSEZKwErtOuy4Z3qitBYWHcT
        j5nUnaKenJU4Pwh8KT5PwCZumw==
X-Google-Smtp-Source: APXvYqxRDiGgBTKX4OvpK3DPoOUb/3Cu6lXEUEkKcn4C86RVnIxo9nRbAkWga96jF5qAdQmTIoHbSA==
X-Received: by 2002:a7b:c251:: with SMTP id b17mr37174245wmj.143.1564575257149;
        Wed, 31 Jul 2019 05:14:17 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a64sm3613713wmf.1.2019.07.31.05.14.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:14:16 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/6] arm64: dts: meson: sei510: Add minimal thermal zone
Date:   Wed, 31 Jul 2019 14:14:07 +0200
Message-Id: <20190731121409.17285-5-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731121409.17285-1-glaroque@baylibre.com>
References: <20190731121409.17285-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add minimal thermal zone for DDR and CPU sensor

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index c7a87368850b..79ae514e238d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -33,6 +33,19 @@
 		ethernet0 = &ethmac;
 	};
 
+	thermal-zones {
+		soc_thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&cpu_temp 0>;
+		};
+		ddr_thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&ddr_temp 1>;
+		};
+	};
+
 	mono_dac: audio-codec-0 {
 		compatible = "maxim,max98357a";
 		#sound-dai-cells = <0>;
-- 
2.17.1

