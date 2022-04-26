Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE4550F12E
	for <lists+linux-pm@lfdr.de>; Tue, 26 Apr 2022 08:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242092AbiDZGku (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 02:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245321AbiDZGkt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 02:40:49 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BB31AF0C
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2022 23:37:42 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c23so29365683plo.0
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2022 23:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LQNCCW/t0M6nUNyuJqCbQI/CYri/RfqDdfU7D89JkJ0=;
        b=Az/DGRUZR2PA9GH8zclYK4b2XW/jSG+j5MZ6mIw7QNuDXan+X7AUawIdfEZzWzpHJO
         2wFb3ORD09d8NZv21bBeV49T5Vns6fUKGQEDfF0EYguRdNsskPdSsQCZQAHlGypmjm0r
         X/Br7S0PykDvBHjbKateyvvxl9DrWczr5kgXugMLHfEQSQrK6MPxctb0GaGewBDJfYUk
         9DgXiZHPNmiqdqm9NsRDkdIKfA1kHoyIkTkF7KXkjYDbiXeAez4g3XDvcpwEvRn/ycbN
         mc+tWyAb5tnVQTS7GZ4muzCrt6Z/vKC7yf+X+si0zUhJy4d5iwlsZZKp1r4j5l9ihL+2
         8Uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LQNCCW/t0M6nUNyuJqCbQI/CYri/RfqDdfU7D89JkJ0=;
        b=1gAxUyE4GHYeOQzlsbTmdqXD+sqeXO70IXUiLUR6yh8aLdF7sKzEOwJOElhPxE0nGm
         HiUV8nP1IVJNSAxqOOcdu3cF85GUrOlzwVUXH7xMuQubjz+EYnQoaAQbVsAGkWLr9mbJ
         2SG0MlMNxXnXqIOiuYIOH+WC6hou7AsGAXBR/XIdJ4iJ7BKOfxw6XiQuHSXsPROlA0dt
         Na1NtuWwPCf+KbJccvh7SWfOCMKx2JdEgVPLXy8wyBKDeU5TSZYR7oE/hYLFGS7jkl9N
         x+OzQGjkcCmvF+kkOA5eln9lIvliL2aYkaS4msnXkKj+ASlL/QvGGYxJD9fSjigfXF6L
         4UNg==
X-Gm-Message-State: AOAM5307CAi35T1d+TDGtBQd7aX91D9algkl3MsnC0Iz11M/bG0HARCi
        Mbf4Y/QSB2dTVC/fy0ahLZA5/Q==
X-Google-Smtp-Source: ABdhPJwenGlYYDtA9Pf1VcI+f2beWfAPx5oE+gOaOF/mgSNPqWqX40ksxmc1Ylaff2VJS9YgT6foTQ==
X-Received: by 2002:a17:902:e890:b0:15a:161a:16a with SMTP id w16-20020a170902e89000b0015a161a016amr21439971plg.39.1650955062538;
        Mon, 25 Apr 2022 23:37:42 -0700 (PDT)
Received: from localhost ([122.177.141.190])
        by smtp.gmail.com with ESMTPSA id p185-20020a62d0c2000000b0050d1f7c515esm10302858pfg.219.2022.04.25.23.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 23:37:41 -0700 (PDT)
Date:   Tue, 26 Apr 2022 12:07:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Lukasz.Luba@arm.com, Morten.Rasmussen@arm.com,
        Dietmar.Eggemann@arm.com, maz@kernel.org,
        daniel.lezcano@linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fuad Tabba <tabba@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Rob Herring <robh@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Enable EAS for CPPC/ACPI based systems
Message-ID: <20220426063739.6ljxtr6hpz7tber5@vireshk-i7>
References: <20220425123819.137735-1-pierre.gondois@arm.com>
 <20220426030810.wj7mdhjhzs2s6y7h@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426030810.wj7mdhjhzs2s6y7h@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-04-22, 08:38, Viresh Kumar wrote:
> On 25-04-22, 14:38, Pierre Gondois wrote:
> > v3:
> > - Remove efficiency_class_populated variable. [Viresh]
> > - Remove patch "cpufreq: CPPC: Add cppc_cpufreq_search_cpu_data"
> >   and access cpu_data through policy->driver_data. [Viresh]
> > - arm64 code only acked by Catalin [Catalin]
> 
> Applied. Thanks.

Removed, build failures:

https://gitlab.com/vireshk/pmko/-/jobs/2375905218

Log: https://builds.tuxbuild.com/28Jos1GBXfT5Cl3HoBKKwmM8Ddk/build.log

/builds/linux/drivers/cpufreq/cppc_cpufreq.c: In function 'cppc_cpufreq_register_em':
368/builds/linux/drivers/cpufreq/cppc_cpufreq.c:593:3: error: implicit declaration of function 'EM_ADV_DATA_CB'; did you mean 'EM_DATA_CB'? [-Werror=implicit-function-declaration]
369  593 |   EM_ADV_DATA_CB(cppc_get_cpu_power, cppc_get_cpu_cost);
370      |   ^~~~~~~~~~~~~~
371      |   EM_DATA_CB
372/builds/linux/drivers/cpufreq/cppc_cpufreq.c:593:3: error: invalid initializer
373cc1: some warnings being treated as errors
374

-- 
viresh
