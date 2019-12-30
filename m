Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2864712D191
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 16:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfL3PoL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 30 Dec 2019 10:44:11 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34938 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfL3PoL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Dec 2019 10:44:11 -0500
Received: by mail-ed1-f65.google.com with SMTP id f8so32952131edv.2;
        Mon, 30 Dec 2019 07:44:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BqjpB17I4FAVcCVel4kRRM5u2ZSN97epJBsAntRnbvo=;
        b=BGn6eLF/ceEdI0HWKQ3q+meVBxDTd6TvXMlQzyPYeivJZclIvXpfkNIIqj+qDDzuYv
         m6jGEvK4vVkZN1IKn1y9P/3Ru/yNsr1vaXaZcBXydbKN5lv4Bbbozaown/breSai8p9B
         OBQjMa6c4axPG+fc+4XIhbcEcH6+hlVpAauTKwjTNYcP03AA0MMYVtSOv4tKWUmXWhAo
         OmXBAqvc8Sw/DLIHQwLdxXpy/vYN2nOl2Q5xd96KZuvH03ps2tyY5dwQvBTt8WczcXpM
         f+FbpO6CCK6USHKxGMpw8sgSWIqoqvdxJSZkL9a3Wn5Nu3/DFc+cOoHdjjc8NWalOQlq
         siGg==
X-Gm-Message-State: APjAAAVp6kz88B1Wr09Sb3FgDCDii+WVuf3rUYZhtbakI0kCSkawVJU3
        LRhzkMXdl7ColV0t674FpG+L7LnN
X-Google-Smtp-Source: APXvYqxzo56maTlSxQsNU5A2SyQb7P5FV8UkAKWQclUCoOB2bQNqmZBjZSuWqej4dQDiaLucch6EvA==
X-Received: by 2002:a17:906:2649:: with SMTP id i9mr71611722ejc.120.1577720649214;
        Mon, 30 Dec 2019 07:44:09 -0800 (PST)
Received: from pi3 ([194.230.155.138])
        by smtp.googlemail.com with ESMTPSA id t1sm5651917ejg.32.2019.12.30.07.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 07:44:08 -0800 (PST)
Date:   Mon, 30 Dec 2019 16:44:05 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [RFC PATCH v3 4/7] arm: dts: exynos: Add interconnect bindings
 for Exynos4412
Message-ID: <20191230154405.GC4918@pi3>
References: <20191220115653.6487-1-a.swigon@samsung.com>
 <CGME20191220120144eucas1p119ececf161a6d45a6a194e432bbbd1f9@eucas1p1.samsung.com>
 <20191220115653.6487-5-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20191220115653.6487-5-a.swigon@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 20, 2019 at 12:56:50PM +0100, Artur Świgoń wrote:
> This patch adds the following properties to the Exynos4412 DT:
>   - exynos,interconnect-parent-node: to declare connections between
>     nodes in order to guarantee PM QoS requirements between nodes;
>   - #interconnect-cells: required by the interconnect framework.
> 
> Note that #interconnect-cells is always zero and node IDs are not
> hardcoded anywhere.
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)

The order of patches is confusing. Patches 4 and 6 are split - do the
depend on 5? I doubt but...

Adjust the title to match the contents - you are not adding bindings but
properties to bus nodes. Also the prefix is ARM: (look at recent
commits).

> 
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> index 4ce3d77a6704..d9d70eacfcaf 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -90,6 +90,7 @@
>  &bus_dmc {
>  	exynos,ppmu-device = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
>  	vdd-supply = <&buck1_reg>;
> +	#interconnect-cells = <0>;

This does not look like property of Odroid but Exynos4412 or Exynos4.

Best regards,
Krzysztof
