Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6146042D862
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 13:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhJNLqG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 07:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhJNLqF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 07:46:05 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AD0C061570;
        Thu, 14 Oct 2021 04:44:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1D7CD3FA67;
        Thu, 14 Oct 2021 11:43:52 +0000 (UTC)
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
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [RFC PATCH 4/9] opp: core: Don't warn if required OPP device does
 not exist
Message-ID: <bd07f4b3-6ebf-e074-c1cd-0ef501e8324f@marcan.st>
Date:   Thu, 14 Oct 2021 20:43:50 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoVjVYkc4+v-=eD+JbC10GazGt8A1LtD1so3PKMmVcyMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/10/2021 18.55, Ulf Hansson wrote:
> Yes, this sounds like you should move away from modeling the memory
> part as a parent genpd for the CPUs' genpd.
> 
> As Viresh pointed out, a devfreq driver seems like a better way to do
> this. As a matter of fact, there are already devfreq drivers that do
> this, unless I am mistaken.
> 
> It looks like devfreq providers are listening to opp/cpufreq
> notifiers, as to get an indication of when it could make sense to
> change a performance state.
> 
> In some cases the devfreq provider is also modeled as an interconnect
> provider, allowing consumers to specify memory bandwidth constraints,
> which may trigger a new performance state to be set for the memory
> controller.
> 
> In the tegra case, the memory controller is modelled as an
> interconnect provider and the devfreq node is modelled as an
> interconnect-consumer of the memory controller. Perhaps this can work
> for apple SoCs too?

I was poking around and noticed the OPP core can already integrate with 
interconnect requirements, so perhaps the memory controller can be an 
interconnect provider, and the CPU nodes can directly reference it as a 
consumer? This seems like a more accurate model of what the hardware 
does, and I think I saw some devices doing this already.

(only problem is I have no idea of the actual bandwidth numbers involved 
here... I'll have to run some benchmarks to make sure this isn't just 
completely dummy data)

> 
> That said, perhaps as an option to move forward, we can try to get the
> cpufreq pieces solved first. Then as a step on top, add the
> performance scaling for the memory controller?

Sure; that's a pretty much independent part of this patchset, though I'm 
thinking I might as well try some things out for v2 anyway; if it looks 
like it'll take longer we can split it out and do just the cpufreq side.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
