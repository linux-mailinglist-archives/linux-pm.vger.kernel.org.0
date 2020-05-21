Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEF91DCA47
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 11:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgEUJii (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 05:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbgEUJih (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2020 05:38:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA48C061A0E;
        Thu, 21 May 2020 02:38:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w7so5947638wre.13;
        Thu, 21 May 2020 02:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IjIynyFwjf26UwcjQuyqUboBX8U9yn2u5B30EEyrNQ8=;
        b=JdxO/adJ3fPA7wQNwUb3KP7PToBjvulh0L8amrdXULsYDPbE99HYM6DxzWHQcANF6M
         AwG+3A5zQg7CEaH2Lu0ar3AuBzfQYj+cpxdoXzqoE7WLEfFXY42BrbtwOGtegUJO9Nkg
         2aSR60B6i8/f7AGTn/S8e889e7bJvBrLhx+Waxq+swP1VYRP4AAVC0sSp9aLFPX+HM2p
         Dmob0CEJvc49kDfQIs9MiDu2wBQ/gRaoHpmX/NwA8dBieTRrUFyS50o+ZE5nQeJjdSB5
         1finPez0mOiXEAMnq7rsCEqJrrEpnbx93Ld8iOnI2OQaRSH4Zwqk329llzIYBmsU2iyy
         lBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IjIynyFwjf26UwcjQuyqUboBX8U9yn2u5B30EEyrNQ8=;
        b=kPM4/j3HdsL/t7ls9+/iL6tuUzQpi+76jDvW7z0wiGVcZVw9EQ1LyvmAB2PSEPlQc1
         Z9dSmHsOPvo4GPfw/A8bVZKB5SxuWtfjZuQ/AayWu5TDsETvGN3rzSsZpH3iVrmQdjTh
         kuCUIUffN++gFiCWZ20dLJnBEhMhlIhCebqQ76M+6n6HvwnMjc0QLwHgAvM8U5DPVvjn
         TQsbG6z02DAbkH3KsbWo+AwDLHoGeQ4gyNrnDiq3qf3Pl+Kw6zv4dJuuTIdgrzYQft11
         RDsUZknEmBpZYYPy3lkdtjKGdpcfK4wwdd+QN3lCv3SjkUSVi44dUth+Hxxv8WiOWAqD
         2xpA==
X-Gm-Message-State: AOAM5303ILMpnwefDGogpE0AtJbjbMsvbJkIUntuaf++ebMLVXN0WsAx
        lc7FW/TbRKw13HAuL8oym9w=
X-Google-Smtp-Source: ABdhPJySJPLAsYHqliY9um18QDi2CpLJ45pMjJkSEbNL871bR0CB21Kqoqo6M1ErOgcdIqKGngD5Rg==
X-Received: by 2002:adf:82c3:: with SMTP id 61mr8265605wrc.326.1590053915713;
        Thu, 21 May 2020 02:38:35 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.243])
        by smtp.gmail.com with ESMTPSA id h137sm11971318wme.0.2020.05.21.02.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 02:38:34 -0700 (PDT)
Subject: Re: [PATCH v13 6/6] arm64: dts: mt6358: add PMIC MT6358 related nodes
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     drinkcat@chromium.org, Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Frank Wunderlich <frank-w@public-files.de>,
        Josef Friedl <josef.friedl@speed.at>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ran Bi <ran.bi@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        srv_heupstream@mediatek.com
References: <1587438012-24832-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1587438012-24832-7-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1020bb5d-ff0f-7d34-5c6a-d9cfe38f912a@gmail.com>
Date:   Thu, 21 May 2020 11:38:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587438012-24832-7-git-send-email-hsin-hsiung.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 21/04/2020 05:00, Hsin-Hsiung Wang wrote:
> add PMIC MT6358 related nodes which is for MT8183 platform
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---

Now queued for v5.7-next/dts64

Thanks!


