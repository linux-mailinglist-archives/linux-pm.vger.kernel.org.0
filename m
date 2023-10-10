Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF6B7C4063
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 21:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343706AbjJJTxA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 15:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343698AbjJJTw7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 15:52:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF348E
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 12:52:55 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-406618d0991so55867795e9.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 12:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696967574; x=1697572374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t5i40gxuuo/zlrus1pUVR5uLfyf6M7O5NanevceCLaM=;
        b=lhp0VL/alWj4yDjaWLLUyl5aIEMTGKPHkZDcjQh00nY3GoMtUjjM12PAqOwSgMCz2b
         kpgOe10BkpNQVcqpRd4hfuGn4kWMmLMHEPXqRDdisLAEVjGxo0XUefFOQ8mxD5oUFDDa
         VOVoW/rwAzHCFvIIfsFwGyoPKhIUNq5c7nyJ3zg8YVzRbMWCy7i3SZUMX3IpmXIBoHfp
         Z1Q7mCbiUZ50E0hPOMA8KriPsfZCv3XNtDzvdMENT36l24Qf2kYto08CehJdZweFHQw6
         z3ZBPuEc3ll6rl4SQ11oVaoVDDrTuN8BuF7lVqXSc2627rKHsE5/F+7rxrvI2Ex66oS4
         tN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696967574; x=1697572374;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5i40gxuuo/zlrus1pUVR5uLfyf6M7O5NanevceCLaM=;
        b=Mv7yfR+nb13LGdgNQjb8CC5AmxNeCZzfgJyyVC7QIE8aGbjoKLQ3ZNVvyl5Ex49kSM
         OAq5B180Sw+IerQo25LcHdxCh2+A4GBB+gqXbDjksTbyrUnd14PViNTDgK3pKiZL91zC
         Hf6TtoyZXK0CwiGmA4ic6Ub4RvcD3w6WY8sk9CuNVqDWuTCN52lOxTFobDTw5lS7kdG/
         1KA/aNFyCNxPLOBR5g/xqXrY5djo5U9DFLbGJvPUrprnbolRDE93uHIonNlzyy3F4FN0
         C1K6dqZjK+Pfc5vtuQdk2C5BKZlGrA5Z++76aw74M0KkT3LQMYiqrKZUgERBO7G4RQqL
         phFw==
X-Gm-Message-State: AOJu0YwQlpAuoA4Hy4xIB3t60RhBaJSvUnLcu/WBgd+T8HOedNufirbR
        yELFJRD4MjzeoC9d/1HnqSeZrw==
X-Google-Smtp-Source: AGHT+IGR3sltT7d1/wfUFY0JcxZUAJ8f7UgReRbR9mZOjJt43SSv1yA+6DtBSb2Qh0Y5dzSbU7hI7g==
X-Received: by 2002:a7b:c3d2:0:b0:402:cc5c:c98 with SMTP id t18-20020a7bc3d2000000b00402cc5c0c98mr16832711wmj.13.1696967573942;
        Tue, 10 Oct 2023 12:52:53 -0700 (PDT)
Received: from [172.30.204.182] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c211400b0040642a1df1csm15081271wml.25.2023.10.10.12.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 12:52:53 -0700 (PDT)
Message-ID: <1aea4a86-7f7c-46ee-9cbe-655eb7663c2a@linaro.org>
Date:   Tue, 10 Oct 2023 21:52:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] ARM: dts: qcom: ipq8064: Add CPU OPP table
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230930102218.229613-1-robimarko@gmail.com>
 <20230930102218.229613-4-robimarko@gmail.com>
 <e255dcbd-6342-49e6-9bfe-17a47b2a3c8a@linaro.org>
 <65255c81.050a0220.141f8.7b8f@mx.google.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <65255c81.050a0220.141f8.7b8f@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/10/23 16:15, Christian Marangi wrote:
> On Tue, Oct 10, 2023 at 03:40:32PM +0200, Konrad Dybcio wrote:
>>
>>
>> On 9/30/23 12:21, Robert Marko wrote:
>>> From: Christian Marangi <ansuelsmth@gmail.com>
>>>
>>> Add CPU OPP table for IPQ8062, IPQ8064 and IPQ8065 SoC.
>>> Use opp-supported-hw binding to correctly enable and disable the
>>> frequency as IPQ8062 supports up to 1.0Ghz, IPQ8064 supports up to
>>> 1.4GHz with 1.2GHz as an additional frequency and IPQ8065 supports
>>> 1.7GHZ but doesn't have 1.2GHZ frequency and has to be disabled.
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>> ---
>> Christian/Robert, can you provide a downstream source for this?
>>
> 
> Sure, consider that everything is with +/-5%.
Hm, so you're e.g. putting ipq8062 384MHz voltage for PVS3 equal to 
0.95*800000 = 760000, but I'm not sure if it's a good idea?

The comment in downstream:

"These are based on +/-5% Margin on the VDD_APCx that is advertised in 
our Datasheet across Temperature"

suggests this is already not very accurate, and betting that the lower 
threshold works on all chips is probably not the best idea.

Konrad
