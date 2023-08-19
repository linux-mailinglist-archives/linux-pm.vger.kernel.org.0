Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98714781825
	for <lists+linux-pm@lfdr.de>; Sat, 19 Aug 2023 09:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344536AbjHSHyV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Aug 2023 03:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344505AbjHSHxu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 19 Aug 2023 03:53:50 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88CD3C06
        for <linux-pm@vger.kernel.org>; Sat, 19 Aug 2023 00:53:47 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9a2033978so26036331fa.0
        for <linux-pm@vger.kernel.org>; Sat, 19 Aug 2023 00:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692431626; x=1693036426;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4pXGd50QS4NhntuldSaEKZY1dWgEwQEkHWL/LnltV2k=;
        b=G37Z+JIuW+ZIy6lQ86mLGfC+7dfURD6nBWdGQ7d7dwSNXxLGXFYf9L0q68Hk2tUJVw
         i5rrlT+xmCMci1EyDCpxkbY4DMGXl7ueagtN3wZ0NiOqDZU6Ra3AGOfPAc/1S4gV+Zls
         U3wXVgE0BH3imk0WgfvzyJu473aaxnP/yDCq2CQHq2yRVqvgjTw/FPPzAHEz5IUYVEIO
         VVCZebACKfEgoguZzAIF1ccegEE7W3KAsbRA4CgdfUudMfsP+yH01YJ9rggIs+KNyQcI
         Wtp/uloNOusvQ+F7W01mDuKENUzDMqw4q8pe/ET9c+tXMnbjPmsfXT45fL342jvxUmH4
         t1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692431626; x=1693036426;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4pXGd50QS4NhntuldSaEKZY1dWgEwQEkHWL/LnltV2k=;
        b=DyHUKMe9ygj19L2Hj27rdr9LptuL5raZB8yOKUGjT8ZbSR7VgXJJlboyrsflURcRlG
         /KoFbUIGi9sN1Eo5OVzlmz0YW+gbcgGxLvKm7WsdtXFBhasCoX4xCI4A3iT/ck+8L4/z
         ybtRThK1d4Y7omRdNVlHvq6wPeoxgV5I9XCVeCpYjY9tiXgnxVIEkAFrq/OjZRKw+MLb
         zAqJ3D0pC7oSiKCV/YVIKYD3PBR4vneaU2n+YKjc7NAWkTKWvJQ8A54LaeQLtX5jR4vb
         QKcEw2hLXzeqEV9mOt/174zEf0P5lodkALT20iSSqGO3nSatLbori+J/0j5oK7+mUXdm
         nJCw==
X-Gm-Message-State: AOJu0YwynXG9nT3PORdOgbpYnJ2msHWEbIZEup+89ZiXSpf26fNyiNOI
        LDs75xY/8thJ18Vrg7K8goktxA==
X-Google-Smtp-Source: AGHT+IEw8pMqEZB8rNtxqDrqr24o9F2PuqslrZMx0sM0n63duTUAkpDaJX/IL/c0f1kXuTlW5MnyEw==
X-Received: by 2002:ac2:5bde:0:b0:4fe:63cf:6048 with SMTP id u30-20020ac25bde000000b004fe63cf6048mr745210lfn.43.1692431626061;
        Sat, 19 Aug 2023 00:53:46 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id l7-20020a17090615c700b00999bb1e01dfsm2240704ejd.52.2023.08.19.00.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 00:53:45 -0700 (PDT)
Message-ID: <af1eca37-9fd2-1e83-ab27-ebb51480904b@linaro.org>
Date:   Sat, 19 Aug 2023 09:53:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 0/1] Add add-maintainer.py script
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <cover.1691049436.git.quic_gurus@quicinc.com>
 <20230810185526.GC31860@quicinc.com>
 <4d94d0fd-72d4-0196-3a30-3e1efb9f5aca@linaro.org>
 <20230816171538.GB26279@quicinc.com>
 <6fb1176f-90f1-7a65-3ab5-f6447418c51e@linaro.org>
 <20230819013303.GA22393@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230819013303.GA22393@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/08/2023 03:33, Guru Das Srinagesh wrote:
> On Aug 18 2023 10:43, Krzysztof Kozlowski wrote:
>>>> For newcomers, OTOH, I would either recommend simple workflow or just
>>>> use b4. Why? Because if you cannot use git-send-email, then it means
>>>> your email setup will make your life difficult and adding maintainers to
>>>> existing patch won't help you.
>>>
>>> You've mentioned a "simple workflow" many times - could you please share more
>>> details on the steps you follow in your workflow for sending patches?
>>
>> I shared it on LKML few times already (and Rob's git send-email identity
>> is also on LKML), so one more time:
>>
>> https://github.com/krzk/tools/blob/master/linux/.bash_aliases_linux#L91
> 
> Thank you for sharing this - it is really neat indeed and you certainly don't
> need a step #2 with this method.
> 
> However, I see areas for improvement in the alias:
> - Subsystem-specific mailing lists, maintainers, reviewers, and other roles are
>   all marked as "To: " sans distinction via the alias whereas
>   `add-maintainer.py` and `b4` both provide marking of lists as "Cc: " which
>   seems aesthetically and semantically more pleasing.

To or Cc does not matter.

> - Only `add-maintainer.py` allows for maintainers to be selectively in "To: "
>   and "Cc: " for patches in a series depending on whether they are the
>   maintainers for that particular patch or not.

It's intentional to CC everyone. If I wanted to Cc/To
maintainer-per-patch, I would use Rob's send-email identity.

> 
>>>> This tool depends on the command line and shell interface of
>>>> scripts/get_maintainers.pl which is another reason why it might not be a
>>>> good idea.
>>>
>>> Could you please elaborate on why depending on the output of
>>> `get_maintainer.pl` is a bad idea? It's what everyone uses, no?
>>
>> No, because if interface changes you need to update two tools.
> 
> But `b4 prep --auto-to-cc` also uses `get_maintainer.pl`!

Yep, and it's Konstantin's headache to keep it updated. :)

> 
> Also, in your previous email you said to "just use b4", which also depends on
> the command line and shell interface of `get_maintainers.pl`. Depending on
> `get_maintainer.pl` is therefore perfectly okay - there is no need to reinvent
> it or disregard it for whatever reasons.

True, it is okay, but adding more tools to depend on it is more work. b4
is awesome tool, thus I feel it is justified to depend on that
interface. I don't see the need for more tools doing exactly the same.

Best regards,
Krzysztof

