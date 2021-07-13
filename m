Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE473C76F8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 21:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhGMTeD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jul 2021 15:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhGMTeD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jul 2021 15:34:03 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDE9C0613DD;
        Tue, 13 Jul 2021 12:31:13 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b12so20513775pfv.6;
        Tue, 13 Jul 2021 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8S0JSRUnQxgp/widcUStdZ06A70Ry0fn6tF6qKTL8sQ=;
        b=XBQC4nn4Ju2cayLDVzYRc2KTECptBWNVFUp7dq5KiANVq0zEVFEvG07cFC352ZR/Ow
         qC0cawY8B127gdbpsCmKuP+h1swZ23LUM/rYHmxe6UeLZvttgPZF6Gl6HH1EkvKFkdZx
         sUG+Rx5YowW2lC1Mri4TIqJ9vvW2dFoCWeLaFLf5X5te/mc/Wm3dNDtqF3nS2/7S+MmB
         KSEGsrRQ/So50sSWNHg1l+UMBdnpRinOruDfZUkdU+D1ucXU+cPjilDN1CpdgjWkzGnR
         SMhAx167T+XVlkil0iIbEHBLA047XnBGk8ijhV0wUTQI6Lr2Fhjodc2RDzYA9cwmoTvY
         P1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8S0JSRUnQxgp/widcUStdZ06A70Ry0fn6tF6qKTL8sQ=;
        b=ttfPD47a3hevOECpe0iRRANIsdNPUh0qzWqmwsZTJIWH71u88nN7mSof6fXPLMVb2N
         /QnG5o2s7DcZ7g83Rb+a/QIda4GmQ8lkcHharht7WO7HRep/nY2WecwpJ0vrESbRWlQj
         dmttjjPM7Td6xbjkPbYYKrBbpZLYRDgcOFPD2IT/VWkQSJxnUb28Werk3B7CmLSGrqhT
         6Al6I1w6gpmB5CThPd25lkLbiE80c3kk8C7nU16OzGaBnNLVHkw001w1pk7Hyvua//Id
         7tvaGc3rvtvv08nlmfrMym9dCToOuTC20fzJL0yZ7Z1rRHR4P5xyWPNdhtm/yAyq5+mX
         5skQ==
X-Gm-Message-State: AOAM531BfC+F89W+pcpu3SAzXwEeh9Q9wk08yfKnbYgU9WaH4QWcAFTJ
        d4owVQOm09D+K0Hv9mZPOvFF6HO+pbOwDg==
X-Google-Smtp-Source: ABdhPJwOaqRJewNcfFrs7Mf2YVnL0Kb+iOqhJI6Pvqll8XIVxUaRWR5QkClCmP9lqeM2syWTiPNLMw==
X-Received: by 2002:a63:7d15:: with SMTP id y21mr5710913pgc.352.1626204671826;
        Tue, 13 Jul 2021 12:31:11 -0700 (PDT)
Received: from [172.30.1.52] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id n33sm21904753pgm.55.2021.07.13.12.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 12:31:11 -0700 (PDT)
Subject: Re: [PATCH 4/4] PM / devfreq: passive: Reduce duplicate code when
 passive_devfreq case
To:     Matthias Kaehlcke <mka@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     andrew-sh.cheng@mediatek.com, hsinyi@chromium.org,
        sibis@codeaurora.org, saravanak@google.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        chanwoo@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210617060546.26933-1-cw00.choi@samsung.com>
 <CGME20210617054647epcas1p41cd87f03bc6f5b44b6f2d7a3e5924860@epcas1p4.samsung.com>
 <20210617060546.26933-5-cw00.choi@samsung.com> <YNIthEVkS8OK19pm@google.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <30340383-c136-6a21-3e88-18cd6ed9cba1@gmail.com>
Date:   Wed, 14 Jul 2021 04:31:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YNIthEVkS8OK19pm@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Matthias,

