Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5CF27AC98
	for <lists+linux-pm@lfdr.de>; Mon, 28 Sep 2020 13:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgI1LVZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Sep 2020 07:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgI1LVZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2020 07:21:25 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7F8C0613CF
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2020 04:21:24 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c18so392750qtw.5
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2020 04:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WGmrNVltU47hsQ2DtZURkPQvI82shboAR3TseDZfLzA=;
        b=OvZnWePH2N/uSdOvV0Jyqo9hXNBCId8vIfJ1g+gMRcBHG6abkV0ZwOWtfNtLr377Dk
         eqPhNMyXfkmbr6k/qi/zbaw0kw9SvCeCsxASbrBwpmlgVRkZoh8yQCvK4A3uSHUTBmuZ
         JkjJzAT2KnACdZtyZpkMO82UD664w8MvmwS5QLAFHR0MnWan2yTkmPS9iLPCDKgCB+bi
         nCpn1MvnWWIUqS9YWDN9EZ3Bruuu7f+pEupf/FeH3wasWsdvcZkoHLu+CFOQ2eC2MnKO
         FDzsolUiLw2uN8iuaiYhzs1sUdF3qm8E/+Gom5VK1jxZqD/aZmVdfaV7WU6R5ryYQYz/
         3jKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WGmrNVltU47hsQ2DtZURkPQvI82shboAR3TseDZfLzA=;
        b=Zv7q87UcKAhVhaojEHKf5gQP4rwieaffQx4H2dCIYRkdcPGg6KSL4zkOFSFLSh0c6K
         OQISE6n32luyRO0tzZg6u59U8Bp0ZYw6DkCSAgMrv/x+qX/X5oIpe34Mf3gpxHBl+p97
         uLkvutJN4dHsoqcSQzXBn4YZIDoHneCZxQqYLOO1nMsovlwLka1BKaQr3Z99EIECiJX7
         Nkf1HPmJGE+AiaNzN+lWzgdldMeIw3mp6xuuHzDYnVpILRWx10E6TLPvsvIKog0u22BW
         3eRq/XSKDVdPnnlvLc54JSDRj3jLUPNb2syewKjdmP+iMbPkFbEK3J9Nto8Aalue9mY9
         UAdg==
X-Gm-Message-State: AOAM533O8Jb30XW5qWuXIoXbqTP5O2nSMlvO4BK0tFcBZK63xFOmTskf
        L1HIzSZnYZJfC6rh4jsHPJTiOg==
X-Google-Smtp-Source: ABdhPJwm8fb7PhQK230zIRzA20KdHBipubUMcovAIRTBXu5FanE/gWWVy+/lvX1/magPx4cHrPCqiA==
X-Received: by 2002:ac8:6d32:: with SMTP id r18mr998010qtu.246.1601292083949;
        Mon, 28 Sep 2020 04:21:23 -0700 (PDT)
Received: from [192.168.1.92] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id t10sm660841qkt.55.2020.09.28.04.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 04:21:19 -0700 (PDT)
Subject: Re: [PATCH RFC 1/8] dt-bindings: thermal: Introduce monitor-falling
 parameter to thermal trip point binding
To:     Rob Herring <robh@kernel.org>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, lukasz.luba@arm.com,
        amitk@kernel.org
References: <20200917032226.820371-1-thara.gopinath@linaro.org>
 <20200917032226.820371-2-thara.gopinath@linaro.org>
 <20200923160328.GA833754@bogus>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <2f923e40-8543-0827-f72f-d8c7df51e4b6@linaro.org>
Date:   Mon, 28 Sep 2020 07:21:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200923160328.GA833754@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,
Thanks for the review.

On 9/23/20 12:03 PM, Rob Herring wrote:
> On Wed, Sep 16, 2020 at 11:22:19PM -0400, Thara Gopinath wrote:
>> Introduce a new binding parameter to thermal trip point description
>> to indicate whether the temperature level specified by the trip point
>> is monitored for a rise or fall in temperature.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>   .../devicetree/bindings/thermal/thermal-zones.yaml         | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>> index 3ec9cc87ec50..cc1332ad6c16 100644
>> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>> @@ -161,6 +161,13 @@ patternProperties:
>>                     The active trip type can be used to control other HW to
>>                     help in cooling e.g. fans can be sped up or slowed down
>>   
>> +              monitor-falling:
>> +                description: |
>> +                  boolean, If true, the trip point is being monitored for
>> +                  falling temperature. If false/absent/default, the trip
>> +                  point is being monitored for rising temperature.
>> +                type: boolean
> 
> What if you wanted to monitor for both?

You usually don't want to. At really low temperature trip (5 degree C or 
0 degree C) you care about starting to monitor when the temperature 
falls below the trip. At high temp trip points, you care about starting 
to monitor when the temperature rises above the trip point. The thermal 
framework takes care of stopping the monitoring (dependent on type of 
monitoring, hysteresis etc.)
> 
>> +
>>               required:
>>                 - temperature
>>                 - hysteresis
>> -- 
>> 2.25.1
>>

-- 
Warm Regards
Thara
