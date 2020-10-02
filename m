Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39B0281936
	for <lists+linux-pm@lfdr.de>; Fri,  2 Oct 2020 19:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388132AbgJBR1y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Oct 2020 13:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgJBR1x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2020 13:27:53 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFE7C0613E2
        for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2020 10:27:53 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q1so1951353ilt.6
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2020 10:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uhP79kZciUU4dVo6hvpfLle6d5MaeIfDR+3Npq0TkNo=;
        b=TAqoowxnvS/2fOkInBCExTNrhFd5nD+Liycnhwa/M3NNLKdcdHW/Qqqz2qXZr53ROR
         ttwqki4//wqATBVHRlsGOcur+nhBEyQEFxZdgOhA9NOChTsDORDQzR1Q40romHycStrN
         cSkig9d+6ySrm+ZKwU8/pg/6hlDE+2yVOgti4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uhP79kZciUU4dVo6hvpfLle6d5MaeIfDR+3Npq0TkNo=;
        b=nTJud8/P/mwC3L2G9ACVLUmwXqD3W7FGWVqS4UgU3VnV1vY1q/P4zrbf0LHHFicJ+V
         QjFEqCvZA2iAootv7AF5mydpFWKAOAVpUn8REoItxHRq0gZwhOnR7/NrFurc6ELyi9eS
         jzz4yp60LVqCKqaUeUiypwg4CWX2W1SqAaMlExh2d3w+Z/Fk9IqKnMXuDAM0hl4/T1+I
         K/DuCyjuU9ejf5W72uix93cTGEyGe8MPgfx90KZJ1FrWHpR7LLW+IOVNpbYOu/tNBrgW
         l8h59f+SoYcu5ZfNsdc2KcD91Uqkdfy4W2DLGUPWXs9svyjwa8S0gK1EkHyU5GDuE7ir
         CI3w==
X-Gm-Message-State: AOAM532+mRElV6hCbXvDN5ypKEM2oFbVXb5YOj+cWl1kUs8luIpvBoHW
        CMeYAYnOz23djZAWoP5pcvEjRQ==
X-Google-Smtp-Source: ABdhPJw5Rb/qdckezT85qY4GYNBl1+UP/H2HCCr1I0GbqpqMl2E6BQLz0xcxSpI3DzRKcNqGaPGr6w==
X-Received: by 2002:a92:950d:: with SMTP id y13mr2686126ilh.42.1601659672856;
        Fri, 02 Oct 2020 10:27:52 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h2sm982660ioj.5.2020.10.02.10.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 10:27:52 -0700 (PDT)
Subject: Re: [PATCH v2] cpupower: Provide online and offline CPU information
To:     Brahadambal Srinivasan <latha@linux.vnet.ibm.com>,
        shuah@kernel.org, trenn@suse.com
Cc:     Janakarajan.Natarajan@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Pavithra R . Prakash" <pavrampu@in.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200929131108.19435-1-latha@linux.vnet.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6694193a-f44e-1239-26c2-7e01650964fc@linuxfoundation.org>
Date:   Fri, 2 Oct 2020 11:27:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929131108.19435-1-latha@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/29/20 7:11 AM, Brahadambal Srinivasan wrote:
> When a user tries to modify cpuidle or cpufreq properties on offline
> CPUs, the tool returns success (exit status 0) but also does not provide
> any warning message regarding offline cpus that may have been specified
> but left unchanged. In case of all or a few CPUs being offline, it can be
> difficult to keep track of which CPUs didn't get the new frequency or idle
> state set. Silent failures are difficult to keep track of when there are a
> huge number of CPUs on which the action is performed.
> 
> This patch adds helper functions to find both online and offline CPUs and
> print them out accordingly.
> 
> We use these helper functions in cpuidle-set and cpufreq-set to print an
> additional message if the user attempts to modify offline cpus.
> 
> Reported-by: Pavithra R. Prakash <pavrampu@in.ibm.com>
> Signed-off-by: Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
> ---
>   tools/power/cpupower/utils/cpufreq-set.c     |  3 +
>   tools/power/cpupower/utils/cpuidle-set.c     |  4 ++
>   tools/power/cpupower/utils/cpupower.c        |  8 +++
>   tools/power/cpupower/utils/helpers/helpers.h | 12 ++++
>   tools/power/cpupower/utils/helpers/misc.c    | 66 +++++++++++++++++++-
>   5 files changed, 92 insertions(+), 1 deletion(-)
> 

Please elaborate the changes made since v1.

I am seeing compile warnings. Please fix and send v3.

utils/cpufreq-set.c: In function ‘cmd_freq_set’:
utils/cpufreq-set.c:332:2: warning: implicit declaration of function 
‘print_offline_cpus’ [-Wimplicit-function-declaration]
   332 |  print_offline_cpus();
       |  ^~~~~~~~~~~~~~~~~~
   CC       utils/cpupower-set.o
   CC       utils/cpupower-info.o
   CC       utils/cpuidle-info.o
   CC       utils/cpuidle-set.o
utils/cpuidle-set.c: In function ‘cmd_idle_set’:
utils/cpuidle-set.c:187:2: warning: implicit declaration of function 
‘print_offline_cpus’ [-Wimplicit-function-declaration]
   187 |  print_offline_cpus();

thanks,
-- Shuah
