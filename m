Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C3978B665
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 19:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjH1R0w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 13:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbjH1R0X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 13:26:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86148CD6
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 10:25:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so447233166b.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 10:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693243551; x=1693848351;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HIxfCT/5MYZNQQezDrzEbmaORh20hf3gUXKEbNNcX3E=;
        b=yAsdxR91RmH2zwGcS3/YDGi08dh2DHGjxe6Hyz+Ao/RpkAjMO9eG2hsCQhx64Qq0Yq
         zIkBbpMkIFIP2rSfm43XVjlX5VQk8nlJw+jWmwCB9hjNBU6CUyL+1Yxv84iD48DexD55
         RNjrgCOkQGfPAyWwk2pF0YaVr0GarxMLbmX23BO/10ubENsOH4AwkJhQC7iGTl4AiXbM
         9Wuuo/J/pDcpd5Hg30ulVBTnzFlHMHaKG2S6o6T/oeOPqpX78wcmRhb8lKx4TBmvf6cx
         T9VmjScHem2ZCf74OPBHBqyLO7fJgAnOkF94CtvQtERcdz3tww48drAKQJw7aIYWM7nJ
         S2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693243551; x=1693848351;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIxfCT/5MYZNQQezDrzEbmaORh20hf3gUXKEbNNcX3E=;
        b=MT0c1PxrJUSVGNBSYLc2jMSg2+ctSOnJjdlaL/fX/IU3JmsfkCvu+lNaX7ppn9xHj3
         BK6Ht7URb2Tq7TcfRutABZ0CZEyeo8yIPuq/19p2e3vcU0JekrgxQM4T1KG29koqcd+l
         TNNf0i87J43UNh3wUf6BF1B1Tvis5oJR/LxQ+HbAw8cNy2QOBoWz+zDFoyvDMrRoL4gY
         VSoZgDIr+fSDspNm2xGqnHGw7J5jIj5AEtHu1I7szog/HLO3R1CPKLDXSW/AanHyrKAw
         ryxEEBqjga/kThEyXO9WbnaQYSr/ucJe9oR5TlL7efGtzRecxfknWXLPH8Xpe6trcplj
         YJ6A==
X-Gm-Message-State: AOJu0YyubYxYUgwczvMCjA8MEDl5h2j8EfremEMydmkfh2bzUzfdI7MA
        XT/86G+eVelUOTJZu/0bIyeAVg==
X-Google-Smtp-Source: AGHT+IHUIvm/eBS/tZHWMulmOQXLPCC/0LclTYRepRFuchAYahYwH5f1d551ROPQJ7xO6EccyZS/WQ==
X-Received: by 2002:a17:907:75c5:b0:9a2:1e14:86bd with SMTP id jl5-20020a17090775c500b009a21e1486bdmr8994196ejc.65.1693243551037;
        Mon, 28 Aug 2023 10:25:51 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id i27-20020a1709063c5b00b009a1c05bd672sm4892895ejg.127.2023.08.28.10.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 10:25:50 -0700 (PDT)
Message-ID: <5358e28f-8fee-a332-b175-9ad146dd8afa@linaro.org>
Date:   Mon, 28 Aug 2023 19:25:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/5] soc: loongson: loongson_pm2: add dependency for INPUT
Content-Language: en-US
To:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>
References: <cover.1693218539.git.zhoubinbin@loongson.cn>
 <08447374271c7df6d1543abce69195f1ae09f59c.1693218539.git.zhoubinbin@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <08447374271c7df6d1543abce69195f1ae09f59c.1693218539.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/08/2023 14:38, Binbin Zhou wrote:
> Since commit 67694c076bd7 ("soc: loongson2_pm: add power management
> support"), the Loongson-2K PM driver was added, but it didn't update the
> Kconfig entry for the INPUT dependency, leading to build errors, so
> update the Kconfig entry to depend on INPUT.
> 
> /opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `loongson2_power_button_init':
> /work/lnx/next/linux-next-20230825/LOONG64/../drivers/soc/loongson/loongson2_pm.c:101:(.text+0x350): undefined reference to `input_allocate_device'
> /opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: /work/lnx/next/linux-next-20230825/LOONG64/../drivers/soc/loongson/loongson2_pm.c:109:(.text+0x3dc): undefined reference to `input_set_capability'
> /opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: /work/lnx/next/linux-next-20230825/LOONG64/../drivers/soc/loongson/loongson2_pm.c:111:(.text+0x3e4): undefined reference to `input_register_device'
> /opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: /work/lnx/next/linux-next-20230825/LOONG64/../drivers/soc/loongson/loongson2_pm.c:125:(.text+0x3fc): undefined reference to `input_free_device'
> /opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `input_report_key':
> /work/lnx/next/linux-next-20230825/LOONG64/../include/linux/input.h:425:(.text+0x58c): undefined reference to `input_event'
> /opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `input_sync':
> /work/lnx/next/linux-next-20230825/LOONG64/../include/linux/input.h:450:(.text+0x5a0): undefined reference to `input_event'
> /opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `input_report_key':
> /work/lnx/next/linux-next-20230825/LOONG64/../include/linux/input.h:425:(.text+0x5b4): undefined reference to `input_event'
> /opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `input_sync':
> /work/lnx/next/linux-next-20230825/LOONG64/../include/linux/input.h:450:(.text+0x5c8): undefined reference to `input_event'

Trim unrelated parts of path and trim logs to show only one warning, not
everything.

Best regards,
Krzysztof

