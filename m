Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428E531EA4F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 14:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhBRNPN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 08:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhBRLDR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 06:03:17 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773D5C061756
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 03:00:16 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id c11so1029337pfp.10
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 03:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WrPoxiKuB7nFteTe2ry4Rsr+lVl96TDbyIvoScKzpUk=;
        b=u0JdY0rnRdgJqcQlsb1zFqwcow3ij+/ooaP2EcpEjj0IFYGHhHHbw0bgxBpFKS813P
         OaHrpV8yO9E/OTE+uNVScWHnq+P4SdI9V8+wen8G8elqdLIQIv/37L6YaEApaKLvroDt
         suLfDqUGqJiWNORsLDOPg4H1lW9eeIeD47R9F5uu+CLrzSxA6TeqzPMcPcFiV1cvnI34
         kA9/kOl06oiJq0nt5GKDQNYY11xD86DUM5CVfUqmmWWF79WE+ehrJMybNFsoOVac0ezP
         yY9/aAsWN1KI4coFivxUk4N2td3mLjpGW9dRnecKQEsbNr0hbzsV41QIuL56hHOlRZTP
         syQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WrPoxiKuB7nFteTe2ry4Rsr+lVl96TDbyIvoScKzpUk=;
        b=jbeahjf5i/IAWydUnYXWarHg4vALIUv5tNeeksKNNm/7dbWuI1mSSQSJerQEbU9CJP
         BMfJdLAJVpqyocB7vMbWa6TeM7AsrJodjkhBRUaJzj/xDy72jrYBftyMeiW+wDnapZ09
         fjKUFK4USzVtRuIKYE9doVIKP5IeKnzajOT4ta9X++P/MWrWrpoKMzGWMW0nVaaE/uhL
         UscyXpIafwYSGlDd5jto0uJoxqJP/Q9Qc9/KzpR/09YcOAiE0EPykK54ltXddScjg3ax
         lov5cBHbf9FZhj3pkmqgFnOn9gepFYDrc9dxQo0RgGxKuZ5Uc77K0+cR+KeqZmZzkKDE
         Z0ow==
X-Gm-Message-State: AOAM530fIOfXoTo9j6W1kyEGfcs80VHZAhM0oYjF8lsLkYFIHtFno0en
        scgeq3qxXVx9SHEQGqh9CIxPrA==
X-Google-Smtp-Source: ABdhPJzCCZYNRKK7AWJkW25UkQ5W6waaRkg3G2H5FiP8f7b3uTCeGKCRbXiVu2cw+vZ4+vozE01Y2Q==
X-Received: by 2002:a05:6a00:22d1:b029:1b4:9bb5:724c with SMTP id f17-20020a056a0022d1b02901b49bb5724cmr3849255pfj.63.1613646015953;
        Thu, 18 Feb 2021 03:00:15 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id k11sm5301393pfc.22.2021.02.18.03.00.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2021 03:00:15 -0800 (PST)
Date:   Thu, 18 Feb 2021 16:30:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        vireshk@kernel.org, cristian.marussi@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        ionela.voinescu@arm.com
Subject: Re: [PATCH v7 2/3] scmi-cpufreq: Get opp_shared_cpus from opp-v2 for
 EM
Message-ID: <20210218110013.2b4ow7fzldra2srj@vireshk-i7>
References: <20210215075139.30772-1-nicola.mazzucato@arm.com>
 <20210215075139.30772-3-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215075139.30772-3-nicola.mazzucato@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-02-21, 07:51, Nicola Mazzucato wrote:
> +	/*
> +	 * Add OPPs only on those CPUs for which we haven't already done so.
> +	 */
>  	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);

Please add a more detailed comment here explaining why you expect OPPs
to be present here in advance. i.e. you _may_ have policy per CPU even
though OPP core says OPPs are shared.. It is not straight forward to
catch otherwise.

>  	if (nr_opp <= 0) {
> -		dev_err(cpu_dev, "%s: No OPPs for this device: %d\n",
> -			__func__, ret);
> -
> -		ret = -ENODEV;
> -		goto out_free_priv;
> +		ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
> +		if (ret) {
> +			dev_warn(cpu_dev, "failed to add opps to the device\n");
> +			goto out_free_cpumask;
> +		}
> +
> +		nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
> +		if (nr_opp <= 0) {
> +			dev_err(cpu_dev, "%s: No OPPs for this device: %d\n",
> +				__func__, ret);
> +
> +			ret = -ENODEV;
> +			goto out_free_opp;
> +		}
> +
> +		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, opp_shared_cpus);
> +		if (ret) {
> +			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
> +				__func__, ret);
> +
> +			goto out_free_opp;
> +		}
> +
> +		power_scale_mw = handle->perf_ops->power_scale_mw_get(handle);
> +		em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb,
> +					    opp_shared_cpus, power_scale_mw);
>  	}

-- 
viresh
