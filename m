Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FB436DF81
	for <lists+linux-pm@lfdr.de>; Wed, 28 Apr 2021 21:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239179AbhD1TYh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Apr 2021 15:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbhD1TYg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Apr 2021 15:24:36 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E34C061573
        for <linux-pm@vger.kernel.org>; Wed, 28 Apr 2021 12:23:50 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id a30so4628076qvb.12
        for <linux-pm@vger.kernel.org>; Wed, 28 Apr 2021 12:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JUAxi53YLYxSALiXtiLsnMW2CLLKIGzodtsYi+jAxQ4=;
        b=IGjbPNUKRQu3oFtUEG6u9EyCTfywe/U0H+J9gcOR9TwCttcNkkV+WRMJWqiofkgXi0
         CvcC2WuSZNIodAQre8WBjIPo4WkrbTxMg0HRdQioWsXpkb284LmKx4/9yzqv/SONhoOC
         0t/ADrZSwdR3y1H3cBIGeySQT8MtmZxA6mvhczbhxeskTOlWJn9vkb2hM7U76V872OTm
         XZwKRdjTZNCmepwU03QKLBU/RLWZZLRktbbCRxdLdQ5ilH3QI3w24daErEk4FvE/Awi8
         lvAe4pR85pdbvFttyfHvdrhKMZ1q3RY5KAqslfNNDe89cL1RIuW44STpUCZJFSPUKmTC
         jryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JUAxi53YLYxSALiXtiLsnMW2CLLKIGzodtsYi+jAxQ4=;
        b=Y6bbYMUD+kxbwtn3j+ZjKxHm/7s2x3XVoPmRd2+7MPMMT5QVkyqOXB+2wf/KyB+o0N
         Wls9lxJEsxz3gFqeqUKPibWZpzLMvo1YWZnuAJMchfkZ8KEpLPYATNmryFJ7cO7oYMWw
         vOaSr6jCvWYYLXD3Cle+akvWa3zMn+DZmhLjvg9/NVTYIk8XFZdp4QQwKS1XVS/Mv92X
         8Xn3GKP5/HWKWHsRROJLzGjqBJ0dJWk5IaRi34vevXEWEkF1OQZYlQe+mINkGdAytL4d
         drXSQP9MkUUAu3cFlhTSU9ejYJ/FPPTy2xtVSsVnzNYakgE1sbmgrM4bGhiCf4romW+q
         EFuQ==
X-Gm-Message-State: AOAM532O43bxuAFMycA8OKfnu5x1qx6+TUXBexMOmalI5F7sknwNmcnJ
        VRx2RpxAofteFpoSY777lPGW5Q==
X-Google-Smtp-Source: ABdhPJwlRyhl8UB1WQj42h4IlzJWlZPJXrdj37LSHTReHnqRnbXVQ4iFZdJRYWqpopmHIucWGcN3Dw==
X-Received: by 2002:ad4:4eaa:: with SMTP id ed10mr2850782qvb.22.1619637829659;
        Wed, 28 Apr 2021 12:23:49 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id d204sm531847qke.3.2021.04.28.12.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 12:23:49 -0700 (PDT)
Subject: Re: [thermal-next PATCH 2/2] thermal: qcom: tsens: simplify debugfs
 init function
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210419012930.7727-1-ansuelsmth@gmail.com>
 <20210419012930.7727-2-ansuelsmth@gmail.com>
 <8e679407-07e7-244a-48fa-0d4d451d744d@linaro.org>
 <YImuFixa0iWtsU3k@Ansuel-xps.localdomain>
 <fe7dff6b-0079-7fba-4982-a3422add83b5@linaro.org>
 <YIm1MdsOm754WtgD@Ansuel-xps.localdomain>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <fe9fb953-c98c-b53c-6020-3652e9f47e75@linaro.org>
