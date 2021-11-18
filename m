Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1E5455D28
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 14:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhKROB3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 09:01:29 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:45895 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbhKROB3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 09:01:29 -0500
Received: by mail-oi1-f173.google.com with SMTP id 7so14354569oip.12;
        Thu, 18 Nov 2021 05:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=L+1EFFQEVUzHvIKDEFNtXuuodd0KJOWIJZc/I07HBGM=;
        b=z4NNVgOwyB9tWPaPpLThGglKn5yX8v4SNDlP8QoJbc7Rf6j/syAo3+SgXVVIKsOb3u
         oaNrOhXmNp17JrGggrFKnMQ+80+MeQW6+cMi3o55cmTpxXfQo0j42nc8BTbzweqF5HiF
         ydd8lyiRm8FRbFy69d7yYTUBX6DawtGgZbycL9rVLYiiVB064pi8cB7CcOcI5EGWrN2o
         5IzkcZlCKZtPiG4eL2SP26YxCPXyIYzXKXThzewzwXy1hRuqmsub7X9qLbf2wJeu5ghy
         Y1buiFSmQCTBZlhzsbNr8Be2G84mxOus9lYeHUoq1X8vg+sM2kb44Ve2XxH13k/P/1YT
         lg2g==
X-Gm-Message-State: AOAM532ttbxiXB781/cOewQFYbVNpRGCKN64fbI16zLmIeOrzxLR+b9c
        NDYB+0ValeniX7jAq6ZCGA==
X-Google-Smtp-Source: ABdhPJxJn9aDv3ESZiqtnlnO+DbXLP+Qg0jRjAQSTOO69pFMvmlCJud/IeQZMmd9fmvmvjElF7x/Sg==
X-Received: by 2002:aca:230b:: with SMTP id e11mr7939069oie.22.1637243908404;
        Thu, 18 Nov 2021 05:58:28 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j187sm733988oih.5.2021.11.18.05.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 05:58:26 -0800 (PST)
Received: (nullmailer pid 998657 invoked by uid 1000);
        Thu, 18 Nov 2021 13:58:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>,
        linux-pm@vger.kernel.org
In-Reply-To: <20211118031841.42315-3-samuel@sholland.org>
References: <20211118031841.42315-1-samuel@sholland.org> <20211118031841.42315-3-samuel@sholland.org>
Subject: Re: [PATCH v3 2/6] dt-bindings: arm: sunxi: Expand MBUS binding
Date:   Thu, 18 Nov 2021 07:58:21 -0600
Message-Id: <1637243901.379133.998656.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 17 Nov 2021 21:18:37 -0600, Samuel Holland wrote:
> The MBUS provides more than address translation and bandwidth control.
> It also provides a PMU to measure bandwidth usage by certain masters,
> and it provides notification via IRQ when they are active or idle.
> 
> The MBUS is also tightly integrated with the DRAM controller to provide
> a Memory Dynamic Frequency Scaling (MDFS) feature. In view of this, the
> MBUS binding needs to represent the hardware resources needed for MDFS,
> which include the clocks and MMIO range of the adjacent DRAM controller.
> 
> Add the additional resources for the H3 and A64 compatibles, and a new
> example showing how they are used.
> 
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../arm/sunxi/allwinner,sun4i-a10-mbus.yaml   | 89 ++++++++++++++++++-
>  1 file changed, 86 insertions(+), 3 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1556462


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

