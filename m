Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F60157B2A3
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jul 2022 10:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbiGTIQV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jul 2022 04:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiGTIQT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jul 2022 04:16:19 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A638550B3
        for <linux-pm@vger.kernel.org>; Wed, 20 Jul 2022 01:16:17 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z3so1939044plb.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Jul 2022 01:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=uYiZZ6ipbb2NI+48VeJC83llK7+Y+q8f+kaW8ZK56qQ=;
        b=GSOr7+oSOYZ/HHofdLRGWf7k+M9K2gU22l7qTUKTZaQEh8qUJj3v/Ej72xu80mI6lz
         spE4kQmyPcFETNdZ+H0CT+H2J4xPSpPYIYH4HmPX2HrmqKPs43O1wuYFEimeVENrU9L6
         jCsQtYl9Ra4BJwOD4k2M3DDYBARaRreeeYtXPyDZw+aAQso6eXcOcWdbSIuK+wRkSWDK
         hFveXJXq6uqt99HSbW4X9Ql7IT5LFcmKuTkoWCh31X1kqFCdOYpcrQBJEvDb1kdKaeD6
         aViBY/KiP8EtTgXstnGx9Urto+fqRmguifbhyONYbpJvCtqtaKaxGa4d26l+mGjX9IOG
         pDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uYiZZ6ipbb2NI+48VeJC83llK7+Y+q8f+kaW8ZK56qQ=;
        b=kb2BvJjuSQtgl6sbRd0+zPoPFGW+g0VJspSdnxIxn3W2O7YB6PaN62O820Jo6vvAw3
         ETxgvmHCZnZls4MWF5Nr1DgPlKf7mVoOPTvORRNy5yGA4U0/1o1OmecJGp4LJAHA1iIb
         m0CYymioB3agu4T6NOLJXBtJpw+eQbwWB/B+oQx4ywGSmq+LDN0O5l/02NJl7Zi+3maL
         J8bfGElAh8f913QofP1DTqAUsda3pmmtf/O1IOfgCgBgiQRYBMYLIEbWLGfaYQTTZ/+a
         KkBceuQikKJSFI9XQiPwXH9cseZb8AkbG1fq0xSm0QnurnFe41OqCGRjZAcg0L2oBFyO
         /RYA==
X-Gm-Message-State: AJIora8K5mJZPn5N+qdGDR0iM7eIsrh35i3GzoQCoSWIxWViEx5l+O++
        W0HcHATPvh0/RYlySxm8bBqNeA==
X-Google-Smtp-Source: AGRyM1uQvco9Cf0V2sKG+aFCbvjKaKE2vSku+wKQT4wBMmvJp5xjDkDd8ETcYz/zgb2jrhASk6/q5g==
X-Received: by 2002:a17:903:22cf:b0:16c:4145:75c5 with SMTP id y15-20020a17090322cf00b0016c414575c5mr37211144plg.127.1658304977031;
        Wed, 20 Jul 2022 01:16:17 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:709e:6fec:df37:6562:5a80? ([2401:4900:1f3b:709e:6fec:df37:6562:5a80])
        by smtp.gmail.com with ESMTPSA id u16-20020a170903125000b001690d398401sm13419432plh.88.2022.07.20.01.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 01:16:16 -0700 (PDT)
Message-ID: <507fec10-7ef8-e043-b4f6-70cd17b8334f@linaro.org>
Date:   Wed, 20 Jul 2022 13:46:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] thermal: qcom: tsens: Implement re-initialization
 workaround quirk
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org
References: <20220701145815.2037993-1-bhupesh.sharma@linaro.org>
 <20220701145815.2037993-4-bhupesh.sharma@linaro.org>
 <09ff7e3a-7dd5-db35-3795-89151afb5363@somainline.org>
 <e69cb444-2bee-870e-08ca-bbe3237d8166@linaro.org>
 <d5dd721e-b0d7-f76d-d40c-b4927c236460@somainline.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <d5dd721e-b0d7-f76d-d40c-b4927c236460@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/19/22 4:09 PM, Konrad Dybcio wrote:
> 
> 
> On 18.07.2022 08:34, bhupesh.sharma@linaro.org wrote:
>> Hi Konrad,
>>
>> On 7/15/22 8:26 PM, Konrad Dybcio <konrad.dybcio@somainline.org> wrote:
>>>
>>>
>>> On 1.07.2022 16:58, Bhupesh Sharma wrote:
>>>> Since for some QCoM tsens controllers, its suggested to
>>>> monitor the controller health periodically and in case an
>>>> issue is detected, to re-initialize the tsens controller
>>>> via trustzone, add the support for the same in the
>>>> qcom tsens driver.
>>>>
>>>> Note that Once the tsens controller is reset using scm call,
>>>> all SROT and TM region registers will enter the reset mode.
>>>>
>>>> While all the SROT registers will be re-programmed and
>>>> re-enabled in trustzone prior to the scm call exit, the TM
>>>> region registers will not re-initialized in trustzone and thus
>>>> need to be handled by the tsens driver.
>>>>
>>>> Cc: Amit Kucheria <amitk@kernel.org>
>>>> Cc: Thara Gopinath <thara.gopinath@gmail.com>
>>>> Cc: linux-pm@vger.kernel.org
>>>> Cc: linux-arm-msm@vger.kernel.org
>>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> ---
>>> Hi, I think this should be also checked and applied on init. This
>>> seems required for at least SM6375, as the controller starts (or
>>> well, doesn't start...) in an unknown state and the driver does
>>> not like it, as the TSENS_EN indicates it is disabled.
>>> Downstream runs this right at probe..
>>
>> Hmm.. very interesting. I was not aware of the SM6375 case, as for SM8150
>> the controller starts in a valid state but may require reinit during operation.
>>
>> So, I did not use the downstream approach to do it right at _probe() and then
>> later while get_temp() is called.
>>
>> Let me add that in v2. BTW do you want me to set the need_reinit_wa as true
>> for SM6375 as well, or would you like to add that with a followup-patch ?
> Please set it, I'll happily test it!

Thanks. Will share v2 shortly.

Regards,
Bhupesh

