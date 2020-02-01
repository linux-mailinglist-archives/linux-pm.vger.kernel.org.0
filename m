Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3985614F6F0
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2020 07:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgBAGdc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Feb 2020 01:33:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33890 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgBAGdc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Feb 2020 01:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZVJNa3Iz+CqGYVEEsyiCQf+hosgVAS0qtuUQxIMU7js=; b=dE+KRg65L44ISuEyK2B6n45nJ
        QbjvdxXLtn+GZ9HKC6/TL6bgJb+0GIuYQVGZaMAQag216uOMzPzKVy8BC0ZWRruPtBTdVknRkHjlj
        Ma4MhCj4rkDkv2+z8HZZnf8hkamNgMWABXAVkZn66U9G/vPJcykDPDpXO7m7C0tKjjdYemfLeLPoM
        entStNyAntZZEPIQfIr5HAV6Qko5HEVF4mr2VJosZ4vvoFvEzIlNp7nV8gNEIxMaw9/w7ekS3E83f
        IsXnol4Wj1q0yEIpEjCclnqL8fOLpsF2vAjEVERUQWmbk3PAAJveBKqDKeVVq4Yb8gMAreRQakVGh
        pr7ssbmMw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixmLT-0003Lz-1s; Sat, 01 Feb 2020 06:33:31 +0000
Subject: Re: [PATCH] Documentation: Fix build error for cpu-idle-cooling.rst
 and client.rst
To:     Changbin Du <changbin.du@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200201062521.7296-1-changbin.du@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6d6bfd1d-dd22-8999-fc73-3cf12dbb3a98@infradead.org>
Date:   Fri, 31 Jan 2020 22:33:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200201062521.7296-1-changbin.du@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/31/20 10:25 PM, Changbin Du wrote:
> This fixed some errors and warnings in cpu-idle-cooling.rst and client.rst.
> 
> Sphinx parallel build error:
> docutils.utils.SystemMessage: ...Documentation/driver-api/thermal/cpu-idle-cooling.rst:96: (SEVERE/4) Unexpected section title.
> 
> Sphinx parallel build error:
> docutils.utils.SystemMessage: ...Documentation/driver-api/dmaengine/client.rst:155: (SEVERE/4) Unexpected section title.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Hi,
This commit has been merged:
commit fe27f13d677ccd826386094df6977cfbc13ccf5e
Author: Randy Dunlap <rdunlap@infradead.org>
Date:   Mon Jan 20 14:33:16 2020 -0800

    Documentation: cpu-idle-cooling: fix a SEVERE docs build failure

Feel free to send patches against current Linus git tree.

Thanks.

