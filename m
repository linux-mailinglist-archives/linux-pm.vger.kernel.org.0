Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AC0615EE5
	for <lists+linux-pm@lfdr.de>; Wed,  2 Nov 2022 10:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiKBJHb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Nov 2022 05:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiKBJGy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Nov 2022 05:06:54 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF15526CF
        for <linux-pm@vger.kernel.org>; Wed,  2 Nov 2022 02:05:15 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so1522785pji.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Nov 2022 02:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mOYHShxj2Z09W+c7tLCPouxAq6KkaYZ6y3Ma3yqAsuE=;
        b=FPfSy8F51NgBPac6q89WdfCkOIziZrv4V1dJdqSeH+hBUnZ/gvmevz01ZujdBT8+mM
         DxtawPUVvSu3MCAwMH7WuQUqHa2BlJe+uX3yTM1nB0AHi0K5Pds02nuOpi590Hm+Hg2v
         wBc+IPYUmcbQiZk2LctEm8preTqbK8XzK366cUOc3w7P+Wvou/KbzcM3KinQDpi1mGc/
         p+HwwUsfPqWeMVNFL/muozyPGsUOFJS8jZQI7a6UChl46Uw3WWyu/5KDY3zmjxW6dsbW
         oHaZyv9l7xCwbz5FJPmrA5Zzfyu+d6uGFvyv1bTCRJ+HfJgFouUi1hVcm35M6nC/VIG7
         3ZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOYHShxj2Z09W+c7tLCPouxAq6KkaYZ6y3Ma3yqAsuE=;
        b=rVegr82D+NQpft72dCzUjNO7TGbe+6CuV1pxrJ8MDs7aJ041aDUDuqi4iY/0sMoBsJ
         GjTrKzbu3/AecBUYoK6HVBS8LLKud1Qv76GAVeieaIPwitQlzvL1P4sY6tJ5gsGbFFMd
         +tVvAEwkLum+VOs3o1nymPCWpc8abHMmm5mCBU/c3ait4XNINz/Q4RLp/UbQLlVHriGT
         Ahr4cVs++lmqukjrXwJiK2lkDz/dYzmv9pFvZ4oHcOAOq6aJYbL1SlsZGDrRIu7lwdZ0
         KSnBV+IUJriWpMT/28ujHGjjMrwsZW/GEr9yvfi2FtVLNHQ+p+RLJbbEh2LwFEnqcqf1
         /aUQ==
X-Gm-Message-State: ACrzQf0nTN4mXbYEgLz58h2bmsRrWw3HRFPMAwOW6A7QlOCHkrZsvvRz
        eZ7Wflc+wl+pn/K7uRrEiHYSd0IpVER5/w==
X-Google-Smtp-Source: AMsMyM7v0it+37mFtxOllnwCsi/EUsAK42mTUgpX7+cma6Gfcodtgzdt/i8z0FCpcYG5Mrh/zbrXbw==
X-Received: by 2002:a17:90a:9404:b0:213:765c:779f with SMTP id r4-20020a17090a940400b00213765c779fmr33905553pjo.127.1667379915248;
        Wed, 02 Nov 2022 02:05:15 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id i26-20020a63585a000000b0046ffe3fea77sm1620462pgm.76.2022.11.02.02.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 02:05:14 -0700 (PDT)
Date:   Wed, 2 Nov 2022 14:35:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, rafael@kernel.org, johan@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Qcom CPUFreq HW driver cleanups
Message-ID: <20221102090512.sfj5fuefzkcl24co@vireshk-i7>
References: <20221102090038.64541-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102090038.64541-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-11-22, 14:30, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series contains cleanup patches targeting the Qcom CPUFreq HW driver.
> This is a spun off of the clock provier series [1].
> 
> Thanks,
> Mani
> 
> [1] https://lore.kernel.org/lkml/20221025073254.1564622-2-manivannan.sadhasivam@linaro.org/T/
> 
> Changes in v2:
> 
> * Rebased on top of cpufreq/arm/linux-next branch

Applied. Thanks.

-- 
viresh
