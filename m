Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4750ABBB9
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2019 17:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfIFPFp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 11:05:45 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40683 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfIFPFp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Sep 2019 11:05:45 -0400
Received: by mail-qt1-f195.google.com with SMTP id g4so7381632qtq.7
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2019 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=H4eRmWROWdXfwod6zKbIROxX1pbo/7j0i9BGt6Sm3Uo=;
        b=HgygfqYdiHJz8kdz1AdDE3O6yJVISx9thjokxuZpQdbnDVdg7UfzNO2d9JeO4RhClo
         vmNBKbWt8GiPxIbeU92Fbxn26oGZFcdwsH9Yt0y3TVIYlun+V50rpEMXfJGMWLyjDo9Y
         T15R3vdQ4hL9LecJEaOOVGtV8HcUgicsNzDs/RyN3GExa8hcB5+VMPAHuyqPvsUFvFLs
         o7BqapbCb9N+exXhCNcZw3tGqKf6qBHv98vT42oUeYLua9XkiyVQyQuTp2O5j5DuEC+2
         d5hUtlgazMP3pav56q1T6Ky4mHn0koU1lWweU4vilyyInPMmcBcDJlUiw/lENBklv2YN
         GeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=H4eRmWROWdXfwod6zKbIROxX1pbo/7j0i9BGt6Sm3Uo=;
        b=FBs3rNv6ts89az8gcMNHWW3SoNpfUhUHbVOqI9JKbgyKPzUJvdkBoKwWc8EbD3P1rd
         5VEvOd9bUnP0rCaFcHmKvZnnhdfTpqLyFjH2S9+oHpZTGQTiXKlQAqQZY0Q3FhksRJV/
         41kfbt74mxz2dTUuGu4HZz1EmOhSfegGNFLG8EuDH98sgGsR1wdp+G//pG6DD4j6CydM
         tPn/7bXtTs25CBeMFLWYNJx1FhVJebk6kpQsZfpNJMefrxpmT7LJmJKW3SEiyH6O96qx
         xrTikLee31SbhJyZcDDPhMtoaWJcRQSKXnJPMqNIqDImxl3bhPehhBPhIhDSxJY4PI8i
         Eapw==
X-Gm-Message-State: APjAAAU2P3P/+p5OvyLoWLZWuP1++317/7Y+dmE9lsOsfZ6bP13mjlwh
        Pxa9PNIFB1kK1uPPN/5spQ0Kdg==
X-Google-Smtp-Source: APXvYqyvQkUQAYMkInSSrRRf5HELm4DEorpUQ/PTIkfSFmLFnBri7ucWQWqnDn9AfTKL8IC+FDKiFA==
X-Received: by 2002:ac8:2392:: with SMTP id q18mr9742127qtq.261.1567782343665;
        Fri, 06 Sep 2019 08:05:43 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id f4sm2105056qth.6.2019.09.06.08.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 08:05:40 -0700 (PDT)
Subject: Re: [PATCH 3/4] thermal: qcom: Add RPMHPD cooling device driver.
To:     Zhang Rui <rui.zhang@intel.com>, qualcomm-lt@lists.linaro.org,
        linux-pm@vger.kernel.org
References: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org>
 <1565398727-23090-4-git-send-email-thara.gopinath@linaro.org>
 <7edecd2667319e7d5d3366996ac06bf596e0f39b.camel@intel.com>
Cc:     bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        rnayak@codeaurora.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5D7275C1.8000103@linaro.org>
Date:   Fri, 6 Sep 2019 11:05:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <7edecd2667319e7d5d3366996ac06bf596e0f39b.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/28/2019 08:23 AM, Zhang Rui wrote:
> On Fri, 2019-08-09 at 20:58 -0400, Thara Gopinath wrote:
>> The MX power domain in RPMH can be used to warm the
>> the SoC in SDM845. To support this feature, introduce
>> a RPMH power domain cooling device driver that can be
>> plugged into the thermal framework.(The thermal framework
>> itself requires further modifiction to support a warming
>> device in place of a cooling device. Those extensions are
>> not introduced in this patch series).
> 
> I'm wondering how this device is used, as well as the thermal extension
> changes needed. To me, it's better to see this patch together with the
> thermal extension changes.
Hello Rui,

