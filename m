Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A120470700B
	for <lists+linux-pm@lfdr.de>; Wed, 17 May 2023 19:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjEQRyH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 May 2023 13:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjEQRyC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 May 2023 13:54:02 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27744FA
        for <linux-pm@vger.kernel.org>; Wed, 17 May 2023 10:54:01 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-76c6ba5fafaso6631239f.1
        for <linux-pm@vger.kernel.org>; Wed, 17 May 2023 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1684346040; x=1686938040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fXutPRKbM379fHJ19Cv4c2+UOyKEPvzUNU2LTmwiWMI=;
        b=ZhHGP90TuO7Skdy9lDU2lyWONj8hFmkCQCOp1i8kQJr7YqLaIqXZu8YUGWRR7+1xhG
         lcTT9lWjZVq2ySX3CwS1AE3Z6S5pwfyKoz0hF9jvCEZDoUA3waRTQDCjr1x42gYmxXpn
         RBUhUDCPQJ7++NlzxQlREWuHcgyKA5O1VTojA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684346040; x=1686938040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXutPRKbM379fHJ19Cv4c2+UOyKEPvzUNU2LTmwiWMI=;
        b=IKdEIjaDJYE1yZApiskwkajMzCEe2qOda+2Im+3BpkBhp8XzjM8dHGjmVGa9y4KQgv
         P0cvag80J9mn7dlOJnHzYnexVPeN+La/NLvTPee/HEMPCFx/ZjpWh2Y2wLzWG+R3i7Lq
         Va8JWjcTkp4atKtILQyBbz5Rb5F+TuvYAEHVkmcWjD2Si+R+a+wSj8uRUwMUMsp/+Dlg
         cBspkrycys/7bCrmAg2uN2lQtTUijMPws1QmIHQ9r8/AH/ItWjewG+kuPVzeXjjPOz8V
         KV18Z3SvtnHg1RgKHcyJsiNltTYVVFIGf5jkHNixaisW/Sf+pjpQIInML74QRJ1FE108
         MboA==
X-Gm-Message-State: AC+VfDy990GlvbcKEP65YcupWxIm2dVqYnP1Px3+cwxptyDs0CiBPBhJ
        Cgr9IyQsYubGV9AVV5DjHlsIREO4tsUcAgDaxIU=
X-Google-Smtp-Source: ACHHUZ7fvq3D47jwbMZ+/dsHvmy9roBTV/V5dLdbY1Z2h4gXmGEKeZg6ijJS0hLynREdg8v3brwJAg==
X-Received: by 2002:a05:6e02:1b0d:b0:332:fcce:c26d with SMTP id i13-20020a056e021b0d00b00332fccec26dmr2651320ilv.0.1684346040428;
        Wed, 17 May 2023 10:54:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a17-20020a92d351000000b0032a8e1ba829sm3186981ilh.16.2023.05.17.10.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 10:53:59 -0700 (PDT)
Message-ID: <d56c18e8-863b-1131-64dd-c84aeab1e968@linuxfoundation.org>
Date:   Wed, 17 May 2023 11:53:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] cpupower: Bump soname version
Content-Language: en-US
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Thomas Renninger <trenn@suse.com>, linux-pm@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20160610005619.GQ7555@decadent.org.uk>
 <ZFqV3ZFROy0m+/Xt@eldamar.lan>
 <eeca542a-eb7f-50a0-b62b-7bab8993185a@linuxfoundation.org>
 <ZF6aJTqMkrlBb0Mm@eldamar.lan>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZF6aJTqMkrlBb0Mm@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/12/23 13:57, Salvatore Bonaccorso wrote:
> Hi Shuah,
> 
> Apologies for the delay!
> 
> On Tue, May 09, 2023 at 04:10:05PM -0600, Shuah Khan wrote:
>> On 5/9/23 12:50, Salvatore Bonaccorso wrote:
>>> Hi Thomas,
>>>
>>> On Fri, Jun 10, 2016 at 01:56:20AM +0100, Ben Hutchings wrote:
>>>> Several functions in the libcpupower API are renamed or removed in
>>>> Linux 4.7.  This is an backward-incompatible ABI change, so the
>>>> library soname should change from libcpupower.so.0 to
>>>> libcpupower.so.1.
>>>>
>>>> Fixes: ac5a181d065d ("cpupower: Add cpuidle parts into library")
>>>> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>>>> ---
>>>> I have to say the choice of variable names here is rather confusing.
>>>> LIB_MIN is used for the soname version, which would normally be the
>>>> *major* part of the version.
>>>>
>>>> I'll send a second patch that switches to more conventional library
>>>> versioning.
>>>>
>>>> Ben.
>>>>
>>>>    tools/power/cpupower/Makefile | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
>>>> index 8358863259c5..0b85f5915ce8 100644
>>>> --- a/tools/power/cpupower/Makefile
>>>> +++ b/tools/power/cpupower/Makefile
>>>> @@ -64,7 +64,7 @@ DESTDIR ?=
>>>>    VERSION=			$(shell ./utils/version-gen.sh)
>>>>    LIB_MAJ=			0.0.1
>>>> -LIB_MIN=			0
>>>> +LIB_MIN=			1
>>>>    PACKAGE =			cpupower
>>>>    PACKAGE_BUGREPORT =		linux-pm@vger.kernel.org
>>>
>>> Repinging this patch. Thomas, we are shipping it in Debian since, and
>>> I'm wondering if the patch did just felt trough the cracks.
>>>
>>
>> Please resend the patch for review.
> 
> Here is the patch again for a fresh review on it. If you want me to
> send it standalone with '[RESEND PATCH]' I can do that as well.
> 

Yes please resend with RESEND tag. I won't be able to apply the patch
when it is included in the reply.

thanks,
-- Shuah

