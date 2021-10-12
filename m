Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1692B429D67
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 07:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhJLGAC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 02:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhJLGAC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Oct 2021 02:00:02 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF06C061570;
        Mon, 11 Oct 2021 22:58:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 17A1E4206F;
        Tue, 12 Oct 2021 05:57:52 +0000 (UTC)
Subject: Re: [RFC PATCH 4/9] opp: core: Don't warn if required OPP device does
 not exist
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-arm-kernel@lists.infradead.org,
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
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211011165707.138157-1-marcan@marcan.st>
 <20211011165707.138157-5-marcan@marcan.st>
 <20211012032144.2ltlpat7orrsyr6k@vireshk-i7>
 <b7cd51ec-38e5-11d8-5193-1170c9d60ac9@marcan.st>
 <20211012055143.xmkbvhbnolspgjin@vireshk-i7>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <caf16a6c-f127-7f27-ed17-0522d9f1fb9e@marcan.st>
Date:   Tue, 12 Oct 2021 14:57:50 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012055143.xmkbvhbnolspgjin@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/10/2021 14.51, Viresh Kumar wrote:
> On 12-10-21, 14:34, Hector Martin wrote:
>> The table *is* assigned to a genpd (the memory controller), it's just that
>> that genpd isn't actually a parent of the CPU device. Without the patch you
>> end up with:
>>
>> [    3.040060] cpu cpu4: Failed to set performance rate of cpu4: 0 (-19)
>> [    3.042881] cpu cpu4: Failed to set required opps: -19
>> [    3.045508] cpufreq: __target_index: Failed to change cpu frequency: -19
> 
> Hmm, Saravana and Sibi were working on a similar problem earlier and decided to
> solve this using devfreq instead. Don't remember the exact series which got
> merged for this, Sibi ?
> 
> If this part fails, how do you actually set the performance state of the memory
> controller's genpd ?

The clock controller has the genpd as an actual power-domain parent, so 
it does it instead. From patch #7:

> +	if (cluster->has_pd)
> +		dev_pm_genpd_set_performance_state(cluster->dev,
> +						   dev_pm_opp_get_required_pstate(opp, 0));
> +

This is arguably not entirely representative of how the hardware works, 
since technically the cluster switching couldn't care less what the 
memory controller is doing; it's a soft dependency, states that should 
be switched together but are not interdependent (in fact, the clock code 
does this unconditionally after the CPU p-state change, regardless of 
whether we're shifting up or down; this is, FWIW, the same order macOS 
uses, and it clearly doesn't matter which way you do it).

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
