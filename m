Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A2E168B3
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 19:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfEGREZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 13:04:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33462 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfEGREZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 13:04:25 -0400
Received: by mail-ot1-f68.google.com with SMTP id 66so6226577otq.0;
        Tue, 07 May 2019 10:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qof9Nq6m3eIX2nP0Hb5nTkjVTKOQLNCq2yMZEGD0HaI=;
        b=fU3blnO8KGc0e4se6/fUy7GSCouh/Hp7fOe771gW5Qocisbbk/vBu5SdnVcWujEvc4
         ohxV7xxMw38HxQeiAgfZXx7rsFLbZkVAcHRdwkeg5WU9gub214GnxYD7cGjuSoa1VubA
         pwJjuge/ml9k9Hd1pxtDeTc0a20tTknimC2tqC/SvkVZa1kHwrMiLl43AbhUkZLo5oJQ
         y4yB0Ucr7Oq14NRfLsSpjD78FdHOLUiC0J6wQrWnU8MGlwPvWTfeLRd72hZntlAfQmCm
         047YSOeJNMlxvuhrOOeds0lQ55bis2W4fZRIydPU8VG9aZ/z07IjtLRWJJkxX1S9IC3o
         aPtQ==
X-Gm-Message-State: APjAAAXojTy5HbeN2txRK3RrhWgb+heAy/skGUbEb1SH6mWnnz+4iCZ1
        a4f8xoyXkO+M7HAVDC3Obg==
X-Google-Smtp-Source: APXvYqzBww8F6CSc1wcNwfmlZTyY59ASOQFWi+ArE8HLHc01LuQYndTn0tXDxdgCiqati7OO6LO2Jg==
X-Received: by 2002:a9d:5d03:: with SMTP id b3mr1965330oti.268.1557248664018;
        Tue, 07 May 2019 10:04:24 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x12sm5190251otq.19.2019.05.07.10.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 10:04:23 -0700 (PDT)
Date:   Tue, 7 May 2019 12:04:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v7 07/13] dt-bindings: memory-controllers: add Exynos5422
 DMC device description
Message-ID: <20190507170422.GA25179@bogus>
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190506151215eucas1p2c57147edac5671c5ec9a223efb6b4adc@eucas1p2.samsung.com>
 <1557155521-30949-8-git-send-email-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557155521-30949-8-git-send-email-l.luba@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 06, 2019 at 05:11:55PM +0200, Lukasz Luba wrote:
> The patch adds description for DT binding for a new Exynos5422 Dynamic
> Memory Controller device.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  .../bindings/memory-controllers/exynos5422-dmc.txt | 74 ++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> new file mode 100644
> index 0000000..be602a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> @@ -0,0 +1,74 @@
> +* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller device
> +
> +The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which the DRAM
> +memory chips are connected. The driver is to monitor the controller in runtime
> +and switch frequency and voltage. To monitor the usage of the controller in
> +runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
> +is able to measure the current load of the memory.
> +When 'userspace' governor is used for the driver, an application is able to
> +switch the DMC and memory frequency.
> +
> +Required properties for DMC device for Exynos5422:
> +- compatible: Should be "samsung,exynos5422-dmc".
> +- clock-names : the name of clock used by the controller.
> +- clocks : phandles for clock specified in "clock-names" property.

Need to enumerate the clocks and their order.

> +- devfreq-events : phandles for PPMU devices connected to this DMC.
> +- vdd-supply : phandle for voltage regulator which is connected.
> +- reg : registers of two CDREX controllers.
> +- operating-points-v2 : phandle for OPPs described in v2 definition.
> +- device-handle : phandle of the connected DRAM memory device. For more
> +	information please refer to Documentation

Documentation... ?

> +- devfreq-events : phandles of the PPMU events used by the controller.
> +- samsung,syscon-chipid : phandle of the ChipID used by the controller.
> +- samsung,syscon-clk : phandle of the clock register set used by the controller.

Looks like a hack. Can't you get this from the clocks property? What is 
this for?

> +
> +Example:
> +
> +	ppmu_dmc0_0: ppmu@10d00000 {
> +		compatible = "samsung,exynos-ppmu";
> +		reg = <0x10d00000 0x2000>;
> +		clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
> +		clock-names = "ppmu";
> +		events {
> +			ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
> +				event-name = "ppmu-event3-dmc0_0";
> +			};
> +		};
> +	};
> +
> +	dmc: memory-controller@10c20000 {
> +		compatible = "samsung,exynos5422-dmc";
> +		reg = <0x10c20000 0x100>, <0x10c30000 0x100>,
> +		clocks = 	<&clock CLK_FOUT_SPLL>,
> +				<&clock CLK_MOUT_SCLK_SPLL>,
> +				<&clock CLK_FF_DOUT_SPLL2>,
> +				<&clock CLK_FOUT_BPLL>,
> +				<&clock CLK_MOUT_BPLL>,
> +				<&clock CLK_SCLK_BPLL>,
> +				<&clock CLK_MOUT_MX_MSPLL_CCORE>,
> +				<&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
> +				<&clock CLK_MOUT_MCLK_CDREX>,
> +				<&clock CLK_DOUT_CLK2X_PHY0>,
> +				<&clock CLK_CLKM_PHY0>,
> +				<&clock CLK_CLKM_PHY1>;
> +		clock-names =	"fout_spll",
> +				"mout_sclk_spll",
> +				"ff_dout_spll2",
> +				"fout_bpll",
> +				"mout_bpll",
> +				"sclk_bpll",
> +				"mout_mx_mspll_ccore",
> +				"mout_mx_mspll_ccore_phy",
> +				"mout_mclk_cdrex",
> +				"dout_clk2x_phy0",
> +				"clkm_phy0",
> +			        "clkm_phy1";
> +		operating-points-v2 = <&dmc_opp_table>;
> +		devfreq-events = <&ppmu_event3_dmc0_0>,	<&ppmu_event3_dmc0_1>,
> +				<&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
> +		operating-points-v2 = <&dmc_opp_table>;
> +		device-handle = <&samsung_K3QF2F20DB>;
> +		vdd-supply = <&buck1_reg>;
> +		samsung,syscon-clk = <&clock>;
> +		samsung,syscon-chipid = <&chipid>;
> +	};
> -- 
> 2.7.4
> 
