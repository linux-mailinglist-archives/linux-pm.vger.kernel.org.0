Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7030154B88A
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jun 2022 20:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352059AbiFNS0d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jun 2022 14:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345024AbiFNS0c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2022 14:26:32 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FABA33E2A
        for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2022 11:26:31 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o6so8445545plg.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2022 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5PoteKNACUJIiodbBzv4rpuOsZ7iSrML2lBKJ0618Ks=;
        b=DJtNDiXZh8IXB7qULCZu2NUWK65E7yNg8XkGcf1rDG3FJ5VkAnuOQGTUmn0hYrRgDh
         EdkYfQ2rY8S2XV84eU6nxJXckRgmY4RJ7vOUnVV/IXmfr8bVYjr0HAzrE0Zs0dYZUZpI
         uJJ5w71+XgvKzF8Y8Jyk5chg6h6hmJLW47xGcH0cTSwiB9jUfzAQflT90AnputPRTKVe
         /nS2fAVQSHWWkLBd0J8ULlrV+SM59f6DPibKcTOz1CrQbsbEYfUcVIaGkJlVI38mDV3i
         qdPWhqcqxqL3EkifKHvCeRmM7k7vyn0tDn3JGKefoRw1B1DfRpiMunS4Pc+rC6urtoG2
         i5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5PoteKNACUJIiodbBzv4rpuOsZ7iSrML2lBKJ0618Ks=;
        b=HHhI5fN63f4UYDB9W6W4eUu7H0DG/mX6/ZJRvs8Oc08BmDgaDchIiXF0qULx4WizXR
         1eDzHczCKJ/DiQPRIlQRaBAACmgC5wMmsXfRKnq86iTvysgsBTskzeYHOXnYPOcVmmUY
         35swROUPB6fe1DCX4EDVIRulzoPl09briDnseD8UZVYFihYYW9dr7PbHhjo8dHFhgLf/
         wdyDSpzfPREZzIwHhByWdzunFcXWveIghmBwo4RCkbVJvdMwfSWBygvTDvNKiLnvEuLz
         0H4Zoy2AIMjHBs3rWGsKNa0u6zU4/yknHoh4tULWlkaKaKNV0XV4iB2l5OcejRLtOBnm
         R4cA==
X-Gm-Message-State: AJIora+V/2ywSXdjD0bW7t71sxLczM3b9A52us2BeBxgCJNcOA83Kv/N
        Zz+xAdPF7e7BGNJ9j2vYm+Z7DA==
X-Google-Smtp-Source: AGRyM1s41SuG2Eua1GEOUdPV2ZJ6V+BSlXeJ0dD/8ZKUvRi7gLl6EIdI9eWchJzPHqVMqigyZufdPg==
X-Received: by 2002:a17:90b:947:b0:1e8:9bd0:5420 with SMTP id dw7-20020a17090b094700b001e89bd05420mr5971897pjb.32.1655231190923;
        Tue, 14 Jun 2022 11:26:30 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id p1-20020a056a0026c100b0051c758a3957sm8169131pfw.149.2022.06.14.11.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 11:26:29 -0700 (PDT)
Message-ID: <80516a8d-80b2-9c96-3ac8-4f2e6e6e851d@linaro.org>
Date:   Tue, 14 Jun 2022 20:26:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 0/4] Thermal cpufreq & devfreq cooling minor clean-ups
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     amitk@kernel.org, rui.zhang@intel.com, viresh.kumar@linaro.org,
        rafael@kernel.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        mingo@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220613124327.30766-1-lukasz.luba@arm.com>
 <92f56aed-e6cd-c65b-f42f-5bd1e07b90c5@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <92f56aed-e6cd-c65b-f42f-5bd1e07b90c5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/06/2022 14:51, Lukasz Luba wrote:
> Hi Daniel,
> 
> 
> On 6/13/22 13:43, Lukasz Luba wrote:
>> Hi all,
>>
>> This is v2 of some minor clean-ups for the thermal cpufreq and devfreq
>> cooling code.
>>
>> Changes:
>> v2:
>> - extened the cpufreq_cooling_device with private ops field, to not waste
>>    memory and simplify allocation/free code (Viresh)
>> - added devfreq_cooling clean-up to align with cpufreq cooling code
>> - added ACKs from Viresh for patch 2/4 and path 3/4
>> - added missing maintainers of tracing to CC list
>>
>> Regards,
>> Lukasz
>>
>> Lukasz Luba (4):
>>    thermal: cpufreq_cooling: Use private callback ops for each cooling
>>      device
>>    thermal: cpufreq_cooling : Refactor thermal_power_cpu_get_power
>>      tracing
>>    thermal: cpufreq_cooling: Update outdated comments
>>    thermal: devfreq_cooling: Extend the devfreq_cooling_device with ops
>>
>>   drivers/thermal/cpufreq_cooling.c | 77 ++++++++++---------------------
>>   drivers/thermal/devfreq_cooling.c | 27 ++++-------
>>   include/trace/events/thermal.h    | 28 ++++-------
>>   3 files changed, 42 insertions(+), 90 deletions(-)
>>
> 
> Could you have a look and take the patches into your tree, please?
> The 3 of 4 patches got ACKs, the last one is devfreq cooling, which
> is pretty minor change.

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
