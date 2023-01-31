Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EF5683199
	for <lists+linux-pm@lfdr.de>; Tue, 31 Jan 2023 16:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjAaPgO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Jan 2023 10:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjAaPgN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2023 10:36:13 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0A94C6F8
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 07:36:08 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h12so14575100wrv.10
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 07:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4He1XsPyOlYucKqUu+Gkem7+0XnZThvYXyNg8w0n1J0=;
        b=FXYxuL+bEVPsdk0pKfFMkVrGNHdxbaWQGjA6GMmUQtujuicg4G9YLycFKwywYU04GY
         +vxdNP0O61f5kufbMCbHTcNQ7EuLrsZz12p29ZwMZMQC4hmPM8forOsvM8DcZH9rOqWC
         CYqa1bbaFOycwWWIXtZonbkQMKAa8AyMJiiZkRlnLzS6yQUbKIYQxLSVZ2rfol6eouze
         Oz6i50OwSkVkaTVRNqRV9xUd+OmeaK0gvyid5QPOUhjcRVFz1B0je3S4APWEHX5mLPQv
         FfpzpJj/rxbhTXxA4ZsrWvixR24y1xMe6gQKJcs/KumGvVKokDmmB1DRVI+Qpm1PPUO7
         zANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4He1XsPyOlYucKqUu+Gkem7+0XnZThvYXyNg8w0n1J0=;
        b=D2OXCF8za4Bcich+V2nnam6wCzuc2SlXECGO+gA3d30+hXZhWMmhiKCazoD4+mT9nu
         gngIGTx+Ms+SuLKfzJ16JcjYHyLt5JQUAoPeXk1IaUnTsbkjHutaQEtmQQUc3zJ35/oE
         N2RC/LvWlwQwY+FQutF6dcvFKUPTqhVrWbknhHtT24gY+RmbWX7RdU9tfNEZt0gRaeQz
         4BqWK9QcUdhwzjvEm8Zyfa9jqjItMm35Yp3oDILQGI1HjckMD6vJDDahrqc+hBpM4xmH
         d4x4wXrmUj7D4x7OjaOQvm2XCpY3MVcrzn9yffN1JDYJmBN005q0gbABqwD4PQcqHHXz
         Kigg==
X-Gm-Message-State: AFqh2ko5mapSGrb5dQiH83WD1LrrkWZSvOKIDw4NkDGlV9UuZ7tXSmH6
        QFo4j8zYT63NLIySM1/M1p1UUg==
X-Google-Smtp-Source: AMrXdXv6BQjgkDK9X3LVit0UZaU80yr2mOlMCeXEk4wJ8iH+3bhvZ9pxQUPZ2tEWvPXsTjR/SWwGeg==
X-Received: by 2002:a5d:46c2:0:b0:2bf:9468:340 with SMTP id g2-20020a5d46c2000000b002bf94680340mr33831907wrs.19.1675179367303;
        Tue, 31 Jan 2023 07:36:07 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z2-20020a5d6542000000b00267bcb1bbe5sm14991191wrv.56.2023.01.31.07.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 07:36:06 -0800 (PST)
Message-ID: <c3a142c5-aac5-5d0a-72fa-3b444a2fa202@linaro.org>
Date:   Tue, 31 Jan 2023 16:36:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/4] thermal: intel: int340x: Assorted minor cleanups
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <2133431.irdbgypaU6@kreacher> <3220135.44csPzL39Z@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3220135.44csPzL39Z@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/01/2023 19:42, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Improve some inconsistent usage of white space in int340x_thermal_zone.c,
> fix up one coding style issue in it (missing braces around an else
> branch of a conditional) and while at it replace a !ACPI_FAILURE()
> check with an equivalent ACPI_SUCCESS() one.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

