Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9459B13B5F3
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 00:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgANXg2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 18:36:28 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:35726 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728757AbgANXgY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 18:36:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579044983; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=7+8Ma8yfcl2diOB4I5famBBLS13KA3B5gNUsRjC85BE=; b=tgOcFVfA4qpnrmUsjd7xH5z4P2sUDqkFNJB4mR+hv2pzWC+6fi8zNMZkuZqgBPfnIxzU4bee
 /ANYff1hnVWZ6QliXsc4eTr8i9rYf/jcdkimnV358QQjZ/E5unIX9XUNjvHJ43QX+Xz4JgtE
 uqbe9mXmpmFjqEKe7aNS4zTo790=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1e5076.7fad57bb9960-smtp-out-n02;
 Tue, 14 Jan 2020 23:36:22 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A47C1C4479F; Tue, 14 Jan 2020 23:36:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.46.162.237] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6722CC433CB;
        Tue, 14 Jan 2020 23:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6722CC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
Subject: Re: [PATCH v1 0/4] Split SDM845 interconnect nodes and consolidate
 RPMh support
To:     Evan Green <evgreen@google.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, sboyd@kernel.org,
        Lina Iyer <ilina@codeaurora.org>,
        Sean Sweeney <seansw@qti.qualcomm.com>,
        Alex Elder <elder@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pm@vger.kernel.org
References: <1576475925-20601-1-git-send-email-daidavid1@codeaurora.org>
 <CAE=gft6sxsZfvPZZXKqbEMjCH_hGKXp_1MS3qTAz6hmMPfn09A@mail.gmail.com>
From:   David Dai <daidavid1@codeaurora.org>
Message-ID: <df9e58ef-7b97-7456-09fb-c13f53207cbb@codeaurora.org>
Date:   Tue, 14 Jan 2020 15:36:19 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAE=gft6sxsZfvPZZXKqbEMjCH_hGKXp_1MS3qTAz6hmMPfn09A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Evan,

On 1/7/2020 3:45 PM, Evan Green wrote:
> On Sun, Dec 15, 2019 at 9:59 PM David Dai <daidavid1@codeaurora.org> wrote:
>> While there are no current consumers of the SDM845 interconnect device in
>> devicetree, take this opportunity to redefine the interconnect device nodes
>> as the previous definitions of using a single child node under the apps_rsc
>> device did not accurately capture the description of the hardware.
>> The Network-On-Chip (NoC) interconnect devices should be represented in a
>> manner akin to QCS404 platforms[1] where there is a separation of NoC devices
>> and its RPM/RPMh counterparts.
>>
>> The bcm-voter devices are representing the RPMh devices that the interconnect
>> providers need to communicate with and there can be more than one instance of
>> the Bus Clock Manager (BCM) which can live under different instances of Resource
>> State Coordinators (RSC). There are display use cases where consumers may need
>> to target a different bcm-voter (Some display specific RSC) than the default,
>> and there needs to be a way to represent this connection in devicetree.
> So for my own understanding, the problem here is that things want to
> vote for interconnect bandwidth within a specific RSC context? Where
> normally the RSC context is simply "Apps@EL1", we might also have
> "Apps@EL3" for trustzone, or in the case we're coding for,
> "display-specific RSC context". I guess this context might stay on
> even if Apps@EL1 votes are entirely discounted or off?
That's correct, the state of those votes are tied to the state of that 
execution environment. So even if the Apps CPU goes into a low power 
mode, other context specific vote will still stick.
>   So then would
> there be an additional interconnect provider for "display context RSC"
> next to apps_bcm_voter? Would that expose all the same nodes as
> apps_bcm_voter, or a different set of nodes?

We trim down the topology to what each execution environment needs, so 
each EE really only "sees" a subset of the entire SoC's topology. In 
this specific case, the display context RSC would only expose a small 
subset of the topology that Apps@EL1 would see.

>
> Assuming it's exposing some of the same nodes as apps_bcm_voter, the
> other way to do this would be increasing #interconnect-cells, and
> putting the RSC context there. Did you choose not to go that way
> because nearly all the clients would end up specifying the same thing
> of "Apps@EL1"?
That's correct, the majority of the consumers will stay with default 
Apps@EL1 context.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
