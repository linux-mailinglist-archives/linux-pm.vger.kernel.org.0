Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAA740D83B
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 13:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbhIPLSH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 07:18:07 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:37088
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236774AbhIPLSG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Sep 2021 07:18:06 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 15F084015F
        for <linux-pm@vger.kernel.org>; Thu, 16 Sep 2021 11:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631791005;
        bh=UXq/IEFZVtb+dXj3jPcLu567vbwU2ZCcPRqhUQdx3Wk=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=WTD5jdTjfDXsDAnhuypNh/WzAQBqMsdm0xJWGlpDyyQbF9x2ORj45uW1Z+FLAgEDU
         nOhXJrrFtcwRgNhMx9Ms6wD+EfE+aRG//eB5OFvQe8gM9Po0EYBln8mIu3ilfaG1/0
         PwLVlcYZvUYOZANMIibE+va695fIIVe5vbr8ZZmu8IEDwcFqX0iUs/2ZoJw1qU1KxP
         D2g5b3CcUafigMqgLOFJPXrtO5uBIa1S2l8Jkz2owOnmA3ZTjlPuWCzjeGvDbrllyN
         GLBmFQw9CnXcXE4vyw6BEYnUDO92TYOy5pdde0oevtAOftLKpr0f1YUxSg9W6PVhXa
         CGR8UwrtRDByA==
Received: by mail-wm1-f71.google.com with SMTP id z18-20020a1c7e120000b02902e69f6fa2e0so2980267wmc.9
        for <linux-pm@vger.kernel.org>; Thu, 16 Sep 2021 04:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UXq/IEFZVtb+dXj3jPcLu567vbwU2ZCcPRqhUQdx3Wk=;
        b=1XO0FdyLbWEAB842WCCtEurQwaXMDVCsiV3o9qKH7q69iwZUj9zGXDFXT4ksdIBluE
         83CLTbETdxK8O+dTdhWndhsFz8dI1b8FgvNn7PioBa4WszA6RcbRGlIdkotrbcWn0ZsW
         nx7EAehDkYbWOzcwqiy4kTLyKM7eGsFgPaIUG84rj+WyLYpD1IdSO+NqPRV6kW/X2QGB
         pqg2KmQhAiWw58paRUtawA/RD0+cCe6uvWQunTy3Y1Bjl+pdmjMWPrEaNRlSrUBlqHa7
         +23tQPR+D6WrNpmBW4gjRWXCq6GsKzRRsjQkdXgLmFCyKr1yhy8WHHUn1Nf8HuwltRLw
         nwRQ==
X-Gm-Message-State: AOAM5314FGs08nu3BW5/V2bVz9r173Ijd32u9rw5Bbhmm5L0dSOwR+h+
        DqzqsTwPZp60suhJ6sYpV71fZngMFrMjelNX/ufjAhhNRkRNr295twl1Ub9sx6E+a4aHrLsOG8T
        zbtZ/vn8jHgqyX6KWLj6PUyCDZXhD/teDdjqi
X-Received: by 2002:adf:b319:: with SMTP id j25mr5491428wrd.256.1631791004637;
        Thu, 16 Sep 2021 04:16:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPUYPtugKgY5biMl0OjTAOdNuK5egkmHMFoaDuBJ2DWRk5mx3hS8X+eQzKUYhNjcOhIbqIbg==
X-Received: by 2002:adf:b319:: with SMTP id j25mr5491411wrd.256.1631791004497;
        Thu, 16 Sep 2021 04:16:44 -0700 (PDT)
Received: from [192.168.3.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id c30sm3021368wrb.74.2021.09.16.04.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 04:16:44 -0700 (PDT)
Subject: Re: (subset) [PATCH v2 4/4] ARM: dts: exynos: align PPMU event node
 names with dtschema
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        linux-pm@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
References: <20210820150353.161161-1-krzysztof.kozlowski@canonical.com>
 <20210820150353.161161-4-krzysztof.kozlowski@canonical.com>
 <CGME20210915075117eucas1p11e3c07d77f1f0dc43c9e4685665eb494@eucas1p1.samsung.com>
 <163169222223.16372.15525688455985156121.b4-ty@canonical.com>
 <9ed20f4b-ca45-54d3-2577-976a9e55eb9d@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <0212a402-1490-0f8f-005e-32bb6f636a13@canonical.com>
Date:   Thu, 16 Sep 2021 13:16:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9ed20f4b-ca45-54d3-2577-976a9e55eb9d@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/09/2021 13:15, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 15.09.2021 09:50, Krzysztof Kozlowski wrote:
>> On Fri, 20 Aug 2021 17:03:53 +0200, Krzysztof Kozlowski wrote:
>>> Use hyphen instead of underscore and align the PPMU event node name with
>>> dtschema.
>>>
>>>
>> Applied, thanks!
>>
>> [4/4] ARM: dts: exynos: align PPMU event node names with dtschema
>>        commit: fb9b199e562d66af90f61d70eb737fa5e4deac2c
>>
> This breaks probing of Exynos event counters, which are needed by the 
> Exynos DMC driver on Odroid XU3/XU4/HC1 boards. Just check the today's 
> linux-next. I had no time to analyze which part of the code depends on 
> the node names though...

Thanks for the report. I'll drop the patch from my queue and check later
the driver.


Best regards,
Krzysztof
