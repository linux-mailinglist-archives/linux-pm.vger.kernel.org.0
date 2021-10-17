Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E4A430774
	for <lists+linux-pm@lfdr.de>; Sun, 17 Oct 2021 11:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhJQJSv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Oct 2021 05:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbhJQJSu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Oct 2021 05:18:50 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29855C061765;
        Sun, 17 Oct 2021 02:16:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id E3D3E423BA;
        Sun, 17 Oct 2021 09:16:31 +0000 (UTC)
To:     Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211011165707.138157-1-marcan@marcan.st>
 <20211011165707.138157-8-marcan@marcan.st>
 <163424925931.1688384.9647104000291025081@swboyd.mtv.corp.google.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [RFC PATCH 7/9] clk: apple: Add clk-apple-cluster driver to
 manage CPU p-states
Message-ID: <5fab7650-7313-2c20-54eb-65078dd9c3d9@marcan.st>
Date:   Sun, 17 Oct 2021 18:16:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <163424925931.1688384.9647104000291025081@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/10/2021 07.07, Stephen Boyd wrote:
> This looks bad from a locking perspective. How is lockdep holding up
> with this driver? We're underneath the prepare lock here and we're
> setting a couple level registers which is all good but now we're calling
> into genpd code and who knows what's going to happen locking wise.

It seems this is all going away given the other discussion threads point 
towards handling this directly via OPP in the cpufreq-dt driver. I'll 
run whatever I end up with for v2 through lockdep though, good call!

> I don't actually see anything in here that indicates this is supposed to
> be a clk provider. Is it being modeled as a clk so that it can use
> cpufreq-dt? If it was a clk provider I'd expect it to be looking at
> parent clk rates, and reading hardware to calculate frequencies based on
> dividers and multipliers, etc. None of that is happening here.
> 
> Why not write a cpufreq driver, similar to qcom-cpufreq-hw.c that looks
> through the OPP table and then writes the value into the pstate
> registers? The registers in here look awfully similar to the qcom
> hardware. I don't know what the DESIRED1 and DESIRED2 registers are for
> though. Maybe they're so that one or the other frequency can be used if
> available? Like a min/max?
> 
> Either way, writing this as a cpufreq driver avoids the clk framework
> entirely which is super great for me :) It also avoids locking headaches
> from the clk prepare lock, and it also lets you support lockless cpufreq
> transitions by implementing the fast_switch function. I don't see any
> downsides to the cpufreq driver approach.

I wasn't too sure about this approach; I thought using a clk provider 
would end up simplifying things since I could use the cpufreq-dt 
machinery to take care of all the OPP stuff, and a lot of SoCs seemed to 
be going that way, but it seems cpufreq might be a better approach for 
this SoC?

There can only be one cpufreq driver instance, while I used two clock 
controllers to model the two clusters. So in the cpufreq case, the 
driver itself would have to deal with all potential CPU cluster 
instances/combinations itself. Not sure how much more code that will be, 
hopefully not too much...

I see qcom-cpufreq-hw uses a qcom,freq-domain prop to link CPUs to the 
cpufreq domains. cpufreq-dt and vexpress-spc-cpufreq instead use 
dev_pm_opp_get_sharing_cpus to look for shared OPP tables. Is there a 
reason not to do it that way and avoid the vendor prop? I guess the prop 
is more explicit while the sharing approach would have an implicit order 
dependency (i.e. CPUs are always grouped by cluster and clusters are 
listed in /cpus in the same order as in the cpufreq node)...

(Ack on the other comments, but if this becomes a cpufreq driver most of 
it is going to end up rewritten... :))

For the cpufreq case, do you have any suggestions as to how to relate it 
to the memory controller configuration tweaks? Ideally this would go 
through the OPP tables so it can be customized for future SoCs without 
stuff hardcoded in the driver... it seems the configuration affects 
power saving behavior / latencies, so it doesn't quite match the 
interconnect framework bandwidth request stuff. I'm also not sure how 
this would affect fast_switch, since going through those frameworks 
might imply locks... we might even find ourselves with a situation in 
the near future where multiple cpufreq policies can request memory 
controller latency reduction independently; I can come up with how to do 
this locklessly using atomics, but I can't imagine that being workable 
with higher-level frameworks, it would have to be a vendor-specific 
mechanism at that point...

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
