Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435F46B1097
	for <lists+linux-pm@lfdr.de>; Wed,  8 Mar 2023 19:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjCHSEz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Mar 2023 13:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjCHSEq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Mar 2023 13:04:46 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A15E99D63
        for <linux-pm@vger.kernel.org>; Wed,  8 Mar 2023 10:04:45 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t15so16216536wrz.7
        for <linux-pm@vger.kernel.org>; Wed, 08 Mar 2023 10:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678298683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=36QQSXDy6HLVF+1TRChIdbNOy+S6sdWRo/ebFHbbL/w=;
        b=xwZVnDqNNrqeOGErsihKhmARGxeQxjenT2pg8APxKJnrKeG6DXe8WYFgNiDuQ+2D9m
         e4uwYe92oW5h1tkYR1zpX7j4asq8c800kUnoDi1PaBEDQEMCLgcGuBElgAsTmdjLvG2C
         CoBgPsAwavVxsyOGBHol+wMrq2hGf+9vlSo2EpOnOSsiV88LdFfmhVq04SXead5XF3c4
         PdCU29X6TE7g+MRSfBwCcELU8xq1nroQLo3d+4P3vtJRTfT6IqxgLaHQ9nGd+TY8SwgC
         NhbjR3CX/HMUelCRyvYO5p6i/OnD14BNIkD6RvMBCXX4RpGPWcufq4Bunp1tESKwmZUy
         A48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678298683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=36QQSXDy6HLVF+1TRChIdbNOy+S6sdWRo/ebFHbbL/w=;
        b=sBhTC1tW1AtvlcAmp1l6T+1WaJ6GjUCusu7yOWQkh2Xpq9aRmbfn6jogVxzqHyT7XT
         bXBKyCjJupA38q+0ffKQcap//grQLs0bjO8Bqr57a/YfiREz2pu7tVmfPtXuuMtAhMAh
         PQW0JHFGprvyS+tOn9wJhnU4WQPAYylAr7qF5bmQLbqwplMdAmJ5vrueNv2EVPb7Xhdj
         dJDd4aRDagJffUJ7Xs1af6phHoVUPv4sRoiHW9e4go7SnL9w6sZE5hXmo11+ISa0Dj5N
         j3igR88d1SlwN+D4/hYvEJYrYuO7dgX1dccrsAsbZC7WSarf8cOtyZIk4HwtH1dW504D
         56ug==
X-Gm-Message-State: AO0yUKXq+acwp8xjGjfW2dnmuuCliTj7g3u2zPmnjB9XKjgReYpnpzdn
        89lznnKIgBuWUlRjJJ4aGr0q3Q==
X-Google-Smtp-Source: AK7set87hJiYUFdWOhlkLfiCzzQEgcB/m/PwMmOH752pH3UfZH7d6XhMNiDWB4G+OFRfnegFoUu/Ug==
X-Received: by 2002:a5d:6912:0:b0:2c8:14ba:4589 with SMTP id t18-20020a5d6912000000b002c814ba4589mr11585613wru.42.1678298683569;
        Wed, 08 Mar 2023 10:04:43 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:4213:ad42:5630:43c4? ([2a05:6e02:1041:c10:4213:ad42:5630:43c4])
        by smtp.googlemail.com with ESMTPSA id r11-20020a5d494b000000b002c54c9bd71fsm15310715wrs.93.2023.03.08.10.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 10:04:43 -0800 (PST)
Message-ID: <1d0e06ca-c61c-27f1-281a-ed75034c91d4@linaro.org>
Date:   Wed, 8 Mar 2023 19:04:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 06/11] thermal/drivers/rcar_gen3_thermal: remove R-Car H3
 ES1.* handling
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
 <20230307163041.3815-7-wsa+renesas@sang-engineering.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230307163041.3815-7-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/03/2023 17:30, Wolfram Sang wrote:
> R-Car H3 ES1.* was only available to an internal development group and
> needed a lot of quirks and workarounds. These become a maintenance
> burden now, so our development group decided to remove upstream support
> and disable booting for this SoC. Public users only have ES2 onwards.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> Please apply individually per subsystem. There are no dependencies and the SoC
> doesn't boot anymore since v6.3-rc1.

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

