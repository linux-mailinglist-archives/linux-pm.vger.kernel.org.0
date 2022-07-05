Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364185664ED
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jul 2022 10:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiGEISx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jul 2022 04:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGEISw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 04:18:52 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B7CCC0
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 01:18:51 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t25so19271389lfg.7
        for <linux-pm@vger.kernel.org>; Tue, 05 Jul 2022 01:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VO3Yw+abO0XerN7IHjaQTl4ZRkrGFfwlEjRNNEBAaJE=;
        b=QqU10rSy1de4c5adArR93qFueLZxfDnMpugIDvp5eq4H7bqF5pDLFpOc4Hs/TBUTJu
         bKe5idB0JNeN20v8v9jlbExDuy5WxPb8Qdack6zrJrMhiTTw3CH3aWi9Hs+2vd/u0CX3
         dxuRTXPmZHcMc073bPigl6trL4K1SmoEs37MddYevx78czH64ji+qAcyEngbgSto05CU
         BeemJr0yiKTEP0BfodwnseRa5oqPJuBWapRedKgtomdcLaJYlO9VIDmdnPHTCw9YRNCy
         S5jjKidsE78coiZ6Gkyi2YzMEhveh11rKgM4De/oiNzo0MfxtNM+LCyhGen80SV/DS8a
         T5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VO3Yw+abO0XerN7IHjaQTl4ZRkrGFfwlEjRNNEBAaJE=;
        b=7V3turLkr/NC2LeBfyAAL/dsjyy8ifApeIBYYvrtKd8ZAgDQhr+UGV+BUzHHgpwCqd
         wwM6f6BMWRgS3GO+WBdV2ONcy8nbl6mxhINtqSqCE3/3cAs8CBCWaf1Sl4ndGBQ9Zmzr
         8M1V6KieMBUPQN9TyzexSOzjp8SN3S+4Q+FD7avPc3yaJzUHYvDSy+ZYwvxp1eHznMvj
         ulV5e912xCONIvcg1n2Z3ZbA6anCrv03cDJ8q3S7JDHBTWQNEvTMTdc77Nwl9orYD5HP
         uxCWhocuTk08DtuUaWSm/nXnUtsZFU/o28fyKOkENI3Ex3zdhFHI0WA1+ydu4K+XcGoG
         wShA==
X-Gm-Message-State: AJIora8rFDPQGcsf2TK1DUAwi1ooaVdhpIIyXm0w5soQtKyXM4iCzUvX
        4VuHvlxIwXjj7fxF/AnonIS9WQ==
X-Google-Smtp-Source: AGRyM1vgNzdfcGSOcNyY6Fdl0PWOPGGjSditlmDICJ6w/5bIRGgiOgEyoZa9Ffoa9UqpPsOcdvHQEA==
X-Received: by 2002:a05:6512:11d2:b0:47f:7ca3:c533 with SMTP id h18-20020a05651211d200b0047f7ca3c533mr21230362lfr.388.1657009129601;
        Tue, 05 Jul 2022 01:18:49 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id g2-20020a056512118200b0047f701f6d09sm5574889lfr.184.2022.07.05.01.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 01:18:48 -0700 (PDT)
Message-ID: <20fdb316-0f7e-0a19-0b1d-70f2f8f7dad9@linaro.org>
Date:   Tue, 5 Jul 2022 10:18:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/8] OPP: Allow multiple clocks for a device
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
References: <cover.1654849214.git.viresh.kumar@linaro.org>
 <8b29fa207024dc295639f9ba52c28e45782e3baa.1654849214.git.viresh.kumar@linaro.org>
 <de13cca4-3a33-6482-7b02-f89796f45325@linaro.org>
 <4cac6c79-ea9a-1f48-c6f1-2e04b54590a4@linaro.org>
 <20220705065940.v3n2s7bgr6eai3rf@vireshk-i7>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705065940.v3n2s7bgr6eai3rf@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/07/2022 08:59, Viresh Kumar wrote:
> On 30-06-22, 14:39, Krzysztof Kozlowski wrote:
>> On 30/06/2022 14:32, Krzysztof Kozlowski wrote:
>>> On 10/06/2022 10:20, Viresh Kumar wrote:
>>>> +	ret = _read_rate(new_opp, opp_table, np);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +	else if (opp_table->clk_count == 1)
>>>
>>> Shouldn't this be >=1? I got several clocks and this one fails.
>>
>> Actually this might be correct, but you need to update the bindings. Now
>> you require opp-level for case with multiple clocks.
> 
> I have thought about this again and adding such "fake" property in DT
> doesn't look right, specially in binding document. It maybe fine to
> have a "level" property in your case of UFS, where we want something
> to represent gears. But others may not want it.

I would say it is not different than existing opp-level property. To me
it sounded fine, so at least one DT bindings maintainer would accept it. :)

> 
> So, in the new version I am sending now, we still consider opp-hz
> property as the property that uniquely identifies an OPP. Just that we
> compare all the rates now, and not just the first one. I have updated
> _opp_compare_keys() for this as well.
> 
> The drivers, for multiple clock case, are expected to call
> dev_pm_opp_set_opp() to set the specific OPP. Though how they find the
> target OPP is left for the users to handle. For some, we may have
> another unique OPP property, like level, which can be used to find the
> OPP. While in case of others, we may want to implement freq-based OPP
> finder APIs for multiple clock rates. I have decided not to implement
> them in advance, and add them only someone wants to use them.

Thanks! Let me take a look at v2.


Best regards,
Krzysztof