Date:   Wed, 28 Apr 2021 15:23:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YIm1MdsOm754WtgD@Ansuel-xps.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/28/21 3:19 PM, Ansuel Smith wrote:
> On Wed, Apr 28, 2021 at 03:14:31PM -0400, Thara Gopinath wrote:
>>
>>
>> On 4/28/21 2:48 PM, Ansuel Smith wrote:
>>> On Wed, Apr 28, 2021 at 12:47:30PM -0400, Thara Gopinath wrote:
>>>> Hi,
>>>>
>>>> Please include a cover letter next time describing the patch series.
>>>>
>>>
>>> Yes sorry, I tought that for a small series (2 patch) it wasn't needed.
>>>
>>>> On 4/18/21 9:29 PM, Ansuel Smith wrote:
>>>>> Simplify debugfs init function.
>>>>> - Drop useless variables
>>>>> - Add check for existing dev directory.
>>>>> - Fix wrong version in dbg_version_show (with version 0.0.0, 0.1.0 was
>>>>>      incorrectly reported)
>>>>>
>>>>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
>>>>> ---
>>>>>     drivers/thermal/qcom/tsens.c | 16 +++++++---------
>>>>>     1 file changed, 7 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
>>>>> index f9d50a67e..b086d1496 100644
>>>>> --- a/drivers/thermal/qcom/tsens.c
>>>>> +++ b/drivers/thermal/qcom/tsens.c
>>>>> @@ -692,7 +692,7 @@ static int dbg_version_show(struct seq_file *s, void *data)
>>>>>     			return ret;
>>>>>     		seq_printf(s, "%d.%d.%d\n", maj_ver, min_ver, step_ver);
>>>>>     	} else {
>>>>> -		seq_puts(s, "0.1.0\n");
>>>>> +		seq_printf(s, "0.%d.0\n", priv->feat->ver_major);
>>>>>     	}
>>>>>     	return 0;
>>>>> @@ -704,21 +704,19 @@ DEFINE_SHOW_ATTRIBUTE(dbg_sensors);
>>>>>     static void tsens_debug_init(struct platform_device *pdev)
>>>>>     {
>>>>>     	struct tsens_priv *priv = platform_get_drvdata(pdev);
>>>>> -	struct dentry *root, *file;
>>>>> -	root = debugfs_lookup("tsens", NULL);
>>>>> -	if (!root)
>>>>> +	priv->debug_root = debugfs_lookup("tsens", NULL);
>>>>> +	if (!priv->debug_root)
>>>>>     		priv->debug_root = debugfs_create_dir("tsens", NULL);
>>>>> -	else
>>>>> -		priv->debug_root = root;
>>>>> -	file = debugfs_lookup("version", priv->debug_root);
>>>>> -	if (!file)
>>>>> +	if (!debugfs_lookup("version", priv->debug_root))
>>>>>     		debugfs_create_file("version", 0444, priv->debug_root,
>>>>>     				    pdev, &dbg_version_fops);
>>>>>     	/* A directory for each instance of the TSENS IP */
>>>>> -	priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
>>>>
>>>> Unconditionally creating priv->debug here is correct. The below if
>>>> (!priv->debug) will never be true because as per your patch 1, we call
>>>> tsens_debug_init once per instance of tsens.
>>>>
>>>
>>> You are right, will send a v2 if everything else is good. What do you
>>> think?
>>
>> I have not tested this yet. The clean up itself looks okay to me.
>> My question is have you tried this with 8960 tsens ? That is the only
>> version of tsens that does not use init_common and hence looks to me that a
>> debug interface is not created. I don't think this should be a problem
>> though. So if you can fix the above, it is a go ahead from me.
>>
> 
> Recent commits should have switched 8960 to init_common. Actually I
> pushed this cause while testing 8960 I notice the warning about
> double debugfs. Anyway thx for the review. Will send v2 ASAP.

Sounds good. Thanks.

> 
>>
>> -- 
>> Warm Regards
>> Thara

-- 
Warm Regards
Thara
