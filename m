Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C48B126E99
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 21:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLSUTY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 15:19:24 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39358 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLSUTX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 15:19:23 -0500
Received: by mail-ed1-f65.google.com with SMTP id t17so6136013eds.6;
        Thu, 19 Dec 2019 12:19:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1z6z1Ui8LL1nkwwIvcM2qSFeAknNPztf5Dw5KcO2dK8=;
        b=sS8NsZJcXcY8TgpHCpIbqW9V5OzarWXytTpQ8I79KR+JDiVB1Q4w0df8fgVfLkZLsP
         QppebyM5rQLw4qBSyvplYNDscsIFUI7WytzCjfgSNR28svfrltxPY4sMrHe/KtE+gqKc
         7o2xqq82jbtzbPzYCjvTd1E7C7k8iCwJwG6DuZ6augRV4mTuVT5iOZibGaICkZIk4OVs
         /duT5SKPDGxCtDrTGp2snC0E4I0dMSi4j/6yeVfQIYdnd3w8Z7pPU0r5PqKoOODUJgKF
         mBLPBfSlIyvl1WKvxRvYrzo5yl3kK+LEThN94aDmshg+bpNWNRO3soKrVjqgyJ8f1vDK
         1r7g==
X-Gm-Message-State: APjAAAVwDJaEYLWKsuFyemHOkK1sW++kXNjjvM+nrEaE6BpHxfVUL5pR
        1v3dDHwmBIMCvNc+yE31cKo=
X-Google-Smtp-Source: APXvYqwwejroRBv27RRKI+KjHOuS4q02b2b9jWEyzsgC2C9l3pOef3KwtMfRZqXDwDfmgHuveS0ogQ==
X-Received: by 2002:a17:906:5606:: with SMTP id f6mr11822819ejq.179.1576786761612;
        Thu, 19 Dec 2019 12:19:21 -0800 (PST)
Received: from kozik-lap ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id m2sm626166edp.85.2019.12.19.12.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 12:19:20 -0800 (PST)
Date:   Thu, 19 Dec 2019 21:19:17 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, kgene@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 7/9] memory: samsung: exynos5422-dmc: Replace deprecated
 'devfreq-events' property
Message-ID: <20191219201917.GA21576@kozik-lap>
References: <20191217055738.28445-1-cw00.choi@samsung.com>
 <CGME20191217055106epcas1p2c43a45e34983c1b3e60cc6fd842dd33e@epcas1p2.samsung.com>
 <20191217055738.28445-8-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191217055738.28445-8-cw00.choi@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 17, 2019 at 02:57:36PM +0900, Chanwoo Choi wrote:
> In order to remove the deprecated 'devfreq-events' property, replace with
> new 'exynos,ppmu-device' property in order to get the devfreq-event device
> in devicetree file instead of 'devfreq-events' property. But, to guarantee
> the backward-compatibility, keep the support 'devfreq-events' property.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  .../memory-controllers/exynos5422-dmc.txt     |  6 ++--
>  drivers/memory/samsung/exynos5422-dmc.c       | 29 +++++++++++++++----
>  2 files changed, 26 insertions(+), 9 deletions(-)

In general looks good for me but I need an ack from Rob.  Patch should
be also split and sent as one of first in the series (before code).

> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> index 02e4a1f862f1..1e1b3702f045 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> @@ -17,14 +17,14 @@ Required properties for DMC device for Exynos5422:
>  - clock-names : should include "fout_spll", "mout_sclk_spll", "ff_dout_spll2",
>    "fout_bpll", "mout_bpll", "sclk_bpll", "mout_mx_mspll_ccore",
>    "mout_mclk_cdrex"  entries
> -- devfreq-events : phandles for PPMU devices connected to this DMC.
> +- exynos,ppmu-device : phandles for PPMU devices connected to this DMC.
>  - vdd-supply : phandle for voltage regulator which is connected.
>  - reg : registers of two CDREX controllers.
>  - operating-points-v2 : phandle for OPPs described in v2 definition.
>  - device-handle : phandle of the connected DRAM memory device. For more
>  	information please refer to documentation file:
>  	Documentation/devicetree/bindings/ddr/lpddr3.txt
> -- devfreq-events : phandles of the PPMU events used by the controller.
> +- exynos,ppmu-device : phandles of the PPMU events used by the controller.
>  - samsung,syscon-clk : phandle of the clock register set used by the controller,
>  	these registers are used for enabling a 'pause' feature and are not
>  	exposed by clock framework but they must be used in a safe way.
> @@ -73,7 +73,7 @@ Example:
>  			      "mout_mx_mspll_ccore",
>  			      "mout_mclk_cdrex";
>  		operating-points-v2 = <&dmc_opp_table>;
> -		devfreq-events = <&ppmu_event3_dmc0_0>,	<&ppmu_event3_dmc0_1>,
> +		exynos,ppmu-device = <&ppmu_event3_dmc0_0>, <&ppmu_event3_dmc0_1>,
>  				 <&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;

Indentation is broken here.

Best regards,
Krzysztof

