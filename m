Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3661B710360
	for <lists+linux-pm@lfdr.de>; Thu, 25 May 2023 05:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjEYDkg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 May 2023 23:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjEYDkf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 May 2023 23:40:35 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5078A135
        for <linux-pm@vger.kernel.org>; Wed, 24 May 2023 20:40:33 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso1301076b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 24 May 2023 20:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684986033; x=1687578033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCvoKrY8dd9+Q/pN1yCXWPMzhbV2OgM2HZjKi5ItOYg=;
        b=T3hHMk8KKSx8DqbWGNA7oa+tLWZKWo5p2ZUhD0VcuQ4ykgTgOx9GeJtYKDNGfeK/SL
         zawp/rx7Sw/KiQam2QU71Dx/Wf7VC/1xovlRvBejQlFg/wgCq87OqeyIMHZE8qmbarSy
         iwTeNXYWq6T0gPUYv9N6elmUngX5W7Fofowy7vATgGIeVfKwVDWhKFyJWIQ+I4OwcR6o
         D/Hr8W4DawDx9UcSSlKHs0KPU9KUgcj+GfNgRuiCNY4k4prvPhctyN+3zh/ho/1NTlk5
         BUd0rMqS2bxOBrYWiSnGaY4KHgFfGacwMRI9E4r0G/3Ak2kOtVl7VW5JfqhhplJIwK94
         14Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684986033; x=1687578033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCvoKrY8dd9+Q/pN1yCXWPMzhbV2OgM2HZjKi5ItOYg=;
        b=gtD6hANAVZQvTvX1MTtAPehGnHXz2bKyhWenqUDCEc7BTND79TscrmZkZFPToKd2Do
         yGOkBn8aN7M0nC8OtMH9Ea10TKAtw0iXJuYKlY4Kl1E3NcLf9oeARGadHqlScl0i+isy
         tOWa+tfv+sR08C6BYsw4wr3HSNunHYDGKXY9pDHOlMrFeMLBJEbPKyk14J3hPHiM9S+r
         BaiRMGlTpAfu1IkOOn58xVqmzNTfkDMX8IaPw42IChQH5OviXR1mFEG9Y6jiFwf9Z7By
         fReY9RrCooNgG87YBWn2T9p80bt/zgJCL4sSXfglWZ2S3fGChm2T1ORzXVVmwIUgU2wD
         q0cQ==
X-Gm-Message-State: AC+VfDyyrkdH0pvzPZbunKlJ8sG/bOsTFcaQY+ZftdO+4bUBXuEx5FvI
        2tzgDnla7v6wJI/2EfuwhOkS7Q==
X-Google-Smtp-Source: ACHHUZ4K2F72irG192E/C2ZC/hrkB10DNT9SkhTSN29jyAic+IcfybdeNC74YeRf00Du88A+0sOt9Q==
X-Received: by 2002:a05:6a00:2d1d:b0:64d:3e7f:7121 with SMTP id fa29-20020a056a002d1d00b0064d3e7f7121mr5672834pfb.22.1684986032719;
        Wed, 24 May 2023 20:40:32 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id j15-20020a62b60f000000b0063b6451cd01sm179468pff.121.2023.05.24.20.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 20:40:32 -0700 (PDT)
Date:   Thu, 25 May 2023 09:10:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, ansuelsmth@gmail.com
Subject: Re: [PATCH v2 4/4] cpufreq: qcom-nvmem: use helper to get SMEM SoC ID
Message-ID: <20230525034029.wlitykc25pssssii@vireshk-i7>
References: <20230524162329.819770-1-robimarko@gmail.com>
 <20230524162329.819770-4-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524162329.819770-4-robimarko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-05-23, 18:23, Robert Marko wrote:
> Now that SMEM exports a helper to get the SMEM SoC ID lets utilize it.
> Currently qcom_cpufreq_get_msm_id() is encoding the returned SMEM SoC ID
> into an enum, however there is no reason to do so and we can just match
> directly on the SMEM SoC ID as returned by qcom_smem_get_msm_id().
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v2:
> * Utilize helper exported by SMEM instead of refactoring
> qcom_cpufreq_get_msm_id()
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 55 +++++-----------------------
>  1 file changed, 9 insertions(+), 46 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
