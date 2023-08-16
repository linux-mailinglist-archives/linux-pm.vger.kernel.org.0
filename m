Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B6077DE33
	for <lists+linux-pm@lfdr.de>; Wed, 16 Aug 2023 12:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243734AbjHPKKA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Aug 2023 06:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243740AbjHPKJx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 06:09:53 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC26C1
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 03:09:51 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe4a89e7efso57521705e9.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 03:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692180590; x=1692785390;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wbztlOWC+xvSiRkUvyjnaCVxKKA5YeHwSfubfjJ6Ioc=;
        b=g/mFwFf/UizCKGiK+G70nkI78qvCvbtxNEjQmzADDyAkD+rFFjcq9fJ9OnY/yvyD6A
         /v79ljlCFfqbe3NPHh6k3jwx8Yv/G/AwnwGHf5GHliRsqGptoDFF32JwScf5A4n0t55x
         SfHA5ydDh3EGnz8PXFhGoSMAOKOIJeFVtnEUOtRBgs8xi5S8YaKA2jfP5sjWXt08kgHf
         cA0WnuYyw7+43+aaF5Su/zLerRR3YpwSme/9j2V+aZWFbJwaP2YRLPUsVB6fmXMv4BQd
         4gvWQsnHjdd2y9o98lpGxioKX/Yb8tkZYngocwjBoIxrNBJZXfAFUIZSCLBAVVCGtiT7
         CTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692180590; x=1692785390;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wbztlOWC+xvSiRkUvyjnaCVxKKA5YeHwSfubfjJ6Ioc=;
        b=WR9rnYZkeamJ5/aH6xbE5Qo/eU+Z60NrS7gFJkb+4RfPD12b63vJou8ofLGextgdJj
         8EFxTSPz++y7/OfxBTd7lfI7yIdw1OipchAbj3jVIonH3I+ufnyRwVFOiiEGSZUO8AiQ
         FVG41lOvCkbFu1a5cSjZcCslpjW7In+Ht8bHlsbKyrlhwOEEVhmMVr0tOu1+QJ2uhwYF
         4v7YMcPYW+V6idwTUAyagKoFLOxoSMUVSFpw/CVcxqmNjALBQO53ejHq7N+0rolla1kx
         R5LjOhh+ovFoFL9UCR7/vX43K868Xg3f5ROb+HUzBfVe9FmAiH9vSQbnbHs7oMV0M5bU
         hmxA==
X-Gm-Message-State: AOJu0YxKo/RKQWugFBuKGBt7AbjCnT5OOzBvlGWvginiriQ1WsAYUpwZ
        q2s9B0dISF8g+ZoLmve02wENF59i+dyp9gI3kX0=
X-Google-Smtp-Source: AGHT+IGrULWI+EPFd+doVfLK1Wd2coE9yVfK6JzdtJTelkJtYzlYDdsM1mYY5u735K/+QNuX3aRB4A==
X-Received: by 2002:a5d:4f86:0:b0:313:ebf3:f817 with SMTP id d6-20020a5d4f86000000b00313ebf3f817mr1108837wru.22.1692180589495;
        Wed, 16 Aug 2023 03:09:49 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id q11-20020adfcd8b000000b003180155493esm20717367wrj.67.2023.08.16.03.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:09:49 -0700 (PDT)
Message-ID: <22152b4a-0f5b-f4f0-9c6c-5e6aa13e6592@linaro.org>
Date:   Wed, 16 Aug 2023 12:09:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -next] thermal/drivers/db8500: Remove redundant
 of_match_ptr()
Content-Language: en-US
To:     Ruan Jinjie <ruanjinjie@huawei.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <20230809101439.2663042-1-ruanjinjie@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230809101439.2663042-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/08/2023 12:14, Ruan Jinjie wrote:
> The driver depends on CONFIG_OF, it is not necessary to use
> of_match_ptr() here.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