>  arch/arm64/boot/dts/mediatek/mt6358.dtsi    | 358 ++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/mediatek/mt8183-evb.dts |   1 +
>  2 files changed, 359 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6358.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
> new file mode 100644
> index 0000000..9361ada
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
> @@ -0,0 +1,358 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2020 MediaTek Inc.
> + */
> +
> +&pwrap {
> +	pmic: mt6358 {
> +		compatible = "mediatek,mt6358";
> +		interrupt-controller;
> +		interrupt-parent = <&pio>;
> +		interrupts = <182 IRQ_TYPE_LEVEL_HIGH>;
> +		#interrupt-cells = <2>;
> +
> +		mt6358codec: mt6358codec {
> +			compatible = "mediatek,mt6358-sound";
> +		};
> +
> +		mt6358regulator: mt6358regulator {
> +			mt6358_vdram1_reg: buck_vdram1 {
> +				regulator-name = "vdram1";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <2087500>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-enable-ramp-delay = <0>;
> +				regulator-always-on;
> +				regulator-allowed-modes = <0 1>;
> +			};
> +
> +			mt6358_vcore_reg: buck_vcore {
> +				regulator-name = "vcore";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1293750>;
> +				regulator-ramp-delay = <6250>;
> +				regulator-enable-ramp-delay = <200>;
> +				regulator-always-on;
> +				regulator-allowed-modes = <0 1>;
> +			};
> +
> +			mt6358_vpa_reg: buck_vpa {
> +				regulator-name = "vpa";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <3650000>;
> +				regulator-ramp-delay = <50000>;
> +				regulator-enable-ramp-delay = <250>;
> +				regulator-allowed-modes = <0 1>;
> +			};
> +
> +			mt6358_vproc11_reg: buck_vproc11 {
> +				regulator-name = "vproc11";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1293750>;
> +				regulator-ramp-delay = <6250>;
> +				regulator-enable-ramp-delay = <200>;
> +				regulator-always-on;
> +				regulator-allowed-modes = <0 1>;
> +			};
> +
> +			mt6358_vproc12_reg: buck_vproc12 {
> +				regulator-name = "vproc12";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1293750>;
> +				regulator-ramp-delay = <6250>;
> +				regulator-enable-ramp-delay = <200>;
> +				regulator-always-on;
> +				regulator-allowed-modes = <0 1>;
> +			};
> +
> +			mt6358_vgpu_reg: buck_vgpu {
> +				regulator-name = "vgpu";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1293750>;
> +				regulator-ramp-delay = <6250>;
> +				regulator-enable-ramp-delay = <200>;
> +				regulator-allowed-modes = <0 1>;
> +			};
> +
> +			mt6358_vs2_reg: buck_vs2 {
> +				regulator-name = "vs2";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <2087500>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-enable-ramp-delay = <0>;
> +				regulator-always-on;
> +			};
> +
> +			mt6358_vmodem_reg: buck_vmodem {
> +				regulator-name = "vmodem";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1293750>;
> +				regulator-ramp-delay = <6250>;
> +				regulator-enable-ramp-delay = <900>;
> +				regulator-always-on;
> +				regulator-allowed-modes = <0 1>;
> +			};
> +
> +			mt6358_vs1_reg: buck_vs1 {
> +				regulator-name = "vs1";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <2587500>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-enable-ramp-delay = <0>;
> +				regulator-always-on;
> +			};
> +
> +			mt6358_vdram2_reg: ldo_vdram2 {
> +				regulator-name = "vdram2";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-enable-ramp-delay = <3300>;
> +			};
> +
> +			mt6358_vsim1_reg: ldo_vsim1 {
> +				regulator-name = "vsim1";
> +				regulator-min-microvolt = <1700000>;
> +				regulator-max-microvolt = <3100000>;
> +				regulator-enable-ramp-delay = <540>;
> +			};
> +
> +			mt6358_vibr_reg: ldo_vibr {
> +				regulator-name = "vibr";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-enable-ramp-delay = <60>;
> +			};
> +
> +			mt6358_vrf12_reg: ldo_vrf12 {
> +				compatible = "regulator-fixed";
> +				regulator-name = "vrf12";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-enable-ramp-delay = <120>;
> +			};
> +
> +			mt6358_vio18_reg: ldo_vio18 {
> +				compatible = "regulator-fixed";
> +				regulator-name = "vio18";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-enable-ramp-delay = <2700>;
> +				regulator-always-on;
> +			};
> +
> +			mt6358_vusb_reg: ldo_vusb {
> +				regulator-name = "vusb";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3100000>;
> +				regulator-enable-ramp-delay = <270>;
> +				regulator-always-on;
> +			};
> +
> +			mt6358_vcamio_reg: ldo_vcamio {
> +				compatible = "regulator-fixed";
> +				regulator-name = "vcamio";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-enable-ramp-delay = <325>;
> +			};
> +
> +			mt6358_vcamd_reg: ldo_vcamd {
> +				regulator-name = "vcamd";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-enable-ramp-delay = <325>;
> +			};
> +
> +			mt6358_vcn18_reg: ldo_vcn18 {
> +				compatible = "regulator-fixed";
> +				regulator-name = "vcn18";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-enable-ramp-delay = <270>;
> +			};
> +
> +			mt6358_vfe28_reg: ldo_vfe28 {
> +				compatible = "regulator-fixed";
> +				regulator-name = "vfe28";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-enable-ramp-delay = <270>;
> +			};
> +
> +			mt6358_vsram_proc11_reg: ldo_vsram_proc11 {
> +				regulator-name = "vsram_proc11";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1293750>;
> +				regulator-ramp-delay = <6250>;
> +				regulator-enable-ramp-delay = <240>;
> +				regulator-always-on;
> +			};
> +
> +			mt6358_vcn28_reg: ldo_vcn28 {
> +				compatible = "regulator-fixed";
> +				regulator-name = "vcn28";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-enable-ramp-delay = <270>;
> +			};
> +
> +			mt6358_vsram_others_reg: ldo_vsram_others {
> +				regulator-name = "vsram_others";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1293750>;
> +				regulator-ramp-delay = <6250>;
> +				regulator-enable-ramp-delay = <240>;
> +				regulator-always-on;
> +			};
> +
> +			mt6358_vsram_gpu_reg: ldo_vsram_gpu {
> +				regulator-name = "vsram_gpu";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1293750>;
> +				regulator-ramp-delay = <6250>;
> +				regulator-enable-ramp-delay = <240>;
> +			};
> +
> +			mt6358_vxo22_reg: ldo_vxo22 {
> +				compatible = "regulator-fixed";
> +				regulator-name = "vxo22";
> +				regulator-min-microvolt = <2200000>;
> +				regulator-max-microvolt = <2200000>;
> +				regulator-enable-ramp-delay = <120>;
> +				regulator-always-on;
> +			};
> +
> +			mt6358_vefuse_reg: ldo_vefuse {
> +				regulator-name = "vefuse";
> +				regulator-min-microvolt = <1700000>;
> +				regulator-max-microvolt = <1900000>;
> +				regulator-enable-ramp-delay = <270>;
> +			};
> +
> +			mt6358_vaux18_reg: ldo_vaux18 {
> +				compatible = "regulator-fixed";
> +				regulator-name = "vaux18";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-enable-ramp-delay = <270>;
> +			};
> +
> +			mt6358_vmch_reg: ldo_vmch {
> +				regulator-name = "vmch";
> +				regulator-min-microvolt = <2900000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-enable-ramp-delay = <60>;
> +			};
> +
> +			mt6358_vbif28_reg: ldo_vbif28 {
> +				compatible = "regulator-fixed";
> +				regulator-name = "vbif28";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-enable-ramp-delay = <270>;
> +			};
> +
> +			mt6358_vsram_proc12_reg: ldo_vsram_proc12 {
> +				regulator-name = "vsram_proc12";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1293750>;
> +				regulator-ramp-delay = <6250>;
> +				regulator-enable-ramp-delay = <240>;
> +				regulator-always-on;
> +			};
> +
> +			mt6358_vcama1_reg: ldo_vcama1 {
> +				regulator-name = "vcama1";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-enable-ramp-delay = <325>;
> +			};
> +
> +			mt6358_vemc_reg: ldo_vemc {
> +				regulator-name = "vemc";
> +				regulator-min-microvolt = <2900000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-enable-ramp-delay = <60>;
> +			};
> +
> +			mt6358_vio28_reg: ldo_vio28 {
> +				compatible = "regulator-fixed";
> +				regulator-name = "vio28";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-enable-ramp-delay = <270>;
> +			};
> +
> +			mt6358_va12_reg: ldo_va12 {
> +				compatible = "regulator-fixed";
> +				regulator-name = "va12";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-enable-ramp-delay = <270>;
> +				regulator-always-on;
> +			};
> +
> +			mt6358_vrf18_reg: ldo_vrf18 {
> +				compatible = "regulator-fixed";
> +				regulator-name = "vrf18";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-enable-ramp-delay = <120>;
> +			};
> +
> +			mt6358_vcn33_bt_reg: ldo_vcn33_bt {
> +				regulator-name = "vcn33_bt";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3500000>;
> +				regulator-enable-ramp-delay = <270>;
> +			};
> +
> +			mt6358_vcn33_wifi_reg: ldo_vcn33_wifi {
> +				regulator-name = "vcn33_wifi";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3500000>;
> +				regulator-enable-ramp-delay = <270>;
> +			};
> +
> +			mt6358_vcama2_reg: ldo_vcama2 {
> +				regulator-name = "vcama2";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-enable-ramp-delay = <325>;
> +			};
> +
> +			mt6358_vmc_reg: ldo_vmc {
> +				regulator-name = "vmc";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-enable-ramp-delay = <60>;
> +			};
> +
> +			mt6358_vldo28_reg: ldo_vldo28 {
> +				regulator-name = "vldo28";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-enable-ramp-delay = <270>;
> +			};
> +
> +			mt6358_vaud28_reg: ldo_vaud28 {
> +				compatible = "regulator-fixed";
> +				regulator-name = "vaud28";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-enable-ramp-delay = <270>;
> +			};
> +
> +			mt6358_vsim2_reg: ldo_vsim2 {
> +				regulator-name = "vsim2";
> +				regulator-min-microvolt = <1700000>;
> +				regulator-max-microvolt = <3100000>;
> +				regulator-enable-ramp-delay = <540>;
> +			};
> +		};
> +
> +		mt6358rtc: mt6358rtc {
> +			compatible = "mediatek,mt6358-rtc";
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> index 1fb195c..9eb84d7 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> @@ -7,6 +7,7 @@
>  
>  /dts-v1/;
>  #include "mt8183.dtsi"
> +#include "mt6358.dtsi"
>  
>  / {
>  	model = "MediaTek MT8183 evaluation board";
> 
