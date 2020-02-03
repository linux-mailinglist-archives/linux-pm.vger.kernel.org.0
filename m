Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17F9815069F
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2020 14:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgBCNLj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Feb 2020 08:11:39 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:43386 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727526AbgBCNLg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Feb 2020 08:11:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580735495; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=vkyTdOaRH1ioFtJvRUXIFVkHYEEyCnAk8WaTMV+sKk4=; b=kieC8vJacnljFapjibpGYKaj7q9tU8iNY20Huze2ChLp6im2aZGQzy7nNg4weLjM76+dCns8
 3kWqtIq3JeXgp/6vHyBhEVfIx4UmG91E4PdTSeJo35AsRmHjRolh8iVmBgBkAhy01MUkLUsa
 gynIwzxAYjjBSUFqvJEnvkHybkM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e381c06.7fc5a7bc37d8-smtp-out-n02;
 Mon, 03 Feb 2020 13:11:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 39582C433CB; Mon,  3 Feb 2020 13:11:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.206.13.37] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B3FB2C43383;
        Mon,  3 Feb 2020 13:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3FB2C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [PATCH v2 4/6] drivers: qcom: rpmh-rsc: Add RSC power domain
 support
To:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org
References: <20190823081703.17325-1-mkshah@codeaurora.org>
 <20190823081703.17325-5-mkshah@codeaurora.org>
 <5d7146be.1c69fb81.38760.7fb8@mx.google.com>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <d6ec3b9e-ed3c-3b6d-f313-1c5acbc786d1@codeaurora.org>
Date:   Mon, 3 Feb 2020 18:41:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <5d7146be.1c69fb81.38760.7fb8@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 9/5/2019 11:02 PM, Stephen Boyd wrote:
> Quoting Maulik Shah (2019-08-23 01:17:01)
>> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>> index e278fc11fe5c..884b39599e8f 100644
>> --- a/drivers/soc/qcom/rpmh-rsc.c
>> +++ b/drivers/soc/qcom/rpmh-rsc.c
>> @@ -498,6 +498,32 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
>>          return ret;
>>   }
>>   
>> +/**
>> + *  rpmh_rsc_ctrlr_is_idle: Check if any of the AMCs are busy.
>> + *
>> + *  @drv: The controller
>> + *
>> + *  Returns false if the TCSes are engaged in handling requests,
> Please use kernel-doc style for returns here.
Done.
>> + *  True if controller is idle.
>> + */
>> +static bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv)
>> +{
>> +       int m;
>> +       struct tcs_group *tcs = get_tcs_of_type(drv, ACTIVE_TCS);
>> +       bool ret = true;
>> +
>> +       spin_lock(&drv->lock);
> I think these need to be irqsave/restore still.
Done.
>> +       for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
>> +               if (!tcs_is_free(drv, m)) {
> This snippet is from tcs_invalidate(). Please collapse it into some sort
> of function or macro like for_each_tcs().
Keeping it as it is, the snippet is actually little different from 
tcs_invalidate.
>> +                       ret = false;
>> +                       break;
>> +               }
>> +       }
>> +       spin_unlock(&drv->lock);
>> +
>> +       return ret;
>> +}
>> +
>>   /**
>>    * rpmh_rsc_write_ctrl_data: Write request to the controller
>>    *
>> @@ -521,6 +547,53 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
>>          return tcs_ctrl_write(drv, msg);
>>   }
>>   
>> +static int rpmh_domain_power_off(struct generic_pm_domain *rsc_pd)
>> +{
>> +       struct rsc_drv *drv = container_of(rsc_pd, struct rsc_drv, rsc_pd);
>> +
>> +       /*
>> +        * RPMh domain can not be powered off when there is pending ACK for
>> +        * ACTIVE_TCS request. Exit when controller is busy.
>> +        */
>> +
> Nitpick: Remove this extra newline.
Done.
>> +       if (!rpmh_rsc_ctrlr_is_idle(drv))
>> +               return -EBUSY;
>> +
>> +       return rpmh_flush(&drv->client);
>> +}
>> +
>> +static int rpmh_probe_power_domain(struct platform_device *pdev,
>> +                                  struct rsc_drv *drv)
>> +{
>> +       int ret;
>> +       struct generic_pm_domain *rsc_pd = &drv->rsc_pd;
>> +       struct device_node *dn = pdev->dev.of_node;
>> +
>> +       rsc_pd->name = kasprintf(GFP_KERNEL, "%s", dn->name);
> Maybe use devm_kasprintf?
Done.
>> +       if (!rsc_pd->name)
>> +               return -ENOMEM;
>> +
>> +       rsc_pd->name = kbasename(rsc_pd->name);
>> +       rsc_pd->power_off = rpmh_domain_power_off;
>> +       rsc_pd->flags |= GENPD_FLAG_IRQ_SAFE;
>> +
>> +       ret = pm_genpd_init(rsc_pd, NULL, false);
>> +       if (ret)
>> +               goto free_name;
>> +
>> +       ret = of_genpd_add_provider_simple(dn, rsc_pd);
>> +       if (ret)
>> +               goto remove_pd;
>> +
>> +       return ret;
>> +
>> +remove_pd:
>> +       pm_genpd_remove(rsc_pd);
>> +free_name:
>> +       kfree(rsc_pd->name);
> And then drop this one?
Done.
>> +       return ret;
>> +}
>> +
>>   static int rpmh_probe_tcs_config(struct platform_device *pdev,
>>                                   struct rsc_drv *drv)
>>   {
>> @@ -650,6 +723,17 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
>>          if (ret)
>>                  return ret;
>>   
>> +       /*
>> +        * Power domain is not required for controllers that support 'solver'
>> +        * mode where they can be in autonomous mode executing low power mode
>> +        * to power down.
>> +        */
>> +       if (of_property_read_bool(dn, "#power-domain-cells")) {
>> +               ret = rpmh_probe_power_domain(pdev, drv);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>>          spin_lock_init(&drv->lock);
>>          bitmap_zero(drv->tcs_in_use, MAX_TCS_NR);
> What happens if it fails later on? The genpd provider is still sitting
> around and needs to be removed on probe failure later on in this
> function. It would be nicer if there wasn't another function to probe
> the power domain and it was just inlined here actually. That way we
> don't have to wonder about what's going on across two blocks of code.

Thanks for pointing this.  Moved it at the end of probe to avoid this.

>
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
