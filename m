Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43A36FC810
	for <lists+linux-pm@lfdr.de>; Tue,  9 May 2023 15:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbjEINgy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 May 2023 09:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbjEINgl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2023 09:36:41 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67C540EB
        for <linux-pm@vger.kernel.org>; Tue,  9 May 2023 06:36:28 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50be17a1eceso11407071a12.2
        for <linux-pm@vger.kernel.org>; Tue, 09 May 2023 06:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683639387; x=1686231387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Evw3dga/gibF8fahaEbss4hLAv5P7a4VbeIJ10I46g=;
        b=Q0Qoy1vBCCsWx6o+vkPqODTIV56XOnrE59tHx9WVlys/i5+sT4W1km3Ntl+Kbc0KmO
         3yazx3SSkEfjWO2aGT2lOtsFovH3xeEtahsLF243M9tMu8bwKP3cl0HyjS5mFMUPvtB3
         RQHsv2+2dm8Kg8tPrcFZMEBSsgxvhG05dv8HLhuYNKWsjFY3PQyk2gsv3xWZt5YBrfBF
         QaXj73+x9Vj8TSRXl6DfmiUPz9hwY0y/zJU/ow1cFv2MCTEf+lydErepJdTcK77l69dB
         OloaDwWsYPp3pndPk4hFCW2sC3rwBEkALgH6uaXfgsRTD7vtW3pzZa4XEr8BLnBJQbOE
         ywDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683639387; x=1686231387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Evw3dga/gibF8fahaEbss4hLAv5P7a4VbeIJ10I46g=;
        b=LCgkstEbjtc84thSrk/Nrsa/y8f01MsxFIxu68chr/WIkERcJ6RwpJZVfkmS9DFINN
         E9I6rL4Edey/q/wKn5nka4eNbZ5X68QKHaoddKdWqyxkclXCc7F6daq07iwzLdTHXzUC
         hUKkYG+N36z2w+T05teU6bbxmalpC7e5m7mW3bvqwJXunD7JkqEF1ZAOfrXgG//dcaoY
         w+u95OIy9VRbcOMiYwDV0k1CS91VJv88IGHM38S2G7I8r6Oe286hkarnUY8tPei7d+ld
         O7Oi+mmqYpdwOqKoTMz0wHKae863Q6FLF4civJK/R70fn9zgKx9bycS7TNIFz119+cE1
         4rNA==
X-Gm-Message-State: AC+VfDzCUVBLbVi5tRthEg4KbLQLIyWACpuZSYO890ViEZWaOHYQud4p
        /1aGIoeqJNVx16R7sUbIZWUJgg==
X-Google-Smtp-Source: ACHHUZ5ocRej8tN17PvDMcuohKR0erlUrhCW9YWL8mvxWP4AsTF2z21jRWrUuTq+RGaUsNjFBDWwEg==
X-Received: by 2002:aa7:c3d8:0:b0:50b:d75d:5dca with SMTP id l24-20020aa7c3d8000000b0050bd75d5dcamr10643780edr.42.1683639387446;
        Tue, 09 May 2023 06:36:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id u11-20020a50eacb000000b0050bc7c882bfsm767121edp.65.2023.05.09.06.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 06:36:26 -0700 (PDT)
Message-ID: <0815c0b5-304b-568f-5a64-d19d7d2aeb93@linaro.org>
Date:   Tue, 9 May 2023 15:36:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v7 1/8] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org, helgaas@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com, kw@linux.com,
        bhelgaas@google.com, vidyas@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
References: <20230424131337.20151-1-sumitg@nvidia.com>
 <20230424131337.20151-2-sumitg@nvidia.com>
 <7c6c6584-204a-ada1-d669-2e8bef50e5e5@linaro.org>
 <3071273b-b03b-5fc8-ffa1-9b18311a3a5d@nvidia.com>
 <5ab9687e-756d-f94b-b085-931d4ea534c1@nvidia.com>
 <10b32e55-4d28-5405-035e-c73a514c95e4@linaro.org>
 <14438cf9-ec78-afb5-107a-4ed954ac0eb7@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <14438cf9-ec78-afb5-107a-4ed954ac0eb7@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/05/2023 15:17, Sumit Gupta wrote:
>>>>>> +                     /*
>>>>>> +                      * MC driver probe can't get BPMP reference as
>>>>>> it gets probed
>>>>>> +                      * earlier than BPMP. So, save the BPMP ref got
>>>>>> from the EMC
>>>>>> +                      * DT node in the mc->bpmp and use it in MC's
>>>>>> icc_set hook.
>>>>>> +                      */
>>>>>> +                     mc->bpmp = emc->bpmp;
>>>>>
>>>>> This (and ()) are called without any locking. You register first the
>>>>> interconnect, so set() callback can be used, right? Then set() could be
>>>>> called anytime between tegra_emc_interconnect_init() and assignment
>>>>> above. How do you synchronize these?
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>>
>>>> Currently, the tegra234_mc_icc_set() has NULL check. So, it will give
>>>> this error.
>>>>    if (!mc->bpmp) {
>>
>> How does it solve concurrent accesses and re-ordering of instructions by
>> compiler or CPU?
>>
> 
> Now, the "mc->bpmp" is set before tegra_emc_interconnect_init().
> So, until the EMC interconnect initializes, set() won't be
> called as the devm_of_icc_get() call will fail.

What if compiler puts "mc->bpmp" assignment after
tegra_emc_interconnect_init()?

What if CPU executes above assignment also after
tegra_emc_interconnect_init()?

Considering amount of code inside tegra_emc_interconnect_init() second
case is rather unlikely, but first possible, right?

Best regards,
Krzysztof

