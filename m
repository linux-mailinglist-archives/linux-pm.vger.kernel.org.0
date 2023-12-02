Return-Path: <linux-pm+bounces-637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E2E801CC8
	for <lists+linux-pm@lfdr.de>; Sat,  2 Dec 2023 13:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E523D2814A9
	for <lists+linux-pm@lfdr.de>; Sat,  2 Dec 2023 12:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93991864F;
	Sat,  2 Dec 2023 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELM3Yfn0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABFE12D;
	Sat,  2 Dec 2023 04:52:02 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a00d5b0ec44so435881366b.0;
        Sat, 02 Dec 2023 04:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701521521; x=1702126321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGS3uiiSRjNFmcXcLobVydkfz1z0YWeEIsOnLuIOTtk=;
        b=ELM3Yfn0abe0IWNwxW4ZEDlMxP5wL8KGoLtdNbnK3hAiP6fMCdrkx8bQF/rDRdLjHm
         XOHK+PciiX9tcrmznu8ihnNp5cRkHP6Ik1kcuKrVUTK6UGu+fQWN7y7LRlOOF5kCVw8H
         vfLm1iEU49yEoslnLwMDVVYv2erM3bNx6ZZUIkPsEIQnbTV7Ak/7qhVtqcxJ64HdrsNw
         o2Z8SWs98wc54vHpS5hSzEbMxkPrimJYAcBs6QByjv96x4ZuUdjzcfaCX8EnJXa7L/Kt
         mZL5gVIHbXBqPPl4K0/9eVJrvdOxUNZhWB/1yFZWmiMYfGoU+yugvuEGgJoiYM4k/njg
         3TfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701521521; x=1702126321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGS3uiiSRjNFmcXcLobVydkfz1z0YWeEIsOnLuIOTtk=;
        b=laS2WnkWAiNnEfQTCHDa3ir6mkQTE4miA8SrNuMwPu7oZ2pUoaYXOpyvO7nUtPQBpL
         p6EoBgG2NdNa8ZI9biJ0X8Ic3FWRYTGF+d9sBLqUROdtOJuySw39fgogCfVqTYWLMspa
         yUcVTT9SABkFBShm7VmxsySAk4mduz69LfxH130/6xQRy2V0/zd77CA5dbUgKt7Cry3J
         Kd0ZNcAOZ4GRrOGvp/2w9qBlUdFyyWMQaLlsbD2wd2fmV7w1ZbHee/p8tHcXU2Y1Difc
         mrF4fIpJoXsoFGfBfztn2EQRA5nO2OdJsHvhTcX+NpueGr/dA55WoBEcUScQc//nNNzQ
         +a/g==
X-Gm-Message-State: AOJu0YxMh7FtLLlERGrSB7mcLHNngnANtZqnvd40y/YsJJARSxRJx1gY
	74fEAsCTQnHMcZ0QSPPw6w==
X-Google-Smtp-Source: AGHT+IFQCssdJ19Dhg4av1bEqGzWCJHnq4HF6friZV69W7kUuaniNiFQHWBT6X9GqTCcTQpVcwkvXw==
X-Received: by 2002:a17:907:a18f:b0:a19:9b79:8b47 with SMTP id om15-20020a170907a18f00b00a199b798b47mr814246ejc.88.1701521521158;
        Sat, 02 Dec 2023 04:52:01 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:908e:b829:354b:f8ee])
        by smtp.gmail.com with ESMTPSA id g5-20020a170906198500b009c5c5c2c5a4sm3018161ejd.219.2023.12.02.04.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 04:52:00 -0800 (PST)
