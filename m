Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD27A435A8C
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 07:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhJUGBa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 02:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhJUGBa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 02:01:30 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1982C06161C;
        Wed, 20 Oct 2021 22:59:14 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id d13so2250286ljg.0;
        Wed, 20 Oct 2021 22:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AqP+rW3LM6sbjMut4cEUwJH0FzaeTM8RqLIE4IGSWQI=;
        b=IMbqWkxb/oKiYZDY9WqqrsR0jFk434X+nZ3C4QtExXDGTcAY4gNyaxbXSa7d13ybFD
         7JzTFLjhXSIFA/TKn3379dbkih84uz73Pz+80Ie/ZAWwLE2RATL/O7umFMA8SxnYuZgE
         gw6teE+nS1K5sBFlHnxM41W4fmVrbz2KCt0DnYYDAAwloqQ3GbRryblVDL9uuCr5OIOs
         n38yVXR7UzEy5evd4/+pNBFAiixdb6NBe1w6aIqZ1P/B1dRtpAUXtWeavcIT9xZAjeop
         QVfh7mCZx+YLGKBjQLU9RLt2D7ql3ewafUt/rxFePWBUpusJ0sM4svHa5rpZA3QBGihy
         JGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AqP+rW3LM6sbjMut4cEUwJH0FzaeTM8RqLIE4IGSWQI=;
        b=SPxLBhQUOKbM7E30lK/WABXduHxZDEFEkrQCeIpM7Uq/FESzoz/ALf+jMkGoacZguj
         fwFkiOfGdyE/c9wpH2pCwluqfGmVp5N9eTt0gsld4SZTd+dfKi52cHD5O1gQM7ujuFkO
         jmapajnQrFL2pYIyuQxIMDnehyMnX+E+jVgr6dcBWFsNa5/2O5MFvSuSn5uiE1M6w9XO
         ha9+NHN7ors7CwTECrSHHNZOcK+uhhgMYNDkeqth9laF9foRShjzJ32YLtg3FTHwEnY9
         Za9mrR4SGB0aDNUyxpA7ki2cZl719lMa+Y8ztSKElpj6nMaKY6XPpLuRJ3rkBlPzppco
         N0pw==
X-Gm-Message-State: AOAM533v+zC+V3v9yLceh3q4o8QMyKWZ3rB0gmj8YtoM0hMm6EuwTtaL
        pqHZHj+PQ3aR1iY/o2hSTmtdUNuMB9U=
X-Google-Smtp-Source: ABdhPJwRcRtZErko2VhI90eXbF/PQ4bWvtdAndtaJOcrxakmp+eB8TpXUv4i2w44bb1Xtlpywp0PpA==
X-Received: by 2002:a05:651c:544:: with SMTP id q4mr3917570ljp.53.1634795952528;
        Wed, 20 Oct 2021 22:59:12 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-10.dynamic.spd-mgts.ru. [94.29.39.10])
        by smtp.googlemail.com with ESMTPSA id j19sm366543lfb.249.2021.10.20.22.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 22:59:12 -0700 (PDT)
Subject: Re: [PATCH v1] dt-bindings: opp: Allow multi-worded node names
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nishanth Menon <nm@ti.com>, David Heidelberg <david@ixit.cz>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211019231905.2974-1-digetx@gmail.com>
 <YXAr4OlhucAibMlH@robh.at.kernel.org>
 <85f84713-1eff-4ebf-df25-adb967dcb440@gmail.com>
Message-ID: <9afaf430-6cd9-b475-cf93-2a400df6b223@gmail.com>
Date:   Thu, 21 Oct 2021 08:59:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <85f84713-1eff-4ebf-df25-adb967dcb440@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

20.10.2021 17:59, Dmitry Osipenko пишет:
> 20.10.2021 17:46, Rob Herring пишет:
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
>>
>> Though really what I'd like to see is the OPP nodes moved into the 
>> device nodes they belong to when appropriate (i.e. when not shared 
>> between multiple devices).
> 
> I already prepared patches to rename Tegra OPP tables in accordance to
> the new naming scheme where opp-table- is the prefix.
> 

Now I see that there are other device-trees than Tegra which use the
"postfix" naming scheme. Hence we should need to use this variant to
cover both cases:

  '^([a-z0-9]+-)*opp-table|opp-table(-[a-z0-9]+)*$'

I'll prepare v2, thanks.
