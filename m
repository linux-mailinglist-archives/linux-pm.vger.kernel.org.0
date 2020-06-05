Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5D11EF1AF
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jun 2020 08:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgFEGyn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 02:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFEGyn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jun 2020 02:54:43 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A53C08C5C2
        for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2020 23:54:43 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b201so4504449pfb.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2020 23:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ol/mCu/wq3XWSqVbrU0PUqg7TLmHc45H/V2FtkyiQoI=;
        b=s0iUWCiulnPEJ14VlJ3QPbOHJDtYlaxnZ91r3vHIWzkqTFRP2S2DaxZOjlbTO0nMc7
         u/xcfCRQb+BxK+PCUZegWHub1d0/4yoybX0RRiksj5OCJGIgb7dnkFfJ8k8lMYWr6j1D
         YMtNpiXm0WIy7uK38y5bje5Uiayn0xVbpbxXSNH+1YTZ6if9sCDclc1xzurVjALDH/8A
         BntGvNMyb5B0DX5XNBT1JNBX+g8dW8K6cu4E47zTAUX2QTiS6Y+VlVJZluhruwf/7ZIW
         oV8Gx/zXNG0ojt3gCdJn4R1lhr8jWtCCCrhCBrLmXdArZWYtJlfjN6Tf9Wub1gqlLrhr
         3X/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ol/mCu/wq3XWSqVbrU0PUqg7TLmHc45H/V2FtkyiQoI=;
        b=ONGugtRdY1NpZYcv9NmPBr2IaYpAUc4adpLgAzIQpPJiOvoGJVfQoSPG0ENoHIiur3
         EpZKkjOUD+Gek07PNa/yhScGvASo1Mq4A59JUrBoedzwkR64LOSYXEvAIrEcVfujeeX5
         xLT1pbboKcTvQWH4dmtIrzRcsEk5evIaknsMMIRBJd4N3TeHIcN+OeqgfZuNEGZW/p+S
         4ihzUaenXQKM2JpVSN9Uk0KW7Zoz1qj6y5nKoXrq9ul6P7cSZJ896zPczVKLSPsrO3bY
         zBjTMhBlUviQcufopZAULtJfE9VdvXOrtuX/4dP/n4ISGRxt0MNJuuC4Ht/bp5rMGQ86
         eihw==
X-Gm-Message-State: AOAM530WXibAPGry0WHb/DN1EyLpD3z2bp4k36ALRZGwwNpkRFQLdHgZ
        eCiTvjyvKZ9OMQzFZ+JO2PVIEQ==
X-Google-Smtp-Source: ABdhPJwlvPwnbWM/1+mGNeZrFWzLnzQ6rlQX7iUtfK5/neAo8V7zz2RAV3kpMfwJv6QAGbR9NgXXAA==
X-Received: by 2002:a63:b10b:: with SMTP id r11mr7798573pgf.27.1591340082464;
        Thu, 04 Jun 2020 23:54:42 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id nl8sm8184779pjb.13.2020.06.04.23.54.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jun 2020 23:54:41 -0700 (PDT)
Date:   Fri, 5 Jun 2020 12:24:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>, saravanak@google.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, peron.clem@gmail.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] regulator: do not balance 'boot-on' coupled regulators
 without constraints
Message-ID: <20200605065439.tzvlny6upxigqx42@vireshk-i7>
References: <CGME20200605063729eucas1p288dd9d3acdb62cc86745cb6af5c31fc6@eucas1p2.samsung.com>
 <20200605063724.9030-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605063724.9030-1-m.szyprowski@samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+Saravana,

On 05-06-20, 08:37, Marek Szyprowski wrote:
> Balancing of the 'boot-on' coupled regulators must wait until the clients
> set their constraints, otherwise the balancing code might change the
> voltage of the not-yet-constrained regulator to the value below the
> bootloader-configured operation point, what might cause a system crash.
> This is achieved by assuming that, the minimal voltage allowed for the
> given 'boot-on' regulator is equal to it's current voltage until
> consumers apply their constraints.
> 
> Suggested-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> This is yet another approach to fix the regulator coupling on
> Exynos5800/5422 SoCs in the regulator core. I agree with Dmitry that this
> issue is generic and if possible it should be handled in the core.
> 
> This patchset is another attempt to fix the regulator coupling on
> Exynos5800/5422 SoCs. Here are links to the previous attempts and
> discussions:
> 
> https://lore.kernel.org/linux-samsung-soc/20191008101709.qVNy8eijBi0LynOteWFMnTg4GUwKG599n6OyYoX1Abs@z/
> https://lore.kernel.org/lkml/20191017102758.8104-1-m.szyprowski@samsung.com/
> https://lore.kernel.org/linux-pm/cover.1589528491.git.viresh.kumar@linaro.org/
> https://lore.kernel.org/linux-pm/20200528131130.17984-1-m.szyprowski@samsung.com/
> https://lore.kernel.org/linux-samsung-soc/57cf3a15-5d9b-7636-4c69-60742e8cfae6@samsung.com/
> 
> The problem is with "vdd_int" regulator coupled with "vdd_arm" on Odroid
> XU3/XU4 boards family. "vdd_arm" is handled by CPUfreq. "vdd_int" is
> handled by devfreq. CPUfreq initialized quite early during boot and it
> starts changing OPPs and "vdd_arm" value. Sometimes CPU activity during
> boot goes down and some low-frequency OPPs are selected, what in turn
> causes lowering "vdd_arm". This happens before devfreq applies its
> requirements on "vdd_int". Regulator balancing code reduces "vdd_arm"
> voltage value, what in turn causes lowering "vdd_int" value to the lowest
> possible value. This is much below the operation point of the wcore bus,
> which still runs at the highest frequency.
> 
> The issue was hard to notice because in the most cases the board managed
> to boot properly, even when the regulator was set to lowest value allowed
> by the regulator constraints. However, it caused some random issues,
> which can be observed as "Unhandled prefetch abort" or low USB stability.
> 
> Best regards
> Marek Szyprowski
> ---
>  drivers/regulator/core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 03154f5b939f..7e9af7ea4bdf 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -3553,6 +3553,17 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
>  		if (ret < 0)
>  			return ret;
>  
> +		/*
> +		 * If no constraints set yet and regulator has boot-on flag,
> +		 * keep its voltage unchanged
> +		 */
> +		if (tmp_min == 0 && c_rdevs[i]->constraints->boot_on) {
> +			ret = regulator_get_voltage_rdev(c_rdevs[i]);
> +			if (ret < 0)
> +				return ret;
> +			tmp_min = ret;
> +		}
> +
>  		ret = regulator_check_voltage(c_rdevs[i], &tmp_min, &tmp_max);
>  		if (ret < 0)
>  			return ret;

This is exactly what Saravana tried to solve earlier AFAIR, lets see what he has
to say here.

-- 
viresh
