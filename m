Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B74F2A6C3C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 18:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgKDRxB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 12:53:01 -0500
Received: from foss.arm.com ([217.140.110.172]:41210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKDRxB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Nov 2020 12:53:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16965139F;
        Wed,  4 Nov 2020 09:53:00 -0800 (PST)
Received: from [192.168.0.11] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01BAC3F718;
        Wed,  4 Nov 2020 09:52:57 -0800 (PST)
Subject: Re: [PATCH v3 2/3] opp/of: Allow empty opp-table with opp-shared
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com
References: <20201102120115.29993-1-nicola.mazzucato@arm.com>
 <20201102120115.29993-3-nicola.mazzucato@arm.com>
 <20201103050141.kiuyotzt4brisch7@vireshk-i7>
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
Message-ID: <9f442724-df13-d582-717d-535cc9c9c9f1@arm.com>
Date:   Wed, 4 Nov 2020 17:54:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201103050141.kiuyotzt4brisch7@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh, thanks for looking into this.

On 11/3/20 5:01 AM, Viresh Kumar wrote:
> On 02-11-20, 12:01, Nicola Mazzucato wrote:
>> The opp binding now allows to have an empty opp table and shared-opp to
>> merely describe a hw connection among devices (f/v lines).
>>
>> When initialising an opp table, allow such case by:
>> - treating some errors as warnings
>> - do not mark empty tables as shared
>> - don't fail on empty table
>>
>> Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
>> ---
>>  drivers/opp/of.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
>> index 874b58756220..b0230490bb31 100644
>> --- a/drivers/opp/of.c
>> +++ b/drivers/opp/of.c
>> @@ -157,6 +157,11 @@ static void _opp_table_free_required_tables(struct opp_table *opp_table)
>>  /*
>>   * Populate all devices and opp tables which are part of "required-opps" list.
>>   * Checking only the first OPP node should be enough.
>> + *
>> + * Corner case: empty opp table and opp-shared found. In this case we set
>> + * unconditionally the opp table access to exclusive, as the opp-shared property
>> + * is used purely to describe hw connections. Such information will be retrieved
>> + * via dev_pm_opp_of_get_sharing_cpus().
>>   */
>>  static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>>  					     struct device *dev,
>> @@ -169,7 +174,9 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>>  	/* Traversing the first OPP node is all we need */
>>  	np = of_get_next_available_child(opp_np, NULL);
>>  	if (!np) {
>> -		dev_err(dev, "Empty OPP table\n");
>> +		dev_warn(dev, "Empty OPP table\n");
>> +
>> +		opp_table->shared_opp = OPP_TABLE_ACCESS_EXCLUSIVE;
> 
> I am not sure I understand the reasoning behind this.

Initially I thought to place a comment right there but I ended up with an
explanation of this case at the top of this function (the corner-case). It
probably also needs more details..
Basically, on this case - empty opp table & opp-shared - we limit the scope of
opp-shared to *only* tell us about hw description, and not marking the opp
points as shared, since they are not present in DT. It would be the equivalent
of describing that devices share clock/voltage lines, but we can't tell anything
about opp points cause they are not there (in DT).
OTOH If we don't set shared_opp to OPP_TABLE_ACCESS_EXCLUSIVE for that specific
case, we won't be able to add opps for the remaining cpus as the opp core
will find the opps as duplicated. This is a corner case, really.

Please let me know if it's not clear.

Many thanks
Nicola

> 
>>  		return;
>>  	}
>>  
>> @@ -377,7 +384,9 @@ int dev_pm_opp_of_find_icc_paths(struct device *dev,
>>  	struct icc_path **paths;
>>  
>>  	ret = _bandwidth_supported(dev, opp_table);
>> -	if (ret <= 0)
>> +	if (ret == -EINVAL)
>> +		return 0; /* Empty OPP table is a valid corner-case, let's not fail */
>> +	else if (ret <= 0)
>>  		return ret;
>>  
>>  	ret = 0;
>> -- 
>> 2.27.0
> 
