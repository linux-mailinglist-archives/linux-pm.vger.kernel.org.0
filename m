Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6D7914C241
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2020 22:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgA1Vdj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jan 2020 16:33:39 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40100 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgA1Vdj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jan 2020 16:33:39 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so7330333pfh.7
        for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2020 13:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D93qg7I5NNh/8e4hQJWbpnFpKCbeO/Ttui56ffqiZTg=;
        b=h7HEAtKfC8YtOpbUNz4JcbPJLQ9R0tRkhJT0Xz4y1caufdhxfslHtDbgu4Q6NZ7NFg
         hCcaewMS6vIHJNWgLRDhdUnObVfyvaFqfcTLHUjT7t+IIdeBtSPuo5yN/+BtXMzXIqTU
         Z5vnBwe74qeouZZGYlgUL0Rt8GXTNlFceIT5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D93qg7I5NNh/8e4hQJWbpnFpKCbeO/Ttui56ffqiZTg=;
        b=b8dWK7E/77LEK8qnoRrcZZ1NdZ1j6y7WukGvCXTtbwTofN62iK1H+52WGBWj/cZfGo
         1Tec6mcYddM4IlFMJi5JWXv+Vh10pviEZ7zNQqSqoUjV5Nu6SQhcpdr1r4P3AyBHWokj
         of015E2UcApm4t4VU126WWvCBJk8CCh3wxGIFOd+nnVG0tEMadLYrxcNVHkEf9TX4HKI
         eYKWXVXNjUEKULM5bhGy0FnFjCBPy5668qW2vFnvbTiLmtVxm18E4zPi/WeTAMNs1UiA
         2qFj70IJ/P1O7t3ZJeuSGU50ebR7FqhTo7Ln61ECPj/EnPEqnd17GaT4RoxqFedpGNcc
         3ckA==
X-Gm-Message-State: APjAAAWOImUkJ10hvQFP3PYzL3vbfEwEGriv0/QRP9xSedWwu/79W6Bk
        1NdbzrAPPWJorNqJZiEOB7ACyw==
X-Google-Smtp-Source: APXvYqwf375WULCwusJ+w2WqIGyFQJ+5ywUjjXQdIANwh3dUOfwZ6FjWrb2H7osbTGz/zBDh8QCbOA==
X-Received: by 2002:a63:a707:: with SMTP id d7mr26553134pgf.93.1580247218923;
        Tue, 28 Jan 2020 13:33:38 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id g10sm26067pgh.35.2020.01.28.13.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 13:33:38 -0800 (PST)
Date:   Tue, 28 Jan 2020 13:33:36 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org
Subject: Re: [RFC v3 04/10] OPP: Add and export helper to update voltage
Message-ID: <20200128213336.GH46072@google.com>
References: <20200127200350.24465-1-sibis@codeaurora.org>
 <20200127200350.24465-5-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200127200350.24465-5-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sibi,

On Tue, Jan 28, 2020 at 01:33:44AM +0530, Sibi Sankar wrote:
> Add and export 'dev_pm_opp_update_voltage' to find and update voltage
> of an opp for a given frequency. This will be useful to update the opps
> with voltages read back from firmware.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/opp/core.c     | 55 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h | 10 ++++++++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 9aa2a44a5d638..f241e83ec926a 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2503,6 +2503,61 @@ int dev_pm_opp_disable(struct device *dev, unsigned long freq)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_disable);
>  
> +/**
> + * dev_pm_opp_update_voltage() - Find and update voltage

The comment should mention that this is done for an OPP.

Maybe omit the 'find' part here and just say 'Update the voltage of
an OPP'?

> + * @dev:	device for which we do this operation
> + * @freq:	OPP frequency to update voltage
> + * @u_volt:	voltage requested for this opp
> + *
> + * Find and update voltage of a disabled opp corresponding to the given
> + * frequency. This is useful only for devices with single power supply.
> + *
> + * Return: 0 if modification was successful or a negative error value.
> + */
> +int dev_pm_opp_update_voltage(struct device *dev, unsigned long freq,
> +			      unsigned long u_volt)
> +{
> +	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);

initialization is not needed

> +	struct opp_table *opp_table;
> +	unsigned long tol;
> +	int ret = 0;
> +
> +	/* Find the opp_table */

Drop the comment, it's obvious from the code.

> +	opp_table = _find_opp_table(dev);
> +	if (IS_ERR(opp_table)) {
> +		ret = PTR_ERR(opp_table);
> +		dev_err(dev, "%s: OPP table not found (%d)\n", __func__, ret);
> +		return PTR_ERR(opp_table);

  		return ret;

> +	}
> +
> +	opp = dev_pm_opp_find_freq_exact(dev, freq, false);
> +	if (IS_ERR(opp)) {
> +		ret = PTR_ERR(opp);
> +		goto put_table;
> +	}
> +
> +	mutex_lock(&opp_table->lock);
> +
> +	/* update only if the opp is disabled */
> +	if (opp->available) {
> +		ret = -EBUSY;
> +		goto unlock;
> +	}
> +
> +	tol = u_volt * opp_table->voltage_tolerance_v1 / 100;
> +	opp->supplies[0].u_volt_min = u_volt - tol;
> +	opp->supplies[0].u_volt = u_volt;
> +	opp->supplies[0].u_volt_min = u_volt + tol;

  			.u_volt_max =

I suppose the assignments need to be done for all possible supplies,
i.e. 0 to (opp_table->regulator_count - 1).
