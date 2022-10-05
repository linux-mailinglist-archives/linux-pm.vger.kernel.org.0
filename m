Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5B85F4FF7
	for <lists+linux-pm@lfdr.de>; Wed,  5 Oct 2022 08:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJEG63 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Oct 2022 02:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJEG62 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Oct 2022 02:58:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F3B72861
        for <linux-pm@vger.kernel.org>; Tue,  4 Oct 2022 23:58:26 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so512388wmq.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Oct 2022 23:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GpP+Iv5ntzm3FcCk+wh0TfpH7Et4pliZwGveGuXYCfE=;
        b=fExXWoyWE51Zo3b02X43ecerK4SDU9i8ILE6/42Wy0/ejD5K+d6/wDIzVHeL568yTE
         VsWNZk99ElG9W9lLA+URACEwnmSBjvIWQl85FXc3N1j704KIdLxcV9CsQfZtWrNRQfzg
         lpYgno1hXWe/xuvNvurfNMxp8jJte/2tpMIJlcaEToAy4km4XvvzQWnSlDQV3mrE7d81
         RXzoL/PTJ8g4z8VBJQVxjDvO1wd/esTkJ8qu94PIAfz7ctT81ld7tDYCJKuQjxfr1nCc
         gjoCgNkYGyaGunMqQVVJlncF36BTBA68SKKjudQCTp090udFeLPhLaC19ILlTHuH2dDc
         Ol4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GpP+Iv5ntzm3FcCk+wh0TfpH7Et4pliZwGveGuXYCfE=;
        b=ubXAU1h4dSgvBK1KLDMsbz0rZcfx2mR60V9s9e3rNAlEUAoGtRS01kbgoDjaSckfeL
         2T3xb4x90pJLo7lBmjFmb9oMdXWzK/tb9PWnydyG70tCHp9mPzA8QsDWIlzSxILVH4La
         QPuUl7yzUB7nk/Y8yisnFvVXWNROTbKPG5fEp8PpXoB36u9z/+lH9pTML4o6KgZ569D0
         FX99yxbBTdrkGwWrvd8dQftlKuHrwfiWR1Oi0Wv5seGqKMfBys598WD6yudpXQGTMQHg
         pMXTSNc3XMyf51v16yZUxMbmKTJmqUtIq2qZHrhEE5BL84ag6CMi/FczZuQOfD7D9sCo
         yeMw==
X-Gm-Message-State: ACrzQf30bIRy5/S4btaBFQ1gfD5yHMFdFhfOv8olROXCeyDPXfRnX6/r
        r2vY9tbDJZLYYL0dcBOruhgEeg==
X-Google-Smtp-Source: AMsMyM54FdxuY2C3Z9b54QiWHETFd8Cb1sd6ephIRME0+aAg9POuSvO9bGK4KVrJsxwfzf/NPDUiuA==
X-Received: by 2002:a05:600c:2241:b0:3b4:88aa:dcba with SMTP id a1-20020a05600c224100b003b488aadcbamr2225395wmm.203.1664953105244;
        Tue, 04 Oct 2022 23:58:25 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ffcf:b5a4:bbee:42a5? ([2a05:6e02:1041:c10:ffcf:b5a4:bbee:42a5])
        by smtp.googlemail.com with ESMTPSA id m21-20020a05600c4f5500b003b48dac344esm1043721wmq.43.2022.10.04.23.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 23:58:24 -0700 (PDT)
Message-ID: <c2b8085c-fd5f-0ef8-5343-4fed77c3e5a2@linaro.org>
Date:   Wed, 5 Oct 2022 08:58:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/3] ACPI: thermal: Use white space more consistently
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <12068304.O9o76ZdvQC@kreacher> <4774295.31r3eYUQgx@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4774295.31r3eYUQgx@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/10/2022 18:31, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The usage of white space in the ACPI thermal driver is not very
> consistent, so improve that a bit.
> 
> While at it, add missing braces to if()/else in a few places.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
