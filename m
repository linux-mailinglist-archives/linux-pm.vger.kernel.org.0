Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3101542DFCD
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 19:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhJNREf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 13:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhJNREf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 13:04:35 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD351C061570;
        Thu, 14 Oct 2021 10:02:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1BFD73FA5E;
        Thu, 14 Oct 2021 17:02:21 +0000 (UTC)
Subject: Re: [RFC PATCH 4/9] opp: core: Don't warn if required OPP device does
 not exist
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211011165707.138157-1-marcan@marcan.st>
 <20211011165707.138157-5-marcan@marcan.st>
 <20211012032144.2ltlpat7orrsyr6k@vireshk-i7>
 <b7cd51ec-38e5-11d8-5193-1170c9d60ac9@marcan.st>
 <20211012055143.xmkbvhbnolspgjin@vireshk-i7>
 <caf16a6c-f127-7f27-ed17-0522d9f1fb9e@marcan.st>
 <CAPDyKFoVjVYkc4+v-=eD+JbC10GazGt8A1LtD1so3PKMmVcyMg@mail.gmail.com>
 <bd07f4b3-6ebf-e074-c1cd-0ef501e8324f@marcan.st>
 <CAPDyKFrFX93XV8a7e7oo1N5weWp2auq=_94fTnzr2EkO3c37Ug@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <ca820b86-fc12-63b9-ec6b-5823ddd73aba@marcan.st>
Date:   Fri, 15 Oct 2021 02:02:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrFX93XV8a7e7oo1N5weWp2auq=_94fTnzr2EkO3c37Ug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/10/2021 21.55, Ulf Hansson wrote:
> On Thu, 14 Oct 2021 at 13:43, Hector Martin <marcan@marcan.st> wrote:
>> I was poking around and noticed the OPP core can already integrate with
>> interconnect requirements, so perhaps the memory controller can be an
>> interconnect provider, and the CPU nodes can directly reference it as a
>> consumer? This seems like a more accurate model of what the hardware
>> does, and I think I saw some devices doing this already.
> 
> Yeah, that could work too. And, yes, I agree, it may be a better
> description of the HW.
> 
>>
>> (only problem is I have no idea of the actual bandwidth numbers involved
>> here... I'll have to run some benchmarks to make sure this isn't just
>> completely dummy data)
>>

So... I tried getting bandwidth numbers and failed. It seems these 
registers don't actually affect peak performance in any measurable way. 
I'm also getting almost the same GeekBench scores on macOS with and 
without this mechanism enabled, although there is one subtest that seems 
to show a measurable difference.

My current guess is this is something more subtle (latencies? idle 
timers and such?) than a performance state. If that is the case, do you 
have any ideas as to the best way to model it in Linux? Should we even 
bother if it mostly has a minimal performance gain for typical workloads?

I'll try to do some latency tests, see if I can make sense of what it's 
actually doing.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
