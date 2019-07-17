Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B986B9AA
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 12:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfGQKEp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 06:04:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49180 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfGQKEo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 06:04:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6715F60F3C; Wed, 17 Jul 2019 10:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563357883;
        bh=PxqQnALfKSRdsnAJ3hzHy40Hd+Z0/yk/Ea0ZEWLH41g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Vhdf4GXnTQEAR0KzBN6zGiFb/kbnxtOGH/4amg98ErC/wcoXHPko/lo5wnbvtVuSV
         zV010JS17rU8lkWqclcn7QeIH0RuuxrPin3k87tBsaL16zUwIxrSEju1/smWgnfiN7
         /pd9E0HwrCVY0QwIogxEx7ld/bRl8wj+1yR+6OUY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.79.43.141] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 888C9602F5;
        Wed, 17 Jul 2019 10:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563357882;
        bh=PxqQnALfKSRdsnAJ3hzHy40Hd+Z0/yk/Ea0ZEWLH41g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Uue7bb9uJIbE++aHtPXX5xa5bSSGXOUdICkpkvXjc9+N9GVN2UcPUFc4B/+0bOD/S
         XPg6wUyVkBjQEtAdc7sNuQpcoORSHwLeSi3YuWiMbDTbkeQ56nXc6ontjBVufuAM2Q
         GcZ5lICxbfDZ2hPh5hhLX1bmmzlQ6XiC2z0FNxxw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 888C9602F5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH] opp: Return genpd virtual devices from
 dev_pm_opp_attach_genpd()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
References: <027985ce35873cd218298302a1408da06d48458b.1562565567.git.viresh.kumar@linaro.org>
 <2ed7993d-523b-270a-2be9-83ad2426e946@codeaurora.org>
 <20190717054713.vn65cfiqebhzdvjq@vireshk-i7>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <2fbfc0fc-7d61-bf8c-67de-28183d03e26a@codeaurora.org>
Date:   Wed, 17 Jul 2019 15:34:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190717054713.vn65cfiqebhzdvjq@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/17/2019 11:17 AM, Viresh Kumar wrote:
> On 11-07-19, 15:09, Rajendra Nayak wrote:
>> Sorry for the delay
> 
> Same here :)
> 
>> I seem to have completely missed this patch.
>> I just gave this a try and here are some observations,
>>
>> I have a case where I have one device with 2 power domains, one of them
>> is scale-able (supports perf state) and the other one supports only being
>> turned on and off.
>>
>> 1. In the driver I now need to use dev_pm_domain_attach_by_name/id to attach the
>> power domain which supports only on/off and then use dev_pm_opp_attach_genpd()
>> for the one which supports perf states.
>>
>> 2. My OPP table has only 1 required_opps, so the required_opp_count for the OPP table is 1.
>> Now if my device tree has my scale-able powerdomain at index 1 (it works if its at index 0)
>> then I end up with this error
>>
>> [    2.858628] ufshcd-qcom 1d84000.ufshc: Index can't be greater than required-opp-count - 1, rpmh_pd (1 : 1)
>>
>> so it looks like a lot of the OPP core today just assumes that if a device has multiple power domains,
>> all of them are scale-able which isn't necessarily true.
> 
> I don't think a lot of OPP core has these problems, but maybe only
> this place. I was taking care of this since the beginning just forgot
> it now.
> 
> What about this over this commit:

Yes, this does seem to fix my concern mentioned in 2. above.

> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index d76ead4eff4c..1f11f8c92337 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1789,13 +1789,16 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
>    *
>    * This helper needs to be called once with a list of all genpd to attach.
>    * Otherwise the original device structure will be used instead by the OPP core.
> + *
> + * The order of entries in the names array must match the order in which
> + * "required-opps" are added in DT.
>    */
>   struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
>                  const char **names, struct device ***virt_devs)
>   {
>          struct opp_table *opp_table;
>          struct device *virt_dev;
> -       int index, ret = -EINVAL;
> +       int index = 0, ret = -EINVAL;
>          const char **name = names;
>   
>          opp_table = dev_pm_opp_get_opp_table(dev);
> @@ -1821,14 +1824,6 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
>                  goto unlock;
>   
>          while (*name) {
> -               index = of_property_match_string(dev->of_node,
> -                                                "power-domain-names", *name);
> -               if (index < 0) {
> -                       dev_err(dev, "Failed to find power domain: %s (%d)\n",
> -                               *name, index);
> -                       goto err;
> -               }
> -
>                  if (index >= opp_table->required_opp_count) {
>                          dev_err(dev, "Index can't be greater than required-opp-count - 1, %s (%d : %d)\n",
>                                  *name, opp_table->required_opp_count, index);
> @@ -1849,6 +1844,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
>                  }
>   
>                  opp_table->genpd_virt_devs[index] = virt_dev;
> +               index++;
>                  name++;
>          }
>   
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
