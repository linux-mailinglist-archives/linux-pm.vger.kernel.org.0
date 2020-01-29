Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35BF614CBB3
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 14:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgA2Ntx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 08:49:53 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:20017 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726271AbgA2Ntu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jan 2020 08:49:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580305789; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=+GsoW3Ht6gEeRhdmfArROpfXpxG5uRnhOhHDj5W5KcU=;
 b=OnfUsUx5a8ARUFxGeBT6wJgJosGS85mVqHeNqjOSpfGJwsIRBSCCHY3yil4Ktl25hxNWBIgA
 oR+zA+BIy4dnf2rzgcSVBbkMLRE0xAFk+l94A7wD965RKp8tOLVgv0ku2QuEZAsyf7zfNhPB
 2oUZa9wpA0yX/O3zDuMXdACuSWI=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e318d7c.7fbed6630ca8-smtp-out-n01;
 Wed, 29 Jan 2020 13:49:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 56EB5C447A1; Wed, 29 Jan 2020 13:49:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 80EC3C43383;
        Wed, 29 Jan 2020 13:49:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Jan 2020 19:19:47 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
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
In-Reply-To: <20200128213336.GH46072@google.com>
References: <20200127200350.24465-1-sibis@codeaurora.org>
 <20200127200350.24465-5-sibis@codeaurora.org>
 <20200128213336.GH46072@google.com>
Message-ID: <634183c54f18b4500da6aa16e9cf4185@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-01-29 03:03, Matthias Kaehlcke wrote:
> Hi Sibi,
> 
> On Tue, Jan 28, 2020 at 01:33:44AM +0530, Sibi Sankar wrote:
>> Add and export 'dev_pm_opp_update_voltage' to find and update voltage
>> of an opp for a given frequency. This will be useful to update the 
>> opps
>> with voltages read back from firmware.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  drivers/opp/core.c     | 55 
>> ++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/pm_opp.h | 10 ++++++++
>>  2 files changed, 65 insertions(+)
>> 
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index 9aa2a44a5d638..f241e83ec926a 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -2503,6 +2503,61 @@ int dev_pm_opp_disable(struct device *dev, 
>> unsigned long freq)
>>  }
>>  EXPORT_SYMBOL_GPL(dev_pm_opp_disable);
>> 
>> +/**
>> + * dev_pm_opp_update_voltage() - Find and update voltage
> 
> The comment should mention that this is done for an OPP.
> 
> Maybe omit the 'find' part here and just say 'Update the voltage of
> an OPP'?

sure makes sense

> 
>> + * @dev:	device for which we do this operation
>> + * @freq:	OPP frequency to update voltage
>> + * @u_volt:	voltage requested for this opp
>> + *
>> + * Find and update voltage of a disabled opp corresponding to the 
>> given
>> + * frequency. This is useful only for devices with single power 
>> supply.
>> + *
>> + * Return: 0 if modification was successful or a negative error 
>> value.
>> + */
>> +int dev_pm_opp_update_voltage(struct device *dev, unsigned long freq,
>> +			      unsigned long u_volt)
>> +{
>> +	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
> 
> initialization is not needed
> 
>> +	struct opp_table *opp_table;
>> +	unsigned long tol;
>> +	int ret = 0;
>> +
>> +	/* Find the opp_table */
> 
> Drop the comment, it's obvious from the code.
> 
>> +	opp_table = _find_opp_table(dev);
>> +	if (IS_ERR(opp_table)) {
>> +		ret = PTR_ERR(opp_table);
>> +		dev_err(dev, "%s: OPP table not found (%d)\n", __func__, ret);
>> +		return PTR_ERR(opp_table);
> 
>   		return ret;

missed that :(

> 
>> +	}
>> +
>> +	opp = dev_pm_opp_find_freq_exact(dev, freq, false);
>> +	if (IS_ERR(opp)) {
>> +		ret = PTR_ERR(opp);
>> +		goto put_table;
>> +	}
>> +
>> +	mutex_lock(&opp_table->lock);
>> +
>> +	/* update only if the opp is disabled */
>> +	if (opp->available) {
>> +		ret = -EBUSY;
>> +		goto unlock;
>> +	}
>> +
>> +	tol = u_volt * opp_table->voltage_tolerance_v1 / 100;
>> +	opp->supplies[0].u_volt_min = u_volt - tol;
>> +	opp->supplies[0].u_volt = u_volt;
>> +	opp->supplies[0].u_volt_min = u_volt + tol;
> 
>   			.u_volt_max =
> 
> I suppose the assignments need to be done for all possible supplies,
> i.e. 0 to (opp_table->regulator_count - 1).

a single value for all possible
supplies seems wrong. Anyway
will wait to see what Viresh
thinks about it.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
