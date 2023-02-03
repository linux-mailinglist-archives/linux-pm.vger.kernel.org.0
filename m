Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC95068A352
	for <lists+linux-pm@lfdr.de>; Fri,  3 Feb 2023 21:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjBCUAd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Feb 2023 15:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjBCUAc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2023 15:00:32 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405EBA778C
        for <linux-pm@vger.kernel.org>; Fri,  3 Feb 2023 12:00:31 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hx15so18283740ejc.11
        for <linux-pm@vger.kernel.org>; Fri, 03 Feb 2023 12:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNZmUjalO4LYPOF+eUW4Y82TvsAb7nT3IdQ/0VgTds0=;
        b=jRO/fAYuRFzZElK1szOUEDoXkIWGt9DLNv8LIQSon7G1JPsu0NOzevjM9U1nQ2uFcH
         XPNXZAIIkMHZYgLD5JCkk/vNJEn147aFKV0AMOXJapzgLkYItcG0U7GqSRR9Z5cX31W9
         YbQUK3ZuPQ0D7Lhq5uXjMRVURnc2o9MLqJhW9k9R0UqPf0QrJQ+KMZ8Q2Ige0M/0V3dX
         kdNevz55C1T3VbHyb1lyn20CuxxFlyaPvtHnAiurioz9Ul8sbBaluJGm6OOK7OKDGMAC
         frDZaX852xLspqd0U/4XFPQS90L8VAFlAzWbsY1mfz4Pwz4ODm8AVo7ch0G+oWQE8w2+
         SJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNZmUjalO4LYPOF+eUW4Y82TvsAb7nT3IdQ/0VgTds0=;
        b=T+kLV+GD08zp0I95+MDOO9Y2SGUara9bhq7f/xEHHv85JrKuDdcXx4ouWiNePneqeZ
         yyywbiXiT+nyoT59jK/QZ9jBtpxIs+MftYyF5bvFdqR1Ni/rVq2pIOPdYB+XEQ3IhZ2U
         kbomQ7whKImXp4yKZvqr8UzFOnIEVjn+1+Pt/czIWH+2t9GaymB17r6SvZ6ZmxbHEtHo
         x8yE0x0snQ+B9YGx7trceuqb9pQQeGDXU/p4JTveO5LltVck9e0taoLASMbgwHE11CDA
         93XF9mXjzksqKTf4x842r3qGSHdkh7U3t9r9stksoX0qDWOLTzEjZ7kpTDdk4v3zBtkp
         NVww==
X-Gm-Message-State: AO0yUKXOwNiHMR9Rq4nAtkOHDUbMTuz2UMuNgvoiLEoQsMU6Rgz2oTZr
        IeS2YSq0oKxj5fk0Z1NHrNA6fA==
X-Google-Smtp-Source: AK7set+Hqp7GLl37iJsFJtTsBfbQ7Klfcp1/GqtqztuTu8LNSWYByMnYkwJg7BMR+qyE6Y51Kd5CiA==
X-Received: by 2002:a17:906:1181:b0:7c1:6e08:4c20 with SMTP id n1-20020a170906118100b007c16e084c20mr12474122eja.7.1675454429730;
        Fri, 03 Feb 2023 12:00:29 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u7-20020a1709060b0700b0087bdae9a1ebsm1823437ejg.94.2023.02.03.12.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 12:00:28 -0800 (PST)
Message-ID: <9b8af6b3-9ab5-12f8-5576-1a93c58a26c1@linaro.org>
Date:   Fri, 3 Feb 2023 22:00:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v2 1/2] PM: domains: Skip disabling unused domains if
 provider has sync_state
Content-Language: en-GB
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Doug Anderson <dianders@chromium.org>
References: <20230127104054.895129-1-abel.vesa@linaro.org>
 <Y9v/z8CYik3faHh7@google.com>
 <3826e0e6-bb2b-409d-d1c3-ed361305bce3@linaro.org>
 <Y9xhbq/MIOgssslh@google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y9xhbq/MIOgssslh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/02/2023 03:20, Matthias Kaehlcke wrote:
