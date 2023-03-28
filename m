Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0F16CB7D9
	for <lists+linux-pm@lfdr.de>; Tue, 28 Mar 2023 09:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjC1HTG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Mar 2023 03:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjC1HTF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Mar 2023 03:19:05 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952F2212B
        for <linux-pm@vger.kernel.org>; Tue, 28 Mar 2023 00:19:04 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y4so45751973edo.2
        for <linux-pm@vger.kernel.org>; Tue, 28 Mar 2023 00:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679987943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2YyLtcWfck99XSuqte56OpC8fUbT/DMhZm1MlJJ7vA8=;
        b=z1sqXxQK/OtJ1ZoqcpRiUEqtysmThq/PWJo1jm3zyBVh6LaVkSGBoxN8ooZDIBhrRi
         AITIizoPzmojNxjJAffW6kihGC0PGvdhqWbx2MwKQ6xCm5aB5V3VavxKn6aHF5MgmO82
         mmMBH9Sd1ZL46KOA6eb5bj9VQRcH8eTNpI0K/isyA5zlWFkeB4/ll/K69oFb1YXm6ary
         Kv3/1K2WGEetv3zLP1p+ylZcOp0kT+oeNCf/ki8TG1Zj+qJo69PtyeQMBx95h2IJpDir
         Z5r4DObtH2ILFJJ0A6MxX1BswYzhkDdJbjVnE2lZe6oVWxFbeOrbooUC0DejK7kosH+Z
         polg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679987943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YyLtcWfck99XSuqte56OpC8fUbT/DMhZm1MlJJ7vA8=;
        b=apOa1uuLjLlIRxJpPA7vg0rFbw5qS1W/lvUqv3W0cVN0buFF0isGtnO/JOFzYscrUg
         W1ebMzDxnCVE+H4uzFyR2BQFHNVdV+cn92ddzYBY2uqnyXGD6H8S0XvUqD3q6P5fOyZl
         avRmDSeoDM1c6A1jO4mYYPqLfgzqfdIOTYJOKSQTKoekybD4z0PzEzi0TNStugYcJpEq
         acxeYZ2zFRMdvcKZ0gy6AQjrZhdPlxRM9+uD1hLssk35Pt7Iikae7dst59+Xz5BQ5tqo
         5nDlb8KeCUBYdgvNWM9LQmknH7K2yE28bb8TCUcrOvbMKzaGZrxDHAgTwX+KzA3FKZcO
         8/gg==
X-Gm-Message-State: AAQBX9dlDuOYbfMTKSdMOFnwmceI+7o56IGTecMioDllW8LoQpu64d3f
        6bZYlgXOebN9cKoUSU4Zus91jw==
X-Google-Smtp-Source: AKy350bneuuGtkW4SO7vxT4eJZc8NFZcpqqqi3sMZmlLvaa3a9JEy+Nj0eljodAD/Qx+zXHyGfM3gg==
X-Received: by 2002:a17:906:8288:b0:933:44ef:851e with SMTP id h8-20020a170906828800b0093344ef851emr16333902ejx.55.1679987943119;
        Tue, 28 Mar 2023 00:19:03 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6? ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id zc14-20020a170906988e00b00927f6c799e6sm15053068ejb.132.2023.03.28.00.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 00:19:02 -0700 (PDT)
Message-ID: <8779217b-bd70-37a4-c779-139690048d4d@linaro.org>
Date:   Tue, 28 Mar 2023 09:19:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next] devfreq: exynos-ppmu: Use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, alim.akhtar@samsung.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230328053853.23159-1-yang.lee@linux.alibaba.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328053853.23159-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/03/2023 07:38, Yang Li wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert

I don't understand why do you reference this commit. There is no bug
introduced there, there is nothing related to this driver.

> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.


Best regards,
Krzysztof

