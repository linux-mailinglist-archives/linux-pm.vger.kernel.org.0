Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7DEC3560
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2019 15:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387871AbfJANSO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 09:18:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50600 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfJANSO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 09:18:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id 5so3381470wmg.0;
        Tue, 01 Oct 2019 06:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hpSRk5pH5ZfX94ui4Po6gctzu/8HdpWpMgPRUTWIgiY=;
        b=MrhHfgTtB4RjVbFnJ6YgniZNBkuh9hi0OKISlgGry6z+29FbKkQbABS745yrCQE2TF
         8/HXLyZ7NNSg2Ah4CK06PM73IRwhEc79dLdIU6C0x5aWfTakf6aD1E9Dfqmai5Zcqoy2
         J4vwgDsCUIgIpjoexu7fwkuNZcgvJZTOJfm4DzqQoYIin06NhFHeae9Qa+ncGop5R9kC
         INY9OfJGCVVBluywOLZv0GmYPBPiiHDtZX8/egqWgE6OYRVo2mnHWg8AEpQyU3V52eUA
         xtTg9lGa6J9e+Ic/qOGulWUjs5IQA/vjStB2efPVTKeJzaUk8/DuPYpknHlGOSvSJl8g
         OvKg==
X-Gm-Message-State: APjAAAX9CMUhtt07RmNccHWZQqjHiVeaY5TThHFOWP41Eiuvq4/0QpT1
        S7hX3iAqrQCQIQcyIxpGI4BcGbji
X-Google-Smtp-Source: APXvYqxgdnyCxx5oD9tLArvgGVNt21WJpjLWH5T4JaMALPm61yEm4BR5Qt7YiPJMubGHsBapZrlLqA==
X-Received: by 2002:a1c:7519:: with SMTP id o25mr3603916wmc.16.1569935891213;
        Tue, 01 Oct 2019 06:18:11 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id y5sm3780299wma.14.2019.10.01.06.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 06:18:09 -0700 (PDT)
Date:   Tue, 1 Oct 2019 15:18:07 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        kgene@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        robh+dt@kernel.org, willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v2 1/4] dt-bindings: memory-controllers: Add Exynos5422
 DMC interrupts description
Message-ID: <20191001131807.GB30129@pi3>
References: <20191001125436.24086-1-l.luba@partner.samsung.com>
 <CGME20191001125444eucas1p2e4254acf8434e1fadf0e208dbe62b2d7@eucas1p2.samsung.com>
 <20191001125436.24086-2-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191001125436.24086-2-l.luba@partner.samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 01, 2019 at 02:54:33PM +0200, Lukasz Luba wrote:
> Add description for optional interrupt lines. It provides a new operation
> mode, which uses internal performance counters interrupt when overflow.
> This is more reliable than using default polling mode implemented in
> devfreq.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  .../bindings/memory-controllers/exynos5422-dmc.txt     | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> index 02aeb3b5a820..afc38aea6b1c 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> @@ -31,6 +31,13 @@ Required properties for DMC device for Exynos5422:
>  	The register offsets are in the driver code and specyfic for this SoC
>  	type.
>  
> +Optional properties for DMC device for Exynos5422:
> +- interrupt-parent : The parent interrupt controller.
> +- interrupts : Contains the IRQ line numbers for the DMC internal performance
> +  event counters. Align with specification of the interrupt line(s) in the
> +  interrupt-parent controller.
> +- interrupt-names : List of IRQ names.

Since the names are important (not the order) they are part of the
bindings and they must be listed here.

Best regards,
Krzysztof


> +
>  Example:
>  
>  	ppmu_dmc0_0: ppmu@10d00000 {
> @@ -70,4 +77,7 @@ Example:
>  		device-handle = <&samsung_K3QF2F20DB>;
>  		vdd-supply = <&buck1_reg>;
>  		samsung,syscon-clk = <&clock>;
> +		interrupt-parent = <&combiner>;
> +		interrupts = <16 0>, <16 1>;
> +		interrupt-names = "drex_0", "drex_1";
>  	};
> -- 
> 2.17.1
> 
