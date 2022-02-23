Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31ED4C0EB4
	for <lists+linux-pm@lfdr.de>; Wed, 23 Feb 2022 09:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbiBWJAT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Feb 2022 04:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbiBWJAT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Feb 2022 04:00:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 612CA7CDE1;
        Wed, 23 Feb 2022 00:59:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29303D6E;
        Wed, 23 Feb 2022 00:59:52 -0800 (PST)
Received: from [10.57.9.184] (unknown [10.57.9.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36B4C3F5A1;
        Wed, 23 Feb 2022 00:59:50 -0800 (PST)
Message-ID: <b6682d6f-a6ae-8a82-68c3-13840c02d178@arm.com>
Date:   Wed, 23 Feb 2022 08:59:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [[PATCH v2 2/2] OPP: Add 'opp-microwatt' parsing for advanced EM
 registration
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220222140746.12293-1-lukasz.luba@arm.com>
 <20220222140746.12293-3-lukasz.luba@arm.com>
 <20220223055357.t3wulpla64vt3xus@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220223055357.t3wulpla64vt3xus@vireshk-i7>
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



On 2/23/22 05:53, Viresh Kumar wrote:
> On 22-02-22, 14:07, Lukasz Luba wrote:
>> +static int _of_find_opp_microwatt_property(struct device *dev)
>> +{
>> +	unsigned long freq = 0;
>> +	struct dev_pm_opp *opp;
>> +	struct device_node *np;
>> +	struct property *prop;
>> +
>> +	/* We only support "operating-points-v2" */
>> +	np = dev_pm_opp_of_get_opp_desc_node(dev);
>> +	if (!np)
>> +		return -EINVAL;
>> +
>> +	of_node_put(np);
>> +
>> +	/* Check if an OPP has needed property */
>> +	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
>> +	if (IS_ERR(opp))
>> +		return -EINVAL;
>> +
>> +	prop = of_find_property(opp->np, "opp-microwatt", NULL);
>> +	dev_pm_opp_put(opp);
>> +	if (!prop)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
> 
> Please follow everything just like opp-microvolt is defined. Create a new field
> in the struct dev_pm_opp, initialize it only once when the OPP is created, that
> field should be used here instead of parsing the DT here again. There also needs
> to be a debug file in debugfs for this new field.
> 
> Search for "supply" and "microvolt" in the OPP core, you will see all the places
> that need it.
> 

OK, so you want to have this available for the whole system. I can do
that. I would go for one value of power and try to fit into the
opp_parse_supplies() code. As far as I can see in the
dev_pm_opp_get_voltage() the simple solution: supplier[0] and u_volt
is used. I would go for similar solution for u_watt.
There is even a single u_amp and no _max, _min variants, so should be
good..
