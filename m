Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B977665C42A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jan 2023 17:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbjACQpq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Jan 2023 11:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238013AbjACQpo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jan 2023 11:45:44 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED6412AAA
        for <linux-pm@vger.kernel.org>; Tue,  3 Jan 2023 08:45:43 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso17308666wms.5
        for <linux-pm@vger.kernel.org>; Tue, 03 Jan 2023 08:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xlYFaDLIw+oAuyNiE146AeJuLBHMHdcHhEkHNkvVnSs=;
        b=D3dzLJP0pXGKVY3j1ccUWQui4pkpfLeR4ND2+sWriliqjNFjkMCUXMtwXp/h9SGzJW
         Mv39ldb6fAtFUZDbgHnnO203NhsDxfKijTUiyqF+Qnppy2UK96zvIpF9ZHof8j/CoaQv
         YBDQWfLsK5KJp6L5k9CftP/LxJa0W5DCHiww+k26Spikf2LWadgr6YlDZEAdcVQdIZaO
         8Ogr+KN53/od5wCc2wZtPtDzoEPCmnclxV/f+AlKuWe2130FRt2f2SfAS3CkA/8pAK3u
         86EjmIzNvH4v9ieAYayS7EHU39y3LZj14aunGuBvh9XXzTaiQ8l2WxdhL+4bxyO0jTpX
         di8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xlYFaDLIw+oAuyNiE146AeJuLBHMHdcHhEkHNkvVnSs=;
        b=jk/Qtaryz29++G5A1MpMVEy41vHScPg2LYgXNW210LgI6YRj+c4wzK4LNUmN3C+tIB
         w71B62ZvaIC57VvC44kXSr9TqmqRz8YPpaoJQrLkRC8t3fHidw+iuqgorm6MMGVTCTWB
         U9LC5qEFxcU8Fft1MIHSp/ofOyF29MtXdMH254gaZX3m+R18Rvxxju9+tEzN0O5CYR8j
         DTWsBsOSMAa+wE0vuTZaVl9K0en+lVl4m6vT03Jo/kQJsZFsjzFj5gU+ERGqLzt5ZAfs
         OBlGh6RZuHWOwyRhNyCI6sw4jBVjd0C07Ppn4LJwxKa2CMgmLptWcy6A1PGqnz9W6wYa
         6OZA==
X-Gm-Message-State: AFqh2krNQ1PdCwqLtlqrs9LkvbMkTFO8jZ8CaIAsMIglCavnEqIlGtij
        DGGKyIkqGa5i5pydPi/olYDPXg==
X-Google-Smtp-Source: AMrXdXuBkdEVYRyzV637IRsANdT+wsKSwkHeuoVGQhf55lma77GGWA6gTgGEKzfcisTABGdPz6/Y4A==
X-Received: by 2002:a05:600c:3d12:b0:3d3:5027:89a4 with SMTP id bh18-20020a05600c3d1200b003d3502789a4mr35599970wmb.7.1672764341689;
        Tue, 03 Jan 2023 08:45:41 -0800 (PST)
Received: from [192.168.1.12] (host-92-24-101-87.as13285.net. [92.24.101.87])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b003c6f8d30e40sm51473426wms.31.2023.01.03.08.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 08:45:41 -0800 (PST)
Message-ID: <27e14346-597f-e3d1-250c-081595eb1759@linaro.org>
Date:   Tue, 3 Jan 2023 16:45:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] thermal/core: fix potential unbalanced put_device during
 register
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20221231210301.6968-1-caleb.connolly@linaro.org>
 <20230102053144.eheohvixllp3mtnd@vireshk-i7>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20230102053144.eheohvixllp3mtnd@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 02/01/2023 05:31, Viresh Kumar wrote:
> On 31-12-22, 21:03, Caleb Connolly wrote:
>> Commit c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
>> causes device_put() to be called if the get_max_state() callback fails
>> during __thermal_cooling_device_register().
>>
>> Fix the cleanup ordering to only call device_put() if initialization
>> fails after the matching device_register() call.
>>
>> Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  drivers/thermal/thermal_core.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index f17ab2316dbd..2c6995b5dcb0 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -920,7 +920,7 @@ __thermal_cooling_device_register(struct device_node *np,
>>  	}
>>  	ret = device_register(&cdev->device);
>>  	if (ret)
>> -		goto out_kfree_type;
>> +		goto out_put_device;
>>  
>>  	/* Add 'this' new cdev to the global cdev list */
>>  	mutex_lock(&thermal_list_lock);
>> @@ -939,10 +939,11 @@ __thermal_cooling_device_register(struct device_node *np,
>>  
>>  	return cdev;
>>  
>> +out_put_device:
>> +	put_device(&cdev->device);
>>  out_kfree_type:
>>  	thermal_cooling_device_destroy_sysfs(cdev);
> 
> What about this one ? This shouldn't be called in case get_max_state() fails,
> right ?

Right, I missed that one! It even gets called twice if dev_set_name()
fails...
> 
>>  	kfree(cdev->type);
>> -	put_device(&cdev->device);
>>  	cdev = NULL;
>>  out_ida_remove:
>>  	ida_free(&thermal_cdev_ida, id);
> 

-- 
Kind Regards,
Caleb (they/them)
