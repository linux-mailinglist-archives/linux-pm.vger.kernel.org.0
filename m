Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8382F9D16
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 11:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbhARKrE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 05:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389363AbhARJzH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 04:55:07 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5164C0613CF
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 01:53:00 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id y205so4067019pfc.5
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 01:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CWOcyAd+BnAljd4w5vN8wSaVPuWlQlW/u40lZ+Q7vBU=;
        b=ZbiVTp1iLgLFYHgQbYW+SvB6DjVh2Ujr25KRKYZMk/IzDGqcGfRe7sjmMcqN8NajiB
         LyFBfPoh2Gu5y30iQn+kpc2PnIZbSsCvxuTEKtBqCNXJ8SJSIA2UmZn0YCFZJsPOjCOg
         ZmLIy95flChXuXujGaJQ9jHxFTF5fx0bZbBhxo0Rrmg8Mhh6yNXhqKmEZvNlVxjStwiO
         zsGUvLEs0/MD3dv42KYYcSniuge0VBkkQXVnEiRHOnyCneAeUdeKubM1OQvkXAX8Jjyx
         h8whRC0F1EKjXu7Xs+I9bhnimBeZhlxiGqM/jk7wdz87xJdSsZlRxzRO/J+ZMTkoGK5M
         cHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CWOcyAd+BnAljd4w5vN8wSaVPuWlQlW/u40lZ+Q7vBU=;
        b=P3OGe9NdEwBrqVz3fMEBB0JQFepzZPye1dQ8i6QHej+XRgPAtL5OizZkW4CtYDCj5e
         cGRoHnNQB+jS/mc0ntrXSxMtddzyAoi++biMN4Q6m8iKI8SSZ6tFczxmayhwgvmH1vyb
         b/goyOeTR6AzFvEiMDndXhah59YOdornwNulE9uMMX/Br0TwlsgFmpeuZCe4uNf5c+k2
         0BFTKmg6twzaVuAmJYagySW1LepAUvFAM8voKzuGcPeON0wxQKkULzWuyPCjExGaP+dQ
         nqcY7A9fRxVN2M4pYjFcJn23zMgPIVn4OcnExJkMfww7nhokER9MT1OYI17O6PtF9zGx
         fB9Q==
X-Gm-Message-State: AOAM533YUpF6ium484GzKpPMZmU/mB5k9CQepg1B1COd6SuNgSrciIo1
        57waMLASaaQPg3ir24H76tehXw==
X-Google-Smtp-Source: ABdhPJzEAyxmVvD6lV19ZCH+dSQU73H+CVsi2eHjsrFo4Xoflvj3xKLckEqcptAVGVi+SvQxJGw8gA==
X-Received: by 2002:a65:49cf:: with SMTP id t15mr25304385pgs.77.1610963580220;
        Mon, 18 Jan 2021 01:53:00 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id f29sm15149252pgm.76.2021.01.18.01.52.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 01:52:59 -0800 (PST)
Date:   Mon, 18 Jan 2021 15:22:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 05/12] opp: Add dev_pm_opp_set_voltage()
Message-ID: <20210118095256.tr2qgnrmokkc6ngf@vireshk-i7>
References: <20210118005524.27787-1-digetx@gmail.com>
 <20210118005524.27787-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118005524.27787-6-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-01-21, 03:55, Dmitry Osipenko wrote:
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 99d18befc209..341484d58e6c 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2731,3 +2731,58 @@ int dev_pm_opp_sync_regulators(struct device *dev)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_sync_regulators);
> +
> +/**
> + * dev_pm_opp_set_voltage() - Change voltage of regulators
> + * @dev:	device for which we do this operation
> + * @opp:	opp based on which the voltages are to be configured
> + *
> + * Change voltage of the OPP table regulators.
> + *
> + * Return: 0 on success or a negative error value.
> + */
> +int dev_pm_opp_set_voltage(struct device *dev, struct dev_pm_opp *opp)

I think we should do better than this, will require some work from
your part though (or I can do it if you want).

Basically what you wanted to do here is set the OPP for a device and
this means do whatever is required for setting the OPP. It is normally
frequency, which is not your case, but it is other things as well.
Like setting multiple regulators, bandwidth, required-opps, etc.

I feel the right way of doing this would be to do this:

Factor out dev_pm_opp_set_opp() from dev_pm_opp_set_rate() and make
the later call the former. And then we can just call
dev_pm_opp_set_opp() from your usecase. This will make sure we have a
single code path for all the set-opp stuff. What do you think ?

-- 
viresh
