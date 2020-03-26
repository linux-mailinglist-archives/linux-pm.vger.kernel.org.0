Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB840194759
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 20:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgCZTUf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 15:20:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34875 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgCZTUf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 15:20:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id m3so8529983wmi.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2020 12:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/LjktucKOtEzJeoqvNIwT3sZZ9bStBvKLooZz8hSISs=;
        b=EXOQiP4iB3qtBnMmWBe+++9F3WdJx1mPHne8OTXLbC0Y5fINESoFIpJC/jgFhSIRPb
         7SBRnKkKjIsFzd2fWGhd24mnp5gc64li2S2sKsAj4O3tarV7D2WberUEk1+bRLmN51+4
         3T/njpiQeDs7iTJBinGl1eDl1pK2qki6mw+3FsF4eHnErA8MFzXkjPR5cV6IF0lu2Ps9
         pnXPJi2GJwreeWoLnrD3XGDFJmqTAv/rHjdOl6VXrrDNEn6r3ya4wh/izHpWFOyVGLh+
         IAWNp2e8gKS/3K8ZgomWCh52SCeXTQnVnvN92ItyG9R/nBoZJKcOhMkJX83DikicvmeT
         UTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/LjktucKOtEzJeoqvNIwT3sZZ9bStBvKLooZz8hSISs=;
        b=Mqd15jPWK2kcLrOU/DSbF9y81UhErO1G9CJxafOEX8a3XJno2Q69coWy5c91qc/5zC
         a98T4dP6oD3udV8E/boi15dDlTwUkRyXI5z8NVF4CR7nTFom8W71pkaFdE2UBnSG6tMK
         hymaVVVjYgP9Ak3adDgSyxcSshdf0Y1TpzINLvHkN9hvEA7K8/QIu6iYCcnsvZd07hXg
         0prjhQL/0feSss8Jafv/t60o8w+ZVOzblTA7IMlZ/h3W1jwLe1Vop9e0j9OJmnSb1GNS
         zSsB1K9Qegczc6VXKPvp4m63A/3geZsmlPKO7VmSvnebSLFPRKsQBN2GzdJCOV3sDZmv
         o5xg==
X-Gm-Message-State: ANhLgQ22hNVM/oQeiQAgvYL7KPjHYrc5URhHA13hT/MPKJ6OcVSYErXj
        eW1x9dFBXc/HmIJgfMnLFpL7jMidsOs=
X-Google-Smtp-Source: ADFU+vs5bqWDnTpUkTut9KiQOl53OpXdwMAAMaIhACHwcV51kqNkbhpq/G8V3sdOQ4ix3vuO0OEX6Q==
X-Received: by 2002:a05:600c:4145:: with SMTP id h5mr1452931wmm.3.1585250433021;
        Thu, 26 Mar 2020 12:20:33 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d702:b4a5:b331:1282? ([2a01:e34:ed2f:f020:d702:b4a5:b331:1282])
        by smtp.googlemail.com with ESMTPSA id w11sm5131836wrv.86.2020.03.26.12.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 12:20:32 -0700 (PDT)
Subject: Re: [PATCH] powercap/drivers/idle_inject: Specify idle state max
 latency
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200326144630.15011-1-daniel.lezcano@linaro.org>
 <CAJZ5v0iDuv0doOzFd140A17fhLKsdgZXbc_XMOuhUeDt70Jz+g@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bb21941a-69ff-36fe-05dd-8f3eb63326dc@linaro.org>
Date:   Thu, 26 Mar 2020 20:20:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iDuv0doOzFd140A17fhLKsdgZXbc_XMOuhUeDt70Jz+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/03/2020 20:14, Rafael J. Wysocki wrote:
> On Thu, Mar 26, 2020 at 3:48 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> Currently the idle injection framework uses the play_idle()
>> function which puts the current CPU in an idle state. The idle
>> state is the deepest one, as specified by the latency constraint
>> when calling the subsequent play_idle_precise() function with the
>> INT_MAX.
>>
>> The idle_injection is used by the cpuidle_cooling device which
>> computes the idle / run duration to mitigate the temperature by
>> injecting idle cycles. The cooling device has no control on the
>> depth of the idle state.
>>
>> Allow finer control of the idle injection mechanism by allowing
>> to specify the latency for the idle state. Thus the cooling
>> device has the ability to have a guarantee on the exit latency of
>> the idle states it is injecting.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org> ---
>> drivers/powercap/idle_inject.c | 27 ++++++++++++++++++++++++++-
>> include/linux/idle_inject.h    |  6 ++++++ 2 files changed, 32
>> insertions(+), 1 deletion(-)

[ ... ]

>> + +void idle_inject_set_latency(struct idle_inject_device
>> *ii_dev, +                            unsigned int latency_ns);
>> + +unsigned int idle_inject_get_latency(struct idle_inject_device
>> *ii_dev); + #endif /* __IDLE_INJECT_H__ */ --
>
> I would like to see a user of idle_inject_get_latency() before this
> goes in.

Do you mean a user for the set/get or the get only? If the latter,
there is no user yet I just added it to have an usual get/set helpers,
if that hurts, I can resend by removing it. If the former, there is a
patch I'm about to send which depends on the 'set'.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
