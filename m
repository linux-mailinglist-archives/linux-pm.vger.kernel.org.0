Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BB4292840
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 15:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgJSNfQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 09:35:16 -0400
Received: from foss.arm.com ([217.140.110.172]:57736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbgJSNfQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Oct 2020 09:35:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 212E6D6E;
        Mon, 19 Oct 2020 06:35:15 -0700 (PDT)
Received: from [10.57.14.99] (unknown [10.57.14.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECC563F719;
        Mon, 19 Oct 2020 06:35:12 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        chris.redpath@arm.com, morten.rasmussen@arm.com,
        linux-arm-kernel@lists.infradead.org
References: <2417d7b5-bc58-fa30-192c-e5991ec22ce0@arm.com>
 <20201008110241.dcyxdtqqj7slwmnc@vireshk-i7> <20201008150317.GB20268@arm.com>
 <56846759-e3a6-9471-827d-27af0c3d410d@arm.com>
 <20201009053921.pkq4pcyrv4r7ylzu@vireshk-i7> <20201012154915.GD16519@bogus>
 <20201012165219.GA3573@arm.com>
 <17819d4d-9e7e-9a38-4227-d0d10a0749f1@arm.com>
 <20201014042531.r7iykzygkvmpsqck@vireshk-i7>
 <503af305-77a4-964a-ed17-8df8b4e3a546@arm.com>
 <20201019094633.m3yvxurfm2xwsb6a@vireshk-i7>
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
Message-ID: <e3b3a583-5e0f-f512-85e6-81c55a0e6db5@arm.com>
Date:   Mon, 19 Oct 2020 14:36:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201019094633.m3yvxurfm2xwsb6a@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,


On 10/19/20 10:46 AM, Viresh Kumar wrote:
> On 19-10-20, 09:50, Nicola Mazzucato wrote:
>> Hi Viresh,
>>
>> thank you for your suggestion on using 'opp-shared'.
>> I think it could work for most of the cases we explained earlier.
>>
>> Summarising, there are two parts of this entire proposal:
>> 1) where/how to get the information: now we are focusing on taking advantage of
>> 'opp-shared' within an empty opp table
>> 2) and how/where this information will be consumed
>>
>> Further details below:
>>
>> 1) a CPUFreq driver that takes the OPPs from firmware, can call
>> dev_pm_opp_of_get_sharing_cpus like you suggested. When doing so, a provided
>> cpumaksk will be populated with the corresponding cpus that share the same
>> (empty) table opp in DT.
>> All good so far.
> 
> Great.
> 
>> The current opp core is not expecting an empty table and therefore some errors
>> are thrown when this happens.
>> Since we are now allowing this corner-case, I am presenting below where I think
>> some minor corrections may be needed:
>>
>> --- a/drivers/opp/of.c
>> +++ b/drivers/opp/of.c
>> @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>>         struct device_node *required_np, *np;
>>         int count, i;
>>
>>         /* Traversing the first OPP node is all we need */
>>         np = of_get_next_available_child(opp_np, NULL);
>>         if (!np) {
>> -               dev_err(dev, "Empty OPP table\n");
>> +               dev_warn(dev, "Empty OPP table\n");
>> +
>> +               /*
>> +                * With empty table we remove shared_opp. This is to leave the
>> +                * responsibility to decide which opp are shared to the opp users
>> +                */
>> +               opp_table->shared_opp = OPP_TABLE_ACCESS_EXCLUSIVE;
>> +
>>                 return;
>>         }
>>
>> @@ int dev_pm_opp_of_find_icc_paths(struct device *dev,
>>         int ret, i, count, num_paths;
>>         struct icc_path **paths;
>>
>>         ret = _bandwidth_supported(dev, opp_table);
>> -       if (ret <= 0)
>> +       if (ret == -EINVAL)
>> +               return 0; /* Empty OPP table is a valid corner-case, let's not
>> fail */
>> +       else if (ret <= 0)
>>                 return ret;
>>
>> The above are not 'strictly' necessary to achieve the intended goal, but they
>> make clearer that an empty table is now allowed and not an error anymore.
>> What it is your point of view on this?
> 
> Why is this stuff getting called in your case ? We shouldn't be trying
> to create an OPP table here and it should still be an error in the
> code if we are asked to parse an empty OPP table.

A driver that gets a set of opp-points from f/w needs to add them to each
device. To do so, it will call dev_pm_opp_add(). If an opp_table struct for this
device is not found, one will be created and the opp-point will be added to it.
When allocation a new opp_table the opp will try to initialise it by parsing the
values in DT. It will also try to find_icc_paths.

Everything happens silently if we don't have a table in DT.

> 
>> In addition, I think it would also be appropriate to update the documentation
>> (Documentation/devicetree/bindings/opp/opp.txt) to reflect this new case
>> (required properties etc).
>> Any different thoughts?
> 
> Yes, this needs a small update in the required-opps section.

Cool, I'll sketch something in the next version.

> 
>> 2) Once the driver gets the 'performance dependencies' by
>> dev_pm_opp_of_get_sharing_cpus(), this information will have to be shared with
>> EAS, thermal, etc.. The natural way to do so would be to add a new cpumask like
>> I proposed in this RFC.
>> I see this as an improvement for the whole subsystem and a scalable choice since
>> we can unambiguously provide the correct information to whoever needs it, given
>> that we don't enforce "hw dependencies" for related_cpus.
>> The changes would be trivial (it's in the original RFC).
>> On the other hand, we can't unload this h/w detail into related_cpus IMO as we
>> are dealing with per-cpu systems in this context.
>> Hope it makes sense?
> 
> I will have another look at this stuff, honestly I haven't looked at
> this in detail yet. But I do understand that we can't really use
> related-cpu here without changing its earlier meaning.

Sure. thanks
> 

Hope it helps

Best regards
Nicola
