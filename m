Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F48595FCD
	for <lists+linux-pm@lfdr.de>; Tue, 16 Aug 2022 18:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiHPQFQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Aug 2022 12:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbiHPQEd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Aug 2022 12:04:33 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8D4B0D
        for <linux-pm@vger.kernel.org>; Tue, 16 Aug 2022 09:03:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a4so1444958wrq.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Aug 2022 09:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc;
        bh=G75P1MnBlTsTHdbk47o07Tr2GO1weW34E0V486dZ6zQ=;
        b=tyvhRkLnT9eQhPU1fA+R37bcZOcR1lj7033nZZYaHV0lalSjYk16myN81RvmFzEdMC
         ndbWIqX+3WeqaBeA4NYeiFOOZplsWmWVG0eBlinEroNkv6X42hD+OZDgFfIEM4+D8HHD
         jSBOg9RNYMjSTCVrPWaO51iBtkm4g6kvHMAvaboPSNjUjSUQppwDWKdo0SOc5ZvywH3a
         wdIkH7/7oG1wUDHRaCoQkUtwjPuA7EqYTuXWezQTRwsFT3XlB2A0Sl44lhrlkRDchgsU
         km96AAvMAwoVwbguS/wwzFqyDDP7ykeHS0+J50yUk0jwdDc04LdcT9/4QOpcIJt9h7Ni
         Le3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=G75P1MnBlTsTHdbk47o07Tr2GO1weW34E0V486dZ6zQ=;
        b=f19aJw1p9zou5/Qd/IKpievltd08gP3i/GtVGsTaiqvER1R89oeqQkymtTmPbcJoT3
         tUhKdMo/BDP63Ws8za4P9prAPUDZHrZdZemr4sbDE7XB/S4mA9eoogrqSYLfVZ/9/HVn
         q0WqYxgDvoJe4yLjseYVFIhTx16IWDAyq4gt8bTj43sN5ZjohOf6ipWao0sjeVO7+blt
         7kGdK/9m7VOgyvgUfUiYXwVhh33DXjRK432kwh/el3fJtcOrtTdz5YI7Y6V8u9ghcWqU
         sQ5v+9BSQXGJe1mbciAqpvJ2mEAcaJxEv49Xu7z2R8VRGfI+wXCcCbEPxzLlVvfXzTc8
         tWUw==
X-Gm-Message-State: ACgBeo3hX768rFqxVIS0WslBI5JoQQswE1DXa0sKKaRmsqbzBEVSaDbe
        1Co/VfM/2MKxwWh9XZvGK6vaJw==
X-Google-Smtp-Source: AA6agR4sDP2eoSMqKaV2coqQ9MbRDM82FgU7mJBsnWOywpv4YY3XTlQ/jWnKNtxaFziuNPY74Dlivg==
X-Received: by 2002:a05:6000:82:b0:225:21ff:a389 with SMTP id m2-20020a056000008200b0022521ffa389mr76896wrx.22.1660665795549;
        Tue, 16 Aug 2022 09:03:15 -0700 (PDT)
Received: from localhost ([109.180.234.208])
        by smtp.gmail.com with ESMTPSA id z3-20020a1cf403000000b003a60bc8ae8fsm1897992wma.21.2022.08.16.09.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 09:03:15 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     Punit Agrawal <punit.agrawal@bytedance.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 6/7] cpufreq: amd-pstate: update pstate frequency
 transition delay time
References: <20220814163548.326686-1-Perry.Yuan@amd.com>
        <20220814163548.326686-7-Perry.Yuan@amd.com> <87bkslim2c.fsf@stealth>
        <DM4PR12MB5278E6B6EC656747AE67BFAF9C6B9@DM4PR12MB5278.namprd12.prod.outlook.com>
Date:   Tue, 16 Aug 2022 17:03:13 +0100
In-Reply-To: <DM4PR12MB5278E6B6EC656747AE67BFAF9C6B9@DM4PR12MB5278.namprd12.prod.outlook.com>
        (Perry Yuan's message of "Tue, 16 Aug 2022 07:02:27 +0000")
Message-ID: <874jycfa66.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Perry,

"Yuan, Perry" <Perry.Yuan@amd.com> writes:

> [AMD Official Use Only - General]
>
> Hi Punit
>
>> -----Original Message-----
>> From: Punit Agrawal <punit.agrawal@bytedance.com>
>> Sent: Monday, August 15, 2022 11:06 PM
>> To: Yuan, Perry <Perry.Yuan@amd.com>
>> Cc: rafael.j.wysocki@intel.com; Huang, Ray <Ray.Huang@amd.com>;
>> viresh.kumar@linaro.org; Sharma, Deepak <Deepak.Sharma@amd.com>;
>> Limonciello, Mario <Mario.Limonciello@amd.com>; Fontenot, Nathan
>> <Nathan.Fontenot@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>;
>> Huang, Shimmer <Shimmer.Huang@amd.com>; Du, Xiaojian
>> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
>> pm@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v5 6/7] cpufreq: amd-pstate: update pstate frequency
>> transition delay time
>> 
>> [CAUTION: External Email]
>> 
>> Perry Yuan <Perry.Yuan@amd.com> writes:
>> 
>> > Change the default transition latency to be 20ms that is more
>> > reasonable transition delay for AMD processors in non-EPP driver mode.
>> >
>> > Update transition delay time to 1ms, in the AMD CPU autonomous mode
>> > and non-autonomous mode, CPPC firmware will decide frequency at 1ms
>> > timescale based on the workload utilization.
>> >
>> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
>> > ---
>> >  drivers/cpufreq/amd-pstate.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/cpufreq/amd-pstate.c
>> > b/drivers/cpufreq/amd-pstate.c index e40177d14310..9cb051d61422 100644
>> > --- a/drivers/cpufreq/amd-pstate.c
>> > +++ b/drivers/cpufreq/amd-pstate.c
>> > @@ -41,8 +41,8 @@
>> >  #include <asm/msr.h>
>> >  #include "amd-pstate-trace.h"
>> >
>> > -#define AMD_PSTATE_TRANSITION_LATENCY        0x20000
>> > -#define AMD_PSTATE_TRANSITION_DELAY  500
>> > +#define AMD_PSTATE_TRANSITION_LATENCY        20000
>> > +#define AMD_PSTATE_TRANSITION_DELAY  1000
>> 
>> How were these values derived? If from documentation, it'll be good to add a
>> link to the relevant documentation. And if they were derived from testing,
>> please mention this in the commit log (along with some details of the tests used
>> to determine the value).
>
> The values are calculated from the CPU PM firmware and hardware design.
> There are some latency and delay values defined  in the PM firmware, I have no documents about the detail for now. 

In that case, please mention that the values are calculated from
firmware / hardware design in the commit log (and include a reference to
the firmware sources if available).

Thanks!

[...]

