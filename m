Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1A44C074C
	for <lists+linux-pm@lfdr.de>; Wed, 23 Feb 2022 02:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbiBWBo6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Feb 2022 20:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbiBWBor (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Feb 2022 20:44:47 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A79250B30
        for <linux-pm@vger.kernel.org>; Tue, 22 Feb 2022 17:44:11 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id t11so16861165ioi.7
        for <linux-pm@vger.kernel.org>; Tue, 22 Feb 2022 17:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7cLXIA7kCsT35AsaZrNb01D5uIgSrPIPE8REvI2l0I0=;
        b=OYkoXJtMcmG8d1V2+UoOUjy9YSVfMChfH8C9Zhfix/S0ui9YYJffwZXmQK3MK3OV5A
         SaCg/6FENJLAZWpiricYkc6jIbTQrlwcBEj7NDI9isnZwa450M7xDaKTmz4eWM9SXys8
         8vUCF8W04jbwr3J/zC9c6uF6YmzlZ8voS2li4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7cLXIA7kCsT35AsaZrNb01D5uIgSrPIPE8REvI2l0I0=;
        b=VNLpKVcYIG3V6SXhkFbgB5TFfMDb9aeZXY0h+ByEQUbNLyfC1x6t3SJXeHueU84HdQ
         TAh7wxE7VOmDL/COxGI5tDg9OmUwF8c2YVPTlseW6aDj59AbrGCA7A9Q5NVbQFguaoiw
         dacGmqffGKHX2e75NHiWCJf+jXDM/vMmblbW0vBgmAvr4uXL8isj/wc03BbNLQ4qC3pQ
         eBEouja7p5YNlNeoF0Uf28N9zuWztMu8EhCmaiMneVJEuUM7tqaKEf4sqhhVSy+rQdqw
         u7K6pyjduFyj03QK8rsM8kmC8BfNmX8pcAp+0RpOC/Z0r5hgl2cNSfn5ZLcW5q+obxHM
         uFRQ==
X-Gm-Message-State: AOAM531mwEJR8tUlqOI+9ZZGLkdNa/VmihTy6HYiJctUBXvpRebkpxWS
        3BeJJ5tzFE5MEmuxIn6qbbu3AA==
X-Google-Smtp-Source: ABdhPJyQv7q+dJ73knBmOIm5S8YLeSqSj9w+moPjh1AT8x4SNBx5LfCaIxftRbweqEN3R0J1CCe4Ig==
X-Received: by 2002:a02:a1d6:0:b0:314:af71:b38a with SMTP id o22-20020a02a1d6000000b00314af71b38amr17757891jah.95.1645580650085;
        Tue, 22 Feb 2022 17:44:10 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id n15sm3365942ilo.26.2022.02.22.17.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 17:44:09 -0800 (PST)
Subject: Re: [PATCH v7 00/10] cpupower: Add AMD P-State Support
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org
Cc:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Jassmine Meng <li.meng@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220222153426.2216974-1-ray.huang@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e435b61a-975b-5063-9eeb-5f09ab8186f3@linuxfoundation.org>
Date:   Tue, 22 Feb 2022 18:44:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220222153426.2216974-1-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/22/22 8:34 AM, Huang Rui wrote:
> Hi Shuah,
> 
> Since AMD P-State kernel is merged into 5.17-rc1, I would like to continue
> revising the AMD P-State support for the CPUPower tool. These series are
> rebased on latest bleeding-edge, any comments are warm for me.
> 
> See patch series of CPUPower in below git repo:
> V1: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v1
> V2: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v2
> V3: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v3
> V4: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v4
> V5: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v5
> V6: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=cpupower-amd-pstate
> V7: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=cpupower-amd-pstate-v7
> 

> 
> Changes from V6 -> V7:
> - Fix the checkpatch warnings and errors.
> - Revise the patch 9 to move the AMD P-State information prints out of
>    boost function.
> - Add a new option to print the performance and frequency capabilities of
>    CPPC, and add related description in manpage documentation.
> 
>

Thank you. Applied to  https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git
cpupower branch for Linux 5.18-rc1

thanks,
-- Shuah
