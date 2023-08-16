Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F097277E1D9
	for <lists+linux-pm@lfdr.de>; Wed, 16 Aug 2023 14:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244142AbjHPMqw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Aug 2023 08:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245321AbjHPMqk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 08:46:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF482708
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 05:46:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31768ce2e81so5726745f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 05:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692189996; x=1692794796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6KDBeOZQrkaTjxPwBCtEwguBc9sQAcZzICpLFmLiK4=;
        b=g2jUNLROrFTBTTK2QZDNP/TBk3AOUhdC52QhbDV44ElvGbnFwI6Z4bvXlF9bxFF4Ts
         g8X3oHUtzKGTXWIoW3lkYglPG2eKr3/ThXbWCMzeW5Wc+SOus2lZSH517RwzjQpHY4vl
         hGA17geaiiHjzn+tKyXRt+0rAb6ghPOZBM3R2WyO5WLdmaD9E7EjYEdUrjmWU9fsYLaq
         wwpywz+ay/Dj7wl/LcxMsl9u9oODKeq8UCo0fpMjQpe/Xw4kZc3ui8obWlpjatuqq8ni
         Gs0ZfEyTVSE4Hbiqpw2odb0Z7D3gekjA549E6gV7tboNPASy/hxhOeuaXVfYqfB2smXN
         0zSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692189996; x=1692794796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6KDBeOZQrkaTjxPwBCtEwguBc9sQAcZzICpLFmLiK4=;
        b=ORv2kc/WITIvlXtEmWsy+fWVoQ4P1P1/kCZwyhyIUxYO1ePnvRTLuoJpkCxeBathYn
         +gMsnwjPiRxdW2TneOGqZ99DVzoQJVTKgilAwuhbiesZWiJ/HL6NiCypizim/a9+Dcqs
         bX+1xxxvcLmo3N4MOOGFqZ8p9ihtYZNoO8TUmZHQl4r2ZXOQC5wYwfR+UI5FAcdG0i8G
         g9HCbEkaqek+yDt4oc58yK/tDpLj2H8gS1/LUXSXTrk0lTAqnq4JSOmzg7fOajlsIRzE
         HJ0jDJ7ex4SgKy2U9uHMV/98ZXZkiLdnGCM6eXylmj8mmHGIZMYbz3C5H9uMKfDkBVIY
         irjA==
X-Gm-Message-State: AOJu0YyKQ6BqndUXGRqke3Y4PHCjyPXSeOUkIIhO3OESMlk+LdytnXqD
        cM0/0na9MlpQIhoDQxF5fzq3eQ==
X-Google-Smtp-Source: AGHT+IFuL7fyxjBeu6kqloW0l/lvxoHCSe4utcFUCa7ZnImaiB3rZUL/dq9gtO1QbbcPYY8UNV6d5Q==
X-Received: by 2002:adf:ec43:0:b0:317:3b13:94c3 with SMTP id w3-20020adfec43000000b003173b1394c3mr1488315wrn.41.1692189995944;
        Wed, 16 Aug 2023 05:46:35 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id m9-20020a7bce09000000b003fe2120ad0bsm24011542wmc.41.2023.08.16.05.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 05:46:35 -0700 (PDT)
Message-ID: <da3e6348-33e0-aaa9-8f86-4b1ba1504551@linaro.org>
Date:   Wed, 16 Aug 2023 14:46:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v15 1/2] thermal: loongson-2: add thermal management
 support
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn,
        zhanghongchen <zhanghongchen@loongson.cn>
References: <20230620012944.28877-1-zhuyinbo@loongson.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230620012944.28877-1-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/06/2023 03:29, Yinbo Zhu wrote:
> This patch adds the support for Loongson-2 thermal sensor controller,
> which can support maximum four sensor selectors that corresponding to four
> sets of thermal control registers and one set of sampling register. The
> sensor selector can selector a speific thermal sensor as temperature input.
> The sampling register is used to obtain the temperature in real time, the
> control register GATE field is used to set the threshold of high or low
> temperature, when the input temperature is higher than the high temperature
> threshold or lower than the low temperature threshold, an interrupt will
> occur.
> 
> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---

[ ... ]

> +	if (devm_thermal_add_hwmon_sysfs(dev, tzd))
> +		dev_warn(dev, "Failed to add hwmon sysfs attributes\n");

[ ... ]

This has been factored out by adding a message directly in 
devm_thermal_add_hwmon_sysfs(), so the test is not needed here neither 
the message.

However, these changes have been long enough on the mailing list and the 
result looks nice.

I can pick this patch and you provide a small patch on top. Or you send 
a V16 with this change. It is your call.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

