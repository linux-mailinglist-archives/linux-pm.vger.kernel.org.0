Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78128716900
	for <lists+linux-pm@lfdr.de>; Tue, 30 May 2023 18:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjE3QQR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 May 2023 12:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjE3QQR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2023 12:16:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1B919B
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 09:15:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30a1fdde3d6so4650785f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 09:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685463345; x=1688055345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lu5F1IugEspqMHiESvEcsCnoLLm2yf+WZVoj3bzugVA=;
        b=sBQPDSjCuRu9YKi7k3CVzG/+spA7rUL/9CoX5x7rJEhMeQnJ7VlumvVoMqE0XcFOH3
         ffMgQMp0NI/SF3+OY0Jyf5RBJ0sjlwMflffxsQxhUhHZj3+p+uyZl67dHQ24THmHxAE3
         Bs8VM4EP9Ksnp/Ed6ioD17dLDI1nNqQJII41YYhNJnYHTh7wjvwlC1og7Cab/tbmgoGx
         vSFy+Whg/YPlK3i0eTogldEKejXwazU63hwgy39bsJ8Iwgxt0eS3KD98hF3AI4riHp09
         2pj5NIx46cfY948PHOItT3IRhUlaGF6nv3F1Iod6FeZod6dfqygPrSTv9mNqDCUJ8HPs
         GG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685463345; x=1688055345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lu5F1IugEspqMHiESvEcsCnoLLm2yf+WZVoj3bzugVA=;
        b=gYgJBZeBATitbmSG4B7yYqZAT8c+Q98jgA87OCKzn8tNkfigsRnh1c76zyTK7TRnpR
         ieFUU9XkUHDU/vD2xzrqBihR9VHP8Tc0vXdaq9IrmM0FmysJz4PF7tabHPernih1o+/N
         +tZWCJKgb3C7+q5wkTJUVj2H/yxj3dRbL1nN/3O0PgcAOOH39ppXX1fRsW/OCmk9+/SQ
         DDFV5rjh7yTI/H/DJe3PDdLJvYLXLzQo5+EjY6J8Kr2FrfOsx+HqwLAMgG2k+gSojIv5
         wGnaqSP7CTUbEmSgFBDisRsf+Tf1pUThnb03wJLJGsgJtwCp0GbmilMkqne6MEQ+6EGl
         gyXQ==
X-Gm-Message-State: AC+VfDzoCZqMJF10ZtcgZmr9VZKXUFHxtvF7+x3/TC/rr5TV8Dbm1IHb
        hnFuKJevyGA+1eXNsmBo639x9U5XYAa9n8LvPxk=
X-Google-Smtp-Source: ACHHUZ42K36rLZ48dPrVtP3seqX1SMMRi1TXQGERYwCPsenYkesR6k6ZiyZSoDrPZOLk3hqWtc3iSQ==
X-Received: by 2002:adf:dc84:0:b0:307:9702:dfc8 with SMTP id r4-20020adfdc84000000b003079702dfc8mr1993243wrj.48.1685463345307;
        Tue, 30 May 2023 09:15:45 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:dd1c:e75b:56ba:6bf? ([2a05:6e02:1041:c10:dd1c:e75b:56ba:6bf])
        by smtp.googlemail.com with ESMTPSA id n13-20020adfe78d000000b003078681a1e8sm3767021wrm.54.2023.05.30.09.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 09:15:44 -0700 (PDT)
Message-ID: <3ba14507-18be-f1df-a29f-4844efa6081b@linaro.org>
Date:   Tue, 30 May 2023 18:15:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] lvts_thermal.c: Fix error checking for debugfs_create_dir
Content-Language: en-US
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, wenst@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230517160326.10732-1-osmtendev@gmail.com>
 <35dea714-6a0f-4673-fd33-23644ea85d33@linaro.org>
 <CAK6rUAOn_+WSqc8R94deSsZHHwJaJLL2LxFGv929bMj7foCcGw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAK6rUAOn_+WSqc8R94deSsZHHwJaJLL2LxFGv929bMj7foCcGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/05/2023 17:54, Osama Muhammad wrote:
> Hi,
> 
> After Reading more about it I also learned about this and I was
> planning to send a patch to remove the error checking for debugfs
> API.Should I send the patch for it?
> 

Yes, you can change also the prototype of the lvts_debugfs_init() 
function by returning void

And then replace the call site:

         return lvts_debugfs_init(dev, lvts_td);

  by:

	lvts_debugfs_init(dev, lvts_td);

	return 0;

> osmten
> 
> 
> On Tue, 30 May 2023 at 20:47, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 17/05/2023 18:03, Osama Muhammad wrote:
>>> This patch fixes the error checking in lvts_thermal.c in
>>> debugfs_create_dir. The correct way to check if an error occurred
>>> is 'IS_ERR' inline function.
>>
>> We do no longer check debugfs functions return values.
>>
>> eg.
>>
>>    https://www.spinics.net/lists/linux-spi/msg37903.html
>>    https://lore.kernel.org/lkml/2023052835-oxidant-doily-404f@gregkh/
>>
>>
>>> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
>>> ---
>>>    drivers/thermal/mediatek/lvts_thermal.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
>>> index d0a3f95b7884..61386be78fa0 100644
>>> --- a/drivers/thermal/mediatek/lvts_thermal.c
>>> +++ b/drivers/thermal/mediatek/lvts_thermal.c
>>> @@ -188,7 +188,7 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
>>>        int i;
>>>
>>>        lvts_td->dom_dentry = debugfs_create_dir(dev_name(dev), NULL);
>>> -     if (!lvts_td->dom_dentry)
>>> +     if (IS_ERR(lvts_td->dom_dentry))
>>>                return 0;
>>>
>>>        for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
>>> @@ -197,7 +197,7 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
>>>
>>>                sprintf(name, "controller%d", i);
>>>                dentry = debugfs_create_dir(name, lvts_td->dom_dentry);
>>> -             if (!dentry)
>>> +             if (IS_ERR(dentry))
>>>                        continue;
>>>
>>>                regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
>>
>> --
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