> Hi Dmitry,
> 
> On Thu, Feb 02, 2023 at 09:53:41PM +0200, Dmitry Baryshkov wrote:
>> On 02/02/2023 20:24, Matthias Kaehlcke wrote:
>>> Hi Abel,
>>>
>>> On Fri, Jan 27, 2023 at 12:40:53PM +0200, Abel Vesa wrote:
>>>> Currently, there are cases when a domain needs to remain enabled until
>>>> the consumer driver probes. Sometimes such consumer drivers may be built
>>>> as modules. Since the genpd_power_off_unused is called too early for
>>>> such consumer driver modules to get a chance to probe, the domain, since
>>>> it is unused, will get disabled. On the other hand, the best time for
>>>> an unused domain to be disabled is on the provider's sync_state
>>>> callback. So, if the provider has registered a sync_state callback,
>>>> assume the unused domains for that provider will be disabled on its
>>>> sync_state callback. Also provide a generic sync_state callback which
>>>> disables all the domains unused for the provider that registers it.
>>>>
>>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>>> ---
>>>>
>>>> This approach has been applied for unused clocks as well.
>>>> With this patch merged in, all the providers that have sync_state
>>>> callback registered will leave the domains enabled unless the provider's
>>>> sync_state callback explicitly disables them. So those providers will
>>>> need to add the disabling part to their sync_state callback. On the
>>>> other hand, the platforms that have cases where domains need to remain
>>>> enabled (even if unused) until the consumer driver probes, will be able,
>>>> with this patch in, to run without the pd_ignore_unused kernel argument,
>>>> which seems to be the case for most Qualcomm platforms, at this moment.
>>>
>>> I recently encountered a related issue on a Qualcomm platform with a
>>> v6.2-rc kernel, which includes 3a39049f88e4 ("soc: qcom: rpmhpd: Use
>>> highest corner until sync_state"). The issue involves a DT node with a
>>> rpmhpd, the DT node is enabled, however the corresponding device driver
>>> is not enabled in the kernel. In such a scenario the sync_state callback
>>> is never called, because the genpd consumer never probes. As a result
>>> the Always-on subsystem (AOSS) of the SoC doesn't enter sleep mode during
>>> system suspend, which results in a substantially higher power consumption
>>> in S3.
>>>
>>> I wonder if genpd (and some other frameworks) needs something like
>>> regulator_init_complete(), which turns off unused regulators 30s after
>>> system boot. That's conceptually similar to the current
>>> genpd_power_off_unused(), but would provide time for modules being loaded.
>>
>> I think the overall goal is to move away from ad-hoc implementations like
>> clk_disable_unused/genpd_power_off_unused/regulator_init_complete towards
>> the sync_state.
> 
> I generally agree with the goal of using common mechanisms whenever possible.
> 
>> So inherently one either has to provide drivers for all devices in question
>> or disable unused devices in DT.
> 
> I don't think that's a great solution, it essentially hands the issue down to
> the users or downstream maintainers of the kernel, who might not be aware that
> there is an issue, nor know about the specifics of genpd (or interconnects and
> clocks which have similar problems).

The goal is to move the control down to individual drivers. Previously 
we had issues with clk_disable_unused() disabling mdss/mdp clocks 
incorrectly, which frequently led to broken display output. Other 
clock/genpd/regulator drivers might have other internal dependencies. 
Thus it is not really possible to handle resource shutdown in the common 
  (framework) code.

> 
> In general symptoms are probably subtle, like a (potentially substantially)
> increased power consumption during system suspend. The issue might have been
> introduced by an update to a newer kernel, which now includes a DT node for a
> new SoC feature which wasn't supported by the 'old' kernel. It's common
> practice to use the 'old' .config, at least as a starting point, which
> obviously doesn't enable the new driver. That happend to me with [1] when
> testing v6.1. It took me quite some time to track the 'culprit' commit down
> and then some debugging to understand what's going on. Shortly after that I
> ran into a related issue involving genpds when testing v6.2-rc, which again
> took a non-trivial amount of time to track down (and I'm familiar with the SoC
> platform and the general nature of the issue). I don't think it's reasonable
> to expect every user/downstream maintainer of an impacted system to go through
> this, one person at a time.

I think it would be nice to have some way of 'sync_pending' debug 
available (compare this to debugfs/devices_deferred).

Note, we are trying to make sure that all supported drivers are enabled 
at least as modules (if possible). If we fail, please send a patch 
fixing the defconfig.

> Maybe there could be a generic solution for drivers with a 'sync_state'
> callback, e.g. a the driver (or framework) could have a 'sync_state_timeout'
> callback (or similar), which is called by the driver framework if 'sync_state'
> wasn't called (for example) 30s after the device was probed. Then the provider
> can power off or throttle unclaimed resources.

I might be missing a point somewhere, but for me it looks like a logical 
solution. Please send a proposal.

-- 
With best wishes
Dmitry

