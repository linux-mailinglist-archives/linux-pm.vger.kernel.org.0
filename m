Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFEC56D242
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jul 2022 02:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiGKAqv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jul 2022 20:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiGKAqu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jul 2022 20:46:50 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208CBB842
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 17:46:49 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s21so3525722pjq.4
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 17:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jy+u2/Orkw5KmxP7WWAAr+h35zqqzgNFiJmE5176PKs=;
        b=FKr76hKbqTHdXaZzcQk1JcbTd4xuSqOxQDHNWsg9ayDudMqqReoSZ9z5QmGGwMFK6S
         dlFfuOyqGl71Bl5zPoaiYh/JYKPihW/xDoCmV0Up3twQrSU6cLI9zOefwxA9dSMbxhf0
         kZ5NObhrk1+w6DieyXHAGPwqI95jn+lqRn34dPf+571/gtjAxv2l+RnoeOe1TmqaS6cq
         701Se9xvjjzjHCEAMytfoLPCUhjaeF6YQ95sji2Aa41KGdmnX+rlXhVqWJTw/UQKC6Bw
         q18kqUPqiLKJG4VA8SyuGe2jEKBO/BAB6QS5HZY3WEaFIv6UxxJu1UNvLixrRep5TMSh
         TtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jy+u2/Orkw5KmxP7WWAAr+h35zqqzgNFiJmE5176PKs=;
        b=cBDY+bkdWiYKzrGtoCS50D6Vj7D2Tw63rYYxvAgKy8lC1XhEjlD/ylMmX4odmvDKOj
         N0NBCSE8/KNM4x7wMQXJ8OcX7/YW/cL6e3zgIx+w0zCmIKOelcJPH1AlmMrJ9KncZH6X
         b+3alFADpgRXivwyrSz3ZedY55Z4ShDvve0sMBMq+G+H5Ijh/kTeRQs1d9a55Zh/AYIy
         kRNgv+Nn0L1CVAX3Md4dapRIOc3ug4GZeNDOrY8V53onAshktg7y2qxUscQoJLWPQuW6
         0G2IgVB77eXpUmbIoABaFX3Q3OrBk4tPoDtgikwpz3yQK6eLV9gJBd/dmWAxM1He0WRG
         3qLQ==
X-Gm-Message-State: AJIora+gBF5LFMF/T2FqEygaJTjUSV2ss01sJhWTF/cvVwre+vMwDW/k
        fdZfPdVmiceQKcdn6mzDcdGX5g==
X-Google-Smtp-Source: AGRyM1uNhy5evo7SwlchejT3g9GtNUWQV4wZlNyCE2q8RGYdxI34ybn5w9nncvXTYD1BAA5bxfIXQg==
X-Received: by 2002:a17:902:da88:b0:16c:27f9:8762 with SMTP id j8-20020a170902da8800b0016c27f98762mr13845419plx.85.1657500408674;
        Sun, 10 Jul 2022 17:46:48 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b0016bd16f8acbsm2490732plg.114.2022.07.10.17.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 17:46:48 -0700 (PDT)
Date:   Mon, 11 Jul 2022 06:16:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Dietmar.Eggemann@arm.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/4] qcom-cpufreq-hw LMH irq/hotplug interractions
Message-ID: <20220711004639.fpppw7gcv5lkyghs@vireshk-i7>
References: <20220704112739.3020516-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704112739.3020516-1-pierre.gondois@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-07-22, 13:27, Pierre Gondois wrote:
> v2:
> - Rebased on v5.19-rc5
> - Changed irq checks from '< 0' to '<= 0' to be aligned
> 
> The patch-set was tested on a rb5 with an old firmware version:
> UEFI Ver    : 5.0.210817.BOOT.XF.3.2-00354-SM8250-1
> Build Info  : 64b Aug 17 2021 23:35:39
> 
> commit ffd6cc92ab9c ("arm64: dts: qcom: sm8250: add description of dcvsh
> interrupts")
> enables DCVS (Dynamic Clock and Voltage Scaling) for sm8250 chips
> (so rb5 included). As no LMH (Limits Management Hardware) interrupts
> were seen, the firmware used for testing should not be able support
> them.
> 
> This patch-set should still contain relevant modifications regarding
> LMH interrupts and CPU hotplug. Still, it would be good to test
> it on a platform which actually uses LMH interrupts.
> 
> Pierre Gondois (4):
>   cpufreq: qcom-hw: Reset cancel_throttle when policy is re-enabled
>   cpufreq: qcom-hw: Disable LMH irq when disabling policy
>   cpufreq: qcom-hw: Remove deprecated irq_set_affinity_hint() call
>   cpufreq: Change order of online() CB and policy->cpus modification
> 
>  drivers/cpufreq/cpufreq.c         |  6 +++---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 11 ++++++++---
>  2 files changed, 11 insertions(+), 6 deletions(-)

Applied. Thanks.

-- 
viresh
