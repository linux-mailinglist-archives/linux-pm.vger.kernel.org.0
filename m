Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05396CBBE8
	for <lists+linux-pm@lfdr.de>; Tue, 28 Mar 2023 12:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjC1KHZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Mar 2023 06:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjC1KHP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Mar 2023 06:07:15 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8105876BE
        for <linux-pm@vger.kernel.org>; Tue, 28 Mar 2023 03:07:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eg48so47193906edb.13
        for <linux-pm@vger.kernel.org>; Tue, 28 Mar 2023 03:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679998020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ZPljhKeSnuSGlSWfKaLNDMSdJrVY6lMlRIxToWIHSE=;
        b=vgTGHg8fA3BZsk9LUPzWlrSQZGnASPGPFuZqfImemSFhHCJj5lrtNpJl1qhJaeaYPE
         leDREJVTlbajzM8RI1c/JJjEonQftsvxksAxwpBnCXhjUjMQyZCY4O7SkHN3OBwzks9Q
         bSr5gSOwPFoaT1eeMkd5r80jXAD5DRr7hRbPRW9rD8V9QLlHdLS6qaVN7LXketIv2oGr
         aUCy2skJ6KxoLOyx9EuzZc6uSN/bxCuCJjKG7VExpH/QuwU/f09lG+YfT/ojSHZl4qh5
         XyE2kG1yPMFqjfQgNc0IQHuEDp6GG1mNDOzZOWLy0yK0OsdVuG6AogQkCxaEJ5VYdtiH
         4Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679998020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZPljhKeSnuSGlSWfKaLNDMSdJrVY6lMlRIxToWIHSE=;
        b=ehOYG5yLgwnjT4fWSfkfuoDuboCOHIf+p4JvWVuEM0xTqCjEUdHSJ2fiZVBHVoNxqV
         CGiIpPgAdmONcbyVYkkfnUlXktzH/qEpIXynBNRpZcc17UL+/zbRYPAzaxilRooWXMmq
         /Gthq9B1S/geNXxLBHdDWAEAo8EEL8ZNcHu2KconwFXV1/n+HvcHQRYZdXYJ+bmJScGj
         LXqycryhVSlpnuEjYsyINKDndEhPF28ClN8uL0VgPzUx642aax1QzYoKD4yKHm/pl+It
         DuCRLnqmI6eVSiedaXms0M1QAVs8Xr1ABZ8D6G7kPg7PX/Ru6wr9ZRP/MWI0pR6/FAUO
         vLWw==
X-Gm-Message-State: AAQBX9dWxiODcKYngFo1PvsudjxJRv36Qe7FNUtuaFFdux4yMc4j9+87
        V2iOcrNLOzkFe4JnemhMm4aaBVGsns4+pvxonI4=
X-Google-Smtp-Source: AKy350ZFYyOvQbIZ2wc5ylrWhyV44C9OKuB3cjIa2tHpjn0Dm3C5pFk/kZSkKlTmHvKCSly/UXuydw==
X-Received: by 2002:a17:906:9244:b0:939:4c86:d492 with SMTP id c4-20020a170906924400b009394c86d492mr14400048ejx.5.1679998019965;
        Tue, 28 Mar 2023 03:06:59 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6? ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id u7-20020a170906b10700b0092f38a6d082sm15071729ejy.209.2023.03.28.03.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 03:06:59 -0700 (PDT)
Message-ID: <81fad553-e8c1-f387-4df2-70c91a6ebc33@linaro.org>
Date:   Tue, 28 Mar 2023 12:06:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next] devfreq: exynos-ppmu: Use
 devm_platform_get_and_ioremap_resource()
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Yang Li <yang.lee@linux.alibaba.com>, kyungmin.park@samsung.com,
        myungjoo.ham@samsung.com, cw00.choi@samsung.com,
        alim.akhtar@samsung.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230328053853.23159-1-yang.lee@linux.alibaba.com>
 <8779217b-bd70-37a4-c779-139690048d4d@linaro.org>
 <20230328095337.sr6s3klmhiyz63pr@intel.intel>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328095337.sr6s3klmhiyz63pr@intel.intel>
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

On 28/03/2023 11:53, Andi Shyti wrote:
> Hi,
> 
> On Tue, Mar 28, 2023 at 09:19:01AM +0200, Krzysztof Kozlowski wrote:
>> On 28/03/2023 07:38, Yang Li wrote:
>>> According to commit 890cc39a8799 ("drivers: provide
>>> devm_platform_get_and_ioremap_resource()"), convert
>>
>> I don't understand why do you reference this commit. There is no bug
>> introduced there, there is nothing related to this driver.
>>
>>> platform_get_resource(), devm_ioremap_resource() to a single
>>> call to devm_platform_get_and_ioremap_resource(), as this is exactly
>>> what this function does.
> 
> I've seen Yang has sent many of these cleanups, perhaps he can
> write something like:
> 
> "
> Commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()") introduces the
> devm_platform_get_and_ioremap_resource() function which combines
> both platform_get_resource() and devm_ioremap_resource() into a
> single call.

I don't think we need to reference that commit at all. It does not
matter when the API was introduced and just makes commit msg unnecessary
long. Instead the commit msg should shortly say why this change is
needed or even worth accepting.

> 
> Update the code to use the new combined function instead of the
> separate calls.

Best regards,
Krzysztof

