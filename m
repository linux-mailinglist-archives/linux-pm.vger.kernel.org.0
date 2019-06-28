Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCF2595F3
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 10:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfF1IVN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 04:21:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38094 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfF1IVN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2019 04:21:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 843B260A97; Fri, 28 Jun 2019 08:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561710071;
        bh=DUTnoso3ufA4MhkXdernXX1YENEFNFy5QNH6KtLrySk=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=E19EzpEiPbCL0t/uq/p8dSMIe2WMRwZtyxsXvtf0dRo6e6DY3JFK2HKDQ1Huwupkd
         DWC7T1Z+femCUCWXr4xrII3jbQrDLNLdrgT7LgMCssVLxTxtune38scVw/Gnj4Fes/
         WACCpTvgECtrH4gkF+BYl857A3AfwLVus5Vyt2E4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.105] (unknown [106.51.23.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B63516070D;
        Fri, 28 Jun 2019 08:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561710070;
        bh=DUTnoso3ufA4MhkXdernXX1YENEFNFy5QNH6KtLrySk=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=YaCExwjq7MnUI2jcch7FOrh58awaSB0cTm9dLpwUpCm+Pg7uloRzVPneVgXv9+AqP
         hWme1R8+xoErirY22CDZ+zxssG+unwx9Qica+8hmrEsfFnqLvm12UiG0AaXVt51P4C
         vMkDShRc1QF9hm46mkvTHOuWZ/5VPEVoeuxw7Egk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B63516070D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH RFC 1/4] OPP: Add and export helper to update voltage
To:     Sibi Sankar <sibis@codeaurora.org>, viresh.kumar@linaro.org,
        nm@ti.com, sboyd@kernel.org, georgi.djakov@linaro.org
Cc:     agross@kernel.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        saravanak@google.com
References: <20190627133424.4980-1-sibis@codeaurora.org>
 <20190627133424.4980-2-sibis@codeaurora.org>
Message-ID: <a4e6bc37-9b45-16a6-f2d1-05df498f18b8@codeaurora.org>
Date:   Fri, 28 Jun 2019 13:50:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190627133424.4980-2-sibis@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/27/2019 7:04 PM, Sibi Sankar wrote:
> Add and export 'dev_pm_opp_update_voltage' to find and update voltage
> of an opp for a given frequency. This will be useful to update the opps
> with voltages read back from firmware.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>   drivers/opp/core.c     | 52 ++++++++++++++++++++++++++++++++++++++++++
>   include/linux/pm_opp.h | 10 ++++++++
>   2 files changed, 62 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 68551d6366e6b..c85c04dc2c7de 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2197,6 +2197,58 @@ int dev_pm_opp_disable(struct device *dev, unsigned long freq)
>   }
>   EXPORT_SYMBOL_GPL(dev_pm_opp_disable);
>   
> +/**
> + * dev_pm_opp_update_voltage() - Find and update voltage
> + * @dev:	device for which we do this operation
> + * @freq:	OPP frequency to update voltage
> + * @u_volt:	voltage requested for this opp
> + *
> + * Find and update voltage of a disabled opp corresponding to the given
> + * frequency. This is useful only for devices with single power supply.
> + *
> + * Return: 0 if no modification was done OR modification was
> + * successful or a negative error value.
> + */
> +int dev_pm_opp_update_voltage(struct device *dev, unsigned long freq,
> +			      unsigned long u_volt)
> +{
> +	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
> +	struct opp_table *opp_table;
> +	unsigned long tol;
> +	int ret = 0;
> +
> +	opp = dev_pm_opp_find_freq_exact(dev, freq, false);
> +	if (IS_ERR(opp))
> +		return PTR_ERR(opp);
> +
> +	/* Find the opp_table */
> +	opp_table = _find_opp_table(dev);

maybe you should look for the opp_table first and then the
opp? otherwise this check seems pretty redundant given the
above call would have failed if the opp table did not exist.

> +	if (IS_ERR(opp_table)) {
> +		ret = PTR_ERR(opp_table);
> +		dev_err(dev, "%s: OPP table not found (%d)\n", __func__, ret);
> +		goto put_opp;
> +	}
> +
> +	mutex_lock(&opp_table->lock);
> +
> +	/* update only if the opp is disabled */
> +	if (opp->available)
> +		goto unlock;

should this throw a warning/error to indicate someone tried to
update this at a wrong time? and perhaps return an error instead of
success.

> +
> +	tol = u_volt * opp_table->voltage_tolerance_v1 / 100;
> +	opp->supplies[0].u_volt_min = u_volt - tol;
> +	opp->supplies[0].u_volt = u_volt;
> +	opp->supplies[0].u_volt_min = u_volt + tol;
> +
> +unlock:
> +	mutex_unlock(&opp_table->lock);
> +	dev_pm_opp_put_opp_table(opp_table);
> +put_opp:
> +	dev_pm_opp_put(opp);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_update_voltage);
> +
>   /**
>    * dev_pm_opp_register_notifier() - Register OPP notifier for the device
>    * @dev:	Device for which notifier needs to be registered
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 87fa09d93d8c2..a17c462974851 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -130,6 +130,9 @@ int dev_pm_opp_enable(struct device *dev, unsigned long freq);
>   
>   int dev_pm_opp_disable(struct device *dev, unsigned long freq);
>   
> +int dev_pm_opp_update_voltage(struct device *dev, unsigned long freq,
> +			      unsigned long u_volt);
> +
>   int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb);
>   int dev_pm_opp_unregister_notifier(struct device *dev, struct notifier_block *nb);
>   
> @@ -261,6 +264,13 @@ static inline int dev_pm_opp_disable(struct device *dev, unsigned long freq)
>   	return 0;
>   }
>   
> +static inline int dev_pm_opp_update_voltage(struct device *dev,
> +					    unsigned long freq,
> +					    unsigned long u_volt)
> +{
> +	return 0;
> +}
> +
>   static inline int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb)
>   {
>   	return -ENOTSUPP;
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
