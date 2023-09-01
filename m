Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F09478FA70
	for <lists+linux-pm@lfdr.de>; Fri,  1 Sep 2023 11:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbjIAJG6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Sep 2023 05:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjIAJG5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Sep 2023 05:06:57 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E866291
        for <linux-pm@vger.kernel.org>; Fri,  1 Sep 2023 02:06:54 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so2251757a12.2
        for <linux-pm@vger.kernel.org>; Fri, 01 Sep 2023 02:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693559213; x=1694164013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CL2wZFAQ9DQMYKYYGQQIGah4zjC0ig67LMgG+Wt4f1Y=;
        b=d3G7fIe8UBMa7gt6/G7qj29NWsPBatVgzGJzXHP5l++Wu7/0gRZ6rlj+4bu1BjP1Gy
         2fsbLHcMS4FApmD3M+FlTyxu8yaT2tGgMeBkNB7Y6qWeu3JBxO+gdkU6f4IlJnRhsNkn
         MKGFthxQR6deD59S+crpEVayayBlLW6yhYnGDGn/kQytn2MAG4HsApgD7T/l5929dpRf
         9qYs/CHgS/2XPzcQ1oePIOvFNb359qW0DgA41wvFLUtjD23WPC/1WpYd8Aahvu3m1TNZ
         dcxp83oal8lV67e9uf0WHHYDNqYoOQ/NeaO7hq49ODb6XdquByGEXvQN7FypXLeOSnID
         t1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693559213; x=1694164013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CL2wZFAQ9DQMYKYYGQQIGah4zjC0ig67LMgG+Wt4f1Y=;
        b=Q9SSU7IVxgz8txMyjAavN2Gob2s6h1gAuwxZ/VKGFBrPdoez5hes1M2pEowPeCigbF
         A4xO5PycHB2XB4AEp6PjvVkD9t1ZHe2DWBWYlXIJWjiXTf+tU+ANAbNfJCI+Do/uLdFX
         35RSGH6FBP1ylz/UhnVbOMFqcZwY+2S+UM8Mpfl2LCZR8yUk8/IGStKYBHNFE1WCi3fP
         +TPsJSgc8xY2ab7SnYk9gmhHCYj9pzDebXNMumJ1HYtyj9/YMLEvZELD6IzK0OxfKP1M
         pyt1b4I/v3Lz1CklrY16cJY4q4EXNSWOCt7IX6Gc3pzGyOV2bRSsHHoEnJ/105fBww1b
         X57w==
X-Gm-Message-State: AOJu0YwARs0SKuhXmmUybhra9HC7SF318Mh7gmDaevVaNxFw4v5oDVnv
        X7m7QGmw+dpASXkBouuxhGZybQ==
X-Google-Smtp-Source: AGHT+IFgycuMFi2b9nbCWqWNuNSEcE07Zi45QXIvtjzYup3K8uPK4QvdgSYexfoBzJlc6i5xrD3o3g==
X-Received: by 2002:a17:907:75fa:b0:9a5:7ade:b5e8 with SMTP id jz26-20020a17090775fa00b009a57adeb5e8mr1170613ejc.10.1693559213457;
        Fri, 01 Sep 2023 02:06:53 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906248700b009920a690cd9sm1727779ejb.59.2023.09.01.02.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 02:06:52 -0700 (PDT)
Message-ID: <cfa55813-946e-7aad-b7a4-54450a1ea5d5@linaro.org>
Date:   Fri, 1 Sep 2023 11:06:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 4/5] dt-bindings: soc: loongson,ls2k-pmc: Allow
 syscon-reboot/syscon-poweroff as child
To:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, soc@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
References: <cover.1693474728.git.zhoubinbin@loongson.cn>
 <38e811816c37a2d52374fa04864654ff1e9b4dc8.1693474728.git.zhoubinbin@loongson.cn>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <38e811816c37a2d52374fa04864654ff1e9b4dc8.1693474728.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31/08/2023 13:43, Binbin Zhou wrote:
>  required:
>    - compatible
>    - reg
> @@ -54,4 +66,18 @@ examples:
>          interrupt-parent = <&liointc1>;
>          interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
>          loongson,suspend-address = <0x0 0x1c000500>;
> +
> +        syscon-reboot {
> +            compatible = "syscon-reboot";
> +            offset = <0x30>;
> +            mask = <0x1>;
> +        };
> +
> +        syscon-poweroff {
> +            compatible = "syscon-poweroff";
> +            regmap = <&pmc>;

???

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Best regards,
Krzysztof

