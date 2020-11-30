Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104312C813B
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 10:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgK3Jl1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 04:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgK3Jl1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 04:41:27 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476A9C0613CF
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2020 01:40:41 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t4so15135342wrr.12
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2020 01:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N+D9qspU/bPnujVIhBzSLSBFh/Erq3Zz8Zph/XPoLdU=;
        b=PXN4zvJY6xEi7NtVks3NdM773rCmmIFJdFFaJw/jIQzzVVjwYb/7ZELgEaBTW00NME
         TN+JSR6mytfTkAFqecbQksX+FG1vV7gl3Lgretdk+mZ5A4hHaqbmuZwbXePjKjECMKs4
         rH4YJIH/uWIrEmQFpYyxed7ZZ2sygkm+bWiO6sjxFbW81ExyIT4g+CptleljcX0eG16z
         dJDi2dDwzhd/PIfyZh9oNydsY9EHMqIz9cqE5nsRwpHKhCDXIY9b2uIzeqEQru2B8QTM
         uou2W8vuNrys+TkK+bC3tZMixm6+FCvMoXgfHLIUesCcjbuW3yQJS0tMPnpzoqsfK7U2
         okfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N+D9qspU/bPnujVIhBzSLSBFh/Erq3Zz8Zph/XPoLdU=;
        b=DZ0GNTSoktzTEZGvLGFv9RW/BcNZ33WgXnbMWqoIQ3ACoG+pGmkOy1jMAuVUqDFeCz
         qZ+CzzzaSpt+xgkm4wXEkMhny2BHYgc0zQcRYBDbXQYLp85JjswtiRkGASvixn+u9qyD
         8t6FFl06hpwCi+pAkUkpAAUws2vrpP6eklqxaP1FFi7ekLZ/DoPY+PJWma0IU0XaWzFS
         i2jfBjUEO3vKwsxFLbnC4kqlugutYUU48XDr9h7GNvUEBfK+tNngAJBPVt8RsZPS5unu
         HtrEEgOnBzhbgagzrkSI+0YHexuNhdu0NF2a8DGVkBmeP7eIVZXPEYr5DE3sgdznArmb
         fc4A==
X-Gm-Message-State: AOAM5334UH/y4f3nxAQO3TYCl77QhJ9pbCv50xXSQTS7g5ckhcMZOsBU
        xSsoG7mDNcRlt4jbxP29GrM0eQ==
X-Google-Smtp-Source: ABdhPJyw6K28mNe+MvOP/X16K9BPwGgApu5AI/HQ+sU8ZFk1ZF1Uj99iAgO8McEKf5wxTx4LVRtDgA==
X-Received: by 2002:adf:e788:: with SMTP id n8mr27310799wrm.84.1606729239874;
        Mon, 30 Nov 2020 01:40:39 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:a9e1:bc04:469:f21b? ([2a01:e34:ed2f:f020:a9e1:bc04:469:f21b])
        by smtp.googlemail.com with ESMTPSA id 189sm10523997wma.22.2020.11.30.01.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 01:40:39 -0800 (PST)
Subject: Re: [RFC 1/2] dt-bindings: thermal: sprd: Add virtual thermal
 documentation
To:     gao yunxiao <gao.yunxiao6@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     rui.zhang@intel.com, amitk@kernel.org, robh+dt@kernel.org,
        javi.merino@kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, "jeson.gao" <jeson.gao@unisoc.com>
References: <1606466112-31584-1-git-send-email-gao.yunxiao6@gmail.com>
 <724ddf78-483c-2cf3-441c-4885af8425a9@arm.com>
 <1af5220c-f598-58f4-488e-fdd505477ed5@linaro.org>
 <fc2e095f-d417-1547-4075-9ece1aeaaf4d@arm.com>
 <CANO_MS+n6CTom-o7Hs4dKtPf-2uih5R7_8BnU_b4Jv8g1a5dkg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b98c6196-d3e5-888b-e85e-633deefe1a49@linaro.org>
Date:   Mon, 30 Nov 2020 10:40:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANO_MS+n6CTom-o7Hs4dKtPf-2uih5R7_8BnU_b4Jv8g1a5dkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/11/2020 10:03, gao yunxiao wrote:
> Hi Daniel
> 
> Thank you for your the new information
> 
> I have a question trouble to you
> We should choose which per-core thermal zone as the IPA's input
> reference temperature in the current kernel version? thank you.

Can you give a pointer to a DT describing your hardware ?



> On 27/11/2020, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>> On 11/27/20 1:26 PM, Daniel Lezcano wrote:
>>>
>>> Hi Lukasz,
>>>
>>> On 27/11/2020 10:27, Lukasz Luba wrote:
>>>>
>>>>
>>>> On 11/27/20 8:35 AM, gao.yunxiao6@gmail.com wrote:
>>>>> From: "jeson.gao" <jeson.gao@unisoc.com>
>>>>>
>>>>> virtual thermal node definition description in dts file
>>>>>
>>>>> Signed-off-by: jeson.gao <jeson.gao@unisoc.com>
>>>>> ---
>>>
>>> [ ... ]
>>>
>>>> It's coming back. There were attempts to solve this problem.
>>>> Javi tried to solved this using hierarchical thermal zones [1].
>>>> It was even agreed (IIRC during LPC) but couldn't continue. Then Eduardo
>>>> was going to continue this (last message at [3]). Unfortunately,
>>>> development stopped.
>>>>
>>>> I also have out-of-tree similar implementation for my Odroid-xu4,
>>>> which does no have an 'SoC' sensor, but have CPU sensors and needs
>>>> some aggregation function to get temperature.
>>>>
>>>> I can pick up Javi's patches and continue 'hierarchical thermal zones'
>>>> approach.
>>>>
>>>> Javi, Daniel, Rui what do you think?
>>>
>>> I already worked on the hierarchical thermal zones and my opinion is
>>> that fits not really well.
>>>
>>> We want to define a new feature because the thermal framework is built
>>> on the 1:1 relationship between a governor and a thermal zone.
>>>
>>> Practically speaking, we want to mitigate two thermal zones from one
>>> governor, especially here the IPA governor.
>>>
>>> The DTPM framework is being implemented to solve that by providing an
>>> automatic power rebalancing between the power manageable capable devices.
>>>
>>> In our case, the IPA would stick on the 'sustainable-power' resulting on
>>> the aggregation of the two performance domains and set the power limit
>>> on the parent node. The automatic power rebalancing will ensure maximum
>>> throughput between the two performance domains instead of capping the
>>> whole.
>>>
>>>
>>
>> Make sense. Thank you for sharing valuable opinion.
>>
>> Regards,
>> Lukasz
>>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
