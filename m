Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55F8534046
	for <lists+linux-pm@lfdr.de>; Wed, 25 May 2022 17:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245000AbiEYPTn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 May 2022 11:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbiEYPTm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 May 2022 11:19:42 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A44DB0A6D
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2022 08:19:41 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id f4so21710112iov.2
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2022 08:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=veK8CNlACACGckQnA58+yIukb+Kk/ZhuNFtCylx0sWE=;
        b=QfLT9UTMnadNtFhkcygEPXxRpVzagooKGAz46mBUgBX47qWTLlDYdYYErRJf090W5z
         HweIp4nOhaE21p480b+8Uu1JuSSuyM2Si4KQU7Wf1toOVZo8pcl4L8o1Tro2FRRCypxw
         olwamMw3m120J2IjBMzdkZi8a9DYnj4POk7sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=veK8CNlACACGckQnA58+yIukb+Kk/ZhuNFtCylx0sWE=;
        b=jsWMWnuqZE2cYXtcjEphWYqjFr51fiC2qklDTIEC26wyVAMnrt35T2UOkgUXA2c+ku
         BCc8M2bb+PlOaemK4o1+Wz6QUq8DUyYqyABuSQaN9Z6zkafV2S/BU5QcHerQXbm1ZBgD
         P8pwFItxhtWFIiu/zkkRfLJptiuCCSe63pH7mTv5x4/0WGZhMw8j4IcZKAuug/nsgQJ8
         yeRg/fff3AKKVXeqt6fEAZW4ImeaKsfm/W8j+hwHY/scaT2GHR1cmYIVA3aTIvpVQGkk
         +Sdl5nDpW7GRBwLxQ0ITz15vnwkFrdA+QpignSeTnRrw7OuQJIVU9D8sL3T2IWrEqlwG
         TecQ==
X-Gm-Message-State: AOAM531mlRSLUP1hzwGTpXooIj1o4tdMd+Z892RaKg/2hoTwdrVffPU1
        BvPOQNyJPBunSZPIZ4p/fnErpQ==
X-Google-Smtp-Source: ABdhPJyV3LqOu6RlqHnaYxGMBNPgT0wQcKmAJNlUXGMCYKaWS5PAd092OryCHPFAPckBKFQL1SsV6w==
X-Received: by 2002:a5e:d614:0:b0:65e:42c8:c51b with SMTP id w20-20020a5ed614000000b0065e42c8c51bmr14603152iom.78.1653491980660;
        Wed, 25 May 2022 08:19:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 1-20020a921301000000b002cde6e35302sm5396250ilt.76.2022.05.25.08.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 08:19:40 -0700 (PDT)
Subject: Re: [PATCH V7 1/4] cpufreq: amd-pstate: Expose struct amd_cpudata
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
References: <20220522115423.1147282-1-li.meng@amd.com>
 <20220522115423.1147282-2-li.meng@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b847b0c2-6e6a-41a9-7d1b-35a14cb9dddd@linuxfoundation.org>
Date:   Wed, 25 May 2022 09:19:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220522115423.1147282-2-li.meng@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/22/22 5:54 AM, Meng Li wrote:
> Expose struct amd_cpudata to AMD P-State unit test module.
> 
> This data struct will be used on the following AMD P-State unit test
> (amd-pstate-ut) module. The amd-pstate-ut module can get some
> AMD infomations by this data struct. For example: highest perf,
> nominal perf, boost supported etc.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> ---
>   MAINTAINERS                  |  1 +
>   drivers/cpufreq/amd-pstate.c | 60 +---------------------------
>   include/linux/amd-pstate.h   | 77 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 79 insertions(+), 59 deletions(-)
>   create mode 100644 include/linux/amd-pstate.h
> 

Looks good to me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
