Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 861669A7C8
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 08:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392391AbfHWGth (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 02:49:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47746 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389682AbfHWGth (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2019 02:49:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 26848605A5; Fri, 23 Aug 2019 06:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566542976;
        bh=zRftSmw5mMkRbxhfik45KPdSZpa8uqSZjZ9T2j19Vbs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lqjV+A+kO/pRBUmTm57hQbWedJya/PnB9dfifcWpL96v19eem1NlEfZGmT0mB00Cp
         wIDKFfDtL6T6eaiZGHEdf4A0jm8VH/DiQNojLBCBOremDdX7wzfYPJ+4B+9CXrlE8s
         fYXjo++7QiwXOXFAZ/rTZ6TtB/FHpjarHZ2iL3Q8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.242.6.109] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 768E6605A5;
        Fri, 23 Aug 2019 06:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566542975;
        bh=zRftSmw5mMkRbxhfik45KPdSZpa8uqSZjZ9T2j19Vbs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OdtIrEbGiM/RpqnNa5Ih/949aB645D4jC/IygCzAyfY1L80egz/GhyNUmuh1xG+jl
         dWqF1nVdJh8MxDsFInPbFq8BVELUuqAUUYJgj3g54VSqfekYIDyrLUX/C7UUn4Gsyq
         LYGRO36+TDrb+fGNhQ9QMpB1S03io+1CRJm68Nks=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 768E6605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [PATCH 4/4] drivers: qcom: rpmh-rsc: Add RSC power domain support
To:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org
References: <20190813082442.25796-1-mkshah@codeaurora.org>
 <20190813082442.25796-5-mkshah@codeaurora.org>
 <5d5451fe.1c69fb81.ee115.1711@mx.google.com>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <c1aba2c1-dfbb-0529-d982-f35106879b77@codeaurora.org>
Date:   Fri, 23 Aug 2019 12:19:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d5451fe.1c69fb81.ee115.1711@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/14/2019 11:55 PM, Stephen Boyd wrote:
> Quoting Maulik Shah (2019-08-13 01:24:42)
>> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>> index e278fc11fe5c..bd8e9f1a43b4 100644
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
>> + *  True if controller is idle.
>> + */
>> +static bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv)
>> +{
>> +       int m;
>> +       struct tcs_group *tcs = get_tcs_of_type(drv, ACTIVE_TCS);
>> +       bool ret = true;
>> +
>> +       spin_lock(&drv->lock);
>> +       for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
>> +               if (!tcs_is_free(drv, m)) {
> Isn't this a copy of an existing function in the rpmh driver?
No.  The changes to add this were previously posted but did not went it.
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
>> @@ -521,6 +547,65 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
>>          return tcs_ctrl_write(drv, msg);
>>   }
>>   
>> +int rpmh_domain_power_off(struct generic_pm_domain *rsc_pd)
>> +{
>> +       struct rsc_drv *drv = container_of(rsc_pd, struct rsc_drv, rsc_pd);
>> +       int ret = 0;
>> +
>> +       /*
>> +        * RPMh domain can not be powered off when there is pending ACK for
>> +        * ACTIVE_TCS request. Exit when controller is busy.
>> +        */
>> +
>> +       ret = rpmh_rsc_ctrlr_is_idle(drv);
>> +       if (!ret)
>> +               goto exit;
> return 0? Shouldn't it return some negative value?
Done.
>> +
>> +       ret = rpmh_flush(&drv->client);
>> +       if (ret)
>> +               goto exit;
> Why not just return rpmh_flush(...)?
>
> The usage of goto in this function is entirely unnecessary.
Done.
>> +
>> +exit:
>> +       return ret;
>> +}
>> +
>> +static int rpmh_probe_power_domain(struct platform_device *pdev,
>> +                                  struct rsc_drv *drv)
>> +{
>> +       int ret = -ENOMEM;
>> +       struct generic_pm_domain *rsc_pd = &drv->rsc_pd;
>> +       struct device_node *dn = pdev->dev.of_node;
>> +
>> +       rsc_pd->name = kasprintf(GFP_KERNEL, "%s", dn->name);
>> +       if (!rsc_pd->name)
>> +               goto exit;
> return -ENOMEM;
Done.
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
>> +       pr_debug("init PM domain %s\n", rsc_pd->name);
>> +
>> +       return ret;
> 	ret = of_genpd_add_provider_simple(...)
> 	if (!ret)
> 		return 0;
>
> Drop the pr_debug(), it's not useful.
Done.
>> +
>> +remove_pd:
>> +       pm_genpd_remove(rsc_pd);
>> +
>> +free_name:
>> +       kfree(rsc_pd->name);
>> +
>> +exit:
>> +       return ret;
> Please remove newlines between labels above.
Done.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

