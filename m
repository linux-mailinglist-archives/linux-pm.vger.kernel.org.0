Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0817C434E71
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 16:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhJTPCI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Oct 2021 11:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJTPCI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Oct 2021 11:02:08 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8688C06161C;
        Wed, 20 Oct 2021 07:59:53 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id e19so13051579ljk.12;
        Wed, 20 Oct 2021 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kK6UBOnqoF7OBIS0/DlDmrh5cokDG1xkwkc1sZI5FoY=;
        b=pTS/D6PFbnnP2+dkBHrAW3PGTnf098d8L+crzq8TeamIJ0xrpTAT7IF1jQ2/BGNIKW
         fbG+HHHiMecNZi/j7jJYWSTfNXQNQqyaB9wib4xa9SAYS2Fb0p913kBV9tFX6hwacGtz
         L21P8FTT93366htsr0cOxP7HBkwwiNnklnHcxlKPw4jl9He+AWOkE8H4ZLeli2172ynA
         SCoPFrE1h+e3cz5cI9NWLBMCRDtO/B/VGTzDRpNQpKvBYbdP+YDrLnkJsvNSk1/7Pj4a
         Q/MEk5XHTdtj2AngQxt4/etQYm15F4puPED16pCz8J8R4RTKnYIBrrhFUhXXaJv/+eks
         +yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kK6UBOnqoF7OBIS0/DlDmrh5cokDG1xkwkc1sZI5FoY=;
        b=OrKPLiiaHP5Vn1r11gI+yedBgD4+FltyYm0Fju4y5fk6zxezlTFNscrvEpr2hPxpeY
         Ra/Cj69NekZ7fMYm9ZhMOkAOuV+WyT54rnVsEoO8u0Iu8FOpxeScHXp4OffaR8oc8YGv
         mAC2Dkti/ggDKZ/wJaV6ScjkbmpL1dWtYsgX8cFKpBlAW6nYjuGyDoPABQJBhxN4jAIv
         2xv/KiVl+OAR9IRB4atLHrdsMhWoNasLxcduwja3Xe2v6fwfOtdSOyOcigH+iJFnUBg0
         OSRT/yD5GHBCDtXbb5baZnzZnHzchlJzKvdluCUJVJ61WAAqIML7vbuIddjVHsTq49ES
         psRQ==
X-Gm-Message-State: AOAM531DSV7sqV3s1Zb+qPIWMH5v88xBIvWVwU/xbrCtxwLEr+UArvOw
        2riM06UmdIu/l0xqYlNOyUZK0hW8xCQ=
X-Google-Smtp-Source: ABdhPJwX5ym1mw31vbP6LKcgrx0yysT/TRF0Pck1m6VvyJu/IqqP33SWuTojYYKOuFoAmL5RrME4Vg==
X-Received: by 2002:a05:651c:111:: with SMTP id a17mr138106ljb.145.1634741991919;
        Wed, 20 Oct 2021 07:59:51 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-10.dynamic.spd-mgts.ru. [94.29.39.10])
        by smtp.googlemail.com with ESMTPSA id z22sm249522ljh.73.2021.10.20.07.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 07:59:51 -0700 (PDT)
Subject: Re: [PATCH v1] dt-bindings: opp: Allow multi-worded node names
To:     Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nishanth Menon <nm@ti.com>, David Heidelberg <david@ixit.cz>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211019231905.2974-1-digetx@gmail.com>
 <YXAr4OlhucAibMlH@robh.at.kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <85f84713-1eff-4ebf-df25-adb967dcb440@gmail.com>
Date:   Wed, 20 Oct 2021 17:59:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YXAr4OlhucAibMlH@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

20.10.2021 17:46, Rob Herring пишет:
> On Wed, Oct 20, 2021 at 02:19:05AM +0300, Dmitry Osipenko wrote:
>> Not all OPP table names and OPP entries consist of a single word. In
>> particular NVIDIA Tegra OPP tables use multi-word names. Allow OPP node
>> and OPP entry name to have multi-worded names to silence DT checker
>> warnings about the multi-word names separated by hyphen.
>>
>> Reviewed-by: David Heidelberg <david@ixit.cz>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>> index ae3ae4d39843..298cf24af270 100644
>> --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>> +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>> @@ -22,7 +22,7 @@ select: false
>>  
>>  properties:
>>    $nodename:
>> -    pattern: '^opp-table(-[a-z0-9]+)?$'
>> +    pattern: '^opp-table(-[a-z0-9]+)*$'
> 
> I don't see how this helps you. What I see needed upstream is a prefix:
> 
> '-?opp-table(-[0-9]+)?$'
> 
> Though really what I'd like to see is the OPP nodes moved into the 
> device nodes they belong to when appropriate (i.e. when not shared 
> between multiple devices).

I already prepared patches to rename Tegra OPP tables in accordance to
the new naming scheme where opp-table- is the prefix.
