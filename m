Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1159753519A
	for <lists+linux-pm@lfdr.de>; Thu, 26 May 2022 17:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbiEZPoT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 11:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237261AbiEZPoR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 11:44:17 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E52D808E
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 08:44:15 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id j15so1308982ilo.5
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 08:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t9FuzQy1mkS/UW8FaDARdLXkyAZZV1awtms5PAsyAmE=;
        b=MPuKvg9lbAGBLPLIhjIPsMx11w2QC+cO7KKzw+FGkCAUc6gPmdiIIxkz+mh/j1HjfX
         F6jnxZ67hhtSdYsNqG6apPHjy78akKz/WPb6TpYlCPdSZnxgVr2XWZcVrEz+OXk9vn+Y
         TKe/BUB9JIIuz3Jg7OYi8StCpDU/C7kE8cbOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t9FuzQy1mkS/UW8FaDARdLXkyAZZV1awtms5PAsyAmE=;
        b=z8r1CPpZIgRTY44Q+F12ws1C/ofn4jRNLvblG4RvQlSOEFxxLYm2NBVT9ik/1O6O8A
         EsX75m5PNryhRH2moP6ADv+wcJ2EH3Ey2Vtve7ZTrnTOoNfqgPrPgxHAwO9w3PnhWQ3s
         paT4w8deL9nUxT1fyVTXOrOKzww0vUnDnflZrhaLLGm28US+V12f16izQmiiaS3EhZvC
         9ttbmHCymy9VtGUh+P8P9Kt2pgiBZletB5we1Ez/HrvwifSW6loyjJLuh529emZv4MJn
         J27GmSFRY4hlTm93LkdZKpxooiw6+u7Z+N7c/b9m6FGOgSxQ6KIbvIqUPUq7LXYCvB8D
         PRcg==
X-Gm-Message-State: AOAM533o3H45HVJJELNO53C57bzL36XMbambmMgEbPuisClUeNfVbNPN
        TDhssiZrnS22rkKtRJ/j5d3nbA==
X-Google-Smtp-Source: ABdhPJxd2HpYEqbVBTiZT+p7mu17J49fCl4Epd+1A0eBP4zKlo+QqSX/Qhe3DtpLgA5CbmV44RBlfA==
X-Received: by 2002:a05:6e02:1b86:b0:2d1:ad50:53f1 with SMTP id h6-20020a056e021b8600b002d1ad5053f1mr10236181ili.191.1653579854622;
        Thu, 26 May 2022 08:44:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b7-20020a023807000000b0032ec819a560sm471302jaa.169.2022.05.26.08.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 08:44:14 -0700 (PDT)
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
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fbd6bc2f-b6d7-497e-410c-4a82876075ff@linuxfoundation.org>
Date:   Thu, 26 May 2022 09:44:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220526034725.1708916-1-li.meng@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/25/22 9:47 PM, Meng Li wrote:
> Hi all:
> 
> AMD P-State unit test(amd-pstate-ut) is a kernel module for testing
> the functions of amd-pstate driver.
> It could import as a module to launch some test tasks.
> 1) It can help all users to verify their processor support (SBIOS/
> Firmware or Hardware).
> 2) Kernel can have a basic function test to avoid the kernel regression
> during the update.
> 3) We can introduce more functional or performance tests to align the
> together, it will benefit power and performance scale optimization.
> 
> We upstream out AMD P-state driver into Linux kernel and use this unit
> test module to verify the required conditions and basic functions of
> amd-pstate before integration test.
> 
> We use test module in the kselftest frameworks to implement it.
> We create amd-pstate-ut module and tie it into kselftest.
> 
> For example: The test case aput_acpi_cpc is used to check whether the
> _CPC object is exist in SBIOS.
> The amd-pstate initialization will fail if the _CPC in ACPI SBIOS is not
> existed at the detected processor, so it is a necessary condition.
> 
> At present, it only implements the basic framework and some simple test
> cases.
> 
> TODO : 1) we will add more test cases to improve the depth and coverage of
> the test. E.X. use the script to trigger the tbench, gitsource, kernbench,
> netperf, speedometer, and etc. testing and monitor the cpu frequency and
> performance goals change, power consumption at runtime.
> 
> Please check the documentation amd-pstate.rst for details of the test steps.
> 
> See patch series in below git repo:
> V1: https://lore.kernel.org/linux-pm/20220323071502.2674156-1-li.meng@amd.com/
> V2: https://lore.kernel.org/lkml/20220413090510.4039589-1-li.meng@amd.com/
> V3: https://lore.kernel.org/lkml/20220421074152.599419-1-li.meng@amd.com/
> V4: https://lore.kernel.org/lkml/20220427135315.3447550-1-li.meng@amd.com/
> V5: https://lore.kernel.org/lkml/20220505022913.329259-1-li.meng@amd.com/
> V6: https://lore.kernel.org/lkml/20220519134737.359290-1-li.meng@amd.com/
> V7: https://lore.kernel.org/lkml/20220522115423.1147282-1-li.meng@amd.com/
> 

> 
> Changes from V7 -> V8:
> - cpufreq: amd-pstate:
> - - amend commit message.
> - - amend module description.
> - Documentation: amd-pstate:
> - - amend commit message.
> - - Remove the personal data.
> 

Looks good to me. Thank you.

Rafael, Viresh,

How do you want to handle this patch series? We are in merge window
and this would be for Linux 5.20 based on the changes and content.

Would you like to take the entire patch series through your tree, you
have my Ack(s) and Reviewed-by(s)

thanks,
-- Shuah