> ---
>  Documentation/driver-api/dmaengine/client.rst | 14 ++++++---
>  .../driver-api/thermal/cpu-idle-cooling.rst   | 29 +++++++++++--------
>  Documentation/driver-api/thermal/index.rst    |  1 +
>  3 files changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
> index a9a7a3c84c63..2104830a99ae 100644
> --- a/Documentation/driver-api/dmaengine/client.rst
> +++ b/Documentation/driver-api/dmaengine/client.rst
> @@ -151,8 +151,8 @@ The details of these operations are:
>       Note that callbacks will always be invoked from the DMA
>       engines tasklet, never from interrupt context.
>  
> -  Optional: per descriptor metadata
> -  ---------------------------------
> +  **Optional: per descriptor metadata**
> +
>    DMAengine provides two ways for metadata support.
>  
>    DESC_METADATA_CLIENT
> @@ -199,12 +199,15 @@ The details of these operations are:
>    DESC_METADATA_CLIENT
>  
>      - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM:
> +
>        1. prepare the descriptor (dmaengine_prep_*)
>           construct the metadata in the client's buffer
>        2. use dmaengine_desc_attach_metadata() to attach the buffer to the
>           descriptor
>        3. submit the transfer
> +
>      - DMA_DEV_TO_MEM:
> +
>        1. prepare the descriptor (dmaengine_prep_*)
>        2. use dmaengine_desc_attach_metadata() to attach the buffer to the
>           descriptor
> @@ -215,6 +218,7 @@ The details of these operations are:
>    DESC_METADATA_ENGINE
>  
>      - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM:
> +
>        1. prepare the descriptor (dmaengine_prep_*)
>        2. use dmaengine_desc_get_metadata_ptr() to get the pointer to the
>           engine's metadata area
> @@ -222,7 +226,9 @@ The details of these operations are:
>        4. use dmaengine_desc_set_metadata_len()  to tell the DMA engine the
>           amount of data the client has placed into the metadata buffer
>        5. submit the transfer
> +
>      - DMA_DEV_TO_MEM:
> +
>        1. prepare the descriptor (dmaengine_prep_*)
>        2. submit the transfer
>        3. on transfer completion, use dmaengine_desc_get_metadata_ptr() to get
> @@ -278,8 +284,8 @@ The details of these operations are:
>  
>        void dma_async_issue_pending(struct dma_chan *chan);
>  
> -Further APIs:
> --------------
> +Further APIs
> +------------
>  
>  1. Terminate APIs
>  
> diff --git a/Documentation/driver-api/thermal/cpu-idle-cooling.rst b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
> index e4f0859486c7..d8b522d37eb9 100644
> --- a/Documentation/driver-api/thermal/cpu-idle-cooling.rst
> +++ b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
> @@ -1,6 +1,9 @@
> +================
> +CPU Idle Cooling
> +================
>  
> -Situation:
> -----------
> +Situation
> +---------
>  
>  Under certain circumstances a SoC can reach a critical temperature
>  limit and is unable to stabilize the temperature around a temperature
> @@ -24,8 +27,8 @@ with a power less than the requested power budget and the next OPP
>  exceeds the power budget. An intermediate OPP could have been used if
>  it were present.
>  
> -Solutions:
> -----------
> +Solutions
> +---------
>  
>  If we can remove the static and the dynamic leakage for a specific
>  duration in a controlled period, the SoC temperature will
> @@ -45,12 +48,12 @@ idle state target residency, we lead to dropping the static and the
>  dynamic leakage for this period (modulo the energy needed to enter
>  this state). So the sustainable power with idle cycles has a linear
>  relation with the OPP’s sustainable power and can be computed with a
> -coefficient similar to:
> +coefficient similar to::
>  
>  	    Power(IdleCycle) = Coef x Power(OPP)
>  
> -Idle Injection:
> ----------------
> +Idle Injection
> +--------------
>  
>  The base concept of the idle injection is to force the CPU to go to an
>  idle state for a specified time each control cycle, it provides
> @@ -64,6 +67,7 @@ latencies as the CPUs will have to wakeup from a deep sleep state.
>  We use a fixed duration of idle injection that gives an acceptable
>  performance penalty and a fixed latency. Mitigation can be increased
>  or decreased by modulating the duty cycle of the idle injection.
> +::
>  
>       ^
>       |
> @@ -90,6 +94,7 @@ computed.
>  
>  The governor will change the cooling device state thus the duty cycle
>  and this variation will modulate the cooling effect.
> +::
>  
>       ^
>       |
> @@ -132,7 +137,7 @@ Power considerations
>  --------------------
>  
>  When we reach the thermal trip point, we have to sustain a specified
> -power for a specific temperature but at this time we consume:
> +power for a specific temperature but at this time we consume::
>  
>   Power = Capacitance x Voltage^2 x Frequency x Utilisation
>  
> @@ -141,7 +146,7 @@ wrong in the system setup). The ‘Capacitance’ and ‘Utilisation’ are a
>  fixed value, ‘Voltage’ and the ‘Frequency’ are fixed artificially
>  because we don’t want to change the OPP. We can group the
>  ‘Capacitance’ and the ‘Utilisation’ into a single term which is the
> -‘Dynamic Power Coefficient (Cdyn)’ Simplifying the above, we have:
> +‘Dynamic Power Coefficient (Cdyn)’ Simplifying the above, we have::
>  
>   Pdyn = Cdyn x Voltage^2 x Frequency
>  
> @@ -150,7 +155,7 @@ in order to target the sustainable power defined in the device
>  tree. So with the idle injection mechanism, we want an average power
>  (Ptarget) resulting in an amount of time running at full power on a
>  specific OPP and idle another amount of time. That could be put in a
> -equation:
> +equation::
>  
>   P(opp)target = ((Trunning x (P(opp)running) + (Tidle x P(opp)idle)) /
>  			(Trunning + Tidle)
> @@ -160,7 +165,7 @@ equation:
>  
>  At this point if we know the running period for the CPU, that gives us
>  the idle injection we need. Alternatively if we have the idle
> -injection duration, we can compute the running duration with:
> +injection duration, we can compute the running duration with::
>  
>   Trunning = Tidle / ((P(opp)running / P(opp)target) - 1)
>  
> @@ -183,7 +188,7 @@ However, in this demonstration we ignore three aspects:
>     target residency, otherwise we end up consuming more energy and
>     potentially invert the mitigation effect
>  
> -So the final equation is:
> +So the final equation is::
>  
>   Trunning = (Tidle - Twakeup ) x
>  		(((P(opp)dyn + P(opp)static ) - P(opp)target) / P(opp)target )
> diff --git a/Documentation/driver-api/thermal/index.rst b/Documentation/driver-api/thermal/index.rst
> index 5ba61d19c6ae..4cb0b9b6bfb8 100644
> --- a/Documentation/driver-api/thermal/index.rst
> +++ b/Documentation/driver-api/thermal/index.rst
> @@ -8,6 +8,7 @@ Thermal
>     :maxdepth: 1
>  
>     cpu-cooling-api
> +   cpu-idle-cooling
>     sysfs-api
>     power_allocator
>  
> 


-- 
~Randy

