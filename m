Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C3E78728F
	for <lists+linux-pm@lfdr.de>; Thu, 24 Aug 2023 16:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241848AbjHXOzJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Aug 2023 10:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241918AbjHXOyu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 10:54:50 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F397B19B2
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 07:54:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3ff5ddb4329so6417415e9.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 07:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692888886; x=1693493686;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mkAw/bivm1OGKzjaSsLX8nP7QHQBExerVYA8MZBISMY=;
        b=lrBSCRCwwCFV0tQuVa7GVmAwI6r1yEuw7xAqRyOX1C427KUeSWUSX/F1ZsCwDzCaq7
         s1S0LR1qK9q/YwFDa885VWWRy8iNRRnfaymnMqxR79SskbQdqEd3xpKbyIzMkM6bdCci
         1u46jFW2FIYwyGWdYJ9HWRORrNo4RA4SJQQdFGi0MoXCfIx4KrOEByEpkDep8ISNWfnB
         gRy5lMLNvW7ByMBB3sbKb1p1XtpTA4rfKN4yusY0l/vYQY3+JR08+he6xFUz2hintem0
         8EhRttXtFQRoimFdyeIZDaNPqSYci0+SjuRqFlMp3BqAMbGvPpkDUfePfxv+gz68bTqv
         xt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692888886; x=1693493686;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkAw/bivm1OGKzjaSsLX8nP7QHQBExerVYA8MZBISMY=;
        b=SSBFeG7Zf2Cq+hlm7GEhlcQPXVE3wk+keo8D6xe8cmr+e0DwvMGo6KQHEy5+UjxcuX
         VK/xv5IuTh5MWAq//JEzZU8/e9hSCapu3JfQq0Li+oiuFZRM8q+kaDxd+fsYcxKrqUw5
         Cty3Hnj9Nb5WKMtF/MOmR+5+ZDvLT5/f4moG+Yk/FeIge99dWyfGfra70VNTA3oY6kOL
         /0NDmIEqJpUqS5fIdTpe9JMnGnCCO0lbVRsx2iXd6RRTVEW9U3CUqTeBZC7O+HoqtyCs
         DbHkdlyhBcAUG2yS1r14wanGqJVqlHK3ovBiaaKR484mPrfctMZ8JWCQU/nkE85vH+MO
         sT8Q==
X-Gm-Message-State: AOJu0YzI4utPqAZN4FzvqZsPnlCnOn3ZAn9hv7QenmSG8wfv9XM72w+a
        ltcTAMMuGl2aux8vOzn+42Zb0g==
X-Google-Smtp-Source: AGHT+IHRtF42Gk2O/Jbn0im820D3YniuUrsfbfG6LB6IaJc38fjjssskEpoRn3XkIl8Ntlzt2PT2Qg==
X-Received: by 2002:a5d:5412:0:b0:319:735f:92c5 with SMTP id g18-20020a5d5412000000b00319735f92c5mr14859666wrv.32.1692888886338;
        Thu, 24 Aug 2023 07:54:46 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id i14-20020a5d630e000000b0031980783d78sm22380031wru.54.2023.08.24.07.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 07:54:45 -0700 (PDT)
Message-ID: <71a842cb-86c4-cd36-ba4c-0be480f8b16c@linaro.org>
Date:   Thu, 24 Aug 2023 16:54:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: imx8mm-thermal: Document
 'nxp,reboot-on-critical'
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
References: <20230823173334.304201-1-festevam@gmail.com>
 <cd1985cf-f13b-8d5b-1f67-f93bae98ce7d@linaro.org>
 <CAOMZO5CPz=ysfjb_x3T0FqKxjTPy1zippZRnkMXCTuyD7fF57g@mail.gmail.com>
 <8070b293-b187-b0cc-fd3d-d057c5623094@linaro.org>
 <CAOMZO5AZh6DUbZJecwaK8jwGBRCj+40GF5OqyuV2c8mgXT9ZYg@mail.gmail.com>
 <36e24244-3382-b6bb-5975-044112d21eed@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <36e24244-3382-b6bb-5975-044112d21eed@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Krzysztof,

On 24/08/2023 14:38, Krzysztof Kozlowski wrote:
> On 24/08/2023 12:53, Fabio Estevam wrote:
>> Hi Daniel,
>>
>> On Thu, Aug 24, 2023 at 7:35 AM Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>>
>>>> I will try a different approach by introducing a Kconfig option.
>>>
>>> Alternatively, the 'chosen' DT node could be used, no ?
> 
> Any DT property would be a problem, because I don't think it is static
> configuration. For example board with the same DTS once should reboot
> (during development) and once shutdown (some customer wants to be sure
> it will stay shutdown after critical condition). It's runtime feature.

Fabio described the feature as a firmware feature where the board does 
not boot until the temperature goes below a certain temperature.

That does not look a runtime feature but a platform specific one.

 From my POV, if the firmware wants to take over the thermal boot of the 
board, it is probably for a good reason (eg. the board will overheat 
between the boot and the kernel puts in place the mitigation framework). 
Letting the user to change that behavior can be dangerous.

>> Good idea. I will introduce a module_param() then.
> 
> Module params are usually discouraged

Why?

> and it also does not allow any
> runtime configuration. I think you need sysfs ABI.

There is already the sysfs ABI with module params

/sys/module/<name>/parameters/reboot_on_critical



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

