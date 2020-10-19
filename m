Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D42D2923E6
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 10:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgJSItO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 04:49:14 -0400
Received: from foss.arm.com ([217.140.110.172]:52532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbgJSItO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Oct 2020 04:49:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8E85101E;
        Mon, 19 Oct 2020 01:49:13 -0700 (PDT)
Received: from [10.57.14.99] (unknown [10.57.14.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84C043F66E;
        Mon, 19 Oct 2020 01:49:11 -0700 (PDT)
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
References: <20200924095347.32148-3-nicola.mazzucato@arm.com>
 <20201006071909.3cgz7i5v35dgnuzn@vireshk-i7>
 <2417d7b5-bc58-fa30-192c-e5991ec22ce0@arm.com>
 <20201008110241.dcyxdtqqj7slwmnc@vireshk-i7> <20201008150317.GB20268@arm.com>
 <56846759-e3a6-9471-827d-27af0c3d410d@arm.com>
 <20201009053921.pkq4pcyrv4r7ylzu@vireshk-i7> <20201012154915.GD16519@bogus>
 <20201012165219.GA3573@arm.com>
 <17819d4d-9e7e-9a38-4227-d0d10a0749f1@arm.com>
 <20201014042531.r7iykzygkvmpsqck@vireshk-i7>
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
Message-ID: <503af305-77a4-964a-ed17-8df8b4e3a546@arm.com>
Date:   Mon, 19 Oct 2020 09:50:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201014042531.r7iykzygkvmpsqck@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

thank you for your suggestion on using 'opp-shared'.
I think it could work for most of the cases we explained earlier.

Summarising, there are two parts of this entire proposal:
1) where/how to get the information: now we are focusing on taking advantage of
'opp-shared' within an empty opp table
2) and how/where this information will be consumed

Further details below:

1) a CPUFreq driver that takes the OPPs from firmware, can call
dev_pm_opp_of_get_sharing_cpus like you suggested. When doing so, a provided
cpumaksk will be populated with the corresponding cpus that share the same
(empty) table opp in DT.
All good so far.
The current opp core is not expecting an empty table and therefore some errors
are thrown when this happens.
Since we are now allowing this corner-case, I am presenting below where I think
some minor corrections may be needed:

--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
        struct device_node *required_np, *np;
        int count, i;

        /* Traversing the first OPP node is all we need */
        np = of_get_next_available_child(opp_np, NULL);
        if (!np) {
-               dev_err(dev, "Empty OPP table\n");
+               dev_warn(dev, "Empty OPP table\n");
+
+               /*
+                * With empty table we remove shared_opp. This is to leave the
+                * responsibility to decide which opp are shared to the opp users
+                */
+               opp_table->shared_opp = OPP_TABLE_ACCESS_EXCLUSIVE;
+
                return;
        }

@@ int dev_pm_opp_of_find_icc_paths(struct device *dev,
        int ret, i, count, num_paths;
        struct icc_path **paths;

        ret = _bandwidth_supported(dev, opp_table);
-       if (ret <= 0)
+       if (ret == -EINVAL)
+               return 0; /* Empty OPP table is a valid corner-case, let's not
fail */
+       else if (ret <= 0)
                return ret;

The above are not 'strictly' necessary to achieve the intended goal, but they
make clearer that an empty table is now allowed and not an error anymore.
What it is your point of view on this?

In addition, I think it would also be appropriate to update the documentation
(Documentation/devicetree/bindings/opp/opp.txt) to reflect this new case
(required properties etc).
Any different thoughts?

2) Once the driver gets the 'performance dependencies' by
dev_pm_opp_of_get_sharing_cpus(), this information will have to be shared with
EAS, thermal, etc.. The natural way to do so would be to add a new cpumask like
I proposed in this RFC.
I see this as an improvement for the whole subsystem and a scalable choice since
we can unambiguously provide the correct information to whoever needs it, given
that we don't enforce "hw dependencies" for related_cpus.
The changes would be trivial (it's in the original RFC).
On the other hand, we can't unload this h/w detail into related_cpus IMO as we
are dealing with per-cpu systems in this context.
Hope it makes sense?

Once we are pretty much aligned with our ideas, I can run some other tests and
make a V3.

Thank you very much,

Best regards
Nicola

On 10/14/20 5:25 AM, Viresh Kumar wrote:
> On 12-10-20, 18:18, Lukasz Luba wrote:
>> On 10/12/20 5:52 PM, Ionela Voinescu wrote:
>>> On Monday 12 Oct 2020 at 16:49:30 (+0100), Sudeep Holla wrote:
>>>> On Fri, Oct 09, 2020 at 11:09:21AM +0530, Viresh Kumar wrote:
>>>>> - I wonder if we can keep using that instead of creating new bindings
>>>>>    for exact same stuff ? Though the difference here would be that the
>>>>>    OPP may not have any other entries.
>>>>
>>>> Well summarised, sorry for chiming in late. I could have not summarised
>>>> any better. Just saw the big thread and was thinking of summarising.
>>>> If the last point on OPP is possible(i.e. no OPP entries but just use
>>>> it for fetch the information) for $subject patch is trying to achieve,
>>>> then it would be good.
> 
> Under normal circumstances, I wouldn't have suggested empty opp-tables
> for sure but it doesn't seem worth adding another binding to get this
> information out :)
> 
>>>
>>> Just to put in my two pennies worth: using opp-shared (in possibly empty
>>> OPP table) as alternative to cpu-perf-dependencies sounds good enough
>>> to me as well.
>>
>> +1
> 
> Now that (almost) everyone agrees, I don't think we need to make any
> change anywhere, in code or bindings. This should work right now as
> well.  The code should never try to create OPP tables and the core
> will not create one. Your driver (which want to get this information
> out of empty OPP tables) shall call dev_pm_opp_of_get_sharing_cpus(),
> which just parses the DT to get this information out.
> 
