Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBEB76B342
	for <lists+linux-pm@lfdr.de>; Tue,  1 Aug 2023 13:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjHAL3q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Aug 2023 07:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjHAL3k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2023 07:29:40 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817D31FC6
        for <linux-pm@vger.kernel.org>; Tue,  1 Aug 2023 04:29:19 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9db1de50cso44663471fa.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Aug 2023 04:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690889357; x=1691494157;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQnhvTrElkRUMYG/j88qokWXWGoFkf2VtDHC0NJz/h8=;
        b=cA9ukiDO6VpnPgc2H7G6sIXnv2oN3+KtOVxpb+j1pmPII/ej/fJRmgSHIsO4Q4HiLT
         AAO1CD2A9C93kWJjILfrrRjgvfx/RfGc5CfpJhXIXrgwGXlS4MsyYqRdbuRq9hxkFRZ/
         DGZAIt0X7RJ3xp4nzwWeRu6bZoqZ9kbSKw9CC7iQBmlfPkebWGmykFDb24+ozRtplf6p
         +6ZipGtewCDhwBakDelAGTth70ugsGV68mBazqXIh0ZDLzUOKfH1q/hekHfScBMkFSml
         M4P0/y9mcXw0oAOE+uSjTCewMToWHhSN3ZHw+s5b4IQlLH9Yf2fkYLYmIs4ZRfDAW2Na
         Ihfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889357; x=1691494157;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQnhvTrElkRUMYG/j88qokWXWGoFkf2VtDHC0NJz/h8=;
        b=d4Vsw9y6XmGBy5s6iiTI8rUWStAL3hP2SprUVqMr0sGsDicN00VFJCXvmEsxcbW89y
         Uh5PORAxn9GOvM0IEq9JV7mey+eNYU0SnZOv4Jum600CAoTcMOeis1Y5v+iMlhhDOs3l
         ugHm6cX5be2vnuGRoHm8md5kvBMWrraQuIBud443C2p2LTHoAq2HkovspwXLo/AmxjdX
         6l0Xfu22Wo/9kLoh2ZxRo1Z6ZAxIcSeooMOcxODmPSYUmqIimNYWfPE2pY8VDBRwuPOr
         worN2vyvamLlbiXrE7E2fEGhS6E/zSnsJmyMNBD27xQHVjsuZshXi2BIe6yOqxawdCF5
         QqyA==
X-Gm-Message-State: ABy/qLakoGNVr8bQ01UmpfIBqGRaO+cjD88CuwLFLAGj4Jaev9NgEioC
        9fGBD//vS5IRi6kiDUPeRXfSa7rLiAa5TYbCC4ydag==
X-Google-Smtp-Source: APBJJlHV5JYqnoDuUsavWaF8qzs6MSrXxGh12jNoZ3jGRoMfI5RtsF4bQLGsAcUFuO+cmJfXIxdicg==
X-Received: by 2002:a2e:98c3:0:b0:2b9:d28c:9c2d with SMTP id s3-20020a2e98c3000000b002b9d28c9c2dmr2175374ljj.23.1690889357548;
        Tue, 01 Aug 2023 04:29:17 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id k15-20020a2e240f000000b002b70a8478ddsm3043192ljk.44.2023.08.01.04.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 04:29:17 -0700 (PDT)
Message-ID: <a289c4ed-7a05-76ea-edfc-3148cfd6c020@linaro.org>
Date:   Tue, 1 Aug 2023 13:29:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] interconnect: qcom: icc-rpm: Let nodes drive
 their own bus clock
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org>
 <20230726-topic-icc_coeff-v2-3-8c91c6c76076@linaro.org>
 <ZMjlZyFcB9IFEG60@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZMjlZyFcB9IFEG60@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1.08.2023 12:58, Stephan Gerhold wrote:
> On Mon, Jul 31, 2023 at 12:52:19PM +0200, Konrad Dybcio wrote:
>> If this hardware couldn't get messier, some nodes are supposed to drive
>> their own bus clock.. Presumably to connect to some intermediate
>> interface between the node itself and the bus it's (supposed to be)
>> connected to.
>>
>> Expand the node struct with the necessary data and hook up the
>> allocations & calculations.
>>
>> To save on memory (not very many nodes have their own clocks), allocate
>> a pointer to an array instead of allocating an array within
>> qcom_icc_node.
>>
> 
> Only on ARM32 though. On ARM64 you waste extra memory:
> 
> u32 bus_clk_rate[QCOM_SMD_RPM_STATE_NUM];
> sizeof(bus_clk_rate) = QCOM_SMD_RPM_STATE_NUM * sizeof(bus_clk_rate[0])
>                      = 2 * 4
>                      = 8
> 
> u32 *bus_clk_rate;
> sizeof(bus_clk_rate) = sizeof(ptr)
>                      = 8 (for ARM64)
>                        + 2 * 4 + malloc overhead
>                          for each node with bus_clk_desc
> 
> which is > 8 from above.
> 
> I'm not quite convinced this optimization is worth it.
Right, u32 is not the same size as *u32, brain fart :D

Konrad
