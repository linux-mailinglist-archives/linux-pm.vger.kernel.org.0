Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7426AE534
	for <lists+linux-pm@lfdr.de>; Tue,  7 Mar 2023 16:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjCGPpj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Mar 2023 10:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjCGPpd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2023 10:45:33 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5126584F4C
        for <linux-pm@vger.kernel.org>; Tue,  7 Mar 2023 07:45:31 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g3so12577054wri.6
        for <linux-pm@vger.kernel.org>; Tue, 07 Mar 2023 07:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678203930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TK38rfMZIYSCE09aA82gNal1pzr6tS/kIcgasbLVBmk=;
        b=3rRyCvaUzbr48hyBZ2CFsD0pYrm9ofuBZ9w+ixhFmH+Wi43j+31NC/s814q6QNIxTy
         HhHe5i0C48LNdFjlVsmS6Qi3HTGBBAOkw+atIdb+RrvET+vqUuPqOuy10ch/rbOBIJqq
         Gu8Q074hLUlXgXMc+9Jru5M/pXPg8DI4UHy0rYtxZIqMsTvRGHf2NF4iBLKfIxa6TeD9
         Ytg6qE0d5W3AVCzQpeXahs23kDYVx7eDGgdSX5WI3HzCk4EFU8VUyhiqoAa0q2VbZF/C
         DVRY4k2cCL6PX/NelxjSBxLwWI6/M0ycf6DfFO850jb8z4Kef6mdyadtYQeW4oe/5Nes
         I+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678203930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TK38rfMZIYSCE09aA82gNal1pzr6tS/kIcgasbLVBmk=;
        b=poMDIxRQ/CFsp7nWTMhd46UnN9nDrmRIaXbiDqZJbnXUsbeFqvPZraEyyVWvLnglb5
         jf2rCCkWecTEbzl28D1EAhYGWRmWPagyu0XpmKPJ9xMQqrxtAG+AKzsGolvCQirRjLuI
         grGKv3Ifn4E5JUhC0M0eEl8i0iQlseEgSSCx6jEVM0m5gAGQmpmNX0NrcIoUYXH2Y46n
         QhJj2AO9ls3iXSLeyzNQwKS8e9ehmSMfLUp3YZCjroYuqHSRz5VgDpb7086Jf/+Ti1ox
         9zw9sa5L2pppFC11fFIxCLWZcCSi7dUETzsxauaUywwWmuomW+46pSbSdcL0cQeGiPKV
         YZMg==
X-Gm-Message-State: AO0yUKU0AjdrGfVTQUQJ4eF7xfW6elI4bWbOoez8wd6u0e93crLaaMOX
        4YKXovCeXOt5AE9dAJfEW/ZurQ==
X-Google-Smtp-Source: AK7set+Guq1ajs13XQHeh554Uq/SiB1NQLIWJev32JcaTps3DMHgTcd/r/3pFPm5VF8vMQ7O2omnWw==
X-Received: by 2002:a5d:4005:0:b0:2c9:5179:41a5 with SMTP id n5-20020a5d4005000000b002c9517941a5mr9632960wrp.8.1678203929903;
        Tue, 07 Mar 2023 07:45:29 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b002c704271b05sm12697905wrt.66.2023.03.07.07.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:45:29 -0800 (PST)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: [PATCH 3/4] arm64: dts: mediatek: mt8195: Add AP domain thermal zones
Date:   Tue,  7 Mar 2023 16:45:23 +0100
Message-Id: <20230307154524.118541-4-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307154524.118541-1-bchihi@baylibre.com>
References: <20230307154524.118541-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add AP Domain thermal zones for the mt8195.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 126 +++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 10c8fb0856bc..b066d1eab1dc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -2652,5 +2652,131 @@ map0 {
 				};
 			};
 		};
+
+		vpu0-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_ap MT8195_AP_VPU0>;
+
+			trips {
+				vpu0_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		vpu1-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_ap MT8195_AP_VPU1>;
+
+			trips {
+				vpu1_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu0-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_ap MT8195_AP_GPU0>;
+
+			trips {
+				gpu0_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu1-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_ap MT8195_AP_GPU1>;
+
+			trips {
+				gpu1_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		vdec-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_ap MT8195_AP_VDEC>;
+
+			trips {
+				vdec_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		img-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_ap MT8195_AP_IMG>;
+
+			trips {
+				img_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		infra-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_ap MT8195_AP_INFRA>;
+
+			trips {
+				infra_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cam0-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_ap MT8195_AP_CAM0>;
+
+			trips {
+				cam0_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cam1-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_ap MT8195_AP_CAM1>;
+
+			trips {
+				cam1_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
 	};
 };
-- 
2.34.1

