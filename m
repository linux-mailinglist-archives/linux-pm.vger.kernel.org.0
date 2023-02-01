Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551BF6868C7
	for <lists+linux-pm@lfdr.de>; Wed,  1 Feb 2023 15:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjBAOqd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Feb 2023 09:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjBAOqO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2023 09:46:14 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F051F6ACAA
        for <linux-pm@vger.kernel.org>; Wed,  1 Feb 2023 06:46:00 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o18so8067205wrj.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Feb 2023 06:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XpnCE8JGjFYZkEnYSegdA0ax2WJNTJlDZWJpuD3D+rw=;
        b=Wx+yAea0y5hkZjxAOAAkqJTFOD8zR9I5at+0Akzs4NOUMX/DfICY9Aetnu2a1wokHS
         9yuM3zkSazoXDZoTJu+GEzPj15LGFpPcd2IfgdC5hzMGoUQNWxX1KfxC+u2tCyYb9zZx
         xuAHrIJ7/7jo3shG6e1NqybFPaDvaKK73+LTZBhBaG71s+zXtGn+wsKO8FMMdeq1YNow
         Clng6HyXw2LXDma1LDBoZj0j4/K2ZM+m6WyhXGFiNcTQG4TGykQj1ChQgVAsiFOJwVO+
         5KUDPr7UUt92Om37wcmAN9RdZo/L08F81j+6XjavFyHFd8DQxMYogJyz+qGGERu1fHcj
         1Fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpnCE8JGjFYZkEnYSegdA0ax2WJNTJlDZWJpuD3D+rw=;
        b=lVqBw6lZRJ2MsvnOa/mR18JGxBSyd33yuYvfS+Qz6lzjlvOY2iJlEy1WABwtKUyeQf
         YtorCSobO8NxPe5hH5c9he5fI0YnJNXCAE5D0SPzEHDsnoDdGnVwr2KJulMF5dzSOOJ6
         QYJscJLjJVXLvS8lInQlcjG93O+I4JoU/3lGWmYNrI33dlBW3BeI8IMEyyazBnouUToz
         tyJgy8bpr44yK6jCUFiS+kPvyHYJE5blc08OsPAeoTJ8o7ZwaMK8sVbJgHV/10YkG9Wg
         5ggvTsl1dQdFbyZuISH0EhHVkRncrr7nyum7Iwf2xh1+ljplC10FUM64hRUeD/JrOglV
         FF1g==
X-Gm-Message-State: AO0yUKWYRNR/4eMVOMj6sIhp7Mk/Ij+OLNp4iY7GtouvhFHqIF/BrNNY
        5n9Qzemt7G2raJOpRnczHeH5Tw==
X-Google-Smtp-Source: AK7set8NOvE0q6Hpfi0AAbA+qgWOmHpwHVUwMAQ1IEXZss2RV/422mWcVVVZ8aBgCUa6BhWkrolm4Q==
X-Received: by 2002:a5d:4d84:0:b0:2bf:eb0e:ccb8 with SMTP id b4-20020a5d4d84000000b002bfeb0eccb8mr2754766wru.37.1675262759346;
        Wed, 01 Feb 2023 06:45:59 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d3-20020adffbc3000000b002bdd155ca4dsm17483619wrs.48.2023.02.01.06.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 06:45:58 -0800 (PST)
Message-ID: <58a5e856-3e8b-d660-09ee-7a18b184452f@linaro.org>
Date:   Wed, 1 Feb 2023 14:45:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] PM / devfreq: qcom: Introduce CCI devfreq driver
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Jun Nie <jun.nie@linaro.org>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230201080227.473547-1-jun.nie@linaro.org>
 <20230201080227.473547-2-jun.nie@linaro.org>
 <515f4e9e-2804-e03a-26f5-f2d3ac331109@linaro.org>
 <71ba0d05-6183-95ef-9e45-cc3dd512475f@linaro.org>
 <CAA8EJpqyqC5D+O=KJnuZnWN4BwBOKcquN11nJfEp2WMSmJobBg@mail.gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CAA8EJpqyqC5D+O=KJnuZnWN4BwBOKcquN11nJfEp2WMSmJobBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/02/2023 13:41, Dmitry Baryshkov wrote:
>>                           cci-cpufreq {
>>                                   target-dev = <&cci_cache>;
>>                                   cpu-to-dev-map-0 =
>>                                           <  200000  200000000 >,
>>                                           <  345600  200000000 >,
>>                                           <  400000  200000000 >,
>>                                           <  533330  297600000 >,
>>                                           <  800000  297600000 >,
>>                                           <  960000  297600000 >,
>>                                           < 1113600  297000000 >,
>>                                           < 1344000  595200000 >,
>>                                           < 1459200  595200000 >,
>>                                           < 1497600  595200000 >,
>>                                           < 1651200  595200000 >;
>>                                   cpu-to-dev-map-4 =
>>                                           <  200000 200000000 >,
>>                                           <  249600 200000000 >,
>>                                           <  499200 297600000 >,
>>                                           <  800000 297600000 >,
>>                                           <  998400 595200000 >,
>>                                           < 1113600 595200000 >;
> These should map to existing opp entries.
> 
> I ended up doing the interconnect driver that maps a clock to the
> interconnect. Then I can use it in the cpu opp tables.
> 

Can you point us at what it is you are proposing ?

---
bod
