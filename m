Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9C8420AD1
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 14:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhJDMXX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 08:23:23 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:42577 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhJDMXT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 08:23:19 -0400
Received: by mail-ot1-f52.google.com with SMTP id c26-20020a056830349a00b0054d96d25c1eso21219297otu.9;
        Mon, 04 Oct 2021 05:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=fZ63krPMlh3kt7911YLk7W+3mai0yNydNaCDOTzrm4E=;
        b=J9G0HYhKgAG+N6ipCoLOilWkayfW2ln1I0yb4E/etvy3gYogkX7cmFjPpuGx6+0ryr
         7Lm1ItD4j/mbBZIHlwzRXXz0XjQ3EViLlcHU5GHkkGUCpLz/G9t4FC+8xbr8D+kGKRuM
         wTWIStuAyABGjD2X2sfp+hUBwzbn0MYvEaIY7KNRArBlASV0aU+UORCBvi7gO2bQ5L9E
         HLALBc4CX5OSbrU/9XL6sI2HjadZweJtsVDuPHWzGZ8JO2V0sucnojLwbOmEA3nen6L2
         KG1F44ZIpols1+KtQZ+oSgLTxvBlHxygBBqmeJ+rJaYFIxOaIkdUGir9wBpyBBoOkyVM
         szaA==
X-Gm-Message-State: AOAM532kCebMkUhhZsPb0yEYlft4lsGX6PA0ZXYN6bPm0yaFJz8LmHaV
        qj+SiwLcfYmmaJq2pK2WLA==
X-Google-Smtp-Source: ABdhPJySJbWCHS0cTjUYXBjhPSL+DTwFSvHXl+qRad/Pxp7aQH2zdRBDfcW88BhRBmbmcdAqehL3Rg==
X-Received: by 2002:a9d:6f9a:: with SMTP id h26mr9210824otq.140.1633350089886;
        Mon, 04 Oct 2021 05:21:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v1sm2841291otj.70.2021.10.04.05.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 05:21:29 -0700 (PDT)
Received: (nullmailer pid 1051512 invoked by uid 1000);
        Mon, 04 Oct 2021 12:21:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-sunxi@lists.linux.dev,
        Michael Turquette <mturquette@baylibre.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20211004012739.39053-4-samuel@sholland.org>
References: <20211004012739.39053-1-samuel@sholland.org> <20211004012739.39053-4-samuel@sholland.org>
Subject: Re: [PATCH v2 3/6] dt-bindings: arm: sunxi: Add H5 MBUS compatible
Date:   Mon, 04 Oct 2021 07:21:26 -0500
Message-Id: <1633350086.771765.1051511.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 03 Oct 2021 20:27:36 -0500, Samuel Holland wrote:
> The H5 SoC has a MBUS very similar to the H3 SoC, but it has a smaller
> MDFS divider range (1-4 instead of 1-16). Add a separate compatible for
> this variant.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1535893


dram-controller@1c62000: 'clock-names' is a required property
	arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-it.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h5-cc.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dt.yaml
	arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dt.yaml
	arch/arm/boot/dts/sun8i-h2-plus-libretech-all-h3-cc.dt.yaml
	arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dt.yaml
	arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dt.yaml
	arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dt.yaml
	arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus-v1.2.dt.yaml
	arch/arm/boot/dts/sun8i-h3-beelink-x2.dt.yaml
	arch/arm/boot/dts/sun8i-h3-emlid-neutis-n5h3-devboard.dt.yaml
	arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dt.yaml
	arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-m1.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-neo.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-r1.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-2.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-lite.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-one.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-pc.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-plus.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dt.yaml
	arch/arm/boot/dts/sun8i-h3-rervision-dvk.dt.yaml
	arch/arm/boot/dts/sun8i-h3-zeropi.dt.yaml

dram-controller@1c62000: clocks: [[2, 112]] is too short
	arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dt.yaml

dram-controller@1c62000: clocks: [[3, 113]] is too short
	arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-it.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h5-cc.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dt.yaml
	arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dt.yaml
	arch/arm/boot/dts/sun8i-h2-plus-libretech-all-h3-cc.dt.yaml
	arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dt.yaml
	arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dt.yaml
	arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dt.yaml
	arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus-v1.2.dt.yaml
	arch/arm/boot/dts/sun8i-h3-beelink-x2.dt.yaml
	arch/arm/boot/dts/sun8i-h3-emlid-neutis-n5h3-devboard.dt.yaml
	arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dt.yaml
	arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-m1.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-neo.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-r1.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-2.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-lite.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-one.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-pc.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-plus.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dt.yaml
	arch/arm/boot/dts/sun8i-h3-rervision-dvk.dt.yaml
	arch/arm/boot/dts/sun8i-h3-zeropi.dt.yaml

dram-controller@1c62000: reg: [[29761536, 4096]] is too short
	arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-it.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h5-cc.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dt.yaml
	arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dt.yaml
	arch/arm/boot/dts/sun8i-h2-plus-libretech-all-h3-cc.dt.yaml
	arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dt.yaml
	arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dt.yaml
	arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dt.yaml
	arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus-v1.2.dt.yaml
	arch/arm/boot/dts/sun8i-h3-beelink-x2.dt.yaml
	arch/arm/boot/dts/sun8i-h3-emlid-neutis-n5h3-devboard.dt.yaml
	arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dt.yaml
	arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-m1.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-neo.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-r1.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-2.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-lite.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-one.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-pc.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-plus.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dt.yaml
	arch/arm/boot/dts/sun8i-h3-rervision-dvk.dt.yaml
	arch/arm/boot/dts/sun8i-h3-zeropi.dt.yaml

dram-controller@1c62000: 'reg-names' is a required property
	arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-it.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h5-cc.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dt.yaml
	arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dt.yaml
	arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dt.yaml
	arch/arm/boot/dts/sun8i-h2-plus-libretech-all-h3-cc.dt.yaml
	arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dt.yaml
	arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dt.yaml
	arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dt.yaml
	arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus-v1.2.dt.yaml
	arch/arm/boot/dts/sun8i-h3-beelink-x2.dt.yaml
	arch/arm/boot/dts/sun8i-h3-emlid-neutis-n5h3-devboard.dt.yaml
	arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dt.yaml
	arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-m1.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-neo.dt.yaml
	arch/arm/boot/dts/sun8i-h3-nanopi-r1.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-2.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-lite.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-one.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-pc.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-plus.dt.yaml
	arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dt.yaml
	arch/arm/boot/dts/sun8i-h3-rervision-dvk.dt.yaml
	arch/arm/boot/dts/sun8i-h3-zeropi.dt.yaml