On 21. 6. 23. 오전 3:35, Matthias Kaehlcke wrote:
> On Thu, Jun 17, 2021 at 03:05:46PM +0900, Chanwoo Choi wrote:
>> In order to keep the consistent coding style between passive_devfreq
>> and passive_cpufreq, use common code for handling required opp property.
>> Also remove the unneed conditional statement and unify the comment
>> of both passive_devfreq and passive_cpufreq when getting the target frequency.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>   drivers/devfreq/governor_passive.c | 80 ++++++------------------------
>>   1 file changed, 15 insertions(+), 65 deletions(-)
>>
>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
>> index 07e864509b7e..7102cb7eb30d 100644
>> --- a/drivers/devfreq/governor_passive.c
>> +++ b/drivers/devfreq/governor_passive.c
>> @@ -91,66 +91,17 @@ static int get_target_freq_with_devfreq(struct devfreq *devfreq,
>>   	struct devfreq_passive_data *p_data
>>   			= (struct devfreq_passive_data *)devfreq->data;
>>   	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
>> -	unsigned long child_freq = ULONG_MAX;
>> -	struct dev_pm_opp *opp, *p_opp;
>> -	int i, count;
>> -
>> -	/*
>> -	 * If the devfreq device with passive governor has the specific method
>> -	 * to determine the next frequency, should use the get_target_freq()
>> -	 * of struct devfreq_passive_data.
>> -	 */
>> -	if (p_data->get_target_freq)
>> -		return p_data->get_target_freq(devfreq, freq);
>> -
>> -	/*
>> -	 * If the parent and passive devfreq device uses the OPP table,
>> -	 * get the next frequency by using the OPP table.
>> -	 */
>> -
>> -	/*
>> -	 * - parent devfreq device uses the governors except for passive.
>> -	 * - passive devfreq device uses the passive governor.
>> -	 *
>> -	 * Each devfreq has the OPP table. After deciding the new frequency
>> -	 * from the governor of parent devfreq device, the passive governor
>> -	 * need to get the index of new frequency on OPP table of parent
>> -	 * device. And then the index is used for getting the suitable
>> -	 * new frequency for passive devfreq device.
>> -	 */
>> -	if (!devfreq->profile || !devfreq->profile->freq_table
>> -		|| devfreq->profile->max_state <= 0)
>> -		return -EINVAL;
>> -
>> -	/*
>> -	 * The passive governor have to get the correct frequency from OPP
>> -	 * list of parent device. Because in this case, *freq is temporary
>> -	 * value which is decided by ondemand governor.
>> -	 */
>> -	if (devfreq->opp_table && parent_devfreq->opp_table) {
>> -		p_opp = devfreq_recommended_opp(parent_devfreq->dev.parent,
>> -						freq, 0);
>> -		if (IS_ERR(p_opp))
>> -			return PTR_ERR(p_opp);
>> -
>> -		opp = dev_pm_opp_xlate_required_opp(parent_devfreq->opp_table,
>> -						    devfreq->opp_table, p_opp);
>> -		dev_pm_opp_put(p_opp);
>> -
>> -		if (IS_ERR(opp))
>> -			goto no_required_opp;
>> -
>> -		*freq = dev_pm_opp_get_freq(opp);
>> -		dev_pm_opp_put(opp);
>> -
>> -		return 0;
>> -	}
>> +	unsigned long target_freq;
>> +	int i;
>> +
>> +	/* Get target freq via required opps */
>> +	target_freq = get_taget_freq_by_required_opp(parent_devfreq->dev.parent,
>> +						parent_devfreq->opp_table,
>> +						devfreq->opp_table, *freq);
> 
> s/get_taget_freq_by_required_opp/get_target_freq_by_required_opp/
> 
> Also need to be fixed in "[3/4] PM / devfreq: Add cpu based scaling
> support to passive governor".

Thanks for catch. I'll fix it.

> 
>> +	if (target_freq)
>> +		goto out;
>>   
>> -no_required_opp:
>> -	/*
>> -	 * Get the OPP table's index of decided frequency by governor
>> -	 * of parent device.
>> -	 */
>> +	/* Use Interpolation if required opps is not available */
> 
> s/Interpolation/interpolation/

I'll fix it.

> 
>>   	for (i = 0; i < parent_devfreq->profile->max_state; i++)
>>   		if (parent_devfreq->profile->freq_table[i] == *freq)
>>   			break;
>> @@ -158,16 +109,15 @@ static int get_target_freq_with_devfreq(struct devfreq *devfreq,
>>   	if (i == parent_devfreq->profile->max_state)
>>   		return -EINVAL;
>>   
>> -	/* Get the suitable frequency by using index of parent device. */
>>   	if (i < devfreq->profile->max_state) {
>> -		child_freq = devfreq->profile->freq_table[i];
>> +		target_freq = devfreq->profile->freq_table[i];
>>   	} else {
>> -		count = devfreq->profile->max_state;
>> -		child_freq = devfreq->profile->freq_table[count - 1];
>> +		i = devfreq->profile->max_state;
>> +		target_freq = devfreq->profile->freq_table[i - 1];
>>   	}
>>   
>> -	/* Return the suitable frequency for passive device. */
>> -	*freq = child_freq;
>> +out:
>> +	*freq = target_freq;
> 
> You might want to split the child_freq => target_freq and commentary change into
> a separate patch, since it is not directly related with the switch to
> get_target_freq_by_required_opp().

OK. I will not change about child_freq -> target_freq.


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
