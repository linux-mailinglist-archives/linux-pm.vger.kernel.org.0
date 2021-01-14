Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C712F65A1
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 17:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbhANQTb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 11:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbhANQTa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 11:19:30 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA4EC061757
        for <linux-pm@vger.kernel.org>; Thu, 14 Jan 2021 08:18:50 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id n42so5628165ota.12
        for <linux-pm@vger.kernel.org>; Thu, 14 Jan 2021 08:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=neCDzobYvRj+21LSZnYQ3+mQEK3W3xLbl4DHzCQkpoE=;
        b=qdcKfyMdd2ZL5FVTBvBiW0Y9q1WXjAQXLY7T/X/mTdIvklxxiFI/nBj4yArVNQ2s80
         sTGI9JrUZGSP6lag8/3EqdFjmwyL+dPd/46aaIuuvg/nqK1CKF/dG7IFKeCx7syBo0Vs
         9/D3pOgnnpnX34NZkmYWkeLksJNSP0XS0pAla4dnvwwljsPlhsK1oX6x1imhyilyfBWf
         DosCq5EBtuxW48THGXfDDWWKnsKYaWmqzmPuyenTMJI3snQ9Ad8hw087ZgAUrc2WbG7b
         5hN7Kx0HgHhMOPaqrp/GX2LI9Um/rJayFibtJ7G9e/NEcrUhLzlE1aeaoZ2R6MrpLRiL
         VbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=neCDzobYvRj+21LSZnYQ3+mQEK3W3xLbl4DHzCQkpoE=;
        b=uLLGs46nT+4ykCb53j4DJMVQgYJurjVGYraDuyidvO//kWxfZsj27nFISpj8NvDjxg
         igDKG3OK5CCtRcAaty6IqkBitqgIqKcdab8FUqiQBNgy3YEB5GqfpXcKUBPNNO1xuq5k
         0++tvb1l1tQ5FU2EvWK/BSKKNQG/qiHrsTOcjLXdM2zDbbZd4JF2E81HrWuspJ/mMupP
         j3hvnqMbI7q+ucIxi7qxv++L3/8qRYPDXMseB9kWN7bvHMo/Jx6hByKk/TDWF295l8Bi
         8rZ0D2Pcg7usbEq/2XWE1/BXZVHE89afepjQlFYHbW/ktW8mUX+1rKrP2OOyxq3yFht+
         SMIw==
X-Gm-Message-State: AOAM531I2LItJv736g6i8g3ZfhUuzG4jYR5iW35yNqpLiJu7dDu27JQW
        D7i9b6GyXnFhj21tdXMFldJ66w==
X-Google-Smtp-Source: ABdhPJzteR1wliWItLJ6Kjqz/X+xzfzkx/i2AsfnizsDebea7ZVBLe/0kc2e0xqRXS6eroS+DVt7LQ==
X-Received: by 2002:a05:6830:1e1c:: with SMTP id s28mr4883402otr.82.1610641129851;
        Thu, 14 Jan 2021 08:18:49 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a24sm1129933oop.40.2021.01.14.08.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 08:18:49 -0800 (PST)
Date:   Thu, 14 Jan 2021 10:18:47 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Steev Klimaszewski <steev@kali.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: enable boost support
Message-ID: <YABu560zuq57b8rJ@builder.lan>
References: <20210113065241.23829-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113065241.23829-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed 13 Jan 00:52 CST 2021, Shawn Guo wrote:

> At least on sdm850, the 2956800 khz is detected as a boost frequency in
> function qcom_cpufreq_hw_read_lut().  Let's enable boost support by
> calling cpufreq_enable_boost_support(), so that we can get the boost
> frequency by switching it on via 'boost' sysfs entry like below.
> 
>  $ echo 1 > /sys/devices/system/cpu/cpufreq/boost
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 315ee987d2d3..6eb88463a24e 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -351,6 +351,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  
>  	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
>  
> +	if (policy_has_boost_freq(policy)) {
> +		ret = cpufreq_enable_boost_support();
> +		if (ret)
> +			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
> +	}
> +
>  	return 0;
>  error:
>  	devm_iounmap(dev, base);
> -- 
> 2.17.1
> 