From: Alex Bee <knaerzche@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 2/5] ARM: dts: rockchip: Add power-controller for RK3128
Date: Sat,  2 Dec 2023 13:51:41 +0100
Message-ID: <20231202125144.66052-3-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231202125144.66052-1-knaerzche@gmail.com>
References: <20231202125144.66052-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add power controller and qos nodes for RK3128 in order to use
them as powerdomains.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 101 +++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index 4e8b38604ecd..b72905db04f7 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/power/rk3128-power.h>
 
 / {
 	compatible = "rockchip,rk3128";
@@ -133,6 +134,106 @@ smp-sram@0 {
 	pmu: syscon@100a0000 {
 		compatible = "rockchip,rk3128-pmu", "syscon", "simple-mfd";
 		reg = <0x100a0000 0x1000>;
+
+		power: power-controller {
+			compatible = "rockchip,rk3128-power-controller";
+			#power-domain-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			power-domain@RK3128_PD_VIO {
+				reg = <RK3128_PD_VIO>;
+				clocks = <&cru ACLK_CIF>,
+					 <&cru HCLK_CIF>,
+					 <&cru DCLK_EBC>,
+					 <&cru HCLK_EBC>,
+					 <&cru ACLK_IEP>,
+					 <&cru HCLK_IEP>,
+					 <&cru ACLK_LCDC0>,
+					 <&cru HCLK_LCDC0>,
+					 <&cru PCLK_MIPI>,
+					 <&cru ACLK_RGA>,
+					 <&cru HCLK_RGA>,
+					 <&cru ACLK_VIO0>,
+					 <&cru ACLK_VIO1>,
+					 <&cru HCLK_VIO>,
+					 <&cru HCLK_VIO_H2P>,
+					 <&cru DCLK_VOP>,
+					 <&cru SCLK_VOP>;
+				pm_qos = <&qos_ebc>,
+					 <&qos_iep>,
+					 <&qos_lcdc>,
+					 <&qos_rga>,
+					 <&qos_vip>;
+				#power-domain-cells = <0>;
+			};
+
+			power-domain@RK3128_PD_VIDEO {
+				reg = <RK3128_PD_VIDEO>;
+				clocks = <&cru ACLK_VDPU>,
+					 <&cru HCLK_VDPU>,
+					 <&cru ACLK_VEPU>,
+					 <&cru HCLK_VEPU>,
+					 <&cru SCLK_HEVC_CORE>;
+				pm_qos = <&qos_vpu>;
+				#power-domain-cells = <0>;
+			};
+
+			power-domain@RK3128_PD_GPU {
+				reg = <RK3128_PD_GPU>;
+				clocks = <&cru ACLK_GPU>;
+				pm_qos = <&qos_gpu>;
+				#power-domain-cells = <0>;
+			};
+
+			power-domain@RK3128_PD_CRYPTO {
+				reg = <RK3128_PD_CRYPTO>;
+				clocks = <&cru HCLK_CRYPTO>,
+					 <&cru SCLK_CRYPTO>;
+				pm_qos = <&qos_crypto>;
+				#power-domain-cells = <0>;
+			};
+		};
+	};
+
+	qos_crypto: qos@10128080 {
+		compatible = "rockchip,rk3128-qos", "syscon";
+		reg = <0x10128080 0x20>;
+	};
+
+	qos_gpu: qos@1012d000 {
+		compatible = "rockchip,rk3128-qos", "syscon";
+		reg = <0x1012d000 0x20>;
+	};
+
+	qos_vpu: qos@1012e000 {
+		compatible = "rockchip,rk3128-qos", "syscon";
+		reg = <0x1012e000 0x20>;
+	};
+
+	qos_rga: qos@1012f000 {
+		compatible = "rockchip,rk3128-qos", "syscon";
+		reg = <0x1012f000 0x20>;
+	};
+
+	qos_ebc: qos@1012f080 {
+		compatible = "rockchip,rk3128-qos", "syscon";
+		reg = <0x1012f080 0x20>;
+	};
+
+	qos_iep: qos@1012f100 {
+		compatible = "rockchip,rk3128-qos", "syscon";
+		reg = <0x1012f100 0x20>;
+	};
+
+	qos_lcdc: qos@1012f180 {
+		compatible = "rockchip,rk3128-qos", "syscon";
+		reg = <0x1012f180 0x20>;
+	};
+
+	qos_vip: qos@1012f200 {
+		compatible = "rockchip,rk3128-qos", "syscon";
+		reg = <0x1012f200 0x20>;
 	};
 
 	gic: interrupt-controller@10139000 {
-- 
2.43.0


