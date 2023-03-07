Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A268B6ADA2B
	for <lists+linux-pm@lfdr.de>; Tue,  7 Mar 2023 10:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjCGJVp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Mar 2023 04:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjCGJVo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2023 04:21:44 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6202F53727
        for <linux-pm@vger.kernel.org>; Tue,  7 Mar 2023 01:21:19 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x3so49475607edb.10
        for <linux-pm@vger.kernel.org>; Tue, 07 Mar 2023 01:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678180878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ImknzI3+zNXeJrlCA1icMSZ6b0iyjrhhLI3KblQlRyU=;
        b=O+VlgSxtnovXaHyjEVIV8KV4l+J3jKScOqh1e165d5VfDiFCAHHgiwejOdiNgeLx0m
         pa2FEhdQ1dzivAuXUTujmVmrR7WgoTvYBpfU5EF8AhbzxOIHNCMqNziQeQXlsG5BnCpB
         G1IWqJT4rySWpHTpwugW8CX3cwxhlaI4ihhEVfncQXuT5UFoynyXvSvUCQm7v3C0eKQY
         ekXmoIqiPNZrK2A6FMlDTCfC4GeYbTQedGx50meYT9O0RHoOmWB4AMVwwssOAyDQ7icI
         io9GYUHX4xQh8cUJmIR+Nm+DA5r3jBueMVmK39FdFF3jtjNVmG8KMGmemJ7SaPNa8Xx7
         s+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678180878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImknzI3+zNXeJrlCA1icMSZ6b0iyjrhhLI3KblQlRyU=;
        b=hqXt5/ZTDqNWrCJGxfO2NkAe4/GJdqBpJ2E9GG4rrRXf7+YgDQDDysOY8p41TVxtNd
         goxoGZjiXqC9jaZ3M2m6R+d/DBJqc1p62Cl4JouJHADPRv9t3HeMIA2YjKeZWQlv8AGp
         W4qP4fcFYxOJMV1RiDOoqQ4Wtn1ULF0Xe25wIC03PfFzlyjh0j6WyKpUb5sENMMRzc5E
         0rWhUGE13+wqzqDS0B7rOaRGFm1ngexZ7VmWesIYjQo9pLDlYGVc3N/hjbRIgjz2LtMD
         peMKlZdDJYi72oVn5D8shMvR4KuZbXUrGLMpTz06rPyhfXz/jd3x5ICNhr0mala5tRtA
         anqA==
X-Gm-Message-State: AO0yUKWFhs/S8flh/Xlbyy6bHUlbOPeGjyMJDbo7W6GFaqa6qgDOcQyR
        58aKkTYbWdnmkCMZVfuhtmwdrQ==
X-Google-Smtp-Source: AK7set/8q1Dpn1fKoXGTnw4DYza29NwMw6JpXmdx/lsPqm8Z5LVvZcCJ0RLSFQYk3xrmhvSUrtjLLA==
X-Received: by 2002:a17:906:ce34:b0:8e0:2887:8263 with SMTP id sd20-20020a170906ce3400b008e028878263mr13454388ejb.39.1678180877879;
        Tue, 07 Mar 2023 01:21:17 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:5310:35c7:6f9e:2cd3? ([2a02:810d:15c0:828:5310:35c7:6f9e:2cd3])
        by smtp.gmail.com with ESMTPSA id v7-20020a170906338700b008e51a1fd7bfsm5843951eja.172.2023.03.07.01.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 01:21:17 -0800 (PST)
Message-ID: <87271ce2-8db4-187f-4bb6-31a7ef687557@linaro.org>
Date:   Tue, 7 Mar 2023 10:21:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Patch v2 0/9] Tegra234 Memory interconnect support
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com, kw@linux.com,
        bhelgaas@google.com, vidyas@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
References: <20230220140559.28289-1-sumitg@nvidia.com>
 <c8cf2435-8b18-7af7-c751-267021142f5a@linaro.org>
 <22525720-9def-27de-cf41-8fd8165d6e01@linaro.org>
 <b1a98a10-cc8d-e2f1-f234-c4804763b6ab@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b1a98a10-cc8d-e2f1-f234-c4804763b6ab@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/03/2023 21:43, Sumit Gupta wrote:
> 
> 
> On 06/03/23 20:37, Krzysztof Kozlowski wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 06/03/2023 16:05, Krzysztof Kozlowski wrote:
>>> On 20/02/2023 15:05, Sumit Gupta wrote:
>>>> This patch series adds memory interconnect support for Tegra234 SoC.
>>>> It is used to dynamically scale DRAM Frequency as per the bandwidth
>>>> requests from different Memory Controller (MC) clients.
>>>> MC Clients use ICC Framework's icc_set_bw() api to dynamically request
>>>> for the DRAM bandwidth (BW). As per path, the request will be routed
>>>> from MC to the EMC driver. MC driver passes the request info like the
>>>> Client ID, type, and frequency request info to the BPMP-FW which will
>>>> set the final DRAM freq considering all exisiting requests.
>>>>
>>>> MC and EMC are the ICC providers. Nodes in path for a request will be:
>>>>       Client[1-n] -> MC -> EMC -> EMEM/DRAM
>>>>
>>>> The patch series also adds interconnect support in below client drivers:
>>>> 1) CPUFREQ driver for scaling bandwidth with CPU frequency. For that,
>>>>     added per cluster OPP table which will be used in the CPUFREQ driver
>>>>     by requesting the minimum BW respective to the given CPU frequency in
>>>>     the OPP table of given cluster.
>>>> 2) PCIE driver to request BW required for different modes.
>>>
>>> No dependencies or ordering written, so I am free to take memory
>>> controller bits, I assume.
>>
>> And not.. NAK, since you decided to ignore my comments. Really, we do
>> not have time for such useless ping pong.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Hi Krzysztof,
> 
> I tried to address the comments given during review of v1 in v2.
> I am sorry if in case I missed any suggestion. Please let me know so I 
> can incorporate that.
> 

I never got any feedback and my first glance suggested nothing changed.
Let me check again.

Best regards,
Krzysztof

