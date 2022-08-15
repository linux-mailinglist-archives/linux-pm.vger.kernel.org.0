Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C017B594EB5
	for <lists+linux-pm@lfdr.de>; Tue, 16 Aug 2022 04:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiHPCgc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Aug 2022 22:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbiHPCgO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Aug 2022 22:36:14 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F3713A501
        for <linux-pm@vger.kernel.org>; Mon, 15 Aug 2022 15:54:19 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id a13so1001369ild.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Aug 2022 15:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=hkKYpQpZVod/c+R4dm3Iger6VJ5VMkCGceQbJFeIRCM=;
        b=AVYFSbBPXaQ55T7CZh6eJ8m+JoJg3uN+n2PSMuVdalLhI98HWk7vsoK0M+nRWYn58h
         aBV4+fBu7w0uvPduhOuiUfSC6rYd51NoL9aX9rFvcAnAPzR/7ySJ2X6EGPigJH+gDab+
         4GFBsr3PSIW1QXlN+z9G3P5rHxjxSUkXX7SbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=hkKYpQpZVod/c+R4dm3Iger6VJ5VMkCGceQbJFeIRCM=;
        b=GkIujf0p2JkcGUA6DAZNjuGOuBc3gwR8bbHWFzVhRW+5ZT7C+J6DuiwsR2G+pdwfEZ
         R8PYms7ZVUXuy30WochSJ0TQaHVt/LCggHroi5FIWeRhDGkYhs697++pNL2c05T0iW6G
         lTK58oMuPjDBziOHy4WIt2dWXZTzzncBksZmcSE1ACQfqFSdDsuQNQXSZyIct2YXGo1k
         G15qfHRl6XTN+TMpuLA7tRrRz6HDC/FTPdsQrO4VG3BJQBHrWA4hM9YT3ln81+OvdKob
         J/vQM9qvZgZ4oaQcYkX5HApiDSNkz4UPllF+E4xzdPxoEj3kaXSvSYooFuT2b05C9ROK
         YAQw==
X-Gm-Message-State: ACgBeo0acYTWbqVxHvThkonbMKk6x7nJ5kWfmyhSO+MV2eIo0ONyDF86
        juKSKN8OSjaS8gRpLDwIyUR0FA==
X-Google-Smtp-Source: AA6agR5ijmhL69tH7zLQ8VChNV3+aCH4BruXktH5EL+HQ94HvKvtKe/2ZTHCpyWCN4+AUO8MyifpWg==
X-Received: by 2002:a92:c24d:0:b0:2e6:7ab0:6477 with SMTP id k13-20020a92c24d000000b002e67ab06477mr138632ilo.229.1660604058711;
        Mon, 15 Aug 2022 15:54:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y18-20020a92d812000000b002e6189eb930sm213479ilm.75.2022.08.15.15.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 15:54:18 -0700 (PDT)
Subject: Re: [PATCH V8 0/4] Add unit test module for AMD P-State driver
To:     Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220526034725.1708916-1-li.meng@amd.com>
 <fbd6bc2f-b6d7-497e-410c-4a82876075ff@linuxfoundation.org>
 <5792136d-079e-6e1e-0bf5-aed1b3db6566@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f6668bdd-4d2a-ff36-7e62-323d6691a188@linuxfoundation.org>
Date:   Mon, 15 Aug 2022 16:54:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <5792136d-079e-6e1e-0bf5-aed1b3db6566@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/9/22 2:28 PM, Shuah Khan wrote:
> On 5/26/22 9:44 AM, Shuah Khan wrote:
>> On 5/25/22 9:47 PM, Meng Li wrote:
>>> Hi all:
>>>
>>> AMD P-State unit test(amd-pstate-ut) is a kernel module for testing
>>> the functions of amd-pstate driver.
>>> It could import as a module to launch some test tasks.
>>> 1) It can help all users to verify their processor support (SBIOS/
>>> Firmware or Hardware).
>>> 2) Kernel can have a basic function test to avoid the kernel regression
>>> during the update.
>>> 3) We can introduce more functional or performance tests to align the
>>> together, it will benefit power and performance scale optimization.
>>>
>>> We upstream out AMD P-state driver into Linux kernel and use this unit
>>> test module to verify the required conditions and basic functions of
>>> amd-pstate before integration test.
>>>
>>> We use test module in the kselftest frameworks to implement it.
>>> We create amd-pstate-ut module and tie it into kselftest.
>>>
>>> For example: The test case aput_acpi_cpc is used to check whether the
>>> _CPC object is exist in SBIOS.
>>> The amd-pstate initialization will fail if the _CPC in ACPI SBIOS is not
>>> existed at the detected processor, so it is a necessary condition.
>>>
>>> At present, it only implements the basic framework and some simple test
>>> cases.
>>>
>>> TODO : 1) we will add more test cases to improve the depth and coverage of
>>> the test. E.X. use the script to trigger the tbench, gitsource, kernbench,
>>> netperf, speedometer, and etc. testing and monitor the cpu frequency and
>>> performance goals change, power consumption at runtime.
>>>
>>> Please check the documentation amd-pstate.rst for details of the test steps.
>>>
>>> See patch series in below git repo:
>>> V1: https://lore.kernel.org/linux-pm/20220323071502.2674156-1-li.meng@amd.com/
>>> V2: https://lore.kernel.org/lkml/20220413090510.4039589-1-li.meng@amd.com/
>>> V3: https://lore.kernel.org/lkml/20220421074152.599419-1-li.meng@amd.com/
>>> V4: https://lore.kernel.org/lkml/20220427135315.3447550-1-li.meng@amd.com/
>>> V5: https://lore.kernel.org/lkml/20220505022913.329259-1-li.meng@amd.com/
>>> V6: https://lore.kernel.org/lkml/20220519134737.359290-1-li.meng@amd.com/
>>> V7: https://lore.kernel.org/lkml/20220522115423.1147282-1-li.meng@amd.com/
>>>
>>
>>>
>>> Changes from V7 -> V8:
>>> - cpufreq: amd-pstate:
>>> - - amend commit message.
>>> - - amend module description.
>>> - Documentation: amd-pstate:
>>> - - amend commit message.
>>> - - Remove the personal data.
>>>
>>
>> Looks good to me. Thank you.
>>
>> Rafael, Viresh,
>>
>> How do you want to handle this patch series? We are in merge window
>> and this would be for Linux 5.20 based on the changes and content.
>>
>> Would you like to take the entire patch series through your tree, you
>> have my Ack(s) and Reviewed-by(s)
>>
> 
> Picking this back up since rc1 is out. How do we want to handle this patch
> series?
> 

Please send me rebased version. I will apply it for the net release.

thanks,
-- Shuah
