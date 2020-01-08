Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1FB13404B
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 12:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgAHLTw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 06:19:52 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45600 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgAHLTw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 06:19:52 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so1449349pfg.12
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2020 03:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cOGvD7y5HQkBlYF9N0NkWtEGiRyDw5Hk/20diZQAQAA=;
        b=I/QT89u9dGq6KzbLwqtEEmn/0AiFljz/rRwWBalIGmgNls+lZ9nYd5DXSIv9m05O2Z
         SZKKVkwM3oOOZODQB1o592LcPoEvG7Ja7SL0pSrPQSloyXq9KBwWsHOBATXFlx7mrNEE
         oueZQP/zINGY37BWRcZ+BZGgNt4BEFuYBFhqDFY6DfFXYINZNNIAqjsij2h7BhluqmYJ
         MY6lk9SKV67tqYvS4NcOvT9FKs9ZrmuKS9g/3KM15PGlNE3DI3Z/rk8NOG6z66HOAwAM
         Yi0mLF/L6qJBN1ZQDoWMOAzD8/Nno07zII52xCpgJ/ah9SXNXLBZf707rByTlpFQ5ldx
         R8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cOGvD7y5HQkBlYF9N0NkWtEGiRyDw5Hk/20diZQAQAA=;
        b=KGXRHwKTXpKem+Ea6is/U0pnjKQummAaX7aFiPjBq1Zhe1TJcqtH+W64k6YqkdSBuY
         efpcQINmZBwtg1WKVxBpbhGGM8uApRHX7V3OFLAR1rjwqfKu4Y0QL2XBLEnxaLEAXoAw
         sEbAhylt1kmPNwLeoDKWOv+57VvNv0j7XZa/2K++3wN7D58HGPUnk/KbxcPMILnJ7IHP
         DmZ9bR35Sp3hXH1/PDZvzXd9pzlJvZiAduQ1OSrhcJ6GTJzBqqrAO0d+kkasLPSsyspT
         Ne1m+UhAPszpdszMWf/4l31rUXEGR3I53R0XRN8xOiKT2e2T6SPDEbYNljL/OGsYJdmB
         ecQw==
X-Gm-Message-State: APjAAAUWG1/tjIkAPYxTvDbGDGE3Oz6NBFaYuRvMj/t9mGFgeEcGZDGv
        vNB7ZCjp95mtxiFh6F0hZdjUKQ==
X-Google-Smtp-Source: APXvYqzywDkjkEjHqoRKd7VAHnkY87bW3tIFt9/TraoWF+Ti+CuLoHpFVbqgQ0f1lIJZz3L5tlYXog==
X-Received: by 2002:a63:201d:: with SMTP id g29mr4778115pgg.427.1578482390987;
        Wed, 08 Jan 2020 03:19:50 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id o7sm3513384pfg.138.2020.01.08.03.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 03:19:49 -0800 (PST)
Date:   Wed, 8 Jan 2020 16:49:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] OPP: Add helper function for bandwidth OPP tables
Message-ID: <20200108111947.q5aafrlz26tnk3nq@vireshk-i7>
References: <20191207002424.201796-1-saravanak@google.com>
 <20191207002424.201796-4-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191207002424.201796-4-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-12-19, 16:24, Saravana Kannan wrote:
> The frequency OPP tables have helper functions to search for entries in the
> table based on frequency and get the frequency values for a given (or
> suspend) OPP entry.
> 
> Add similar helper functions for bandwidth OPP tables to search for entries
> in the table based on peak bandwidth and to get the peak and average
> bandwidth for a given (or suspend) OPP entry.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/opp/core.c     | 301 +++++++++++++++++++++++++++++++++++------
>  include/linux/pm_opp.h |  43 ++++++
>  2 files changed, 305 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index c79bbfac7289..3ff33a08198e 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -127,6 +127,29 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
>  
> +/**
> + * dev_pm_opp_get_bw() - Gets the bandwidth corresponding to an available opp
> + * @opp:	opp for which peak bandwidth has to be returned for

s/peak //

> + * @avg_bw:	Pointer where the corresponding average bandwidth is stored.
> + *		Can be NULL.
> + *
> + * Return: Peak bandwidth in kBps corresponding to the opp, else
> + * return 0
> + */
> +unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp, unsigned long *avg_bw)
> +{
> +	if (IS_ERR_OR_NULL(opp) || !opp->available) {
> +		pr_err("%s: Invalid parameters\n", __func__);
> +		return 0;
> +	}
> +
> +	if (avg_bw)

Do you see this being NULL in practice ? If no, then we can make it
mandatory for now ?

> +		*avg_bw = opp->avg_bw;
> +
> +	return opp->peak_bw;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_get_bw);
> +
>  /**
>   * dev_pm_opp_get_level() - Gets the level corresponding to an available opp
>   * @opp:	opp for which level value has to be returned for
> @@ -299,6 +322,34 @@ unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_freq);
>  
> +/**
> + * dev_pm_opp_get_suspend_opp_bw() - Get peak bandwidth of suspend opp in kBps

Hmm, I wasn't expecting this. So the interconnects will also have a
suspend OPP ?

> + * @dev:	device for which we do this operation
> + * @avg_bw:	Pointer where the corresponding average bandwidth is stored.
> + *		Can be NULL.
> + *
> + * Return: This function returns the peak bandwidth of the OPP marked as
> + * suspend_opp if one is available, else returns 0;
> + */
> +unsigned long dev_pm_opp_get_suspend_opp_bw(struct device *dev,
> +					    unsigned long *avg_bw)
> +{
> +	struct opp_table *opp_table;
> +	unsigned long peak_bw = 0;
> +
> +	opp_table = _find_opp_table(dev);
> +	if (IS_ERR(opp_table))
> +		return 0;
> +
> +	if (opp_table->suspend_opp && opp_table->suspend_opp->available)
> +		peak_bw = dev_pm_opp_get_bw(opp_table->suspend_opp, avg_bw);
> +
> +	dev_pm_opp_put_opp_table(opp_table);
> +
> +	return peak_bw;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_bw);
> +
>  int _get_opp_count(struct opp_table *opp_table)
>  {
>  	struct dev_pm_opp *opp;
> @@ -343,6 +394,40 @@ int dev_pm_opp_get_opp_count(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
>  

I think we should add function header here instead of the helpers
which get exact match for freq, bw or level. And then pass a enum
value to it, which tells what we are looking to compare. After that
rest of the routines will be just one liners, make them macros in
header file itself.

> +struct dev_pm_opp *dev_pm_opp_find_opp_exact(struct device *dev,
> +					      struct dev_pm_opp *opp_key,
> +					      bool available)

-- 
viresh
