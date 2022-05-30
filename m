Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D76A538589
	for <lists+linux-pm@lfdr.de>; Mon, 30 May 2022 17:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbiE3Pzi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 May 2022 11:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242812AbiE3PzR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2022 11:55:17 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE037A440
        for <linux-pm@vger.kernel.org>; Mon, 30 May 2022 08:37:40 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q21so3968567wra.2
        for <linux-pm@vger.kernel.org>; Mon, 30 May 2022 08:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dHVLbk3AV0dd8GEKymr7IhItI3kAwD2l5UPJ3pBu8OY=;
        b=S2W8GweQqrYTD47vb+pQgiKJ5qKN2lkHBo0u95Afq6WcHRoWcblyWf/jI+i+ij6Neu
         5hEh/HcfQ7xorUCYltwrCc0EVljT8TGGdcwS+Q8JGzAuHsh/Dmf4gjMHsWVxWjCF/0UD
         2tZgn93GyOrHyu1vsuc9EwiOwYlruy1AOFYY25+nDjz92zbfHWBBaQyxH+Esn+i5LyJD
         BWHkrFZsdBOFKov/Gu06uuCcPbSh9AD+9o1nyCJTtOXH6x2aLyFiiIVbmmtcBttZ8X1R
         tKX+TFmqvCr2NGVuBMOhjkL0Q6WxQWiqKH342HBEImMABiHXCxyFKGOKuKolsLvEdG8P
         Wm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dHVLbk3AV0dd8GEKymr7IhItI3kAwD2l5UPJ3pBu8OY=;
        b=0qzgq3QnrO5Ylilt72KAlA9sF2A8NhboLBypxTVCt3S77LwmUV3CyjKrqmiZrC+bff
         dsR7k+a949uhsGP8OXZJZklU4+HoscfvfcqRq1Zzh/k/9toM3wl30hmHkAXwv9Q+bdsJ
         Y5sqoGAAoSGAZQYPopaT5L4iJ7QPetA4KEhKXsB9/CeKDk0E8tQRYyOmejJyLJRbBUYl
         aiDjg9n2ePFeJsbY/6Ca1L8K1Yw8/mKFB5xqLcKC26gcdKQ4HpS6wdURs99MUsAZtug0
         7CHvyT/wKSzM1Vr/t5TMuHnPq4+7Qtej5U8erc/keTkp2VWnhRepEBOn2Tu2askSOPeB
         vYVg==
X-Gm-Message-State: AOAM5328tIEFIn7J80RbwNr0Se7bDGMfmJ0f7P446ZSUse6/edDKQTEv
        68TMIyEXYY2wQU0YtUpCngjCIw==
X-Google-Smtp-Source: ABdhPJwFmlnZmLrmB5aHH6oBUwmP9Hl/eVP4Wo3PbT5phvdQ46qd5owrHlZhQHlMToTG/7c6/cL3Cw==
X-Received: by 2002:a5d:6b8a:0:b0:20f:f515:98d6 with SMTP id n10-20020a5d6b8a000000b0020ff51598d6mr24297234wrx.527.1653925058720;
        Mon, 30 May 2022 08:37:38 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id f1-20020a5d5681000000b0021033caa332sm3260262wrv.42.2022.05.30.08.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 08:37:38 -0700 (PDT)
Message-ID: <7037eef5-1af4-4a54-08a5-b078fe2540ce@linaro.org>
Date:   Mon, 30 May 2022 17:37:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/2] arm64: remove generic ARM cpuidle support
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220529181329.2345722-1-michael@walle.cc>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220529181329.2345722-1-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/05/2022 20:13, Michael Walle wrote:
> Playing with an own PSCI implementation, I've noticed that the cpuidle-arm
> driver doesn't work on arm64. It doesn't probe because since commit
> 788961462f34 ("ARM: psci: cpuidle: Enable PSCI CPUidle driver") the
> arm_cpuidle_init() can only return -EOPNOTSUPP, because the commit removed
> the cpu_idle_init and cpu_suspend ops.
> 
> It left me puzzled for quite some time. It seems that the cpuidle-psci is
> the preferred one and this has been the case for quite some time. The
> mentioned commit first appeared in v5.4.
> 
> Remove the ARM64 support for the cpuidle-arm driver, which then let us
> remove all the supporting arch code.
> 
> Michael Walle (2):
>    cpuidle: cpuidle-arm: remove arm64 support
>    arm64: cpuidle: remove generic cpuidle support
> 
>   arch/arm64/include/asm/cpu_ops.h |  9 ---------
>   arch/arm64/include/asm/cpuidle.h | 15 ---------------
>   arch/arm64/kernel/cpuidle.c      | 29 -----------------------------
>   drivers/cpuidle/Kconfig.arm      |  3 ++-
>   4 files changed, 2 insertions(+), 54 deletions(-)

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
