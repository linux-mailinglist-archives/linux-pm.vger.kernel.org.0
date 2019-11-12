Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25169F99E7
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 20:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKLTi4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 14:38:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34593 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKLTi4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2019 14:38:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id n13so14103904pff.1
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2019 11:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o8c8L+yq5uuteeSNGFKsd4YFj6CHGTB4powAvhzFPnY=;
        b=cV1/yMqBzCFsW6cFqDNJvCbf2UDQGqjhfDyhntfVDOLeKmGZAU2S/sS0b9oxxz9Ysb
         5GPFydtMuD9otbBfQIyFGfHV+GCkeZE5SvQWGMldPwawqp9UO6oG+Z+6As4gBbp5LT3w
         8u6Cc97jizxpjA8Ks7Plgt6wjmjvMnLQ40WqAYsO+4phSj3r0yyVqGy5d1HANlh4jQFo
         80Dx+1uE0UzOL3JrCNpxqc7vuCXRakkYQ8wtse1gGABogprdqX192w3kNUAkSHMUbH5u
         ZEJJpDVCtgJZosJz/Cc9OrwzUZUZNDKAdv51G7+BY3qUEAiQUGAZvWLBwR2dUhK911sN
         qxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o8c8L+yq5uuteeSNGFKsd4YFj6CHGTB4powAvhzFPnY=;
        b=uho9razbdmgGs99Sa2uRihCjl6yh9GJP7aWy5SrLZhoC2oL802d9aQTU6AxWXTX6EW
         wZVsqv52hYTlKv0FtiH/xovj083uQLMZxLRqLkSvAopVJKClyIz/eCX8rd0M49Wcvh8O
         RNz24GT6hXynZGw64V7VMgW0oUhnxoeZQJb6hIinOYnToxgBo0RqJXvdMlepu07tjs2x
         TrDy4KfWdLoZoqBNmOzQIR4usGwFkiDT01imZyvFnKCNWmbm84g7ozEYbL6EKscyaabX
         FoPUymSpYETJ0rJ5ODCRwczmEbhuo3wSIjcCg/6vfaTc1w4szqXUJ7jaMuC0yXPJf7xi
         5Z5g==
X-Gm-Message-State: APjAAAWk9Rev6BF6wUf+jl9I8DG2roq4v6FD2tYmQBNg/nTq/3SDZ4gU
        Ymz+l+fVIUfQBXWcc/sO1BzHng==
X-Google-Smtp-Source: APXvYqwNk8rTopisVa5O//iCgC0uJ+EsNW1aFkZUV/LOERUiXv1g7ZmWg9AUyGjWe5ZiQ8QmBCXIhg==
X-Received: by 2002:a17:90a:6d27:: with SMTP id z36mr8893488pjj.38.1573587535530;
        Tue, 12 Nov 2019 11:38:55 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y11sm23437710pfq.1.2019.11.12.11.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 11:38:54 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:38:52 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        edubezval@gmail.com, swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] drivers: thermal: tsens: Add critical interrupt
 support
Message-ID: <20191112193852.GC3140946@builder>
References: <cover.1573499020.git.amit.kucheria@linaro.org>
 <4b949a4f401a7f9d403ed0f0c16c7feb083f3524.1573499020.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b949a4f401a7f9d403ed0f0c16c7feb083f3524.1573499020.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 11 Nov 11:21 PST 2019, Amit Kucheria wrote:

> TSENS IP v2.x adds critical threshold interrupt support for each sensor
> in addition to the upper/lower threshold interrupt. Add support in the
> driver.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-common.c | 129 ++++++++++++++++++++++++++--
>  drivers/thermal/qcom/tsens-v2.c     |   8 +-
>  drivers/thermal/qcom/tsens.c        |  21 +++++
>  drivers/thermal/qcom/tsens.h        |  73 ++++++++++++++++
>  4 files changed, 220 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 4359a4247ac3..2989cb952cdb 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -23,6 +23,10 @@
>   * @low_thresh:     lower threshold temperature value
>   * @low_irq_mask:   mask register for lower threshold irqs
>   * @low_irq_clear:  clear register for lower threshold irqs
> + * @crit_viol:      critical threshold violated

"violated" as in "temperature is above crit_thresh"?

> + * @crit_thresh:    critical threshold temperature value
> + * @crit_irq_mask:  mask register for critical threshold irqs
> + * @crit_irq_clear: clear register for critical threshold irqs
>   *
[..]
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 7d317660211e..784c4976c4f9 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -121,6 +121,27 @@ static int tsens_register(struct tsens_priv *priv)
>  
>  	enable_irq_wake(irq);
>  
> +	if (tsens_version(priv) > VER_1_X) {
> +		irq = platform_get_irq_byname(pdev, "critical");
> +		if (irq < 0) {

Treating this as a fatal error breaks backwards compatibility with
current devicetree; and even within your patch series, tsens should fail
to probe between this patch and the application of patch 3.

Please flip this around and do:

irq = platform_get_irq_byname(pdev, "critical");
if (irq >= 0 && tsens_version(priv) > VER_1_X) {
	request_irq()...
}

> +			ret = irq;
> +			goto err_put_device;
> +		}
> +
> +		ret = devm_request_threaded_irq(&pdev->dev, irq,
> +						NULL, tsens_critical_irq_thread,
> +						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +						dev_name(&pdev->dev), priv);
> +		if (ret) {
> +			dev_err(&pdev->dev, "%s: failed to get critical irq\n", __func__);
> +			goto err_put_device;
> +		}
> +
> +		enable_irq_wake(irq);
> +	}
> +
> +	return 0;
> +
>  err_put_device:
>  	put_device(&pdev->dev);
>  	return ret;

Regards,
Bjorn
