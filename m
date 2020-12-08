Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841F32D2417
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 08:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgLHHOO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 02:14:14 -0500
Received: from foss.arm.com ([217.140.110.172]:43164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgLHHOO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Dec 2020 02:14:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48A8231B;
        Mon,  7 Dec 2020 23:13:28 -0800 (PST)
Received: from [10.57.34.152] (unknown [10.57.34.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26F033F718;
        Mon,  7 Dec 2020 23:13:26 -0800 (PST)
Subject: Re: [PATCH v4 1/4] dt-bindings/opp: Update documentation for
 opp-shared
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com
References: <20201202172356.10508-1-nicola.mazzucato@arm.com>
 <20201202172356.10508-2-nicola.mazzucato@arm.com>
 <20201208042924.kv7tqsbstoanqham@vireshk-i7>
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
Message-ID: <bfb6a380-645e-d721-4610-be73ab4f2dcd@arm.com>
Date:   Tue, 8 Dec 2020 07:15:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201208042924.kv7tqsbstoanqham@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

thanks for your comments. I will update subject and content as you suggested.

Regards,
Nicola

On 12/8/20 4:29 AM, Viresh Kumar wrote:
> Subject should rather be:
> 
> dt-bindings: opp: Allow empty OPP tables
> 
> On 02-12-20, 17:23, Nicola Mazzucato wrote:
>> Currently the optional property opp-shared is used within an opp table
>> to tell that a set of devices share their clock/voltage lines (and the
>> opp points).
>> It is therefore possible to use an empty opp table to convey only that
>> information, useful in situations where the opp points are provided via
>> other means (hardware. firmware, etc).
>>
>> Update the documentation to remark this additional case and provide an
>> example.
>>
>> Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
>> ---
>>  Documentation/devicetree/bindings/opp/opp.txt | 53 +++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
>> index 9847dfeeffcb..a5f1f993eab9 100644
>> --- a/Documentation/devicetree/bindings/opp/opp.txt
>> +++ b/Documentation/devicetree/bindings/opp/opp.txt
>> @@ -72,6 +72,9 @@ Optional properties:
>>    switch their DVFS state together, i.e. they share clock/voltage/current lines.
>>    Missing property means devices have independent clock/voltage/current lines,
>>    but they share OPP tables.
>> +  This optional property can be used without any OPP nodes when its only purpose
>> +  is to describe a dependency of clock/voltage/current lines among a set of
>> +  devices.
> 
> And instead of this, we should rather update "OPP nodes:" section like
> this:
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 9847dfeeffcb..28077ce3a845 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -63,11 +63,13 @@ This describes the OPPs belonging to a device. This node can have following
>  - compatible: Allow OPPs to express their compatibility. It should be:
>    "operating-points-v2".
>  
> +Optional properties:
>  - OPP nodes: One or more OPP nodes describing voltage-current-frequency
>    combinations. Their name isn't significant but their phandle can be used to
> -  reference an OPP.
> +  reference an OPP. These are mandatory except for the case where the OPP table
> +  is present only to indicate dependency between devices using the opp-shared
> +  property.
>  
> -Optional properties:
>  - opp-shared: Indicates that device nodes using this OPP Table Node's phandle
>    switch their DVFS state together, i.e. they share clock/voltage/current lines.
>    Missing property means devices have independent clock/voltage/current lines,
> 
