Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED1C2B4315
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 12:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgKPLn6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 06:43:58 -0500
Received: from foss.arm.com ([217.140.110.172]:38346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgKPLn6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Nov 2020 06:43:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C2B6101E;
        Mon, 16 Nov 2020 03:43:57 -0800 (PST)
Received: from [10.57.59.112] (unknown [10.57.59.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E2333F70D;
        Mon, 16 Nov 2020 03:43:55 -0800 (PST)
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
 <9f442724-df13-d582-717d-535cc9c9c9f1@arm.com>
 <20201105044118.k75um7gcz3ffkphc@vireshk-i7>
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
Message-ID: <fead451e-329b-465c-5055-f5dadd58e056@arm.com>
Date:   Mon, 16 Nov 2020 11:45:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201105044118.k75um7gcz3ffkphc@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

sorry for being late in replying.


On 11/5/20 4:41 AM, Viresh Kumar wrote:
> On 04-11-20, 17:54, Nicola Mazzucato wrote:
>> Initially I thought to place a comment right there but I ended up with an
>> explanation of this case at the top of this function (the corner-case). It
>> probably also needs more details..
> 
> I read it earlier as well but yeah, that wasn't good enough for me to
> understand what you are doing.
> 
>> Basically, on this case - empty opp table & opp-shared - we limit the scope of
>> opp-shared to *only* tell us about hw description, and not marking the opp
>> points as shared, since they are not present in DT.
> 
> It doesn't matter where the OPP table entries are coming from. The OPP
> table should be marked shared if it is found to be shared.
> 
>> It would be the equivalent
>> of describing that devices share clock/voltage lines, but we can't tell anything
>> about opp points cause they are not there (in DT).
> 
> Its okay, even then we should set the right flags here. It is really
> confusing that we blindly set it as exclusive, even though it may be
> shared.
> 
>> OTOH If we don't set shared_opp to OPP_TABLE_ACCESS_EXCLUSIVE for that specific
>> case, we won't be able to add opps for the remaining cpus as the opp core
>> will find the opps as duplicated. This is a corner case, really.
> 
> Hmm, I am not sure where you fail and how but this should be set to
> OPP_TABLE_ACCESS_EXCLUSIVE only if the OPP table isn't shared. else it
> should be OPP_TABLE_ACCESS_SHARED.
> 
Thanks for providing more details around the meaning of opp-shared, much
appreciated. I had some time to play a bit more, and yes, there is no need to
set shared_opp to OPP_TABLE_ACCESS_EXCLUSIVE. A minimal change in the driver
sequence would suffice.

I will remove that in the V4.

Many thanks,
Nicola
