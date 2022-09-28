Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF245ED801
	for <lists+linux-pm@lfdr.de>; Wed, 28 Sep 2022 10:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbiI1Iim (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Sep 2022 04:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiI1IiC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Sep 2022 04:38:02 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE9BA3D46
        for <linux-pm@vger.kernel.org>; Wed, 28 Sep 2022 01:37:53 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id g20so13539262ljg.7
        for <linux-pm@vger.kernel.org>; Wed, 28 Sep 2022 01:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=62Eoklyt/D9YICCu7HqYVZqvNE1CJufCEW7h9Tv64so=;
        b=vkpzReO0KQzEk/YOvT5M1oXJQW9u+9JQ+eEqmpGzLdU2fmYY+yW3eHLRVtQMjhDRdn
         V6wt3ZR5FeGO+6TimfqDyyuKw0pIqrDhFXggf4SMgwqPoVLvAJVGVKX8KF5mLY5+FpUz
         bP5f4IsKnBn8XTa2aPh3FdR8tE5RmllT7rS7iSc4akCTGzZIaDpjZ/JjucVv3J6pheIF
         ELVJWnwzQAnVIbV5fr01Z0oldpNikPywadH+gPBOTP0Hr+F/ZY0gAWhSOyA1wduNa7tR
         1sQsy74ff9fm6FhRG+a2pIZop1XVDZq0RFyn2Xpo56mhyrfbIBf/Ig/M3PioDg2G9hHj
         sv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=62Eoklyt/D9YICCu7HqYVZqvNE1CJufCEW7h9Tv64so=;
        b=QKLtl7t+eKsjUfC7Tvx9WnBWHIrIZs5aRv1x7SyunMy8NbB49+4J2gVr+Uwu4FL0Z7
         rA8U3WuolvpjqpJ0cI4IFZeQPvAxIveHPoy4Xp3sypNuYbB0cAB0ZUTG+96USiqdwF34
         JEYahTvrRSsHRaeZPXqhxz/9SfFjynEQL452XzqbnlkW+A4uQhiqJPkh6uxdof0FVWgk
         8BDSRdkDQh3UL0xiL2t4n0hXbe6xuSfWSgGhSRiELa23qtpA0PzBOiGbP+9fVVqaqgax
         2RwGQfdtrt7N1v8BtJ5FyVMoRQWmHhKw6CvWohxH4dTl/+0Uj0k9w5Di0JJnlxh5JqLY
         axwg==
X-Gm-Message-State: ACrzQf1K2+ri5qa+KJktOTrFybtOhQ1rTF0DB9scYr5RpNnyEMbppwl0
        nkwCQIPVLxXTZs7ZDuTYKVK6eA==
X-Google-Smtp-Source: AMsMyM7KmT+Blx4/udVJvmQmTtAk3QqtyL9qew6LvYoEkmqaGbUMoY64pgryHZ1fIouAZZ1S64YKKA==
X-Received: by 2002:a2e:bc11:0:b0:26c:565:12f6 with SMTP id b17-20020a2ebc11000000b0026c056512f6mr10948162ljf.91.1664354271840;
        Wed, 28 Sep 2022 01:37:51 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 23-20020a2e0917000000b0026c35c4720esm375585ljj.24.2022.09.28.01.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 01:37:50 -0700 (PDT)
Message-ID: <066b55cf-4a28-89a2-56ab-572590c97c30@linaro.org>
Date:   Wed, 28 Sep 2022 10:37:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5 2/3] dt-bindings: thermal: add loongson2k thermal
 binding
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
References: <20220928083702.17309-1-zhuyinbo@loongson.cn>
 <20220928083702.17309-2-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928083702.17309-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/09/2022 10:37, Yinbo Zhu wrote:
> Add the loongson2k thermal binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

