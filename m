Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC845357CD
	for <lists+linux-pm@lfdr.de>; Fri, 27 May 2022 04:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiE0Che (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 22:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiE0Che (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 22:37:34 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5272713D0F
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 19:37:33 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id e66so2802689pgc.8
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 19:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vEt5uMmj85iIH78diI8VutYncv/+lgRIee1XJuNBlVo=;
        b=muzq6sxY5PJeaaXrefhfjlS2P1X1QmTcJXVkZ0d34P/1VVi2USpcI64v5sPNPi9n7o
         1ulMdxT+F9ozYh29oHAdsCji+NTwlugDpeFgCkqc9YsNJ1nK05/JhBf+VWR5ycaQWita
         +lknEAYNJOl6UACvgYorccKz/3iPu52wEHs0CrND9nit4F/oUW9eSbZWPFrSuAoD0YpI
         Fw3Za31MnBoy6SvIoYq0NGNsBzo5tUo7b6KME5o4xAx+LL8k2r86lWvR2bC26wXF8JGD
         JevNyIL1GkDzIyNo8jq+n3kFqWn9P5WJO4LkZMz82rarlWnEKtuorVyBvMaCHYP+LOEv
         xT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vEt5uMmj85iIH78diI8VutYncv/+lgRIee1XJuNBlVo=;
        b=L8xikwXibXJDHwMSvbH+onnGhen8m1j63ZXmhH6pZU3FkTBxRQnz3BflfR+k1TkRaY
         ijnj5j7Hs10sQc067BkUAz1u37uRLmmavZ7aEkxVMpfDbbQpi06f+GZ0CoZuqjeMPqB6
         rmZHCqH5vK88PUrrqCtrqTBPf8HUyYgDmeNp7C3dj5jJFC6Ufyl5QKJLSEnfTs9/zaCo
         llSJxQUVh8MDhKBSMbxLk9O6SQlaTFjSFH5NaoUle/gSpXEKUI0F3cT0lok/rhoBy3n3
         WA8rGRSh7KdoiZ6bxgVlF8eP7H0x2iM4By3cMjooaj2QeEmJ+CVBN1Z01qKnD7JcUNKf
         UyZw==
X-Gm-Message-State: AOAM5314mXGHgdJgSjORx0h9XVHDfPuE+h/kIQJeyWiWpKHiamY3vgMh
        aV2/y3nO/gEnh5V9glxhffHM3w==
X-Google-Smtp-Source: ABdhPJy0reVtBjFCsvHB3Es/3XtifdTMhkeagjyP/aInbKwhnq7FGhxN7io7fV6BRWf7jrn2lBCo9w==
X-Received: by 2002:a65:6d06:0:b0:3f6:2e7c:da39 with SMTP id bf6-20020a656d06000000b003f62e7cda39mr34347172pgb.23.1653619052785;
        Thu, 26 May 2022 19:37:32 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090a31cd00b001d77f392280sm341426pjf.30.2022.05.26.19.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 19:37:32 -0700 (PDT)
Date:   Fri, 27 May 2022 08:07:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] opp: Fix some kernel-doc comments
Message-ID: <20220527023729.uz3s2s5mcya46uuz@vireshk-i7>
References: <20220526132035.112026-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526132035.112026-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-05-22, 21:20, Yang Li wrote:
> Make @freq to @bw in dev_pm_opp_find_bw_ceil() and
> dev_pm_opp_find_bw_floor() kernel-doc comment to
> remove warnings found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
> 
> drivers/opp/core.c:753: warning: Function parameter or member 'bw' not
> described in 'dev_pm_opp_find_bw_ceil'
> drivers/opp/core.c:753: warning: Excess function parameter 'freq'
> description in 'dev_pm_opp_find_bw_ceil'
> drivers/opp/core.c:812: warning: Function parameter or member 'bw' not
> described in 'dev_pm_opp_find_bw_floor'
> drivers/opp/core.c:812: warning: Excess function parameter 'freq'
> description in 'dev_pm_opp_find_bw_floor'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/opp/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

-- 
viresh
