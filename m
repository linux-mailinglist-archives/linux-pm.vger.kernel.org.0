Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCAB437176
	for <lists+linux-pm@lfdr.de>; Fri, 22 Oct 2021 07:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhJVGAw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Oct 2021 02:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhJVGAw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Oct 2021 02:00:52 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22138C061764;
        Thu, 21 Oct 2021 22:58:35 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i6so516638lfv.9;
        Thu, 21 Oct 2021 22:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LjFmEeV00RuFncTblJ5Dy7JPoBVQH1IRuNrpKBOX7Sk=;
        b=ofO598ygKjxBqO2DT5JrnUeVP8xaYK5mJYy0mg9YogHwEmITstNU5oU9xRi+kc6GtZ
         PIeq1o8QJ1orsMKRgHnrO2mxzGncDlkRQNw/ORDGp1rpvh58xTgahr1NQ+D5W+43c3Mk
         sHiH/6bbY3jHU3i2N4sESlejbpjQrKSUGVL8o3RMVjorzBzAfE+ts1MV1qEN8DxvnLCv
         5WsKyEZ8DJNmizkSCrUME7yZuuEMwhR47NlVoZWjo5P0GSLqiaX7VZaQ9ETsyO3lRKOS
         l3pIwa4bCbXlEAImbZZKsvY7vFZYEbm6GoZ8cKjSM+q2KGyli6CC6vfISAfuTQ6ukC0h
         6TtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LjFmEeV00RuFncTblJ5Dy7JPoBVQH1IRuNrpKBOX7Sk=;
        b=orCEgal+y0lEIrGbiv0LXk6DrvkbOKA9DPBsFpvAvAPosDpqy47psQphhtM2slbRrD
         7yYpdfDj+4kAISHXvkBzOru4i8SxLvVR97cyg8kt4Z6w8BJN7P8E/w2p+2Ap7Pqp/GsH
         yITvYY3gwXYQEseySdsFTYps/00zqHJj3I8Nlf+YIGOpBR59hL8ra4ENPvMEeD3AJAT0
         /Kj59wybKm8uo4+130W73ZQC4bSFfWzqHxPWaUvIiXuBpTHNVyXLjzdy5JHkNLBQgB6w
         U39nsCE5H+G2WDsWrW0yOrr5hMm76ycxDuXvEIDWDbWJYYazgr5jaOKIDWMI5Fx8DPZb
         PP0A==
X-Gm-Message-State: AOAM533AEeUpDmCDlq25IpNsIwc8iou8k/rznB7CAxrG5O4S5136F86e
        u+gLrSmHmG6Yt2IEHTSo+3TiZPj6ff0=
X-Google-Smtp-Source: ABdhPJzfP+XFNKubQWaoU3N36DnYL2ckZCnZPzWNBKTZGZwUw9z6pE4uNby581VLTrXRJ9ycegKIpw==
X-Received: by 2002:a05:6512:3d14:: with SMTP id d20mr2840289lfv.542.1634882313098;
        Thu, 21 Oct 2021 22:58:33 -0700 (PDT)
Received: from [192.168.2.145] (94-29-61-202.dynamic.spd-mgts.ru. [94.29.61.202])
        by smtp.googlemail.com with ESMTPSA id v3sm788208ljv.7.2021.10.21.22.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 22:58:32 -0700 (PDT)
Subject: Re: [PATCH v1] dt-bindings: opp: Allow multi-worded node names
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nishanth Menon <nm@ti.com>, David Heidelberg <david@ixit.cz>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211019231905.2974-1-digetx@gmail.com>
 <YXAr4OlhucAibMlH@robh.at.kernel.org>
 <20211022044334.4yn3i4kwinbrjicd@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6e26c2fe-9288-1d90-585f-f173e693d9e8@gmail.com>
Date:   Fri, 22 Oct 2021 08:58:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211022044334.4yn3i4kwinbrjicd@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

22.10.2021 07:43, Viresh Kumar пишет:
> On 20-10-21, 09:46, Rob Herring wrote:
>> On Wed, Oct 20, 2021 at 02:19:05AM +0300, Dmitry Osipenko wrote:
>>> Not all OPP table names and OPP entries consist of a single word. In
>>> particular NVIDIA Tegra OPP tables use multi-word names. Allow OPP node
>>> and OPP entry name to have multi-worded names to silence DT checker
>>> warnings about the multi-word names separated by hyphen.
>>>
>>> Reviewed-by: David Heidelberg <david@ixit.cz>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>>> index ae3ae4d39843..298cf24af270 100644
>>> --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>>> +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>>> @@ -22,7 +22,7 @@ select: false
>>>  
>>>  properties:
>>>    $nodename:
>>> -    pattern: '^opp-table(-[a-z0-9]+)?$'
>>> +    pattern: '^opp-table(-[a-z0-9]+)*$'
>>
>> I don't see how this helps you. What I see needed upstream is a prefix:
>>
>> '-?opp-table(-[0-9]+)?$'
> 
> I wonder if we should disallow that to keep naming more consistent.
> 
>> Though really what I'd like to see is the OPP nodes moved into the 
>> device nodes they belong to when appropriate (i.e. when not shared 
>> between multiple devices).
> 
> +1
> 
> The only reason for keeping it outside was because CPUs were sharing them.
> 

Not very doable for Tegra device-trees. Those OPP tables are huge, it's
impractical to put them into device nodes.
