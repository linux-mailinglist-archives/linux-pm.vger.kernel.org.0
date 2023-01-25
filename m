Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C6067A885
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 02:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjAYB5e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Jan 2023 20:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjAYB5d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2023 20:57:33 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D5D2005F
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 17:57:31 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id az20so43942048ejc.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 17:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/mKFyQdCK+sFsQ62/Alg3KP7i9MMdCNwigkeF8QsM/A=;
        b=moVGq3j7mY9vwiXNvzJqg0s8DHlSR9CmEAz6WBRUWUIqUb/5upUHGzWQ0TdWfmSIUE
         1gnpPFhe5NPFqlhU0dgwNuAILQ77w5Ed7YG9OzzRDs7c42mSZGHJWZ/97IboecLqehVs
         jcQ5EjUe/Z4grGvkQo8xV1UZvNTJfPPoPPJa96NNIzvXNRI2ZVf1HcCuPSoqPvesf8OJ
         DEULqAsp/JGIYkwD9qurOSdj7iJ3FrrVYvGPsA5mA9kdzGsEIue10/9RsKtNvlhC3z+0
         giWN9CyoAPDwhoUzUeNvlgLjF97IiEyWWW8boz+yj3AcC8d7SNRynJmzeehPCUN+YxYM
         UJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/mKFyQdCK+sFsQ62/Alg3KP7i9MMdCNwigkeF8QsM/A=;
        b=yxBCUr5/9D61ae5dk2/vt/jLRuh1UxaEo73JVDZqur+9UYtzGkjxFTB0e1P3vSWWkt
         SLIUBopijuzca8klWUSM25ztonOfT9j0yjFlAiPwT1aRdwrp6+ZB1jesDX1UUnostakI
         BOpG3hNQz3pd02m6d9eHwHJ2iliE9mDaIhuIdX4xh9exljaHZHIfB+LPkoaBcOFF3YCn
         hHGDV8yFpexTEQNvThO4kOH6RmkYG7ib1N+PyVVrK0E+hKE4xMFhsZ30NiR7KQaQXxIl
         FAwQasXrRzqY6RHadKGFSnbhS4z96/sM67i+OiI1frWcrs3tTYWXUzfJgKdki6/z/y5g
         C/HQ==
X-Gm-Message-State: AFqh2koqJIqkh4FKkcdoIpmvLcXbsrBooheexBKM6hm4+Z3CsZjiRQ4k
        NrEZjwGfXK4OQEjNrFVCNFq6bQ==
X-Google-Smtp-Source: AMrXdXvvfVLo6uoOWYvx6AfYZxEwfpNt+CFEl9MEZT7I7eIv0P0XG4dhVAgWPJtV9+bKMd/U1gslog==
X-Received: by 2002:a17:907:9548:b0:86f:fe6b:57f7 with SMTP id ex8-20020a170907954800b0086ffe6b57f7mr27293741ejc.62.1674611849499;
        Tue, 24 Jan 2023 17:57:29 -0800 (PST)
Received: from [192.168.1.101] (abyl109.neoplus.adsl.tpnet.pl. [83.9.31.109])
        by smtp.gmail.com with ESMTPSA id t9-20020a170906608900b00871cb1b8f63sm1636301ejj.26.2023.01.24.17.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 17:57:28 -0800 (PST)
Message-ID: <7781e371-781c-c301-6504-99fdeb7f2b36@linaro.org>
Date:   Wed, 25 Jan 2023 02:57:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 2/9] interconnect: qcom: rpm: Always set QoS params on
 QNoC
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
References: <20230116132152.405535-1-konrad.dybcio@linaro.org>
 <20230116132152.405535-3-konrad.dybcio@linaro.org>
 <8673ef49-a37e-2d76-b800-bf9b10875006@linaro.org>
 <eac4a16e-c6b2-64ae-f5a2-84dab64476df@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <eac4a16e-c6b2-64ae-f5a2-84dab64476df@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 19.01.2023 01:27, Bryan O'Donoghue wrote:
> On 18/01/2023 20:36, Konrad Dybcio wrote:
>> Would be very nice if somebody could test this one in particular
>> on QCM2290 to make sure it does not regress that SoC..
>>
>> Shawn, Loic?
>>
>> Konrad
> 
> I have a 2290.
> 
> Since I'm already helping with review, I'm happy to help with test too.
Thanks!

I'm afraid it won't be necessary though..

This patch gives more trouble than it solves. Here's the thing:

It was working perfectly on my SM6375 for quite some time and then
I rebased my branch on a newer -next and suddenly it makes things go
boom boom.. I think I'll drop it in the next revision, even if that's
what downstream does.. At least until I pretend to be an archaeologist
surgeon again and debug this..

Konrad

> 
> ---
> bod
