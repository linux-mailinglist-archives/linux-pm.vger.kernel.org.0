Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E2A25359B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 18:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHZQ7s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 12:59:48 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:28830 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgHZQ7r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 12:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598461185;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=+pqpHEhGcbUD6zkwsM5Wv+MICfwn4EzpafFO0jMt18s=;
        b=P8c+z5DLitmM0m8PvcLgBxSpymQLOY4rWZFnDv4p3Ss5qV68DJibqSZhcQ56HN6qge
        1xasWJCkazBvnz8bzaJel9eDMQR4K6Aj3S9oPzzhwTAbe5jNbEWJuGcnekKZOyDbpzw6
        8f5h+Xn3fSxAtTJF5H+MXyxjzQF4X5oVJkqi69c+zvGPZwQdnpm/1jg6BrBWu+UhBqTn
        UVWtj2w/Ey0lRORmbD9lI+/PCTiZPQiA7lo3iPEXSTk/aXadZYUElhY9RgW81PRwawzt
        MVE7uc+lijv4zAIrhZJZ6CjS7u0LCvSc78X020Uii1aVEG+cnjOnuhaPxSrbHgVDGEcM
        tXAA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7Ic/Fboo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id g0b6c1w7QGxhpMl
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 26 Aug 2020 18:59:43 +0200 (CEST)
Date:   Wed, 26 Aug 2020 18:59:36 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] opp: Allow opp-supported-hw to contain multiple
 versions
Message-ID: <20200826165936.GA73657@gerhold.net>
References: <cover.1598442485.git.viresh.kumar@linaro.org>
 <c4d59ad206394e4f73ab7547c6cd99d95c032128.1598442485.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4d59ad206394e4f73ab7547c6cd99d95c032128.1598442485.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 26, 2020 at 05:20:29PM +0530, Viresh Kumar wrote:
> The bindings allow multiple versions to be passed to "opp-supported-hw"
> property, either of which can result in enabling of the OPP.
> 
> Update code to allow that.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

This is exactly what I was looking for!
And it works just fine in my tests:

Tested-by: Stephan Gerhold <stephan@gerhold.net>

Thank you!
Stephan

> ---
>  drivers/opp/of.c | 47 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index e39ddcc779af..5dac8bffd68c 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -434,9 +434,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_find_icc_paths);
>  static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
>  			      struct device_node *np)
>  {
> -	unsigned int count = opp_table->supported_hw_count;
> -	u32 version;
> -	int ret;
> +	unsigned int levels = opp_table->supported_hw_count;
> +	int count, versions, ret, i, j;
> +	u32 val;
>  
>  	if (!opp_table->supported_hw) {
>  		/*
> @@ -451,21 +451,40 @@ static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
>  			return true;
>  	}
>  
> -	while (count--) {
> -		ret = of_property_read_u32_index(np, "opp-supported-hw", count,
> -						 &version);
> -		if (ret) {
> -			dev_warn(dev, "%s: failed to read opp-supported-hw property at index %d: %d\n",
> -				 __func__, count, ret);
> -			return false;
> +	count = of_property_count_u32_elems(np, "opp-supported-hw");
> +	if (count <= 0 || count % levels) {
> +		dev_err(dev, "%s: Invalid opp-supported-hw property (%d)\n",
> +			__func__, count);
> +		return false;
> +	}
> +
> +	versions = count / levels;
> +
> +	/* All levels in at least one of the versions should match */
> +	for (i = 0; i < versions; i++) {
> +		bool supported = true;
> +
> +		for (j = 0; j < levels; j++) {
> +			ret = of_property_read_u32_index(np, "opp-supported-hw",
> +							 i * levels + j, &val);
> +			if (ret) {
> +				dev_warn(dev, "%s: failed to read opp-supported-hw property at index %d: %d\n",
> +					 __func__, i * levels + j, ret);
> +				return false;
> +			}
> +
> +			/* Check if the level is supported */
> +			if (!(val & opp_table->supported_hw[j])) {
> +				supported = false;
> +				break;
> +			}
>  		}
>  
> -		/* Both of these are bitwise masks of the versions */
> -		if (!(version & opp_table->supported_hw[count]))
> -			return false;
> +		if (supported)
> +			return true;
>  	}
>  
> -	return true;
> +	return false;
>  }
>  
>  static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 
