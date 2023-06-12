Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC0572C825
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 16:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbjFLOWx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 10:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbjFLOWf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 10:22:35 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104421BD3
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 07:20:24 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f65779894eso4296597e87.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 07:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686579604; x=1689171604;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NSvlsm1vEOWf78ZaJaA6a10BH4JNNfXIER+h17rt9CM=;
        b=JPIwRskU6oZ71zvly+9F3vYs8JoENWrSqHRTTyFm0TLCvlS//DjLmq5PHfnCh09yvM
         n0B6KUxDZ95gPCPdPl95F4/hdKyLHfEPKd7MVmKs5JU4pFWKkrbsWYJPC7ZtxvCcW8cn
         ceZtgdLJfT74N38ZAEjuZmJU7dtyciQrZPUDx2NEyOQlkd2VvaqcNtFFaT4FYERV0sL5
         GDDBQquW14e85U4jlcs763ktIjPlL69Zo838FEiudcnqw6RtEwDSifPsNiX7WQdISYFM
         oG9sJpl4O69ArtmlZgGSEBfGamrimNnDwxpPkpdp+tVYL0yOVKsCLayY2D+NYfmOVxa0
         GRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579604; x=1689171604;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NSvlsm1vEOWf78ZaJaA6a10BH4JNNfXIER+h17rt9CM=;
        b=cJI4106A7G0jgGT04g4k1SJbJI6pSRg2dckcdrHPiUF/whym/3ZwNYc9lRczwho/eT
         XxSipN7F7QXtWZz9PDP2RJaWw7TLxkZLzMvfD7tfrQhr8fPT3a8HvE5WIh86+yU/Z8lo
         eAmZZIAi8TdHZrNbFWzJgUQ6sUXHDWncasHdl5HlZnII0GykdsGffPT/S4Iuxi2ZfdNG
         mPtOv4PjDcW1oq1ipaPhxqknUq7VOjhyarACSx6eNLJR5dxqebzSJGjSfCyrJfoVuwGq
         qmWSg2x11up/BqhyYdFP4JbPsoAv2PHCt9WlwGbpgC3rwxAeMdsqXgqxYj9sveazPYN0
         juQg==
X-Gm-Message-State: AC+VfDw47kMpbA33y8mUmasvgYHLPDZX22zdZpx3H12Fuf98WhJrs7uC
        x+8lZgM5Kp5cmtMVYjMgjJkfxg==
X-Google-Smtp-Source: ACHHUZ4fTsFvE37eGGctgd/kBdjCtwzEKl+BMhrZpZQL+PsW0znUnxYR3vsTgnR+WC43YUkDa5zmhA==
X-Received: by 2002:a05:6512:2305:b0:4f3:822d:bcf7 with SMTP id o5-20020a056512230500b004f3822dbcf7mr2923641lfu.21.1686579604135;
        Mon, 12 Jun 2023 07:20:04 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id a11-20020a2e980b000000b002b1c0a663fbsm1785366ljj.77.2023.06.12.07.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 07:20:03 -0700 (PDT)
Message-ID: <99a68056-a4c9-d475-9245-e0802ffe4c89@linaro.org>
Date:   Mon, 12 Jun 2023 17:20:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 00/18] ARM: qcom: apq8064: support CPU frequency scaling
Content-Language: en-GB
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
 <6486dcef.050a0220.4c054.4c59@mx.google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <6486dcef.050a0220.4c054.4c59@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11/06/2023 19:27, Christian Marangi wrote:
> On Mon, Jun 12, 2023 at 08:39:04AM +0300, Dmitry Baryshkov wrote:
>> Implement CPUFreq support for one of the oldest supported Qualcomm
>> platforms, APQ8064. Each core has independent power and frequency
>> control. Additionally the L2 cache is scaled to follow the CPU
>> frequencies (failure to do so results in strange semi-random crashes).
> 
> Hi, can we talk, maybe in private about this interconnect-cpu thing?

Hi, sure. Feel free to ping me on IRC (lumag) or via email. Or we can 
just continue our discussion here, as it might be interesting to other 
people too.

> I see you follow the original implementation of the msm_bus where in
> practice with the use of the kbps the correct clock and voltage was set.
> (and this was also used to set the fabric clock from nominal to fast)
> 
> On ipq806x and I assume other SoC there isn't always a 1:1 map of CPU
> freq and L2 freq. For example on ipq8064 we have max CPU freq of 1.4GHz
> and L2 freq of 1.2GHz, on ipq8065 we have CPU 1.7GHz and L2 of 1.4GHz.

This is also the case for apq8064. The vendor kernel defines 15 
frequencies for L2 cache clock, but then for some reasons all PVS tables 
use just 3 entries from these 15.

> (and even that is curious since I used the debug regs and the cxo
> crystal to measure the clock by hardware (yes i ported the very ancient
> clk-debug to modern kernel and it works and discovered all sort of
> things) the L2 (I assume due to climitation of the hfpll) actually can't
> never reach that frequency (1.4GHz in reality results to something like
> 1.2GHz from what I notice a stable clock is there only with frequency of
> max 1GHz))

I would like to point you to https://github.com/andersson/debugcc/, 
which is a userspace reimplementation of clk-debug. We'd appreciate your 
patches there.

> So my idea was to introduce a simple devfreq driver and use the PASSIVE
> governor where it was added the possibility to link to a CPU frequency
> and with interpolation select the L2 frequency (and voltage)

I stumbled upon this idea, when I was working on the msm8996 and it's 
CBF clock (CBF = interconnect between two core clusters). While it 
should be possible to use DEVFREQ in simple cases (e.g. L2 clock >= 
max(CPU clock), if possible). However real configurations are slightly 
harder.
E.g. for the purpose of this patchset, the relationship for apq8064 is 
the following (in MHz):

  CPU    L2
  384    384
  486    648
  594    648
  702    648
....    ...
1026    648
1134   1134
....   ....
1512   1134
....   ....

It should be noted that msm8960 also used just three values for the L2 
cache frequencies. From what I can see, only msm8x60 made L2 freq 
tightly follow the CPU frequency.

>  From some old comments in ancient qsdk code it was pointed out that due
> to a hw limitation the secondary cpu can't stay at a high clock if L2
> was at the idle clock. (no idea if this is specific to IPQ806x) So this
> might be a cause of your crash? (I also have random crash with L2
> scaling and we are planning to just force the L2 at max frequency)

It might be related. It was more or less the same story with msm8996, 
which was either 'maxcpus=2' or scaling the CBF clock.

> But sorry for all of this (maybe) useless info. I checked the other
> patch and I didn't understand how the different L2 frequency are
> declared and even the voltage. Is this something that will come later?
> I'm very interested in this implementation.

The L2 frequency (<&kraitcc 4>) is converted into bandwidth vote, which 
then goes into the OPP tables. But please also see the discussion 
started at the patch 15.

> 
>>
>> Core voltage is controlled through the SAW2 devices, one for each core.
>> The L2 has two regulators, vdd-mem and vdd-dig.
>>
>> Depenency: [1] for interconnect-clk implementation
>>
>> https://lore.kernel.org/linux-arm-msm/20230512001334.2983048-3-dmitry.baryshkov@linaro.org/
>>
> 

-- 
With best wishes
Dmitry

