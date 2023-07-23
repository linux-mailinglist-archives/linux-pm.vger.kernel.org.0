Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA9775E100
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jul 2023 11:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjGWJkj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jul 2023 05:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGWJki (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jul 2023 05:40:38 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD8EE67
        for <linux-pm@vger.kernel.org>; Sun, 23 Jul 2023 02:40:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fdddf92b05so4667544e87.3
        for <linux-pm@vger.kernel.org>; Sun, 23 Jul 2023 02:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690105236; x=1690710036;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0LlZmT4tMDOB873i3zzQ26d5Y0kjAgWR/PhFUxBYLHA=;
        b=geiHVdXPhueRuZs/egiBJN1uroQUc2XUIobsjZKMrzW9eFIbwVLTk426g5wBfifL83
         VFPOhOSi+o7FAZUIV190+omtE39ueBbqgd3q8oM3acgpMsY6yYNlwxbyYlCtH9O/OcrD
         ra2WDkrTZnIjPt7+0CRaI8Zd1qZUxlQgc+KvrDjTfY7Hnqu8ox27MBe0374pXY9przvC
         vcom30p7z/UzdgLliiWsRRfqoI456l7SK59xvGEpuyxC4rQwZ1SZSm8ijTk7CrwCCaBe
         GEIxbn5WYglontvA0bcRsBxuLR+JuSgsvkAepEb1trywaC5bZbwtF5EL5zOZMjcetJDN
         GLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690105236; x=1690710036;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LlZmT4tMDOB873i3zzQ26d5Y0kjAgWR/PhFUxBYLHA=;
        b=cTHeEvMh1eNsRyV2auwB64sS9Itibj8DWc6C/1BqsB283+8qcdEffn+idh+TL3kRoI
         86nCcrd0wLsAdA7nE5U1NoSwpzZZVSn/OuFZqCCO7XiYYSeNYzO3N620WMwvAzFjMj0o
         414FBRzgjzmaFrqQ7dxpe1Y2Dz6ah8T6bQ92MY3WxyyRjPOOxPDUrONSM9PLSfoqvEiu
         FUG0CM3UJDnNZBfQk72dwNvPYylZ6cR0NthcHyCkjKrMk8tDNXZTPRECxBZ9da5JZkFk
         MWPlCrow4lZ5+Ki2+WGM0TFm7eGDiqa2DpYI15ERMYF3XRr9N+dtMN1fUCHwnTkHOE8i
         zg2Q==
X-Gm-Message-State: ABy/qLafaP4DJNwPW+TXPTU/ovOVhDYLiic9geV79axsB77iLBY6r73O
        pLYx9/SxP1B3GVr4JzmQQ5M6Rg==
X-Google-Smtp-Source: APBJJlFrWguwFhN5iKtC4ZiJPTAlNGKoD0rvT/DCYS0aE8fiB4TThWkJR3wuZ5V6xoWJSpIyCfFHTA==
X-Received: by 2002:a19:8c1c:0:b0:4f3:80a3:b40a with SMTP id o28-20020a198c1c000000b004f380a3b40amr3514230lfd.69.1690105235831;
        Sun, 23 Jul 2023 02:40:35 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id y16-20020a5d6150000000b00313e59cb371sm9253083wrt.12.2023.07.23.02.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 02:40:35 -0700 (PDT)
Message-ID: <17dc1961-c629-e09f-8979-1e6cbc92534e@linaro.org>
Date:   Sun, 23 Jul 2023 11:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] thermal/drivers/sun8i: Don't fail probe due to zone
 registration failure
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Icenowy Zheng <uwu@icenowy.me>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hugh Dickins <hughd@google.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230718-thermal-sun8i-registration-v1-1-c95b1b070340@kernel.org>
 <5a9ccb708f004e70e2102417eb48b766b03777cd.camel@icenowy.me>
 <ZLwH9RFnJymdy7YD@finisterre.sirena.org.uk>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ZLwH9RFnJymdy7YD@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Mark,

On 22/07/2023 18:46, Mark Brown wrote:
> On Sat, Jul 22, 2023 at 08:11:43PM +0800, Icenowy Zheng wrote:
>> 在 2023-07-18星期二的 16:04 +0100，Mark Brown写道：
> 
>>> Since we currently do not define any trip points for the GPU thermal
>>> zones on at least A64 or H5 this means that we have no thermal
>>> support
>>> on these platforms:
> 
>>> [    1.698703] thermal_sys: Failed to find 'trips' node
>>> [    1.698707] thermal_sys: Failed to find trip points for thermal-
>>> sensor id=1
> 
>> I think this is an issue in the core thermal subsystem, and sent a
>> patch; Unfortunately the patch seems to be rejected by linux-arm-kernel
>> (and some other mailing lists)...
> 
> It did seem to be a bit of an excessively strict requirement, I was
> going to poke at that myself.  It does seem worthwhile doing the change
> in the sun8i driver anyway, there might be some other issue that causes
> registration to fail which would have the same issue.

Why do you want a thermal zone if there is no trip point ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

