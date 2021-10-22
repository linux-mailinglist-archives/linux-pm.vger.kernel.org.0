Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3190A4371FA
	for <lists+linux-pm@lfdr.de>; Fri, 22 Oct 2021 08:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhJVGnM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Oct 2021 02:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhJVGnL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Oct 2021 02:43:11 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4945C061764;
        Thu, 21 Oct 2021 23:40:54 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 204so1016139ljf.9;
        Thu, 21 Oct 2021 23:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AUAtMKuxMsjzOIyLD1CPPnq43vKQM5zHWJL7mwZ9Rhg=;
        b=JYkyD5EvuQchO/VB/4Kth1YHsnnQrg7H3jXOa72ZS60GzzUtndEX63CHlQgCh7xjLH
         mnV6NLbNuNFLJ+8kvAHh7tklexVxn8v18yTArTxFVC2Iawruv7HzuYjFt0hjeYKTup1d
         AYdEEf/mYp+sGtQqwnlv4lMNVwTA2uqKwOGlw3dX9Zi/z7Rfm7NqSurCa0QqFsviF63V
         5Kt0bjIqCWYuhWkqKWGmMh6mDmbawq2v3ZTqPQuPkG90F/tWoDj/1of1brvs5+CZn1uc
         0gr5nTkHx+x2PRvqeWdsPaLzS8i7ijf9O8OtzE7hJ0tuTl2qbLiHNCB5UABI5udn0Tfe
         0F3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AUAtMKuxMsjzOIyLD1CPPnq43vKQM5zHWJL7mwZ9Rhg=;
        b=M0XcXa+LqbKnh8kWJAqqjJbCI2nFNHTtPsU6YGfq069kdJQ8NCYPjzal+0KzKBNwqF
         Ok/PAjwq4nmX0xnOU3+I8+Py2f/JdvPhlJWwHK3pIsZSQmwDO0J3kBPCcBJj/c01UI9d
         P314OrJA7DZ9yUKkFwU0ACN+kjB3CzUzqE8MEcwlJDu09hamQaiNBK2AQ4vLE+ZitoYi
         xAOYluz36swXSrO7ZZ2kNV1+WcIwSLM6O9hSBT+XuCbjVHxO0RhWFPc8pbBUlx2v2sjG
         o2sBYjdDZ+5omSpxvSktVTcAe/UZNzTqJataMMYDyLrW4esKSgNKtpIXoJk7Sux39hsi
         fjJg==
X-Gm-Message-State: AOAM531ZKLczdBu5nn1nCFfq/sMFoSB36nqYqvWFuoUSIJN3b87xF/sz
        WR5Fj+kGRcg3vFNaJAr226owmr4ncJ4=
X-Google-Smtp-Source: ABdhPJztwHqSpdRLmKUut71b7G+onl4clcdxyYfKJIsiASIdfg0iF72aXmBBcAmKdsfb+ixnF4k73Q==
X-Received: by 2002:a05:651c:2c7:: with SMTP id f7mr11171135ljo.480.1634884852871;
        Thu, 21 Oct 2021 23:40:52 -0700 (PDT)
Received: from [192.168.2.145] (94-29-61-202.dynamic.spd-mgts.ru. [94.29.61.202])
        by smtp.googlemail.com with ESMTPSA id g7sm805440ljl.83.2021.10.21.23.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 23:40:52 -0700 (PDT)
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
Message-ID: <48de7f40-deda-739d-96ca-e61ec5a0b257@gmail.com>
Date:   Fri, 22 Oct 2021 09:40:51 +0300
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
> I wonder if we should disallow that to keep naming more 

I also think that postfix variant should be disallowed for consistency.
I sent out patches for both variants.

V2 uses pattern that supports both naming schemes. If V2 is less
appropriate, then please take this V1.
