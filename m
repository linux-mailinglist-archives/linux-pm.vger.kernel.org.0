Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C1E403000
	for <lists+linux-pm@lfdr.de>; Tue,  7 Sep 2021 22:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344715AbhIGU4M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Sep 2021 16:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239567AbhIGU4M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Sep 2021 16:56:12 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F3FC061757
        for <linux-pm@vger.kernel.org>; Tue,  7 Sep 2021 13:55:05 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id i24so29916pfo.12
        for <linux-pm@vger.kernel.org>; Tue, 07 Sep 2021 13:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wGaKI/yf6S0oUQYpDmwjH/p4Na2pyd87gFzKo1CWnso=;
        b=ixdOmrehN/QeCK0jpo5gTlYdtXGq2P900/s6Cbx5hzSs52ePfcKJvzs2fmujYInuVX
         KXYv6oJXQAPfcHW8pevszF96PSpRXWZjz9h2h7jMkDprO+GQln6e8RhKTPXcXEy6bgZD
         aB2d2Di7S16LvGa1NKCSPZqlanhrqI+bLfQ3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wGaKI/yf6S0oUQYpDmwjH/p4Na2pyd87gFzKo1CWnso=;
        b=rlD/Bmd0UZwkkAAfkcoyg+4ZcDPAac+iWnlTOHcAGlN11S2aWXAyFM2eq/5S/Fi7pc
         ptJlyrb/sYuLvorEgTG1Z6uK/QwyvSanM5Jkl4mJUZlMwOqaeyECNkHO6PmlOa7UtRBt
         xCpmqUjGzyZkSrmmHhCvBr+KQczovIaGfp8D9b1qnHNFEehc6AajiMSLX8ohqNcdvz9P
         bXv3meYwP5LFb+pl4TLIMwYoncmCBWDGrPSmgFg18gPPvToSD/DdeOUPMR/yYlXfskO1
         ZqlIQe3AA3Go+aAwKXLlsxnq3EoWK/txx5v5wBQxKwsexzJelcwHuEdXVNStLwqmPbIY
         w8MA==
X-Gm-Message-State: AOAM533zKGT6T409K5cFXqW0Gc7/1/pS0hWKp+F99UMawReP4fHQxKoF
        ibW6zdUljPpf3f45lO2Skxgr4Q==
X-Google-Smtp-Source: ABdhPJznsxKxiqpSc33nzng/rxyyYCDmutmO65n8y2+nksEV1jNF1GMyekDDc5jtSI0UPYJmupffwQ==
X-Received: by 2002:a63:ed4a:: with SMTP id m10mr236852pgk.448.1631048105231;
        Tue, 07 Sep 2021 13:55:05 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c6b2:7ae:474d:36f6])
        by smtp.gmail.com with UTF8SMTPSA id 70sm19201pfu.93.2021.09.07.13.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 13:55:04 -0700 (PDT)
Date:   Tue, 7 Sep 2021 13:55:03 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: thermal: tsens: add timeout to
 get_tem_tsens_valid
Message-ID: <YTfRp1pOoQYFRGX+@google.com>
References: <20210905174708.4605-1-ansuelsmth@gmail.com>
 <20210905174708.4605-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210905174708.4605-2-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Sep 05, 2021 at 07:47:08PM +0200, Ansuel Smith wrote:
> The function can loop and lock the system if for whatever reason the bit
> for the target sensor is NEVER valid. This is the case if a sensor is
> disabled by the factory and the valid bit is never reported as actually
> valid. Add a timeout check and exit if a timeout occurs. As this is
> a very rare condition, handle the timeout only if the first read fails.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/thermal/qcom/tsens.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index b1162e566a70..38afde1a599f 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -599,6 +599,7 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
>  	int hw_id = s->hw_id;
>  	u32 temp_idx = LAST_TEMP_0 + hw_id;
>  	u32 valid_idx = VALID_0 + hw_id;
> +	unsigned long timeout;
>  	u32 valid;
>  	int ret;
>  
> @@ -607,13 +608,21 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
>  		ret = regmap_field_read(priv->rf[valid_idx], &valid);
>  		if (ret)
>  			return ret;
> -		while (!valid) {
> -			/* Valid bit is 0 for 6 AHB clock cycles.
> -			 * At 19.2MHz, 1 AHB clock is ~60ns.
> -			 * We should enter this loop very, very rarely.
> -			 */
> -			ndelay(400);
> -			ret = regmap_field_read(priv->rf[valid_idx], &valid);
> +
> +		if (!valid) {
> +			timeout = jiffies + msecs_to_jiffies(20);
> +
> +			do {
> +				/* Valid bit is 0 for 6 AHB clock cycles.
> +				 * At 19.2MHz, 1 AHB clock is ~60ns.
> +				 * We should enter this loop very, very rarely.
> +				 */
> +				ndelay(400);
> +				ret = regmap_field_read(priv->rf[valid_idx], &valid);
> +				if (valid || ret)
> +					break;
> +			} while (!(ret = time_after_eq(jiffies, timeout)));
> +
>  			if (ret)
>  				return ret;

With the overloading of 'ret' the return logic is getting a bit more
convoluted. Also the function should probably return -ETIMEDOUT or
some other meaningful error if the bit is never valid.

How about keeping the 'while (!valid)' condition, and adding

	if (time_after_eq(jiffies, timeout))
		return -ETIMEDOUT;

inside the loop?

