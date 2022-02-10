Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22544B0507
	for <lists+linux-pm@lfdr.de>; Thu, 10 Feb 2022 06:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiBJF1T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Feb 2022 00:27:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbiBJF1Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Feb 2022 00:27:16 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8D8DB7
        for <linux-pm@vger.kernel.org>; Wed,  9 Feb 2022 21:27:17 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id u16so2577776pfg.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Feb 2022 21:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aNj5Xh0xA6luKin8itDN2Q7hu6ygPFEEo5apEpE+LlY=;
        b=tBMJbISrQv+1mFot1P5qF4jD2V2MhoFY3dgpLTbOyXJf9HCdVKkRFzDYALxvCLpSU5
         RDp6h19SWeKdPqNQGV61d1dGNX5gzx4+Q0HwUvCE4jaXwgRLR9jJNiJduW2o7Lvy5KgD
         ne19u3f2NT7Q2nTDFtTCXx2qXdFj9DzBxiS/QB5gs+HDmz6jVe/kLNDzK9+2qXkAQ6mg
         swz5K5IzKu/9777ETt+ZLfYKTo28cZfrKZlc6d3ZgKa1GUAiDf8e8OpSC/QmoBSDzM9O
         U0JwdkDRq7lsaU+5lX2pdo9U0nJ+eX9TWgCm1/qFvkmjZiXrrHQ271s3eC5Rnrx1dn1r
         /MOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aNj5Xh0xA6luKin8itDN2Q7hu6ygPFEEo5apEpE+LlY=;
        b=Lypp3tnU+THMZzUMPsDUGsv32VF3x2T/DIW/PqY6x5Jaqdn4spL89vSx26Rwb0p5zf
         5jkWhfjLNZmRYsinuzEena3gweDkOhf3RpOEwlrpWKupb5zS+dFPcbZSP7eobFjjH/Ev
         Ay0P86diauaiLLfU+RhZlIbjKNpwLyISccOtgY9cfN6ZjM+O5vBUQ6fjXCP4JK8GrPIc
         IG8PAUL7YVOZWhcgzavbHLQdx2z1oKBqSb1MD4/n77vl5LcY8efssBi9N7N13dlUQL5f
         6v2BWu7dUEYJlu10NDMCFhWJvpVR2bNDUUJovtoWzQyEuFoQc9W1W0N822Krl2WZ4cDV
         sc+Q==
X-Gm-Message-State: AOAM530D7jMdz2HaGnrfyUN5zW9olYK+ZXlwn9gnElMgSoeeiUgk6r+D
        EYqj7fP4rq5rQOPfTPZTgGQ4td3CN5yvhA==
X-Google-Smtp-Source: ABdhPJySnVchiExhDDsVEiiW2jga5YDbIbQp0gXN4uCn5Wed/vB+Sf7H0H3dId3iJ/6+ssJ2b4IIxg==
X-Received: by 2002:a63:4b17:: with SMTP id y23mr4781304pga.489.1644470836741;
        Wed, 09 Feb 2022 21:27:16 -0800 (PST)
Received: from localhost ([136.185.132.167])
        by smtp.gmail.com with ESMTPSA id pc4sm691067pjb.3.2022.02.09.21.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 21:27:16 -0800 (PST)
Date:   Thu, 10 Feb 2022 10:57:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <Pierre.Gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Lukasz.Luba@arm.com, Morten.Rasmussen@arm.com,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq: CPPC: Fix performance/frequency conversion
Message-ID: <20220210052714.em6vt7j627wi5dns@vireshk-i7>
References: <20220208080109.697904-1-Pierre.Gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208080109.697904-1-Pierre.Gondois@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-02-22, 09:01, Pierre Gondois wrote:
> CPUfreq governors request CPU frequencies using information
> on current CPU usage. The CPPC driver converts them to
> performance requests. Frequency targets are computed as:
> 	target_freq = (util / cpu_capacity) * max_freq
> target_freq is then clamped between [policy->min, policy->max].
> 
> The CPPC driver converts performance values to frequencies
> (and vice-versa) using cppc_cpufreq_perf_to_khz() and
> cppc_cpufreq_khz_to_perf(). These functions both use two different
> factors depending on the range of the input value. For
> cppc_cpufreq_khz_to_perf():
> - (NOMINAL_PERF / NOMINAL_FREQ) or
> - (LOWEST_PERF / LOWEST_FREQ)
> and for cppc_cpufreq_perf_to_khz():
> - (NOMINAL_FREQ / NOMINAL_PERF) or
> - ((NOMINAL_PERF - LOWEST_FREQ) / (NOMINAL_PERF - LOWEST_PERF))
> 
> This means:
> 1- the functions are not inverse for some values:
>    (perf_to_khz(khz_to_perf(x)) != x)
> 2- cppc_cpufreq_perf_to_khz(LOWEST_PERF) can sometimes give
>    a different value from LOWEST_FREQ due to integer approximation
> 3- it is implied that performance and frequency are proportional
>    (NOMINAL_FREQ / NOMINAL_PERF) == (LOWEST_PERF / LOWEST_FREQ)
> 
> This patch changes the conversion functions to an affine function.
> This fixes the 3 points above.
> 
> Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
> Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 43 +++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 22 deletions(-)

Applied. Thanks.

-- 
viresh
