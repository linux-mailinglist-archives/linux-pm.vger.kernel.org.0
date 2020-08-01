Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92B0234F76
	for <lists+linux-pm@lfdr.de>; Sat,  1 Aug 2020 04:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgHAChR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 22:37:17 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:51838 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728331AbgHAChR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2020 22:37:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596249435; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=OptR6uFR4LgTpWN1RfzXVooY5E2MVRFuTtO4DpUTtsQ=; b=e5cFKha1Z7bAYNIdenGwSX92otuxh5fPtvKVE196jUujKkUpKDzsRPk+YkmNr1r9iOPe8/jl
 +g9+t/sxn6PsiJljP46UHqjM9rE20ca62gRK1J9jTnn3EoNSAHeJTqPlc5Dg2mg3yqCGb0uN
 YBtYtBCYeP2jGv0wr4ycQgz8zQw=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f24d53ef89b692ba2f29173 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 01 Aug 2020 02:36:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C84D1C433C9; Sat,  1 Aug 2020 02:36:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=2.0 tests=ALL_TRUSTED,NICE_REPLY_A,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.117] (ip70-179-20-127.sd.sd.cox.net [70.179.20.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0A4FAC433C6;
        Sat,  1 Aug 2020 02:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A4FAC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
Subject: Re: [PATCH v2 1/2] interconnect: Add sync state support
To:     Saravana Kannan <saravanak@google.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>, okukatla@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200722110139.24778-1-georgi.djakov@linaro.org>
 <20200722110139.24778-2-georgi.djakov@linaro.org>
 <CAGETcx-QM8P2nVxcQJZz+m5Zwi==2qLfinb0FkDXJ7dNVP5bEA@mail.gmail.com>
 <e4f68ae5-5cf7-bac4-e7f2-c074327ea659@codeaurora.org>
 <CAGETcx-i=wBB4Ooch734B0ejK6F5mGPLQ6c_K4FeFyNmMLsL=Q@mail.gmail.com>
From:   Mike Tipton <mdtipton@codeaurora.org>
Message-ID: <df0cfd7c-442b-810b-1bb2-58d628e7fe85@codeaurora.org>
Date:   Fri, 31 Jul 2020 19:36:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx-i=wBB4Ooch734B0ejK6F5mGPLQ6c_K4FeFyNmMLsL=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/30/2020 12:07 PM, Saravana Kannan wrote:
> On Mon, Jul 27, 2020 at 11:18 PM Mike Tipton <mdtipton@codeaurora.org> wrote:
>>
>> On 7/22/2020 10:07 AM, Saravana Kannan wrote:
>>> On Wed, Jul 22, 2020 at 4:01 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>>>
>>>> The bootloaders often do some initial configuration of the interconnects
>>>> in the system and we want to keep this configuration until all consumers
>>>> have probed and expressed their bandwidth needs. This is because we don't
>>>> want to change the configuration by starting to disable unused paths until
>>>> every user had a chance to request the amount of bandwidth it needs.
>>>>
>>>> To accomplish this we will implement an interconnect specific sync_state
>>>> callback which will synchronize (aggregate and set) the current bandwidth
>>>> settings when all consumers have been probed.
>>>>
>>>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>>>> ---
>>>>    drivers/interconnect/core.c           | 61 +++++++++++++++++++++++++++
>>>>    include/linux/interconnect-provider.h |  5 +++
>>>>    2 files changed, 66 insertions(+)
>>>>
>>>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>>>> index e5f998744501..0c4e38d9f1fa 100644
>>>> --- a/drivers/interconnect/core.c
>>>> +++ b/drivers/interconnect/core.c
>>>> @@ -26,6 +26,8 @@
>>>>
>>>>    static DEFINE_IDR(icc_idr);
>>>>    static LIST_HEAD(icc_providers);
>>>> +static int providers_count;
>>>> +static bool synced_state;
>>>>    static DEFINE_MUTEX(icc_lock);
>>>>    static struct dentry *icc_debugfs_dir;
>>>>
>>>> @@ -255,6 +257,12 @@ static int aggregate_requests(struct icc_node *node)
>>>>                           continue;
>>>>                   p->aggregate(node, r->tag, r->avg_bw, r->peak_bw,
>>>>                                &node->avg_bw, &node->peak_bw);
>>>> +
>>>> +               /* during boot use the initial bandwidth as a floor value */
>>>> +               if (!synced_state) {
>>>> +                       node->avg_bw = max(node->avg_bw, node->init_avg);
>>>> +                       node->peak_bw = max(node->peak_bw, node->init_peak);
>>>> +               }
>>>
>>> Sorry I didn't reply earlier.
>>>
>>> I liked your previous approach with the get_bw ops. The v2 approach
>>> forces every interconnect provider driver to set up these values even
>>> if they are okay with just maxing out the bandwidth. Also, if they can
>>> actually query their hardware, this adds additional steps for them.
>>
>> The problem with using something like get_bw() is that while we can
>> dynamically query the HW, we have far less granularity in HW than we
>> have nodes in the framework. We vote at BCM-level granularity, but each
>> BCM can have many nodes. For example, the sdm845 CN0 BCM has 47 nodes.
>> If we implement get_bw() generically, then it would return the BW for
>> each node, which would be the queried BCM vote scaled to account for
>> differences in BCM/node widths. While this could be useful in general as
>> an informational callback, we wouldn't want to use this as a proxy for
>> our initial BW vote requirements. For CN0, we wouldn't want or need to
>> vote 47 times for the same CN0 BCM. Each of the 47 node requests would
>> result in the same BCM request.
> 
> Firstly most people in the list don't know what BCM means. Also, all
> of this is your provider driver specific issues. If you are exposing
> more nodes than available HW granularity, then you might want to
> question why it needs to be done (probably to make aggregation easier
> for the driver). If it's needed, then optimize your get/set() calls by
> caching the value in an internal variable so that you don't send a
> request to your BCM if you haven't changed the value since the last
> request. This is not a reason to not have get_bw() calls at the
> framework level. Other providers might support it and it'd make their
> lives easier.

The nodes capture the HW topology, so they are all needed to expose the 
necessary paths and aggregate properly. However, HW doesn't support 
voting for each node individually. Instead, they are grouped together 
and collections of nodes are voted using a single "BCM". So in addition 
to the node aggregation done in the framework, we also aggregate across 
all nodes belonging to the BCM.

> 
>> All we'd really need is a single node per-BCM to serve as the proxy
>> node. We'd query the HW, scale the queried value for the chosen proxy
>> node, and set init_avg/init_peak appropriately. This would save a lot of
>> unnecessary votes. Based on the current implementation, the set() call
>> in icc_node_add() for initial BW wouldn't trigger any actual HW requests
>> since we only queue BCMs that require updating in the aggregate()
>> callback. However, the set() call in icc_sync_state() would, since we
>> re-aggregate each node that has a non-zero init_avg/init_peak.
> 
> Having a fake "proxy node" seems like a bad internal design. Also,
> have you timed the cost of these calls to justify your concern? If you
> cache the values after aggregation and check before you send it down
> to a "BCM", at worst you get one additional call to rpmh per BCM due
> to this feature. I'm guessing any time delta would be lost as noise
> compared to the boot up time.

It wouldn't be a fake node. It would be one of the real, existing nodes. 
But since we can only query/vote the BCM (and a single BCM can have 
multiple nodes), then we'd just have to choose one node per-BCM in order 
to "hold" the initial BW from boot.

I don't have specific timing numbers offhand. But now that I think about 
it it's a bigger functional issue. If we implement get_bw() to return 
the available BW for each node in the BCM, then our internal BCM 
aggregation will quickly ramp to max. The avg_bw for each node in the 
BCM is summed. If every node in the BCM votes for the queried BW, then 
it will sum to something much higher.

As I mentioned before, we could solve this problem by implementing 
get_bw() to only return non-zero BW for one node per-BCM. This would 
work for the initial proxy voting. The only downside is that it wouldn't 
be a generic "get_bw" callback anymore. It would return our initial BW 
vote instead. That's not a big deal, unless the framework wants to use 
it for other purposes in the future. But that doesn't seem particularly 
likely. The framework already knows the BW explicitly voted by clients. 
So querying is only useful to find out how much BW is configured in HW, 
but isn't explicitly voted for. Outside of the initial sync-state 
context I don't see that being necessary.

> 
>> There's nothing stopping us from implementing get_bw() as if it were
>> get_initial_bw(), but that only works until the framework decides to use
>> get_bw() for more things than just the initial vote. I suppose we could
>> also just have a "get_initial_bw" callback, but it only needs to be
>> called once, so doesn't necessarily need a callback as opposed to
>> additional init_avg/init_peak members in the icc_node struct.
> 
> The benefit of "ops" vs "fill up these variables" is that you can
> differentiate between "I don't care, framework can decide" vs "I need
> it to be 0". Put another way, there's no way to say "I don't care" if
> you use variables. And by default drivers that don't really care (as
> in, okay if it's set to INT_MAX) shouldn't have to do extra code/work.
> 
> Long story short, there's nothing wrong with get_bw(). If your
> specific driver needs to optimize the calls to your RPMH hardware,
> that should be hidden inside your driver.

Yeah, I get all that. I was mainly pointing out that sometimes there's a 
distinction between the available BW (get_bw) and the desired initial BW 
vote (get_initial_bw). I'm fine if we go with get_bw(), but our 
implementation may look a bit odd.

> 
> -Saravana
> 
