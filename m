Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7303C534169
	for <lists+linux-pm@lfdr.de>; Wed, 25 May 2022 18:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240347AbiEYQVX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 May 2022 12:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiEYQVW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 May 2022 12:21:22 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0B17C162
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2022 09:21:19 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id n2-20020a9d6f02000000b0060b22af84d4so3430140otq.1
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2022 09:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ha7IXtvgklJj4qrv/kc8K+uqTPs5aQBvEZ0QJe/O9Zo=;
        b=bwf1fFxXehkfdyzmP75VPu5LsvG06tzsZQ8V1S1c8ociHtOAqpD+9/3j3yZKpaINZ5
         CTvTDmg6c2LsT5eMO9OQ7xTYHqAhsMAtS6fgujvKG64Wl14xwzEErmv7LCPJLsEHPw4+
         z3OZrVrjaegtVEQo8GdvZkgEd234SmBAX9RGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ha7IXtvgklJj4qrv/kc8K+uqTPs5aQBvEZ0QJe/O9Zo=;
        b=6pSFrB2RlzUneXkYoPzag5ym9+xm3yOqo4BrcLLId9ocGPqt3Nz2TvXzKSU0UtCIO9
         9qAHDZMad7LLjZGyGDKNywsDU9TcPyI1J7EPfDtkjMrNeUxYzY43AjFVvxMmYFsUrNXi
         TqmtBHdQaxXrLf+z5TSYFK0cDtn4maPoat088oPhTgW3s51gXlC5cnzCQP5GUJ9xFc1m
         yBC3jRIJLJHIM3kc9vnNUFr+kzYuSOvKJNV8HrzgLkMJSVtkfewiboXlCB8pyh0z91A+
         uxZ3whyVTTPNoevYCgQEOZJOdwbPrNTGWJZ1TLuz+jmc93CbZYIF6qu623EPVdcgDsRd
         0Y0A==
X-Gm-Message-State: AOAM5332z3k2Rh3ykTq9kB7uy7xZL+2dTd36xaZle/RyhEH5bm4DYP/O
        TAowaR3ei0BpsApKz4W3C7epYw==
X-Google-Smtp-Source: ABdhPJwd8ZBEJH4uLt0dqdzZMBiwAj3oa7FbaLvoxW0fDY4eKVrP6EVQL35ZjQYLOyj1rctC2k+ysQ==
X-Received: by 2002:a9d:6858:0:b0:606:e29a:b19c with SMTP id c24-20020a9d6858000000b00606e29ab19cmr12601930oto.65.1653495678855;
        Wed, 25 May 2022 09:21:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g6-20020a9d6c46000000b0060ae8586befsm6140047otq.53.2022.05.25.09.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 09:21:18 -0700 (PDT)
Subject: Re: [PATCH V7 4/4] Documentation: amd-pstate: Add unit test
 introduction
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
 <20220522115423.1147282-5-li.meng@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8c91add2-57dd-9f58-ccce-6f692e381bf3@linuxfoundation.org>
Date:   Wed, 25 May 2022 10:21:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220522115423.1147282-5-li.meng@amd.com>
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
> Introduce the AMD P-State unit test module design and implementation.

It also talks about kselftest and how to use - let's say that here.

> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 76 +++++++++++++++++++++
>   1 file changed, 76 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 83b58eb4ab4d..c2b8693601aa 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -182,6 +182,7 @@ to the ``struct sugov_cpu`` that the utilization update belongs to.
>   Then, ``amd-pstate`` updates the desired performance according to the CPU
>   scheduler assigned.
>   
> +.. _processor_support:
>   
>   Processor Support
>   =======================
> @@ -282,6 +283,8 @@ efficiency frequency management method on AMD processors.
>   Kernel Module Options for ``amd-pstate``
>   =========================================
>   
> +.. _shared_mem:
> +
>   ``shared_mem``
>   Use a module param (shared_mem) to enable related processors manually with
>   **amd_pstate.shared_mem=1**.
> @@ -393,6 +396,76 @@ about part of the output. ::
>    CPU_005     712          116384        39        49        166       0.7565  9645075 2214891 38431470  25.1   11.646       469         2.496         kworker/5:0-40
>    CPU_006     712          116408        39        49        166       0.6769  8950227 1839034 37192089  24.06  11.272       470         2.496         kworker/6:0-1264
>   
> +Unit Tests for amd-pstate
> +-------------------------
> +
> +``amd-pstate-ut`` is a test module for testing the ``amd-pstate`` driver.
> +
> + * It can help all users to verify their processor support (SBIOS/Firmware or Hardware).
> +
> + * Kernel can have a basic function test to avoid the kernel regression during the update.
> +
> + * We can introduce more functional or performance tests to align the result together, it will benefit power and performance scale optimization.
> +
> +1. Test case decriptions
> +
> +        +---------+--------------------------------+------------------------------------------------------------------------------------+
> +        | Index   | Functions                      | Description                                                                        |
> +        +=========+================================+====================================================================================+
> +        | 0       | amd_pstate_ut_acpi_cpc_valid   || Check whether the _CPC object is present in SBIOS.                                |
> +        |         |                                ||                                                                                   |
> +        |         |                                || The detail refer to `Processor Support <processor_support_>`_.                    |
> +        +---------+--------------------------------+------------------------------------------------------------------------------------+
> +        | 1       | amd_pstate_ut_check_enabled    || Check whether AMD P-State is enabled.                                             |
> +        |         |                                ||                                                                                   |
> +        |         |                                || AMD P-States and ACPI hardware P-States always can be supported in one processor. |
> +        |         |                                | But AMD P-States has the higher priority and if it is enabled with                 |
> +        |         |                                | :c:macro:`MSR_AMD_CPPC_ENABLE` or ``cppc_set_enable``, it will respond to the      |
> +        |         |                                | request from AMD P-States.                                                         |
> +        +---------+--------------------------------+------------------------------------------------------------------------------------+
> +        | 2       | amd_pstate_ut_check_perf       || Check if the each performance values are reasonable.                              |
> +        |         |                                || highest_perf >= nominal_perf > lowest_nonlinear_perf > lowest_perf > 0.           |
> +        +---------+--------------------------------+------------------------------------------------------------------------------------+
> +        | 3       | amd_pstate_ut_check_freq       || Check if the each frequency values and max freq when set support boost mode       |
> +        |         |                                | are reasonable.                                                                    |
> +        |         |                                || max_freq >= nominal_freq > lowest_nonlinear_freq > min_freq > 0                   |
> +        |         |                                || If boost is not active but supported, this maximum frequency will be larger than  |
> +        |         |                                | the one in ``cpuinfo``.                                                            |
> +        +---------+--------------------------------+------------------------------------------------------------------------------------+
> +
> +#. How to execute the tests
> +
> +   We use test module in the kselftest frameworks to implement it.
> +   We create amd-pstate-ut module and tie it into kselftest.(for
> +   details refer to Linux Kernel Selftests [4]_).
> +
> +    1. Build
> +
> +        + open the :c:macro:`CONFIG_X86_AMD_PSTATE` configuration option.
> +        + set the :c:macro:`CONFIG_X86_AMD_PSTATE_UT` configuration option to M.
> +        + make project
> +        + make selftest ::
> +
> +            jasminemeng@jasmine-meng:~/amd-brahma$ cd linux
> +            jasminemeng@jasmine-meng:~/amd-brahma/linux$ make -C tools/testing/selftests

Remove the personal data (login etc.) from the above text

> +
> +    #. Installation & Steps ::
> +
> +        jasmine@jasmine-meng:~/amd-brahma/linux$ make -C tools/testing/selftests install INSTALL_PATH=~/kselftest

Remove the personal data (login etc.) from the above text

> +        jasmine@jasmine-meng:~$ sudo ./kselftest/run_kselftest.sh -c amd-pstate

Same here

> +        TAP version 13
> +        1..1
> +        # selftests: amd-pstate: amd-pstate-ut.sh
> +        # amd-pstate-ut: ok
> +        ok 1 selftests: amd-pstate: amd-pstate-ut.sh
> +
> +    #. Results ::
> +
> +         jasmine@jasmine-meng:~$ dmesg | grep "amd_pstate_ut" | tee log.txt

Same here

> +         [12977.570663] amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
> +         [12977.570673] amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
> +         [12977.571207] amd_pstate_ut: 3    amd_pstate_ut_check_perf      success!
> +         [12977.571212] amd_pstate_ut: 4    amd_pstate_ut_check_freq      success!
>   
>   Reference
>   ===========
> @@ -405,3 +478,6 @@ Reference
>   
>   .. [3] Processor Programming Reference (PPR) for AMD Family 19h Model 51h, Revision A1 Processors
>          https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip
> +
> +.. [4] Linux Kernel Selftests,
> +       https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
> 

With the above changes:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
