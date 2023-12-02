Return-Path: <linux-pm+bounces-638-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9615801D97
	for <lists+linux-pm@lfdr.de>; Sat,  2 Dec 2023 16:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F141C20323
	for <lists+linux-pm@lfdr.de>; Sat,  2 Dec 2023 15:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A941A595;
	Sat,  2 Dec 2023 15:52:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15295129;
	Sat,  2 Dec 2023 07:52:13 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1r9SHd-0002AT-MB; Sat, 02 Dec 2023 16:51:57 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Alex Bee <knaerzche@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
 Alex Bee <knaerzche@gmail.com>
Subject:
 Re: [PATCH v2 2/5] ARM: dts: rockchip: Add power-controller for RK3128
Date: Sat, 02 Dec 2023 16:51:56 +0100
Message-ID: <6926340.F8r316W7xa@diego>
In-Reply-To: <20231202125144.66052-3-knaerzche@gmail.com>
References:
 <20231202125144.66052-1-knaerzche@gmail.com>
 <20231202125144.66052-3-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Alex,

Am Samstag, 2. Dezember 2023, 13:51:41 CET schrieb Alex Bee:
> Add power controller and qos nodes for RK3128 in order to use
> them as powerdomains.

does the power-domain controller work with the incomplete set of
pm-domains too?

What I have in mind is
- adding the power-controller node with the existing set of power-domains
- the gpu pm-domain is in there
- adding the gpu parts


And a second series with
- patch1 from here
- a dts patch adding the additional pm-domains to rk3128.dtsi
- I guess patch1 also should be split into a patch adding the binding-ids
  and a separate patch for the code addition.


Heiko

> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
>  arch/arm/boot/dts/rockchip/rk3128.dtsi | 101 +++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
> index 4e8b38604ecd..b72905db04f7 100644
> --- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
> +++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/power/rk3128-power.h>
>  
>  / {
>  	compatible = "rockchip,rk3128";
> @@ -133,6 +134,106 @@ smp-sram@0 {
>  	pmu: syscon@100a0000 {
>  		compatible = "rockchip,rk3128-pmu", "syscon", "simple-mfd";
>  		reg = <0x100a0000 0x1000>;
> +
> +		power: power-controller {
> +			compatible = "rockchip,rk3128-power-controller";
> +			#power-domain-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			power-domain@RK3128_PD_VIO {
> +				reg = <RK3128_PD_VIO>;
> +				clocks = <&cru ACLK_CIF>,
> +					 <&cru HCLK_CIF>,
> +					 <&cru DCLK_EBC>,
> +					 <&cru HCLK_EBC>,
> +					 <&cru ACLK_IEP>,
> +					 <&cru HCLK_IEP>,
> +					 <&cru ACLK_LCDC0>,
> +					 <&cru HCLK_LCDC0>,
> +					 <&cru PCLK_MIPI>,
> +					 <&cru ACLK_RGA>,
> +					 <&cru HCLK_RGA>,
> +					 <&cru ACLK_VIO0>,
> +					 <&cru ACLK_VIO1>,
> +					 <&cru HCLK_VIO>,
> +					 <&cru HCLK_VIO_H2P>,
> +					 <&cru DCLK_VOP>,
> +					 <&cru SCLK_VOP>;
> +				pm_qos = <&qos_ebc>,
> +					 <&qos_iep>,
> +					 <&qos_lcdc>,
> +					 <&qos_rga>,
> +					 <&qos_vip>;
> +				#power-domain-cells = <0>;
> +			};
> +
> +			power-domain@RK3128_PD_VIDEO {
> +				reg = <RK3128_PD_VIDEO>;
> +				clocks = <&cru ACLK_VDPU>,
> +					 <&cru HCLK_VDPU>,
> +					 <&cru ACLK_VEPU>,
> +					 <&cru HCLK_VEPU>,
> +					 <&cru SCLK_HEVC_CORE>;
> +				pm_qos = <&qos_vpu>;
> +				#power-domain-cells = <0>;
> +			};
> +
> +			power-domain@RK3128_PD_GPU {
> +				reg = <RK3128_PD_GPU>;
> +				clocks = <&cru ACLK_GPU>;
> +				pm_qos = <&qos_gpu>;
> +				#power-domain-cells = <0>;
> +			};
> +
> +			power-domain@RK3128_PD_CRYPTO {
> +				reg = <RK3128_PD_CRYPTO>;
> +				clocks = <&cru HCLK_CRYPTO>,
> +					 <&cru SCLK_CRYPTO>;
> +				pm_qos = <&qos_crypto>;
> +				#power-domain-cells = <0>;
> +			};
> +		};
> +	};
> +
> +	qos_crypto: qos@10128080 {
> +		compatible = "rockchip,rk3128-qos", "syscon";
> +		reg = <0x10128080 0x20>;
> +	};
> +
> +	qos_gpu: qos@1012d000 {
> +		compatible = "rockchip,rk3128-qos", "syscon";
> +		reg = <0x1012d000 0x20>;
> +	};
> +
> +	qos_vpu: qos@1012e000 {
> +		compatible = "rockchip,rk3128-qos", "syscon";
> +		reg = <0x1012e000 0x20>;
> +	};
> +
> +	qos_rga: qos@1012f000 {
> +		compatible = "rockchip,rk3128-qos", "syscon";
> +		reg = <0x1012f000 0x20>;
> +	};
> +
> +	qos_ebc: qos@1012f080 {
> +		compatible = "rockchip,rk3128-qos", "syscon";
> +		reg = <0x1012f080 0x20>;
> +	};
> +
> +	qos_iep: qos@1012f100 {
> +		compatible = "rockchip,rk3128-qos", "syscon";
> +		reg = <0x1012f100 0x20>;
> +	};
> +
> +	qos_lcdc: qos@1012f180 {
> +		compatible = "rockchip,rk3128-qos", "syscon";
> +		reg = <0x1012f180 0x20>;
> +	};
> +
> +	qos_vip: qos@1012f200 {
> +		compatible = "rockchip,rk3128-qos", "syscon";
> +		reg = <0x1012f200 0x20>;
>  	};
>  
>  	gic: interrupt-controller@10139000 {
> 