I somehow missed this email. I am sorry about that.

IMHO, the thermal extensions, needed would be
1. Extend the dt-bindings either in the thermal-zone or in the trip
description to indicate whether a zone/trip is being monitored for
rising/falling temperature
2. Changes in thermal-core and the governors(starting with step-wise) to
monitor falling temperature as well.

There are comments for this patch series like fixing the genpd
extensions I have proposed and making the warming device more generic.
So I will post a v2 for this anyways.

I have some proto-type for the above mentioned extensions. I will post
them out asap.

Again, apologies for missing this email

Regards
Thara

> 
> thanks,
> rui
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>  drivers/thermal/qcom/Kconfig            |   7 ++
>>  drivers/thermal/qcom/Makefile           |   1 +
>>  drivers/thermal/qcom/qcom-rpmhpd-cdev.c | 141
>> ++++++++++++++++++++++++++++++++
>>  3 files changed, 149 insertions(+)
>>  create mode 100644 drivers/thermal/qcom/qcom-rpmhpd-cdev.c
>>
>> diff --git a/drivers/thermal/qcom/Kconfig
>> b/drivers/thermal/qcom/Kconfig
>> index aa9c1d8..a540130 100644
>> --- a/drivers/thermal/qcom/Kconfig
>> +++ b/drivers/thermal/qcom/Kconfig
>> @@ -20,3 +20,10 @@ config QCOM_SPMI_TEMP_ALARM
>>  	  trip points. The temperature reported by the thermal sensor
>> reflects the
>>  	  real time die temperature if an ADC is present or an estimate
>> of the
>>  	  temperature based upon the over temperature stage value.
>> +
>> +config CONFIG_QCOM_RPMHPD_CDEV
>> +	tristate "Qualcomm RPMHPD based cooling device"
>> +	depends on QCOM_RPMHPD
>> +	help
>> +	  This enables RPMHPD based cooling devices. On SDM845, this is
>> +	  MX power domain.
>> diff --git a/drivers/thermal/qcom/Makefile
>> b/drivers/thermal/qcom/Makefile
>> index 7c8dc6e..e4eb520 100644
>> --- a/drivers/thermal/qcom/Makefile
>> +++ b/drivers/thermal/qcom/Makefile
>> @@ -4,3 +4,4 @@ obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
>>  qcom_tsens-y			+= tsens.o tsens-common.o tsens-v0_1.o
>> \
>>  				   tsens-8960.o tsens-v2.o tsens-v1.o
>>  obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
>> +obj-$(CONFIG_QCOM_RPMHPD_CDEV)		+= qcom-rpmhpd-cdev.o
>> diff --git a/drivers/thermal/qcom/qcom-rpmhpd-cdev.c
>> b/drivers/thermal/qcom/qcom-rpmhpd-cdev.c
>> new file mode 100644
>> index 0000000..265523b
>> --- /dev/null
>> +++ b/drivers/thermal/qcom/qcom-rpmhpd-cdev.c
>> @@ -0,0 +1,141 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2019, Linaro Ltd
>> + */
>> +#include <linux/err.h>
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/module.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/thermal.h>
>> +
>> +struct rpmhpd_cooling_device {
>> +	struct thermal_cooling_device *cdev;
>> +	struct device *pwr_domain;
>> +	int max_state;
>> +	int cur_state;
>> +	bool is_pwr_domain_on;
>> +};
>> +
>> +static const char sdm845_rpmhpd_cdev_name[] = "mx";
>> +
>> +static const struct of_device_id rpmhpd_cdev_match_table[] = {
>> +	{ .compatible = "qcom,sdm845-rpmhpd-cdev", .data =
>> &sdm845_rpmhpd_cdev_name },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, rpmhpd_cdev_match_table);
>> +
>> +static int rpmhpd_cdev_get_max_state(struct thermal_cooling_device
>> *cdev,
>> +				     unsigned long *state)
>> +{
>> +	struct rpmhpd_cooling_device *rpmhpd_cdev = cdev->devdata;
>> +
>> +	*state = rpmhpd_cdev->max_state;
>> +	return 0;
>> +}
>> +
>> +static int rpmhpd_cdev_get_cur_state(struct thermal_cooling_device
>> *cdev,
>> +				     unsigned long *state)
>> +{
>> +	struct rpmhpd_cooling_device *rpmhpd_cdev = cdev->devdata;
>> +	int perf_state;
>> +
>> +	dev_pm_genpd_get_performance_state(rpmhpd_cdev->pwr_domain,
>> +					   &perf_state);
>> +	*state = perf_state;
>> +	return 0;
>> +}
>> +
>> +static int rpmhpd_cdev_set_cur_state(struct thermal_cooling_device
>> *cdev,
>> +				     unsigned long state)
>> +{
>> +	struct rpmhpd_cooling_device *rpmhpd_cdev = cdev->devdata;
>> +	struct device *pwr_domain = rpmhpd_cdev->pwr_domain;
>> +	int ret;
>> +
>> +	ret = dev_pm_genpd_set_performance_state(pwr_domain, state);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (state && !rpmhpd_cdev->is_pwr_domain_on) {
>> +		ret = pm_runtime_get_sync(pwr_domain);
>> +		rpmhpd_cdev->is_pwr_domain_on = true;
>> +	} else if (!state && rpmhpd_cdev->is_pwr_domain_on) {
>> +		ret = pm_runtime_put(pwr_domain);
>> +		rpmhpd_cdev->is_pwr_domain_on = false;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static struct thermal_cooling_device_ops rpmhpd_cooling_device_ops =
>> {
>> +	.get_max_state = rpmhpd_cdev_get_max_state,
>> +	.get_cur_state = rpmhpd_cdev_get_cur_state,
>> +	.set_cur_state = rpmhpd_cdev_set_cur_state,
>> +};
>> +
>> +static int rpmhpd_cdev_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev, *pd_dev;
>> +	struct rpmhpd_cooling_device *rpmhpd_cdev;
>> +	const char *rpmhpd_cdev_name = of_device_get_match_data(dev);
>> +	unsigned int count;
>> +	int ret;
>> +
>> +	if (!dev->pm_domain) {
>> +		pd_dev = dev_pm_domain_attach_by_name(dev,
>> rpmhpd_cdev_name);
>> +		if (IS_ERR(pd_dev))
>> +			return PTR_ERR(pd_dev);
>> +	} else {
>> +		pd_dev = dev;
>> +	}
>> +
>> +	rpmhpd_cdev = devm_kzalloc(dev, sizeof(*rpmhpd_cdev),
>> GFP_KERNEL);
>> +	if (!rpmhpd_cdev) {
>> +		ret = -ENOMEM;
>> +		goto detach_pd;
>> +	}
>> +
>> +	ret = dev_pm_genpd_performance_state_count(pd_dev, &count);
>> +	if (ret)
>> +		goto detach_pd;
>> +
>> +	rpmhpd_cdev->pwr_domain = pd_dev;
>> +	rpmhpd_cdev->max_state = count - 1;
>> +	rpmhpd_cdev->is_pwr_domain_on = false;
>> +
>> +	pm_runtime_enable(pd_dev);
>> +
>> +	rpmhpd_cdev->cdev = thermal_of_cooling_device_register
>> +					(dev->of_node,
>> rpmhpd_cdev_name,
>> +					 rpmhpd_cdev,
>> +					 &rpmhpd_cooling_device_ops);
>> +	if (IS_ERR(rpmhpd_cdev->cdev)) {
>> +		dev_err(dev, "unable to register %s cooling device\n",
>> +			rpmhpd_cdev_name);
>> +		ret = PTR_ERR(rpmhpd_cdev->cdev);
>> +		goto detach_pd;
>> +	}
>> +
>> +	return 0;
>> +
>> +detach_pd:
>> +	dev_pm_domain_detach(pd_dev, false);
>> +	return ret;
>> +}
>> +
>> +static struct platform_driver rpmhpd_cdev_driver = {
>> +	.driver = {
>> +		.name = "qcom-rpmhpd-cdev",
>> +		.of_match_table = rpmhpd_cdev_match_table,
>> +	},
>> +	.probe = rpmhpd_cdev_probe,
>> +};
>> +module_platform_driver(rpmhpd_cdev_driver);
>> +
>> +MODULE_DESCRIPTION("Qualcomm RPMHPD cooling device driver");
>> +MODULE_LICENSE("GPL v2");
> 


-- 
Regards
Thara
