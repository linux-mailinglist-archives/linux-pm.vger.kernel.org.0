Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57DC38D40D
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 15:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfHNNBE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 09:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfHNNBE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Aug 2019 09:01:04 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E759221744;
        Wed, 14 Aug 2019 13:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565787663;
        bh=sxfCJqJU/qaOohNVgHPQHtwC8Q7H8C3hXjEXkCV0LNo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tiBxKOHYPSR9Y16yt71V0kc9fqsUD3IQPem9PJ+ncdv72uoSxmqJtsd0RLTgE1vhZ
         zPnAJCALKkwQ1OQTB7iDM9vbtg1WlAG9wCYw+O4SUFaOQa7pTN/CQsOM92O6VI18V/
         bXMlvMyNZfAyuY9uE3S+ddZXnYhANUtNV02Jxty0=
Received: by mail-lj1-f169.google.com with SMTP id u15so9741898ljl.3;
        Wed, 14 Aug 2019 06:01:02 -0700 (PDT)
X-Gm-Message-State: APjAAAULxOpygd4VJgACuT0l7DrARQnRgLiqQHvjxd8ES7TWrUQuXfKj
        wi/cSA7Zesw22i5ohC89fi/Dv3jipyrsSi1n58E=
X-Google-Smtp-Source: APXvYqxsCMPhEB6d19AkAwrH2WmpslgogpPgDenxgBgQD8gEdZbqPk9ibFEDJH1FhqxoSOjrLiasHqOPI013151j9Zs=
X-Received: by 2002:a2e:8197:: with SMTP id e23mr4590849ljg.80.1565787661091;
 Wed, 14 Aug 2019 06:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190813150858eucas1p1a5fbf425753e4911c50631c3a6d34ffd@eucas1p1.samsung.com>
 <20190813150827.31972-1-s.nawrocki@samsung.com> <20190813150827.31972-8-s.nawrocki@samsung.com>
In-Reply-To: <20190813150827.31972-8-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 14 Aug 2019 15:00:50 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdfe-ON9wmy30YGoGG_LzwhEuXmcv_-kt07cS-Wd3cG8w@mail.gmail.com>
Message-ID: <CAJKOXPdfe-ON9wmy30YGoGG_LzwhEuXmcv_-kt07cS-Wd3cG8w@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] soc: samsung: Update the CHIP ID DT binding documentation
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 13 Aug 2019 at 17:09, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> This patch adds documentation of a new optional "samsung,asv-bin"
> property in the chipid device node and documents requirement of
> "syscon" compatible string.  These additions are needed to support
> Exynos ASV (Adaptive Supply Voltage) feature.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v2:
>  - none
>
> Changes since v1 (RFC):
>  - new patch
> ---
>  .../devicetree/bindings/arm/samsung/exynos-chipid.txt  | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
> index 85c5dfd4a720..be3657e6c00c 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
> @@ -1,12 +1,18 @@
> -SAMSUNG Exynos SoCs Chipid driver.
> +SAMSUNG Exynos SoC series CHIPID subsystem
>
>  Required properties:
> -- compatible : Should at least contain "samsung,exynos4210-chipid".
> +- compatible : Should at least contain "samsung,exynos4210-chipid", "syscon".
>
>  - reg: offset and length of the register set
>
> +Optional properties:
> + - samsung,asv-bin : Adaptive Supply Voltage bin selection. This can be used
> +   to determine the ASV bin of an SoC if respective information is missing
> +   in the CHIPID registers or in the OTP memory. Possible values: 0...3.
> +
>  Example:
>         chipid@10000000 {
>                 compatible = "samsung,exynos4210-chipid";

Please update the example with new required compatible.

Best regards,
Krzysztof

>                 reg = <0x10000000 0x100>;
> +               samsung,asv-bin = <2>;
>         };
> --
> 2.17.1
>
