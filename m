Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934A0778208
	for <lists+linux-pm@lfdr.de>; Thu, 10 Aug 2023 22:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbjHJUUx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Aug 2023 16:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbjHJUUx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2023 16:20:53 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499DA272D
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 13:20:51 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b962c226ceso21195341fa.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 13:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691698849; x=1692303649;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iylCfLaU0WQeliCWu5KpopM/+sElU6AE+n+9QM8qgEw=;
        b=ep8hRVZdMzqruJheKzUHAmze1qyUq+zqpuYl+uMRbps5KlZNVCXqd9nh19kPvO9smP
         kR2BCwXmlS4AXHmMwMKR0ornVlXjGEMMonwWDqaOKGqcE+C/OtYPu8bUvWjFsYRKN7Wa
         YAdvgEE0JTvuZvGNYChHrsYhwXNbD1lbKNXORbJ8+7y+244BHYizxE+hcPBj2p1QpVN4
         8B+VoN0OlCzcX38N2a6WuLmB5uXhny0Byp9wt5+oSHHIFFaix+1G5DfbSl43rKwcRirI
         E4HmRq4fHr7taAE90tnNZAQsCesR7QSHpYp7f2kDNNUvZEeJUO5TAipYPGH8Np6eCpqw
         HNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691698849; x=1692303649;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iylCfLaU0WQeliCWu5KpopM/+sElU6AE+n+9QM8qgEw=;
        b=cJ3o9YovU8N7f5rGSkYWnx3Zp9kgSpxh0dSd98S3puQFeqpBjren2B0pJdt6em8njk
         jVXl5KYye+Yrens7fxH6n3Jv4EBEtNqnwpuszZIAtlY08x3sPz/eTRRkOG+4LS5fD+sT
         zEBYLatO67VLt6Na1UnyjULZmv6Srica+7XLuiBc8j4wprXESYl35/ul88xkia06fxPf
         yUVjIC1tYzk96wUnUdsV+gMjXkW3eSXcSHchtwIUdKR5NcJeoVIXm/M+BB0ZqUu3qK6E
         bJsy/J8a45ZlLmVkOmmA/zKkCQ6A2rZMuMozaFxoBVeVqcWo1PsvM298knCKyaF4Yier
         t6SA==
X-Gm-Message-State: AOJu0YwJfApOl6JQNkINLbKTMVhFWlV6IYdjU2hEDYAovPEjjJVFyJ4p
        Wi65KzmwxLC43soN/yLhRRjrrii95a//oMtdWzA=
X-Google-Smtp-Source: AGHT+IGFsVQ+aLTQvgk+3yiiMebqGId5YXGFOUQf3/d82qwOQz63Laj76O1e/ilgzea4em0jwG/dgQ==
X-Received: by 2002:a2e:a316:0:b0:2b9:b067:9554 with SMTP id l22-20020a2ea316000000b002b9b0679554mr69177lje.2.1691698849331;
        Thu, 10 Aug 2023 13:20:49 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id a23-20020a2eb177000000b002b9f0b25ff6sm510087ljm.4.2023.08.10.13.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 13:20:48 -0700 (PDT)
Message-ID: <590c091c-7fbe-4169-b5cc-0e98de96d883@linaro.org>
Date:   Thu, 10 Aug 2023 22:20:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sdm670: add frequency profile
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230802011548.387519-6-mailingradian@gmail.com>
 <20230802011548.387519-10-mailingradian@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230802011548.387519-10-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2.08.2023 03:15, Richard Acayan wrote:
> Add the coefficients for the CPU frequencies to aid in frequency
> scaling.
> 
> Profiling setup:
>  - freqbench (https://github.com/kdrag0n/freqbench)
>  - LineageOS kernel, android_kernel_google_msm-4.9
>  - recommended configuration options by freqbench
>  - disabled options that require clang or 32-bit compilers
>  - mmc governor switched from simple_ondemand to powersave
> 
>     Frequency domains: cpu1 cpu6
>     Offline CPUs: cpu1 cpu2 cpu3 cpu4 cpu5 cpu6 cpu7
>     Sampling power every 1000 ms
>     Baseline power usage: 445 mW
> 
>     ===== CPU 1 =====
>     Frequencies: 300 576 748 998 1209 1324 1516 1612 1708
> 
>      300:  1114     3.7 C/MHz     43 mW   11.6 J   25.8 I/mJ   269.4 s
>      576:  2138     3.7 C/MHz     51 mW    7.1 J   42.2 I/mJ   140.3 s
>      748:  2780     3.7 C/MHz     67 mW    7.3 J   41.3 I/mJ   107.9 s
>      998:  3706     3.7 C/MHz     73 mW    5.9 J   51.1 I/mJ    80.9 s
>     1209:  4490     3.7 C/MHz     86 mW    5.7 J   52.2 I/mJ    66.8 s
>     1324:  4918     3.7 C/MHz     90 mW    5.5 J   54.6 I/mJ    61.0 s
>     1516:  5631     3.7 C/MHz    103 mW    5.5 J   54.9 I/mJ    53.3 s
>     1612:  5987     3.7 C/MHz    109 mW    5.5 J   55.0 I/mJ    50.1 s
>     1708:  6344     3.7 C/MHz    126 mW    5.9 J   50.5 I/mJ    47.3 s
> 
>     ===== CPU 6 =====
>     Frequencies: 300 652 825 979 1132 1363 1536 1747 1843 1996
> 
>      300:  1868     6.2 C/MHz     53 mW    8.5 J   35.2 I/mJ   160.6 s
>      652:  4073     6.2 C/MHz     96 mW    7.1 J   42.4 I/mJ    73.7 s
>      825:  5132     6.2 C/MHz    117 mW    6.9 J   43.7 I/mJ    58.5 s
>      979:  6099     6.2 C/MHz    151 mW    7.4 J   40.4 I/mJ    49.2 s
>     1132:  7071     6.2 C/MHz    207 mW    8.8 J   34.1 I/mJ    42.4 s
>     1363:  8482     6.2 C/MHz    235 mW    8.3 J   36.1 I/mJ    35.4 s
>     1536:  9578     6.2 C/MHz    287 mW    9.0 J   33.3 I/mJ    31.3 s
>     1747: 10892     6.2 C/MHz    340 mW    9.4 J   32.0 I/mJ    27.6 s
>     1843: 11471     6.2 C/MHz    368 mW    9.6 J   31.1 I/mJ    26.2 s
>     1996: 12425     6.2 C/MHz    438 mW   10.6 J   28.3 I/mJ    24.2 s
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
I've looked into this a bit and upstream handling of dynamic power seems
broken on qcom.. Trying to resolve this

Konrad
