Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007DE21DE15
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 19:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbgGMRBF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 13:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbgGMRBE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 13:01:04 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD54C061755
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 10:01:04 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id j10so10459084qtq.11
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 10:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P0iBC/WN/QpVqecFxZ7dZUdqk1Yv3dfke4IJQgmo7vw=;
        b=CJ8JSST77FVzlY08ahfSo7BV8d1SMIbx5VuVK6KmkCScq6LqOIjMa8dRRTN4zZoB1S
         RX+njTlua5cC2H4AevbdIVNkPHbAs9CuUEunmPpq+hxDiznnIMmwfX9L654Y+y9RVHyQ
         0swjRb04Db0kVLVzf28MFtF/rhv5R8d2CsVVh6xy/8H3D8z1kr74BgaTFJ/1ByryBi5u
         3EfuxQhHopgEIbrC8ZXONRvvNty0Sjhad4ww5IS38vCOJoN9wIB719EkukFf52ZHwBSH
         h9SFmWdT/Fg7614YUtwmkK3crRhW3sYx83BfG71otxqKzYSxRt4LrOWj6aJcXltmgO7E
         t8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P0iBC/WN/QpVqecFxZ7dZUdqk1Yv3dfke4IJQgmo7vw=;
        b=JiUhG0SGXeCxRiA2/mCcnG2Luhva7EnBktK58k+YRoayQObgfViM1LmZwASryrjDKH
         RtmSGqekMV5zU+cRc4icSuson8cSZnEiuipUNvO8XlGlBBP+cphsnfjNJu9lRBuYfl18
         B2xgCm9tt5NPPUnHfNYYVHvsa6b3qW+GyoPafKTmSoHXXh/ZJGK9WWH5ad00JqSCYcbl
         JnkOh63D7YsB6P7ZPokd3b30TqdeMTRaQEKbcdpymnOXlfqM/x2Wqz8mGwMTq5XWCKVD
         F0+ZJ2dkWnP2BhsgXa53At2Yr8GceaMsYVVDq5GPchb6RpukfGNy3dCYFFP3cekSEBlm
         ZWcw==
X-Gm-Message-State: AOAM531kgNnJ4dIMHt3pYOg6NrT8eTk947WYWj1VtSGZofOOtQ2ddDv6
        4MZgoE/uQoQkvRD81eV6OUTzSg==
X-Google-Smtp-Source: ABdhPJyhlffBbLpO9vlLtuMxcv6sdBRtlI41L28L7FXDX7Y87Wn4OqCeI/zqveRdQJdN2muBVmbeEw==
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr304912qte.196.1594659663213;
        Mon, 13 Jul 2020 10:01:03 -0700 (PDT)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id z18sm20097156qta.51.2020.07.13.10.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 10:01:02 -0700 (PDT)
Subject: Re: [RFC PATCH 1/4] dt-bindings:thermal:Add cold trip point type
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200710135154.181454-1-thara.gopinath@linaro.org>
 <20200710135154.181454-2-thara.gopinath@linaro.org>
 <08503e0c-c8db-6d03-9692-5339dadf6c4f@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <2b845792-41f0-7fb1-122e-a77aa70c9a3c@linaro.org>
Date:   Mon, 13 Jul 2020 13:01:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <08503e0c-c8db-6d03-9692-5339dadf6c4f@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/13/20 11:05 AM, Daniel Lezcano wrote:
> On 10/07/2020 15:51, Thara Gopinath wrote:
>> Extend thermal trip point type property to include "cold" trip type
>> indicating point in the temperature domain below which a warming action
>> must be intiated.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/thermal/thermal.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
>> index f78bec19ca35..1689d9ba1471 100644
>> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
>> @@ -87,6 +87,7 @@ Required properties:
>>   	"active":	A trip point to enable active cooling
>>   	"passive":	A trip point to enable passive cooling
>>   	"hot":		A trip point to notify emergency
>> +	"cold":		A trip point to enable warming
>>   	"critical":	Hardware not reliable.
>>     Type: string
> 
> 
> thermal.txt should have been removed. Perhaps, a patch is missing. The
> thermal.txt has been converted into 3 yaml schema.
> 
> The change should be in thermal-zones.yaml.

Hi Daniel..

Thanks for the review. My bad.. I will fix this in the next version.
I can send a patch removing thermal.txt as well


> 
> 

-- 
Warm Regards
Thara
