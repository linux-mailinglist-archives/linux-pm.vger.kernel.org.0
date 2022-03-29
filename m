Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC564EAEA3
	for <lists+linux-pm@lfdr.de>; Tue, 29 Mar 2022 15:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbiC2Nlh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Mar 2022 09:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237412AbiC2Nlg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2022 09:41:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF8BD1FA54;
        Tue, 29 Mar 2022 06:39:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7055D23A;
        Tue, 29 Mar 2022 06:39:53 -0700 (PDT)
Received: from [10.57.7.161] (unknown [10.57.7.161])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AC333F73B;
        Tue, 29 Mar 2022 06:39:50 -0700 (PDT)
Message-ID: <85f6a95e-24c3-0119-d43f-e57a3996280d@arm.com>
Date:   Tue, 29 Mar 2022 14:39:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [0/8] Introduce support for artificial Energy Model
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mka@chromium.org, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, sudeep.holla@arm.com,
        matthias.bgg@gmail.com
References: <20220316235211.29370-1-lukasz.luba@arm.com>
 <YkMJyRblpNMnv8ub@e120937-lin>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <YkMJyRblpNMnv8ub@e120937-lin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Cristian,

On 3/29/22 14:29, Cristian Marussi wrote:
> On Wed, Mar 16, 2022 at 11:52:03PM +0000, Lukasz Luba wrote:
>> Hi all,
>>
> 
> Hi Lukasz,
> 
>> This patch set adds new callback and support for artificial Energy Model (EM).
>> The new EMs have artificially generated performance states.
>> Such EMs can be created from lean information sources, such
>> as the relative energy efficiency between CPUs. The ACPI based
>> platforms provide this information
>> (ACPI 6.4, s5.2.12.14 'GIC CPU Interface (GICC) Structure'
>> 'Processor Power efficiency Class' field).
>>
>> Artificial EMs might require to directly provide the 'cost' of
>> the generated performance state. This patch set adds a new callback
>> .get_cost() for this. The EM framework does not force any model
>> or formula, it's up to the platform code.
>>
>> Artificial EMs aim to leverage the Energy Aware Scheduler
>> (EAS). Other frameworks relying on performance states
>> information (i.e. IPA/DTPM) must be informed of the
>> EM type and might be prevented from using it. This patch
>> sets also does this by introducing a new flag:
>> EM_PERF_DOMAIN_ARTIFICIAL.
>>
>> The patch set is based on current linux-next, where some
>> changes to OPP & EM are queuing.
>>
>> The patch set also contains (patch 7/8 and patch 8/8) logic which prevents
>> two EM's client frameworks from using this new EM type. Some other approach,
>> using 'milli-watts', has been proposed and discussed, but refused [1].
>> This new flag is more precised and should not leave space for
>> wrong interpretation.
>>
>> Shortly after this patch set you will see a patch set implementing the
>> platform code and registering this new EM.
>>
> 
> Just to let you know that in the few days I'm going to post the first
> chunk of some SCMIv3.1 additions that includes also (as you probably
> know) the SCMI Perf protocol support for reporting perf_domain costs in
> micro-watts and not only in milli-watts.
> 
> Given that it does not seem that as of now the em_ API used by the SCMI
> cpufreq driver can make use of this new scale (and being not at all
> familiar with EM/EAS for sure :P), the SCMIv3.1 'Perf micro-watts' patch
> which I will post (I'll CC you) does NOT expose any new interface but only
> takes care to store the new micro-watts capability internally in a flag
> (if advertised by an SCMIv3.1 backend server), so that, basically, you'll
> keep seeing from the SCMI cpufreq driver that the scale is milli-watt
> (when milli-watts are used of course) or non-milli-watt (for abstract and
> micro-watts scales).

Sounds good!

> 
> This is intended to be of course a first step, laying out just the bare
> minimum commmon internal SCMI support, until we figure out how to properly
> expose this from the SCMI Perf in order to make it usable for EM.
> (if neeeded at all).
> 

I had such a patch for the EM, to keep the power in micro-Watts.
We can glue these two layers (high level EM and low layer SCMI
perf). Let's sort it out.

Regards,
Lukasz
