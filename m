Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077336B381A
	for <lists+linux-pm@lfdr.de>; Fri, 10 Mar 2023 09:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCJIHu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Mar 2023 03:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCJIHs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Mar 2023 03:07:48 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8250E1FC6
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 00:07:13 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o12so17077143edb.9
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 00:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678435610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rVnc0kHjfb6WR8zgiNTVTUOi5y/jlNnTwVPCFa2f25o=;
        b=PQVaU71ja1FYrRO2JIec5pr5R4/fVxTiFP1DTfFEovz2+Uw/7Z0Xa6RWSV1COUZ83N
         WWsOOJLKg49wDX8K6fVAuOdnALXL7GVuvSUnRqsLIFZbhSrcAchMudWOjPy3rqyHFW9d
         kY/YiGZQkV+xCj+/zjqNR6enrESRcnPyUciq/tzKCWwW1CkNVNKQDjHxUoHuJXdwkdfs
         J/rOjRUa+OLSbtRmbnyhahW+Kg4Tqt1ccWifhokogXJZOstZ5d6areW/Y37RAIvfb6qR
         jDMWcD1dvsFDjL2spVFIcXHFvtzXGESZpYWQnlHfkDHV4sbabovpbVkq44qivJ47DHUr
         Ib4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678435610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rVnc0kHjfb6WR8zgiNTVTUOi5y/jlNnTwVPCFa2f25o=;
        b=WGvbXKl9XYO5f6tVqTw4FUivp9Ln0mjVryG30hOKU6SgyvzQSrbkBCQ94G/7NoSvDF
         u6I3dhZ+IlDT84PPIw42BqWyZ3jbnJt9KdGNUx+U+nbQA7yuYPssKXCVxCyrUCeBRUaB
         238GTfRKYrZ1wMnYT6ro1t5M9RPkxhIq4gDdkNYpPGpYZsjoGmB6/Euvdox1e6Zgxmfu
         ft3sWJ4m8HdOBRNqosMWH03gwLnrG3P8TNvfyuk2DLxczby4DgMuUBVVKEPreWmJFTj5
         lcdjIHTQnPHv76ioTf8LMqTyD2FWTUR3tYOtZO9QRstcvXtofPYKkTi7nbrANJjQqMzM
         4aKg==
X-Gm-Message-State: AO0yUKV677RTaXsFC+2FnkTkilw4BSPAqass3gHbqDoWyg9mHDJBrA0z
        tq5h4g5iVcA1v0QLmKH+IgXHIg==
X-Google-Smtp-Source: AK7set9OCiU6sz+Wb9xhH3agADyu3oF1kpKbiPqnJFZe+hETI4Y038QXJwU//HiMTmmFPwQjLwDAnA==
X-Received: by 2002:a17:906:12cc:b0:8f4:ec13:d599 with SMTP id l12-20020a17090612cc00b008f4ec13d599mr26071743ejb.27.1678435610090;
        Fri, 10 Mar 2023 00:06:50 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id s30-20020a50d49e000000b004c44d00a3b5sm521897edi.20.2023.03.10.00.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 00:06:49 -0800 (PST)
Message-ID: <a1290791-7589-32dc-fc96-af857d10aa61@linaro.org>
Date:   Fri, 10 Mar 2023 09:06:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dt-bindings: power: supply: bq256xx: Add ts-ignore
 property
Content-Language: en-US
To:     Hermes Zhang <chenhuiz@axis.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Davis <afd@ti.com>
Cc:     kernel@axis.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230309023926.38682-1-chenhuiz@axis.com>
 <49e67fb3-4ef9-5d50-c3e8-3c7857145bbc@linaro.org>
 <b2ac2d1f-3e9b-f96d-3724-020f7140b05f@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b2ac2d1f-3e9b-f96d-3724-020f7140b05f@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/03/2023 04:48, Hermes Zhang wrote:
> On 2023/3/9 18:12, Krzysztof Kozlowski wrote:
>> On 09/03/2023 03:39, Hermes Zhang wrote:
>>> Add a new property: ts-ignore to allow user to enable the TS_IGNORE flag
>>> in chip. Ignore TS pin will allow user to control the charging
>>> parameters instead of the default JEITA profile in chip.
>> You miss users of it.
> Could you give some more info about what I missed?

Users. DTS and driver code.

>> @@ -68,6 +68,12 @@ properties:
>>         Interrupt sends an active low, 256 μs pulse to host to report the charger
>>         device status and faults.
>>   
>> +  ts-ignore:
>> Missing vendor prefix... is this generic property? ts-ignore is very
>> cryptic. You should describe here rather desired system characteristic.
>> Why anyone would need to use it per-board level?
> 
> OK, I will fix it. Will "ti,ignore-ts-pin" be better? 

No, because does not describe system characteristic. Read again my last
two sentences.

> Yes, it's a 
> generic. To disable the TS pin, actually we also could do it from HW, 
> but from software, it could be more flexble. But if HW already disable 
> it, then you don't need to do it again from dts.

If this is configurable from HW, why this should be in DT?


Best regards,
Krzysztof

