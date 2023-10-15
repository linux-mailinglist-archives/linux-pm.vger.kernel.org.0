Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325497C9C04
	for <lists+linux-pm@lfdr.de>; Sun, 15 Oct 2023 23:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjJOVyl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Oct 2023 17:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJOVyk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Oct 2023 17:54:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E6FAD
        for <linux-pm@vger.kernel.org>; Sun, 15 Oct 2023 14:54:38 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40651a726acso36008205e9.1
        for <linux-pm@vger.kernel.org>; Sun, 15 Oct 2023 14:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697406877; x=1698011677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0QG9vlqxiNVALcyUAQIY9+SbjzzlS00U4CnvIpEmDRQ=;
        b=c8IoE1VlOM4P9DeE5bJfPGlVr0Wb1LMAzh5d8PG+SvqnBc0nVUaBZkJqYihYDOaxSB
         BQApQS79Z4v8pF1ea1UvPY3pBQC+DNpUhmcOEGi2CJsHIx+csl0ugEFQ9IRGMWX2KJgK
         KYd+8iQnkV/cn9NsDC4iXejKtMBTW3D3O0FtlEYfvjtwJYjwN+r4CppydQkEI7dsqp5a
         rp+QuP3UUcKtfB3HBlvzTVYtymcYMgCNGRBlfV8V1KMW3tRODTq9m89AVZWH51KHJYr0
         PAlk6g1YV7ISOfC/Vtoc284501bvqd/I2hnyYzXIX8Z7FUiOC0J8JQoGx3rziJB8DXBx
         AaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697406877; x=1698011677;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QG9vlqxiNVALcyUAQIY9+SbjzzlS00U4CnvIpEmDRQ=;
        b=FYBll4eVBzPoRSuENO/TDeD9nvVhd4t+0gJpE6bZDoDBe4AaaIyN4ItzBjQw1OxDpc
         TdaysD+rcR7WLKbIic+UdI1NwQpqJM56d85qP7criemBWSH5jeBkdiPmvud/B/U8Tbo0
         /FM8tH0ZT+qHYVPRPJb3kjTojRn45tqP89LilIabRt1at5Z2+3JDvg1frrGCECjjqCmV
         kjl7x/BV1j261lUQ0E4Ce7KYxXd6FCYJnhXgA+UkQWh4wpBVLIbGuL0+VTB2039VFC1w
         Fuh9/BgyeElKsGTED8y/WtgQlbFy/xA9seS6jkWuD9c3PjYEH1JGDTInWA+cHA3BGNQZ
         4idA==
X-Gm-Message-State: AOJu0YwdSkEgQ2tO8+LQcJv+we9hb+xicLJOE2Xd81NNk+QBLXwayvw7
        2YW+jd7Xc0HgmbnXtlt/jxmsMI8mI3rUsC7j0VM=
X-Google-Smtp-Source: AGHT+IGXZ6gUTWqXb+xT9o+FleuWv6jXqAEwhIBbsrFbTegYHrtte+4y/J8ZdhEBguj+srpdLn/7kg==
X-Received: by 2002:a05:600c:1910:b0:407:859c:a1bc with SMTP id j16-20020a05600c191000b00407859ca1bcmr709327wmq.26.1697406877121;
        Sun, 15 Oct 2023 14:54:37 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id jb17-20020a05600c54f100b00401bbfb9b2bsm889040wmb.0.2023.10.15.14.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 14:54:36 -0700 (PDT)
Message-ID: <83dbd835-c36e-4e7d-a5e4-c572e19c649d@linaro.org>
Date:   Sun, 15 Oct 2023 23:54:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/4] dt-bindings: thermal-zones: Document
 critical-action
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>
Cc:     rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20231006180453.2903342-1-festevam@gmail.com>
 <CAOMZO5CfW10dwVDYaHkvhTMKeHw38ZAt1kdH8qB=8AM=cqdHvw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAOMZO5CfW10dwVDYaHkvhTMKeHw38ZAt1kdH8qB=8AM=cqdHvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/10/2023 12:39, Fabio Estevam wrote:
> Hi Daniel,
> 
> On Fri, Oct 6, 2023 at 3:05 PM Fabio Estevam <festevam@gmail.com> wrote:
>>
>> From: Fabio Estevam <festevam@denx.de>
>>
>> Document the critical-action property to describe the thermal action
>> the OS should perform after the critical temperature is reached.
> 
> Are you happy with the v10 series?

Yes, I think they are fine except one thing.

The include/linux/reboot.h is changed along with thermal*.c file. IMO it 
is preferable to have separate patch, I mean all reboot.h changes folded 
in a single patch before the thermal_*.c changes. It is actually 
orphaned and we should ask Matti Vaittinen <mazziesaccount@gmail.com> 
its acked-by as he is the author of the code you are changing. 
Otherwise, he will have to ack the patches which contain also thermal 
code which is not its area.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

