Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB4A7148BB
	for <lists+linux-pm@lfdr.de>; Mon, 29 May 2023 13:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjE2Lk1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 May 2023 07:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjE2LkV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 May 2023 07:40:21 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320BC109
        for <linux-pm@vger.kernel.org>; Mon, 29 May 2023 04:40:12 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f3b9e54338so3586598e87.0
        for <linux-pm@vger.kernel.org>; Mon, 29 May 2023 04:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685360410; x=1687952410;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XnP50kar14DpzkcsWdfhw9HR2nmUDWr1W10Tl3md5mo=;
        b=M+Z5yyhkdbMV9sJyF3AJuaqqFankJ9GPUDdwhK5KMpZwdoVMZGEGeoSiwFxyBFYYvR
         eGpNAZYsb7OZscOUdQzd8osEr8nKbGcUuw7B2UMV2xtSQ1u3sc5ZjrtftVyRuOY/ylgg
         D5oCQ8GdPjMmMNCwsYfcIJh3+Z97rF8gmdPucNV0b40KPYt1wgnfvMrPVNXqtGNgAoSJ
         8PSyDsg2VbNuYJJyXsNdkCjoOP5WzbIH5ntHoayXOb0OSs5p/eTDMZgPL5NBQmsyMYMK
         TYZm4X4h4Wl0pGSVosFkGYqYcKaMKoAIrhV5bpmZSz0f7ma0ueECqEX7zfMx5KnlQVPh
         wIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685360410; x=1687952410;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XnP50kar14DpzkcsWdfhw9HR2nmUDWr1W10Tl3md5mo=;
        b=Ut+mf0sR5y3jOWEckx9hgpJB21ewLRKhKUWWQqsb/XwQ83oMF9BISKJPBSBoeFHLr3
         QlR7ssvqkelmfAvHNRcsJ0Ozi4UME0N20jkDtxpOyLoOB13x13Xc6q2FJbb+dy2j/rfu
         P3u/rjYq6azB5Y9Y39qoy6HG21a662CsH3Mo9wYzc98MFhvzvv1gwUoTUWZz+kvRzuzu
         /ugijt/hNPZ+D6jl1GhfQRuQkBXHNMIdaohstOV0gJLOLH9l9HkyFwwRagfe0svlWoRv
         mKvtDSeTC6DdIdsFtpccgQROnbnm+zV+Vln9qHsrOYUcihjKL1OFGJjm9muRBZlwFLIj
         wWtA==
X-Gm-Message-State: AC+VfDwTLUrjf07hw63hTodapElPzYiatUokjpAEmucu5Rd1nYTUH7eg
        xOg5ZVc7jvmjDJLjZOdJiiebI/3HaqPvIdFrUtk=
X-Google-Smtp-Source: ACHHUZ7fI48ej5TXXqJctqcq03UNXCtn8FPIkCvh/I191Cx43aGKacvHHbK0WRyjIl/dICELADhWEQ==
X-Received: by 2002:ac2:4893:0:b0:4f4:4cd4:6df4 with SMTP id x19-20020ac24893000000b004f44cd46df4mr3764153lfc.25.1685360410337;
        Mon, 29 May 2023 04:40:10 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004f4cabba7desm1934981lfn.74.2023.05.29.04.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 04:40:10 -0700 (PDT)
Message-ID: <8a2eb4ff-8a27-0a37-b9cc-1f522ddd1fa8@linaro.org>
Date:   Mon, 29 May 2023 13:40:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] opp: Provide a function for just setting bandwidth
Content-Language: en-US
To:     Georgi Djakov <djakov@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230526-topic-opp_bw-v1-1-e881091363af@linaro.org>
 <8b7f4b22-76e2-e812-92ed-35e5ecdd6309@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <8b7f4b22-76e2-e812-92ed-35e5ecdd6309@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 29.05.2023 12:38, Georgi Djakov wrote:
> Hi Konrad,
> 
> On 26.05.23 12:17, Konrad Dybcio wrote:
>> Currently it's not possible to set just the bandwidth if the OPP
>> describes other properties (required-opps, opp-hz etc.).
>>
>> Introduce dev_pm_opp_set_bw() to solve this problem.
>>
> 
> Who is going to use this?
I wanted to use it with Adreno for fine-grained control during system
suspend/resume. It turned out that I was essentially then trying to power
on the hardware without its power supply.


https://lore.kernel.org/linux-kernel/8b7f4b22-76e2-e812-92ed-35e5ecdd6309@kernel.org/T/#t

Konrad
> 
> BR,
> Georgi
> 
