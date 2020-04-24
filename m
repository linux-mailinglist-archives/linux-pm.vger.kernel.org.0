Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493D21B7F11
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 21:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgDXTgr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 15:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXTgq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 15:36:46 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221C6C09B048
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 12:36:45 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e6so4274342pjt.4
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 12:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fCaJ0E8Gy0Ol3hZwXIBBUzkNzHWsMd/CDDe4oOvOuTQ=;
        b=PQHAtxwFS2mt1dXsLhSX43jK+gKlDCgwH7u0Py3KQvQlYXy2gaDsNjW2cwZw6jVkC3
         eqxmxs4oQHNNDo6AmIC8SPTTP1CfwTdpoNH1Sdj6KY1WrZ/Iryoj3I1djtUCdxXfdcHu
         MvQSogpRnoYWLCopy2551VaW4dpQV5iKXjNCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fCaJ0E8Gy0Ol3hZwXIBBUzkNzHWsMd/CDDe4oOvOuTQ=;
        b=aGXvgGBz/+0CdH5knTVG7qR71ly7CET6Hsw7b2yXo7Diq1XpRuz+2yLl3R0tCGdYzK
         nn4mPNESLGS1FDeJUDdShb3Bl7RcrleRMOWW41kiFP0ryX+NsH+lZPnXquKToDR0RsyI
         SUVmJKp2t7vawjYIzkl+18EVRuiXStQQANoCJSOwaBjkkU2CfUPkkXTgH//dZ1EBcBFs
         REU0qyfUy3o3U8tWsjgxsu90tucEwlYDV8E9aRnBRGMEnqwdBJgBIPQB/aJxnwgF6aMG
         IGxcDZD0zszFGjZYqg4BMnilCO1gIDbxAwTYG44Hc3mMlY8RpRhgN8Jp/FycR26Ihf9n
         5S3Q==
X-Gm-Message-State: AGi0PuaYSkU7Ie1JWiXgkjVGBLx/6tGVz5By+Y+M3iz3xCQEpDkx0XhO
        OM3YTkDEMbVe/BVE36f0pf/rKg==
X-Google-Smtp-Source: APiQypKkAz8KIQ265AUq1vhvPDVa/neLERznR3WhDNuRCZGz09aJvd0sJvTaUaF15TcJWwgt3ZAv9Q==
X-Received: by 2002:a17:90a:9318:: with SMTP id p24mr7963439pjo.163.1587757004623;
        Fri, 24 Apr 2020 12:36:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id d17sm5698390pgk.5.2020.04.24.12.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 12:36:43 -0700 (PDT)
Date:   Fri, 24 Apr 2020 12:36:42 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, saravanak@google.com,
        sibis@codeaurora.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/7] OPP: Update the bandwidth on OPP frequency changes
Message-ID: <20200424193642.GC4525@google.com>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-7-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200424155404.10746-7-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 24, 2020 at 06:54:03PM +0300, Georgi Djakov wrote:
> If the OPP bandwidth values are populated, we want to switch also the
> interconnect bandwidth in addition to frequency and voltage.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> v7:
> * Addressed review comments from Viresh.
> 
> v2: https://lore.kernel.org/r/20190423132823.7915-5-georgi.djakov@linaro.org
> 
>  drivers/opp/core.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 8e86811eb7b2..66a8ea10f3de 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -808,7 +808,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  	unsigned long freq, old_freq, temp_freq;
>  	struct dev_pm_opp *old_opp, *opp;
>  	struct clk *clk;
> -	int ret;
> +	int ret, i;
>  
>  	opp_table = _find_opp_table(dev);
>  	if (IS_ERR(opp_table)) {
> @@ -895,6 +895,17 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  			dev_err(dev, "Failed to set required opps: %d\n", ret);
>  	}
>  
> +	if (!ret && opp_table->paths) {
> +		for (i = 0; i < opp_table->path_count; i++) {
> +			ret = icc_set_bw(opp_table->paths[i],
> +					 opp->bandwidth[i].avg,
> +					 opp->bandwidth[i].peak);
> +			if (ret)
> +				dev_err(dev, "Failed to set bandwidth[%d]: %d\n",
> +					i, ret);
> +		}
> +	}
> +
>  put_opp:
>  	dev_pm_opp_put(opp);
>  put_old_opp:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
