Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F303441EF7
	for <lists+linux-pm@lfdr.de>; Mon,  1 Nov 2021 18:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhKARIL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Nov 2021 13:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231348AbhKARIK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Nov 2021 13:08:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E87CA6120F;
        Mon,  1 Nov 2021 17:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635786336;
        bh=Et+zbnq/w5wA87ahfTfx+EP73rf6WOa27T2AGFinLSo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oeM4+10j7AmpQOY7ONVEniI83qgp0fN3cv6px5tLAdN4nGxxih3MN93rGIKgcmsbB
         HMquaVHAXbzaX0YN34RUECMeT465kDVH+ljQ4MV6vFYDN9nVmfCRtIx+ZJZf5rRMqI
         w0l8286zAeOgwALWDCLxJPfQh6fQzNIAsE+WZpltNCpg/mlm9iSDa9vw8bCWoJn5dq
         mU0/XgSMZMqY0XqiNHW3QGaVHOwzwnwtjHHKNFeJP1rztrs+N84ZIlFRqzFt12DRvN
         4btAeSNLzX9YIAwfeU1XCfSTYGCtqqnNKP39qK6kJLLDsR/dj3a04rgyUtD3kGFC4R
         e+CkJNOk0fKHA==
Message-ID: <e2c22d54-1a2f-3730-f1a0-276a1027d977@kernel.org>
Date:   Mon, 1 Nov 2021 19:05:29 +0200
MIME-Version: 1.0
Subject: Re: SCMI protocol for interconnect scaling
Content-Language: en-US
To:     Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linaro-open-discussions@op-lists.linaro.org" 
        <linaro-open-discussions@op-lists.linaro.org>
Cc:     Sudeep Holla <Sudeep.Holla@arm.com>,
        Cristian Marussi <Cristian.Marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        quic_mdtipton@quicinc.com, quic_viveka@quicinc.com,
        grahamr@codeaurora.org, s.nawrocki@samsung.com,
        a.swigon@samsung.com, abel.vesa@nxp.com, digetx@gmail.com,
        treding@nvidia.com, dawei.chien@mediatek.com,
        henryc.chen@mediatek.com
References: <42432cc2-5cb2-ea74-0980-8575e3a343fd@kernel.org>
 <DU2PR08MB723772CAC1CEE69963675CF682839@DU2PR08MB7237.eurprd08.prod.outlook.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <DU2PR08MB723772CAC1CEE69963675CF682839@DU2PR08MB7237.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 25.10.21 17:55, Souvik Chakravarty wrote:
> Thanks Georgi for initiating this.
> Don’t have too much to add, just some initial thinking on my part below.
>
>> From: Georgi Djakov <djakov@kernel.org>
>> Sent: Thursday, October 21, 2021 12:06 PM
>>
>>
>> Hi all,
>>
>> I am recently getting questions about hooking the interconnect framework to
>> SCMI, so i am starting a discussion on this problem and see who might be
>> interested in it.
>>
>> The SCMI spec contains various protocols like the "Performance domain
>> management protocol". But none of the protocols mentioned in the current
>> spec (3.0) seem to fit well into the concept we are using to scale interconnect
>> bandwidth in Linux. I see that people are working in this area and there is
>> already some support for clocks, resets etc. I am wondering what would be the
>> right approach to support also interconnect bus scaling via SCMI.
> 
> You are right - the current Performance Domain Mgmt. Protocol is not fit for
> purpose for this requirement.
> 
>>
>> The interconnect framework is part of the linux kernel and it's goal is to manage
>> the hardware and tune it to the most optimal power- performance profile
>> according to the aggregated bandwidth demand between the various endpoints
>> in the system (SoC). This is based on the requests coming from consumer drivers.
>>
>> As interconnects scaling does not map directly to any of the currently available
>> protocols in the SCMI spec, i am curious whether there is work in progress on
>> some other protocol that could support managing resources based on path
>> endpoints (instead of a single ID). The interconnect framework doesn't populate
>> every possible path, but it exposes endpoints to client drivers and the path
>> lookup is dynamic, based on what the clients request. Maybe the SCMI host
>> could also expose all possible endpoints and let the guest request a path from
>> the host, based on those endpoints.
>>
>> There are already suggestions to create vendor-specific SCMI protocols for that,
>> but i fear that we may end up with more than one protocol for the same thing,
>> so that's why it might be best to discuss it in public and have a common solution
>> that works for everyone.
> 
> +1. If there is a common requirement to be found that is always the best. Vendor specific
> protocols might end up with extensibility issues once a similar protocol gets
> supported in a future version of the specification.

Thanks Souvik! Maybe we should try to implement a vendor protocol as
a starting point? I am adding more people who might be interested in
SCMI - folks that have interconnect drivers already merged or in the
process or doing that. The goal is to see who is interested in this
and to figure out a list of requirements for the new protocol.

Apologies to people not interested in ARM's System Control and 
Management Interface. Please ignore this email.

Thanks,
Georgi
