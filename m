Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF515530AD5
	for <lists+linux-pm@lfdr.de>; Mon, 23 May 2022 10:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiEWHcy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 May 2022 03:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiEWHcj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 May 2022 03:32:39 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A7826E5
        for <linux-pm@vger.kernel.org>; Mon, 23 May 2022 00:32:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id b5so5286506plx.10
        for <linux-pm@vger.kernel.org>; Mon, 23 May 2022 00:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l6vKoyEya/r3/MqVEEJWzCpNcuuesZvhsyqXin89G20=;
        b=QkkPzppkGobaBMNtLMjTdS88K0En7cKbJRSLr/uCDJHYpNDsXdoNt7dKWMSOumeJuW
         2hUbrbUVFiJiun2+NVvuDJghnz5x3AhxhqVZh7ilPtoik3nOgS6EwjLGMR57IVlIsMIS
         E51jAnuW6i5mKRZ36FgcV6rz2yQXfXyZdbsLWcMk4m3+fvRBa2MD3Dy1nAg1QiRfXSkv
         ZqsxVjyeUlyzPoEpqYpxtQy5j0L6WE2P3v486BQvYR0FuuXCjYH+CSGEucQ0NFS/aM7K
         oGOQU/xmKbrDqirJI0e1slSZb2NDdorb53JovJb8o4GRFSKF3iRHzvvfECqhiufy81fH
         fO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l6vKoyEya/r3/MqVEEJWzCpNcuuesZvhsyqXin89G20=;
        b=lf/bqv0Fg8fFMISECO4Fcp7kKD1PKkPes0TGDZf6D/PDWkiVbRV2Dxr4g8nI31wXdb
         yQQI67punSLyJq8loK6DIeOMHzrO87uqZIozQeVg6m4RyLMCKNLCcNlgmfulUuBFFzlE
         5Lpy80Y9uEns28BlMIf20shhaR5jGGIKzcekqGC7qMw4imtDukYUeCXgsUhQWiX813rK
         ekjSiu4BmtBF+MBWUOO7XmLkke9hneosb+Q0H+uMdiAKYNmBe65VZTGlQV7ohGEI5BzT
         yLL9WNNZYgcQwOlptvkfnbZRJGnoNIs4gXSl8gt94qwv7pWa5KDS4vIPqEdtbex6TX7R
         NRug==
X-Gm-Message-State: AOAM531IMtMk0fATGn8hKDX7K4/kS7BV8oL+FkLgmrQVNqswPLwgT7a1
        Vt4WcjTCBD0ZQUf597AKYMQIDg==
X-Google-Smtp-Source: ABdhPJxua26V/dTD9Xrx6ogoO6c0plBdrLo/kP7vn5fAlM3y5vBZrLDMIXXKyZRHMsd33ZQVnFsxyA==
X-Received: by 2002:a17:902:f710:b0:15f:165f:b50b with SMTP id h16-20020a170902f71000b0015f165fb50bmr22287217plo.158.1653291123694;
        Mon, 23 May 2022 00:32:03 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090341c600b0015e8d4eb2d8sm4322308ple.290.2022.05.23.00.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 00:32:03 -0700 (PDT)
Date:   Mon, 23 May 2022 13:02:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Meng Li <li.meng@amd.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 2/4] cpufreq: amd-pstate: Add test module for
 amd-pstate driver
Message-ID: <20220523073201.asdi35v5f43aoaee@vireshk-i7>
References: <20220522115423.1147282-1-li.meng@amd.com>
 <20220522115423.1147282-3-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220522115423.1147282-3-li.meng@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-05-22, 19:54, Meng Li wrote:
> Add amd-pstate-ut module, which is conceptually out-of-tree module
> and provides ways for selftests/amd-pstate driver to test various
> kernel module-related functionality. This module will be expected by
> some of selftests to be present and loaded.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/cpufreq/Kconfig.x86     |   7 +
>  drivers/cpufreq/Makefile        |   1 +
>  drivers/cpufreq/amd-pstate-ut.c | 293 ++++++++++++++++++++++++++++++++
>  3 files changed, 301 insertions(+)
>  create mode 100644 drivers/cpufreq/amd-pstate-ut.c

I wonder if this should be moved to selftest directories instead ?

-- 
viresh
