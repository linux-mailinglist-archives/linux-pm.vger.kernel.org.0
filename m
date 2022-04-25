Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F3E50DD92
	for <lists+linux-pm@lfdr.de>; Mon, 25 Apr 2022 12:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiDYKGT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Apr 2022 06:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241502AbiDYKGQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2022 06:06:16 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DDD2252B
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2022 03:03:11 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r13so28585742ejd.5
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2022 03:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=2WgIrPk8Gi6VJyQTSCt7yrmHnUX10MpNP4vrR/luUsk=;
        b=FtmLTt9nLJTfd8E53+GL35FEXD6Y2iUV/bCMkbQrdI1H1Mn+b+qjzwcSx9WoKwN1oZ
         3ibqxm1YuE+QsJOp0cAPCUCldZX2uxaSb3Q0hBhc2DHv8QVBidVPj4A8R+h56IxQkEDK
         la6PsdSwjHEknO4cjKbgVgXZQxYuKYffSxEuJ7UpCt0nyri7ESoqrygRVL2BWIKYtY39
         tcr0n6yb72i7KItNmP0T1QnDjjl3r+iq1ddxZo+DYAJHff7TDwycGbc8nGDwjCkg0T/W
         sj2WopWH2wMf4CjEDllsNO8lLi0C3dRfAfv/JdAFGE9DvVFJatS8LuGF2RKoO8+JfirJ
         Tmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2WgIrPk8Gi6VJyQTSCt7yrmHnUX10MpNP4vrR/luUsk=;
        b=zSFFsZicRENHKict7Cew1+2loXH4d+kF7km4C9LuFXgAIXaEwHt9dzTW6yMY9Hd7W7
         5mBAMH4DejXeDgJMaOFRIhAWactZ05eNAQFsAZIKNlrrMu8S3URDeHe+zVAju4DmigKk
         LcT9RvgVEPtWDQJEEnF4IA1NnbE55wQW+R4dK4EueHoG4K9Ci2xMiPEvaQtL5+88U434
         jskQ2rxOwkmQeqRcQtMNu2Yuv5T9hQ/jBurm+EH9g8y463G4MBi6+RelU6KO6NJxjrAr
         CcD9IEIHHAIW+mNTNAPXqm0q9knlqUNUPyuEpKpYV97YcRhLj/UffFphqhfpFZZuDtpp
         fvSQ==
X-Gm-Message-State: AOAM530vy/BujMKQCtVREkXfezEwOa5srxKfiNAVlDqoVyy1He7G6Fd8
        kjRI+iIfRsOQUFWg/Mwwj2zGOg==
X-Google-Smtp-Source: ABdhPJzkai7WwAl5gkr1Z6X8P9PyQmQBzG0zYuIWg22TReBOZg1vlzz5jQ1xhjuQjOsO2p5ns99SXQ==
X-Received: by 2002:a17:907:1ca0:b0:6f3:a59c:288e with SMTP id nb32-20020a1709071ca000b006f3a59c288emr175991ejc.716.1650880990272;
        Mon, 25 Apr 2022 03:03:10 -0700 (PDT)
Received: from [192.168.0.241] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g17-20020a056402425100b00425f2816b85sm381941edb.27.2022.04.25.03.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 03:03:09 -0700 (PDT)
Message-ID: <e059bd49-a301-032a-d089-9ef6cb313089@linaro.org>
Date:   Mon, 25 Apr 2022 12:03:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v2 4/6] PM: opp: allow control of multiple clocks
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
 <20220411154347.491396-5-krzysztof.kozlowski@linaro.org>
 <20220422234402.B66DDC385A4@smtp.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422234402.B66DDC385A4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23/04/2022 01:44, Stephen Boyd wrote:
> Quoting Krzysztof Kozlowski (2022-04-11 08:43:45)
>> Devices might need to control several clocks when scaling the frequency
>> and voltage.  Example is the Universal Flash Storage (UFS) which scales
>> several independent clocks with change of performance levels.
>>
>> Add parsing of multiple clocks and clock names and scale all of them,
>> when needed.  If only one clock is provided, the code should behave the
>> same as before.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> 
> I vaguely recall that scaling more than one clk with an OPP table is
> confusing? I think it's because things like dev_pm_opp_find_freq_ceil()
> don't make sense when there's more than one frequency table. How is that
> handled here?

The assumption (which might need better documentation) is that first
clock frequency is the main one:
1. It is still in opp->rate field, so it is used everywhere when OPPs
are compared/checked for rates.
1. Usually is used also in opp-table nodes names.

The logical explanation is that devices has some main operating
frequency, e.g. the core clock, and this determines the performance. In
the same time such device might not be able to scale this on core clock
independently from others, this this patches.

Best regards,
Krzysztof
