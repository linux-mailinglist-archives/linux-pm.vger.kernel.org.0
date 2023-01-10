Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E24E664813
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jan 2023 19:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbjAJSFX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Jan 2023 13:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbjAJSEk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2023 13:04:40 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5418371883
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2023 10:02:13 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l26so9411545wme.5
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2023 10:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lky2hFk0ZCuhfftcY+w+Fb6UVu3tOk/1XG69lUBZIIs=;
        b=WYX8e6boRbMXRHxe+9x5I4KoFLkeeDvIJfMqDfrDvClefdaH7FUvPkh4saqw8J7Z/Y
         9NgZl7RuS+9vGlwi4TzBeAt9ik/J78gxGNmtz/kBLiSL2iyfCqf0fsHh1fua6lPnglOZ
         WZTvPJcjjI3r9DTFJ/f+xdLsZ3qB2+neRiW4tgMI8Tn5le/BO5za3xwAWV5/Qbu9bZpD
         8dIwNXdAFIxirxqab8cwTYwarmP21R0++g0U0EoddWwnwlHcAxtGMs6PG5P1+z6mbw8b
         8Qt0D/J9AIyoUZpN8x4QFGEB56wXLN4XTfVcruvh3MuKoXFpeEPBthfpPIDTzHnobLW4
         9YVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lky2hFk0ZCuhfftcY+w+Fb6UVu3tOk/1XG69lUBZIIs=;
        b=a6snP1hsqCVtjVEHb1ns6YAgTr+/Yhqjt+Uo7jD/Q2sexj3sjJAi4QnG422CSLQ/pp
         dYBtVhTHTEBqsGmrmp8qDLRwWRw6JD9RfaL9Ly+dy/ORgP+lxph3odEXgzkADVa2G0/j
         IOb5zP3HHqnqPYZiagttvvoQZLGQ8ekrzu61AQx2VyLA8NxhZklGJCczSAb2ISAcmcJ0
         kedL04eX1o5qBxHVrCwCydbDlVFvF2hG/Whq4iYbJNgzPO+JMRE7YFNyjGERWWie7IPZ
         5xJIiGEHHuWlJrgJ87061q0RCzYTtIeVSMlJLSKHg/XHtF9mOaR/iBpU4mQXLOygZmm1
         7BhQ==
X-Gm-Message-State: AFqh2kqGzbwmXZ7r10D+/m05XX8ALG1AGKLcOIAA9ErJrgRdtdIuiOgF
        B5c+Om6YNTXXaftD+e188IqyVQ==
X-Google-Smtp-Source: AMrXdXvIopoym2NkzDEk8vfnbPAC9sUrG4qKrP6GDhe0I1K0yutH+DpUD6SaL+h6fhWXC2AohwF0cA==
X-Received: by 2002:a05:600c:2d91:b0:3cf:735c:9d54 with SMTP id i17-20020a05600c2d9100b003cf735c9d54mr49600925wmg.1.1673373731771;
        Tue, 10 Jan 2023 10:02:11 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id j6-20020a05600c42c600b003b492753826sm14734031wme.43.2023.01.10.10.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 10:02:11 -0800 (PST)
Message-ID: <81900466-9992-c59b-e2ce-26c71948906d@linaro.org>
Date:   Tue, 10 Jan 2023 19:02:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [GIT PULL] generic trip points for the thermal framework
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Xu Panda <xu.panda@zte.com.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
References: <72fcddd3-0429-4e23-ab68-2a502f451966@linaro.org>
 <CAJZ5v0iSsg63KdfY79DHSeR+DnaQF2c7GoFZaUw3eHh4XNkWRA@mail.gmail.com>
 <CAJZ5v0gX0KttHGFWAJU5urTfTQVqZeXjFOBrrovygQamwYs_4A@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gX0KttHGFWAJU5urTfTQVqZeXjFOBrrovygQamwYs_4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/01/2023 13:31, Rafael J. Wysocki wrote:

[ ... ]

>>
>> Pulled and pushed out, thanks!
>>
>> I've merged my thermal-intel branch on top of this and pushed out the
>> result into the bleeding-edge branch.  Please check my merge conflict
>> resolution there.
> 
> It would not build due to tj_max being undefined in
> pkg_temp_thermal_device_add().
> 
> Should be fixed in bleeding-edge now.

At the first glance, it looks ok for me

Thanks

   -- Daniel

> Rui, please have a look at that too.
> 
> Thanks!

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

