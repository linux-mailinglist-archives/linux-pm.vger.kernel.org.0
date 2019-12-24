Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41D9412A1A5
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2019 14:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfLXNMC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Dec 2019 08:12:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35700 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfLXNMC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Dec 2019 08:12:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so2494953wmb.0;
        Tue, 24 Dec 2019 05:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xv6fj//PLhqbq16JTfxLOSmf7sN0fE/sKGiYmf3uDbg=;
        b=lEzXy/5fCv6xqhHgtLqYCRDpU59kJQsMB9S1Dx3oM9bFlHPVeS5ca4OfJTlyWxf0R1
         qHO+4Bdmh3LXlSLS8AYFJucCKjK6aB4Xr5F9sNKT+crnsL5rCODfPefYP7gOlHARlQ5c
         jmpGjV9TiV2vSRXcp0E7YXYJLkHcNrWqpLMqmj6s2AsV5JEfWWqm7qQxsuqqkHjyNhJI
         Dy052j+I4s9f/5Lg1Gu8gjvDW1RDVabHP8Rfah8Lp4KJoRsiA9SsYHe0NyAiIsiGor6J
         /gUUuFULmKaO0Yh2M0+wyF5uqXhZ5F3/0PtNvic/kO2UO5gCLdz7tND8ZeVyhTy/WnsQ
         dE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xv6fj//PLhqbq16JTfxLOSmf7sN0fE/sKGiYmf3uDbg=;
        b=jmADIH/Vsa+VjvlZMH5GEq1xSVlEGs1zv9AiEi2WOv3VdoY93sadPt/MW5jgjIPJ4r
         wFEb//PxwOLOm7Gxc7lNMfoSJPPzd3YxmRbZObFl2J3VSQKKyt9sQBfbffYB5p9XvJYD
         wcxjcpwOWzgB5PAK7f6lD/iZep2nOwsintPHWMVYFRtlsALzmGBFhO33xTD8sW4uqdmZ
         A9wrPzIRTCuN0ewjsEvFviDyCdbsiuPbfpNf4Nfa9rx4D93jXehep1SNuUZMi5zi0EzB
         8pb92it920JlByzz1yzFrdxq4W/INrUKRdgdBlMoxqWK5AuP8RL3R80GnHb5SnMhK8Sf
         gOFw==
X-Gm-Message-State: APjAAAUmUWC/UgAv1eaHoAfFfi30QvKRFi3X+U8S+c0vG9zDRfmbRQKO
        QcMpA6/3VCOKnrpJfDw+RjA=
X-Google-Smtp-Source: APXvYqzRuYR6134pRDFq3Yf9xY6KpX3WI/tV3Jrpy6rro6JAMVg6375WF3SECTkCFDEBgqcM698j1A==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr4445625wmk.68.1577193118768;
        Tue, 24 Dec 2019 05:11:58 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id g7sm24175656wrq.21.2019.12.24.05.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 05:11:57 -0800 (PST)
Date:   Tue, 24 Dec 2019 14:11:55 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/7] add thermal sensor driver for A64, A83T, H3, H5,
 H6, R40
Message-ID: <20191224131155.GA17359@Red>
References: <20191219172823.1652600-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219172823.1652600-1-anarsoul@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 19, 2019 at 09:28:16AM -0800, Vasily Khoruzhick wrote:
> This patchset adds driver for thermal sensor in A64, A83T, H3, H5,
> H6 and R40 SoCs.
> 
> v8:
> 	- [vasily] Address more Maxime's comments for dt-schema
> 	- [vasily] Add myself to MAINTAINERS for the driver and schema
> 	- [vasily] Round calibration data size to word boundary for H6 and A64
> 	- [vasily] Change offset for A64 since it reports too low temp otherwise.
> 	           Likely conversion formula in user manual is not correct.
> 
> v7:
> 	- [vasily] Address Maxime's comments for dt-schema
> 	- [vasily] Move common part of H3 and H5 dts into sunxi-h3-h5.dtsi
> 	- [vasily] Add Maxime's a-b to the driver patch 
> 
> v6:
> 	- [ondrej, vasily] Squash all driver related changes into a
> 			   single patch
> 	- [ondrej] Rename calib -> calibration
> 	- [ondrej] Fix thermal zone registration check
> 	- [ondrej] Lower rate of sensor data interrupts to 4/sec/sensor
> 	- [ondrej] Rework scale/offset values, H6 calibration
> 	- [ondrej] Explicitly set mod clock to 24 MHz
> 	- [ondrej] Set undocumented bits in CTRL0 for H6
> 	- [ondrej] Add support for A83T
> 	- [ondrej] Add dts changes for A83T, H3, H5, H6
> 	- [vasily] Add dts changes for A64
> 	- [vasily] Address Maxime's comments for YAML scheme
> 	- [vasily] Make .calc_temp callback mandatory
> 	- [vasily] Set .max_register in regmap config, so regs can be
> 		   inspected using debugfs
> 
> Ondrej Jirman (4):
>   ARM: dts: sun8i-a83t: Add thermal sensor and thermal zones
>   ARM: dts: sun8i-h3: Add thermal sensor and thermal zones
>   arm64: dts: allwinner: h5: Add thermal sensor and thermal zones
>   arm64: dts: allwinner: h6: Add thermal sensor and thermal zones
> 
> Vasily Khoruzhick (1):
>   arm64: dts: allwinner: a64: Add thermal sensors and thermal zones
> 
> Yangtao Li (2):
>   thermal: sun8i: add thermal driver for H6/H5/H3/A64/A83T/R40
>   dt-bindings: thermal: add YAML schema for sun8i-thermal driver
>     bindings
> 
>  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 160 +++++
>  MAINTAINERS                                   |   8 +
>  arch/arm/boot/dts/sun8i-a83t.dtsi             |  36 +
>  arch/arm/boot/dts/sun8i-h3.dtsi               |  20 +
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi            |   6 +
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  42 ++
>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  |  26 +
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  33 +
>  drivers/thermal/Kconfig                       |  14 +
>  drivers/thermal/Makefile                      |   1 +
>  drivers/thermal/sun8i_thermal.c               | 639 ++++++++++++++++++
>  11 files changed, 985 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
>  create mode 100644 drivers/thermal/sun8i_thermal.c
> 
> -- 
> 2.24.1
> 

Hello

Thanks for your work.

Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Tested-on: sun50i-h6-pine-h64-model-b
Tested-on: sun50i-h6-pine-h64
Tested-on: sun8i-a83t-bananapi-m3
Tested-on: sun8i-h2-plus-orangepi-zero
Tested-on: sun8i-h2-plus-orangepi-r1
Tested-on: sun8i-h2-plus-libretech-all-h3-cc
Tested-on: sun8i-h3-libretech-all-h3-cc
Tested-on: sun50i-h5-libretech-all-h3-cc
Tested-on: sun50i-a64-pine64-plus

Note that your patch serie support R40 but you do not have any R40 DT patch.
If you need testing, do not hesitate to ask.

Regards
