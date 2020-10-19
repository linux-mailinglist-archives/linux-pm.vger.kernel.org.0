Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDAD2925EE
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 12:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgJSKfn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 06:35:43 -0400
Received: from foss.arm.com ([217.140.110.172]:54764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbgJSKfm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Oct 2020 06:35:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFEE430E;
        Mon, 19 Oct 2020 03:35:40 -0700 (PDT)
Received: from [10.57.15.200] (unknown [10.57.15.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2E623F66E;
        Mon, 19 Oct 2020 03:35:37 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Clarify abstract scale usage for power values in
 Energy Model, EAS and IPA
To:     Quentin Perret <qperret@google.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Nayak, Rajendra" <rnayak@codeaurora.org>
References: <f660731e-132b-2514-f526-d7123ed3522c@arm.com>
 <d04019bd-9e85-5f3e-2a1b-66780b8df3dc@linaro.org>
 <3e3dd42c-48ac-7267-45c5-ca88205611bd@arm.com>
 <00ceec64-3273-bb4a-6f38-22de8d877ab5@linaro.org>
 <CAJZ5v0hV8fwRnADdjiiF=zapO3AE6=_W_PeOQ_WhUirCcFkgdA@mail.gmail.com>
 <e321191c-61d2-a15d-47c2-653b277984ca@linaro.org>
 <20201016121844.GA2420691@google.com>
 <b3c6d7a5-0564-6e84-77ff-9afe10d7ee27@linaro.org>
 <20201016130905.GA2426638@google.com>
 <deffb2b4-34cb-3f46-af89-cc216d1cf5c5@arm.com>
 <20201016160218.GC2426638@google.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d8ea69a4-515d-b06c-368f-47bb212e071f@arm.com>
Date:   Mon, 19 Oct 2020 11:35:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201016160218.GC2426638@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/16/20 5:02 PM, Quentin Perret wrote:
> On Friday 16 Oct 2020 at 15:42:57 (+0100), Lukasz Luba wrote:
>> Do you mean a new entry in DT which will be always below
>> 'dynamic-power-coefficient' and/or 'sustainable-power' saying the unit
>> of above value?
> 
> Yes, something like that.
> 
>> There was discussion with Rob (and Doug) about this. I got the
>> impression he was against any new DT stuff [1].
>> We don't have to, I think we all agree that DT will only support mW.
> 
> Right, I agree this is a 'nice-to-have'.
> 
>> I have agreed to this idea having a 'flag' inside EM [2], which
>> indicates the mW or bogoWatts. It could be set via API:
>> em_dev_register_perf_domain() and this new last argument.
>>
>> I can write that patch. There is only two usage (3rd is on LKML) of
>> that function. The DT way, which is via:
>> dev_pm_opp_of_register_em() will always set 'true';
>> Driver direct calls of em_dev_register_perf_domain(), will have to
>> set appropriate value ('true' or 'false'). The EM struct em_perf_domain
>> will have the new bool field set based on that.
>> Is it make sense?
> 
> I had something more complicated in mind, where units are arbitrary
> ('milliwats', 'scmi-bogowatts', ...) as that would help if units can be
> specified in the DT too, but if we don't care about that then yes I
> suppose a boolean flag should do.

Thank you Quentin for help in sorting this out.
I'll send the v3.

Regards,
Lukasz

> 
> Thanks!
> Quentin
> 
